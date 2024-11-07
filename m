Return-Path: <linux-kernel+bounces-400176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816999C09FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3891E1F21D5E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD93212F08;
	Thu,  7 Nov 2024 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQg+omE4"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84899212EEE
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992970; cv=none; b=H/J0YighBortvRXcQMaveIyR0jkdplq8D/3LeCgVzFA87Ej2akJdlePUbcNYl26SgR808i9ZtMBkddLNHqf5Ur3E2IyARP3al7VhUMbNcO3MuocOTxg+35MMDk7A+LqITDQkcBNiV7jPpvY58vR2xuvMZp2LHzXC92CQ3e5UWZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992970; c=relaxed/simple;
	bh=sEV7/1lNcAGghvSOllscVDoX+Ge9+Saq5vXgLjWcLu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGKeStpW2lzOAGUV/9oLGA8P9keE/WPhAFDIu3GC3z3X6dvtNKYHMqrihnTw7vmdJwM3iUDwv7xtUTl0fb50SI4YrniuvgLKwngOfWs6RFuFsCrcEMnhmaSahlcuf4bXBBwKnEl9egf7t4rT/2H04I1uNVOTyyLvrUZ6a4upLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQg+omE4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so845953b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 07:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730992968; x=1731597768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cF16SelVt42awWoGaQ964t9K62xlpSMVWs7rksVSNDM=;
        b=nQg+omE4HQp+rJpmvEHsHv9wOTHpHF7XjDea+poYGWTvhGe0Fn+53XcKZhUCLu1yzP
         HNXNNruptm7zgt0GA8Dw9TIT+Vxqd2KktVwL53rr5jYYyCOneruXYyMT1ujHUR0oXTWQ
         MexObLqXslHduBRhKmnS7suj09vY+Crnlu81v58KaNHOXsdPGg4EzKH5MBV9hnK8QOPw
         9Ovls9gaBk2urd1E0oU9SijNaLJwVf0qfg+0TeFmBIjkghhIeDkkW/ALgh5A++wShApp
         6WibOSQZyJrZ4UzQuaUsKd5DoCrgXsmYNnLzXIIftmYkqNcjHJbVEkndpWB0Uqqe47+V
         e/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730992968; x=1731597768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF16SelVt42awWoGaQ964t9K62xlpSMVWs7rksVSNDM=;
        b=Sw/n4f+0WBX4TSp5kGTOm2wFPVs2kJwNmfgWy5gbYLP3eUkPkoa3QjF75/0JkMHyj2
         yWEw15Z9AOk7gAP5Q/s0VJufGv0s6FxfwZMaBBEExOhf90pd0ozqchYNadsYJDIrNHqm
         G8fjuZ1rJA2fO+McJpLvEbpl9dhqI+ngulN2vJOS4m2L+gXhUqdXTY5QWm7SSRuLBzkm
         pfdDyPy9P4t7YiYn2dAEhwQyXmPD/uPkibY+uN3w4QgGUmKwfMnQaKsHPocic099LfQX
         7043I/Dyx38RDdruyVC9VOcYWycb+FtsQDD3qBIsVrHTdOfwO8WSXvGFITMdxomZc5ae
         EyTA==
X-Gm-Message-State: AOJu0Yyy5KllruRJMoSQZuUDJS7V7OmLRehyOlTYGdcFJi9uTQjwrypB
	sGG3T120+bMuHBMGBAv55FrtprMOT+sHC0wotKbkxap2yzzMdHIC
X-Google-Smtp-Source: AGHT+IFgX9hkXGlngtxgLeDWkbvKQtMYglJJsiUazn9aQsHkm3JjCnRYtIdJz6ROEUmBK6RBvEU+AQ==
X-Received: by 2002:a05:6a00:3d0e:b0:71e:55e2:2c54 with SMTP id d2e1a72fcca58-72062fb8c93mr62440510b3a.12.1730992967651;
        Thu, 07 Nov 2024 07:22:47 -0800 (PST)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffc2sm1724687b3a.25.2024.11.07.07.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 07:22:47 -0800 (PST)
Date: Thu, 7 Nov 2024 07:22:44 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Chen Yu <yu.c.chen@intel.com>, Leonardo Bras <leobras@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3 0/3] sched/topology: optimize topology_span_sane()
Message-ID: <ZyzbRKEtOj54mdJQ@yury-ThinkPad>
References: <20240902183609.1683756-1-yury.norov@gmail.com>
 <20241106180613.GQ10375@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106180613.GQ10375@noisy.programming.kicks-ass.net>

On Wed, Nov 06, 2024 at 07:06:13PM +0100, Peter Zijlstra wrote:
> On Mon, Sep 02, 2024 at 11:36:04AM -0700, Yury Norov wrote:
> > The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
> > even when cpu != i. In such case, cpumask_equal() would always return
> > true, and we can proceed to the next iteration immediately.
> > 
> > Valentin Schneider shares on it:
> > 
> >   PKG can potentially hit that condition, and so can any
> >   sched_domain_mask_f that relies on the node masks...
> > 
> >   I'm thinking ideally we should have checks in place to
> >   ensure all node_to_cpumask_map[] masks are disjoint,
> >   then we could entirely skip the levels that use these
> >   masks in topology_span_sane(), but there's unfortunately
> >   no nice way to flag them... Also there would be cases
> >   where there's no real difference between PKG and NODE
> >   other than NODE is still based on a per-cpu cpumask and
> >   PKG isn't, so I don't see a nicer way to go about this.
> > 
> > v1: https://lore.kernel.org/lkml/ZrJk00cmVaUIAr4G@yury-ThinkPad/T/
> > v2: https://lkml.org/lkml/2024/8/7/1299
> > v3:
> >  - add topology_cpumask_equal() helper in #3;
> >  - re-use 'cpu' as an iterator int the for_each_cpu() loop;
> >  - add proper versioning for all patches.
> > 
> > Yury Norov (3):
> >   sched/topology: pre-compute topology_span_sane() loop params
> >   sched/topology: optimize topology_span_sane()
> >   sched/topology: reorganize topology_span_sane() checking order
> 
> Why are we doing this? Subject says optimize, but I see no performance
> numbers?

Well, if we have a chance that cpumask_equal() is passed with
mask1 == mask2, the new vs old approach is O(1) vs O(N), and this
is the case of PKG. This should have performance impact for many-CPUs
setups (much more than BITS_PER_LONG).

I have no such machine, and can't give you perf numbers. I can drop
'optimization' wording, if you find it confusing without numbers.

Thanks,
Yury

