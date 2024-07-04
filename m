Return-Path: <linux-kernel+bounces-241541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 543FC927C60
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A1C1F2442F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659BC3D3B3;
	Thu,  4 Jul 2024 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDPHCzU8"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321C83F9CC;
	Thu,  4 Jul 2024 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114914; cv=none; b=H8w5k48VwQoH04TB7xJzMznudNW9KKtfXs2CrAlqCi7uRY3FVeFdCBomI2H0RDSjGHAmm4VhTf0JSVNIkB6+sngbpojkBl6gVMSX497s1nNGOSTWsEY0wcf2Q5PPSl/0SS+uLsK59N8GXAH0WdNri03HFyMpT2ateHgCPUNyu+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114914; c=relaxed/simple;
	bh=yeCKIXHGW4HLd+zc9vzHQDm0oy280H3OdGtDxJ0bBXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4/0nAn11VPgJrkY6uc93+IVc8SFOmDgJ+sfWEZapnf7oaHcunsw4y1dRRCE4Br05GZyfndmZXYQBj2SDuyLyndcV32awon4szSOYfPSDZ1OmukHvMf7yoGeVc9wTxl2Y3j4yqVKvrCdWZgSyKONVlUfO5fe9ul3Ew2Tw+ElgNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDPHCzU8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-367940c57ddso558599f8f.3;
        Thu, 04 Jul 2024 10:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720114911; x=1720719711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DD+79gEm0XI4lApuwdUr/m+jS9/o8tYpP//fuDo0BF0=;
        b=JDPHCzU8AA6J8p6MkHfzX+sWHV1Uykv9AQ5E6ZVZGLLjiQOnaJUUwjq5+xs656FRsd
         Dg2Trz+Qtd+YdprLMwhgLSiAz9R+3BinPR5ZRuaKzS3LcsO3mjwiNp9n4j9rPb+Iudcm
         5o/FFbK4fYaPIV9PQazfp7m01VtVQ6tD0cHPIWDznMn6RU1aVQVoHnM06Xzfsyz6kXAB
         15CvdTkn7QE1wguMH8s6hQTEOJN7zTbHP6fsLOVmURMukphrrqK+XTmmPP0BKGx3iVrR
         8vV3zN1DrBQNzOFkAnAWQfv93RZzDdUAb2I3zDSGpRDwBuIBCoC99+60SxWHSH8dPNyh
         5XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720114911; x=1720719711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DD+79gEm0XI4lApuwdUr/m+jS9/o8tYpP//fuDo0BF0=;
        b=MTqY16b2T036KHfxQd6jUA47cNSW3U98UCDYsyxWsJhk04dfTrr4mtWyC1aDOB3wwm
         Y2RfQUIaEaEptIQ6Mx22+4SSSHMGQU+sMRIN0/C+e/ZXiUe9x+I0Yu4hUp2QJ4hYG/4v
         6Wh26o3Mnm+f+TTxUPkEYM8wic5pas4nXXJIt2iQU21yQH02CoIW50Ga0u1KsehpCFpr
         vwfv03u1diPyUM0VRdin/aI9rx1tI12COPGBYm6XTPluT3PLFjldcjpz1pEbLoEjMFyy
         TmnNPZabUPWJ4nxWCqYXGsl8JDulkw6DPpT49ugyhQR8SApiIKcFoXd466E2xVXuTyTY
         sshQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTA65E84yotMK73XbxTjDizLUys0fulPP0j/T0yhOL0KrsOQ4EYvVaRPcNfwbLAaC+qM8Mle7kosuOTXL1g8v9RBzdurG+B09SKwTk
X-Gm-Message-State: AOJu0YztUrlPs+HATOqG2bji41AuiKF6JK60ciIdGnqmnYaQfsG4L6/j
	KtsT+nSG/5S6yj7TG7cTuiEP7XMzZFqR7nfJQKSsGC3L4ofckMNO
X-Google-Smtp-Source: AGHT+IGmbxgZZZex3R3p7fd8tn7nK0WGsIU6quKOVgqMY0z4nZ9HyLjjPfBDs1wD+vOgmxfmqxrYwQ==
X-Received: by 2002:a05:6000:acf:b0:362:69f1:a08 with SMTP id ffacd0b85a97d-3679dd24f5amr2079362f8f.19.1720114911455;
        Thu, 04 Jul 2024 10:41:51 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a18c2810sm1395455f8f.18.2024.07.04.10.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:41:51 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:41:49 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: sprd: rename SDHCI nodes to mmc
Message-ID: <5262c00966eef7db054debff93cdd789dbfce34d.1720112081.git.stano.jakubek@gmail.com>
References: <cover.1720112081.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720112081.git.stano.jakubek@gmail.com>

DT bindings expect SDHCI/MMC nodes to be called 'mmc', rename them.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 arch/arm64/boot/dts/sprd/sc9863a.dtsi | 4 ++--
 arch/arm64/boot/dts/sprd/whale2.dtsi  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
index 53e5b77d70b5..a7b897966882 100644
--- a/arch/arm64/boot/dts/sprd/sc9863a.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
@@ -551,7 +551,7 @@ ap-ahb {
 			#size-cells = <2>;
 			ranges;
 
-			sdio0: sdio@20300000 {
+			sdio0: mmc@20300000 {
 				compatible = "sprd,sdhci-r11";
 				reg = <0 0x20300000 0 0x1000>;
 				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
@@ -567,7 +567,7 @@ sdio0: sdio@20300000 {
 				no-mmc;
 			};
 
-			sdio3: sdio@20600000 {
+			sdio3: mmc@20600000 {
 				compatible = "sprd,sdhci-r11";
 				reg = <0 0x20600000 0 0x1000>;
 				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index 7068bfd2f4c3..cdf52fd78ee4 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -133,7 +133,7 @@ ap_dma: dma-controller@20100000 {
 				clocks = <&apahb_gate CLK_DMA_EB>;
 			};
 
-			sdio3: sdio@50430000 {
+			sdio3: mmc@50430000 {
 				compatible = "sprd,sdhci-r11";
 				reg = <0 0x50430000 0 0x1000>;
 				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1


