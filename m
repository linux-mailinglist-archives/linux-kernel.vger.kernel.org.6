Return-Path: <linux-kernel+bounces-439623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 016BB9EB1E1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C38169035
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48F11AA1DB;
	Tue, 10 Dec 2024 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm6jBhSp"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9358541C64;
	Tue, 10 Dec 2024 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837246; cv=none; b=hWTLLpi4NebE+SUtFEnAo6S2lQpNm26IzIGjTJF+Yv3bHiqKWCB2Cemb/Oy6C7kDD6fRJpi1xCQaYF8rq6gwGZTUp1537UxSzvkyKyMMhlJmvWQGhZDjs/EcKZygEsWCob5o1Is5EmaKJzXqaRskibRIdPVIKUq2IJ5txjfTiPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837246; c=relaxed/simple;
	bh=Ym00reN6sZsXJPK7U169ONysSfAeAO9Yt+bdol2IDMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puCV4+u1NfXvKYwkSgUWh4Ar+7HfAu9vQ2F0BeiNZ4849Nk40NeqT5fKGQgs7AK/KyrfmG3Rj8z/sjbYC3h/xX6Oq2f14Kot+cwjs/DLI9RusojvGREFGEb+VcJ+PDZ2zUwYYpWfuJWMad378W07JCnzOU/OthNhkE15Z+3zF5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nm6jBhSp; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so4587879a12.1;
        Tue, 10 Dec 2024 05:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733837243; x=1734442043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBCKmYeQtQXtJD2nS/OX7EenTXHyXCtFX8tV6++9Flc=;
        b=Nm6jBhSpYT3IJrMIwfna7J3inrfZE/k3fuWue5xV9aCrID+pO35/xGIO9kdPrEStHs
         3csVKtd3MqTc8Zovg+uzud0s8c2pmh2FdLoNEm+iabPeruy2PwO+WYz1axTSgqnu939p
         LTzW0A7XRPLKPosheXSPzaVUJJiHm8FCkAs22QRBsltq6Y1aT0oHo538g8FjmpXICUii
         ph7BW5cfgQ+s46006N6H+9+rt81D1HKIdbL+uwbSYj5BuAlyFmw35D1i+/BEtWTupFEd
         ZzoF+gXGOlhtD2QPQnGf/Y0h9sCqtvUwRvemMmvlvs56/fJ4J8cEE5nviO+bXMXIhCqa
         1g9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733837243; x=1734442043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBCKmYeQtQXtJD2nS/OX7EenTXHyXCtFX8tV6++9Flc=;
        b=fuWZWacCkccrk7D4G5un3PZQIOp3tfmAWissF25Al+Au/YjijvI7gEI72LTwNCBlUn
         xW2/zgmzMsvOVD97Vg6PYkp1bm0YZhQgyVxFs9GjGKhprCHnTwHPL3UIoUCqClPfnB1A
         L1QR5ZtQacVvikTOQBpV6yy+/Aj0QDZCp5HyTz0Sh+Cl1yxV+DLEoypdUN821hfEGge/
         6HdHofBbwrRB5I5Md+jKXxWiWwNkpixnXSWVendVxD9SKRFK4c87mq7blYw/vkEH5Mgp
         0hPC8rwkQyY7c9x3Tz75LbFFJ30OA4Io4cwWkQ3cNZgbfzk4/3BLRioqGkdrM+CVbJzc
         Ttvw==
X-Forwarded-Encrypted: i=1; AJvYcCWGULZphIMgi48RF+rMFabXNA8X1ft+ZmBV4dYDo08qtXWi43fKOTdEIQ79NX5NMpU4aCKxTneMpVo=@vger.kernel.org, AJvYcCX1fu+Viz8vNLi0kHbMVKmXwcr3JV17VM+/+TFY4TtgRV1qTNoKFL3LMLO1bwZ8Kwl2iLzNkZ9xHhQx3hcL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6u/AiN4Inco/qCVFp5Kp1miAATWkeBeXra5lCiU9Ml8Yy2j+Y
	H6qBn8n87Ds35HEyqqU3Kol6sUJAouBp49ULsjhj+r/8ABDlt6INEAMGnHyJ5OY8IuKO3keQklC
	D+RO0Vt54zCkoIqsopOCPZcZHc7k=
