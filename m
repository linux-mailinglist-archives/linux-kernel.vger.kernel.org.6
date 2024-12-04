Return-Path: <linux-kernel+bounces-430401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5709E306F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5C56B23698
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF18C1854;
	Wed,  4 Dec 2024 00:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOW7tbio"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD537F9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733272743; cv=none; b=W0ZL4uNodiYCjaBOvy1MhpICrazbQzsU6008SZl5nM5W3Z68NvfeMUzenEKz8eGoAlVGzThww0Aj+1dGTF7oiDiu/I5QCNHnOPd80xglc94mXmNPa8MI4vxFFFTtKk67wY3S4oRcqnJvDf8tWpezU9Tv7Ja/6oscBkNdbfv5S1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733272743; c=relaxed/simple;
	bh=c2G/7EJkBEWgvygfaSCOqrOJGNYN5fuZ9sPfMdIgAFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2Z2Zv4FOpMahIhays2OSMGJCfvl6DWQuXsdzeoFXuashKp6AvDu8brlw0hIiGKsSWd8AgZu/ZDQQJ/P4oR+6uwrmQ47X+re9bz+WpQgFQc1jd407QUUPRZaTRa8X0nHZtQmcXlQBMl+s0Ad153SrYwtNo5ogVTLBJP+tMEJ3E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOW7tbio; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-724fc1aaa91so5613618b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 16:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733272741; x=1733877541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2iy64dWSEgtoo4nfx4yZcRtBBDLE3Df+R/OhP0nDrk0=;
        b=eOW7tbio1RAGWJJttkwjIdjNr6JRtvfZUP7er4FTgkZwk74/KZSja/Jr2APPCZEfII
         GS9Ex/PUtRg5dB/pe2tk2u8G5Jm2VVEX0gTx3iijyYlGkMHkdgnkWbLuVi5sltLGJlsE
         5vhZkDoDxhYmXzN0J+Km2rRh1k9UlZQ8v3cScAWC8lWRVC2XRyGF8It3eBUNhX8Lk00M
         PIvxQLak2EioN9J7HMTD7znK7ffu2KyzNbwWIthLSygX7O5arqRDBSfo+NvRrGwzg2DD
         9/OoXsuhX3GPQ9A/AVXK+iBJv23Gr8GmGZ7XOWA6fwpsbla+m1JJHx3j/geVB2ZOFM17
         6Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733272741; x=1733877541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iy64dWSEgtoo4nfx4yZcRtBBDLE3Df+R/OhP0nDrk0=;
        b=VsQOfj2tqCygCLKXuA437fuZd8T4JVRjdcQHx8Z2+67/h19XO6IU9VkQbIo+i4PTTh
         ffZ5EJLBVZXni8YReN2Mego1dF3DOMMcq5nTjO/g4ijQfFIc/wQkIaxutcQQ24PhdVGC
         PPFT+Me2+45B1SVqM8gvwOAT4QptoC/OmVwlLMH/A2qgHngu1RoAIrCJ9xN81WpssCrH
         XACEFiMB9t40lA/tGbypEgwo6Qgfeg+C36TB+cC3W3YLoIx4HrMXO5EeLR/wPcMyMSQw
         l/qwPuHzLKTM46d2Wf44kkAouz7FJPzZKbmtJJtxXLrsODYDE+7z7ypNYd66hasVQB5s
         8HUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxUQF++EmbQN7Bty6GeqfeWjdJpIu36O25Y0xRFmkS2ftUaOuovBGtDhkm/YRUAQ8s4s6CZled8uzmOi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAzYA9DrTPNmpiTwbmSI5tgZE3K/cWWBOJK/+GqGu4CitxzGAq
	HaJtkzWq35RD6wvda8s9D7lp1jsjICq/ENwkZBLZL97IScRR90hU
