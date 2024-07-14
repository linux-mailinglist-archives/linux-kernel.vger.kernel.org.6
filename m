Return-Path: <linux-kernel+bounces-251789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AEC9309D7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11BE1C20A0E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 11:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6407344E;
	Sun, 14 Jul 2024 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOqDiWJy"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A128644361;
	Sun, 14 Jul 2024 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720958226; cv=none; b=SmFDGQnL3ORBdl3hJlOVmcqYOadIcez4f09gNo28x1pQG9XwhpyHJBF43GsCuumz5fWDBds5ofgvhlmVhx2IUGdh12/3fBjR5n63QUyZznpJYR43vTKZNfUr9x1Efe+3+JnUyNJWwDIFrOve58bHCWo0Y4+mXbczayaLihKu7CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720958226; c=relaxed/simple;
	bh=vnMOWr+sg3V7r4lks/vNsJBg4r3vgoqD/LS4j65+Dv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnhlooI3Fcp6bwbhrPhAYVDwZXMe2+cNQxYgJ2isKj7VnG20rTITlpC8RTtmhfdeYRaZtt9oILv/zxzkxrSpBvLaeIeQcF6NBy685rcDQMWX0lN4T4sWaqUYMuiYM13LZ9QOhuOyIrm6N77fSliPfeVn2saxdum32KHvIACFEtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOqDiWJy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-427aeebaecdso533295e9.1;
        Sun, 14 Jul 2024 04:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720958223; x=1721563023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ev+3M1KyoZUQSOdLbbDNRbHz25PKSnzPrZasulwQUs=;
        b=ZOqDiWJySJ4r1aV7uaNdFLykr3zOM9yHoLSizpaJhX8OXjHCoCbHE5LtN30kyThjof
         04bKTINexmAafzQ69g2qn11h+E7Wiy5iQe+F4T/TCitUx2cppfHnTTGspPsCAtCYyCfV
         Rszy7dLZ6kCGe9icHXNGAO4I1pFcWoDN4jM+LePsGaZrSAXsIRqSxuHSQ4YBXlMPM87H
         a+NJkSdeIqEUngj/9K9u/7HR3yZ28GWvTKiHhM09zB7bDshdWFou9PvSt/jOQQHhb6a5
         HQzcHpXrb+9JUfyB5EMNhzeNSZ7DHyBigs/xHhWPsvz9cUP/cV95g1wWfD8P97+02kxn
         qk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720958223; x=1721563023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ev+3M1KyoZUQSOdLbbDNRbHz25PKSnzPrZasulwQUs=;
        b=khhEdLTKpGPbuI4AlJMeStFNhXafICe66haeLZ/miDyrM4r1c+l/mlHlg86pj7eZxL
         ND5XNj4/YJfFbQMOb7sro7og0kD4M/VY3xzk9c0zHu4qTSf+E4pGjm1pmJjIgQ4+Lxso
         6p8u5zEeSzAqBc2wHqx0hYvoz+yFGSA+YTLN4mJYwV9MNIkhF1H/VOrq71FK6LCfGG4v
         fFs/9kznbDJY+eQGhVaaKeAmqLvvhalQDN92hT+s6m3AS1buRjwWpVyz/4pEOkLkAQRw
         9KxGqUc5B57LewehLM54UTMpBRhTd3+W7mn88hqmXdOIqeIA6vzeS/klUH6sduzC6MVg
         N/sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE3caA87zkoLxVgcFZYSHk/PQVhCGK9dknel5PFYOntLebaQqAmFAkcenhNm1ThXv2HOzBw2gKzg6Dv/P+dC7boxiIypQg6bXkGe63
X-Gm-Message-State: AOJu0YxaSljwxeV9OypB0F1T+4dNa5BNOje5GzJGTD2p0Co7EOcVimxe
	lZ7iIeJw7kXpZkCIvsmfqhTTuPvZdOgHfvMz6tZGX608+S6OUM7u
X-Google-Smtp-Source: AGHT+IEtYsC7P4Ws91isMUHy6oUv2VIAuPj7vuP5tk2PAP0VVBeyw8wgsl5gBPEyKo/XzJ19YhUJPw==
X-Received: by 2002:a05:600c:2184:b0:426:61e8:fb35 with SMTP id 5b1f17b1804b1-426707cc03dmr114510845e9.4.1720958222873;
        Sun, 14 Jul 2024 04:57:02 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f239876sm84675835e9.3.2024.07.14.04.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 04:57:02 -0700 (PDT)
Date: Sun, 14 Jul 2024 13:57:00 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: sprd: sc2731: rename fuel gauge node to be
 generic
Message-ID: <246c0c7763a432d4bebcb0e99b90dcf4cded333d.1720957783.git.stano.jakubek@gmail.com>
References: <cover.1720957783.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720957783.git.stano.jakubek@gmail.com>

According to DT spec, node names should be generic. Rename the
sprd,sc2731-fgu node to a more generic "fuel-gauge".

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index 7e55b2b31c84..48b681768f6e 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -95,7 +95,7 @@ pmic_adc: adc@480 {
 			nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
 		};
 
-		fgu@a00 {
+		fuel-gauge@a00 {
 			compatible = "sprd,sc2731-fgu";
 			reg = <0xa00>;
 			bat-detect-gpio = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
-- 
2.34.1