X-Gm-Gg: ASbGnctTgyo+Ej4PXDRt3doQpCi68cPD8GpPMD6egESlQZgqKyMJDVVts/qDa5mqEC2
	vA25XS2IE9pHwDx98f3Jngm2yxj94n/umzXPcj4WkRHYwS0aa75gYX+Qdm68=
X-Google-Smtp-Source: AGHT+IH4cq4eJMBBv9InVUxlo+TzZnHjLwzmvamweU5oP6kP+jJlPr/U3U9rCW2HNtHUYQxnPZCF1RFlpv5NCQEhnhU=
X-Received: by 2002:a05:6402:5190:b0:5d0:feec:e15d with SMTP id
 4fb4d7f45d1cf-5d3be6d650cmr14520588a12.8.1733837242523; Tue, 10 Dec 2024
 05:27:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210013010.81257-1-pgwipeout@gmail.com> <20241210013010.81257-3-pgwipeout@gmail.com>
 <0d11705121f29ccfb7cfa342505a6e35@manjaro.org>
In-Reply-To: <0d11705121f29ccfb7cfa342505a6e35@manjaro.org>
From: Peter Geis <pgwipeout@gmail.com>
Date: Tue, 10 Dec 2024 08:27:13 -0500
Message-ID: <CAMdYzYqJLK6oJHCUVztth6mtJsYrRQSPzNYpR-ZmR7rNprZXfg@mail.gmail.com>
Subject: Re: [PATCH 2/6] clk: rockchip: fix wrong clk_ref_usb3otg parent for rk3328
To: Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Elaine Zhang <zhangqing@rock-chips.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 4:44=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Peter,
>
> On 2024-12-10 02:30, Peter Geis wrote:
> > Correct the clk_ref_usb3otg parent to fix clock control for the usb3
> > controller on rk3328. Verified against the rk3328 trm and usb3 clock
> > tree
> > documentation.
> >
> > Fixes: fe3511ad8a1c ("clk: rockchip: add clock controller for rk3328")
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >
> >  drivers/clk/rockchip/clk-rk3328.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/rockchip/clk-rk3328.c
> > b/drivers/clk/rockchip/clk-rk3328.c
> > index 3bb87b27b662..cf60fcf2fa5c 100644
> > --- a/drivers/clk/rockchip/clk-rk3328.c
> > +++ b/drivers/clk/rockchip/clk-rk3328.c
> > @@ -201,7 +201,7 @@ PNAME(mux_aclk_peri_pre_p)        =3D { "cpll_peri"=
,
> >                                   "gpll_peri",
> >                                   "hdmiphy_peri" };
> >  PNAME(mux_ref_usb3otg_src_p) =3D { "xin24m",
> > -                                 "clk_usb3otg_ref" };
> > +                                 "clk_ref_usb3otg_src" };
> >  PNAME(mux_xin24m_32k_p)              =3D { "xin24m",
> >                                   "clk_rtc32k" };
> >  PNAME(mux_mac2io_src_p)              =3D { "clk_mac2io_src",
>
> Sorry, but I was unable to verify this in the part 1 of the
> RK3328 TRM, in both versions 1.1 and 1.2, which is all I have
> when it comes to the RK3328 TRM.  Is that maybe described in
> the part 2, which I've been unable to locate for years?
>
> Moreover, the downstream kernel source from Rockchip does it
> the way [1] it's currently done in the mainline kernel, which
> makes me confused a bit?  Could you, please, provide more
> details about the two references you mentioned in the patch
> description, or maybe even you could provide the links to
> those two references?
>
> [1]
> https://raw.githubusercontent.com/rockchip-linux/kernel/refs/heads/develo=
p-4.4/drivers/clk/rockchip/clk-rk3328.c

It is unfortunate the TRM doesn't include the clock maps, because they
are extremely helpful when one can acquire them. It also doesn't help
that the TRM register definition only referred to this as "pll". I was
sent specifically the usb3 phy clock map for my work on the driver,
which had the location of each switch and divider along with the
register and bit that controlled it. That combined with the TRM
register map allowed me to find this error.

Thanks!
Peter

