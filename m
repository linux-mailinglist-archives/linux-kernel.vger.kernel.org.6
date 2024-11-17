Return-Path: <linux-kernel+bounces-412244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BE79D05CA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 21:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC991F21AE6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 20:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB711DBB35;
	Sun, 17 Nov 2024 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFlXwjzi"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFA62E419;
	Sun, 17 Nov 2024 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731875125; cv=none; b=ubzQCSWAteRVxmGl5b3EfCPMi1i1uujWpNdG5n6sjEiOb4sHTeBnnq4fLXATIqrkQiosIUHCtScabovSFfFeHCF4bc1Q9rt6tXYn/fx3FVoRKYGngHSVk1usB+fky9CCBSJkEZ31fSz88YXbQX4wBiNaXr5F/cn5nInYiK1iH6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731875125; c=relaxed/simple;
	bh=q/kGLB+qfi7wyEslp5V7sDFhlxrf/PadLPyCk/p8cD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLY8HH1pzOApGcF37D/tFVw5Km94LdGNZ+qE3OWL5eSHCdUnTJxUK0WFIa2xahBDHzOl17lghUbWt5xDWImpd/z0ADUxkeI1tdgahi/QkSfhRExYhga3QRDqcn5Toqs5gOkapylvcx7MaFeIY+Bi0PqMF7YdZ3HOTwfKaJEC91s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFlXwjzi; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7246c8b89b4so2300670b3a.1;
        Sun, 17 Nov 2024 12:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731875123; x=1732479923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IXNCYpKNgdmFrxDQ/AnKhcjV9mQM2l13Obks8uXGww=;
        b=kFlXwjziqpYNTwf+5J5Ab0MLuJQQFp0bAt14vY5BtGD+ZvBuLzXc8hC27zoPyZYO2Q
         QMqWEbO8OP4ZDZD+26ftkFnlFsyhL13HCV+3MyUEJ/9G2BB8OD/RgJJVftNFceZhIWwW
         YmZMroMO/IbtHNm7iuw1RtTMOgreqL0KRsXZPlc2NNoIjrv6mBI08QYTCmI3xPKXgMlI
         OoxWPr6w+3V0StACoRYI/2ebN9gcgFZ8qCk1JnFVFXdoj4gLcoF7gxy5UFqtz/w7nfsK
         1U/vXE1wq70mpNqOFmnU+R6msMtXe+XAhDermtiozGXyDEBIZ6bOugEzopR9UHcd+6gY
         NLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731875123; x=1732479923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IXNCYpKNgdmFrxDQ/AnKhcjV9mQM2l13Obks8uXGww=;
        b=kHXtS8iPUhCobUBg4eJB1XQmBQk5nvYiXfMPAXtoWG7zhQ4STvfIJOqRh6H1cEjwgw
         HGN5zln4GT9te3gWdaYIDc2Hrr8Bc5H9ucNY9P0xKT806fnubo0cok1bLP7eHkQLrYyY
         wdMlr2AQ4qgrHDEmlSBSdo+Zewsu2Np8EFIpUtJN8UlL/6CI3ajD/ntn2fs339Syy7ZF
         cQGmYAmLHaROFVV8Zxn4naV5KriZaHhByDdYJOunpxp1u/+gUUGuNRoE1afiBW/5RC4M
         5844U7bgK/lvjgjAG3SaHtDjZkdhjKcs/Xh/LVLgxPJr2Gojx3K30mA/mg79u5zc4w0G
         ITFg==
X-Forwarded-Encrypted: i=1; AJvYcCU5pnvAtdVjMi+MiRExnRjwqW3LCmh3N5nMu/+u1TZeoCjl2rFCulOmRBYhEJjsInttfhfOF8KRDfI=@vger.kernel.org, AJvYcCV5fvNuWrq3v0ePTQZu6eGcq+jbyE5UhToafPcbMaKUhiROGasM7b/fHFJvCs3HYTONNeV7KJ6mxrUpy90k@vger.kernel.org, AJvYcCXBqDw7LxEcJ1pPxlYxn1lm2RfjIkmMlMvoX5FYRv1lmqNRYAo1VKoV1TjTbscpk2vDx+aRBNo5rIvKlxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9PYyhpDLE7jsEs2hnUYsWwW9np7YMcJLcw2zeSC3QHbmvs2Ra
	3rIZvhmc1ONwdjSWDP7aOCblCcm7n4WrV2YCFzQRIz9WHeQBFt1Cmz4Xm2hpXqcl2q3nowU+f6P
	8L89s1D0+f37GMEjwpnUp2IN2Ig8=
