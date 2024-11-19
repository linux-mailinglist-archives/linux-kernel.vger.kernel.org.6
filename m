Return-Path: <linux-kernel+bounces-414062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3CB9D228F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006B5282F58
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F54319C57C;
	Tue, 19 Nov 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw2t2kJ5"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55478139566;
	Tue, 19 Nov 2024 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732008950; cv=none; b=TE0PQBeZzQCa/E3UgVUXLrx4zfsUZDZ+ErG5NBkuhbYfZiQEZvxNiHrqzVnVQHrf7xklexphhdgDWCoBddntXcOPweekB2Il/kEyI8918wLpDGiCgM8KkXT1gjBQ0JyHQ5+wamvVvuzlGydjFSZ95qeu2lJdI0uCQYiCr+9Fs1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732008950; c=relaxed/simple;
	bh=tOr5zUwmN3yb2nhQ6wi2hnuyw96AxHgJdGY6vzcZcrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcobqFoQoFYS8ooJjImii1euayzASIZsR6vTBcV5kcwcprFQ3qE8C3/ao2oYV0d3A+xP/rqcRW9qO6lSulLe0KjwptycC5vMf9MIfVX/D1WrToYLeyjVFdlhCiqZBn4MTtPhP2WqDKl+CX7kDw0h0IaHVsRua/PzJwS52b8yRXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cw2t2kJ5; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a77fe30b0dso327485ab.3;
        Tue, 19 Nov 2024 01:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732008948; x=1732613748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnYFnM2sFhC5wfCK+6fZ2Ja9fZiE3XOnCzCCHGI4GG0=;
        b=cw2t2kJ5L/E8CaBpXxl1UBVCbWjQNGnEZjTLjyEcQ4C33W/fQRQqd9FCcq79l/0ciy
         7o6EfRPaZLRvJDxXqsHxIr1m24gxZJllZO7sKPSL7yXRu3klPyzX+ASTNzc3nMPAYsax
         1ALfFbyod2fBOF0hm7tW41hqYqHV2ZzafiWPjJoBFrMm6wdFvxX3eZqTgt0H6EBB6Iya
         MqDF9/0OIv++RU6cEhnjC6DKJwQge4RWsen/U1YnlVFtABojLpl4XKN7rKztPKYPMaWZ
         DZmmJh+IwNncMRkq0XnskXGD1QnrXhCTcupBkJaKo4CgKQIYzKJQIrrolLCJ7e9cQWM5
         pFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732008948; x=1732613748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnYFnM2sFhC5wfCK+6fZ2Ja9fZiE3XOnCzCCHGI4GG0=;
        b=fZuxfia1KoYbnY+aM1LNOprYHAPs0ONmcIekzLEGQWEBduRgqk4qHrsdM5VECtbW8u
         h86ohpYmRD/rP2JoGC/HDTMDntia9Fsl0lRwVBmaJj/h+rvu9dQuoBOtKWXDGAI+XrVS
         b6w5VRnaFaPwCwHZ7a65Jbv/h6omLqmNGuQ/R/wf23dom7eiwCGglR0JiJJ7xLnYk8m/
         X9qjmLKvN+7RbJ5ZRzOooCjcDAWAI13CInLZC6ksyReRtpahluu6lYMp7FvZza0yMqlg
         1NMFOc5BoH6od1FwsipPkznPnrGv5GOHYAshIy1dq/pycIRXp6rSnQhqw/F5DT9lAdA4
         Jovw==
X-Forwarded-Encrypted: i=1; AJvYcCUYXM70jbM1Cfl4CUtrNS0XDD1yILqVt+cpYg/sZGYYcmoZRDXhPd6QLac41sc/Qur0U0KuNESDaHswN0U8@vger.kernel.org, AJvYcCXojYLnJPT/tvKEq5DvsxDpVor3go3tqL5se4ubp6FmZzQkLmj+pFx2faJtDr1VEpdiLCwtgyw+wm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVVxPeM9EATEqvy49ivy+pGpRjQkj6Nq8lhM2UgV1PPw1NoxHA
	u/oIsKqRlyK45dOJ4ASXsNs8B0m8OCBmD+IX8gbtqay+pud6ikMap0PgRT66DIgRKKQU1wlzYvo
	tPre8f/KnBiji/CvKjfZnTMPyVPg=
