Return-Path: <linux-kernel+bounces-441989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F03F9ED67D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24128188C77D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E1317736;
	Wed, 11 Dec 2024 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSh1U4+D"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7642594AA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944937; cv=none; b=qRCVxjDct3HZ1rm1Yld8dEeMUaOUnayITNkgJYDKA602C0XsaFkMGYY6oUnjlaoFqv7Q58kQGhVZGK31ZeObUyoQJ7vMJKKjzaAZ8Qw4sOfNuog/NHO5ZQ3MJjzvaQWsOTxy0riDvJM+DvKKIha76T4jLGbGGvDixr7ZbXoborA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944937; c=relaxed/simple;
	bh=0guIPxZF8cwXbarQ750vhuWao8mMlmLhUUhPOsFxuVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jCgZkMyMntxvPtVSK1Ru/cgnzsqTqPagp2L9sqxIjzYhLGGEa2m6oESBcQqG+cuE892ztgwmGAROkA2Wx97Tb1WyvAxObaCmSZtpf+kMn8djj308el8X9ZjETTsMJ3qQ69ToEnFbic/Nnf+J0YivTc0YhSjPgM2K3aXKNbGYUkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSh1U4+D; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2161eb95317so53538265ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 11:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733944935; x=1734549735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JJeFN1xbe3QjC5dAWvwZ8QPV4wpZMDCARpp+S2afYJ4=;
        b=jSh1U4+D+LqspO4kG1hPX6FLQmYwiqIV7cOuFSaPHNeby85VDbDeLLqz3Of4GZmAtB
         UYQdh4bVae+IaJ7PQQg5jleAVvxMjUAPa9ZD3nlnAvxSXNnSRHS9ssK0GtKpw9qO9XN/
         Z7/JUHy32zcVMgD0/mRguupGED3QGrcfruY3PsO6yaM8GjiHbHgDmgN4rwdTATJm8MVB
         Z5xr8wIyzB4KwNyC/Ixv3gcKQ8umke1ElsVF3zTWPkqwC/jTEFhXSBesIM+qrm2TX0fB
         rXtypIlMykfL6xD10bEOg0cOhw+oRnl1LNbm3EQovZHx02DoK9xiPRXi6q5ItKNbNIlK
         X+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733944935; x=1734549735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJeFN1xbe3QjC5dAWvwZ8QPV4wpZMDCARpp+S2afYJ4=;
        b=DUlp04RifzENaxIaj+4qZQo8eWpMaFsWEHMIJQ6X6wmLh4WT7J5Ddxa/sFmxOUNTdU
         rCXBhXIyPUjCbFvAD/kKe+aS6WRGUm2ixjD1UL1xCWY/RqcV5XGOFQ5B4RM9Rna1KWWb
         ImHpsv7G/F4EAj7MUiC/GAVrqdaWCIq6FaE4CxdC0qS09BgfXj6LgsLkvrMzzuB6/uNq
         vQRogcQZxmSr/duQkArqzBtclWxYs8y0E0HtwYfzU8qqrf2wnbzZaXraOB3U2S51eG/3
         AMSlfYCSCM9kFQ9FmDEtpbTAm+umvF2YGEJBPczLZ/63+QCo6Z0cpcT79rE7KaJJfaIN
         1F3A==
X-Forwarded-Encrypted: i=1; AJvYcCUzT8CAX2aHDRKULPBMc9tMFDhSy2XPRzku6Aj6iE31HwsbaTNzLCmpn8f0+UtXvyVPYvxdlKXfb8pUM54=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzdHn2iKX9IIVEirSqwbptRaxsw4paGJPQtxTGMMSZr8/OGnIO
	0UPWWbvudCzKO1TjpCbnGhAbKdU9VIZgTwo6Vab8Zr6X+VSGcyIc
X-Gm-Gg: ASbGnctlwEe4U1BnHkqFpnY+F3xAFGIEREORSJIbzxJYptQZX6EMLqRpRWgKmNfGfDy
	d3biTF04sMCQ5+mtCjUGemTbqMuo/QwU2LD4AehjLa4CjYl6HcSWpo9ODSOC8nQdSSEI9EtKjn7
	gYg3NpT6m6jeCoHynTS+nk2g98BxmZSQ7wjUKjTK2jUtFQkKsXJ0+Z/uS5twEEuoOeavBMfb+HI
	KbLOoeDIOHkh/5x2aCq1ZPBlUdeZgW2qcLKPQQ7S/BTx8KY1TKxi+GaOuMxK1aJpBw4mw==
X-Google-Smtp-Source: AGHT+IE2qWHRpHyPBAV6Og8YQFnhhYxu4NQuDXnPZJ6JsI8ddClQFgl4aCNOIlwumuOq+B48WG/qOA==
X-Received: by 2002:a17:902:d506:b0:215:ae3d:1dd7 with SMTP id d9443c01a7336-217783b77d8mr73063535ad.19.1733944934713;
        Wed, 11 Dec 2024 11:22:14 -0800 (PST)
Received: from localhost.localdomain ([2402:e280:21c5:223:2c08:f85:3644:ef6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216500da1f8sm54936875ad.5.2024.12.11.11.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:22:14 -0800 (PST)
From: eisantosh95@gmail.com
To: 
Cc: eisantosh95@gmail.com,
	Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rohit Chavan <roheetchavan@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gpib: Wrapped macro in parentheses to ensure the correct evaluation order
Date: Thu, 12 Dec 2024 00:52:04 +0530
Message-Id: <20241211192209.22493-1-eisantosh95@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Santosh Mahto <eisantosh95@gmail.com>

ERROR found by checkpatch.pl script

Signed-off-by: Santosh Mahto <eisantosh95@gmail.com>
---
 drivers/staging/gpib/gpio/gpib_bitbang.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index a2d562cbd65b..3aec39a6d6b5 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -44,10 +44,10 @@
 			pr_info("%s:%s - " frm, NAME, __func__, ## __VA_ARGS__); } \
 	while (0)
 
-#define LINVAL gpiod_get_value(DAV),		\
-		gpiod_get_value(NRFD),		\
-		gpiod_get_value(NDAC),		\
-		gpiod_get_value(SRQ)
+#define LINVAL (gpiod_get_value(DAV),       \
+		gpiod_get_value(NRFD),              \
+		gpiod_get_value(NDAC),              \
+		gpiod_get_value(SRQ))
 #define LINFMT "DAV: %d	 NRFD:%d  NDAC: %d SRQ: %d"
 
 #include "gpibP.h"
-- 
2.25.1


