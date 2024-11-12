Return-Path: <linux-kernel+bounces-406006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1BC9C59F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90BD1F2344A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9780B1FC7DC;
	Tue, 12 Nov 2024 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1/bVu0cj"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A261FBF6C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731420697; cv=none; b=cOMzJ+ORnUYDGn9dkJAmVnxPLUBCDOmVk2ehl/LPSgrMbM+F7Ff7c99HzoI4jcO5qcro+PuKQTP+Dn78qUzSgh7FWm/TFtl6zymj5z4WgUkqBR3nqfawdihU9rgp6SnbPokI/fFuIa3bFTuMBqg0yIDc7bJyQrmPuUaQfqBDJLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731420697; c=relaxed/simple;
	bh=1fZhEbTaDiiroktK8JnnW5AlOotjuE0UbSmwivk2zNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnes8/w6/n2hKfupwKdv9cPIpSZ8UIwCCFnWb1MzKmornLXzgF1Fg1fZMXvBp8mQmI5ov+a5kYzaFz6YeaGSgfo2bnLqHhNAILAeYTHMcrbnhsFa+SHqK8xZmIuy89JYCYcEwBPpGUe80RCklJNBsmgJWHn/5FH6UCHJv9xMuIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1/bVu0cj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20ca4877690so140915ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 06:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731420694; x=1732025494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkqXyzik8eZACIcFxqtlyAZ4d3oM6XwthEsQPSJKppo=;
        b=1/bVu0cjI6uYSnBA6czimetVLmc4a5JGirGFl/zFfaishrtCemA91rk4WvrIeXqLtJ
         Djzps+0sfFL0KSOYuggZhRAu4wd0K9M7BG2NjtGP8wa9l5RKj8hKuc1IYIH+Zi+qYGxH
         MDHIrC3+MhxDj/mwpaddYiMSPAzfwaCqTUtjYQEi/JO778EoHj/oDnkDj/07kRKaWAWp
         egSveJvzfPb0MJVPSx3fwv5TzRbbK4oUG5JtQTbQvPORKCVOtgx5jVPvEXaJkKGhmoPu
         FFDRTq6Oi3Mij6ZsBkRwkfmkfhPwNbzjwVGWAnS8LsWRXcVdAkKuNtheHtwdBHyvYAI1
         ranQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731420694; x=1732025494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkqXyzik8eZACIcFxqtlyAZ4d3oM6XwthEsQPSJKppo=;
        b=WK3yUoFdtSN0sWXXMZ8vGYo2TsRFBrdwVWtf4/j7cMJz1340LIiTFNri2LcZ6A8dqD
         kGEvJGuU6dV6QhrX3qVXUUyfub+BGmGw0D4gSUQBtpQcV0K9Mnxxqk22sYh0s0wiyPQJ
         3p7Xw5mP5BWpwowipyjrSfcIiKRK5Eh1NQputg2vnzUQg5dv9RfYDMzI1MGRTws0t0xQ
         d1S9cRo5A9gKZAIPuxLU8kfSCTOJEx+ROb0tKuc+qvo8D/NFTWpvl7r5Q8KCebUmuO0g
         0iE1b+aJdydNDKGzyMH5prmBclcedfx9cAG8SvwUwMSAuwk+7uaxV4lJ132o5nXscVeK
         LeSQ==
X-Gm-Message-State: AOJu0Yz/OWhjebfnPSzfMaH/Gh37LRscPrDob4I3FjvbG4cvldJb0ipU
	qGjLU9ES4g5qTZe38yZ8Z0PpXyKRCkOaUnRbAijAK0Iw0pPWrjWhPIF4P19VJdPG+6rGMiQtinv
	Cg4UTocn9UBKx56BhoIi5gyctLRd14gzIk5kB
X-Gm-Gg: ASbGncuAATWr9mXnWbumztAXd4ntW87WZUa+nfhaxjZRnT4++Ppv7kBdjK9OCSonFMN
	0QnWniI4afrid95BnVkZVOqSwECTX0w==
X-Google-Smtp-Source: AGHT+IHlRgvzbYmdyT/fAOqtiTj4F4oiQEsE+/ajhC4KCnzbFZ6t8EIkbdeU7Hy/B+sKHd+rJDTDQvGKLo1SfMQrNTg=
X-Received: by 2002:a17:903:124a:b0:20c:568f:37c7 with SMTP id
 d9443c01a7336-211aceca238mr1984225ad.17.1731420693651; Tue, 12 Nov 2024
 06:11:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112074048.1762371-1-mmaslanka@google.com> <ZzNVH65o0ue6jn6a@finisterre.sirena.org.uk>
In-Reply-To: <ZzNVH65o0ue6jn6a@finisterre.sirena.org.uk>
From: =?UTF-8?Q?Marek_Ma=C5=9Blanka?= <mmaslanka@google.com>
Date: Tue, 12 Nov 2024 15:11:07 +0100
Message-ID: <CAGcaFA3SdBVtOiPJQG82YwBX01s5_mJszeM4LNSc5Pn74S2Cvw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: da7219-aad: Fix detection of plugged jack after resume
To: Mark Brown <broonie@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, Nov 12, 2024 at 2:16=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Nov 12, 2024 at 07:40:47AM +0000, Marek Maslanka wrote:
> > Don't notify and mark the jack as unplugged during the "set_jack" actio=
n,
> > because this action is called very late in during the resume process, f=
orcing
> > the jack to be unplugged after the resume, even if the jack is plugged =
in. Let's
> > leave the responsibility of managing the insertion of the jack to IRQ.
>
> > @@ -33,10 +33,6 @@ void da7219_aad_jack_det(struct snd_soc_component *c=
omponent, struct snd_soc_jac
> >       struct da7219_priv *da7219 =3D snd_soc_component_get_drvdata(comp=
onent);
> >
> >       da7219->aad->jack =3D jack;
> > -     da7219->aad->jack_inserted =3D false;
> > -
> > -     /* Send an initial empty report */
> > -     snd_soc_jack_report(jack, 0, DA7219_AAD_REPORT_ALL_MASK);
> >
> >       /* Enable/Disable jack detection */
> >       snd_soc_component_update_bits(component, DA7219_ACCDET_CONFIG_1,
>
> This path is also (AFAICT only?) called when registering the jack by
> da7219_set_jack(), I'm not immediately seeing the path for resume.  This
> suggests that what's going on here is an issue with the machine driver
> unregistering the jack over suspend?

In my case the da7219_set_jack() is directly called from avs_card_resume_po=
st()
(sound/soc/intel/avs/boards/da7219.c) so that could be a problem too.

