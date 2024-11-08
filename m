Return-Path: <linux-kernel+bounces-401040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B219C154F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B1D1C22AA6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E601C578E;
	Fri,  8 Nov 2024 04:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tvp6AT5v"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FA31946DF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 04:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731039162; cv=none; b=uVw/XgCSmEfvcg5O5PwIRpnunSidx22f0Ofva5Q+fgM53j0qVgwb7yrnwPUwohat9BF/tp/v8Ax1R9As7SGKHfH0Tn+YWHRAnb7yxy23dj+oT/ZvczvKefWmnsNs0kd8ngLNoZTVA9zyQ7ZmCxbJh53rgZgHV+jlOvAHXl6r7RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731039162; c=relaxed/simple;
	bh=Ig8OfnRGbLlZcoupOSdoVbW4aN+FUi8kSSPgFc3gUdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVY6Z2Cg1ZpvWRfAna43u9X7dCaJsV0fjSsnDuXFNHXe0xImt51lReeyMX2WwEd8A1OT3w+eIskg6jUj/WKlDyooKuPsJ5OaZaydWqGIs1Y0LnyEdjaEUys1Lx/ELTbb33c0W4fuJ9bm1rFdZB/SQLlTIxLpuIseinKP+rqkOD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Tvp6AT5v; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-84fd764f6ddso1317129241.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 20:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731039159; x=1731643959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQMqtLphVcnPY0+PnZHagIpPa7d9fieRvTBwtPiHmJ8=;
        b=Tvp6AT5vfoNhWmUUUz8aahXf1g5CGMWlPmBGrNfcJEST3OVwMF5F4cxNO/IYvj+Ioj
         3yOOnWvhrqVWfK4yJJiDSJeQr3YdO+x1dnl/ymnBvRk+b8BKYakcF1RmomnyIc5SEo2O
         Lb3fkubreWsEY8WdvCnA3zNVMvuJsP02lOd/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731039159; x=1731643959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQMqtLphVcnPY0+PnZHagIpPa7d9fieRvTBwtPiHmJ8=;
        b=mxiPamS2BDBSeql8MBQ93NL9/AfJliH/o/Gs/EoZMEinhdOsmLIHZkc8jHfZguIf3Y
         LCwRHLImmAaAHGo1jHV0rgaIc4y4wt+Zc19N7fRiEfwxelEfwimV68kC2ZXtIC1kqNpU
         6F08Gczsu+ROhIWNpyAWbesbKnbcHbh7zXBOb+E53JPIIvkcSozT/qTFbARMETlgnznw
         E0R5psVfdRCCsel7/gLqDr1JVtYCAyRO+TbRqT9MPPAc3PqBoVtmLPkXBgWxA2dctaT+
         +ggfXnMVTBDjEBmXx98wP/PUCEJTKB1yGpZuSGKVODPvNHopwjwn7cHu6cg/qW6N+q+o
         0vNw==
X-Forwarded-Encrypted: i=1; AJvYcCUbVOLFQEE9YSgNupznol+05ofI7cwJWerDAV4Yz9Osd7einLk/JL4z4xh4UGSAnuVUrGp0bTQdnyW/20c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbXspJXpBkI5m7ulziIgO/FBCxEgxv03cD5Er45Q7l8q5Z8wtP
	EMDJAswi6+pUYa7bYVWc30jgBRdTiManUBVr/weKobtlrsNoi2uvvrhP5k0DRPipDpr8w4l1jYk
	=
X-Google-Smtp-Source: AGHT+IED2eVz+OAW8h9e4/+VIkklkaEQgPojF3myKcWwdKm53TpKvbOgfjTVD9ol0C7ggieONkFIrw==
X-Received: by 2002:a05:6102:418c:b0:4a9:15c:f02 with SMTP id ada2fe7eead31-4aae22be05dmr1251636137.11.1731039158752;
        Thu, 07 Nov 2024 20:12:38 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4aa9f01e74bsm473810137.31.2024.11.07.20.12.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 20:12:34 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-84fd764f6ddso1317076241.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 20:12:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSw+meJg8eDpfGY44i+bJIhe9Em1Jv1aLnC46yC8lntGvX5DYGq2miWUjqeeTH2wTXvTzQCkI7zNEuJsQ=@vger.kernel.org
