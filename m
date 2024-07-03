Return-Path: <linux-kernel+bounces-239761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7506E92650E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F6F1C2211E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD18E18308B;
	Wed,  3 Jul 2024 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKUd8Afl"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F0B181BB3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021082; cv=none; b=grnW6ys+p/7w1WTljha5ulKgeMb7OJu2n2jXoYoDW//F7rWz2uRcwlZ9TWUcCN3aLYKFq0wvkp35WOlVugybrh4uniQiU0dooZMNLVfj4q1ZG/ZqdY1T35PeCMNcEV3Bf7riI3nj2Xp+iCOVRigmgJYwW54ah0Eq2jpI6yXh1mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021082; c=relaxed/simple;
	bh=U56saMjIfEuTsQ+HGnNS0wH0SrTxaY1/OZS4zOAPdKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TWjBGJDBiLd6+jNcOAHP4LLOfiyjOEb6Ww+pnrSIHncHt+NqsDwObvYHMDAXPzlFIEesaEczK75UERNBYf6b4WnZeuPRi1qhkBI+w6VDCNDX0SQ6u61Ic5wyvW418HfMJL/B/ZPMfdxwY1gokQg8yC0x2ZltA+g4uGNEhaBHKBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKUd8Afl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57cd26347d3so3917951a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720021079; x=1720625879; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKi2JAqKWrjfu71x3mrudLF5NIxjHTPRhhtNA6MHl8U=;
        b=IKUd8Aflf+vlIN+WaatNk9Eup9ERIzwSY3ono928gVFkn0zkgOMbojQ5RBFx92odjm
         1d37TFuy+28EYzKGjvCRUBMIfkUUIYFDUQ0vb0EHwxKsExbDXvj759GzfkW04Bvy1igF
         blJXnZ2S/dpsm6QkA3W2/OFOvpOFwjNR+2LtCBqqlZtjIJdECwwX3d/UOZBW2UTPAjy3
         5XsbhNGevyTZOI2zosbC91Nz5L+RpAgJ/htpcqcwqjmtcnb1haEKhk46B5lKKKS0vhIA
         cCNAt5/z9XkXTwcSglG7ue7ow+EtL+12V0Z2rERpAP+xDcWC+CtNEIQL4Iw/+cPKLpQI
         OPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720021079; x=1720625879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKi2JAqKWrjfu71x3mrudLF5NIxjHTPRhhtNA6MHl8U=;
        b=iKQ54xFiUCmNWTKbkJ7wKIKw3X7nOAzher+VtL6tWtECv43fRw30KUvg3Dm+Py3Yns
         WMG4CfvV3dT2uofJWJxDjlW5Cj7sMRz0wR2Cx1xCx3fyU9UURwlIVog4b4bHLrZ2L3i2
         YGBKaDLFZ6fOZLguaC6dgqS9W6JcjoVGoVLGo6Gg8LGm3Lz/waWJNFV2ZafKsSygu5ja
         WaPNchs1GizL10LX1qkYw3SiBvOtPjxsB5ImPIa43dpcRH5zTjxL6jneSn0fFMZl1xHQ
         B3Q7X3C+q9NMX0Mjoz//30qTdWDG9sZ4VnDvJTfofp3n5pebe0maVxows/q33VqGhpTo
         3m1A==
X-Gm-Message-State: AOJu0YzhyWPIoewpQh/AeEUh/lxeTS1OXzbSiB+mvytsrNlvly7EbK+3
	prvZYv8jAQGmADIru5jQz2T/hk/IUnmS3NqOOZFSolcL92lOxPtz1EbDPJqY
X-Google-Smtp-Source: AGHT+IHbzg2lqQpiAO/jvzPTPWoOyHg/cz6NXGW5jL/Cnfvihh++f0NocK6eSj+lGz0hwsNrRyIpaQ==
X-Received: by 2002:a05:6402:2690:b0:58c:804a:6f0a with SMTP id 4fb4d7f45d1cf-58c804a743fmr2085903a12.19.1720021078878;
        Wed, 03 Jul 2024 08:37:58 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861503b4c5sm7119512a12.93.2024.07.03.08.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:37:58 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 17:37:35 +0200
Subject: [PATCH 2/7] mfd: fsl-imx25-tsadc: Constify struct regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-mfd-const-regmap_config-v1-2-aa6cd00a03bd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720021075; l=754;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=U56saMjIfEuTsQ+HGnNS0wH0SrTxaY1/OZS4zOAPdKk=;
 b=AVQr2VorHlXjUiqjQdwraVmBCNgIgN/uudSFtafwKl/WtWGftc+dJxM5Zi5gaXQbBfZbnAEuT
 WSX95/ir/DMAiRLqHReT4craFJ3a0tXA5uvok85xFHdJtAbPvSW6m3M
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`mx25_tsadc_regmap_config` is not modified and can be declared as const
to move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/mfd/fsl-imx25-tsadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
index 74f38bf3778f..2e4ab2404154 100644
--- a/drivers/mfd/fsl-imx25-tsadc.c
+++ b/drivers/mfd/fsl-imx25-tsadc.c
@@ -16,7 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
-static struct regmap_config mx25_tsadc_regmap_config = {
+static const struct regmap_config mx25_tsadc_regmap_config = {
 	.fast_io = true,
 	.max_register = 8,
 	.reg_bits = 32,

-- 
2.40.1


