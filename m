Return-Path: <linux-kernel+bounces-344826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC96A98AEA1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE16C1C21DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BD71A0BD0;
	Mon, 30 Sep 2024 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpS94XCO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACCB21373
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727729074; cv=none; b=nXD8TcsUemGK9Z9llRhAh+5J0V5DEKxhgrgp7VMu62J0ZPCJMc70DjI/M5WQ3ioPeA9B4lDJjyLSep8VkMK5v0VKAdLzePHZinhgND5/M55QY1ZzHlJ72wR3exgy+6OxoyviiSbvznSzfiS51nD8M4ec01aQZm4sQBnpjprE510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727729074; c=relaxed/simple;
	bh=c72X7rthoTw3UZ+SQ1NNx6VPjSXuahNV8Yeg+OSrwYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YL1r/RkLND7drsuzFEl7YLSndcn4TXvJTmAr7SvATBrqp358VfzFuD3KYfpuZcvlcBk8PkXuQAfGDsnx9BtGt0AZ7X1V9tgwfz542PJf4eTBVc6xWfmu0G7aeyQtH0REc8WWI79D5394o+2udteCvQ5KcUK6lOr9tiznzKR/aXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpS94XCO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727729071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=365yvXyrH4HDYhpTGG7hYppkncBneUPU1yFT5H0aB0A=;
	b=KpS94XCO0g9rY5oQzqPw6rRvWuycw/b3B88+QtvujdARvEQZhpH6LzxlH172Qlw9lbEEUS
	Pdyepaeyluey5p0SFtM1D8C6ZDwmL6foCqH5OCBCN+Ty/IivzGEC1QrnOQBUQd685sfdk3
	KlsuPlS4EBpgPErUg8KdDsW8r68GQe8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-mzMmRun8Oj23ZJjEnWC6ww-1; Mon, 30 Sep 2024 16:44:28 -0400
X-MC-Unique: mzMmRun8Oj23ZJjEnWC6ww-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb6ed7f9dso48545835e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727729067; x=1728333867;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=365yvXyrH4HDYhpTGG7hYppkncBneUPU1yFT5H0aB0A=;
        b=KbI4GQZpjqy7N/n5cV1NQXoCsYfuTuPdDpDpoxx9jZ8X8piZ5E8O0L4x/AH2RrKW6R
         hp6+LmQshibK7Oxoe/N3KOZ51lUQpSd2bfmbryLUSQVZK3cyWrNl+2vzSbj1JrmTgBDH
         9RKme6Hbsdx0J6Gkh1rrONFEWzJh5vmXdMPGhUvNQkjqY2X77A2S38q+xagrRUViVa/p
         G/PhpRsoWkTTZRfjTRg4yQhecu4nl3tMcVAlPQ8KiJiWFDAQkAZYZXJqXLeniUxiywjJ
         V4zV0YzLEPm8LN5nkB3f7BTP69A0/mhZoQNepGoRg76zy2SqftXu65+0VpGY1ZtH51Zx
         enRA==
X-Forwarded-Encrypted: i=1; AJvYcCUOZL1OC4UHr2WrjeBgzILN53TOYQpr9AZn9wGAb+efZsFzUQwn3LaV1EHorr06j4BeBmkv8Y4OQbthYdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI3+vi2e55US4uklJfh6u9cK85U9KNBfzDwMu8bZDzXKL59cAN
	i0/ACAH4iv2YB6z53HFsnOR+evdyHAZS3NZpUx6XtKuvTtrlvaU46/WVdNYl2GSWzxqTJPL/I1h
	HLWMkNLsXowRP3dW386mi+JkwLKPpNjWFjGCY9Vbfm8MgFuSwEhN0EQcBZvNnnA==
X-Received: by 2002:a05:600c:5117:b0:42c:a8cb:6a5a with SMTP id 5b1f17b1804b1-42f5844b9dcmr147785275e9.15.1727729066742;
        Mon, 30 Sep 2024 13:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3QwwtLTQ50I8wwuCMh3xfz8nU4lYj9l/hZpN5kLgSBt4DCsR7xs1/zC1/fF3VISo1BGRq2A==