X-Google-Smtp-Source: AGHT+IESauqchq9PDYS2eN/NUPSZQIC5QBWQ/3DGshEXY0B0+CbLRHFdSpp+k0Au0xMSMcpEdjnIqHwBym5eQT+niCg=
X-Received: by 2002:a17:90b:1e4b:b0:2ea:696d:732d with SMTP id
 98e67ed59e1d1-2ea696d739fmr2887150a91.13.1731875123370; Sun, 17 Nov 2024
 12:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-alc287-nitro5-v1-0-72e5bf2275c3@gmail.com>
 <20241114-alc287-nitro5-v1-1-72e5bf2275c3@gmail.com> <87iksmq8ho.wl-tiwai@suse.de>
In-Reply-To: <87iksmq8ho.wl-tiwai@suse.de>
From: Hridesh MG <hridesh699@gmail.com>
Date: Mon, 18 Nov 2024 01:54:45 +0530
Message-ID: <CALiyAo=5aLbYEyRWWw7QscTk6cXy5qckHToiPL6h4fKM9=skLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ALSA: hda/realtek: Fix headset mic on Acer Nitro 5
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Stefan Binding <sbinding@opensource.cirrus.com>, Kailang Yang <kailang@realtek.com>, 
	Simon Trimmer <simont@opensource.cirrus.com>, Joshua Grisham <josh@joshuagrisham.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > +     [ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_VERBS] =3D {
> > +             .type =3D HDA_FIXUP_VERBS,
> > +             .v.verbs =3D (const struct hda_verb[]) {
> > +                     { 0x20, AC_VERB_SET_COEF_INDEX, 0x45 },
> > +                     { 0x20, AC_VERB_SET_PROC_COEF, 0xD689 },
>
> This is a generic setup for the headset input in CTIA mode.
> Do you really need this explicity?  Usually it's set up at
> alc_headset_mode_ctia() when the iPhone type is connected.
Yeah, the mic wont pick up input without it. I did have a feeling that
it's supposed to be set up automatically rather than being set as a
verb but I couldn't figure out which part of the code I'm supposed to
modify to make that happen. I've tried running it with dynamic
debugging turned on but I don't see the output of codec_dbg from
alc_headset_mode_ctia() :(

> >  static const struct snd2_pci_quirk alc269_fixup_tbl[] =3D {
> > @@ -10201,6 +10220,7 @@ static const struct snd_pci_quirk alc269_fixup_=
tbl[] =3D {
> >       SND_PCI_QUIRK(0x1025, 0x1466, "Acer Aspire A515-56", ALC255_FIXUP=
_ACER_HEADPHONE_AND_MIC),
> >       SND_PCI_QUIRK(0x1025, 0x1534, "Acer Predator PH315-54", ALC255_FI=
XUP_ACER_MIC_NO_PRESENCE),
> >       SND_PCI_QUIRK(0x1025, 0x169a, "Acer Swift SFG16", ALC256_FIXUP_AC=
ER_SFG16_MICMUTE_LED),
> > +     SND_PCI_QUIRK(0x1025, 0x159c, "Acer Nitro 5 AN515-58", ALC_287_FI=
XUP_ACER_NITRO_HEADSET_MIC_PIN),
>
> The table is sorted in PCI SSID order.  Please put at the right
> place.
Will do, thanks.

> > +     {.id =3D ALC_287_FIXUP_ACER_NITRO_HEADSET_MIC_PIN, .name =3D "alc=
287-fixup-acer-nitro-headset-mic"},
>
> Nowadays the less need for a new model name string.  You can specify
> the model with an alias of SSID if any other device needs to apply the
> same quirk, too.  So, unless it's mandatory, better to drop.
I added the model name string to make debugging easier for users. When
troubleshooting this issue, I followed many guides that recommended
the 'Codec-Specific Models' document, but no entry existed for the
ALC287. I thought that adding a model name would help users quickly
identify and apply the correct quirk without needing kernel expertise.
However, if this goes against the current standards, I=E2=80=99m happy to
adjust.

