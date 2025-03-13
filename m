Return-Path: <linux-kernel+bounces-558651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D371A5E915
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 060E37AB875
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBCC171C9;
	Thu, 13 Mar 2025 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asP0KWc8"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBAA376F1;
	Thu, 13 Mar 2025 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741826999; cv=none; b=XypMtVS6u4a4AOLamXcQr6VrC69QIuYgtF8yeL03pyuIcrbwOQEF2xY+TEd8NmyeALiGPN7BD+yaIlkckdOmhp1vkL+Newyp7gyYSut9b+zEO0WFIwLJDarlAcfOIst5yQxS0w8ejBKF3iXKEK/qpF570GxT5ARIkL6UXt+sMnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741826999; c=relaxed/simple;
	bh=Z49HXwaxexdDXy7kOpCh40mnlaoCuxB1V0yAtiPZZAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpM3gDIR0jtSEzApwqavOEN/civjuXGMCCXNZgBI1D6t8CxOLGIm0cvJ227Jp0EyLu6wZr8kApu+x3kT/MhwgLarWgCrTdl4S4kxyUqLpjew/sg29IR5Hr8rF+wLRJIR3f9/WK5rEBnu8QVsbgEk8Vyp3TXiPotrugqwEG138Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asP0KWc8; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-476775df2f0so14940201cf.1;
        Wed, 12 Mar 2025 17:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741826997; x=1742431797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkeNyflx08eBwoXdOrj+id9tFS6hOSl0Scgwwso0Pdc=;
        b=asP0KWc85RzWtO8Zf0I6uVwSD26cE0WIeas47M6A/nACTMwyyMP8DZ+K3hqkHvwmq0
         FW28EQsRHDXsChnAhoKFc31/YP16OKL3IK4DBdKnZUO0NhXjgjNDCIrqXrZtff94BEoJ
         vvL5rGlsaF0gvhlL4lVl0pUUfUD+HcDYZuc2NIlPDUg3LHhYaTjPRvxi8UuzAaE7y9pz
         bRHL2FpjTGYyBYHAQT/D/Hb+6IyknrCCcFPYWdn2IEkwRhYgOHjOstL93WXS/0+jWLgd
         2KdJGG/q1uRvdchZpOdMdXUmWZm923uUuMxm8fe/UMK2XuSzPuDtgepMZ0UpBAteQR92
         w2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741826997; x=1742431797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkeNyflx08eBwoXdOrj+id9tFS6hOSl0Scgwwso0Pdc=;
        b=Qvsmv1cmAjzfqqUgxKm1eXKdnZ/InXmSxVlzmU/5cnhcrM3CnSbEUG2E7+xTllnFXS
         L8TaHLa1r5CmHOJtUPB6tWhCjSdngKKV7hikAr9znlTyvGF48rLcDVmPJ+Di1ZaItoxC
         9AfZjiB7WXegkeCBfICTU6Y4b+5aBrc1vXka6MEMwEF3mq7+JeOlb9D5k0ZwMUaRWeQc
         WMHBsoY3RJ5qzZ6NKd3uPBMPrER0nglKC7drjUYfVaVgCpzdvvfsy4aHGeVdlfXXb1h4
         ujbsG+8OUs5JTPPFvqGYlVzKvx4WvIfOCYgJRybi6t5eZHsdcFrlVM3B7R3U4t7HQjlS
         aTZg==
X-Forwarded-Encrypted: i=1; AJvYcCUqC1nwCQKUT1T5fkR4NfDZZQJJuEfQv4HpcY8HKwnNqcb1O6waWdluIotrwlv2wPxWujGMr45NtCM0JmY=@vger.kernel.org, AJvYcCVKaMhrVPevGMycfLZO+BxLybp8CL0WYELLHzF/ebhRNsIdeMfIfJD/ulBXnmj0b+vmIOYMKfGNeBPfeFw=@vger.kernel.org, AJvYcCWbTlJVQiMruj8UVmeJ40D5nx9qpomr9sGNeBxFy/e8IJq1NY/pIyAcyTv/0YFKOR5FZ6sMts0xBTYcAKWa@vger.kernel.org, AJvYcCWuqFeYKQczKuGyzf7dmDuxKE0AprTUqtGXMP2MmoTZIzhb18aq3f5mxboZoyDjxtGahOaxJvUN6ynS@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/S4HcFCXfjW+uhjX9yxFkyWT28TjKuobedg4c+uvab3l14HCP
	Nco9X/WVqosyIWzNThFSrgaBwN5TtNotxlWKmbtYDkUtdPa/J1+oQZHDBnerb7svf07+1YT6t1o
	LTjE161YSGiGEoJfUowhEN1QPLOA=