X-Gm-Gg: ASbGncsqdr8RIdvIlwi5wKi63rpg477tMXunLcDNEUtrdqJOsczfu++KnTOw/3YIsOh
	w9nTUafK6knbLdRpxPZbxheLdqBqioaPVFxUGSEp8rOYnYJm0Wo+pIyH9PR1K5d7FfMDeeIU/xI
	5+SVphkNdBa/AVsrKbDaZxO/dcReLQv+TAtRwnLbVAgk3ZTPJGXa7VCxtTh3g7hQXateEHARZzA
	fjASwmvmLPV0Qeu/U8vi6TH73EeiU2hTwha4alvThm6oHs51g==
X-Google-Smtp-Source: AGHT+IGQXD1t2sZSOCF4oOUgFUBCImHDNtvG8ZU6r+iuznTIFCooAiZpkt7S3qxQC3WQnfEY7B8bxg==
X-Received: by 2002:a05:6a00:9a0:b0:71e:6c65:e7c4 with SMTP id d2e1a72fcca58-7257fce9159mr6941537b3a.26.1733272740908;
        Tue, 03 Dec 2024 16:39:00 -0800 (PST)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fb8easm11062236b3a.114.2024.12.03.16.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 16:39:00 -0800 (PST)
Date: Tue, 3 Dec 2024 16:38:58 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched_ext: Introduce per-NUMA idle cpumasks
Message-ID: <Z0-kovS-Ba9CaP9J@yury-ThinkPad>
References: <20241203154917.123419-1-arighi@nvidia.com>
 <20241203154917.123419-3-arighi@nvidia.com>
 <Z0-cf7gUzV8jIWIX@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0-cf7gUzV8jIWIX@slm.duckdns.org>

On Tue, Dec 03, 2024 at 02:04:15PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Dec 03, 2024 at 04:36:11PM +0100, Andrea Righi wrote:
> ...
> > Probably a better way to solve this issue is to introduce new kfunc's to
> > explicitly select specific per-NUMA cpumask and modify the scx
> > schedulers to transition to this new API, for example:
> > 
> >   const struct cpumask *scx_bpf_get_idle_numa_cpumask(int node)
> >   const struct cpumask *scx_bpf_get_idle_numa_smtmask(int node)
> 
> Yeah, I don't think we want to break backward compat here. Can we introduce
> a flag to switch between node-aware and flattened logic and trigger ops
> error if the wrong flavor is used? Then, we can deprecate and drop the old
> behavior after a few releases. Also, I think it can be named
> scx_bpf_get_idle_cpumask_node().
> 
> > +static struct cpumask *get_idle_cpumask(int cpu)
> > +{
> > +	int node = cpu_to_node(cpu);
> > +
> > +	return idle_masks[node]->cpu;
> > +}
> > +
> > +static struct cpumask *get_idle_smtmask(int cpu)
> > +{
> > +	int node = cpu_to_node(cpu);
> > +
> > +	return idle_masks[node]->smt;
> > +}
> 
> Hmm... why are they keyed by cpu? Wouldn't it make more sense to key them by
> node?
> 
> > +static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
> > +{
> > +	int start = cpu_to_node(smp_processor_id());
> > +	int node, cpu;
> > +
> > +	for_each_node_state_wrap(node, N_ONLINE, start) {
> > +		/*
> > +		 * scx_pick_idle_cpu_from_node() can be expensive and redundant
> > +		 * if none of the CPUs in the NUMA node can be used (according
> > +		 * to cpus_allowed).
> > +		 *
> > +		 * Therefore, check if the NUMA node is usable in advance to
> > +		 * save some CPU cycles.
> > +		 */
> > +		if (!cpumask_intersects(cpumask_of_node(node), cpus_allowed))
> > +			continue;
> > +		cpu = scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
> > +		if (cpu >= 0)
> > +			return cpu;
> 
> This is fine for now but it'd be ideal if the iteration is in inter-node
> distance order so that each CPU radiates from local node to the furthest
> ones.

cpumask_local_spread() does exactly that - traverses CPUs in NUMA-aware
order. Or we can use for_each_numa_hop_mask() iterator, which does the
same thing more efficiently.

Thanks,
Yury

