Return-Path: <linux-kernel+bounces-390711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E489B7DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B4AB22863
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2BE1BCA05;
	Thu, 31 Oct 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rUj1qxSN"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50E41BE87A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730386856; cv=none; b=PHJw/D5Q+hc/zq9TG3LXPCQ+1iONWSpRLpanQGCjy6uhW2PYmxrCsNElG8SIMZ48CoFfG+NvOQ8HvxpZanMN0NfrsbHXbFSpVvyuaHxAVI26lXkxAFWjK+f5V+qvgSjHtneLkzz4EBlKnolnLUDpMpd3KMZoQAED5hxIyKNU7zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730386856; c=relaxed/simple;
	bh=DNXiPZZOPqqCGRsSUrJuQXwDPghQpinVVwrMRAUyp2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVWArKiHDmO2IIoomKIw7hi7d5un3gfNPMKsA3sDLW1GfOI8O9Enb8ep+Q0FNSfypSpmaQDRSoaFAREKC5nlcT4oxLad02gLWwY18Xx6S9/OK11MT5u8CZY3QUmEHBc+M7jBI1BD3wr/5MEW7lFIX6IJIN5cgFMeqJ7v7DSDT24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rUj1qxSN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d4fd00574so679392f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730386852; x=1730991652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dhr5+lgkwJp/4xdbeZNcQAzRLkNmuREPhlR8Kw0nM4=;
        b=rUj1qxSNBHbEup9MP2VYlTdX3/000FECbtikzv+E+ylkPhLwzEoDCv7mSMXHqUuIQJ
         WBmKOba/6DIYKQ/ZdX6+fDKeaYblSwpen45y04VqeZrXXy2xgMzHCwu+Mj0w7REyNond
         gJi044aH98HgkrFj8kaXsBigoBjtujjzfXwm7ybFG7U495nfPhXRmvlyIeWH9JkPSVTc
         Fq9BFmbzfXahWDcELSdsLXtUJlLZUFw+hBDgTWewnc5VBJe4SAMymBuIn4mVizG3a/WP
         Bcp3LxcrH2OEYdGY8OCpCm2BOkdT7ng8qFTGBeAMizyLcGoakJx4N1hS1gTkWVi8sKuD
         fXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730386852; x=1730991652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dhr5+lgkwJp/4xdbeZNcQAzRLkNmuREPhlR8Kw0nM4=;
        b=HrtyQN084U2PTWxzZn3dgLccv7chwJq+FkJhJY3Yed97VeUu/WDEMhaKK5oDcf05ey
         ccbL2vxItXd8HbRbFCp7sCpUpwGT8C5/OisyKgp0q9LClaXF0zFLrSQRgWuEc7N6qeSj
         6Y19UU69Gz5kAQ9g0YmOlNpKayB+nSWrIIwf6O1cseALhsPj7Qhq6OZxuykjyfguNFf0
         c6Z1YvxoDkqrGLu7M8jWcyeVGJ0YagcMxDnLX+BQngJlDfUoqtOgkWRII4kW3CuIuh7F
         xlCpqFjJUBexL7bH7C9NA8YZPaaMxUUpSa8qi5Y1LXQD26IaI+GygjScqh4w3fdCn2pV
         sjJg==
X-Forwarded-Encrypted: i=1; AJvYcCVb6FOjg7Ir0bHP6qKOvFPAtIllZV3cINrehrvHNV5f+cV/M6ZzGeIb5d+f41Tpk6Q4bjkyTRg2izobyn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZT0CL+wTTdE6Lxwy3QWOhoj0EwG6wcmkvd0BIQxhgQfgWhrG9
	pYfxrgWZyXL05PFhLVIuxmRHtlP3uD9o8an+xYlEZl1AtvJexAo4tJehzn3tlaY=
X-Google-Smtp-Source: AGHT+IHKfc7pJ6Zm8piuDfmKaMIbjSaLV4oLGDh35XiuzbNsP65XFtHQ4OrcCPyxEHtqyv/uMEAbZg==
X-Received: by 2002:a05:6000:1566:b0:374:cee6:c298 with SMTP id ffacd0b85a97d-381c79e3662mr280380f8f.21.1730386851639;
        Thu, 31 Oct 2024 08:00:51 -0700 (PDT)
Received: from gpeter-l.lan ([145.224.65.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8524sm59163225e9.5.2024.10.31.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:00:51 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: alim.akhtar@samsung.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	krzk@kernel.org
Cc: tudor.ambarus@linaro.org,
	ebiggers@kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	linux-scsi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v3 11/14] scsi: ufs: exynos: set ACG to be controlled by UFS_ACG_DISABLE
Date: Thu, 31 Oct 2024 15:00:30 +0000
Message-ID: <20241031150033.3440894-12-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241031150033.3440894-1-peter.griffin@linaro.org>
References: <20241031150033.3440894-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HCI_IOP_ACG_DISABLE is an undocumented register in the TRM but the
downstream driver sets this register so we follow suit here.

The register is already 0 presumed to be set by the bootloader as
the comment downstream implies the reset state is 1. So whilst this
is a nop currently, it should protect us in case the bootloader
behaviour ever changes.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/ufs/host/ufs-exynos.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 78307440107f..5078210b2a5c 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -76,6 +76,10 @@
 #define CLK_CTRL_EN_MASK	(REFCLK_CTRL_EN |\
 				 UNIPRO_PCLK_CTRL_EN |\
 				 UNIPRO_MCLK_CTRL_EN)
+
+#define HCI_IOP_ACG_DISABLE	0x100
+#define HCI_IOP_ACG_DISABLE_EN	BIT(0)
+
 /* Device fatal error */
 #define DFES_ERR_EN		BIT(31)
 #define DFES_DEF_L2_ERRS	(UIC_DATA_LINK_LAYER_ERROR_RX_BUF_OF |\
@@ -215,10 +219,15 @@ static int exynos_ufs_shareability(struct exynos_ufs *ufs)
 static int gs101_ufs_drv_init(struct exynos_ufs *ufs)
 {
 	struct ufs_hba *hba = ufs->hba;
+	u32 reg;
 
 	/* Enable WriteBooster */
 	hba->caps |= UFSHCD_CAP_WB_EN;
 
+	/* set ACG to be controlled by UFS_ACG_DISABLE */
+	reg = hci_readl(ufs, HCI_IOP_ACG_DISABLE);
+	hci_writel(ufs, reg & (~HCI_IOP_ACG_DISABLE_EN), HCI_IOP_ACG_DISABLE);
+
 	return exynos_ufs_shareability(ufs);
 }
 
-- 
2.47.0.163.g1226f6d8fa-goog


