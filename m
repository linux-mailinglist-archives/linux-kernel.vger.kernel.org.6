Return-Path: <linux-kernel+bounces-189008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BF68CE9E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C20FB23187
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA7012F59A;
	Fri, 24 May 2024 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="HCrdbbkA"
Received: from mail-wr1-f99.google.com (mail-wr1-f99.google.com [209.85.221.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC964E1C3
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575286; cv=none; b=sr0jnHd6tNnovSl/smtJ5Nv1dR4vbEyJzkpO2HThl5ne6H0Ra1K5nRuvKgFf7EPODsVXeHo2C2mYd2kALsgziOzPR4Tiuz/TYOd5RBsxe7DTFv6QRVTeYFwPDL6C/0UJ7lVsNdmsJzNXu+mE4xmQC7lKaJtnp5YRdqeCeFA8MPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575286; c=relaxed/simple;
	bh=F8/KqPuTA3STsdOrh0OGo7BppxoWY1fWB0fqUmwksXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZOHZnanDnHQu2nCFk78GQiDu1CvGd8TPXLf6cX85BHNxudqTWcOcnPYgS+eC7plZ/7mvFo/RV6XdO47Rp494xd8op0HbWIp6TNA5wClUvqWTIXPLL8HHMyUY0XSB2uj+Ww7xEewpWHnTEXSmgflMoiXgQlyIleomn1yytxfsxEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=HCrdbbkA; arc=none smtp.client-ip=209.85.221.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f99.google.com with SMTP id ffacd0b85a97d-354f8a0cd08so2500067f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 11:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575278; x=1717180078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/tSxq6GA4AT2Mm+nWQe3L0M6c7/C4J7O/BV4BAy6ic=;
        b=HCrdbbkAjz1tSpFIwBraoBEQcqzzGcabQBgTv52KLoBobA2t/QS6RtuOifaiwI5G0J
         5O0jn6BKDJmwgu+XfACyb31fSyKoNSNttHo9e+UkptKYOKE+iQlsELMZLZxGIWyP44o7
         ybQu5ZYseUCLyGyGqnBZ8tFfUnoCpu7Ge1JXYbYiNCjHforIsRtz0sH4YvtpDI1bd/+E
         bk/PsZrvZ+YbBo4AhXwA7I7mYGfG55MxEhLau8u9cbPW3EWCDcIHk+FJDCFvqImozoCt
         bDD2Ep8dFJgT8wz1tv5J69punW6kzhkxd3zu7dYxF65boaHmmecBdTnJdUA8iKxuP19R
         tqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575278; x=1717180078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/tSxq6GA4AT2Mm+nWQe3L0M6c7/C4J7O/BV4BAy6ic=;
        b=sV3WFT/LFNGu/YdR7k7Py25CkLX4C+Xe9RLB1kwKv2Nz/qePu7jn/D9bBauT8lnirs
         7eWBTKDYSKoIW0Feuo2L4vOS/2L5x+TNACDoePVIMkpSiakzUg7/tZG5axv0pJsO217R
         +DOv0KTuVqY8Nb0hSiMHBMwUyANDCo9ZeMTgUK/HXDvPONmZ8JX5HXYeJWznSIUEsaIG
         az8IrGDpEtplh7LLEoKzigzx4ARoHiyRTSwujfp8D5zoLaR1KW6yzjsdSAI7+kuS+eJE
         3dJEuFoj9II61hHplLukGCcofLHUdkt7VoWF/KGbQ9sbkaZI9Z/tZ+Ox7+2f3rP9w4aZ
         ZVcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBvLth1WrBDhz2NH/ZmLEnO0yZaQaTyq1Eco/v7gUOm8thGfjGGyIx0l8zpXMJluqmqkJFvm+ykiYP6s5PY/HYSUO0o350jm50JSrV
X-Gm-Message-State: AOJu0YyhssedbJiXn0pEAofQqHnLL0ZtcG7awYdwHSl++jRpA6opcMZ6
	QvOhyM6TyWkVGf+ap89kSSzPj2Tjnuyk0qVmVcBSFpz6ESqEFhm+S8bqwaGgQznmkjssFV3JKkB
	Xwtkd8Fcs98Ue4BMn2O316F3nyru46rOU
X-Google-Smtp-Source: AGHT+IGz+W6dkdCIXw0ZDp1B/MgrtzNbyRrO8ywWOE/qPAQsbvGxItyKlknvWBy72WuD1SEAMZ/Y6JavBjaB
X-Received: by 2002:a05:6000:4597:b0:354:e775:19fd with SMTP id ffacd0b85a97d-355221819d2mr1987214f8f.26.1716575278649;
        Fri, 24 May 2024 11:27:58 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-3557a1c67f0sm61533f8f.70.2024.05.24.11.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:58 -0700 (PDT)
X-Relaying-Domain: raspberrypi.com
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mmc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-sound@vger.kernel.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH 13/18] arm: dt: Add dma-ranges to the bcm283x platforms
Date: Fri, 24 May 2024 19:26:57 +0100
Message-Id: <20240524182702.1317935-14-dave.stevenson@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
References: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to use the dma_map_resource for mappings, add the
dma-ranges to the relevant DT files.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 arch/arm/boot/dts/broadcom/bcm2711.dtsi | 12 ++++++++++--
 arch/arm/boot/dts/broadcom/bcm2835.dtsi |  3 ++-
 arch/arm/boot/dts/broadcom/bcm2836.dtsi |  3 ++-
 arch/arm/boot/dts/broadcom/bcm2837.dtsi |  3 ++-
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm2711.dtsi b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
index d64bf098b697..d6f32d32b456 100644
--- a/arch/arm/boot/dts/broadcom/bcm2711.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
@@ -42,7 +42,8 @@ soc {
 			 <0x7c000000  0x0 0xfc000000  0x02000000>,
 			 <0x40000000  0x0 0xff800000  0x00800000>;
 		/* Emulate a contiguous 30-bit address range for DMA */
-		dma-ranges = <0xc0000000  0x0 0x00000000  0x40000000>;
+		dma-ranges = <0xc0000000  0x0 0x00000000  0x40000000>,
+			     <0x7c000000  0x0 0xfc000000  0x03800000>;
 
 		/*
 		 * This node is the provider for the enable-method for
@@ -550,7 +551,14 @@ scb {
 		#size-cells = <1>;
 
 		ranges = <0x0 0x7c000000  0x0 0xfc000000  0x03800000>,
-			 <0x6 0x00000000  0x6 0x00000000  0x40000000>;
+			 <0x0 0x40000000  0x0 0xff800000  0x00800000>,
+			 <0x6 0x00000000  0x6 0x00000000  0x40000000>,
+			 <0x0 0x00000000  0x0 0x00000000  0xfc000000>;
+		dma-ranges = <0x4 0x7c000000  0x0 0xfc000000  0x03800000>,
+			     <0x0 0x00000000  0x0 0x00000000  0x80000000>,
+			     <0x0 0x80000000  0x0 0x80000000  0x80000000>,
+			     <0x1 0x00000000  0x1 0x00000000  0x80000000>,
+			     <0x1 0x80000000  0x1 0x80000000  0x80000000>;
 
 		pcie0: pcie@7d500000 {
 			compatible = "brcm,bcm2711-pcie";
diff --git a/arch/arm/boot/dts/broadcom/bcm2835.dtsi b/arch/arm/boot/dts/broadcom/bcm2835.dtsi
index 15cb331febbb..480e12fd8a17 100644
--- a/arch/arm/boot/dts/broadcom/bcm2835.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2835.dtsi
@@ -35,7 +35,8 @@ cpu@0 {
 
 	soc {
 		ranges = <0x7e000000 0x20000000 0x02000000>;
-		dma-ranges = <0x40000000 0x00000000 0x20000000>;
+		dma-ranges = <0x80000000 0x00000000 0x20000000>,
+			     <0x7e000000 0x20000000 0x02000000>;
 	};
 
 	arm-pmu {
diff --git a/arch/arm/boot/dts/broadcom/bcm2836.dtsi b/arch/arm/boot/dts/broadcom/bcm2836.dtsi
index 783fe624ba68..4ab7769c056a 100644
--- a/arch/arm/boot/dts/broadcom/bcm2836.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2836.dtsi
@@ -8,7 +8,8 @@ / {
 	soc {
 		ranges = <0x7e000000 0x3f000000 0x1000000>,
 			 <0x40000000 0x40000000 0x00001000>;
-		dma-ranges = <0xc0000000 0x00000000 0x3f000000>;
+		dma-ranges = <0xc0000000 0x00000000 0x3f000000>,
+			     <0x7e000000 0x3f000000 0x01000000>;
 
 		local_intc: interrupt-controller@40000000 {
 			compatible = "brcm,bcm2836-l1-intc";
diff --git a/arch/arm/boot/dts/broadcom/bcm2837.dtsi b/arch/arm/boot/dts/broadcom/bcm2837.dtsi
index 84c08b46519d..d034d6a8caad 100644
--- a/arch/arm/boot/dts/broadcom/bcm2837.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2837.dtsi
@@ -7,7 +7,8 @@ / {
 	soc {
 		ranges = <0x7e000000 0x3f000000 0x1000000>,
 			 <0x40000000 0x40000000 0x00001000>;
-		dma-ranges = <0xc0000000 0x00000000 0x3f000000>;
+		dma-ranges = <0xc0000000 0x00000000 0x3f000000>,
+			     <0x7e000000 0x3f000000 0x01000000>;
 
 		local_intc: local_intc@40000000 {
 			compatible = "brcm,bcm2836-l1-intc";
-- 
2.34.1


