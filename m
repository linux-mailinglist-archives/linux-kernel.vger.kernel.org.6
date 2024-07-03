Return-Path: <linux-kernel+bounces-239766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED69926518
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF341F21933
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E20A18734B;
	Wed,  3 Jul 2024 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXLkWATp"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D411850B9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021089; cv=none; b=HgITtuVUkWGoqrl6KkL6a9N0ziruMMk18HzBq2HUIutszXfU4AJW6gitMOqiKTW+udVGQuGSqNECBofBNlIpoaoxgxYK0x6u9ann6OG8lEL53o2KOKcxmX1+le6I0+Ckd82iJd3M5bJT8JmULIvTym9Z+AoMWxeD/RM9x4wCHM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021089; c=relaxed/simple;
	bh=LKI2QEHHewZIBoO1kuOf0vVdX3Kg06AQSdrYQ8twpkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HAnfXf6JUoozPR0S9AtQOZKvhF5vbU1FWI/iH8qxiWJ9LU5tHsWX1YKamWYijrosr2Fv73TNzx5ew2d5UJDvQol/DKEjEVKMs/sKW2b+almnFFTq+ZdVamUPZb0/Mtp9n3NeOs9V3zkFhOT1zY/NHfb/WnIZnnHYNkoUOMIOXHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXLkWATp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58d24201934so1078940a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720021085; x=1720625885; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWEywv5t5/SdpV2ZwtxWx9CvH6fdNiDrX1/VhDJvqUg=;
        b=hXLkWATpQCDhBMEGgCJUueQ7uD9crwP3yyDtGKmnCuu1IMS3r6QzInZ0kwtOsXgGdQ
         9ueu5w7K9dSdOt9Q3ILr+FnSA/V4QMyzjrA5bjqrn/fJ8wonqUu4ddKcixmXDP2T0DJJ
         1YHmMs7Bvna+ccVOli9aUP9D1eTFmAIwC9VSBo+RPdJrsj1ZoFCDjiuL8a2d/EzjyX9e
         lA2MoaRtrb6F7GIUTJ+shCmWRZQMW6LZGEHGg9IWFpRNzJsDogLaNdOlNuk8+ioDu+GH
         eFayaxUGtAxuwP58InHQm7cGE4GUrwYhfuyxVmObgNbNKgSE849m4zLaW3gEujwXdTe5
         E+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720021085; x=1720625885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWEywv5t5/SdpV2ZwtxWx9CvH6fdNiDrX1/VhDJvqUg=;
        b=RgVdhF4u7sJZsyEsHQUmtOcWeviGb5VoiaazqH6y3IJINFcXKEILnVVGkbYrXHYM2T
         gsAa5NsbkkeLX+iWRifOM5Wn0ONEFYIorQSWuSFrAnT6+gQnPNayhlcymJMtlkUxFgmC
         0dvQ35LM7SDlFlxB1qILSGSPdwj4FFl2Lbqgg/fBv9pJslW4YorAVu8v/MSDE/3Kpcn+
         8gbJtF6oqUrGulTGydf0keFU3T7Qav82+Mb1BgqbkAoVk3baZnbkFOmVIAcmFk3z+BpW
         LHEChBMH3/SpJPB6wunKH75R6k4XMxeIXbYMRhsHDSTGMVSyXN7YwIfPUZuDeMh1ONpB
         xnNA==
X-Gm-Message-State: AOJu0YycvZvDy8Kxpgb/Bu6V/qFHUWu8ay4JO3Brk6Yc494LLKuUDoM3
	A9L5j3Wi0yfSwiDZW+LCULOgIT+V2mDAj7OMEUI9rAQUprmi87BXt5lxcCt+
X-Google-Smtp-Source: AGHT+IEH55huE/k5TpbK06pig6EzTTffXJgUxint6WaluoXZ+m5yup3JJBqxfU8O7ZA5KvA4IiQ9LA==
X-Received: by 2002:a50:fb86:0:b0:57d:455:d395 with SMTP id 4fb4d7f45d1cf-58ce4ab0355mr1374332a12.7.1720021085159;
        Wed, 03 Jul 2024 08:38:05 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861503b4c5sm7119512a12.93.2024.07.03.08.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:38:04 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 17:37:40 +0200
Subject: [PATCH 7/7] mfd: intel-m10-bmc: Constify struct regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-mfd-const-regmap_config-v1-7-aa6cd00a03bd@gmail.com>
References: <20240703-mfd-const-regmap_config-v1-0-aa6cd00a03bd@gmail.com>
In-Reply-To: <20240703-mfd-const-regmap_config-v1-0-aa6cd00a03bd@gmail.com>
To: Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, Xu Yilun <yilun.xu@intel.com>, 
 Tom Rix <trix@redhat.com>
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720021075; l=1447;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=LKI2QEHHewZIBoO1kuOf0vVdX3Kg06AQSdrYQ8twpkg=;
 b=lJ3zTuutc0Z4p2RoH31euQHDqzOporSJvVUPFyuQFoRAv5URPTdnbH5qJjw7DBBL1OERTfddD
 Z8ZzClYrR9VABhzaaNK4ubSv5VPNoYHXpRqy6vD28THHvVq3DxqZG1P
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`m10bmc_pmci_regmap_config` and `intel_m10bmc_regmap_config` are not
modified and can be declared as const to move their data to a
read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/mfd/intel-m10-bmc-pmci.c | 2 +-
 drivers/mfd/intel-m10-bmc-spi.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
index 698c5933938b..4fa9d380c62b 100644
--- a/drivers/mfd/intel-m10-bmc-pmci.c
+++ b/drivers/mfd/intel-m10-bmc-pmci.c
@@ -336,7 +336,7 @@ static const struct regmap_access_table m10bmc_pmci_access_table = {
 	.n_yes_ranges	= ARRAY_SIZE(m10bmc_pmci_regmap_range),
 };
 
-static struct regmap_config m10bmc_pmci_regmap_config = {
+static const struct regmap_config m10bmc_pmci_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
index d64d28199df6..36f631ef7a67 100644
--- a/drivers/mfd/intel-m10-bmc-spi.c
+++ b/drivers/mfd/intel-m10-bmc-spi.c
@@ -24,7 +24,7 @@ static const struct regmap_access_table m10bmc_access_table = {
 	.n_yes_ranges	= ARRAY_SIZE(m10bmc_regmap_range),
 };
 
-static struct regmap_config intel_m10bmc_regmap_config = {
+static const struct regmap_config intel_m10bmc_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,

-- 
2.40.1


