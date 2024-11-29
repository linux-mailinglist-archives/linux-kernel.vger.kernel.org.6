Return-Path: <linux-kernel+bounces-425490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B139DC2CD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A91E163924
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19D4199EB2;
	Fri, 29 Nov 2024 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t/Fco5k+"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B341993BD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879478; cv=none; b=WF034zxYxGZK0ZhWwgLbuGtnl5oVmLsLbdYrRdIMP3tM2jc5g1Zm+phrRCqCgMuShFEMzQCWJtGFi7BcF+7kg44nPxANeuaGtYM/dY4nB1r/3UgMTgY4i+2HJtvDSo3NqQKYER4JzUoTPKA1c/Gjitz8bhtr0CgptHYuW0vzhII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879478; c=relaxed/simple;
	bh=VwpdmW3NZbtKY8ETSgMCK73nCEbh1x28I08qBy9WpOI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CGcQ8ehj6mMzzmLWMXA6mYCmVOCzCV859IzJ+TlVfseVkxrpjE+XDrzubOGeg9mbKauvl2vDsLKJdHSpYQF58OB2/1G7xMr1SkWuQ7iB01tl73elYBWOF4Va5AKhuxktDJcSU5EPikFg/HCH8cWdeQYLTOUOqgmS64UWn7UqWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t/Fco5k+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434ab938e37so11065865e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 03:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732879475; x=1733484275; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xjr4t6+jaVnD1Nnpoc97h5Ga1ERmjaQD302gTdpjnNU=;
        b=t/Fco5k+aFFSTAzSe0OfXGtCBUuycK2MTUdWllLULhZ013CXCBwSt8yIcp0sgI0VCs
         xncyUNpEBEwn3gqkl1fnrpIt9DdpfExAmRjR/vH8RE+CHHkuQ3lTFM4su+4YDLNnulJI
         XkzJsQgqoF8HZNZf7/XMyGzGJui+hz/oSrHn+DybfIQkAL0q1GywFaZk/UUrUPzNLhuP
         SW4LQto+SKxRd1oa0NbsjblM3KoR3f74/oB83avUmc+wb7q3MqkoTtOU4RiG0zVe8EtG
         54USodjZxXMEEcUX0iwJc1VLfMsNDZUj/xYbrlZomsD+0GXl3cq+4YsJiNsw1lihT0Q2
         9O5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732879475; x=1733484275;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xjr4t6+jaVnD1Nnpoc97h5Ga1ERmjaQD302gTdpjnNU=;
        b=MY7vrMTORcne+PMbPSmPgh/3XdNTbdFi+VUuLh7DpppeGntsvY2SHl/xzYPTgiwVrZ
         mDfJdYBkgPaN/X+HPm7JJ1vCEVAOA5kN1W/YmT6RdBARvZnDar7ZgUBL211hSNBCsS30
         NOtss8IoIm85T3Au3Mhk1WT95WkAqoj1h2CliNcP9bTek+l4SrAWagQZ7tPz9+0eAzNy
         gE1Ewf77sRjgJM1d0W0KD2BobD6xHXF3DAb9ix+SuAsPYVsybKauSnPWAa+6IYT7YrKI
         jgENZHFPvgxpHe/4/t1gDuU5fMpbpOV5MGQwsOYIBBjd3mhOtcBgoakfbXYyXLn/DD64
         cqPA==
X-Forwarded-Encrypted: i=1; AJvYcCUO0U0d56UjbBN/6r5T6aA32jXT96k9nfFlR2T2FnSEaor8J4afRzUcuEtSaRfB/MZXb5V0QRVuCkH7e4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzexw8mgevle05II4ix3RafqRKgg2wJIdjBeG9bKaTImaMbV0fk
	amX4JWTrTsaz5od7YhsifXiBOALdSIfssIJnAbWdU1lsaV1d0bUbs3QNe/upOCc=
X-Gm-Gg: ASbGncvS1VH/nDtH0z5HJOLJ4Skni7F48q0r557b+h8s5oBtAFA/KX57OGjqg/TexfL
	H3FFVtZcbzv+yLNPVjU+nEORUqN+JOkmTcRHRHLRT6YttUIhbzvTT12hRtIWtXT/+GDTOTVBHAm
	qlZKijBMDg2+C4/Y5dOEjhgq5UpOeIW1sTHjv/8A5L7vHKjjko3Mkfz+JCTMRZSzmZyM5Q0JxSF
	m2tRtSWjYsc1ZlpI/sW9XYTJ/P1Hphu1KJfomA+ignfp//9q0vflkw=
X-Google-Smtp-Source: AGHT+IGJf7wL63WoRbY7Qyhb5Is/61MFEjb8kJtv26dX8E7BzS9uZFKdz8Zkaho5ks18oSvth2ZAng==
X-Received: by 2002:a05:600c:3546:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-434a9de78d0mr93513265e9.22.1732879474788;
        Fri, 29 Nov 2024 03:24:34 -0800 (PST)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74f05asm80752145e9.1.2024.11.29.03.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 03:24:34 -0800 (PST)
Message-ID: <f14714b4bb667d339e6402c6cae37cee47406770.camel@linaro.org>
Subject: Re: [PATCH 4/6] arm64: dts: exynos: gs101: enable
 snps,dis_rxdet_inp3_quirk for DWC3
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>, Jagan Sridharan <badhri@google.com>, Alim
 Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>,
 kernel-team@android.com,  linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,  linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-samsung-soc@vger.kernel.org
Date: Fri, 29 Nov 2024 11:24:32 +0000
In-Reply-To: <20241127-gs101-phy-lanes-orientation-dts-v1-4-5222d8508b71@linaro.org>
References: 
	<20241127-gs101-phy-lanes-orientation-dts-v1-0-5222d8508b71@linaro.org>
	 <20241127-gs101-phy-lanes-orientation-dts-v1-4-5222d8508b71@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-27 at 11:01 +0000, Andr=C3=A9 Draszik wrote:
> This is required for the DWC3 core to reliably detect the connected
> phy's Vbus state.
>=20
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
> =C2=A0arch/arm64/boot/dts/exynos/google/gs101.dtsi | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> index 18d4e7852a1a..ab016fe9b99a 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -1302,6 +1302,7 @@ usbdrd31_dwc3: usb@0 {
> =C2=A0				interrupts =3D <GIC_SPI 463
> IRQ_TYPE_LEVEL_HIGH 0>;
> =C2=A0				phys =3D <&usbdrd31_phy 0>, <&usbdrd31_phy
> 1>;
> =C2=A0				phy-names =3D "usb2-phy", "usb3-phy";
> +				snps,dis_rxdet_inp3_quirk;

Seems this alone isn't enough in all cases, I'll send an update in a while.

Cheers,
Andre'


