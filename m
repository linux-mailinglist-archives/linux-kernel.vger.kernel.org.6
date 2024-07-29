Return-Path: <linux-kernel+bounces-265581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F280893F31A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E3B2828C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF37144317;
	Mon, 29 Jul 2024 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hkSvOSS6"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF53A28399
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250102; cv=none; b=EA0F3NX1tq1ewOjSOdq/7Bgl4MLFo3pVxTy4Es8rd9yVgASlIRUka89cdU+2t2wq6GK0brMp/8wfh+8uHMwzYyeMegmJbwr+NkqKWUpaZIyz61kfwNMPvOenhBq1yBMTXeuC3eKPCDqoKF7FBQGrrYRei+srVGUTTEXnh0iWR7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250102; c=relaxed/simple;
	bh=Y04ZSsuADx2XPQblfooyYup6wOTxDR++qyXR+aRSDQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZjrRz1709umRj7wyujUK6xdfebC4DlKiI7JVqlSUI2nXBB9jzMBLz8hqRBVmO/LPr01bXEz2ASkbCfgF8i5E8QiByfzr5xU4bXibduaJSGqtLgqijQZC3GQ53LpsWj2WrTM7oWc0/YDW4EfnXxhDrTRTWXrQ7ULcUmVCH7WZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hkSvOSS6; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52f042c15e3so3054447e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 03:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722250098; x=1722854898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/0x59CX402n1FHBQk1SZQEtizSNWtGdnpBxqm2a6U8=;
        b=hkSvOSS6XZcQwz0sSH/syJp9riJyvYbuSPeJCRwXtbgxM3ZsUDx6m0B6r1R37FSlMD
         g09vmxPVH57S7wE4epDH6hXgrdcAQrMtdIOwwjc8qvB3GPXvfyLEVfBPlTZ9H2I+tbP/
         b62Jm367Jg2H0uFegMBTBAViEp7VfyPZC8Dfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722250098; x=1722854898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/0x59CX402n1FHBQk1SZQEtizSNWtGdnpBxqm2a6U8=;
        b=nlAIEfcSZ5k9TuzKFxQVuZUhy+M1vxJEjRcukHt0sg/tEGhL3XfCw5MAtHhvf+TJlX
         meqjP5smj05Chtr4QqTy97odQaQE7ErLevNX5yLrpNhoK7x6ZdD5HRxArRtCHrCl0loo
         qYla5RiWaTFM7RbjpIrf2hOzlNZ8JEZ1YxdMIkKmnHf+gicE+Pow4eQ0R1q1yLxbJ/nA
         bUbdmeNK+bm7MPGgMeoEnYYyKXVujMlZbz/IXL0Y5pEpcVcPgSsj4Cu0Cu8zfoLe3by5
         Iil9AeQtybbcVqzlwSmoWjhy/GOyLlXO1rQ2e28mJYR+qg5CdZOHhqfZzUqQiGd6sSMz
         fcrA==
X-Forwarded-Encrypted: i=1; AJvYcCWbOtDhrdxx2MEocYQmumSE/KL784w7BtqZLztfUtTGseR90UI8Kmzggzx5aQ2pgDy/xKWmlnpW9y6P+5wQxxyq1gYhj98RHkHTDU8y
X-Gm-Message-State: AOJu0Yy8rbj2DjplK0+FCPrLSWwHZlfRv1DPROhsAbYMuyprWyNBh0Rl
	OU8jsk627aEX6nvwpKuX5r8rjofr6T8jcpOxKko5awcM0oSc9PcqsIhMrMYqtpqlS8c1OcrjH7x
	tq0pV79JBrpID5TK+FKrL2tpXs00KognJIHI8
X-Google-Smtp-Source: AGHT+IHB5y8Efven0rM7568H5Q/7IIX0B75sAgumyMxO9pLVe7LTrTw+hIQBfTXynQiq2pmvum8YwhTKmZ6h1vTdBSA=
X-Received: by 2002:a05:6512:4002:b0:52f:36a:f929 with SMTP id
 2adb3069b0e04-5309b6d2e9amr1967665e87.4.1722250097727; Mon, 29 Jul 2024
 03:48:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722-usb-1129-probe-pci-clk-fix-v1-1-99ea804228b6@collabora.com>
 <CAGXv+5H_pxR18sHeqdWPy9_FARrnLwyyOHV4VXCn9p5OExseiQ@mail.gmail.com>
 <f12ba385-090b-4772-8c52-e515e25b00ac@collabora.com> <CAGXv+5G92=-k5MDH4BPcM8tgPwcGTJ60trJwr7BwTGHD=wpnDw@mail.gmail.com>
 <51f0f4f3-11a5-4d74-981e-3f24f8475c7f@collabora.com> <CAGXv+5F-U6O3dQdU2L8bR5V+D=PLreACZYCh5sxBY3PFrex1zg@mail.gmail.com>
 <de0b0daa-2a35-4286-b4db-4f646073a04c@collabora.com>
