Return-Path: <linux-kernel+bounces-180959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C518C757C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B4C1F22E53
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7BF145A09;
	Thu, 16 May 2024 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjWK6WEW"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC5F2D054
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715860272; cv=none; b=gzcV0unvLUzMmVPaHO4iJIOhDrDz39Jrr8ankjWnRJA8V0iH19kI3eS1p8/pHiTSb9xNLMYe+46+x9dSX9H5zXUMRA10wlrLrsslpENGssEy56/St6CpRlt1+5EERqOo6mQXVC6m51n1P/Tf0io7iDTY0N7wk8lIXzAe6Q8i7mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715860272; c=relaxed/simple;
	bh=2RFvru3qNs5Q1GzuN1S7DvoV9ae5pgaXt+awmuUkakc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgXVkfdiXQg0WjW/yu9JtluVsmia+K9rOhCCfbsTw1ApA08j/4pmkNLjaX/3uPiTajdKHmZNqhbweR9je+wrbtJcxwB4oXXnTiV0q53ktspMzm3nyblgEu1P2RXBONAtel5guDXK7z17USV18DfeSAbHARYt3gNRaR80xNOBaLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjWK6WEW; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e45c0a8360so7324281fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 04:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715860269; x=1716465069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RFvru3qNs5Q1GzuN1S7DvoV9ae5pgaXt+awmuUkakc=;
        b=SjWK6WEWQKFbRyg1UobI+OtS5uuhxHQiYMJKfJ/C7NRy5qOXGBj9001zoXD7hHCbpb
         Bldc/fcy+ixBcdlgmm8NCVBCTLxmfllKerNP0ib73AxXjTPGSMoi4Y8FDUsV8bFblUzF
         3Cn101M1AmZcxF2eCgXSayOUQWgq9Uv+0AU6mmeMl7798+tebJwXV3TRgeBsiIXhy6FT
         +d9HLHylUUbxIK2lY9nQted9I2eF/lhbYnUJ81HR2vT5+OYCX0jvfOuKMd+Ry0/Yc2BR
         wLUPRIQBclppFQoaBGpgLgADu2HnWipDieCj4oTrUVHKMiH9mukoBiTDLl4dLfI429VH
         jdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715860269; x=1716465069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RFvru3qNs5Q1GzuN1S7DvoV9ae5pgaXt+awmuUkakc=;
        b=bmf9He7ro4jkynRzLc3K8ChDYUt3CEmX0q4YICQ5PTXtPA7eqocnICBPbuCSBQtHRv
         EwIU+rWqWxV3pdkn7v1VRBPEek/Rhm4IwB+Evg4lsz6Q4Yotw4CmSi/RQf2ofa+L6ZC0
         Ld+KYt3IA6g3I84OF+l+8vfYyLTwsSQk1v5JPsrAmon1MMeOocuUxp65Om5jHkn5Aca6
         spz+bujojfJ7sm4HSguhXc0WtrEWOA3obYHIsiENdyHck8pJ7jvol13LgXMAOSrPcXnk
         +vRno2uxuq15oLnvk92IibVzmzHK77VGEpEkSeSBz8mpAFkP3kXS8xt1nQ4KShsazjeO
         9qCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWyiXHQ7uWmeUeNF/HqE3itFo1HxZI92Ad3MKxOJKdYKjgNIHlww0AKWerrGnC0kpJDx4ervHqdgRq31x/0h72Fzd2NxIltsYA6rO3
X-Gm-Message-State: AOJu0Yy+S66gk5wDPZD5LT0a1jEtDq/sbNRx4bpgp53u7J82K0wDIcrR
	DzPIi70/SPZTQt78U/iXQCR6jXkmh1xU3ioBYM+Q0V1HFQV8YbQaqwvRj4US7uzE26BRQAdpJBH
	pACjH6HOc3jeQ04g2arjb53pPMFQ=
X-Google-Smtp-Source: AGHT+IHJSkt+9LtPwNrcnP/V+x/wC3MzMQ76225JAhHnRc8Pez8DttnaDS3TUlvL25SMxe5ejVccAkTR7sRW2aT/BAA=
X-Received: by 2002:a2e:3218:0:b0:2d8:3e60:b9c9 with SMTP id
 38308e7fff4ca-2e5204b2e71mr115151651fa.33.1715860268727; Thu, 16 May 2024
 04:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418142008.2775308-1-zhangpeng362@huawei.com>
 <20240418142008.2775308-3-zhangpeng362@huawei.com> <ec2b110b-fb85-4af2-942b-645511a32297@gmail.com>
 <c1c79eb5-4d48-40e5-6f17-f8bc42f2d274@huawei.com>
