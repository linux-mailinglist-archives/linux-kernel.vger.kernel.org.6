Return-Path: <linux-kernel+bounces-426383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A879DF267
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 18:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDB42814B7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 17:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754791A76BB;
	Sat, 30 Nov 2024 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FA9qHEJZ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415CF43AA1
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732989302; cv=none; b=MyGHJsV3z74azqQp/RH41H5EjFt5H/oUzR2ynNhQ7dCONCyXV52Vh72Jkx4WzXAJqc9yufjDgQNtVZYYHIhx1UH0TlQkb4R7N+8k4iZhLtCdeE/wZhIX+yByDifLBjtrEvreV5iz/dgjSLJC3vSKOkIYkWmf4vZzLAPQey9aAjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732989302; c=relaxed/simple;
	bh=TBkohQCe2NGHE89Lnt7hpzegbj2T78s6vHSK58z3pLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oa6SuCnA2Pupuvac4m0z87mNSF2boSRKwLGRY0vGFxNIuyaqlwK7LYSHQIZJdeyTPnCG0rddy6UkVts6Pcv6XQEIhR3snnV5G9x+7prgpIvJj1noJTU93OJ5WW+kgnycUCaHJqtEnpvGleUe8GDQFykgBFmdTiadXcoFAjkwxpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FA9qHEJZ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa5366d3b47so443323466b.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 09:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732989297; x=1733594097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UmhUEJ3l16+JAXSnSdZ675vJ19gWez6ArVsbJQ9w8QQ=;
        b=FA9qHEJZglcnSKOUnddX17x1L48R2SQuuJduUsr3mptOyXebGFsvAhfHHref6Zu4Xu
         hS9BGvNCpk5IeoDfZE1dDnRm1jP8yg8MkdXVCdOgG7ObNGg1BjX+9WR793QY4eic+f+E
         t2R/642pqzP6cUY1gRybGsYzw7bniiqt6ySy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732989297; x=1733594097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmhUEJ3l16+JAXSnSdZ675vJ19gWez6ArVsbJQ9w8QQ=;
        b=Gh8Suwrj5mYwjS0RQ5fdemo7GIDpdqPlsedL4Re2rBnZK6CuBCmpSBWlo8SqZDuvfG
         lwUiajBIuK5J7kkItGkjDdhJsv8gYTvY3oH79qNPxIQ4eN3oDtyKqpEJDg1uFdCQC5n1
         JLV9GbAvtht17RoLBqhQCeP4HmfkSd3hDewnThvDxCuNHkRai2q90ysCiYrdI30t3KI1
         7fWQAldylCIP9xAuzrvHpzP0WL9aPrT+cnfNUUBfs+Q2Etp9RhIY2lPgMngYNOp5a3ir
         w1ILX4YIwYQnxK6ZzNBm5dDD/XIzF+1hgrl9GBEJQy4NcBApqK7RKZ/v/dc9oqd+SpBb
         3m5w==
X-Forwarded-Encrypted: i=1; AJvYcCVfG0/rbdTwNU8Nx2U7pEHYAk36JLhzc3X/45L0TVd/AOBJHuXI+Qubm0J5gRwy/frZMmCf1da0D7o8XPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFQQ9jYQl1aNskIKicz4O0iWA3bEdv3lYqlNsQKJsGk3fA+m6i
	/pf/pJEYClFCHQ6rn7u/Wyh6qxfOESw760CZR7ne8f/vqqFKW8v5xVnXCmeE1xc4XGyFZeQn8IO
	4FSAdgQ==
X-Gm-Gg: ASbGncuBIyvoH1BJNzxSfb+tQ7LW0QP4AKbXApopwi/RzwlVCau2MEMSzTuMkkyTDEe
	MybY3eWh4GnpWcD7VMGQtSLv1sW5/c/wI9KScdDmZm8eLzj+JTDAkA9/wLaM0YtiYJXKj4xkgxn
	6yFrGduUI52mcURU5isggIBBxF8TSv59iyajIKrOeGXdEpcIjlPgJ0girdSHbWEt2XNdfG6jyCu
	ruJks/LWGgJGvvTMcmslDD2DwVS0lYbvlB/EMUpp5/K9X5srKPXpdOWz5qfcQbatxSjYJaiv/Mk
	UQ4lwTfe+toy+AH6KLyKEcWi
X-Google-Smtp-Source: AGHT+IEzWqSAsmkGSXCmjCw4KrLoLFyu1UDEXaehpxvuq5mHa56iuRDGAKt881RQIMrHvsuTiV368g==
X-Received: by 2002:a17:906:cd2:b0:aa5:2575:e75d with SMTP id a640c23a62f3a-aa580edfbd0mr1223666366b.2.1732989297388;
        Sat, 30 Nov 2024 09:54:57 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599905c56sm300565566b.142.2024.11.30.09.54.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 09:54:56 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa52a5641f8so399935166b.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 09:54:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUu9rCI1Z/alhIuC+2PrjkogQ1PlS5W+2LrIr70arvGPoiiQUMVwfJSBFWyBolR2g7vp6F7jX2QY3ioIXc=@vger.kernel.org
X-Received: by 2002:a17:907:780e:b0:aa5:1d6a:540b with SMTP id
 a640c23a62f3a-aa580edf9f2mr1127107466b.1.1732989296168; Sat, 30 Nov 2024
 09:54:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411301528.342383d8-lkp@intel.com> <069d686ab958d973563cfad52373ec6c8aad72ca.camel@surriel.com>
In-Reply-To: <069d686ab958d973563cfad52373ec6c8aad72ca.camel@surriel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Nov 2024 09:54:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj0HyNR+d+=te8x3CEApCDJFwFfb22DH5TAVyPArNK9Tg@mail.gmail.com>
Message-ID: <CAHk-=wj0HyNR+d+=te8x3CEApCDJFwFfb22DH5TAVyPArNK9Tg@mail.gmail.com>
Subject: Re: [linus:master] [x86/mm/tlb] 7e33001b8b: will-it-scale.per_thread_ops
 20.7% improvement
To: Rik van Riel <riel@surriel.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 09:31, Rik van Riel <riel@surriel.com> wrote:
>
> 1) Stop using the mm_cpumask altogether on x86

I think you would still want it as a "this is the upper bound" thing -
exactly like your lazy code effectively does now.

It's not giving some precise "these are the CPU's that have TLB
contents", but instead just a "these CPU's *might* have TLB contents".

But that's a *big* win for any single-threaded case, to not have to
walk over potentially hundreds of CPUs when that thing has only ever
actually been on one or two cores.

Because a lot of short-lived processes only ever live on a single CPU.

The benchmarks you are optimizing for - as well as the ones that regress - are

 (a) made up micobenchmark loads

 (b) ridiculously many threads

and I think you should take some of what they say with a big pinch of salt.

Those "20% difference" numbers aren't actually *real*, is what I'm saying.

> 2) Instead, at context switch time just update
>    per_cpu variables like cpu_tlbstate.loaded_mm
>    and friends

See aboive. I think you'll still want to limit the actual real
situation of "look, ma, I'm a single-threaded compiler".

> 3) At (much rarer) TLB flush time:
>    - Iterate over all CPUs

Change this to "iterate over mm_cpumask", and I think it will work a
whole lot better.

Because yes, clearly with just the *pure* lazy mm_cpumask, you won
some at scheduling time, but you lost a *lot* by just forcing
pointless stale IPIs instead.

            Linus

