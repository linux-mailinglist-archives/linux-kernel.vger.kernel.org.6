Return-Path: <linux-kernel+bounces-219652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB4B90D616
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FFC71F21E12
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CDC15EFA0;
	Tue, 18 Jun 2024 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KZaJrcC+"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDB015ECE7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721838; cv=none; b=L/LksDYYRAvFB32/tr9i/ro1N4lXJLrFwABy+q+nUfRHLDW8KB0MFPCvI3H/VP0f0XjC3ZG/5044WFB4KAjat2OpHvU+y89ZtYr6ReP8/vzzEkDy5OHLeZGMnHsGaEfxJH/6TsRgtP3jnVSjltzk604LWPs394VivJalyVMBboQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721838; c=relaxed/simple;
	bh=SNSuiQRo9T7DEQ2R3qycx5vSw4DAytKvvHqY/7vPHKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hpr1Y6dyO5c8fzIKpL35S7H0g0S/no7R/+AFOrGYdg/To2y8FCuLbpuHA8ot7tKJYUNN89JTPR+AIpXICnXKZdRfF/3QH2yWJVsCDTDz6M5oq7KmNcRi7oXIkaYjNLVpzdxGCI3DpBivyHVbNTSDUJqmzk4ussuKvnQFZebTW5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KZaJrcC+; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b060f0f48aso25514396d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718721835; x=1719326635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Zq4WUZA9GuHMC/0cNFmA/OUlKHldacJDbVJ/hibF2g=;
        b=KZaJrcC+/jl7QLUoTEo/1Qd0BZCniZfh/Et6QFE9lCw3gsW1UOwyh2u063c0uphMJc
         5eo6ndsa0NGtli22rGOazeX3Ee6AavFihVuna9qkWzQBlG34hbIW+azuMxeYGWdraJRl
         pA17mvADqcMV7fl00/jOib7MtEXjGooViy3Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718721835; x=1719326635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Zq4WUZA9GuHMC/0cNFmA/OUlKHldacJDbVJ/hibF2g=;
        b=jLDrLRPh7RhCg2F8ui5XkSnnwXK5xB7/feNepAjtvCYZep19SYg8Q8bkaoQiNrCYPF
         NjRvCMpCT+dup+xSSTcTuGJXCpBZaClAYiWpaaGtb2V/YyiuUsFgSAYf7ai02/SREIR1
         TCo1yLR8DMPCFNfMsh3aiUu+BENrmt9Joj/hgYFmbasKtGwgPJFfmFBJGqlysud9BYWK
         0U7AiCwTbLtgUzIX1H0b9e4C1wS9fS6Eo8Dfyeduy8dFKF07MwXv9L+HjoNDMJrB+3jK
         nje0RthySLSsHzDpWHBUqlkmGynES8BslZ9j3JAza8H+xZt46DdUpp9V92woo9MvMifY
         hnSg==
X-Forwarded-Encrypted: i=1; AJvYcCWSmpGRRoyOQfl2edNBcX4I7WSxhNUWeRgO3tjVWgvnCM/WMDNP3V9DRI81mt1zVbUdZiH0zbm+wJgfn1LTllRDzZvGMTtZhDkEO49o
X-Gm-Message-State: AOJu0Yw3ALcr6zQGSPUkf9vnKxx/GiBQ0ZFaJneZN9UcxM/WyWVxLi+U
	L5FT+kOG+hto7meVi657Rre2xvTXyKcI1tUbnzKPgn9rCbJsUR3qwgnqFKX84v3XP41Hd+F8w+8
	=
X-Google-Smtp-Source: AGHT+IEE/FUgGKeVxITPPE+F7RZWGx7BBTBS1NwNNzDg+BpOc2HeQqVoY0PlDJGzT02uyD1m4tC4yw==
X-Received: by 2002:ad4:48c2:0:b0:6b2:b5d9:91d6 with SMTP id 6a1803df08f44-6b2b5d99431mr117994796d6.18.1718721834945;
        Tue, 18 Jun 2024 07:43:54 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5f02481sm67493046d6.138.2024.06.18.07.43.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 07:43:54 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-443580f290dso303811cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:43:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+Y5TPsFSRgiBfz3dOczBZIqJrSkXaNg1XQd2aYhu5WnoeLH1cVujoifR2rCKR8mMu5lGkdEypNoUcMcPQ4Swnf3S55p1O/0IYXAA6
X-Received: by 2002:a05:622a:13d2:b0:444:a760:55de with SMTP id
 d75a77b69052e-444a760572amr130461cf.24.1718721833609; Tue, 18 Jun 2024
 07:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618003546.4144638-1-dianders@chromium.org>
 <20240617173426.7.Ie8aa2af2df12c2e9dc510f003a301401a1ac97fb@changeid> <20240618125710.GE11330@aspen.lan>
