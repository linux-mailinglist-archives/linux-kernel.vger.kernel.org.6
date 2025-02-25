Return-Path: <linux-kernel+bounces-532492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5512FA44E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2EA1688A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7482020FA9E;
	Tue, 25 Feb 2025 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPW9plm8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288C720FA9B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518001; cv=none; b=dkrVQ5QRNi1Cfuq2BWdLPE6+B3XSt9dYMzl4S/CGdYba9xKjx5vZNTEgM7jaTquF4h4RjEdF8Ac+mWP+ySlYZOJW0/D6pFJDJRph2h6+bvvaGHnJWKnaEDRSaJNFaWNKDqLj1kkDckyXyWoGUlAygN7pNh4fNvskLAlZEgTzerw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518001; c=relaxed/simple;
	bh=RGluz43GVvStsDd1HSxx9qZpHwxLnjUMaRjVhtcePjE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=stm9WmXfmBImcXXtdz/yORCDHO8p9R3Sor1zx/77JfUyCysViVueGpsVWeGCgOY4/gqx/RKu7X2W3d7MIOCpiIDq7iaJWbAtrnM3SWURL1QDuFxUBQbdLEKcNy3CQamQV+C14X4igMlSjJe0XlNI5b2FhbkJvlItRfueiq2I30U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPW9plm8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740517998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGluz43GVvStsDd1HSxx9qZpHwxLnjUMaRjVhtcePjE=;
	b=fPW9plm8D8fMmXMThWrtMKADzOP+/hXNAZ/rebkme61FYsPtpjlr742dYRKsSrdrsahxLQ
	a2p8ngsVt6QahHxeHZEdSsixJGv8OI15wG5d955YQOhsoXef8WPTmNRSI206dLfrpFYTzU
	eh1LVZVstPKpESe9ya/tER7rthsjsjw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-P7tunIlrOdiC7xA0Jfdgcg-1; Tue, 25 Feb 2025 16:13:15 -0500
X-MC-Unique: P7tunIlrOdiC7xA0Jfdgcg-1
X-Mimecast-MFC-AGG-ID: P7tunIlrOdiC7xA0Jfdgcg_1740517994
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f31e96292so3861282f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740517994; x=1741122794;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGluz43GVvStsDd1HSxx9qZpHwxLnjUMaRjVhtcePjE=;
        b=w5Vs47FmD2mtWe3KMvb7SBLOTqrT+WZTXZEAeFBz6Bu5YefVljD4h8eKYuhSMrrn/M
         poFdoSAAWyuJXfG4rnWEkCTbYcT/sBYsx04UYb/z5JhzVKBGzWEC9uGqMDV1QZO/gkL+
         InIkLrlKZgUiIbL9ZkA1Mz3RBzDqVzNPaJG173+tMWEz/alO9Ht5jeoEi1egK9/NDEmJ
         ZCHRBEbeWYxZevqmi6VfUB4zzku00b4XfPHwZbouD1+X8Yy8MHQBA3q80W0eQX+FmN34
         KUpUSdJNraZQAtxijWG9ZeCYW5DhW0OkFZMpKbDJg62eQCp2NnxwL8BJtDgMR/Z51r6W
         moJw==
X-Forwarded-Encrypted: i=1; AJvYcCWyTslL5nnDH7Kcl/0+BZXriwHcgeQPT0ZHmadV+v1KlvAFgUN8ZEM9R4xkFiBV4jMfDD2QPEjXLVX4Bw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjhXUy5pDck/Y5pKm0QueMYgpmxMFLE3eV7pqltT1ZLRpDKw4R
	qjZBZabJvW7blu8SheG/IaoX5IG6eZiavIhE3R6n68NOgUeKg3w0xvn+TxXYDVHPuV+IjHB3T3Q
	cOE1WWfiI4hyKpJwFftMK04kZM/T0zHTtG3k8Zur1wFxet7V0RLNS6jbzvpqaMw==
