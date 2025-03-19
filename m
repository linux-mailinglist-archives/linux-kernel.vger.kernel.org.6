Return-Path: <linux-kernel+bounces-568868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED73A69B80
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB591889729
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E85B22172B;
	Wed, 19 Mar 2025 21:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gxk1Bstp"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC8421D3F8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421104; cv=none; b=dWa4bKqCm+CKhpX5Tw9ygh7P8j6HX53YcmL67DLjpF/HOJil78D4Dty+4X85vLGssolJv7IsGZR+w8kP+qI48Gw+fgtiJqraMlGOBfbBm3TxptNTf07jyW3cUHk95O7mmlEQt8jtV+LhEroi9hDm7yhGpqfnp6EbjjeER2fSzTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421104; c=relaxed/simple;
	bh=6A227ZHcLwmH34Uyd7dFlW31JXsgCCsAPJaGw3Nto3o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fo41uvg38SDVLPZTgArGyrHtEFpnNA3meePoC7xEVszeUF+/xYf4tTUzYpCb4DVUOon1YOAnxnvLuiYHHCrXJIhGZMAofJWoFvc1XoohPpU13zcy0hs+M648ZugcZ0WoQJ37Np4lfG2ODnfamGF3Gbcf9IW+EaQH0Fru50psNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gxk1Bstp; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso248018a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742421099; x=1743025899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2FlX2bXYTfLPxWNvFOZ2OVVRCbqnN5Q4yt/8rIDVkFQ=;
        b=Gxk1BstpCZk9hfyHF4pDYDjsapZboYHtwMfp8iCpvwy8kN0x1g4Ik3Sa/shB4Itx3x
         OP6bHjfQVtnC3fDmPaFIKJ/bQSC/3dMI7U29v9d+90lWIIx+apzJy1MD1zjZ9b2oZZ6N
         SrYTpa/Fe0bjxbFo/nBsRZSKoHuzjq3/4Bd14e+wrse4mN7deqoWJ5Fgv6CCfEwQrG0l
         WsFu0bnTh3bgFIDqaWI3TOgZT2AkQmuVQQI8I1WN7xYICbdCSSd+hcCjAIb6QlGQsYdA
         O1o/1Eq8ccXPGtXFEe8DmyM8jDnErTXMBsIIC63CpJl9AJYO5OvDnDAQ+li4gCw+8Lqd
         RIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421099; x=1743025899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FlX2bXYTfLPxWNvFOZ2OVVRCbqnN5Q4yt/8rIDVkFQ=;
        b=ZojJBdgBaxjESWMIQCamQ4Xf1i2AsiGnUqTKY9t+pWbk8LW6UUH/Ldksp6vCybE4zh
         gRoRBjml30nD7p8VuUnhkUR2/YUxO2R4v6biGOjdgDRijPWz3b4zKbz3zQv/AGx9VWQH
         X3pkER9Jq2LMI4TooSI5UU9gm413RVtjCiCui4kMarmBlSixb0HuLjzHnrxNOnuMpMqu
         nnyj6R2StDIAGXkJ1mb8HpqcQRe1qSGWDg8r/IbkWxWyHFFY3LtVTRoTmTae3t78gFtJ
         +JtaJTIdWGT6VMILlxD1z6RHP/6YwmPD9+BjwuXfXssUU5V5vPx+Kit+ToCdljOMuwib
         HiMA==
X-Forwarded-Encrypted: i=1; AJvYcCU4tz5KPYd8pkMyCXG4M4r76gUuFm2VIEbj0x0qHUjC4UYsO0xky2yvtVmfr7OibSgMmXNPS9IxshHQQdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3KSAXEM+RWKao8P/HjFsZQoqgQHLnVbFaaUdyQ9tBr9kmdynb
	f+YmGUNM6QjiahMvBhugfcUA22nXD7ghEYBiqCCK8Virpl9QUo7ZpdWrSveAC9k=
X-Gm-Gg: ASbGncuhXg6hd1a/dtMG7RJkh+br/9bOVIc90Q+1OsXDypq4mtMSiJHStz0KeYNtUkN
	CKIynTxQSNnr6exujn74scedTHvRwHJp06Au3B+cNySmGdCvXnjcpaml23VNMBd614fSX0dcxSG
	NNPbSEbSiX/tV8FptbU8XfN5Xlsh50crhdcGzEwdnliySfg5hG9XNrUJRslfUpbNLUykfHFPvXg
	qRmqurojCNzs8ZJi53+S5e96InSE77PrjkYBx4Z2/ZYRMHR19mAM65++zaBhISeKlyOsUJR6lio
	M4vY2PlePAb9QiBP92fmoTZUaku0D81lWjeBWV5MNRtjHffikUSYBXrxnrUMF1jHthteAwgoANr
	+gqUeOV44+w==
X-Google-Smtp-Source: AGHT+IHnjg8ip47n0umRwsuHPNgFyT6zs/YGRrSkkBMrSE2e0JyIORLF+LT96OI94/1opTBkG6cz+w==
X-Received: by 2002:a05:6402:d0d:b0:5e0:8ab6:65fa with SMTP id 4fb4d7f45d1cf-5eb80d4a3eemr4555608a12.19.1742421098973;
        Wed, 19 Mar 2025 14:51:38 -0700 (PDT)
Received: from localhost (host-87-4-238-14.retail.telecomitalia.it. [87.4.238.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e8169b1623sm9678655a12.39.2025.03.19.14.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:51:38 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com
Subject: [PATCH v8 12/13] arm64: defconfig: Enable RP1 misc/clock/gpio drivers
Date: Wed, 19 Mar 2025 22:52:33 +0100
Message-ID: <378f6ef859d7c23770b1532a370f4af97cc9a922.1742418429.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1742418429.git.andrea.porta@suse.com>
References: <cover.1742418429.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Select the RP1 drivers needed to operate the PCI endpoint containing
several peripherals such as Ethernet and USB Controller. This chip is
present on RaspberryPi 5.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index cb7da4415599..cc70793e97ef 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -618,6 +618,7 @@ CONFIG_PINCTRL_QCS615=y
 CONFIG_PINCTRL_QCS8300=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QDU1000=y
+CONFIG_PINCTRL_RP1=m
 CONFIG_PINCTRL_SA8775P=y
 CONFIG_PINCTRL_SC7180=y
 CONFIG_PINCTRL_SC7280=y
@@ -700,6 +701,7 @@ CONFIG_SENSORS_RASPBERRYPI_HWMON=m
 CONFIG_SENSORS_SL28CPLD=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_SENSORS_INA3221=m
+CONFIG_MISC_RP1=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_DEVFREQ_THERMAL=y
@@ -1289,6 +1291,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_FSL_SAI=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_COMMON_CLK_RP1=m
 CONFIG_COMMON_CLK_RS9_PCIE=y
 CONFIG_COMMON_CLK_VC3=y
 CONFIG_COMMON_CLK_VC5=y
-- 
2.35.3


