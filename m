Return-Path: <linux-kernel+bounces-189468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D3F8CF06C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 19:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D8A1C20CCE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 17:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDCD126F03;
	Sat, 25 May 2024 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MOWnbdJ8"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC0D8664A
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716657754; cv=none; b=ZUsOvZBF/rbAZxzVz3iloxrx+jtjy+cqp/aXXXDQDAMQZTU7CWGWhhbjYVdv0BNbVdH/TEaAPUdMX0oHAoEMKlELXjSYgIhIcLAiedW3rxkh7Au0Jne/VyOutSbVvvBo/DX1Nwz0Ma0pxUPiTw4WYLx8oS1guB6dG7QamiRUv8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716657754; c=relaxed/simple;
	bh=0b27gHz25rPfYL/9z2pWCcUIqtjMCjhiVdHPOcrZPrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJ8DMgsppJDGKfFxSuVPHuPWrnz2luDc4rmBObwXqmXXkcPLk0AUY58rMeaDqaQJfF1zvyaDf72hatnFAGx1FrZVG0t8Tj5Hos0Zky3brcXbFZXJoJUR1f8AD4EZHmYP11YZ3aNfrmlLWYm3B9ZQv9ESfoK7728doM733OGjwho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MOWnbdJ8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so7527416a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716657751; x=1717262551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JzN3wtHA1BYDhfS4dK8COke7X2DpPeCn0vB2QuxJE+w=;
        b=MOWnbdJ8LmcqMM8VFzdOBjXa7GKivOODFnGkh/8xb/uZp9rgQCc7J6ZqCe4DbKBjSJ
         sAWHXfCq4Ly3C14n3+BlcCDqjl8WUKIhmcYqAn9gg0L+EL9IWGzwmrdk/dCNmD4hFsc5
         9CmsmT0gDNWNfXAMsgS1dIxk4OU7Af1tSeykE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716657751; x=1717262551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzN3wtHA1BYDhfS4dK8COke7X2DpPeCn0vB2QuxJE+w=;
        b=UiQDNDvbzePHodo71I5SEK74GBu+Lc/9hhUiCosc+DgM/gIWWE8wTmiHR7sWdY/1BP
         p2vxUL8nPtgWUZed8rTUg+67EkTfetAirhd8F8VteuY/pXVD3rMlJZTHHDCOuiO9kK1d
         rJsiRJk0gUOoaE9NheqYxiHnzQpOSStLR4rqzJCkjyqFoSnSWT3XAKdIGI9R0BUHaNIa
         0AX//JqQXRTZR4Hmgej9hrVmmTXEoyAQ4QYKGl9VYRfIW1ia81P5H6wiLQRPmmmP3A95
         2HqzXY35JHijYRgFQpcWnYCSB+DY+uiXwWl9x70auDEmTHs3wZ/a73BrwbAO3SbcLhsV
         F/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUZLNZ3a/fJnclHMjKoyW4C2Alp4YetDZ1zjwCJ5xRmDDU0xn3z11bEqZW0/afzp2WDkb3HwLdXJ/w2bMZDIV1UQzpHrtGrpc5DjkHe
X-Gm-Message-State: AOJu0Yxf14FS28+lwKCYOf38eOFU9TJZlykpRmi3HKEQPnDPaBqzJ+QB
	WyjDToAJQ/3RLSlQpHe+JgtsceFNjIiEGAfw8d9ruWrtRNmVkpsaMLE6Qma4Uu9oMsMCMCmslQQ
	L8TuJ/A==
X-Google-Smtp-Source: AGHT+IGnvsGspCz+K7nqyuquEyL3/OQQWEmCbcjrf8lod87VrO3PBrbdj0ixzjeKd+akKZA7qchSeQ==
X-Received: by 2002:a50:cd01:0:b0:578:6019:265a with SMTP id 4fb4d7f45d1cf-578601927e8mr3549200a12.8.1716657751143;
        Sat, 25 May 2024 10:22:31 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578524bae15sm3350094a12.86.2024.05.25.10.22.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 10:22:30 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6269885572so311637266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 10:22:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRCEs2b+qpo4pTLc9spmykcnsvLyVRUWJF6s+44XsZogZmSPzgMc5aCqSgm1VsDC+pHISle0UffYvJjPt8/38dF+kMQL/GsxCEkj4V