X-Gm-Gg: ASbGnctn01KkNlzIIq7w3x/+o2fCj9IT1F4tZYP8c9spu9f/QDy0TovY2YpdoRyBH3h
	MZhsYFQZ+7V0r3DZ6L85MYUKI9g9Ht3JfB8yw4cykIl6OnWtwMaUR9g051esd9oZUmeO5dI4aNs
	TIHeuN7yA5jvgwykOiYngF+H6p2uBC8MfgLfD1fhxFIZMDyR203rhrXiS+ML4/QUHMf1eSg2JGG
	powOxtMcPzkNBE8TuH0u2OZOWjZ3DqlQXZf4dJswtrvEP5naCjTAn/WNfcuCZSuMTn6LxnuNOPY
	u7eBqsIk8MR7YEZzMEVBMzZMcBXbMfSwE1Y5ZOvyohBu/ULwzvgdAkma5uyy5d325dKETGHZ7BD
	3
X-Received: by 2002:a05:6000:4013:b0:38d:e584:81ea with SMTP id ffacd0b85a97d-390d4f9fb3emr645236f8f.45.1740517994503;
        Tue, 25 Feb 2025 13:13:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFy4N/He/MCmAygW2he1I9yokRSLZNxxCGRPy/cDMpHs3zYeeaXE6c7lSzjUiEkR5upKQt5iQ==
X-Received: by 2002:a05:6000:4013:b0:38d:e584:81ea with SMTP id ffacd0b85a97d-390d4f9fb3emr645220f8f.45.1740517994160;
        Tue, 25 Feb 2025 13:13:14 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8667d5sm3502299f8f.20.2025.02.25.13.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 13:13:13 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Josh Don <joshdon@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Ben
 Segall <bsegall@google.com>, Thomas Gleixner <tglx@linutronix.de>, Andy
 Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mel Gorman <mgorman@suse.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-rt-devel@lists.linux.dev, Tejun Heo <tj@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Barret Rhoden <brho@google.com>, Petr
 Mladek <pmladek@suse.com>, Qais Yousef <qyousef@layalina.io>, "Paul E.
 McKenney" <paulmck@kernel.org>, David Vernet <dvernet@meta.com>, "Gautham
 R. Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal
 <swapnil.sapkal@amd.com>
Subject: Re: [RFC PATCH 00/22] sched/fair: Defer CFS throttling to exit to
 user mode
In-Reply-To: <CABk29NsCqkOVXHfu1=ir9nhKiy2PVsONdZm29qXdbJX8LrfCNA@mail.gmail.com>
References: <20250220093257.9380-1-kprateek.nayak@amd.com>
 <20250220105558.GJ34567@noisy.programming.kicks-ass.net>
 <b2386349-2879-4dce-afb0-f6486c24c117@amd.com>
 <20250220113227.GL34567@noisy.programming.kicks-ass.net>
 <xhsmhikp44oan.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CABk29NsCqkOVXHfu1=ir9nhKiy2PVsONdZm29qXdbJX8LrfCNA@mail.gmail.com>
Date: Tue, 25 Feb 2025 22:13:12 +0100
Message-ID: <xhsmh1pvl20ev.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20/02/25 17:47, Josh Don wrote:
> On Thu, Feb 20, 2025 at 7:40=E2=80=AFAM Valentin Schneider <vschneid@redh=
at.com> wrote:
> ...
>> As pointed by Ben in [1], the issue with the per-task approach is the
>> scalability of the unthrottle. You have the rq lock held and you
>> potentially end up unthrottling a deep cgroup hierarchy, putting each
>> individual task back on its cfs_rq.
>>
>> I can't find my notes on that in a hurry, but my idea with that for a ne=
xt
>> version was to periodically release the rq lock as we go up the cgroup
>> hierarchy during unthrottle - the idea being that we can mess with part =
of
>> hierarchy, and as long as that part isn't connected to the rest (i.e. it=
's
>> not enqueued, like we currently do for CFS throttling), "it should be
>> safe".
>
> Can you elaborate a bit more? Even if we periodically release the
> lock, we're still spending quite a long time in non-preemptible kernel
> context, and unthrottle is also driven by an hrtimer. So we can still
> do quite a lot of damage depending on how long the whole loop takes.

Indeed, this only gives the rq lock a breather, but it doesn't help with
preempt / irq off.


