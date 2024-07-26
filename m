Return-Path: <linux-kernel+bounces-263430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 309EF93D5BA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537481C233B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2668F178CC8;
	Fri, 26 Jul 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nyh412+n"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823D41EA6F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006714; cv=none; b=s4S+F9Ly4i6/RGiRt3yLp0hyPQYOtNWIRkdDhBa7fJkLO38nszzVxRPmIEfPb3Dkdq1mBIpKo1A0oYVCO3UdWwnBUdF5ApyYPdJvdURdAh1T+gj30dP++9dv1VQ5JK+8DoncF30UiGTTh2rfG2dApNv0VBTFuljVOENeGchNX+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006714; c=relaxed/simple;
	bh=BsWFGdAF7XBzX8e4+jMwcTSNvr7Iw0hfVJ1CYXwe8I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOeX13Eq9ODcdrqUy7YyS1hMX3bk6p0zAfdhhZKumwhW+Ncsf32+HkR2YB7Y80L3/1cHZaQShfZf600IRQBEd8ZrG1prT1XJEN4CR+fAZC0cxbRV1TDNmqWoXOSDzUYSZibgZviSt2NoxwSycdAcU9EsQaA7g5dXi14zaUtOGBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nyh412+n; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso20339051fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722006711; x=1722611511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTcHH2j+s1hb1mCfRdNcGdP6fILWYb3lLn9HYz/KlSw=;
        b=Nyh412+n6gF70nrK4XSUxrLZS26sL1OEoBywq4LlGAsQP2bvM4aZltRS4crGz17Geu
         TzgeC7D9+NG2ZfCkCWmYREyv9M9Q4cPqJYTpM7PjnTHr/mNhJrL4Q5239QYrZvC49I8T
         qkqV/i/QjYlVXsyDV71y/fi0Gq8ZKCGeknk0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722006711; x=1722611511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTcHH2j+s1hb1mCfRdNcGdP6fILWYb3lLn9HYz/KlSw=;
        b=AMKf9Y5legrG+DUTLNezppQjCf2HhU34kUnd3RMDUUIRZKlbEfxwdbw0hggP7AtJoK
         mroJYLt+7L6mfSR0Fz4+orrzYJcTXtfKOP4saJ7vG0WMuv9qRmD9EeqoNvQB8ghq98AH
         teJ0vsIfG0ICtGyKsR4++9bSsX1yFM7B+eL/6TS1CDM/6rgtqfq4zkPcW1qTcllvTvy0
         w7ejAzW4p0wdTaiS6I1z4Pbr87whEqxogMleQuL6Bje6UGdgt8VSjfd1UgGhSpv6xw0Q
         I48w07JAoP0c8dXgnvPekvXgKyn3NVDWMGXZDdT9pd9DxJRqz94mxxwvuTItDlP65YT7
         5IqA==
X-Forwarded-Encrypted: i=1; AJvYcCVLzM8zBibuS3h6ntXXvLZHdN8WRlxnU7ea426bg7oYxawPfHO8l0vmxYi54sdRfQIUqwCJNhyKAz5jqIH7rFTJTClE0rbW2yWqnBOl
X-Gm-Message-State: AOJu0Yz87ioLdTeBx792SNguZO52gFgI1HLzU2I4vFjmGArcHChuzcLl
	QXgJiI2yxQnoVQW+JpEruvMGjfoUDFGHptNfPMST5k22c4sYbdmn0yWlab4P5Erds39TwHcXM0U
	MfUgjjBVc6b9VnZ5eV8w2zlQC5egMgLTTszmv
X-Google-Smtp-Source: AGHT+IHDVcZ7KXLOAKMLyDwEWrD5j4fRyegkq6cGnhaUP9u+zy4o58+lxAm64v2kyV8TtF07McmVZ2yCfIFULN1rXkc=
X-Received: by 2002:a2e:9786:0:b0:2ef:324f:c907 with SMTP id
 38308e7fff4ca-2f03db562c7mr51360951fa.5.1722006710402; Fri, 26 Jul 2024
 08:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722-usb-1129-probe-pci-clk-fix-v1-1-99ea804228b6@collabora.com>
 <CAGXv+5H_pxR18sHeqdWPy9_FARrnLwyyOHV4VXCn9p5OExseiQ@mail.gmail.com> <f12ba385-090b-4772-8c52-e515e25b00ac@collabora.com>
