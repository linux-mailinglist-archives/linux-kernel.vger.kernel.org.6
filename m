Return-Path: <linux-kernel+bounces-327405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0D3977588
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BAD7B23269
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF10D1C68AE;
	Thu, 12 Sep 2024 23:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSmH14M0"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3763D1C331D;
	Thu, 12 Sep 2024 23:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183218; cv=none; b=AGTa+hVtS0vLTX9yMf0pXhtatH1l+OtMwKB0ik8yQb3MNHVoBuZGiFbVoowjmDaI+KGQwQiA8c/o7jJJJ3eSw43TR9vc/p/jcDWHx2SL0NNTwKGt3IcmUnItyYrQnL+ugKR5F5SAlC2kkKj0gwQ2PWsM8pHH+6T8xnrzqcokrJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183218; c=relaxed/simple;
	bh=UdCJlnJosESBpLD1XXoyLp1nvyQEOPEcRjwTYfSsenA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dsexdsAXREhuUyBknzurCNMxh0sOPoLj+EdjFfZCz6/eA/dCDsO3mdkPDZQx4TTTfvmw7/Iae+5z7oXmHFHCma37Cw+VDz+aj+SLsq385hSVeh/bcwakIoZW0pv5uVY339sk+r03Rgi/V/c5XROzagGECngzblPjIRMNqarz+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSmH14M0; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so33582066b.3;
        Thu, 12 Sep 2024 16:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726183214; x=1726788014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXhULeeV7vls+nv+QnnPDOCh7Gg8+iCwIhYeNnAxrac=;
        b=BSmH14M0ab7XXT8QK8TOPIncWlun8cPwJccEUfegXSm7IOqffBtVUR5NgNEHe+AWnm
         0JIdXJJoJusAhvLpAgdZWg/lEegdBID2jCc04l1eYUuwbE5L0gOxEqVFt712w8x+4qal
         v233afB9+2HK4TUzOFTckw6s+T6JIzm2wYxbCZdsb11UtVkw84Vre/5wz7SSBlAPg/Gm
         uARbXiPHd1tvppBcsWa4dOKngJn+YVqwhYdt/0mCfWfsBBpk3VBbYiZ20uBVzfQFf3j4
         yihd3tqiYAt8iebVpz3qW90UTna/Iv3+QYFbHM1NSunrnVFcrkoYac/sq5TR3W+5YBXz
         OHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183214; x=1726788014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXhULeeV7vls+nv+QnnPDOCh7Gg8+iCwIhYeNnAxrac=;
        b=gI3s3zL5gOfjFo0AYOuxeSOuzwjIABDf/PRH7P6WVJI22DIrPuT3rMckTnzW3Apzvu
         mruQ5RrFCSGEMch78gVDAxE7mvMNWIL77YJUqKepGuPQRzSPxENovLFk7rW/p017zTWS
         8IrN4I3X4G2tqZfexZGp3/Ol6hUN+HZ8XHQDy8b6+Hg20PFgn3adgWS/Ag1Ga32fDGTj
         UzYCkhM4XtzV7lAf1pqApLWOCtH1isO4Rhqq+NFN8y7/8mJbMKxuMUZ7Pos82T3ES1Ll
         GfzU5hSSRCbH8fNgW8pjxb92DYiwFFTDL+NiB2mqaZz7eT77QZLmfKyGU+N1X6dTuqIK
         Ln9w==
X-Forwarded-Encrypted: i=1; AJvYcCUBt9RZxnzkD2qhTorSGts//cuact/kMqdw80sJQ1gSLqcQ05nhaCZyrattRSPogthR6/7TXtzmE5b/@vger.kernel.org, AJvYcCUOb8wCGfQy2t7ajjlazFVIroFxHCg9lTMo3jRCcp3nnWO24DXRn9okISVybE5bqeu8qwnwcKloXzOZ1kGd@vger.kernel.org
X-Gm-Message-State: AOJu0YyP0W0SuTOe1IR+eOnZll7ieKq/z/Y/6uH2gUVb+/WFqkkQ+JWj
	cYwfqID9ODxMDtf5esFpXDic6qwBzbJjlWiPJGCK++/uv4Wh5O5uQemV4LLVzBJwicZfBj3rixm
	+m80vmAJIIX2if2bx1DTQmoZ7sUM=
