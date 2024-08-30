Return-Path: <linux-kernel+bounces-308689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A59F966063
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CECA1C21070
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E6B192D98;
	Fri, 30 Aug 2024 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EogIyUTl"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C532718E37B;
	Fri, 30 Aug 2024 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016474; cv=none; b=oJbt6RwSu/JjTTTYkcEH6/qhDPBuTa/CP0+Zn47ofRafoRLbDVHpzDD/jLPxFlfSGVe32EtQtEiehW8Wgk9MzzS7Karj5AEmrSBX1HRCL3OWvGlV+JZvw637VAUVdk0X0EOpXNrZQvctvsyLJvDtp5V1FYY6blwJEAkbNtI5jhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016474; c=relaxed/simple;
	bh=BV5EmluQ5ZCnEA/Kv+AdrPB2dYnJ/h91c+wbfdqQca8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ILPSiVHc4HicLphoYvub00jMsKaFQNR2YoVn8N+t5H8J60CHspbb6X9DL+mU12Ww1TnUUpXCuuisxusKj9RgzUbffWMn64Vh2LvKazKdK1ohXniO8U9UL6lV03WqabnoF1Et8MRsHqq4UGVdtvGnfscNd058AWg6H27LwYW8Fu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EogIyUTl; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-533488ffaf7so2326342e87.0;
        Fri, 30 Aug 2024 04:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725016468; x=1725621268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bjzdXiwsa0/WMthyTpumKvsBAFiWrJE+R9DPjDT/rck=;
        b=EogIyUTl6lxD1NIovv5jC+0XryrbepeqNRtvxSfpKkHfcShE2h86J9gUWvjN2Ay+Xc
         D9OZ+cr5uq8ZBk+ZxOWIcKnaWq5cmSPOBmpi/md3X3hO2lPP2YW4V6Pef8w9va42GSH2
         voJ6B+vZPnKtjXCfsWdQDRXvqB3slaXj9pbW3kVKBTjIElLPgIZQPuQYx9Ql3rpxWv+v
         dMAwNDm2SSUkA7jxi/qJuvmyWZZhnj0lmE/PB1T2/e0hBoVMWrBqay9Orl6VCkibdlQQ
         cyAv8dUgsDKeV+vwucRLVSUjBzJiL1oCIA/jLwq4wR3qS/uL041f6Fu5HYty/rt6ylQY
         ZGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725016468; x=1725621268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjzdXiwsa0/WMthyTpumKvsBAFiWrJE+R9DPjDT/rck=;
        b=Yj8ThedGAWLv3Cnoo4AZ0SFvXBICUtpBiBYaiJAuh7z9ZcVCR74HR0cOxFc9T6/SX+
         Ehp27J2ZrD8JDhB+hBteyaH7eRT7i3Gs/yvAgmG6fo4d3BN51IsAOvB++Lb+j24F/yV1
         iSDmPoMGk0tQ93LGwMHTLjbEqpgRVTE+oZxBPeaH2pJK2zDkZBlESNYdrB62LuIRlPZt
         id7SqUsx8elOgQrLmMT7IP1/MixBIkwxnK4Gl6pGfTWDupfUXjewbEMHaMclRNfCZ2h6
         TMOPe/cWg52mLxqCeP0GcOHORU+4HYh9EfPJXXQbjiZ0hZO04dIBBqr+rhOckujpEGzr
         Vfag==
X-Forwarded-Encrypted: i=1; AJvYcCXjKsPXUaYXT92KBEc0pk6cuIfoD8/DlcTlzkFGm2matRLmEXkxLx/P+H4z/xZIR3NGfaucNuUfUBE7IpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0tZbuLELFoIEgmp1JIK0U/cbE8B0N4kDcelSFGWtVMOq0tOXV
	lfNFxUbV+K+uRBrr25MgnCr72vdwO0VtfIgoLRsfLXoBa76FTEmxSTXDfg==
X-Google-Smtp-Source: AGHT+IFLb59bfWqTaF7WYJGy2WFa/ITykDR8q6Iz8Nvghkj3ASnpZRURh3cs9iG+5fv7bGAqT1dwHA==
X-Received: by 2002:a05:6512:1282:b0:52e:91ff:4709 with SMTP id 2adb3069b0e04-53546b2574fmr1248127e87.21.1725016467403;
        Fri, 30 Aug 2024 04:14:27 -0700 (PDT)
Received: from WBEC678.wbe.local (xt27dd.stansat.pl. [83.243.39.221])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079b8f9sm554556e87.46.2024.08.30.04.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 04:14:26 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: linux-hwmon@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: ltc2991: fix register bits defines
Date: Fri, 30 Aug 2024 13:13:50 +0200
Message-Id: <20240830111349.30531-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the LTC2991, V5 and V6 channels use the low nibble of the
"V5, V6, V7, and V8 Control Register" for configuration, but currently,
the high nibble is defined.

This patch changes the defines to use the low nibble.

Fixes: 2b9ea4262ae9 ("hwmon: Add driver for ltc2991")
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/hwmon/ltc2991.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/ltc2991.c b/drivers/hwmon/ltc2991.c
index 573cd8f5721b..7ca139e4b6af 100644
--- a/drivers/hwmon/ltc2991.c
+++ b/drivers/hwmon/ltc2991.c
@@ -42,9 +42,9 @@
 #define LTC2991_V7_V8_FILT_EN		BIT(7)
 #define LTC2991_V7_V8_TEMP_EN		BIT(5)
 #define LTC2991_V7_V8_DIFF_EN		BIT(4)
-#define LTC2991_V5_V6_FILT_EN		BIT(7)
-#define LTC2991_V5_V6_TEMP_EN		BIT(5)
-#define LTC2991_V5_V6_DIFF_EN		BIT(4)
+#define LTC2991_V5_V6_FILT_EN		BIT(3)
+#define LTC2991_V5_V6_TEMP_EN		BIT(1)
+#define LTC2991_V5_V6_DIFF_EN		BIT(0)
 
 #define LTC2991_REPEAT_ACQ_EN		BIT(4)
 #define LTC2991_T_INT_FILT_EN		BIT(3)
-- 
2.25.1