In-Reply-To: <20240618125710.GE11330@aspen.lan>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Jun 2024 07:43:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WY18ROK6pnF4DviGrTAJDd_YbR5T0MAoTR4w1_+xCeTg@mail.gmail.com>
Message-ID: <CAD=FV=WY18ROK6pnF4DviGrTAJDd_YbR5T0MAoTR4w1_+xCeTg@mail.gmail.com>
Subject: Re: [PATCH 07/13] kdb: Tweak "repeat" handling code for "mdW" and "mdWcN"
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Jason Wessel <jason.wessel@windriver.com>, 
	Thorsten Blum <thorsten.blum@toblux.com>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 18, 2024 at 5:57=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Jun 17, 2024 at 05:34:41PM -0700, Douglas Anderson wrote:
> > In general, "md"-style commands are meant to be "repeated". This is a
> > feature of kdb and "md"-style commands get it enabled because they
> > have the flag KDB_REPEAT_NO_ARGS. What this means is that if you type
> > "md4c2 0xffffff808ef05400" and then keep hitting return on the "kdb>"
> > prompt that you'll read more and more memory. For instance:
> >   [5]kdb> md4c2 0xffffff808ef05400
> >   0xffffff808ef05400 00000204 00000000                     ........
> >   [5]kdb>
> >   0xffffff808ef05408 8235e000 00000000                     ..5.....
> >   [5]kdb>
> >   0xffffff808ef05410 00000003 00000001                     ........
> >
> > As a side effect of the way kdb works is implemented, you can get the
> > same behavior as the above by typing the command again with no
> > arguments. Though it seems unlikely anyone would do this it shouldn't
> > really hurt:
> >   [5]kdb> md4c2 0xffffff808ef05400
> >   0xffffff808ef05400 00000204 00000000                     ........
> >   [5]kdb> md4c2
> >   0xffffff808ef05408 8235e000 00000000                     ..5.....
> >   [5]kdb> md4c2
> >   0xffffff808ef05410 00000003 00000001                     ........
> >
> > In general supporting "repeat" should be easy. If argc is 0 then we
> > just copy the results of the arg parsing from the last time, making
> > sure that the address has been updated. This is all handled nicely in
> > the "if (argc =3D=3D 0)" clause in kdb_md().
> >
> > Oddly, the "mdW" and "mdWcN" code seems to update "last_bytesperword"
> > and "last_repeat", which doesn't seem like it should be necessary. It
> > appears that this code is needed to make this use case work, though
> > it's a bit unclear if this is truly an important feature to support:
> >   [1]kdb> md2c3 0xffffff80c8e2b280
> >   0xffffff80c8e2b280 0200 0000 0000                            ...
> >   [1]kdb> md2c4
> >   0xffffff80c8e2b286 0000 e000 8235 0000                       ...
> >
> > In order to abstract the code better, remove the code updating
> > "last_bytesperword" and "last_repeat" from the "mdW" and "mdWcN"
> > handling. This breaks the above case where the user tweaked "argv[0]"
> > and then tried to somehow leverage the "repeat" code to do something
> > smart, but that feels like it was a misfeature anyway.
>
> I'm not too keen on "successfully" doing the wrong thing.
>
> In that light I'd view this as a feature that is arguably simpler to
> implement than it is to error check *not* implementing it. In other
> words by the time you add error checking to the argc =3D=3D 0 path to
> spot mismatches then you are better off honouring the user request
> rather then telling them they got it wrong.

Hmmm. How about we store the last "argv0" and we just immediately fail
if "argc =3D=3D 0" and "argv[0]" doesn't match the previous one?

The override rules for lines / word count is already complicated
enough and my head was spinning trying to get this right and reason
about it. I tried several times and each time I thought I had it
working cleanly I ended up with some other weird corner case that was
broken. For instance, with the current code this case is broken (IMO):

[3]kdb> md2c4 0xffff0000d8948040
0xffff0000d8948040 0204 0000 0000 0000                       ........
[3]kdb> md2
0xffff0000d8948048 3000 824f 0000 0000 0003 0000 0001 0000   .0O...........=
..
0xffff0000d8948058 0003 0000 0000 0000 0000 0000 0000 0000   ..............=
..
0xffff0000d8948068 8000 884a 8000 ffff 0001 0000 0100 0040   ..J...........=
@.
0xffff0000d8948078 0000 0000 0001 0000 0000 0000 0000 0000   ..............=
..
0xffff0000d8948088 0030 0000 0000 0000 000a 0000 0000 0000   0.............=
..
0xffff0000d8948098 f0e6 fffb 0000 0000 9340 809b 0000 ffff   ........@.....=
..
0xffff0000d89480a8 0005 0000 0003 0000 0001 0000 0078 0000   ............x.=
..
0xffff0000d89480b8 0078 0000 0078 0000 0000 0000 0000 0000   x...x.........=
..

Specifically I would have expected the "last" wordcount to persist but
instead it fell back to the default mdcount. Maybe the above is right
but it's distinctly non-obvious.


> Daniel.
>
>
> PS I have never done so but I also wondered if it is reasonable to use
>    this feature to manually decompose structures. For example:
>
>      md1c1 structure_pointer; md1c7; md8c1; md8c1; md2c2

Sure, you can come up with cases where it could be useful, but it
feels like there are other ways to accomplish the same thing w/ less
complexity.


-Doug

