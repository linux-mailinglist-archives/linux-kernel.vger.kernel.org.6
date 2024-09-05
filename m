Return-Path: <linux-kernel+bounces-317023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDCD96D85B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E24E28921A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EDD1A070F;
	Thu,  5 Sep 2024 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m63ELd7O"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8481A00C9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538844; cv=none; b=bXvNVX8mUcVWlaKDhEO3dxACVUdeNoB2KDsKA58aYJZbSPhhw/JAa1uO1qMgC3ZR+nE7ZO3WVguz3obmhyRKo9uOx5yqYW7zBvXmdzFCPd3332BQFds9NJFX6MdrcgT52H+iX5bb89Gm2cGmUS2ekOzr76aqVG3rR85BAMj5eAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538844; c=relaxed/simple;
	bh=eTokxFo2Gbcm/AntL3u7SiekRO9OltPCJDNUu03xoPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYaO2hX7h6hmzseMyHvEki7ydsM29nE7qOnXZmdhaMPjUpEG37KJKhJwQB6IMJ8JX7cg5fRzAvbSdzy+iV5m4G5cfCQbFrd/VxZki4U1/Y4Ra66RXa/Tq7Ag4B5wmmDYZ32xV9jdQWDdGWUP661HwE49fn9X0+PQg+mcpBWFuwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m63ELd7O; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42c2e50ec6aso4123845e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538841; x=1726143641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEuMISrGIDHQtpF4zwh1s1lz53SR9gVfxvteXYJ3M9w=;
        b=m63ELd7OjMvO/dT0hN0mXwso4jz2Em2lcoIW3C1xW/bu4WDHWumYfXDnd4lE1NnUuh
         Hn58UKXjrQVcetMYSQXVhqeyfpcBTgfN7KuhuQowpmoxCipsraHwi77VGsWNHPb8YKD5
         +gOg2fIuIXF8LZDRmn3c1kYnJUcxDB9xANMlW9LGFEdLGyBpSGQmZMl1cMz4X+KYhiyD
         FTQTDQW0g/49Z8Tc/GNQRWvT3XYVynDRusMJO8k3S1/JP6WX92YKYEJ2C4TuvJvceUr4
         9rbpTqs50xMcxtLOF71uStxcNAaOO7lofljc/OB1QuPgrNV4Dosba7i3zrPMfsX07wAo
         bp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538841; x=1726143641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEuMISrGIDHQtpF4zwh1s1lz53SR9gVfxvteXYJ3M9w=;
        b=XsgAUA1MU9lKbm9h5h3PxNmxf7j4xd3GuIeMCqJ9gPcWEyhzXIfz5uLEgTbx+KmJbu
         qdVlvdLXQ/Cv3YUEtD2wrKCUCsgfsPueCuJj3uACcXDf8P0oY8+CqVmANjsfZE8PmcTd
         lK2lfvp+LM0Kwwh51qAyGFFGkEYvpbHfe0eVYecHt2eFLVQr8WL8P8AkgSBr5fuJH6ok
         VDlTxuDaRQt3OdpJAIdTeHqf4gf5IRHEmXUXqU7+PATwHRA2tes+G/3LYOcvuATbW988
         WBXE7TvxM4LhI0GkN/POfEQs66M7CJGnxmUNkYTJufZU806GdK0FRK2rQkLIvF0+piWT
         f1Og==
X-Gm-Message-State: AOJu0YxXmrwkMVy28pKPAD2o0wXUnqdc3S2Ajm2CZftxGL4dkAEO2z5y
	XgIzgFaac0+bty9/kZoISfoeRSewC8Qm4ZnrpVvaotofhs8HQMkLHch8YdHK3p4=
X-Google-Smtp-Source: AGHT+IFZ/LBdBIQEpyR/Bd8wkokRbvCAVMPzrg2l9G1nDYfM+JTSentxmzCBJCBHseV1xZ8C1OgGdg==
X-Received: by 2002:a05:600c:4593:b0:424:8be4:f2c with SMTP id 5b1f17b1804b1-42c95adc1b6mr33370565e9.2.1725538840920;
        Thu, 05 Sep 2024 05:20:40 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27364sm230390515e9.34.2024.09.05.05.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:39 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 12/18] lib/rbtree-test: Include <linux/prandom.h> instead of <linux/random.h>
Date: Thu,  5 Sep 2024 14:17:20 +0200
Message-ID: <20240905122020.872466-13-ubizjak@gmail.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/rbtree_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
index 41ae3c7570d3..8655a76d29a1 100644
--- a/lib/rbtree_test.c
+++ b/lib/rbtree_test.c
@@ -2,7 +2,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/rbtree_augmented.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/slab.h>
 #include <asm/timex.h>
 
-- 
2.46.0


