Return-Path: <linux-kernel+bounces-294609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE47C959011
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF27283D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968831C68A9;
	Tue, 20 Aug 2024 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N1JCi1B/"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF76814B097
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191107; cv=none; b=fX9OMPWPEBPUMChYBbdgc+nmcfEbfls8AigGre4yWsuzNMWQH6ZxeSEJ9xTCXArdjKc2QrC0XqJLcHkaKPtvyiKG5GIkPfQ/nJ4DFO6B04cpx0XXor6HT0R5VLCmT0DrLJneQFtBuUn5/HqLkJK03P/5crtWaefH4rBYdHz9Ez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191107; c=relaxed/simple;
	bh=6aJg8eWkIu6E+nuBgwiwCdUGFgcdw16iAxyUgSWdpYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkLWQmvK0RklFN6PhV+wAp1eZ+pbuC3aN6/wXuI3X2Uyhyfy8Usa5Dq/D6ZmZvV30gZ8gcxGnm98XkvgM+NaG5Z3WqUelOa2OvJStLjB2mtTKGUC9MnX3RyLd4JzPP/sZaO9KRaGpPjT/2W9O/N8sZbQexIXydm2xcXx8EhYEVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N1JCi1B/; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f3f68dd44bso3927921fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724191104; x=1724795904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U+YfgjBbjapgsBjbRcnfMrP6oWrjX+7ArLGJFDDZNek=;
        b=N1JCi1B/YP+rI+s5jiGOJbi3HEYN+wu/u+D1rRH3BNoSCkXxyyco0XF6AoRGgYsmhM
         LbvwAbP2s2d1QxobPXuVvdk+b/sKz0Ax7CHJk6duxKWNpoV04/ulCEoRpSKUKpf+17fd
         /HBemzi1+xGdU5DfDtuVg0T8r0k2jQ6IQBDsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724191104; x=1724795904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+YfgjBbjapgsBjbRcnfMrP6oWrjX+7ArLGJFDDZNek=;
        b=e354LPKGRz9GlFdSMXcFg07+xVHmK2kDsaoQ8jxALUndPYQiuePS/AlLKo8lfbAu0+
         5owPABwaLuRCQBFKvS+BTrVVP8XC5u+2Iwoz8pOGHyQhoOgsaD0Y6UVZcaSTn6vR3LZU
         ZiJ9aobKA01oCM8SwH+uqR+1o1YMVhHON3RNoCLxSqLvgRe/VT+HfjBoRtAg5GWu4rxJ
         dbduX6ZrNqULqV6FQzHIE9S8dzdl2XtMTmcoLF4nL4pZOMJBLb9qD+X0kRr01QB5LYeq
         8F2UElRvxnxGD1+8h+OZwidpoKHjORcuK0CAhr1vIr0RgpHRMqZYc5WfTuZtmgOT0V5P
         FtoA==
X-Forwarded-Encrypted: i=1; AJvYcCVO0nx8ISCzcyOWzhQYCc0XToX7/NjMGs3qTdtyLJKSQRM9BwE9uDaOP6+wzgZdV/uu95Tn9Ph3LiYW1iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZb9pYhLeSQQn63Wi4+oeduiJSWWL+AvUdvgM75JOcfcld9Beq
	UBAmHML6AhybX9Tw3cIBU3OU//6EZjXT6jouPyb60v++ApGig4+iz80m3y6Zxl1qxlPZdIHBnL7
	kCYnVuw==
X-Google-Smtp-Source: AGHT+IHJGotp1vIt62CkilUL0/fB3fJRxoZ0OKCQIrEn+D3UYpRrADDs6AKF3rdmVCFCUbqLLj5Jmw==
X-Received: by 2002:a2e:8708:0:b0:2f3:f358:8657 with SMTP id 38308e7fff4ca-2f3f8953075mr1598871fa.44.1724191103046;
        Tue, 20 Aug 2024 14:58:23 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f3ce4d1df3sm10895001fa.35.2024.08.20.14.58.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 14:58:22 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso3416538e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:58:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlCDn/q/KwKsv9HapP0z2ZFhwK2LwCwujkpvVeV6h9jun/8m4t7+fA/gLnFW+Bvs2OEIp0pjS/LwBU970=@vger.kernel.org
X-Received: by 2002:a05:6512:114d:b0:52c:818c:13b8 with SMTP id
 2adb3069b0e04-5334857f579mr82520e87.4.1724191101986; Tue, 20 Aug 2024
 14:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819053605.11706-1-neilb@suse.de> <CAHk-=widip3Dj5UWs8MVGgxt=DJjMy1OEzZq9U8TMJAT3y48Uw@mail.gmail.com>
 <172419045605.6062.3170152948140066950@noble.neil.brown.name>
In-Reply-To: <172419045605.6062.3170152948140066950@noble.neil.brown.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Aug 2024 14:58:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxS9qM36w5jmf-F32LSC=+m3opufAdgfOBCoTDaS1_Ag@mail.gmail.com>
Message-ID: <CAHk-=whxS9qM36w5jmf-F32LSC=+m3opufAdgfOBCoTDaS1_Ag@mail.gmail.com>
Subject: Re: [PATCH 0/9 RFC] Make wake_up_{bit,var} less fragile
To: NeilBrown <neilb@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 14:47, NeilBrown <neilb@suse.de> wrote:
>
> I can definitely get behind the idea has having a few more helpers and
> using them more widely.  But unless we get rid of wake_up_bit(), people
> will still use and some will use it wrongly.

I do not believe this is a valid argument.

"We have interfaces that somebody can use wrongly" is a fact of life,
not an argument.

The whole "wake_up_bit()" is a very special thing, and dammit, if
people don't know the rules, then they shouldn't be using it.

Anybody using that interface *ALREADY* has to have some model of
atomicity for the actual bit they are changing. And yes, they can get
that wrong too.

The only way to actually make it a simple interface is to do the bit
operation and the wakeup together. Which is why I think that
interfaces like clear_bit_and_wake() or set_bit_and_wake() are fine,
because at that point you actually have a valid rule for the whole
operation.

But wake_up_bit() on its own ALREADY depends on the user doing the
right thing for the bit itself. Putting a memory barrier in it will
only *HIDE* incompetence, it won't be fixing it.

So no. Don't add interfaces that hide the problem.

                  Linus

