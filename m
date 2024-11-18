Return-Path: <linux-kernel+bounces-412421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F619D08D4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85DB9281EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095CA13E02A;
	Mon, 18 Nov 2024 05:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hbt52fG6"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B07913D8A3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731907620; cv=none; b=r7mi7oC9wE5JMSVU3gwa45QtohYCpJoUtkgXKaQPkFF0/n+LpKQo6C2truP5mGyn1z7bcC1nhKLeRhcrGEyn0BsrwLEN9DE/xClplbsWSForKNcMeAAs7q1tS45h6tKzHezLU3Q4VTC5T7vQg++tcIH7dx3yYsb1xISrsEn5wDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731907620; c=relaxed/simple;
	bh=jF19QpNLsWJdKg8cszr94Mt3lwCQCf2zi3FZ0K2NVvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8KF/pFmQFz1t2ZN0eecCrf6irIsCOu85RoSrknYxmdHWqPPjG+H5gW6qN+ncINmiHbEoe99cuXO0n99JBUFi7cYOHFrSMMgcWnwN6zSJQ+BdhWwFAew2Zrs4x70GGeNRKqxUf8oSIDG4J+ZASvGQsPvmS17upbM6YtmbUI8yrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hbt52fG6; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-856a084088bso1603406241.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 21:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731907617; x=1732512417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y/5O/DaG+qseUM4co6lv9seYRVyO4Z+4HtVpQlw/vA=;
        b=Hbt52fG6dZj3eyBNFWpQvvvcD6PQCxPwGd7+WUFTW8PaQATABXvUprtFMb3t28ZsjM
         WUIGLzkGdQHbsRDYyrB6q0yWR5br7DrA0OM+h29H+/3uMy2ArhPQqGTsAOc3+DhNEtlm
         3KNVbnA0bmA4/72jdeubHCFgMyy8FkUDGP0XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731907617; x=1732512417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Y/5O/DaG+qseUM4co6lv9seYRVyO4Z+4HtVpQlw/vA=;
        b=tSW6d5A8wLb+9zZ1SLPKtkGabU1vHEHq9C9nYteHOBpnWyHY/KKpV6VsyXC12a18vv
         HRiNMkZgLgdLLDB0ezH0ybWBxvsTJCO29MSOo8t3QRVQBihjwZMeSOrlQupGEBNm/quQ
         9r3zn+sm+73wNFe/aBfy3pnva8f4oyo/5Lp33rvmPPIHo5E+0e+nh8wa8Rtf47H5d365
         jNcV0JsBKiTZdjgDtw7JtCnNx9/W6iOGcTg8LZq9sKlDmA34C5tyb9/uE4HElPOGKPYg
         MGOePt6gvmVeoNhClvNiruGLPBkSbSliVP9jm3yzDx5S5Vkq6GyI1kjg6rl84jZeuWm7
         OA8g==
X-Forwarded-Encrypted: i=1; AJvYcCX6QJsEiu1v31OofebvsgGxF7GZ7dBxdSKAHpJDESklXFAzq7aO9yYunzzQf3N3SWyx8t4+DVEsQmlyUEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoOnn9hcXTukhjpqr3qNw1dZeFfWMHcCowM7eL9+7iuErz1cvX
	8G7jM1CgYAh6mXbO6gMlTO1IjJwtLfOuNTzFZ212NRsEpv8bHzp/0Ip/SpciP5vZIXQbscB0nfY
	=
X-Google-Smtp-Source: AGHT+IHtddWx61KF7BibMoSElrv8jXCOPdaYvVZ8HZF0oLUCKcXWS/tBbbrHJhauXBYnsaEHdqkqnw==
X-Received: by 2002:a67:ee8d:0:b0:4ad:63b1:eb62 with SMTP id ada2fe7eead31-4ad63b1eeb5mr6922423137.4.1731907617520;
        Sun, 17 Nov 2024 21:26:57 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4ad643061c7sm1022434137.0.2024.11.17.21.26.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 21:26:56 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-50d2c02875cso1465628e0c.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 21:26:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeJuV/8i1Xw9zm7YwpRxJ46zt2HMij3EW2amArm9U6Pq0KPKd3Wy9v+8dOpt0PRe6Kks/IqoT/njS2cuY=@vger.kernel.org
X-Received: by 2002:a05:6122:3d12:b0:50d:6d53:fedf with SMTP id
 71dfb90a1353d-5147863e751mr10322690e0c.8.1731907615744; Sun, 17 Nov 2024
 21:26:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105093222.4055774-1-fshao@chromium.org> <20241105093222.4055774-3-fshao@chromium.org>
 <b66dbf9e-b35b-482c-9eb7-112ef1f398d6@collabora.com> <CAC=S1ngozo11g1vF2jnHjTLcNmP8tOMsQhK+LR0QWqoeXwSJjg@mail.gmail.com>
 <59f4bcc1-c752-4f2f-8e55-349cc2432b8a@collabora.com> <CAC=S1nhhfwHU5K5ZyUhZBhvz38LOZGLnGN-Rc1ZAup_VTfkpvA@mail.gmail.com>
 <CAC=S1nj5PVJ=zwZiBLoOCHzsspaRw9ddAH_dXfPayD=LyW5wNA@mail.gmail.com> <545b6db8-c7d7-4a28-a040-12088f9002df@collabora.com>
