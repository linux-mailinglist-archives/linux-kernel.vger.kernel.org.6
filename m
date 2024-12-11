Return-Path: <linux-kernel+bounces-442035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D209ED737
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA24281127
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C5620A5EF;
	Wed, 11 Dec 2024 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FGT3KQ75"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0D1FF1DC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948836; cv=none; b=esIiiOMe4+zyxZAKLsAHw0UpeodjvdsmXtvJXTP2l+XHgW1wLNXYS7yYvZ1hXpnk94SbWeozmcPTu7zhryERwpm4MvnvnrCIhs+oeqD+tT1ZTQtfgIIpNUZhkLW1cOk/GIpSpvifwM4TCQCyPAs1D0oZYXIc3q8o1zWOJ1bv32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948836; c=relaxed/simple;
	bh=+6KsVTKiBNf0T5WxKiyslicNcKH5uqheARr/KeXIbME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odqUZK4oTpTI7n/19tMKX1XsGSTvVuydWmxQoYfdFP7PBqmMiw+UmrqTZegOML2uDQG8/zbrJcXi5FCwEhxfoC5CAbqftAO+aFDrfQW7IdnmECYC4YdG3l+Cv8doRgth7Wg0zz3WfLDhHog7l2uni9HPfDsiYSPg2uTrzgHEuzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FGT3KQ75; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa67f31a858so699089466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733948833; x=1734553633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rbt6Qzp7kYp6+9v+n7g2ohZVarku/bMVIveHt2W9FqM=;
        b=FGT3KQ75NXtTst9Vwss35Xha/GeCGPBfOGHDwOD6rhZhI60lJMkoeePKLofWRfZ1hw
         lxNHzDMTiGbXHX6yrBseDCr2tyBJUYb7/5sg7+ZcnBuitB8kC0hHAbYZPKPdhvsvof1K
         m4rDjmnx96RrR7apMNy6KF2j3UV9uBVqj6mVNQkqmrSRrNgBBzuRfYpztS+awjlNoP6N
         q9WhEubpheYa8wV1SZTXmto+6qsyyrp/Z5cQGrJvspEaMJUXxtYjvcOFHnxKsiPZAYRo
         BktImywkYWjMX0PayuHH0nGJZiVUMOMwM+4M22/Zgstkc8emtL/kEmVjdhO54ZQqU1Gi
         aaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733948833; x=1734553633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rbt6Qzp7kYp6+9v+n7g2ohZVarku/bMVIveHt2W9FqM=;
        b=UkA5tB9mGzwlmluI1KzZidmFVnoIjvGbSIHD83zgrzD+Bkt7/emvglpLfXjBdb3qmJ
         7ErPM5Gev17VMcpod5NC4cTQSIfPiJPZw1MV2+87QEVci0TCPSu+X07LjS+fANtRDyW1
         5MzKRLZpTld7rl7iZ9u23QvyQqGDDMiwrKyRlE44PiCMw0Y6OOP79HFp+wDBm7CTJdKE
         Xm9LABY9z5nLrQY0I3PSgFQYLQ6vKi7Ejx7tKEk5kYHZKeh96JUCiJeavokIImDHFCeY
         hA968/gK4sAV6t89CUHyxXk6sy5OqZo1REtbbMUisryg3t7LR1AHSDCOJE+e3xG3ruql
         HPVg==
X-Forwarded-Encrypted: i=1; AJvYcCXJtk63Jc8uho4gZeJget+UiifYyyw33MQsrbP3++go01hXAPsjOE2oY473gl3kg/OeMX7ZWuaNFnqMHgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4c0D6LJeZjhzHDezhMy8GWnY2r13ZR6z6Iy24Ss/BwABBLyPi
	RcY9+yjSOuRB2L3bZPyyPHoWe0XauKYhJvwe/suytxCLUMEN2XOcOwhiTaNRugdsLQAlTgZxM0W
	LTzNiYPZThDlb38rfTW/YGBizS0jxlOL2sl0=
X-Gm-Gg: ASbGncvdX4HTg32qpavqB2l0QiLVElR/PdjAri6uzdJDUn8LR4G3NL4Fdd9KHc2AouC
	yBmQADMHQmurfnMJNqyHSomaoPK+H/u5mojXEbcXE1DbGi/N3P8IKcyFjCi8mxpuQ
X-Google-Smtp-Source: AGHT+IHNnX0wYMBVFIGSe3M7v6rxr1UdkIt6jQEfX0+/0Dw3pXAiHvkuUd/5zMEGoWF0m8wBGNewTzim10IA85r2BNc=
X-Received: by 2002:a17:906:2931:b0:aa6:7d82:5411 with SMTP id
 a640c23a62f3a-aa6b1395822mr338067966b.40.1733948833441; Wed, 11 Dec 2024
 12:27:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211182502.2915-1-spasswolf@web.de> <87wmg69gex.ffs@tglx>
In-Reply-To: <87wmg69gex.ffs@tglx>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Dec 2024 12:27:00 -0800
X-Gm-Features: AZHOrDkJ2hJzF4GYWYCBBvsb_CcFqGLq00nD3GWsedOE0i_vDtVJ-VAbJtB0obw
Message-ID: <CANDhNCpUWk_7Ocp0fvvjsLgZavcxvFcr3ac6psaZOa0xySfxZw@mail.gmail.com>
Subject: Re: commit 894d1b3db41c leads to frequent hangs when booting
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bert Karwatzki <spasswolf@web.de>, Metin.Kaya@arm.com, boqun.feng@gmail.com, 
	bsegall@google.com, daniel.lezcano@linaro.org, dave@stgolabs.net, 
	dietmar.eggemann@arm.com, joelaf@google.com, juri.lelli@redhat.com, 
	kernel-team@android.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	longman@redhat.com, mgorman@suse.de, mingo@redhat.com, paulmck@kernel.org, 
	peterz@infradead.org, qyousef@layalina.io, rostedt@goodmis.org, 
	vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org, 
	xuewen.yan94@gmail.com, zezeozue@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 11:19=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Wed, Dec 11 2024 at 19:25, Bert Karwatzki wrote:
> > I tried to debug this with CONFIG_LOCKDEP=3Dy in v6.13-rc2, but using C=
ONFIG_LOCKDEP=3Dy
> > makes the hangs disappear or far less likely, and I get this warning
> > (2 examples from two boots):
> >
> > [   17.203857] [   T1337] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
>
> config LOCKDEP_CHAINS_BITS
>         int "Bitsize for MAX_LOCKDEP_CHAINS"
>         depends on LOCKDEP && !LOCKDEP_SMALL
>         range 10 21
>         default 16
>         help
>           Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS t=
oo low!" message.
>
> Can you increase the chain bits config and try again?
>

Thanks for the report and bisecting this down!

Can you double check that the following commit is in your tree? I
think it has landed just in the last few days upstream:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D82f9cc094975240885c93effbca7f4603f5de1bf

thanks
-john