In-Reply-To: <f12ba385-090b-4772-8c52-e515e25b00ac@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 26 Jul 2024 23:11:37 +0800
Message-ID: <CAGXv+5G92=-k5MDH4BPcM8tgPwcGTJ60trJwr7BwTGHD=wpnDw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Add missing clock for xhci1 controller
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 8:11=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 25/07/24 12:34, Chen-Yu Tsai ha scritto:
> > Hi,
> >
> > On Mon, Jul 22, 2024 at 11:27=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> >>
> >> Currently if the xhci1 controller happens to probe before the pcie1
> >> controller then it fails with the following errors:
> >>
> >> xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
> >> xhci-mtk 11290000.usb: can't setup: -110
> >> xhci-mtk: probe of 11290000.usb failed with error -110
> >>
> >> The issue has been tracked down to the CLK_INFRA_AO_PCIE_P1_TL_96M
> >> clock, although exactly why this pcie clock is needed for the usb
> >> controller is still unknown. Add the clock to the xhci1 controller so =
it
> >> always probes successfully and use a placeholder clock name for it.
> >>
> >> Reported-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com> #Ke=
rnelCI
> >> Closes: https://lore.kernel.org/all/9fce9838-ef87-4d1b-b3df-63e1ddb0ec=
51@notapiano/
> >> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> >
> > So I asked MediaTek about this, and it seems the correct thing to do is
> > disable USB 3 on this host controller using the following snippet. The
> > snippet is copy-pasted from our issue tracker and won't apply directly.
> >
> > This is also seen in mt8395-kontron-3-5-sbc-i1200.dts, on which xhci1
> > is used only for USB 2.0 on an M.2 slot.
> >
>
> Uhm, okay, but why should USB3 be disabled on a controller that supports =
USB3?
>
> I agree about disabling it on specific boards that use only the USB 2.0 l=
ines of
> this controller, but doing that globally looks wrong... and looks like be=
ing a
> workaround for an error that gets solved with adding a clock as well.
>
> In short, the question is: why would that be the correct thing to do?

We can disable it in mt8195-cherry.dtsi then?

ChenYu

> Cheers,
> Angelo
>
> >
> > ChenYu
> >
> > index 8b7307cdefc6..2dac9f706a58
> > --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> > @@ -1447,6 +1447,7 @@
> >                                        "xhci_ck";
> >                          mediatek,syscon-wakeup =3D <&pericfg 0x400 104=
>;
> >                          wakeup-source;
> > +                       mediatek,u3p-dis-msk =3D <0x1>;
> >                          status =3D "disabled";
> >                  };
> >
> >> ---
> >>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 10 ++++++++--
> >>   1 file changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boo=
t/dts/mediatek/mt8195.dtsi
> >> index 2ee45752583c..cc5169871f1c 100644
> >> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> >> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> >> @@ -1453,9 +1453,15 @@ xhci1: usb@11290000 {
> >>                                   <&topckgen CLK_TOP_SSUSB_P1_REF>,
> >>                                   <&apmixedsys CLK_APMIXED_USB1PLL>,
> >>                                   <&clk26m>,
> >> -                                <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHC=
I>;
> >> +                                <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHC=
I>,
> >> +                                /*
> >> +                                 * This clock is required due to a ha=
rdware
> >> +                                 * bug. The 'frmcnt_ck' clock name is=
 used as a
> >> +                                 * placeholder.
> >> +                                 */
> >> +                                <&infracfg_ao CLK_INFRA_AO_PCIE_P1_TL=
_96M>;
> >>                          clock-names =3D "sys_ck", "ref_ck", "mcu_ck",=
 "dma_ck",
> >> -                                     "xhci_ck";
> >> +                                     "xhci_ck", "frmcnt_ck";
> >>                          mediatek,syscon-wakeup =3D <&pericfg 0x400 10=
4>;
> >>                          wakeup-source;
> >>                          status =3D "disabled";
> >>
> >> ---
> >> base-commit: dee7f101b64219f512bb2f842227bd04c14efe30
> >> change-id: 20240722-usb-1129-probe-pci-clk-fix-ef8646f46aac
> >>
> >> Best regards,
> >> --
> >> N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> >>
> >>
>
>
>

