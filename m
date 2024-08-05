Return-Path: <linux-kernel+bounces-274275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C672C9475F8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63761B215F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C361494DA;
	Mon,  5 Aug 2024 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnfgFY0u"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BBD37171;
	Mon,  5 Aug 2024 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842647; cv=none; b=XmTBy+cQkBFXFkQH2GknCaN1Ij31luxrpNZdYwAwc4YP77cDLNp/61YwIiGMM/UFUDplHufpdNX32kgVC4aUGeKNMnWPa5UpPAPGhh1gZ7mvyb7OPM8U1jB8tOg7/qU5/FT0d6V3NAr43ggC0Z5d74JkPjN9tfiPf/8jCbTM6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842647; c=relaxed/simple;
	bh=LcuVZZsY0RfLuEW4dwfUeRMbp+61GKGzXqHvjBrakKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n97ZKYpDjilL5QqmQQoPT3qYdHPImNNU+cLt15OqWpYGKDD/r05KxoCcQj4nSEdtkmiAiHTTgPxJinpkHDnLYZC85smFa7aDUmjzHtf3rMaiCFTt9bR/wNUuGRMlcqbmRuZ5/2Er9Wz5+6+z6VsPR9Fi+Uz+HYEiJ7IcQHDGGmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnfgFY0u; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a20c529c77so364754085a.1;
        Mon, 05 Aug 2024 00:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722842645; x=1723447445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bJCDkUm9uGos/S2yAhP9gTs32qLhxq1fJbQ2ttf0O/g=;
        b=PnfgFY0uk1hC9VjSUCOT1uEoIc/GTSggcCmrYHhiieFh21n3MjCv/Shl7rXib0RQfX
         8QT8/W10dyn17wZKHhKM68+78SRn/wLBAv7xSkHhRHjGCIeXbU8+5w73kF8sJ7yTX7pR
         TLvmeibfX5VxLppTpABZ76WugpKKzHG7SvE5w83nOeQ/4kd48weXsLdeiOA7oz2dsQQX
         VIi2pMqQUCTbsmJ79Cp+hSh/YiDRiB0knl7ieugxVDVIRN6i4OrcqbuuwpPcAdbPp3V3
         weAjdObuliI8sx7WvVbU9YHYGt30fPJjEZjyT+nu6kGCZHhwOGRn3rZvKz1Gj42plO3c
         4Q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722842645; x=1723447445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJCDkUm9uGos/S2yAhP9gTs32qLhxq1fJbQ2ttf0O/g=;
        b=LPsmKRCx3ijlYoD2zlagoh3QU9427Fn/iSCAqL8K0hzWYY6P05EJKlzaCbcOY763OR
         aKtbD+hBj45TgnQZDTWBZY6v1+lHBQLrygX3Sn5wGBo9zZnNgheCnGIoaKwBTk3reUHf
         BJQbp732II/UZrfG/C1I5jUu28CrcUiy6ymd5FSg1ewVYthNLaaFEbmx6KONEI+NsRej
         k4wC+kPBguA2dn7taVn6pXQY8JjKzto1CmoRFPHe8fAmXsLuDFs0LHipvVakpjU6H1Zc
         nLC6GSQWz2Ifg45PVtwurivoMpPBIXF99aPJAwNSFy5cdVgtkQ59OypMEQmcS0uyWCTb
         gkTg==
X-Forwarded-Encrypted: i=1; AJvYcCUfoQ/Xv+LumfE+i+eMpIAjUVXM4JAO26K6dhmxi10oh8cypOfzKKcq+6nd2DuJAMJ9X2FUikUj+fpGuD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz51medqCBr6SgTPHufALSaG1EGmr2uraYU/ZjVHHC2cRZ1gIvz
	2Eo7zsNN8NvNaNEBXCKrv+8K9Q77RuYAF0/gbxjUEA/TLvRKqwlN
X-Google-Smtp-Source: AGHT+IEsAe/Dk0azZ0HdPYMZsstncNy0glXwPpIIEDsYaCfC3xV4RjLoInunuPv0NkEthK733b2UEg==
X-Received: by 2002:a05:6214:390c:b0:6b7:9a8a:2feb with SMTP id 6a1803df08f44-6bb983b8ffdmr116719916d6.26.1722842645249;
        Mon, 05 Aug 2024 00:24:05 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b8665sm32510206d6.73.2024.08.05.00.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 00:24:04 -0700 (PDT)
Date: Mon, 5 Aug 2024 09:24:00 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] arm64: dts: sprd: rename SDHCI nodes to mmc
Message-ID: <861648dea0d36017327e1742ef4ef42f54b971b8.1722842067.git.stano.jakubek@gmail.com>
References: <cover.1722842066.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722842066.git.stano.jakubek@gmail.com>

DT bindings expect SDHCI/MMC nodes to be called 'mmc', rename them.

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
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