X-Received: by 2002:a05:600c:5117:b0:42c:a8cb:6a5a with SMTP id 5b1f17b1804b1-42f5844b9dcmr147785155e9.15.1727729066351;
        Mon, 30 Sep 2024 13:44:26 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57debe51sm114910415e9.20.2024.09.30.13.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:44:25 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: paulmck@kernel.org
Cc: Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
 linux-next@vger.kernel.org, kernel-team@meta.com, Tomas Glozar
 <tglozar@redhat.com>
Subject: Re: [BUG almost bisected] Splat in dequeue_rt_stack() and build error
In-Reply-To: <43d513c5-7620-481b-ab7e-30e76babbc80@paulmck-laptop>
References: <5ea3658b-5aec-4969-92c5-49a2d23171c3@paulmck-laptop>
 <xhsmh4j74o6l9.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <8094db32-5c81-4537-8809-ddfe92a0ac6c@paulmck-laptop>
 <4b93e5cf-c71e-4c64-9369-4ab3f43d9693@paulmck-laptop>
 <xhsmh1q27o2us.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <cc537207-68a3-4dda-a8ec-6dda2fc1985d@paulmck-laptop>
 <250cde11-650f-4689-9c36-816406f1b9b8@paulmck-laptop>
 <182ef9c6-63a4-4608-98de-22ef4d35be07@paulmck-laptop>
 <xhsmh34m38pdl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ac93f995-09bc-4d2c-8159-6afbfbac0598@paulmck-laptop>
 <43d513c5-7620-481b-ab7e-30e76babbc80@paulmck-laptop>
Date: Mon, 30 Sep 2024 22:44:24 +0200
Message-ID: <xhsmhed50vplj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30/09/24 12:09, Paul E. McKenney wrote:
> On Fri, Sep 13, 2024 at 11:00:39AM -0700, Paul E. McKenney wrote:
>> On Fri, Sep 13, 2024 at 06:55:34PM +0200, Valentin Schneider wrote:
>> > On 13/09/24 07:08, Paul E. McKenney wrote:
>> > > On Sun, Sep 08, 2024 at 09:32:18AM -0700, Paul E. McKenney wrote:
>> > >>
>> > >> Just following up...
>> > >>
>> > >> For whatever it is worth, on last night's run of next-20240906, I g=
ot
>> > >> nine failures out of 100 6-hour runs of rcutorture=E2=80=99s TREE03=
 scenario.
>> > >> These failures were often, but not always, shortly followed by a ha=
rd hang.
>> > >>
>> > >> The warning at line 1995 is the WARN_ON_ONCE(on_dl_rq(dl_se))
>> > >> in enqueue_dl_entity() and the warning at line 1971 is the
>> > >> WARN_ON_ONCE(!RB_EMPTY_NODE(&dl_se->rb_node)) in __enqueue_dl_entit=
y().
>> > >>
>> > >> The pair of splats is shown below, in case it helps.
>> > >
>> > > Again following up...
>> > >
>> > > I am still seeing this on next-20240912, with six failures out of 100
>> > > 6-hour runs of rcutorture=E2=80=99s TREE03 scenario.  Statistics sug=
gests that
>> > > we not read much into the change in frequency.
>> > >
>> > > Please let me know if there are any diagnostic patches or options th=
at
>> > > I should apply.
>> >
>> > Hey, sorry I haven't forgotten about this, I've just spread myself a b=
it
>> > too thin and also apparently I'm supposed to prepare some slides for n=
ext
>> > week, I'll get back to this soonish.
>>
>> I know that feeling!  Just didn't want it to get lost.
>
> And Peter asked that I send along a reproducer, which I am finally getting
> around to doing:
>
>       tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration =
12h --configs "100*TREE03" --trust-make
>

FYI Tomas (on Cc) has been working on getting pretty much this to run on
our infra, no hit so far.

How much of a pain would it be to record an ftrace trace while this runs?
I'm thinking sched_switch, sched_wakeup and function-tracing
dl_server_start() and dl_server_stop() would be a start.

AIUI this is running under QEMU so we'd need to record the trace within
that, I'm guessing we can (ab)use --bootargs to feed it tracing arguments,
but how do we get the trace out?


