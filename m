Return-Path: <linux-kernel+bounces-287786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D90952C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8793282B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861571D416E;
	Thu, 15 Aug 2024 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBUGDruC"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B83C1D3626;
	Thu, 15 Aug 2024 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716803; cv=none; b=QweJ+e+/AqH2fKAjTubj0x8wzbD0CKadmPaEWGY1a6SiGTqf5/vlT+ZxmZA3Oz5rXmGHtmaXsb5YXTTCPxa+i0ftRn9hrlyN/z22Yf6xpZw09SQS7xQyuq/5ihj5YP/vnQwqLjJy9DlIRIjxHe6jk4G3fgERdejVHu/wkl4/OAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716803; c=relaxed/simple;
	bh=GOxLm4U4ZWLjl0NkzII/zgkG4/f6Y+/4oj/C8o1Tx8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uc8AnDdec6zp4rwX7KpnarqcTET3Lff6pyKMmLOwXF0uhyUYIfL1Z+vBIgv/qU4YFm3vXm+c1dZhPx4hRE0gEh0ADrql9/PShk27MJAPGL9rAXuEJ+iYFDi2X1zhJrL76+4MRrDaMJP9NcVDrYUzH9xWK2UMZ6WpfA3zPGi3dko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBUGDruC; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bd1a9bdce4so1068083a12.3;
        Thu, 15 Aug 2024 03:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723716800; x=1724321600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6LLozyAaE8F3GKHniRRNzwrPHtCCu3L1lXB48SRYipQ=;
        b=XBUGDruCIr8F9k+hKaR3/X9EKj0cy7TEHdjakeEbzpI+LK1z/2uqa4xaG60KHz28nQ
         GCoB4kYUDGkFT90V7x9gUMet7I5k83JRDPhd+4acirboCg+noGbaL/6+ctYoWHTPrRUi
         tGFHKCO2aFsIoJXS4IoGF3VQmQ4lJpffxITB6vkvQHcJuIQ88fFbldOLohIW6HAVRvPe
         9BRHQvcjv500/v/cIf+yAbcL3v9VS93MLdes/57ecP+fWgGGbU93uUExBi7GQSrsPgMw
         V+Ef5SRYET0PYP2LIvGeC8jwuRWMVHUPJllbEDfrXt93Q2+cPZal92bfzKEOyIT3P3/P
         aXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723716800; x=1724321600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LLozyAaE8F3GKHniRRNzwrPHtCCu3L1lXB48SRYipQ=;
        b=QCbV3fjBAirBeoe2BKr+qVZC4qViggGHtQiT5QLDNWrqUsrnsCTBsy2ngLaAd+ClKE
         tlhqrsbdW8sC8Nr7a7LH4cf1wdzujoabJ4TpRQ9scIA/7+UiRXF7Xc5ezrsLEzmtIKzA
         4FQoNtXjWnz++MvGpDC8qdEAnX7/UnENxcw6+x9YSeWY/MDyq6DYMNt++9xHL4Gj+zkC
         nyDHDMksx43GCOsbOR7owsF8Auddv77e93L7Y0FuUlZgB5FapVFtPpIuNgcw6iQFrohT
         AI2rL2lVyBZjuvA1yBrmcDcgj4AKFs0PxmzaakZd7ds794RxAEDEbmMkBzEkW0DRzVSc
         s+Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWXgJ5Psj8MGdN1jWMoUdm0C2XpvJiZsy8GsdVNlmvm4hVI6KWQ5KfuqLWz6Z5ECxY0G8aO1+z277WNAR3N9qzW9XkXvkg05LLyzZAz
X-Gm-Message-State: AOJu0YxaOM/WhtXc7FpcRH+tyy4nbC6OQO/MX+CQfsUkYrMsEg6C54Qy
	N39+U5TkWF+F2PoX96tNYWIKuNYl0nuLkvZtqyqUvPGZREAUd69S
X-Google-Smtp-Source: AGHT+IFnZ23a+xDFO83XJOOZnnc3Kope6N7J29Pj/fvePKB7e2N/ix7pSU6EiHVwnyS6+cWjn97VEw==
X-Received: by 2002:a17:907:f704:b0:a7d:a00a:a9fe with SMTP id a640c23a62f3a-a8366c3130dmr374088766b.17.1723716800125;
        Thu, 15 Aug 2024 03:13:20 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396d332sm77373766b.224.2024.08.15.03.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 03:13:19 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:13:18 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: sprd: sc2731: fix bat-detect-gpios property
Message-ID: <e57ee9b94f128753d156d77015f6cc3dc24fd9e8.1723716331.git.stano.jakubek@gmail.com>
References: <cover.1723716331.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723716331.git.stano.jakubek@gmail.com>

According to DT bindings, the property is called bat-detect-gpios, not
bat-detect-gpio. Update the property as such.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index 12136e68dada..c8b30c0479fd 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -97,7 +97,7 @@ pmic_adc: adc@480 {
 		fuel-gauge@a00 {
 			compatible = "sprd,sc2731-fgu";
 			reg = <0xa00>;
-			bat-detect-gpio = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
+			bat-detect-gpios = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
 			io-channels = <&pmic_adc 3>, <&pmic_adc 6>;
 			io-channel-names = "bat-temp", "charge-vol";
 			monitored-battery = <&bat>;
-- 
2.34.1