X-Gm-Gg: ASbGncsJfq49Kb0zUk1rvNMAt12uZXnXTUaAk81ETWP0Dwg5UyIQ4n6kQuyhJyMpcQl
	227JFHD9iJPI0FbdkbEKUTLvcIsbBoxcirX5j3Y8ePy2P1LGa3QjABM4QQTeqB34/SEV2ORuI2V
	mS86I2SG7xTh7H+m1lC5XglEm5OP7CQYJFJII=
X-Google-Smtp-Source: AGHT+IE4UMHREzgkQUDlb9f76ML3et+Bb02b5+av1fLvRw1YGIeJDBdw7dFMjSxPahafRrC3GwwrWULZTUZ927Q/Ez0=
X-Received: by 2002:a05:622a:438a:b0:476:652f:4db4 with SMTP id
 d75a77b69052e-476ba8b2f27mr8949481cf.5.1741826996633; Wed, 12 Mar 2025
 17:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
 <CAHgNfTxS1Q4PPsw520-J4Yn6xg+QZOYFkYhg5yv-uZFu5waN_g@mail.gmail.com>
 <20250307205156.GA583954-robh@kernel.org> <5996925.DvuYhMxLoT@setsuna> <20250312125832.GA359842-robh@kernel.org>
In-Reply-To: <20250312125832.GA359842-robh@kernel.org>
From: James Calligeros <jcalligeros99@gmail.com>
Date: Thu, 13 Mar 2025 10:49:40 +1000
X-Gm-Features: AQ5f1JpviH4ysHbqATC6ly_Fa9fyvcQzoJXH7f6pMF6qeXNeHE906TPegzKdRB0
Message-ID: <CAHgNfTwLfqCP-TL_pdqxs0AC+1z845Ca1zU6dUS=xwNMgaz+5Q@mail.gmail.com>
Subject: Re: [PATCH v3 17/20] ASoC: dt-bindings: tas2770: add flags for SDOUT
 pulldown and zero-fill
To: Rob Herring <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shenghao Ding <shenghao-ding@ti.com>, 
	Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shi Fu <shifu0704@thundersoft.com>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	=?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
	Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	asahi@lists.linux.dev, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 10:58=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Mon, Mar 10, 2025 at 07:30:07PM +1000, James Calligeros wrote:
> > On Sat, Mar 8, 2025 at 6:51=E2=80=AFAM Rob Herring <robh@kernel.org> wr=
ote:
> > > How would it work when you need a mask? "dai-tdm-slot-tx-mask" is
> > > enough?
> >
> > The existing TX/RX slot masks are used to control which slots the codec
> > is operating on, AIUI. I don't know if it makes sense to alter how code=
cs
> > deal with this. Could we combine the suggested dai-tdm-slot-tx-idle
> > with an optional dai-tdm-slot-tx-idle-mask property? From the machine
> > driver's perspective, the API would then be similar to the existing
> > set_tdm_slot ops. The current downstream macaudio machine driver builds
> > its links by allowing multiple codecs and CPUs to be linked to a DAI,
> > like so:
>
> Wouldn't the NOT of dai-tdm-slot-tx-mask be the idle mask?

Theoretically it should be, and that's probably just what we should do.
We would then just have the dai-tdm-slot-tx-idle-mode property to worry
about. There may be a reason a unique property was added however, as only
some codecs have it set in our downstream DTs. Perhaps Martin can shed
some light on this?

> >
> > dai-link@0 {
> >       cpu {
> >               sound-dai =3D <&cpu0>, <&cpu1>;
> >       };
> >       codec {
> >               sound-dai =3D <&speaker0>,
> >                         ...,
> >                         <&speaker6>;
> >       };
> > };
> >
> > In this case, the codec-specific mask property was added so that a mask
> > could be applied to a specific codec rather than the whole dai, however
> > from upstream drivers tt looks like the way this should be handled is t=
o
> > have "dai-tdm-slot-tx-idle-mask-n" properties at the dai level, then ha=
ve
> > the machine driver set the mask for the appropriate codec during setup.=
 So
> > for macaudio, assuming speaker5 requires this zerofill mask, we would
> > have something like this:
>
> I'm now confused why you need n masks and what does n represent?

We can have n cpus linked to m codecs in macaudio, and we need to specify
the TDM properties for each codec individually . There seem to be a couple
of ways upstream drivers deal with this, but the "nicest" way I've seen is
what amlogic[1] does, which is extend the dai-tdm-slot-* properties with
an index (-n) representing the specific codec it's for.

Regards,
James

[1] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/=
bindings/sound/amlogic%2Caxg-sound-card.yaml