In-Reply-To: <545b6db8-c7d7-4a28-a040-12088f9002df@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Mon, 18 Nov 2024 13:26:19 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhX88aaQ6dusab1qM2_noaSjTMdhJ9t5o4L_Nri9dWPVw@mail.gmail.com>
Message-ID: <CAC=S1nhX88aaQ6dusab1qM2_noaSjTMdhJ9t5o4L_Nri9dWPVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: mediatek: Introduce MT8188 Geralt
 platform based Ciri
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 6:09=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 11/11/24 08:10, Fei Shao ha scritto:
> > On Fri, Nov 8, 2024 at 12:11=E2=80=AFPM Fei Shao <fshao@chromium.org> w=
rote:
> >>
> >> On Thu, Nov 7, 2024 at 6:37=E2=80=AFPM AngeloGioacchino Del Regno
> >> <angelogioacchino.delregno@collabora.com> wrote:
> >>>
> >>> Il 07/11/24 07:58, Fei Shao ha scritto:
> >>>> On Wed, Nov 6, 2024 at 9:19=E2=80=AFPM AngeloGioacchino Del Regno
> >>>> <angelogioacchino.delregno@collabora.com> wrote:
> >>>>>
> >>>>> Il 05/11/24 10:30, Fei Shao ha scritto:
> >>>>>> Introduce MT8188-based Chromebook Ciri, also known commercially as
> >>>>>> Lenovo Chromebook Duet (11", 9).
> >>>>>>
> >>>>>> Ciri is a detachable device based on the Geralt design, where Gera=
lt is
> >>>>>> the codename for the MT8188 platform. Ciri offers 8 SKUs to accomm=
odate
> >>>>>> different combinations of second-source components, including:
> >>>>>> - audio codecs (RT5682S and ES8326)
> >>>>>> - speaker amps (TAS2563 and MAX98390)
> >>>>>> - MIPI-DSI panels (BOE nv110wum-l60 and IVO t109nw41)
> >>>>>>
> >>>>>> Signed-off-by: Fei Shao <fshao@chromium.org>
> >>>>>> ---
> > [...]
> >>>>>> +&pmic {
> >>>>>> +     interrupts-extended =3D <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
> >>>>>> +};
> >>>>>> +
> >>>>>> +&scp {
> >>>>>
> >>>>> Is this SCP-dual or SCP?
> >>>>> I see SCP, but I also see a SCP-Dual memory region... what's going =
on here?
> >>>>>
> >>>>> Of course, the SCP-Dual won't work if you don't override the compat=
ible string...
> >>>>
> >>>> To clarify, the second SCP core is used for MIPI camera in downstrea=
m,
> >>>> and I deliberately only describe the first SCP core here since the M=
TK
> >>>> camera ISP driver isn't in upstream at the moment.
> >>>> I had a fixup patch for removing the scp-dual reserved memory region=
,
> >>>> but likely it was missing during the rebase... let me check again if
> >>>> it can be removed, just in case there's firmware protecting the regi=
on
> >>>> and the kernel shouldn't access it.
> >>>>
> >>>
> >>> Hmm... but the second SCP core can still be brought up, even if the M=
IPI Camera
> >>> driver is not upstreamed yet, right?
> >>
> >> Well, that's true... and it should pave the way for validating the
> >> driver with the upstreamed DT whenever that becomes available.
> >>
> >>>
> >>> That shouldn't cause lockups and/or other kinds of bad behavior, and =
should
> >>> bring up a core and just never use it, without any particular issues.
> >>>
> >>> If we can enable the secondary core, let's just go for it.. as that w=
ill help
> >>> specifying the exact memory layout of this board (and failing to do t=
hat may
> >>> create some other issues, that's why I'm proposing to enable that eve=
n if it
> >>> is not really used in this case).
> >>>
> >>> What do you think? :-)
> >>>
> >>
> >> Sure, that sounds good to me, too.
> >> I started only with the essential DT bits to ensure the device can
> >> boot, which it does, so I guess it's time to bring that back. I'll
> >> incorporate that in v3.
> >> I plan to fix up the single SCP core node to SCP-dual directly, so
> >> please let me know if you prefer seeing that as an individual patch on
> >> top (either option works for me).
> >>
> >
> > In fact, I noticed that it seems to require modifying mt8188.dtsi (and
> > potentially mt8390-genio-700-evk.dts) to support the second SCP core,
> > but I want to avoid doing so in this series if possible to keep this
> > as a pure new .dts introduction (if that makes sense).
> >
> > I can think of 3 options here:
> > 1. I resend this series *with* the single SCP core enabled in
> > -geralt.dtsi. And then I send a follow-up series to introduce the
> > second SCP core and update the affected .dts{,i}.
> > 2. I resend this series *without* any SCP cores in -geralt.dtsi. And
> > then I send a follow-up series to introduce both of the SCP cores at
> > once, and update the affected .dts{,i}.
> > 3. I delete the parent (mt8188) scp declaration and re-describe the
> > dual-core SCP structure in -geralt.dtsi. This avoids touching
> > mt8188.dtsi and mt8390-genio-700-evk but leaves the dual-core SCP
> > stuff exclusively to geralt/ciri. I don't know if MT8390 wants to
> > utilize the second SCP core or not.
> >
> > I guess (3) is less likely what we want down the line, but that's just
> > for reference. Any preference/suggestion?
> >
>
> I want to verify with MediaTek whether the Genio 700 EVK can make use of =
the
> dual-core SCP first, as it is highly possible that it indeed can and, if =
that
> is the case, counting that any product development would be anyway based =
on
> the EVK.... we will probably never see single-core SCP in MT8188 devicetr=
ees
> ever again.
>
> Please send the Geralt/Ciri devicetrees without SCP support for now, so t=
hat
> we can get the vast majority of the code upstream - which anyway is likel=
y
> 95% of what you have right now... then I will either notify you for how t=
o
> proceed with the SCP (especially if I come to a conclusion before you sen=
d
> the new series), or I will just send the SCP DT series on my own.

Noted. This is currently on the back burner as I have other tasks at
hand, but I'll get back to it ASAP (hopefully later this week).

Thanks,
Fei

>
> Cheers,
> Angelo
>

