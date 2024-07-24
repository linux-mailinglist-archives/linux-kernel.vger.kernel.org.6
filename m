Return-Path: <linux-kernel+bounces-260783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6038D93AE2D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923CD1C22F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA04A14D452;
	Wed, 24 Jul 2024 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KmLSmkL9"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB013A418
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811434; cv=none; b=aBSl3Bcb3UWysO8aMFpTrRd7X6I0y+0Mfs40bohiIZpvMcenoAK44dvHSfnIcyLS4dOSxF7lOo8Z8vYTtoRMC+M1zkI5GdulijoyKHCG4era3sA76af7Xlw0u+zHpszbI21664VVlDc5nCldB+HpO7S+Qy96sh55XXmLBdMc/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811434; c=relaxed/simple;
	bh=it6TmeD94CbkExwTMtJXO2ImHcBqqRkhW8fJ57kF1wg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lITMhRpcpvtgCb3diKHiMW5qwORIQVnsaV7QBzx9hdniTuc3ao+EkgDF0qMXYE4tet/HqnJJ4at8gg8DA0y2K1dD6GPAVMpoqkZ2L0ZvW1VtBCEx3cRB+Xih3iudDJ4JWuAz3SdxAzUjLx4VlmHKnc/mMSWo3VQCPATE2gNFSqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KmLSmkL9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-368526b1333so339506f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721811430; x=1722416230; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ex2WAaEgr4Aywnu8Z6YGTbRFYH2z8IgKzkgzd617kh4=;
        b=KmLSmkL9rxd1cFtZtvHS7Z+hOofVhRiCkTU41AYB1FZgY24TED0n49SK4Tn2S1Cb+t
         MWLwTzfLXy6FKoUuWsymABHAcvj0dMMmw9DMAbM/oTNQJjRPVi7xkX91Mb6Vnq5Masgj
         Z2q50feq180VlPfED1pyZJ+V2B4S+mWIAU9O16h8u/8hdPBbRl7HaIjrG/D3k/DWeaAb
         5lTjWepO3EdKs4eKfuJRQDwh2fQE4/b41HKxPpXiBgmlWheJxjI7yd5gmNm6sRtr+/MX
         gMYmPLcPN0NSxmroRX1HrhtNuKfmQUN3sfZg/+im9CGmJXPBLmuJq2I8SYmLtwy/N3dM
         VFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721811430; x=1722416230;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ex2WAaEgr4Aywnu8Z6YGTbRFYH2z8IgKzkgzd617kh4=;
        b=gtuWdv1iOs7eZYtTNWAy/sGdVZdIHfklpWjj4vLeA87SJczpP2NAPl7eirNBxSeoDQ
         tuUoFib1XEOxpt5jQ16kjfE3QAO++RLjmuPzNvpnhCEf7yBHrdm6fEnrME7Au6hCZLWJ
         DElP+3pi7O9ciRsVqJV+ZW3Oy/wWlOa23vKWkMOovT5A9KPtNXN96+Qj3TYooEuPPzMm
         xE6s/y7cILjWp1ei7/7ogW74Agb5dou/BJ7IHN1vF1w47spBEQpXxNAvXB8BzLJGdguV
         JYPnIUKn9EMT0LzvUQbXvTEn16D57+Yh7zY2+cmlsuwuTC7XhT+X5uUqrR0en2QGizqO
         8aog==
X-Forwarded-Encrypted: i=1; AJvYcCVvmw1Xvsqk8+MPuCNR0Acr+aAGTXnT9klC9qMCnmpcmTXiA7coRDZ5yDU+U6uhiFZV/DvKkBjoWXDSFHrg+Mru1CQQ/kte3wS2VElc
X-Gm-Message-State: AOJu0Yz767sItwQmNI3CTv7vT9yMOwMxa0uEiJCRowhTjpAJAG80Gatc
	doIop3ZNKHV0+uTg54xczUPZIQzUd+o5NQ/rLFz4nk3mCUI5kdk4prrL46kCWBE=
X-Google-Smtp-Source: AGHT+IHT9UkzD1uO1lRT5mI9+EExnZOGwlczD2Bif9FSUePHDawxlyCapZD9VsjXCE8jdbXZOpuBgw==
X-Received: by 2002:a5d:5270:0:b0:367:8a2d:b354 with SMTP id ffacd0b85a97d-369f66cef90mr870578f8f.14.1721811429818;
        Wed, 24 Jul 2024 01:57:09 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ced78sm13792084f8f.74.2024.07.24.01.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 01:57:09 -0700 (PDT)
Message-ID: <a1b7ce4bce1826e9c231677bb221aa44dc842e24.camel@linaro.org>
Subject: Re: linux-next: manual merge of the phy-next tree with the
 samsung-krzk tree
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kishon Vijay Abraham I
	 <kishon@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Krzysztof Kozlowski
	 <krzysztof.kozlowski@linaro.org>, Linux Kernel Mailing List
	 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
	 <linux-next@vger.kernel.org>, Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 24 Jul 2024 09:57:08 +0100
In-Reply-To: <20240724091458.3052dc6f@canb.auug.org.au>
References: <20240703141932.47e51748@canb.auug.org.au>
	 <20240724091458.3052dc6f@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Stephen,

On Wed, 2024-07-24 at 09:14 +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> On Wed, 3 Jul 2024 14:19:32 +1000 Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote:
> >=20
> > Today's linux-next merge of the phy-next tree got a conflict in:
> >=20
> > =C2=A0 include/linux/soc/samsung/exynos-regs-pmu.h
> >=20
> > between commit:
> >=20
> > =C2=A0 85863cee8ce0 ("soc: samsung: exynos-pmu: add support for PMU_ALI=
VE non atomic registers")
> >=20
> > from the samsung-krzk tree and commit:
> >=20
> > =C2=A0 32267c29bc7d ("phy: exynos5-usbdrd: support Exynos USBDRD 3.1 co=
mbo phy (HS & SS)")
> >=20
> > from the phy-next tree.
> >=20
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tre=
e
> > is submitted for merging.=C2=A0 You may also want to consider cooperati=
ng
> > with the maintainer of the conflicting tree to minimise any particularl=
y
> > complex conflicts.
> >=20
> > diff --cc include/linux/soc/samsung/exynos-regs-pmu.h
> > index f411c176536d,6765160eaab2..000000000000
> > --- a/include/linux/soc/samsung/exynos-regs-pmu.h
> > +++ b/include/linux/soc/samsung/exynos-regs-pmu.h
> > @@@ -657,8 -657,8 +657,12 @@@
> > =C2=A0 #define EXYNOS5433_PAD_RETENTION_UFS_OPTION			(0x3268)
> > =C2=A0 #define EXYNOS5433_PAD_RETENTION_FSYSGENIO_OPTION		(0x32A8)
> > =C2=A0=20
> > =C2=A0+/* For Tensor GS101 */
> > =C2=A0+#define GS101_SYSIP_DAT0					(0x810)
> > =C2=A0+#define GS101_SYSTEM_CONFIGURATION				(0x3A00)
> > =C2=A0+
> > + /* For GS101 */
> > + #define GS101_PHY_CTRL_USB20					0x3eb0
> > + #define GS101_PHY_CTRL_USBDP					0x3eb4
> > +=20
> > =C2=A0 #endif /* __LINUX_SOC_EXYNOS_REGS_PMU_H */
>=20
> This is now a conflict between he phy-next tree and Linus' tree.

What's the way to resolve this? Can I do something?

Cheers,
Andre'


