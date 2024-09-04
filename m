Return-Path: <linux-kernel+bounces-315403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F04C196C22F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7EB1F23B3A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61231DEFC3;
	Wed,  4 Sep 2024 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgOJ+pMS"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7611DCB35
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463483; cv=none; b=tDElxlpKWIhRmum7O5ZWAV8D/ZnYftJfRBUtOQ3/hqBEmkYFBnBib6SKGja4NxxTRdRiMEe0RMEwM5L9/tW6Maea50Yr52QSv0cg9SXR4TgLXA2TA+p9Us5Vtk3MAqWQQdyVDniSZVtNfHihKqqls3fCOfX6ed9IU2ZezAVS/nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463483; c=relaxed/simple;
	bh=nNkGB49kwoOkrTPxFGOPj4+3czI4scaeIuVCty+qiM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwIMmGb+KFxVrVnrRbJehTfRRR9YgyAfZepZz7kjLRDh+4TGncto9pbeNW2XnUguCKGnkARMMUEPDq+znRFlKjhJxyzyNS4Q3zpCI0TJcDmLdxWkV8VgdIJRSjhUG8ID07uaZDZmIzxZeHJUmCJSmskwSjhVJ0/Pws4xM8i3s9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgOJ+pMS; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so4818671b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725463481; x=1726068281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=obGSaR8lFRv4zA3d5qVGPGlY9CoGbYSHk4LdgGzJDV8=;
        b=VgOJ+pMSdRhKJq1YV2jOtOT6Ebr7X0JyeuUkoTXUJIw5nJuv+GtMuitbF5C193ax2r
         wBgBCwmBIf2LLdLoaxFdCIO/N6RVoJvvHikFX3Qs1Eydi2+9UrqjscqrRUY5R2l3a0eY
         bDfw9KzGQEA5iGTMGDwDURt1NP0l0VVQwvvmY59nYkcjKOQwfHFhcRTZO02LsZtAo1CI
         zXbxWoC5LRUl42tb1MzbOoT9p7TY5lGVbseRLehZwnCPqhOgEptdhoKbllIsmrE7Ur6Z
         D8YCDDj1k8wQDrGFGSEwyeTsMzyqYGAS6vAZgJIqKJAgLeR+1EL/pDPaBH+EPeb8x4jo
         5SfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725463481; x=1726068281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obGSaR8lFRv4zA3d5qVGPGlY9CoGbYSHk4LdgGzJDV8=;
        b=KSZFgCes6SN5vp99XvAp1YsZGAfdzUAhnRgXazFuOfCNswqzl+I6SihKqyrYutrHjr
         ig6MlTCcfpEd5o/v2s5tPhB45i1lPfedrV+bqp0JY0Gvx9Q0xQvkg83wBgwHDeU2LRs4
         x7G82S5jYk0PoYGeCSk30GRT/27mrmp8KeWK56l9EOiw+dtD7S/QFpPvcoRWl651G+58
         70/Z1VrI6wSVbgQ21Wm8mDFR91bE45BvioSfAEb9QSvE5zYwPfF1SlW360PZof+rtbcr
         1mbgUDAPSyCfJrwPw5yuRRuC80LsAa8/MzqfkBOM8V77XeSNeP+T8Banj4JkETow+w8Z
         ZDEg==
X-Forwarded-Encrypted: i=1; AJvYcCXGlDzMdnLIxGXuJR0etdxN6I63P9ZwkhdX0lgjlsJJI+In4ZWoZTdwMpH6gL7QUTI1cArCZzfzwoqEas4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgIHrZSqrVb/EjmjEUjfKk7a/dmeGo/SlPerSaPN1FlB+MxeK
	0PrYh05IKLv4Y3TtaadbIzzDNKSUicjGhYCjUE0VxVXTKhxqTwjcMKdhkBgg
X-Google-Smtp-Source: AGHT+IEtfiK/RMQn0LZvd2f5nOjXN8Xjs5IfCpmi6aXp2aQBd/B+ANV+OOPxuz6J1lDIQQEjPY6PTw==
X-Received: by 2002:a05:6a00:9165:b0:705:6a0a:de14 with SMTP id d2e1a72fcca58-715dfbab54amr20280159b3a.1.1725463481065;
        Wed, 04 Sep 2024 08:24:41 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177858b655sm1726649b3a.127.2024.09.04.08.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:24:40 -0700 (PDT)
