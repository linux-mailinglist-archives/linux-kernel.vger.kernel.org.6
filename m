Return-Path: <linux-kernel+bounces-317014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A37A96D847
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A8D28BC03
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BBE19DF53;
	Thu,  5 Sep 2024 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA4RUV/q"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD7A19D077
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538837; cv=none; b=qc/YEgtjS5t4N94RF1ctBrlMRsZnqcb0srPADczI3k6IGBgYjo+gAG3eToko5L0bOxQKZS4Z8OhGYdEMV+W7Fo6gB6+zwxsM8kXfnliQpqNDLpy/P1yIsiWX6hl10LnezNTrZWkutXH8C3ysP3BbGMaFuEDouPW67eGXd3qIesg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538837; c=relaxed/simple;
	bh=3am2KZLP0mLKceOiY+SlmvNvkFupOoG5olIwp30Eoyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+FE426pdPxu9t32cmH0zGVWXlvxOTW/rlSi29mT/4WemAGVLwftAOpdjh90K36VVf5Qzg8NY85YXDLv7GSoko+Cwkhpz8mEVlP3UfIZi6xFRRr4UnRPEFs6J6L5pSWsNaTQsigu+XZ8C8+9xoMn6MB8A4iiLZG2k0FtGWdK0cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BA4RUV/q; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42bbd16fca8so6401875e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538834; x=1726143634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YI/CvSQVhMFLsmI2MjG7L1HRsn3b7z7cN3E/2Aq7FgQ=;
        b=BA4RUV/qsdGiAXDQE3zQUn/Id1ZDvNt967+43gt81MPJdR7eTAgn+FyCMQTQdgg4gi
         wXfvTIqZpC/idXJgGEKSUS2DoZ4+4MKig6OEguYOUUeHAEv5hcRw5qMIXQPQudrr2+tI
         qoazYNGbxyEL8y8TxS5/V3hOhmXj9bsrtsamHl3Lqt5OaP62n57BLq0YTSIhaLgk+cMS
         O7bctC7pItX5dRNRVuzD0FQ3LTfBFMnMaFdX5qC+qcK9YLuyNWI7MyWm1R/fQL3LklXf
         43q6dV7q4ygBbr/7twb2oIbZwDkbxtpA+5fL1UPQO0uT/PZziCeZfY49w9AMtpzlEPcf
         kZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538834; x=1726143634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YI/CvSQVhMFLsmI2MjG7L1HRsn3b7z7cN3E/2Aq7FgQ=;
        b=CdNIGUia4gmt2MmEW7SzawJ3u/gDt2zgFT7cceSAAT0wwsAvTylfsdsV/ZgFlWH4yl
         Ov76iNTcK2S+tMnWx9lD96/ed90WVsbt3JWMx+OHKVeosRtSZfeUPMei8oRrhWyCgFUc
         TJMPm2xV/KH4x1dwWSd34tyDckOJ0sJvnARn8UFez/DLeaLWCLffKHVsM0DflOHjD3Hb
         /cb1gSef6fxIv10t0t+6EOvxKrTLwYNnsvRMkEtD1r1sU6jH9W88JI1O9QO085qXkJ6R
         u7Dzecs6aNwWD4ekBtCWIvIqG7xZsX54FAeBRc8hnwIs9q16p7dsukghlztAOF4EM1Ji
         iRkw==
X-Gm-Message-State: AOJu0Yx4hB6UvoQoz/0uZznj2K1WPBHuPp0YfNQnxrv1oF0oEEN7AnLf
	bkoWWne3AONEqGQDJIR5zoAySNaxPXR9DKpmcKaVDDOkWoZMlbHQ9dO7N2IwC8Q=
X-Google-Smtp-Source: AGHT+IHh9ahZOuVdkouGSy73mPo3qHvw1aRKnqu1PkxdzVU3ua9tH0FWnn1oAS5usbAj1f9UQwhWwQ==
X-Received: by 2002:a05:600c:474f:b0:428:d83:eb6b with SMTP id 5b1f17b1804b1-42c880efd7emr87077045e9.15.1725538833584;
        Thu, 05 Sep 2024 05:20:33 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27364sm230390515e9.34.2024.09.05.05.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:32 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 06/18] fscrypt: Include <linux/prandom.h> instead of <linux/random.h>
Date: Thu,  5 Sep 2024 14:17:14 +0200
Message-ID: <20240905122020.872466-7-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905122020.872466-1-ubizjak@gmail.com>
References: <20240905122020.872466-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage of pseudo-random functions requires inclusion of
<linux/prandom.h> header instead of <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc. linux-fscrypt@vger.kernel.org
---
 fs/crypto/keyring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 6681a71625f0..e2c10b3b960b 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -21,7 +21,7 @@
 #include <asm/unaligned.h>
 #include <crypto/skcipher.h>
 #include <linux/key-type.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/seq_file.h>
 
 #include "fscrypt_private.h"
-- 
2.46.0