X-Google-Smtp-Source: AGHT+IHbZo2wnjqdUsLgmBT4T7H7hcXQYR+XunYL7wqkMhhgveG3haS7KrE2iato4KRSLlyIyR37QuYUaUcqB8LNq1A=
X-Received: by 2002:a17:907:f763:b0:a86:81b8:543f with SMTP id
 a640c23a62f3a-a90480cef74mr48691066b.64.1726183213701; Thu, 12 Sep 2024
 16:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912025034.180233-1-CFSworks@gmail.com> <20240912025034.180233-5-CFSworks@gmail.com>
 <ed4b6913-f19b-4280-b3b2-f5bb1e7f47eb@kwiboo.se> <CAH5Ym4jEMvBVQNNS6U49RWTAVPX4GmOVC-VjgXsFCR=X68QWgA@mail.gmail.com>
 <8c0b8145-3e90-42e6-8e1a-5be6424d1055@kwiboo.se>
In-Reply-To: <8c0b8145-3e90-42e6-8e1a-5be6424d1055@kwiboo.se>
From: Sam Edwards <cfsworks@gmail.com>
Date: Thu, 12 Sep 2024 16:20:01 -0700
Message-ID: <CAH5Ym4hPGNgczG5TzYPqUHPE7Dsb2Kwyc9VJkoanMj=3AGZWVg@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: rockchip: Enable all 3 USBs on Turing RK1
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ondrej Jirman <megi@xff.cz>, 
	Chris Morgan <macromorgan@hotmail.com>, Alex Zhao <zzc@rock-chips.com>, 
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Jing Luo <jing@jing.rocks>, 
	Kever Yang <kever.yang@rock-chips.com>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Daniel_Kukie=C5=82a?= <daniel@kukiela.pl>, 
	Joshua Riek <jjriek@verizon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 3:35=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> On 2024-09-12 23:06, Sam Edwards wrote:
> > On Thu, Sep 12, 2024 at 12:53=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se=
> wrote:
> >>
> >> Hi Sam,
> >>
> >> Sounds like this may be missing
> >>
> >>         rockchip,dp-lane-mux =3D <0 1 2 3>;
> >>
> >> or
> >>
> >>         rockchip,dp-lane-mux =3D <3 2 1 0>;
>
> Small correction, the second 4-lane mode would be described as:
>
>         rockchip,dp-lane-mux =3D <2 3 0 1>;
>
> >>
> >> if all lanes are used for DP and none are used for USB.
> >>
> >> It should help describe the hw and also help the driver set mode to
> >> UDPHY_MODE_DP and that should disable the u3 port, or there may be an
> >> issue to fix in the phy driver.
> >
> > Thanks for your insights Jonas!
> >
> > I haven't yet gotten to DP enablement so I don't know the correct DP
> > layout. Ultimately I do want the USBDP0 node to have the necessary
> > properties for DP, but alas that's a patch for another day.
> >
> > Nonetheless, I briefly tried it and I don't think UDPHY_MODE_DP
> > affects the PHY's "backend" (ctrl<->phy iface) at all, only the
> > availability of frontend lanes to the USB-specific backend: So port u3
> > is still enabled, there's just no way to reach it electrically.
> >
> > With that in mind, would you recommend that I add a placeholder
> > dp-lane-mux of 0 1 2 3 for now, just to keep the PHY from attempting
> > to speak USB to a DP device? I don't foresee any harm in leaving it
> > as-is but you may know something that I don't.
>
> The rk_udphy_u3_port_disable() call in usbdp phy driver should help set
> the usb3otg0_host_num_u3_port=3D0 you mentioned:
>
>   .usb3otg0_cfg =3D RK_UDPHY_GEN_GRF_REG(0x001c, 15, 0, 0x1100, 0x0188),
>   .usb3otg1_cfg =3D RK_UDPHY_GEN_GRF_REG(0x0034, 15, 0, 0x1100, 0x0188),
>
> Here the disable/enable values is little bit inverted in macro, i.e.
> enable=3D0x0188 is the value set when u3_port_disable(disable=3Dtrue) is
> called.

