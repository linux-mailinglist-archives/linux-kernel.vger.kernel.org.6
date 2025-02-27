Return-Path: <linux-kernel+bounces-536642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBC2A4826A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E2D17F573
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6094225F795;
	Thu, 27 Feb 2025 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sIfbzkkg"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AAA25F792
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668272; cv=none; b=eQfSaGkAJ1bGp0vvGSn2nfHfiDEquvYbyNsUlknuJnN9KRMdJTe1GasH2dNM2BXZDXzuc9QM9+Pfg6ba+Jcl+GBjkuU8UBtXlwRqGQY81rPfDSaubNfXgnXRU/CXFa6PrnFI4bu328kBfEIjYnbdpnVQ4MzfQ8MgPTsYGo+6iow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668272; c=relaxed/simple;
	bh=DDXrrba6/WpzP8bI9c/CPfIOz9zI6g2hO9iOlccn1Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=um/4SIfLCS467V/pguCs8rwaj9whIXoQCcOZwrfNIXZKJyzI+5lQrcN7CVCyx20jX5ytXO4VeZQs9TtfJ6xV9AZiUe+I8HVnG/zRg05qjmncM2+/quM0Hmfx30W5RzeZrNnK3jRFouz9KZZpCEoGn38L5FTO19zaGi+dmLCdfvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sIfbzkkg; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30795988ebeso11459261fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740668269; x=1741273069; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o6kWm1WxAljHizi3xT8gP5C7gJ5IPTi+Bx7Iv+hmWHQ=;
        b=sIfbzkkgLHNyfgVCSp/oKxGS4T31vpSW5HhBsYfo2BlJAGMAWeEBHHsUDXXLHlOE2h
         1nKlNadr/jmZV40UZ6LTelZT2yM39izHFMNWtU7EzoUxYqKqQx0g6oGXQU+VCOpbCgrg
         uiI5379Z0oapoaD2+XXz9rcmuw4v+gmGmxLjuEvcnzEUqF86EAbMc82NqtjeA+UlKPGF
         /Rc/an+QIbCRZkTgMNxG+EoUGwmaPbgP6tncvyiZx8V+ozsm9wu1oPNusX0Tc3eZCcWi
         +toXS4hF3NECMf76qHBiVUAQdn37nJmR9PXhZD7bAvIeQjd3GPxiH6CaZq+J4aGo6sBm
         EglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740668269; x=1741273069;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6kWm1WxAljHizi3xT8gP5C7gJ5IPTi+Bx7Iv+hmWHQ=;
        b=WKM9/I7sZCo3e8rTdv/1FcFlpHMtxLZSJ2oOZCQg+C8XvhjPW4nEJheRXBsAMj/yfR
         WDSq7XvTAvjEP2gIPSlzpOIvJsX825aJPQx1q8IEj1D0LUF+RWoBls6o6blgBOKYXtlj
         +72mOtyfNClw9ZUJ/0CeawsJXuSD/glX6Lyz2gM2IeEUllQDygtFvrEDdqzfWzBZ1Yyj
         9IkajEWRwewJG7w5ujCOdOgNml03oPH6BNfiWARt0pPweSdVswLLdnpQ8EdmyIRD/XYM
         WfiZLRK0xkiI/90awtLzTX34RkDt6iuU685PEr/U4r+AEUyiOYUDdUasKGWTdfYlhrl+
         t7Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWiozV/YbL0gpaIPT9V7X5ldHg1uotRhpdhO61icQXWIyhFKB5GIHtP646HblyjidcoyvbulGK7/tOA1T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ1LL3NcEj2Z72x0SKM51JZbjbXBkXW8Q1mou7Ch7OXK10y/mU
	EYo46fG9rIro2Itk4xsn+4gyK1WJ9q4E543cEamabOi3GRXncyZtK0k8ongRktY=
X-Gm-Gg: ASbGnctF7zGM4tw5pSVrfpg9nLqnidm20E3SCgdI7TyEIT25cPqfAl8HgMKArehPtYm
	lSotVUbg8jg6vv/0I6g5tL0YkLlgKHp1jqikUz5bKZ6AV9Z5Ta/YNyCaFiX9a/7lIgK+YdVbtHh
	jbdRV4AjXHnUqJ5aKhK6262YZOox1Q5SnT087zjLA3Qxowb4kQAmUMo4wxyAUpMPjh4QKTpaA6y
	cJ2G8tME6zvojmM+L3E+Zc31r1Jp6JE311VYoxTJQEFzMh/M447o3GPTY3mmjF4nnOZRrORuOTI
	Lm6T4YF2/m9mwFB6fQvZypF80MrWvjGIbmKpc/Kod5isSxK09XtrjkYGKqUyzsNy6D2c5qfk0qn
	FKcuEkw==
X-Google-Smtp-Source: AGHT+IFle+ByWFKvSAisfuqZrntUlT1vHp52/oS2NVYwgUxcznsQotmllj3S/yU1ebMvTGen2ti2HA==
X-Received: by 2002:a2e:81d2:0:b0:2fb:cc0:2a05 with SMTP id 38308e7fff4ca-30a80cba36dmr62735011fa.37.1740668268815;
        Thu, 27 Feb 2025 06:57:48 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b8688a587sm1920371fa.111.2025.02.27.06.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 06:57:48 -0800 (PST)
