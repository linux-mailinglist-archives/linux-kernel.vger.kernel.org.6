Return-Path: <linux-kernel+bounces-274280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88BA947602
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58550B21551
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B19149DF1;
	Mon,  5 Aug 2024 07:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5EW9J/c"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE49149C43;
	Mon,  5 Aug 2024 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722842738; cv=none; b=ljueCWfm1ZONlz97UPHXFpAWFIfJPoehBML/STqSe1+2KMDwAriLFtn3yAlWf+v9TAIsczyUEMoK61cXTSeKNBNXnl82d46eylpUivyG4Krc9/bwOXepx5XSWwkuWxnRb2oynTc8uL2YTz6eTaHhSV5n5rZqlulxyu5P6VIykBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722842738; c=relaxed/simple;
	bh=PoXLAVeQWU88QJiCfIQ/1HplwlyHlbzMx2Az4zrHiOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpuDJDgPHqZR4bGMiUcdhikdQ0TSP6Eh0x2PeVGM4LVik0KPgC7YZcBpjs+//Mh9PKqyj7B13H0GoThZO3nOzVmcqfg8GAqYFHhZu3DSfvN0dsf9OCirFvi+nRDrVHc+5h+YSmXNxVMEsMTX2qmLPN0F5Jwa0jpxnVJaJLclg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5EW9J/c; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3683178b226so5229212f8f.1;
        Mon, 05 Aug 2024 00:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722842735; x=1723447535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEnt8HbBDdv44YYdhtwgW2fA5+KmUA+AJaLSvUEuvnQ=;
        b=h5EW9J/cCgT3kK5TbjZO2U9uOnnhAN7GDd35cUFY0FmeZXdt/jeViX9VC8Mu5mztJf
         ckiQNDcUqaIiCqpL4cmHfOu+NU18sc9uXtHuGCCz9F2s7aGfNssJEGmp7qKhyCw0ab+A
         1jSH6KHcP9DpGmrZtlfregC5KBNaw/uMcDCcKkkne/xkip4JU/k3rv16hH1pLuFqaSVt
         hANxrr4F0xMzQHeRprmQEK5e35eSbjuTym/ymS0UASROyjNJbFI2qOV1dGn6XAalnOEJ
         lv62/9mfq6xkVLbGgVS9buulQylMo78MibjQihY8cXTebDVCNn9dX5SWPmSBOxreCsU3
         UyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722842735; x=1723447535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEnt8HbBDdv44YYdhtwgW2fA5+KmUA+AJaLSvUEuvnQ=;
        b=oglbTpOfMZJIsuL7BRaKn8fiSCfeFHUg+of1CPJzxypNI7LMpF8RgZJ1qfoSS19Bsi
         Vj27YOYMDvcV7uEk64AhzpP1NXepRwFHeivNB7uaV+pmmb9rsPZ58M6Wnvt3sWQtZD2G
         Hn+hK2v+FNTCqwG1v8W8tTBzX06bCKj5meJXpkPxunuBUB18hUf8LpK9cCVdfqe0b8a8
         EMLgmtuNxBaGDf7Gks+M0rlqzorYMXfIb513ZAXNUOwpoZYer+3sYQFvYtfPeT7SUiL+
         FwbwPBvfvCZpkFVJnbKkgj+fFlKSXEsmNOX/MGyS+Ui062+KC0t59VgAgGFIIfly8tdU
         mfsg==
X-Forwarded-Encrypted: i=1; AJvYcCUf4G7iiNeF1F6GBrX+4z5DYxNGN2eic5BRWAs1U0nIFzKGuGNDW9+AO0boTsBS/K/tf97MZcfHQYnBs96jZms5DFzFd/tc/qk2DRtU
X-Gm-Message-State: AOJu0YxzkBEhhwwQ7ms9p/HkW77fgHGiVX6Ep5wwUmTqoN53JdPphpxR
	wKMzNSWEceDzjCjUKSFNM8Jvr9E7n4YGBSoL/h2Y+eglKAn+Fc3B
X-Google-Smtp-Source: AGHT+IHBxdUq+iropeJlYDt3hjgiD6MNPvkCZytiqeBfNEB+Inabth5K9G6s9wgG6shbTzmmvVFIwg==
X-Received: by 2002:adf:f18a:0:b0:368:7e8a:a8b4 with SMTP id ffacd0b85a97d-36bbc0dcf49mr7771700f8f.23.1722842734982;
        Mon, 05 Aug 2024 00:25:34 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd02b15csm8937994f8f.65.2024.08.05.00.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 00:25:34 -0700 (PDT)
Date: Mon, 5 Aug 2024 09:25:33 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: sprd: sc2731: rename fuel gauge node to
 be generic
Message-ID: <45f5b1b8aac893d9b87c43ea76370199da4e3ff1.1722842067.git.stano.jakubek@gmail.com>
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

According to DT spec, node names should be generic. Rename the
sprd,sc2731-fgu node to a more generic "fuel-gauge".

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index fc4e2b1e160e..12136e68dada 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -94,7 +94,7 @@ pmic_adc: adc@480 {
 			nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
 		};
 
-		fgu@a00 {
+		fuel-gauge@a00 {
 			compatible = "sprd,sc2731-fgu";
 			reg = <0xa00>;
 			bat-detect-gpio = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
-- 
2.34.1


