Return-Path: <linux-kernel+bounces-433920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF7A9E5EC1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9051884F92
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A801022D4FB;
	Thu,  5 Dec 2024 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ROYskDul"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37102225788
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733426817; cv=none; b=al1FPhHT15xbqAUsUDaCgGezPX5puGFSzm29l1veey8uHUYS3iRgk1Zo7WSroLkgcP4vO70AhP1aEgreRD/sohvDX69OgteIhBbv3vWZCV9agOEsE8IQ6mv/xJAlIQvWRPGWjgfrpDaeRFN8P3QwUDyy/HtKMNyBDoBLRNXARq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733426817; c=relaxed/simple;
	bh=RKXhCMXvfJXkHiVgHUqpW4IGz6rcjdhtT4SjnmZZ6WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEBBxlnIQ266BG9V32/WaadBq1QfRv4jDUDFcHWA4OhIRgVzGmUad9vIazIcypTA96V2tv9ue3dCJlaU0Sc5ny2Vr+Or2/I2DOl647B1P/2UK1rR49Pwi4p1OsinsLfVrPmb97NlyvBUt+pKhh5o65uyCGbybL3IAFfYO8YSx8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ROYskDul; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so253791a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 11:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733426813; x=1734031613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XWh2Ea994aJGegiZF+JWYE2IVRgn2FJbG2ZX4otv3lI=;
        b=ROYskDullIt2hHKGG3DZHwAoSdf9kqjXxSY5bAnxpibdvhzljEpWnmHRcB3FJBEaoh
         UrLtt11Os6Kc1FwDC4RPMNBgxU/nHruhhbk8JxkxiCXxS6UiLcbLO7PEcu6WL4ffBSyP
         Fz/Hkl0QfvyiBl/0TJ9ylds0vfwAIWWAHaPfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733426813; x=1734031613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWh2Ea994aJGegiZF+JWYE2IVRgn2FJbG2ZX4otv3lI=;
        b=vRqNt8R0iK9nDYW1KzAmdh6Ri9oSAjC27GrVbwJNihxk6huEQc8F+VkHeRFFqUJmIT
         FPG/iOtRR++d0XAvpSOf/nsKBaE927ZDiaJ9L8k7kjfOiVyUBKJ4wt+Y4hkKWAi4vP+d
         A5XMnENQx1yj9MEoDDt2Rh12MH7fdiRZ35LOFOxE8UMA6j1fjpM4ZldinNTwtCGwWrwk
         W4tM/ls6IxDBya70QfCf1U7wJ8pXk7IUzZBeB6DCkZxzjmyQ2Va5IEJzNmIg+oQrDOgk
         aiueUGaEgi1jFDQC0CLCOPgZk5QhHWEvl9PMCc6R07ZF9wjAMWAYQcKMEkgu+R7IfeVF
         YfbA==
X-Forwarded-Encrypted: i=1; AJvYcCXtvQ/r9ODhHVoA3n4vqPvPAzpn50hT44fgcSm8NQULxCQYKhe9JloAC8tmRnXYOBnu4xCiucFzXgkfKao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmMCdLSYD53hUGu5KeaRO6ld7ZyhheXz4NchdTL9TKLkMnrZYW
	X5AyetcymElAhnH2kEbUaYMRpxTrxfCvD3zUfuxvF0G0aRd19D8y8XzicwkCVmtmqmwVhlvfew/
	SHYixIA==
X-Gm-Gg: ASbGncvA41AjuFPGYP+pyrO5oXHsyQuzVm6/C89og106M8rfOvrwJakXKwPcfKf+kxm
	Q+pd8cWNV0tM2BSfXkmKnrv0DTMGhWNMj0IvGF5Ygb3SWc6yxxYFcbWcbiAxXrwmJ4fYgFe3MZh
	kDmK6myI00ZsCX7sKHH8CN+Gdu5rqZ2vM88gQjbLIfTKO5GFuTj2zGD0fz/+c4B/5VtHCgzOleY
	qYXMB74FEoMzxZbZe6P8gi7pB7MDD85fS6fy8YkKvsYZZ+o7sHjLEI83+lpiEaiPveJ2zJ+rhxn
	nWPTwPSeOQEwhnpOO8U6owIL
X-Google-Smtp-Source: AGHT+IF3mgETUSe59D4Hi4r1BKjurvZiXzw99tRi+F/e37hnF1pnklW7AuGKN7rkDB5GgGvrPtqRng==
X-Received: by 2002:a17:906:23ea:b0:aa6:2753:ba08 with SMTP id a640c23a62f3a-aa639fa4c53mr4808266b.6.1733426813296;
        Thu, 05 Dec 2024 11:26:53 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260ebaefsm129939866b.197.2024.12.05.11.26.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 11:26:52 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so237740666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 11:26:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJW6po+uYsSEEBLicoritJSpuF40iCXq8f6y9qxwHG4NOCjcVHVZlZV0hyfY0RTQ6VmCNjfJ85Y85MnFI=@vger.kernel.org
X-Received: by 2002:a17:906:310c:b0:aa6:2605:b9ec with SMTP id
 a640c23a62f3a-aa63a26904bmr3273666b.43.1733426812112; Thu, 05 Dec 2024
 11:26:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com> <20241205141850.GS3387508@ZenIV>
 <CAGudoHH3HFDgu61S4VW2H2DXj1GMJzFRstTWhDx=jjHcb-ArwQ@mail.gmail.com> <a9b7f0a0-bd15-4990-b67b-48986c2eb31d@paulmck-laptop>
In-Reply-To: <a9b7f0a0-bd15-4990-b67b-48986c2eb31d@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Dec 2024 11:26:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjNb1G19p3efTsD9SmM3PzWdde1K2=nYb6OUgUdmmgS=g@mail.gmail.com>
Message-ID: <CAHk-=wjNb1G19p3efTsD9SmM3PzWdde1K2=nYb6OUgUdmmgS=g@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
To: paulmck@kernel.org
Cc: Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, edumazet@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Dec 2024 at 10:41, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> > To my understanding this is the idiomatic way of spelling out the
> > non-existent in Linux smp_consume_load, for the resize_in_progress
> > flag.
>
> In Linus, "smp_consume_load()" is named rcu_dereference().

Linux.

But yes and no.

It's worth making it really really clear that "rcu_dereference()" is
*not* just a different name for some "smp_consume_load()" operation.

Why? Because a true smp_consume_load() would work with any random kind
of flags etc. And rcu_dereference() works only because it's a pointer,
and there's an inherent data dependency to what the result points to.

Paul obviously knows this, but let's make it very clear in this
discussion, because if somebody decided "I want a smp_consume_load(),
and I'll use rcu_dereference() to do that", the end result would
simply not work for arbitrary data, like a flags field or something,
where comparing it against a value will only result in a control
dependency, not an actual data dependency.

             Linus

