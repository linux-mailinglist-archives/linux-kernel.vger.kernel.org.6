Return-Path: <linux-kernel+bounces-367528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB7D9A0377
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9ADF1F22038
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8931CC14C;
	Wed, 16 Oct 2024 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThS+MUO3"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7117165F1A;
	Wed, 16 Oct 2024 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065742; cv=none; b=ZOZqSOFiR0XIbyZSqEYaQXQjg+pV12Wm6cg7kTxb+sdSVEnSYavu2F9hqp8Cy/dLSnGHl7yQRP3jW4bRHHFghAGuO0269H6pT4H4Af5dulAfcTgM59mrUuiI5a5QfCd7W5sBnWOPzGf+XDefMCiEPof0VslY0RkQ1zDfgZsxrLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065742; c=relaxed/simple;
	bh=aqyru2K2BXLWgHvgQ6mdiMQPnNpNoVxIfWtpLpm5Fo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ruk2EY8nK3aUs7QH1R5Xg77TYCQxToNWdPIAXKs90UP93moDl1xpx6wS4/o9u8a29Jeqb575JD0VWg2Kz7CNJ2dhtNEKx/BuHGh7kmOjgt51krVQwpHKbDgyRSK3Nf8qZsBzo6sHJI62pBcGletqgRB5yrSLIrxUMDLrkHga3m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThS+MUO3; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso6848162a12.2;
        Wed, 16 Oct 2024 01:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729065738; x=1729670538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtCFeuRBBCL7c2WKLvXHw2/xsvB0Q4sVn0uS0dCJjmM=;
        b=ThS+MUO3ZfUBcsJ0Dx+d2esfnR9o9nmUyOM65p9RYrHa55/X0Nk71ydmlIXOj018L2
         1kcWuF66cw85yJvyFnhTbSjnncmvW9JIEt8wPSpviFX2yFQQg6hfXi/TpEl2H+Uq9l0J
         TfP8JD1GQNUb0U8yl76oOgNuJJdsU2vA58iNJCrqYwgGpBufJzSlcoXxZSr4Dfh1/Vg6
         XLUXa3CDo2bj+xNEBlG47+KR74ETh3jP1FDFuG2kbDkjCDYcmOl9btwqXY+xlm6zXThS
         hafWiJHI1XkQYhwuGOtzUIyaaZw1HGj3ZzzcrCdKlM0MJigeWf1RS3ZE+OQK0h4iQG8x
         34kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729065738; x=1729670538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtCFeuRBBCL7c2WKLvXHw2/xsvB0Q4sVn0uS0dCJjmM=;
        b=tDihY2peIgUpts7o94Sb3q5Ab50/mrnyExOqGh+pIEWjRNif1z7buIZ2H99X5Gb4Kg
         dp2XG7ilR+f+yNPluec1MrwJzF0CWrXTLthG8IdUd+HovFgkKyFyx1qGajGX6a9tROeW
         dBJ2ZyoSNcDl3AkWzvnQcuiQDWLPeLeXTKOjlestI6Znnl2xMDrclNoRI10EKZWVncFT
         polTATEagh6lEhXfQYcIAg82mTjd5vvsl9ftRKJ8MK9lY5C/tHiynlgREbtUtiDICJ3/
         qMydS/s9Pn5mnVLYzw02mz0FRin0O2Wufg3sVOonhIuBM+W0VGmRbV5nPm4BOrwyGYEn
         +6cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrsOGGgfGxyKgMy/SP+TZMZkTUFHhjJv8+INNe4ABcnC0QN5hYsycuJhul5B8+HUTMmcdGaoROdIeW/Jg=@vger.kernel.org, AJvYcCWADqYIGkoAZpou/dbxjtAFkNnB6v/63WwOO4RReh2Vqcg6FGTK4mSIuWseyjrHlGhl0f/tXNK7s9azoe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsJxOeqH/0Ovhp04kX1Uyo1DU44u/L1bjQN022Q35g48xNVXQy
	cSljGfUTNbX6DoVZV/twmJGNTBphyeSrDf09y6sqgxsuivSRzvupgagY0COFldCm+pMFDe6btZs
	nOyhcySKIf7bwYyTyN4WOr0hLU3I=
X-Google-Smtp-Source: AGHT+IENv1biL2MoBmVkiW9/DVZkA779vcn3QmSTBcq4PNMZsq6C2l/biD2V8pQLyRFSUxDptoFZVmHh8dJq551DyXw=
X-Received: by 2002:a05:6402:5194:b0:5c9:87a0:4fcc with SMTP id
 4fb4d7f45d1cf-5c987a050f7mr5892752a12.16.1729065737907; Wed, 16 Oct 2024
 01:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015150958.2294155-1-arnd@kernel.org> <52c7e318.434f.192941d2bee.Coremail.zhoubinbin@loongson.cn>
 <887501dc-6bcc-4f98-b472-af609c4c370b@app.fastmail.com>
In-Reply-To: <887501dc-6bcc-4f98-b472-af609c4c370b@app.fastmail.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Wed, 16 Oct 2024 14:02:03 +0600
Message-ID: <CAMpQs4Lu8To_4buztSNsWRzSHM_uAqLXqyB+p3R-OAnAHeLuFQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: loongson: make loongson-i2s.o a separate module
To: Arnd Bergmann <arnd@arndb.de>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Arnd Bergmann <arnd@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Tang Bin <tangbin@cmss.chinamobile.com>, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 1:02=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Oct 16, 2024, at 06:56, =E5=91=A8=E5=BD=AC=E5=BD=AC wrote:
> >> -----Original Messages-----
> >> From: "Arnd Bergmann" <arnd@kernel.org>
> >> Send time:Tuesday, 10/15/2024 23:09:54
> >> To: "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown" <broonie@kerne=
l.org>, "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>=
, "Binbin Zhou" <zhoubinbin@loongson.cn>
> >> Cc: "Arnd Bergmann" <arnd@arndb.de>, tangbin <tangbin@cmss.chinamobile=
.com>, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
> >> Subject: [PATCH] ASoC: loongson: make loongson-i2s.o a separate module
> >>
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> An object file should not be linked into multiple modules and/or
> >> vmlinux:
> >>
> >> scripts/Makefile.build:221: /home/arnd/arm-soc/sound/soc/loongson/Make=
file: loongson_i2s.o is added to multiple modules: snd-soc-loongson-i2s-pci=
 snd-soc-loongson-i2s-plat
> >
> > I would like to ask for some advice.
> > I didn't notice this warning before when I submitted the patch, is
> > there some specific compilation option that needs to be turned on?
>
> I think this is one of the warnings that are currently
> only enabled when building with "make W=3D1". I have this enabled
> by default as I hope to make it a default warning soon.
>
> In general, I would recommend to build new driver code with W=3D1
> before submitting.
>

Okay, thanks for the advice.
I'll pay special attention to it when submitting code in the future.

Thanks.
Binbin
>      Arnd

