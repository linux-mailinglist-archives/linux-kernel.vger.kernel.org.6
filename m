Return-Path: <linux-kernel+bounces-377738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F04D9AC34E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5F41F2477F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850974503C;
	Wed, 23 Oct 2024 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cDl5N70k"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7B315B122
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675039; cv=none; b=vGcP2/b5yNd5RItZMfKG3qM6fxkVWt4b8bwETKQi3AJAzbfFN9q+LVitPIphqQFti0x0poT6J7ztiw541qy5sJyDCMSbncTGyxn6FBBHypvUFrmfoyQHIcSXQdHYonwuyWwDuIBKFOmR1L32yp1X5NFntlhathF4LHLDFmuHGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675039; c=relaxed/simple;
	bh=wtB++VIztt5HrzVDtGHAG03WXfiePjTR9YlbhZgm7nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUQC0bd6MN09jXwQRIplLWo/bXJK6Zb5vB6hUP812ynNxSofwTKT9jzM6PAf3ZjhCliV/88tjQ4cg7nmkySF/Z5GSpbviVNTQ35W/tJf2ZmNwYM2ZVwvNxamsWGOsF1nYaCeDZF84FRoKpdZNyKoDJr88JMuQMLBbXKNj+oMDY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cDl5N70k; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb561f273eso65192931fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729675036; x=1730279836; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wtB++VIztt5HrzVDtGHAG03WXfiePjTR9YlbhZgm7nk=;
        b=cDl5N70kW4qZ92fU3zt9XzrqqbmPXBPAR1397nRyl8QFe2280rQWAEVMnPnOEXfzyr
         CQpf7IerO4IQRmZyROB25M4v5cD3bVyixJ5PzTMGla2pzMQVv5VW8hzCmXOsF4t6ALCC
         DEIP6658YoISqPJGBgq3GUyOdtkIAl56f80J0yMCifAAEvXP5xKzmLelybI1sYAr5O7y
         jU6Qsij7SkfqYVzwMcn1rxlneUor0LXCkfbq8yH1mYfKkHgAwtzAJVjtE/PR9q02FFi4
         8/JCQU8rMY8y2ILwvD+NB30kGipYxS5zfVYnZCAGbf1HjbASG4cyELEU9wcnJRsI8mU2
         80/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675036; x=1730279836;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtB++VIztt5HrzVDtGHAG03WXfiePjTR9YlbhZgm7nk=;
        b=l/tRUp39UoF5DFik/R8/etXI92TBE/HmgX+7kuQKb8frQEog0XZGoMIAJdI+saiM2k
         /Qw9CO29TcBWcu9PBYJ5HUjnsn9nLdOjCljhImqIigru68fgPbFsGCuRslJEnWoyiC25
         01ciXFJ8CXvK3wEI3EOB13uZW4suZzFAeBGGJuM+FiDJ73nTKenp0NLSwy0M0aSzJHnm
         v11YW43IJmW9ufzQqn6WD9xmdzy3JWKoTtWdvUMhVNTHGg4Ee0malomHYesiy3LWfjIw
         um6wPg5blzhGisebBfipK6c899W82DEgTO/xbkhE1BRiImSFpt6/HzWKG2kHfMMSVtu4
         Q60g==
X-Forwarded-Encrypted: i=1; AJvYcCVZQLDUFWPM9PpaaX6h28eSAu8C5NDoCAR6xHARFmgN90WBbxQeH1+J407yt2MyIYr71gh+xzYgsYskh/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPRKVlL4p4VcG1r0VUntl87Ep+osVJwsOmewmePfXtZvGz/qFB
	5DI8z1e7AuL5tf/o7K7X13Fyt+eRl4c6GOAXUgQs0GpIuEkur1Fo+UH5VaIMKpAkn3hGAouINdH
	9QpgLsj/bmZKToCnANrpt1raLefIiQfrIgEAQ
X-Google-Smtp-Source: AGHT+IFvkPWDLHQT3Gtx5JJGGOJecwZ7B/rbkd7cgrlXZ9fP+lFzPxCiaYSOPYzYujteUjqgXjdomewJxB+DT79mLAc=
X-Received: by 2002:a2e:a9a6:0:b0:2fb:565a:d93c with SMTP id
 38308e7fff4ca-2fc9d33a85emr9429421fa.1.1729675036276; Wed, 23 Oct 2024
 02:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87a5eysmj1.fsf@mid.deneb.enyo.de> <20241023062417.3862170-1-dvyukov@google.com>
 <8471d7b1-576b-41a6-91fb-1c9baae8c540@redhat.com> <5a3d3bc8-60db-46d0-b689-9aeabcdb8eab@lucifer.local>
 <CACT4Y+ZE9Zco7KaQoT50aooXCHxhz2N_psTAFtT+ZrH14Si7aw@mail.gmail.com> <b1df934e-7012-4523-a513-d3d1536b7f72@suse.cz>
In-Reply-To: <b1df934e-7012-4523-a513-d3d1536b7f72@suse.cz>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 23 Oct 2024 11:17:05 +0200
Message-ID: <CACT4Y+Z=fjoOxn8NY8kYJd2CC1SkmjkmAmqSzJbQiU04G=BEvw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] implement lightweight guard pages
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>, fw@deneb.enyo.de, 
	James.Bottomley@hansenpartnership.com, Liam.Howlett@oracle.com, 
	akpm@linux-foundation.org, arnd@arndb.de, brauner@kernel.org, 
	chris@zankel.net, deller@gmx.de, hch@infradead.org, ink@jurassic.park.msu.ru, 
	jannh@google.com, jcmvbkbc@gmail.com, jeffxu@chromium.org, 
	jhubbard@nvidia.com, linux-alpha@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-parisc@vger.kernel.org, mattst88@gmail.com, 
	muchun.song@linux.dev, paulmck@kernel.org, richard.henderson@linaro.org, 
	shuah@kernel.org, sidhartha.kumar@oracle.com, surenb@google.com, 
	tsbogend@alpha.franken.de, willy@infradead.org, elver@google.com, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 11:06, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 10/23/24 10:56, Dmitry Vyukov wrote:
> >>
> >> Overall while I sympathise with this, it feels dangerous and a pretty major
> >> change, because there'll be something somewhere that will break because it
> >> expects faults to be swallowed that we no longer do swallow.
> >>
> >> So I'd say it'd be something we should defer, but of course it's a highly
> >> user-facing change so how easy that would be I don't know.
> >>
> >> But I definitely don't think a 'introduce the ability to do cheap PROT_NONE
> >> guards' series is the place to also fundmentally change how user access
> >> page faults are handled within the kernel :)
> >
> > Will delivering signals on kernel access be a backwards compatible
> > change? Or will we need a different API? MADV_GUARD_POISON_KERNEL?
> > It's just somewhat painful to detect/update all userspace if we add
> > this feature in future. Can we say signal delivery on kernel accesses
> > is unspecified?
>
> Would adding signal delivery to guard PTEs only help enough the ASAN etc
> usecase? Wouldn't it be instead possible to add some prctl to opt-in the
> whole ASANized process to deliver all existing segfaults as signals instead
> of -EFAULT ?

ASAN per se does not need this (it does not use page protection).
However, if you mean bug detection tools in general, then, yes, that's
what I had in mind.
There are also things like stack guard pages in libc that would
benefit from that as well.

But I observed that some libraries intentionally use EFAULT to probe
for memory readability, i.e. use some cheap syscall to probe memory
before reading it. So changing behavior globally may not work.

