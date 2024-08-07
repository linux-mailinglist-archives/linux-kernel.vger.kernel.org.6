Return-Path: <linux-kernel+bounces-278286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711FD94AE44
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9951E1C216CB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F2C13774B;
	Wed,  7 Aug 2024 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiUE3Qso"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32152F3E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048780; cv=none; b=LOssPEHBNyLAkf2KKTwUdkA6KTFYYZ5g21XjS72TvGwSTaCLY0SCvjXIgmzc7tkT8uo/iXJdjHFvIFzOGR23rRvLIRA/ETj8z9VA0J7M13vn5/AwrRnmjF+YRgXX3LoejLSYtIE/IT7/rVyIyUOLW6HfjDaSW5/aVLpXx5jW4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048780; c=relaxed/simple;
	bh=7jUDM+xLtypuR3LWObie88czTNQttanVUl62e9mzloI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE5nzfE/qXfVrGIg0XGRe9jugU5MLCgm/hG/INoFmNTZieS1GQKBmoxdqRvI431oCfzcPaLMKgYo/wMtAZHd8t34tDluK3kw0z47OCgf930fTkVRAvELQDz0LedsK39V7GjFgi3mmJsED4T1rfMzmEVhh3DANMAv5a7Iod6Vn1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiUE3Qso; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc65329979so1253055ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723048778; x=1723653578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCzZ2NG+7iTC4t2x8SaeAedg7WRJblJNbmhLrG4zTO0=;
        b=LiUE3Qso1wSsbPPgqCYJLaXBLO/9ag3GowUWNoiHVaMYXKQ9NSajXUZUA6Hbdkygvv
         xnI6DI+I4F+34ZpPPe4q1jTuNFpxRIKrwJS56oCL1oifldrnvAKDUlF+b98l4gsATU+Q
         3NhyWkLXdvfbKMsQFt0IbRE8xaqhzy2k7LSUKq/6XJO0wNO3g6Div/4IZZtrGEycNXzP
         ginWNwMBoip8G26wm3QH2VB4kNbJao6aPsT0yirmOsfjNfMSJVp0MqoQ0v9Daq9xwds/
         nf/dd4PVvmfyl0wdgTlcmVQizoZM5EjvabqCxuCYoP1m6zgdrlKMPhiVw5828+WTUlwI
         khYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723048778; x=1723653578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCzZ2NG+7iTC4t2x8SaeAedg7WRJblJNbmhLrG4zTO0=;
        b=tLqMIRZxDPQyT3c2Zr3mBtBfDq25W2ncJSl+pj09/Icqb1koxKtkFmT9xK/vQ1cpcW
         q92d8qS7JV3w3oFGtAiEpf7NwcKKiMTNOmRmLyZpfQqI1lY1/BzcrKcEVmk5TgHGA9ke
         02VMHBmvXqcfezDigMDjCZWN6wzqYFRvnA5gw00+5gjaaahRREwLBRtgGpFBtOpbWjf3
         YDa7eVNjEQFUCHNOsQLrFg1WeTy22Q9goGzqnst6IHDf79X5HOK672occFD+/LLAwq4k
         1MCCxj1oGHwAJK2EoUdGGMX06FvyQKCKLlbzfqWWEEgbhmM3eeISx2Fbq5YPXttzHl9n
         alRw==
X-Gm-Message-State: AOJu0YzjWniWvyV5pq8czMkblTwLSowZcB9YiN9IbSVQ2zkXgzCM73yX
	Vl4kGaakmx6VL8sR+00f/19ANeeoUNvWEMKEI50wf0EZIe4pjvcQ
X-Google-Smtp-Source: AGHT+IEfg0P/zq5fbIeplhyr9GmYwmn9uUCIRSBW2duRXm7pFZpUMxC4ayytohYsd7+LmJC7gsIpnQ==
X-Received: by 2002:a17:902:ecc5:b0:1fd:8f66:b070 with SMTP id d9443c01a7336-1ff57464d40mr264528465ad.57.1723048777926;
        Wed, 07 Aug 2024 09:39:37 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905e58fsm108734075ad.177.2024.08.07.09.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 09:39:37 -0700 (PDT)
Date: Wed, 7 Aug 2024 09:39:34 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Leonardo Bras <leobras@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 2/2] sched/topology: optimize topology_span_sane()
Message-ID: <ZrOjRqdita_dOjk9@yury-ThinkPad>
References: <20240802175750.1152788-1-yury.norov@gmail.com>
 <20240802175750.1152788-3-yury.norov@gmail.com>
 <xhsmhy159mz0g.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ZrJk00cmVaUIAr4G@yury-ThinkPad>
 <xhsmhv80cmoc1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhv80cmoc1.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Wed, Aug 07, 2024 at 03:53:18PM +0200, Valentin Schneider wrote:
> On 06/08/24 11:00, Yury Norov wrote:
> > On Tue, Aug 06, 2024 at 05:50:23PM +0200, Valentin Schneider wrote:
> >> On 02/08/24 10:57, Yury Norov wrote:
> >> > The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
> >> > even when cpu != i.
> >>
> >> For which architecture have you observed this? AFAIA all implementations of
> >> tl->sched_domain_mask_f are built on a per-CPU cpumask.
> >
> > x86_64, qemu emulating 16 CPUs in 4 nodes, Linux 6.10, approximately
> > defconfig.
> 
> For the default_topology:
> cpu_smt_mask() # SMT
>   (per_cpu(cpu_sibling_map, cpu))
> 
> cpu_clustergroup_mask() # CLS
>   per_cpu(cpu_l2c_shared_map, cpu);
> 
> cpu_coregroup_mask() # MC
>   per_cpu(cpu_llc_shared_map, cpu);
> 
> cpu_cpu_mask() # PKG
>   cpumask_of_node(cpu_to_node(cpu));
> 
> Ok so PKG can potentially hit that condition, and so can any
> sched_domain_mask_f that relies on the node masks...
> 
> I'm thinking ideally we should have checks in place to ensure all
> node_to_cpumask_map[] masks are disjoint, then we could entirely skip the levels
> that use these masks in topology_span_sane(), but there's unfortunately no
> nice way to flag them... Also there would cases where there's no real
> difference between PKG and NODE other than NODE is still based on a per-cpu
> cpumask and PKG isn't, so I don't see a nicer way to go about this.
> 
> Please add something like the following to the changelog, and with that:
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>

Sure, will do.

> """
> Some topology levels (e.g. PKG in default_topology[]) have a
> sched_domain_mask_f implementation that reuses the same mask for several
> CPUs (in PKG's case, one mask for all CPUs in the same NUMA node).
> 
> For such topology levels, repeating cpumask_equal() checks is wasteful -
> check that the tl->mask(i) pointers aren't the same first.
> """