X-Received: by 2002:a67:ad07:0:b0:4a5:b1f5:ba93 with SMTP id
 ada2fe7eead31-4aadfdcbb33mr2266607137.6.1731039153643; Thu, 07 Nov 2024
 20:12:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105093222.4055774-1-fshao@chromium.org> <20241105093222.4055774-3-fshao@chromium.org>
 <b66dbf9e-b35b-482c-9eb7-112ef1f398d6@collabora.com> <CAC=S1ngozo11g1vF2jnHjTLcNmP8tOMsQhK+LR0QWqoeXwSJjg@mail.gmail.com>
 <59f4bcc1-c752-4f2f-8e55-349cc2432b8a@collabora.com>
In-Reply-To: <59f4bcc1-c752-4f2f-8e55-349cc2432b8a@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 8 Nov 2024 12:11:57 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhhfwHU5K5ZyUhZBhvz38LOZGLnGN-Rc1ZAup_VTfkpvA@mail.gmail.com>
Message-ID: <CAC=S1nhhfwHU5K5ZyUhZBhvz38LOZGLnGN-Rc1ZAup_VTfkpvA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: Introduce MT8188 Geralt
 platform based Ciri
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 6:37=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 07/11/24 07:58, Fei Shao ha scritto:
> > On Wed, Nov 6, 2024 at 9:19=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Il 05/11/24 10:30, Fei Shao ha scritto:
> >>> Introduce MT8188-based Chromebook Ciri, also known commercially as
> >>> Lenovo Chromebook Duet (11", 9).
> >>>
> >>> Ciri is a detachable device based on the Geralt design, where Geralt =
is
> >>> the codename for the MT8188 platform. Ciri offers 8 SKUs to accommoda=
te
> >>> different combinations of second-source components, including:
> >>> - audio codecs (RT5682S and ES8326)
> >>> - speaker amps (TAS2563 and MAX98390)
> >>> - MIPI-DSI panels (BOE nv110wum-l60 and IVO t109nw41)
> >>>
> >>> Signed-off-by: Fei Shao <fshao@chromium.org>
> >>> ---
> >>>
> >>> Changes in v2:
> >>> - remove invalid or undocumented properties
> >>>       e.g. mediatek,dai-link, maxim,dsm_param_name etc.
> >>> - remove touchscreen as the driver is not yet accepted in upstream
> >>> - update sound DAI link node name to match the binding
> >>> - add missing pinctrls in audio codec nodes
> >>>
> >>>    arch/arm64/boot/dts/mediatek/Makefile         |    8 +
> >>>    .../dts/mediatek/mt8188-geralt-ciri-sku0.dts  |   11 +
> >>>    .../dts/mediatek/mt8188-geralt-ciri-sku1.dts  |   60 +
> >>>    .../dts/mediatek/mt8188-geralt-ciri-sku2.dts  |   56 +
> >>>    .../dts/mediatek/mt8188-geralt-ciri-sku3.dts  |   15 +
> >>>    .../dts/mediatek/mt8188-geralt-ciri-sku4.dts  |   43 +
> >>>    .../dts/mediatek/mt8188-geralt-ciri-sku5.dts  |   73 +
> >>>    .../dts/mediatek/mt8188-geralt-ciri-sku6.dts  |   69 +
> >>>    .../dts/mediatek/mt8188-geralt-ciri-sku7.dts  |   47 +
> >>>    .../boot/dts/mediatek/mt8188-geralt-ciri.dtsi |  397 +++++
> >>>    .../boot/dts/mediatek/mt8188-geralt.dtsi      | 1492 +++++++++++++=
++++
> >>>    11 files changed, 2271 insertions(+)
> >>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri=
-sku0.dts
> >>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri=
-sku1.dts
> >>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri=
-sku2.dts
> >>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri=
-sku3.dts
> >>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri=
-sku4.dts
> >>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri=
-sku5.dts
> >>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri=
-sku6.dts
> >>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri=
-sku7.dts
> >>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri=
.dtsi
> >>>    create mode 100644 arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> >>>
> > [...]
> >
>
> [...]
>
> >>> +&pmic {
> >>> +     interrupts-extended =3D <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
> >>> +};
> >>> +
> >>> +&scp {
> >>
> >> Is this SCP-dual or SCP?
> >> I see SCP, but I also see a SCP-Dual memory region... what's going on =
here?
> >>
> >> Of course, the SCP-Dual won't work if you don't override the compatibl=
e string...
> >
> > To clarify, the second SCP core is used for MIPI camera in downstream,
> > and I deliberately only describe the first SCP core here since the MTK
> > camera ISP driver isn't in upstream at the moment.
> > I had a fixup patch for removing the scp-dual reserved memory region,
> > but likely it was missing during the rebase... let me check again if
> > it can be removed, just in case there's firmware protecting the region
> > and the kernel shouldn't access it.
> >
>
> Hmm... but the second SCP core can still be brought up, even if the MIPI =
Camera
> driver is not upstreamed yet, right?

Well, that's true... and it should pave the way for validating the
driver with the upstreamed DT whenever that becomes available.

>
> That shouldn't cause lockups and/or other kinds of bad behavior, and shou=
ld
> bring up a core and just never use it, without any particular issues.
>
> If we can enable the secondary core, let's just go for it.. as that will =
help
> specifying the exact memory layout of this board (and failing to do that =
may
> create some other issues, that's why I'm proposing to enable that even if=
 it
> is not really used in this case).
>
> What do you think? :-)
>

Sure, that sounds good to me, too.
I started only with the essential DT bits to ensure the device can
boot, which it does, so I guess it's time to bring that back. I'll
incorporate that in v3.
I plan to fix up the single SCP core node to SCP-dual directly, so
please let me know if you prefer seeing that as an individual patch on
top (either option works for me).

Regards,
Fei


> >>
> >>> +     firmware-name =3D "mediatek/mt8188/scp.img";
> >>> +     memory-region =3D <&scp_mem>;
> >>> +     pinctrl-names =3D "default";
> >>> +     pinctrl-0 =3D <&scp_pins>;
> >>> +     status =3D "okay";
> >>> +
> >>> +     cros-ec-rpmsg {
> >>> +             compatible =3D "google,cros-ec-rpmsg";
> >>> +             mediatek,rpmsg-name =3D "cros-ec-rpmsg";
> >>> +     };
> >>> +};
> >>> +
> >>> +&sound {
> >>> +     compatible =3D "mediatek,mt8188-nau8825";
> >>> +     model =3D "mt8188_m98390_8825";
> >>> +     pinctrl-names =3D "aud_etdm_hp_on",
> >>> +                     "aud_etdm_hp_off",
> >>> +                     "aud_etdm_spk_on",
> >>> +                     "aud_etdm_spk_off",
> >>> +                     "aud_mtkaif_on",
> >>> +                     "aud_mtkaif_off";
> >>
> >>          pinctrl-names =3D "aud_etdm_hp_on", "aud_etdm_hp_off",
> >>                          "aud_etdm_spk_on", "aud_etdm_spk_off",
> >>                          "aud_mtkaif_on", "aud_mtkaif_off";
> >
> > Acked.
> >
> >>
> >>> +     pinctrl-0 =3D <&aud_etdm_hp_on>;
> >>> +     pinctrl-1 =3D <&aud_etdm_hp_off>;
> >>> +     pinctrl-2 =3D <&aud_etdm_spk_on>;
> >>> +     pinctrl-3 =3D <&aud_etdm_spk_off>;
> >>> +     pinctrl-4 =3D <&aud_mtkaif_on>;
> >>> +     pinctrl-5 =3D <&aud_mtkaif_off>;
> >>
> >> Add a comment:
> >>
> >>          /* The audio-routing is defined in each board dts */
> >>
> >>> +     audio-routing =3D "ETDM1_OUT", "ETDM_SPK_PIN",
> >>> +                     "ETDM2_OUT", "ETDM_HP_PIN",
> >>> +                     "ETDM1_IN", "ETDM_SPK_PIN",
> >>> +                     "ETDM2_IN", "ETDM_HP_PIN",
> >>> +                     "ADDA Capture", "MTKAIF_PIN",
> >>> +                     "Headphone Jack", "HPOL",
> >>> +                     "Headphone Jack", "HPOR",
> >>> +                     "MIC", "Headset Mic",
> >>> +                     "Left Spk", "Front Left BE_OUT",
> >>> +                     "Right Spk", "Front Right BE_OUT",
> >>> +                     "Rear Left Spk", "Rear Left BE_OUT",
> >>> +                     "Rear Right Spk", "Rear Right BE_OUT";
> >>> +
> >>
> >> ...and remove the audio-routing from this dtsi; it's anyway being
> >> overridden by the -ciri.dtsi devicetree...
> >
> > Acknowledged, and thanks for all the feedback here.
> >
>
> You're welcome :-)
>
> Cheers,
> Angelo
>