Date: Thu, 27 Feb 2025 16:57:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Nikita Travkin <nikita@trvn.ru>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] {vision/navigation}-mezzanine: Fix overlay root node
Message-ID: <axorlloo25pdox6kjl23l4kzosofxhqkygxbtcbtx3sbgj54m7@hn3jyf4oaeno>
References: <20250226-qcom-nonroot-overlays-v1-0-26c6e7605833@trvn.ru>
 <vq5dcsi55aqn56h6ihysqk4lainhmjbyvot3jiqkxm3i7igsak@da5u6ro7rkvg>
 <62a53d3222dfc516accd8dcd5e1adca0@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62a53d3222dfc516accd8dcd5e1adca0@trvn.ru>

On Thu, Feb 27, 2025 at 02:01:41PM +0500, Nikita Travkin wrote:
> Dmitry Baryshkov писал(а) 27.02.2025 09:16:
> > On Wed, Feb 26, 2025 at 07:29:54PM +0500, Nikita Travkin wrote:
> >> While considering to propose WoA EL2 dt overlays upstream I was looking
> >> at existing overlays and noticed that some of them are broken: they put
> >> seemingly meaningful fixups into the overlay's "/" node, which places
> >> them into the overlay "metadata" itself, not into a fixup fragment to be
> >> applied to the actual dtb. This series fixes those two by changing to
> >> full path "&{/}" which should work as it was initially intended.
> >> 
> >> See demonstration of the problem below:
> >> 
> [...]
> >> $ dtc extra.dtbo
> >> /dts-v1/;
> >> 
> >> / {
> >> 	foo;
> >> 
> >> 	bar {
> >> 		baz;
> >> 	};
> > 
> > Is this behaviour documented somewhere? I'd say, it would be a surprise
> > to me.
> > 
> 
> According to dtc docs [1],
> 
>    3.b) The Device Tree fragments must be compiled with the same option but they
>    must also have a tag (/plugin/) that allows undefined references to nodes
>    that are not present at compilation time to be recorded so that the runtime
>    loader can fix them.
> 
> so per my understanding "plugin" directive only changes the meaning of
> references (i.e. stuff with "&"), to generate fragments/fixups, which
> are the only way libfdt combines overlays into the base dtb.
> 
> I suppose the old way of "manually" writing fragments (and thus writing
> to / as raw nodes) was kept because phandle/path based updates were
> added later to dtc and many overlays were still defining raw fragments...
> 
> "/" also allows one to write "raw" nodes into the overlay, which is
> sometimes used by downstreams. (i.e. they put custom extensions to the
> overlay format [2] or add metadata into / of the dtbo like "compatible"
> values to reject incompatible overlays from applying. [3]) This is
> actually why I started looking here in the first place as for woa el2
> overlays I was asked to add compatible metadata as, apparently, NixOS
> tooling requires it to validate the overlays [4].

I see. Thanks a lot for the explanation and for the pointers!

> 
> [1] https://web.git.kernel.org/pub/scm/utils/dtc/dtc.git/tree/Documentation/dt-object-internal.txt#n120
> [2] https://github.com/raspberrypi/linux/blob/rpi-6.6.y/arch/arm/boot/dts/overlays/adafruit-st7735r-overlay.dts#L73
> [3] https://github.com/radxa-pkg/radxa-overlays/blob/main/arch/arm64/boot/dts/rockchip/overlays/rk3588-i2c0-m1.dts#L5
> [4] https://github.com/TravMurav/slbounce/blob/main/dtbo/x1e-el2.dtso#L12
> 
> >> 
> >> 	fragment@0 {
> >> 		target-path = "/";
> >> 
> >> 		__overlay__ {
> >> 			whatever-comes-next-after-baz;
> >> 		};
> >> 	};
> >> };
> >> 
> >> $ dtc combine.dtb
> >> /dts-v1/;
> >> 
> >> / {
> >> 	whatever-comes-next-after-baz;
> >> 	compatible = "fake,board";
> >> 	fake,value = <0x2a>;
> >> };
> >> 
> >> In the resulting dtb foo bar and baz are missing.
> >> 
> >> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> >> ---
> >> Nikita Travkin (2):
> >>       arm64: dts: qcom: qrb5165-rb5-vision-mezzanine: Fix broken overlay root
> >>       arm64: dts: qcom: sdm845-db845c-navigation-mezzanine: Fix the overlay root
> >> 
> >>  arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dtso       | 2 +-
> >>  arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso | 2 +-
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >> ---
> >> base-commit: 8433c776e1eb1371f5cd40b5fd3a61f9c7b7f3ad
> >> change-id: 20250226-qcom-nonroot-overlays-bfe21d33be8c
> >> 
> >> Best regards,
> >> -- 
> >> Nikita Travkin <nikita@trvn.ru>
> >>

-- 
With best wishes
Dmitry