In-Reply-To: <de0b0daa-2a35-4286-b4db-4f646073a04c@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 29 Jul 2024 18:48:05 +0800
Message-ID: <CAGXv+5EvzRr8h5vnuV2h=zkVwkVp3fShDP_45BpaO0HkivuDtQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Add missing clock for xhci1 controller
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 4:54=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 29/07/24 10:07, Chen-Yu Tsai ha scritto:
> > On Mon, Jul 29, 2024 at 3:59=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 26/07/24 17:11, Chen-Yu Tsai ha scritto:
> >>> On Fri, Jul 26, 2024 at 8:11=E2=80=AFPM AngeloGioacchino Del Regno
> >>> <angelogioacchino.delregno@collabora.com> wrote:
> >>>>
> >>>> Il 25/07/24 12:34, Chen-Yu Tsai ha scritto:
> >>>>> Hi,
> >>>>>
> >>>>> On Mon, Jul 22, 2024 at 11:27=E2=80=AFPM N=C3=ADcolas F. R. A. Prad=
o
> >>>>> <nfraprado@collabora.com> wrote:
> >>>>>>
> >>>>>> Currently if the xhci1 controller happens to probe before the pcie=
1
> >>>>>> controller then it fails with the following errors:
> >>>>>>
> >>>>>> xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
> >>>>>> xhci-mtk 11290000.usb: can't setup: -110
> >>>>>> xhci-mtk: probe of 11290000.usb failed with error -110
> >>>>>>
> >>>>>> The issue has been tracked down to the CLK_INFRA_AO_PCIE_P1_TL_96M
> >>>>>> clock, although exactly why this pcie clock is needed for the usb
> >>>>>> controller is still unknown. Add the clock to the xhci1 controller=
 so it
> >>>>>> always probes successfully and use a placeholder clock name for it=
.
> >>>>>>
> >>>>>> Reported-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>=
 #KernelCI
> >>>>>> Closes: https://lore.kernel.org/all/9fce9838-ef87-4d1b-b3df-63e1dd=
b0ec51@notapiano/
> >>>>>> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.co=
m>
> >>>>>
> >>>>> So I asked MediaTek about this, and it seems the correct thing to d=
o is
> >>>>> disable USB 3 on this host controller using the following snippet. =
The
> >>>>> snippet is copy-pasted from our issue tracker and won't apply direc=
tly.
> >>>>>
> >>>>> This is also seen in mt8395-kontron-3-5-sbc-i1200.dts, on which xhc=
i1
> >>>>> is used only for USB 2.0 on an M.2 slot.
> >>>>>
> >>>>
> >>>> Uhm, okay, but why should USB3 be disabled on a controller that supp=
orts USB3?
> >>>>
> >>>> I agree about disabling it on specific boards that use only the USB =
2.0 lines of
> >>>> this controller, but doing that globally looks wrong... and looks li=
ke being a
> >>>> workaround for an error that gets solved with adding a clock as well=
.
> >>>>
> >>>> In short, the question is: why would that be the correct thing to do=
?
> >>>
> >>> We can disable it in mt8195-cherry.dtsi then?
> >>
> >> That device does not use this controller, so yes we can disable it, bu=
t that still
> >> doesn't resolve the issue pointed out by Nicolas...!
> >
> > No. I mean disable USB3 on this port. Also see the next paragraph.
> >
>
> Yes, sorry I was meaning the same - but I effectively wrote "disable cont=
roller"
> instead, my bad.
>
> >> Please note that the issue that he sees doesn't happen only on Tomato,=
 but also on
> >> other MediaTek MT8195/MT8395 boards - and applying this commit makes d=
isabling the
> >> controller, or disabling the USB 3 lines on the controller, kinda redu=
ndant, as
> >> this will effectively fix probing it... but again, fixing the actual i=
ssue with
> >> this controller is something that must be done.
> >
> > If those other boards use the XHCI1 USB3 lines for ... USB3, then the U=
SB3
> > PHY should also be tied to XHCI1, right now due to the Cherry Chromeboo=
k
> > design, only the USB2 PHY is tied to it.
> >
>
> Yes, I am aware of that.
>
> >> Disabling the controller on Tomato is a different topic - here we are =
discussing
> >> about fixing the issue, and that will happen, again, on any board that=
 has this
> >> controller enabled with USB3 lines. :-)
> >>
> >> So, unless there is any specific reason for which applying this commit=
 is a bad