Aha, I didn't notice that the PHY driver had this, thanks for pointing
it out! Yes, it's good that it's also switching the clock source and
disabling PHY status signals so I should definitely be relying on this
code for now.

>
> Guessing that because the phy is not referenced its init() ops never
> gets called and u3 never gets disabled unless a usb3-phy is referenced.
>
> >
> >>
> >>> +     status =3D "okay";
> >>> +};
> >>> +
> >>> +&usb_host0_xhci {
> >>> +     extcon =3D <&u2phy0>;
> >>> +     maximum-speed =3D "high-speed";
> >>
> >> If this only use the USB2 phy, this should probably also override the
> >> default phys and phy-names props with:
> >>
> >>         phys =3D <&u2phy0_otg>;
> >>         phy-names =3D "usb2-phy";
> >
> > I agree completely: if the controller doesn't need the USB3 PHY, then
> > it should not (implicitly) be specified in the DT. Being able to add
> > these overrides is a big goal of mine as well. :)
> >
> > Sadly, `phys` is what initializes USBDP's USB-side backend, so without
> > it the RX_STATUS line goes floating, and because the controller still
> > expects a port there, it misbehaves:
> > [   30.981076] usb usb2-port1: connect-debounce failed
> >
> > I can tell the controller that there is no u3 port by doing this in U-B=
oot:
> > =3D> mw.l 0xfd5ac01c 0xf0000000 # usb3otg0_host_num_u3_port=3D0
> > =3D> boot
> > ...and that makes single-PHY operation work perfectly! But unless
> > Linux itself effects that change, this patch can't rely on that GRF
> > being set correctly.
> >
> > Do you have a recommendation on how I might go about disabling this
> > port? I sent a patchset last year [1] that had the DWC3/xHCI driver
> > ignore enumerated u3 ports when the maximum-speed was set to
> > high-speed, but the consensus seems to be that this shouldn't be
> > addressed at the xHCI driver level, so somehow zeroing the necessary
> > GRF bits sounds like the way to go here. What do you think?
>
> Not sure if it would help but could be that part of init() ops should be
> moved to probe(). Would still require the phy driver to probe before usb
> controller for that to help/work.
>
> Adding a rockchip,dp-lane-mux prop and keeping the phys prop as-is is
> probably easiest way for now.

Continuing my comments above: I agree fully. My v2 will add a
placeholder dp-lane-mux.

Maintainers: I will be sending a v2 of this patch separately in the
future; please consider this patch withdrawn from the series.

> One option for future could possible be to have grf driver disable u3
> and modify usbdp phy driver to enable u3 instead of disable u3, not
> sure this will fully work, init of the usbdp phy seem very sensitive
> and possible a one-time op. Trying to "usb start" in U-Boot will only
> work one time, using "usb reset" or a "usb stop/start" cycle will cause
> usbdp phy init to fail and a full board reset is needed to get port
> working again.

Arguably, it doesn't make sense for the USBDP driver to be affecting
these GRFs at all, because *technically* they're configuration signals
fed into the DWC3: therefore whatever driver binds to
"rockchip,rk3588-dwc3" ought to be setting them according to the PHYs
it discovers in the DT. I suspect that this code was only put in the
PHY driver because that's a more convenient place to put
Rockchip-specific management code for the time being.

Of course, this is all a discussion to be had in a different thread.
For now, suffice to say, I agree with your thoughts about the USB3OTGn
GRF management situation needing improvement and am interested in
lending a hand wherever I can. :)

Thank you for your insights,
Sam

>
> Regards,
> Jonas
>
> >
> > Kind regards,
> > Sam
> >
> > [1]: https://lore.kernel.org/all/20231208210458.912776-1-CFSworks@gmail=
.com/
>