In-Reply-To: <c1c79eb5-4d48-40e5-6f17-f8bc42f2d274@huawei.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 16 May 2024 19:50:52 +0800
Message-ID: <CAMgjq7DHUgyR0vtkYXH4PuzBHUVZ5cyCzi58TfShL57TUSL+Tg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] mm: convert mm's rss stats to use atomic mode
To: "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc: Rongwei Wang <rongwei.wrw@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, dennisszhou@gmail.com, shakeelb@google.com, 
	jack@suse.cz, surenb@google.com, kent.overstreet@linux.dev, mhocko@suse.cz, 
	vbabka@suse.cz, yuzhao@google.com, yu.ma@intel.com, 
	wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 11:32=E2=80=AFAM zhangpeng (AS) <zhangpeng362@huawe=
i.com> wrote:
> On 2024/4/19 10:30, Rongwei Wang wrote:
> > On 2024/4/18 22:20, Peng Zhang wrote:
> >> From: ZhangPeng <zhangpeng362@huawei.com>
> >>
> >> Since commit f1a7941243c1 ("mm: convert mm's rss stats into
> >> percpu_counter"), the rss_stats have converted into percpu_counter,
> >> which convert the error margin from (nr_threads * 64) to approximately
> >> (nr_cpus ^ 2). However, the new percpu allocation in mm_init() causes =
a
> >> performance regression on fork/exec/shell. Even after commit
> >> 14ef95be6f55
> >> ("kernel/fork: group allocation/free of per-cpu counters for mm
> >> struct"),
> >> the performance of fork/exec/shell is still poor compared to previous
> >> kernel versions.
> >>
> >> To mitigate performance regression, we delay the allocation of percpu
> >> memory for rss_stats. Therefore, we convert mm's rss stats to use
> >> percpu_counter atomic mode. For single-thread processes, rss_stat is i=
n
> >> atomic mode, which reduces the memory consumption and performance
> >> regression caused by using percpu. For multiple-thread processes,
> >> rss_stat is switched to the percpu mode to reduce the error margin.
> >> We convert rss_stats from atomic mode to percpu mode only when the
> >> second thread is created.
> > Hi, Zhang Peng
> >
> > This regression we also found it in lmbench these days. I have not
> > test your patch, but it seems will solve a lot for it.
> > And I see this patch not fix the regression in multi-threads, that's
> > because of the rss_stat switched to percpu mode?
> > (If I'm wrong, please correct me.) And It seems percpu_counter also
> > has a bad effect in exit_mmap().
> >
> > If so, I'm wondering if we can further improving it on the exit_mmap()
> > path in multi-threads scenario, e.g. to determine which CPUs the
> > process has run on (mm_cpumask()? I'm not sure).
> >
> Hi, Rongwei,
>
> Yes, this patch only fixes the regression in single-thread processes. How
> much bad effect does percpu_counter have in exit_mmap()? IMHO, the additi=
on
> of mm counter is already in batch mode, maybe I miss something?
>

Hi, Peng Zhang, Rongwei, and all:

I've a patch series that is earlier than commit f1a7941243c1 ("mm:
convert mm's rss stats into
percpu_counter"):

https://lwn.net/ml/linux-kernel/20220728204511.56348-1-ryncsn@gmail.com/

Instead of a per-mm-per-cpu cache, it used only one global per-cpu
cache, and flush it on schedule. Or, if the arch supports, flush and
fetch it use mm bitmap as an optimization (like tlb shootdown).

Unfortunately it didn't get much attention and I moved to work on other thi=
ngs.
I also noticed the fork regression issue, so I did a local rebase of
my previous patch, and revert f1a7941243c1.

The result is looking good, on my 32 core VM machine, I see similar
improvement as the one you posted (alloc/free on fork/exit is gone), I
also see minor improvement with database tests, memory usage is lower
by a little bit too (no more per-mm cache), and I think the error
margin in my patch should be close to zero.

I hope I can get some attention here for my idea...

