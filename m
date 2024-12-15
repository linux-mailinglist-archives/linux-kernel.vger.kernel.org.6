Return-Path: <linux-kernel+bounces-446491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFDB9F2501
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 18:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38731884BC2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 17:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA471B394C;
	Sun, 15 Dec 2024 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HV/zMfxh"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B4D18E76B
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734283421; cv=none; b=JlaLZVuBCOvoX72WE8erFmBB8h3InkXCKRc1QBMdBb6xqlgg5hehPhT13oH83GQdNttfA8HkQR/A1KWC9jJUQ6NZC8e99WSwmn43wHOna4vN9uonaXMsYqoyM+lgU7StGEE/EsnvaElrxNd2Z3x952H/Ojv4m/gZvWdu3VPKzkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734283421; c=relaxed/simple;
	bh=aLg5ldcVTR11W3YcKuKA8OLL/uCmalyrYgsAm17n8LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWvP1hauxZQC5yVCk8S8hNe5e4Vx/qlFQAEiWw4CJbHwf1uSDOSt0ZJ5FKGcTxmZL0AkyVpa8XZ+kJ+StCanLVsS2IZ4RIo8f5nCWj50IFTtA1oUMR1ch1UmBYlSflYWxEu9TPYgYdqupsxc7xsSJ1wFsLvVhtRZqYAlZ33gTpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HV/zMfxh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d65b4ae632so1915723a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 09:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734283417; x=1734888217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T/pWSMoGEy01nphDBYB+B2lwysFEkT3HP90ug+TA2+M=;
        b=HV/zMfxhcN8qb1k1Djwyve4rDlyE5Y6VcMgK3euZ9z+bg5WPeeiUGz23kSNUYhsLVn
         XfK/ByPYBOvmF4XuF7zeL7ljSsRw15Vqx4alZE04dNz1Ke5fSIfgnI5d3BBC+niVz3Jl
         u8PD+dkxgA0t4ExzX9TMIHpm/qzQO9ufvFzLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734283417; x=1734888217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/pWSMoGEy01nphDBYB+B2lwysFEkT3HP90ug+TA2+M=;
        b=VmbaTG9AWKUW9/oBQ18UUg/SGeeXx8dRpIcGYpbGeu50/37uSRI2WpLKXivT12/bqU
         9YlQEumfbWOZgNmd0q8TvnqFIEs5reImVCVDfa48tq4gTyXiZbcn5fTGnh32mraXw/sD
         mKsnqYvEI0Pq/rVMMfHfmeMaUZJjPRiDdgx1m6G81MLxSk0FokMV6WCpxunIf4KCR/BJ
         i+mgxReLM9aFUq5fpavJPiCmzHjRmn7JUW4IPjGnN2n1Spa+6KSyXg6AZRVkC9GfgCmF
         ubp7NTvfMziP4TEALORUrs48npfP5MMIZMlXjQQXu/x8FoHfHtrLBAOxSXgMw24c0XgZ
         vouQ==
X-Gm-Message-State: AOJu0Yw6HywyUw/waU8LgDQCrg3pcz/YspkzQAJBCMGHfvJm+UXf+sB7
	FKdnqdT4kXkWzgFsJghYfpmRSepfNzZLcAfL1CRaaMeV3TUdRA5tYtf76LYDabjOOzACI6acDV6
	uy78=
X-Gm-Gg: ASbGncvEYDWsQk2xf81cbiNzvX6hpL8uQfF6/owEPiQlhSPwYQN/qzSvdTLxNzv1cDt
	Pyprm2JeU9XQsciQOsDwxQYXvRZ8W1HcocyxDg6/uyvFP2bDjAYUpm1zCbVqr3qH6clMVtp7v64
	hA56Uc7GagAWzDO4C7RUQajZ05VsjoqhGFURTXkl51guy5bzi7SLXlrfcI17bIEvGMeQNzkYmve
	GFyRwUxfQW2p3BnQ/VPOnqAnQkS05vNkir2mYWI0mB/JSBbJggCc3mA9UPLwBDNZtSfB0/Bko/e
	OpxvRcIb+18xpbtuDnWKzKLkGopQE+0=