X-Received: by 2002:a17:906:34d3:b0:a59:ac10:9be5 with SMTP id
 a640c23a62f3a-a626250e4dfmr486825366b.27.1716657749826; Sat, 25 May 2024
 10:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521192614.3937942-1-acme@kernel.org> <CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com>
 <ZlFE-wbwStOqt8Ra@x1> <ZlFGpxWGQskCTjeK@x1> <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
 <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com> <CAM9d7chXVsoNP6uYMCqy2MZOiWkt4GrFn+giYLHQjaJRsap1Cw@mail.gmail.com>
In-Reply-To: <CAM9d7chXVsoNP6uYMCqy2MZOiWkt4GrFn+giYLHQjaJRsap1Cw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 May 2024 10:22:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjY7CG5WRZQ3E1gdEO9YtUQstMe7a=ciShY0wz0hKXyuQ@mail.gmail.com>
Message-ID: <CAHk-=wjY7CG5WRZQ3E1gdEO9YtUQstMe7a=ciShY0wz0hKXyuQ@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Clark Williams <williams@redhat.com>, 
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Anne Macedo <retpolanne@posteo.net>, 
	Bhaskar Chowdhury <unixbhaskar@gmail.com>, Ethan Adams <j.ethan.adams@gmail.com>, 
	James Clark <james.clark@arm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 May 2024 at 00:38, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Yep, so I'm curious what makes it fail.  IIUC the commit in question
> would convert "cycles" event to "${whatever_pmu}/cycles/" if the pmu
> has "events/cycles" alias in sysfs or in JSON.  But it should work after
> that too. :(

Well, having looked at it some more, I have the main CPU PMU:

    /sys/bus/event_source/devices/armv8_pmuv3_0/

which has a 'cpu_cycles' event, and the cpumask covers all the 128
cores in this thing.

That's the thing the regular profiling *should* use:

    $ ls events/
    br_mis_pred          l1d_cache_wb        l3d_cache_allocate
    br_mis_pred_retired  l1d_tlb             l3d_cache_refill
    br_pred              l1d_tlb_refill      l3d_cache_wb
    br_retired           l1i_cache           mem_access
    bus_access           l1i_cache_refill    memory_error
    bus_cycles           l1i_tlb             sample_collision
    cid_write_retired    l1i_tlb_refill      sample_feed
    cpu_cycles           l2d_cache           sample_filtrate
    exc_return           l2d_cache_allocate  sample_pop
    exc_taken            l2d_cache_refill    stall_backend
    inst_retired         l2d_cache_wb        stall_frontend
    inst_spec            l2d_tlb             ttbr_write_retired
    l1d_cache            l2d_tlb_refill
    l1d_cache_refill     l3d_cache

But the thing that seems to have confused the new parsing is that this
machine _also_ has

    /sys/bus/event_source/devices/arm_dsu_{0..63}/

which all have a 'cycles' event:

    $ ls events/
    bus_access  cycles     l3d_cache_allocate  l3d_cache_wb
    bus_cycles  l3d_cache  l3d_cache_refill    memory_error

but these things are basically some "each pair of cpus has some bridge
to the L3", which is why this 128-core machine has 64 of them. So each
of those have something like this:

    $ cat cpumask
    40
    $ cat associated_cpus
    40-41

I did not look any closer at what the 'cycles' there can actually
count, but clearly they can't be used for recording. And even if they
can, they shouldn't for the default "cycles".

> It seems my system doesn't have the alias (both in x86_64 and arm64)
> at least in sysfs.  I think that's why I don't see the failure and maybe
> there's a specific hardware issue - like a M1 macbook issue?  IIRC it
> required the exclude_guest bit to be set, but I think we handled it already
> so this must be a different issue.

This is my new Ampere system, which has basically replaced the M2
Macbook Air as my arm64 test platform, since it builds the kernel a
whole lot faster. That's what 128 cores will do...

Ian's patch at

    https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.com/

makes things work for me again, but I get the feeling that the JSON
parsing is too fragile. It should have noticed that the 'cycles' event
it found wasn't useful for profiling, and gone on to the next one,
instead of just giving an incomprehensible error message.

I think the real problem was that the JSON parsing code blindly just
looked for "cycles".

The only thing that seems to make Ian's new
evlist__add_default_events() special is that it uses
"perf_pmus__scan_core()" for that cycles finding, which in turn then
uses only the *core* PMU's.

It feels to me like the "parse the JSON info" is just too fragile,
picks the wrong events, and Ian's "add defaults" just works around the
weakness.

But whatever. With his patch, at least it works for me.

                 Linus