Date: Wed, 4 Sep 2024 08:24:38 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>
Subject: Re: [RFC PATCH 2/2] sched: Improve cache locality of RSEQ
 concurrency IDs for intermittent workloads
Message-ID: <Zth7tj9Cq-gigTx8@yury-ThinkPad>
References: <20240903190650.53644-1-mathieu.desnoyers@efficios.com>
 <20240903190650.53644-3-mathieu.desnoyers@efficios.com>
 <ZtdqhmKmbVsCSAkJ@yury-ThinkPad>
 <615f169b-3b24-4661-8a2c-185c6d80f7a4@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <615f169b-3b24-4661-8a2c-185c6d80f7a4@efficios.com>

On Tue, Sep 03, 2024 at 07:22:37PM -0400, Mathieu Desnoyers wrote:
> On 2024-09-03 15:59, Yury Norov wrote:
> > On Tue, Sep 03, 2024 at 03:06:50PM -0400, Mathieu Desnoyers wrote:
> [...]
> > > +
> > > +static inline void mm_set_cpus_allowed(struct mm_struct *mm, const struct cpumask *cpumask)
> > > +{
> > > +	struct cpumask *mm_allowed = mm_cpus_allowed(mm);
> > > +	int cpu, nr_set = 0;
> > > +
> > > +	if (!mm)
> > > +		return;
> > > +	/* The mm_cpus_allowed is the union of each thread allowed CPUs masks. */
> > > +	for (cpu = 0; cpu < nr_cpu_ids; cpu = cpumask_next_andnot(cpu, cpumask, mm_allowed)) {
> > > +		if (!cpumask_test_and_set_cpu(cpu, mm_allowed))
> > > +			nr_set++;
> > > +	}
> > 
> > You can do the same nicer:
> > 
> >    for_each_cpu(cpu, cpumask)
> >    	nr_set += !cpumask_test_and_set_cpu(cpu, mm_allowed);
> > 
> > This should be faster and a bit simpler, to me.
> 
> In this scenario, I expect the following per-thread cpumask properties for a
> given process (typically): those will be typically the same bits
> set repeated over all threads belonging to a process. There are of
> course scenarios where specific threads will override the mask, but
> I don't expect this to be the most frequent case.
> 
> So we typically have an operation which initially copies the initial
> thread's allowed cpus mask to the mm allowed cpus mask, and then when
> additional affinity changes are done, we want to augment the mm allowed
> cpus masks with any additional cpu that may show up. But again, I expect
> the initial thread to typically have the complete mask and other
> operations won't typically change the mm allowed cpumask bits.
> 
> I also expect the cpumask to be often quite dense (often all bits
> are set).
> 
> Now if we look at the operations for your proposal here:
> 
> - for_each_cpu loads cpumask word-by-word and for each set bit, it
>   issues cpumask_test_and_set_cpu on mm_allowed, which is really a
>   test_and_set_bit, a fully ordered atomic operation, on each _bit_
>   set. That's O(nr_cpus) fully ordered atomic operations, and thus
>   expensive exclusive cache line accesses.

Both versions are O(N).
 
> My approach does:
> 
> - The equivalent of a for_each_cpu_andnot (actually I should use
>   exactly that! I just noticed it exists in the API.), which loads

Yes, you should.

>   both thread and mm CPUs allowed masks in parallel, word-by-word,
>   and only issues a cpumask_test_and_set_cpu for CPUs which are set
>   in the per-thread mask, but not in the mm mask. In the typical cases
>   discussed above, we pretty much never need to issue the atomic
>   test-and-set. So all we need to do for the common case is to read
>   both cpu masks in parallel, no stores/atomic ops needed.

This all doesn't look like a hot path. And anyways, speculating around
performance without numbers on hands sounds cheap.

In my experience, iterators with a very lightweight payload are ~100
times slower comparing to dedicated bitmap ops. Check this for example:
3cea8d4753277.

If you're really cared about performance here, I'd suggest you to
compare your iterators approach with something like this:

  cpumask_or(mm_allowed, mm_allowed, cpumask);
  atomic_set(&mm->nr_cpus_allowed, cpumask_weight(mm_allowed);