X-Google-Smtp-Source: AGHT+IFXWwrYfX+i7t7g6IEQ0beBuNZy/X+vNJlvKvNQHsX/X/ySH+ytKj++Xf1GLjQEvLjuBdgvyg==
X-Received: by 2002:a17:907:7853:b0:aa6:762e:8c20 with SMTP id a640c23a62f3a-aab77e96883mr936296066b.43.1734283416787;
        Sun, 15 Dec 2024 09:23:36 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963911f3sm231825566b.161.2024.12.15.09.23.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 09:23:35 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9e8522445dso686051066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 09:23:35 -0800 (PST)
X-Received: by 2002:a17:907:785a:b0:aa6:82e8:e896 with SMTP id
 a640c23a62f3a-aab76d0ac70mr784561366b.0.1734283415047; Sun, 15 Dec 2024
 09:23:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214182138.4e7984a2@batman.local.home> <CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
 <20241214220403.03a8f5d0@gandalf.local.home> <20241214221212.38cc22c3@gandalf.local.home>
 <CAHk-=wiSdtNvq_wUtq7f3oO7S7BYCeXh7a707HKvK9nVkxR=jQ@mail.gmail.com>
 <CAHk-=wh3cUC2a=yJv42HTjDLCp6VM+GTky+q65vV_Q33BeoxAg@mail.gmail.com>
 <20241214233855.46ad80e0@gandalf.local.home> <CAHk-=wh3uOnqnZPpR0PeLZZtyWbZLboZ7cHLCKRWsocvs9Y7hQ@mail.gmail.com>
 <20241215050517.050e9d83@gandalf.local.home>
In-Reply-To: <20241215050517.050e9d83@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 15 Dec 2024 09:23:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5jE5ARarmYNdL4sja36_e-mnejv3zRMC62Jzn-a3omw@mail.gmail.com>
Message-ID: <CAHk-=wh5jE5ARarmYNdL4sja36_e-mnejv3zRMC62Jzn-a3omw@mail.gmail.com>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Dec 2024 at 02:04, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> What va_list bug? That logic didn't break.

That logic HAS NEVER EVER WORKED RIGHT.

You are literally mis-using va_list. The code is *wrong*. It depends
on the exact calling convention of varargs, and just happens to work
on many platforms.

And even when the calling conventions happened to match, it only
happens to work because of how vsnprintf() treats its incoming
argument.

So my complaint is literally that the code you are fixing is
unfixable. It's a "it happens to work" situation (except when it
didn't), not a "this code is right" situation.

And dammit, you must have known this code was garbage, because when I
do a "git blame", I see your name on that test_can_verify_check()
function.

Basically, you are walking the va_list in invalid ways, because you
want to use vsnprintf() in invalid ways. As part of that walk, you are
(a) fundamentally mis-using va_list and (b) modifying the format
string as you go along (both in the sense of actually changing the
format string, but also switching that format pointer around).

My issue with this is that (b) was buggy, but it was a bug that came
from a much more *fundamental* bug - the misuse of vsnprintf.   Which
is why I'm saying "rip it out". Because your fix is fixing symptoms.
It's not fixing the fact that you are doing things that are wrong.

Looking up more, I also think the whole "replace "%p" with "%px" is
broken and wrong.

Isn't every single case of '%p' in this context from a TP_printk() situation?

IOW, instead of dynamically creating a temporary buffer and adding
that 'x' by hand, why wasn't that just a 'sed' script and done
statically?

In fact, wouldn't *most* of the sanity checking be possible to just do
entirely statically instead of at runtime?

Yeah, yeah, there's more than a few '%p' users, but

     git grep 'TP_printk.*%p[^A-Za-z]' | wc

shows that it's manageable. That probably misses some multi-line
cases, but still - doing this kind of "rewrite constant string at
runtime because we didn't do it statically" seems *wrong*.

And in this case, that wrongness was literally the cause of the bug.

                Linus