> >> idea, or any alternative fix to this that is better than the proposed =
one, and
> >> not a workaround... I'm applying this one.
> >
> > Didn't I just relay what MediaTek says is the correct fix? Disable USB3
> > for this port on devices where the serial pairs are used for PCIe inste=
ad
> > of USB3.
> >
>
> I think there must've been some misunderstanding here.
>
> Yes you did relay what MediaTek is the correct fix, and I agree that the =
USB3 must
> be disabled on devices where those serial pairs are used for PCIe instead=
 of USB,
> or on devices where those are completely unused.

OK. I will send a patch for Tomato as you asked.

> This, though, will fix the issue only on those devices (because we are di=
sabling
> those lines entirely, so depending on how we see it, this might not be a =
fix but
> rather a workaround).

I would say that is a more accurate description of the hardware, so a fix.

> If we don't apply this fix, any board that uses those pairs for USB 3 ins=
tead will
> still show the same "clocks are not stable" error, leaving them with a br=
oken port.
>
> And I believe that because the clocks are not routed externally but rathe=
r are
> internal to the SoC, so, if INFRA_AO_PCIE_P1_TL_96M is necessary for that=
 USB 3
> port to work, a board that intends to use those pairs for USB3 would stil=
l need
> this exact clock to actually get that port to work.

I couldn't reproduce the issue by disabling pcie1 as Nicolas mentioned.
I don't have any more to add to this though. Sorry for the noise.

> As for Tomato itself - I agree that we must add the u3p-dis-msk=3D0x1 fla=
g, yes,
> and we will, but I'm purely talking about - again - an eventual board tha=
t would
> not have that property because USB3 is exposed/used for real.

I think it would make more sense to fix the `phys =3D ` statement in mt8195=
.dtsi
to list both the USB2 and USB3 PHYs. At the board level, for boards only
using USB2, we would have the overriding `phys =3D ` statement alongside th=
e
`mediatek,u3p-dis-mask` property. Does that make sense to you?


Thanks
ChenYu

> Cheers,
> Angelo
>
> >
> > Regards
> > ChenYu
> >
> >> Cheers,
> >> Angelo
> >>
> >>>
> >>> ChenYu
> >>>
> >>>> Cheers,
> >>>> Angelo
> >>>>
> >>>>>
> >>>>> ChenYu
> >>>>>
> >>>>> index 8b7307cdefc6..2dac9f706a58
> >>>>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> >>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> >>>>> @@ -1447,6 +1447,7 @@
> >>>>>                                          "xhci_ck";
> >>>>>                            mediatek,syscon-wakeup =3D <&pericfg 0x4=
00 104>;
> >>>>>                            wakeup-source;
> >>>>> +                       mediatek,u3p-dis-msk =3D <0x1>;
> >>>>>                            status =3D "disabled";
> >>>>>                    };
> >>>>>
> >>>>>> ---
> >>>>>>     arch/arm64/boot/dts/mediatek/mt8195.dtsi | 10 ++++++++--
> >>>>>>     1 file changed, 8 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64=
/boot/dts/mediatek/mt8195.dtsi
> >>>>>> index 2ee45752583c..cc5169871f1c 100644
> >>>>>> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> >>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> >>>>>> @@ -1453,9 +1453,15 @@ xhci1: usb@11290000 {
> >>>>>>                                     <&topckgen CLK_TOP_SSUSB_P1_RE=
F>,
> >>>>>>                                     <&apmixedsys CLK_APMIXED_USB1P=
LL>,
> >>>>>>                                     <&clk26m>,
> >>>>>> -                                <&pericfg_ao CLK_PERI_AO_SSUSB_1P=
_XHCI>;
> >>>>>> +                                <&pericfg_ao CLK_PERI_AO_SSUSB_1P=
_XHCI>,
> >>>>>> +                                /*
> >>>>>> +                                 * This clock is required due to =
a hardware
> >>>>>> +                                 * bug. The 'frmcnt_ck' clock nam=
e is used as a
> >>>>>> +                                 * placeholder.
> >>>>>> +                                 */
> >>>>>> +                                <&infracfg_ao CLK_INFRA_AO_PCIE_P=
1_TL_96M>;
> >>>>>>                            clock-names =3D "sys_ck", "ref_ck", "mc=
u_ck", "dma_ck",
> >>>>>> -                                     "xhci_ck";
> >>>>>> +                                     "xhci_ck", "frmcnt_ck";
> >>>>>>                            mediatek,syscon-wakeup =3D <&pericfg 0x=
400 104>;
> >>>>>>                            wakeup-source;
> >>>>>>                            status =3D "disabled";
> >>>>>>
> >>>>>> ---
> >>>>>> base-commit: dee7f101b64219f512bb2f842227bd04c14efe30
> >>>>>> change-id: 20240722-usb-1129-probe-pci-clk-fix-ef8646f46aac
> >>>>>>
> >>>>>> Best regards,
> >>>>>> --
> >>>>>> N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> >>>>>>
> >>>>>>
> >>>>
> >>>>
> >>>>
> >>
>

