Return-Path: <linux-kernel+bounces-394966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8ED9BB69F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5667C1F22020
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970CE41C72;
	Mon,  4 Nov 2024 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cjO/glj3"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34274382
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728065; cv=none; b=iIx46WdC3gL3eMhO+99wGMw+DQeb3Ei/31Dg7uELY4LhBZ4eW28v89UckXSBQGxlNOrVLUY9bxQKIMWbb4cNZ2Rkmsy7jFEboPVQoMztrTgxRI9VnlXZPmyFcUgi5U2O/yw+GKVp/bxmLO7z0dM82rmgl2psp4eRh373raD4Elo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728065; c=relaxed/simple;
	bh=d2Gs/FJxD1D/1W+hsOvxkmezFCiv8TLZLGxI4DNbMnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfPrUOVenZgLUAxrTkdMDYjkWFcHMnIGLwIaBrOaOLOl1U+LdM4EnQmYAPlSy7rqQcK7srrRjxvABqfFEGN3YAGwraKxEX0Zu12x20YI0RxXK8w9kQV7VeHJ9t6cSojDJhdO1DTKg/ALrXRE8lB0X4GATsro4UVZHp/mlXxwAn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cjO/glj3; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53a097aa3daso3890637e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730728061; x=1731332861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsymmwIGsuVs7v1n+LWpRRRaG0hjIy9yDhaEU8VEsww=;
        b=cjO/glj3+CQKyIhE3JTSgSjFpFJ4D51nAlx3aqY1AoX4OCSkNNyKR8WoQMRQbQZciD
         iA3MgOhG3ZWd0hL/xb0aKnpPDy8AMSvAbpLRxw8aNW35nfqD9q7mzv5jJaAluWvilEu/
         Mk++Paf84NMFwq52MDut49H5TaHh9wyhCSLTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730728061; x=1731332861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsymmwIGsuVs7v1n+LWpRRRaG0hjIy9yDhaEU8VEsww=;
        b=qrqzPQl/e8nHqCS1+18PBTzDSvat941d+bQF5O0cdd+r5RXFmJKCOF+YFFBh8bfTXT
         q5HfDQ/vCiU1ydQaNK+k5wQsML/qwfnytN7vRrw3YBBww3rsdGLDW71U/Uzs66kN/MtU
         jghA4kniHZEjfeJaUCUe6Ucl8jFIjP+FkAF9MxlkyEXHOueFlfrc/YtsnxQ7Xh632i0t
         d2kx2IhbteIBm6B8o42o65Il1Snh6bu4SCFzIfK7C8QXxy2CzBYUvpf2RRx2SR2tydfF
         w6HOTJD1aMQoBrdTAOldOQAcmZ/F4mmSgbk7LLEKJjDUfEXyED2rMgun4+hQvRWosKIy
         UHYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVik27cvhQRvOmclb/8TybLtfHyDfYKBwXsyypmPsAoljrcoxYMjqfwVBlwQ8l2bd2wta/ArypGl4Dddi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz6WGR5baYs9lAX5gGRS9DCdjr+3HpGAlkI9se+ONA/hIwPWpk
	Dnigs1HbJlk+K63XPDNzXXHVPRv5QPPodJHiE2ux3CSDTjRoZl0VpX1kUv94EanDES+0Y2RuABs
	r2S7ZNCsApGrIerdveUFrSU/is/unbzaDWlsb
X-Google-Smtp-Source: AGHT+IG6XUFtsKbcLLl53KOkLywI84S6ITEyyTl9D7WkFTQfnMFACCzmN85bTtyfiBZP6XY2rRglSKd6AWN+dPBO6zo=
X-Received: by 2002:a05:6512:230b:b0:539:9645:97ab with SMTP id
 2adb3069b0e04-53d65dfee01mr4788487e87.33.1730728061055; Mon, 04 Nov 2024
 05:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030070224.1006331-1-wenst@chromium.org> <20241030070224.1006331-2-wenst@chromium.org>
 <CAGXv+5HVy41qee6kwVUeLV_DfA0=wk2X77kv81rBKAZDGE6mww@mail.gmail.com> <bbaa0c8f-9702-4252-a674-e46fb51f0a2a@collabora.com>
In-Reply-To: <bbaa0c8f-9702-4252-a674-e46fb51f0a2a@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 4 Nov 2024 21:47:30 +0800
Message-ID: <CAGXv+5GHP1M1rKwR8j+bN8GmpxWtpkfLTnvBdkg5wOvWanc-kw@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: mediatek: mt8183-kukui-jacuzzi: Drop
 pp3300_panel voltage settings
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 9:19=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 04/11/24 14:00, Chen-Yu Tsai ha scritto:
> > On Wed, Oct 30, 2024 at 3:02=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.or=
g> wrote:
> >>
> >> The pp3300_panel fixed regulator is just a load switch. It does not ha=
ve
> >> any regulating capabilities. Thus having voltage constraints on it is
> >> wrong.
> >>
> >> Remove the voltage constraints.
> >>
> >> Fixes: cabc71b08eb5 ("arm64: dts: mt8183: Add kukui-jacuzzi-damu board=
")
> >> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >
> > I see that the other three patches were merged and included in the pull
> > request, but not this one. Were there any concerns?
> >
>
> Sorry I forgot to actually provide an explanation for that - yes, I do ha=
ve some
> comment about this one.
>
> Despite this being a load switch, it's still switching power from regulat=
or A to
> target device X, so this is technically still providing 3.3V to device X.
>
> Think about how a "regular" full-fledged regulator works: you can (someti=
mes) set
> a voltage, and then you can ENABLE the VOUT for said regulator (/rail): t=
his kind
> of "load switch" does exactly the same as the ENABLE switch for a full-fl=
edged
> regulator.

But it does not provide regulation. One cannot "set" the voltage on a load
switch; one can only set it on its upstream supply, if that supply provides
regulation.

IIRC Mark said some years ago that if a regulator doesn't regulate the
voltage, then the voltage constraints should not be given. The constraints
are then derived from its upstream supply.

That's the guideline I've followed for all the regulator related changes
I've done over the years. Does that work for you?

> So, this is switching on and off a power rail that is derived from a sour=
ce rail,
> practically creating... well, a "new" rail, with...
>
>   VIN=3Dsomewhere-3.3v,
>   VOUT=3Dsomewhere-still-3.3v
>
> Any objections/doubts/etc? :-)

I agree with most of it, except the part that I laid out above about the
load switch not providing regulation.

> P.S.: I'm writing fast, sorry if anything appears unclear, feel free to s=
hoot more
>        questions in case :-)

No, it's pretty clear, and I believe one of the common interpretations
I see. Thank you for the quick response.


Thanks
ChenYu

> Cheers,
> Angelo
>
> >
> > ChenYu
> >
> >> ---
> >>   arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 --
> >>   1 file changed, 2 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/=
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> >> index 783c333107bc..7bbafe926558 100644
> >> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> >> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> >> @@ -35,8 +35,6 @@ pp1800_mipibrdg: pp1800-mipibrdg {
> >>          pp3300_panel: pp3300-panel {
> >>                  compatible =3D "regulator-fixed";
> >>                  regulator-name =3D "pp3300_panel";
> >> -               regulator-min-microvolt =3D <3300000>;
> >> -               regulator-max-microvolt =3D <3300000>;
> >>                  pinctrl-names =3D "default";
> >>                  pinctrl-0 =3D <&pp3300_panel_pins>;
> >>
> >> --
> >> 2.47.0.163.g1226f6d8fa-goog
> >>
>