X-Google-Smtp-Source: AGHT+IHbK7ZHvwSeOtWJ3a+S2WJZt3wsFdIwJInxf7s6NhG7VuTWPA8z9cbCUhbcQ9pqfV4z4beW5CW/veyMnZgCR10=
X-Received: by 2002:a05:6602:3403:b0:82a:3552:6b26 with SMTP id
 ca18e2360f4ac-83e6c2ea511mr1433295139f.15.1732008948402; Tue, 19 Nov 2024
 01:35:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007132555.GA53279@francesco-nb> <20241112075958.GA8092@francesco-nb>
 <20241112092054.GA18139@francesco-nb> <CAA+D8AO3a5WsZ4=V-9CDifDZYjJjwQmQQDDQM7ZKgZ6_-CNDPA@mail.gmail.com>
 <Zzde9xS0zGJhcoUb@gaggiata.pivistrello.it>
In-Reply-To: <Zzde9xS0zGJhcoUb@gaggiata.pivistrello.it>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 19 Nov 2024 17:35:36 +0800
Message-ID: <CAA+D8AMx14hp51aH7Y=Sgu+X+_KxQ8zdJdrQHFY84nKtQsKKrw@mail.gmail.com>
Subject: Re: clk_imx8mp_audiomix_runtime_resume Kernel panic regression on v6.12
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <frank.li@nxp.com>, abelvesa@kernel.org, 
	peng.fan@nxp.com, mturquette@baylibre.com, sboyd@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, Adam Ford <aford173@gmail.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Mark Brown <broonie@kernel.org>, 
	ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 10:47=E2=80=AFPM Francesco Dolcini <francesco@dolci=
ni.it> wrote:
>
> On Fri, Nov 15, 2024 at 11:13:58AM +0800, Shengjiu Wang wrote:
> > On Tue, Nov 12, 2024 at 5:20=E2=80=AFPM Francesco Dolcini <francesco@do=
lcini.it> wrote:
> > >
> > > On Tue, Nov 12, 2024 at 08:59:58AM +0100, Francesco Dolcini wrote:
> > > > On Mon, Oct 07, 2024 at 03:25:55PM +0200, Francesco Dolcini wrote:
> > > > > it seems that an old regression is back on v6.12, reproduced on -=
rc2
> > > > > (not sure about rc1).
> > > > >
> > > > > The original report is from https://lore.kernel.org/all/202404241=
64725.GA18760@francesco-nb/
> > > > > and it was fixed with https://lore.kernel.org/all/1715396125-3724=
-1-git-send-email-shengjiu.wang@nxp.com/.
> > > > >
> > > > > Is it now back?
> > > >
> > > > I was able to reproduce this issue once more, this time with 6.11.7=
.
> > > > As I wrote in another email the issue is not systematic as it used =
to
> > > > be.
> > > >
> > > > Any idea?
> > >
> > > Frank, Shengjiu, could it be that the udelay(5) in imx_pgc_power_up()=
 is
> > > too short and therefore we have such non-systematic failures?
> > >
> >
> > Francesco,  it seems hard to reproduce it on my i.MX8MP-EVK board.
> >
> > If it is easy to reproduce on your side, you can try to enlarge the del=
ay
> > time to see if there is any improvement.
>
> It's hard also for me to reproduce, we just have a relatively extensive
> test farm and 2 times it happened while doing unrelated tests. I was hopi=
ng we
> could have some idea on what's going on, I'll see if I can put together s=
ome
> kind of stress test, being able to reproduce it more systematically would
> certainly help.
>

With my test,  the issue reproduced with delay 5us/6us. but hard reproduced
with 7us.
I think we may need to use a delay of 10us for safety.

Best regards
Shengjiu Wang

