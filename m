Return-Path: <linux-kernel+bounces-244846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9EC92AA40
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEC11C216E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6EE2233A;
	Mon,  8 Jul 2024 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDj5Ntu9"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83429208B0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720468867; cv=none; b=BKy/u4KMrdw5HUWfaDsXgXF+fUeo5uyT8bBLQFqlwAX7SsrbG7FjRbKnUj+b+woNaoMBr/m2sQZPb+Ue3ZHFUozcSt9OVb49UOG7s4V/9A5HghTwrLCXBBszol5Y5zDVfnHzQZDraiz2Mj9lbAQw+PsIMBYVERzgNrWCpTHE9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720468867; c=relaxed/simple;
	bh=h90f6fLktIu1HBZ8opHuxfw9LxTv8oTTaF1DCZ5fFZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jptJfwWXWRN+O2jcsNwHqRs0FBBjGSeel3SngkEnWSIzqgFZ8UtS+w5hsgVyA9eIo9pIXPOv6gdE8W+EBoLZrkrltsoDxcLh1gT1adA4W2uIfVVYQlEV2CSeKYVFnyPtGU7Y3EuepBTwWOkTK0dcyDfxuP22b2hxWhr0GPwCJTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NDj5Ntu9; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c9a7323e62so2145297a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 13:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720468865; x=1721073665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JKofRGCVbdBaxylVyvWkAtca/dIYQIMpyiEB7Yojpz4=;
        b=NDj5Ntu9qFsgZCT+CouRtObh50WDTxR1AtKJ4HalD+tgfDXbiY0EdsUO+Uhc6zvu/4
         OAJZcqA99aLrncdyJMOGMHri2BQFPrPWJTjwqggcWGXqGF5/jA6fQyvuzLEevhVJV2OS
         XjF203eHeUobS/VKvTtYwqtE5yomRqWKqJF880u6VocuZQuPC5+VzvXxW3Ww0Ke1YVKq
         gK5uh4bou2tmqeKVfiYCxIV4qtadwefpY0V1r/zp5MpDK1Mkrs1s5baZxoJL+GZp9CWY
         lonwzhp/ruaniQtAlTHiBaCYSzVbpKpxlyTP85xNm6xySGAlfRl9GmGG0OVwLKuhj6yb
         msIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720468865; x=1721073665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKofRGCVbdBaxylVyvWkAtca/dIYQIMpyiEB7Yojpz4=;
        b=SlGorTWrKn7FZmWSaXUSfrXNtj/kY5WixV4NpKuPw5XZqiF5WzWcpfzfML8ouwfT0a
         O4X+EbRMZFcd10lTgr2h/oelOPABCFJ9ajUGF0fWpzYekRfxDQvB5xBj9v4Yf01PdTb7
         PV92FzhfJ64Z3mO6YonMf208t4If5uHV4CUH3mQOFVMtIdMgv1I+RU6mKJPlRMftuC3P
         nzE/gcuZjg+DYXhnivZzwWawt/kJSBCQTvuouOZQeJnmQR3UHiTzr/CbUewv82q1lwQ2
         IXwpTI8BhWSh+1UxFPBZDhdqCEGkLhb1PcIO3+xPI+0acgyHJBEHZMfvtwfC/8xm7EB5
         vHug==
X-Forwarded-Encrypted: i=1; AJvYcCU3M+Cy7iFP2mR+CRMx3MzkzQd6jVC29krsyrE/CRmXl8b0RIibJRegnJhDP5Gw4G/FVojszy+NmI1mB8Sb0JK0EcBQ5RrtP7bzRzG3
X-Gm-Message-State: AOJu0YxkEfybYBu/ED5iBxnSd71ZTVGtzqzAq3ulpibXA0Tfihvhf5Cq
	bFopCGSC2Dzdk9cytkIsZiHY9TuiHdKc3zCUkEvE7Ivy+CU4m6QP9Ja3kmke49W/EX7SL5fdK68
	aGfrJGCVGQ9c9cUvOBFtKAzQdkioGF+8egEuMtA==
X-Google-Smtp-Source: AGHT+IFztnCuCRrbApG1GuZVo5/3MzzM9skVkiyuEleO8prqkTs5JqjFclMOe/J0WMPG/dXnaF3KupnbFOLmkqgWyaE=
X-Received: by 2002:a17:90a:fd83:b0:2c8:7330:68b3 with SMTP id
 98e67ed59e1d1-2ca35d3da20mr571322a91.39.1720468864736; Mon, 08 Jul 2024
 13:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708075752.GF11386@noisy.programming.kicks-ass.net>
 <alpine.DEB.2.21.2407081038350.38148@angie.orcam.me.uk> <20240708095520.GI11386@noisy.programming.kicks-ass.net>
In-Reply-To: <20240708095520.GI11386@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 8 Jul 2024 22:00:53 +0200
Message-ID: <CAKfTPtBiYfoDWAA+wzk0=MiztZzWz_232fjvhnJrHz6XTgZwaQ@mail.gmail.com>
Subject: Re: sched: Update MAINTAINERS
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Ingo Molnar <mingo@kernel.org>, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jul 2024 at 11:55, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 08, 2024 at 10:47:18AM +0100, Maciej W. Rozycki wrote:
> > On Mon, 8 Jul 2024, Peter Zijlstra wrote:
> >
> > >   Thank you for having been our friend!
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -19929,7 +19929,6 @@ R:  Dietmar Eggemann <dietmar.eggemann@ar
> > >  R: Steven Rostedt <rostedt@goodmis.org> (SCHED_FIFO/SCHED_RR)
> > >  R: Ben Segall <bsegall@google.com> (CONFIG_CFS_BANDWIDTH)
> > >  R: Mel Gorman <mgorman@suse.de> (CONFIG_NUMA_BALANCING)
> > > -R: Daniel Bristot de Oliveira <bristot@redhat.com> (SCHED_DEADLINE)
> >
> >  I think perhaps a CREDITS entry would be due rather than just dropping
> > from MAINTAINERS.
>
> Ah, I was not aware of that file. Yes we can add a few lines there.
>
> Thank you for the suggestion.

For the patch and this

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> ---
> diff --git a/CREDITS b/CREDITS
> index 1a1a54555e11..a58066be6d73 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -271,6 +271,9 @@ D: Driver for WaveFront soundcards (Turtle Beach Maui, Tropez, Tropez+)
>  D: Various bugfixes and changes to sound drivers
>  S: USA
>
> +N: Daniel Bristot de Oliveira
> +D: Scheduler contributions, notably: SCHED_DEADLINE
> +
>  N: Carlos Henrique Bauer
>  E: chbauer@acm.org
>  E: bauer@atlas.unisinos.br

