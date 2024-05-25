Return-Path: <linux-kernel+bounces-189274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7303C8CEDCE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 06:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274D2282126
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 04:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B913611B;
	Sat, 25 May 2024 04:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dMFp6/o2"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D4A15C3
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 04:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716610827; cv=none; b=V0wS7nGZLpIk2TwYBgKVXXQpdNx3BD2jwnqvf4emRWkaQev98sPa3bDyOnvU5cU2Zs52ToAxG88egV5l3dXhgtFSAiaXLzsskw8jme+FVnhvQlj4yU2ZCGxEDs2SOJgECbIHY4g5nMKvrNRYX8GqUbdPBa7LK4Qz5LHZuTfOlck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716610827; c=relaxed/simple;
	bh=yUTpSxbNH6db5FAa1/hdQT3OaPurqyv2ctC1i45QKag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQJWt42SqG9rSj8CFSIoEmRS/SzJP3dBSquEjHT+dOQekh3IDwj+b5gFbb3RQlPhkQvt/RFyLPC1NXc95LK030m8PabrVXKgivRKassO9s4IHCvOco0UmyPhpntgutJpeHKbN8vfbM/juA/qqC+soqElvd5UvZvpiSQVgmHF8ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dMFp6/o2; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-578517c7ae9so1877489a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 21:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716610824; x=1717215624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LLJmGwspiHr/isf1p7f95VagjPipkZ0Pc2JPelvy7/Y=;
        b=dMFp6/o2zp49ZM2C2aQbmilWBhTbzPpcWhQi38Ima8C3y0BkqXqLA9XHK6Iymsh14A
         r0CCLzTjL51dqjN3oJ1EpCEAv2VihqISgg/V4J8ERXc6HAoQeyMvd2u6zncHiU75ylbP
         M/Axfo7Vj6qtT0R5dMkrJaICOowgzCTytEQbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716610824; x=1717215624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLJmGwspiHr/isf1p7f95VagjPipkZ0Pc2JPelvy7/Y=;
        b=K2WoxJ6mUcgg0OjFxIgEzrqp7Owy+N7NuuRVQJZntj8GFuPd3N2/seWeoCSvFfipoW
         HeEpRLzqnCDu8izNCJzeL9o+O1OoZ99w9kOhdx+tWDJHv3dqWQSXRkIt8tdLni6yT/+T
         WRKsDHIZFUPil48ysXckWWiBL086J75wJBBDAYyS6Nin1vCmPxzB/8aFy8OaJwIM2rhD
         kZY44MrxsFtSvEs+iJ+tT4yyKEPcJMr60taftEugEdgm8PRxH+8wtaEZWu1JPwl95DAI
         Fm2IDonr1XheIPOhdd/r4EaJRxkSKA2DZGl2x4o/upronjYYtAD9w+30x1mxyNOSdDyG
         BtDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6DkpLye2Fd1bH2gFJb9V5CLM4/ZKWqFCjVM8J4R9o/XG+4rZRDUXS2ldF2637uLuF6Fezq8b1wV9U2kJl7iS8b3ioghz7bso3TjQC
X-Gm-Message-State: AOJu0YzWQs69PDo2QGF6goc1AG49Qk2C6E0MF+1Vi8N6eGMoqYaNZBiP
	1MrN9RBN/o2N1Lx46JhFGJKmLdVIPjWfKYXxBGTV4g+sctK5+9+QP1Rh9YIZ2RQgVsJWUUf+BzT
	xTRT61g==
X-Google-Smtp-Source: AGHT+IHVROSJ0fF7oXM+nfKXoEQ/6Vzjie0b1ibl7E5Z+rHCWwu/CR1XrTHZgxFLtuUQHo+3g3p8QQ==
X-Received: by 2002:a50:8d13:0:b0:578:5a70:fe8 with SMTP id 4fb4d7f45d1cf-5785a701071mr2294411a12.11.1716610823959;
        Fri, 24 May 2024 21:20:23 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785233bfddsm2675556a12.3.2024.05.24.21.20.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 21:20:22 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a626776cc50so189490266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 21:20:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVljcmlcU2wn/dZ5BfhuUddV8kgtoAtUrG39575yMfFu1mClcVxr/5l2Ja8owihEZT6eluHGIFYCQI0U5KBZGuqyC7GoUtr8MddtRuu
X-Received: by 2002:a17:906:28ce:b0:a52:6fcb:564a with SMTP id
 a640c23a62f3a-a62641a8d45mr253718866b.9.1716610821954; Fri, 24 May 2024
 21:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521192614.3937942-1-acme@kernel.org> <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
 <ZlFE-wbwStOqt8Ra@x1> <ZlFGpxWGQskCTjeK@x1> <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
In-Reply-To: <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 May 2024 21:20:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
Message-ID: <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Anne Macedo <retpolanne@posteo.net>, 
	Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 May 2024 at 20:48, Ian Rogers <irogers@google.com> wrote:
>
> Thanks for the report. TL;DR try putting the PMU name with the event
> name, so "cycles:pp" becomes "armv8_pmuv3_0/cycles/pp", where
> armv8_pmuv3_0 is the name of the PMU from /sys/devices.

What? No.

If that is the new rule, then I'm just going to revert. I'm not going
to use some random different PMU names across architectures when all I
want is just "cycles".

In fact, the "cycles:pp" is a complete red herring. Just doing a simple

 $ perf record sleep 1

with no explicit expression at all, results in that same

  Error:
  cycles:P: PMU Hardware doesn't support sampling/overflow-interrupts.
Try 'perf stat'

because perf *ITSELF* uses the sane format by default.

So ABSOLUTELY NO. We're not changing the rules to "You have to know
some idiotic per-architecture JSON magic".

I don't want any excuses like this. No "You are holding it wrong".
This is a BUG. Treat it as such.

And yes, "perf record -vv" shows that it apparently picked some insane
arm_dsu_0 event. Which just shows that trying to parse the JSON rules
instead of just having sane defaults is clearly not working.

So here's the deal: I will revert your commit tomorrow unless you show
that you are taking it seriously and have a sane fix.

Because no, "You are holding it wrong" is not the answer. Never was,
never will be. Things used to work, they don't work any more. That
shit is not acceptable.

                   Linus

