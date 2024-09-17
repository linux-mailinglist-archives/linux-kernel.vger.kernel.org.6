Return-Path: <linux-kernel+bounces-331358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE9297ABCB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D58531F24C06
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08118148833;
	Tue, 17 Sep 2024 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PsEHh3h8"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7183873446
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726556727; cv=none; b=Sos/qIQxg/JVNlDCwDo88jbBQ1sj8wqfUgtIsP50mMYUZShWAuyvXQND8yY9fH7zSZ5hoU5PsUMhSswDq4R6oMRxEFGkrh9D08SEayu5IY69STysToH+AoVU5/2i8ywkjrPsKF3QuB4QBPDegBaiCfln4ctMqHQn8R/srh+MD4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726556727; c=relaxed/simple;
	bh=pPCDGkmjaJFiaG0NM6Gk+8jx2l1609rB2A5MJWi94cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFWKNNRUf6p0znLPFBR/tc9XHhC3cjd09cvWczWmrD8/RWF74CeB/yotSdF6imc8Ek2L5KAb73L7q5rIH5h1bs4bsuvP2Iim72YLZ5nJYBi8yKrnQxpAOfLWzjGl1R1/bjuAcXuvXwTDgLIRxBeNWAI8Sdq7Cu1s46dY8SIGDFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PsEHh3h8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so53717575e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 00:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726556724; x=1727161524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ILf67Y81lASSuXGrTQfS2z5An5s8u2dCx//Qru/Z7g=;
        b=PsEHh3h8rw3rS0dUK8fB62LBW9ItWC6Umdtle2/nBYdTeCEp8VG5ZE4mX8thDhRGo+
         dVT6G0j4V7fd3ScdKFxrmO6KVFMH+WwtRxcPIRFYqTnhUieJsS4Zt8BzzInDG0GqP56A
         hncoWZ7vf5ng6SpEslj2flVhnjPXtLzv96y1ZA1kDNe18rQz+HgOdkxpQ7scQykNmW2e
         MIYzlqT3lDL86PrGAH+fwbVnnxOgl/HIVl4GNaP36meYbQVxGxaofT2cAYJIiHoT5dfp
         g321ZGmqKnOVnl++E6iwRqzE8Mv9/kJTpt2ImkspCXghg61lv/j3IJZaObIAZ0e3kMuO
         PaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726556724; x=1727161524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ILf67Y81lASSuXGrTQfS2z5An5s8u2dCx//Qru/Z7g=;
        b=ZC2H1VvXk6dgmYtqaZfDTpUXWbYKLvZuH5RZzUzfasKFpaSXCuHe8+snaHmWtoVjRM
         as3nS5tiN2KTj+SfE4cIy7yB7tOGkLxGhxTq8FrXpPwy2Fz/ZvGt5q3BT0jLJehYINwt
         PKOTy5sWmRty5GGIvhbaawtxq02h71U4LIZDNk24u5ZcmgTxs1mQEPNDI3ZF0+r1Duer
         z+UWZ53HvWyxexYXMmgVqXN+2jVqdU9kYFEBci8thC6ggd4r9RZrxgRypBDGrUiQKa/X
         D0JN6ARXYkPa2ZFSvy/ETk/RlInAcqNPGfxdULTDCYEli3k/47RanKVPpODx6rZOugZq
         rfow==
X-Forwarded-Encrypted: i=1; AJvYcCVqy7BI8L8J/Hsg4gMLP6SuQoxMttSUHvZG3U/LJoovpMe16xaHxMCxgqGUcmb02g48vdt5ooRAj/zAoFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkG/iK20l/eZoB8lSM3x6z6CXII6xBNJoqI/RCOOdnf8PeQ0/G
	MdqQBFsYh8otCdsWSFnv1bUO+HVxkhuq46V67/uU1/1KXqX/6d6rjFb0ZHDK6PU=
X-Google-Smtp-Source: AGHT+IH3o/npKUx4YaHbMCjDDrmqsFqTss9Txf7nthZNJj9hxmPQ6MElpiejAbOBFTxY5d2alc+OAw==
X-Received: by 2002:a05:600c:3588:b0:42c:bcc8:5882 with SMTP id 5b1f17b1804b1-42d9070a259mr154521055e9.7.1726556723600;
        Tue, 17 Sep 2024 00:05:23 -0700 (PDT)
Received: from localhost (109-81-84-13.rct.o2.cz. [109.81.84.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b055052sm129132255e9.9.2024.09.17.00.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 00:05:23 -0700 (PDT)
Date: Tue, 17 Sep 2024 09:05:22 +0200
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 12/19] kthread: Default affine kthread to its preferred
 NUMA node
Message-ID: <ZukqMvPU03hgCLHu@tiehlicka>
References: <20240916224925.20540-1-frederic@kernel.org>
 <20240916224925.20540-13-frederic@kernel.org>
 <ZukhKXxErPOaXtAL@tiehlicka>
 <4b107fec-e391-4680-9457-b282310b4454@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b107fec-e391-4680-9457-b282310b4454@suse.cz>

On Tue 17-09-24 09:01:08, Vlastimil Babka wrote:
> On 9/17/24 8:26 AM, Michal Hocko wrote:
> > On Tue 17-09-24 00:49:16, Frederic Weisbecker wrote:
> >> Kthreads attached to a preferred NUMA node for their task structure
> >> allocation can also be assumed to run preferrably within that same node.
> >>
> >> A more precise affinity is usually notified by calling
> >> kthread_create_on_cpu() or kthread_bind[_mask]() before the first wakeup.
> >>
> >> For the others, a default affinity to the node is desired and sometimes
> >> implemented with more or less success when it comes to deal with hotplug
> >> events and nohz_full / CPU Isolation interactions:
> >>
> >> - kcompactd is affine to its node and handles hotplug but not CPU Isolation
> >> - kswapd is affine to its node and ignores hotplug and CPU Isolation
> >> - A bunch of drivers create their kthreads on a specific node and
> >>   don't take care about affining further.
> >>
> >> Handle that default node affinity preference at the generic level
> >> instead, provided a kthread is created on an actual node and doesn't
> >> apply any specific affinity such as a given CPU or a custom cpumask to
> >> bind to before its first wake-up.
> > 
> > Makes sense.
> > 
> >> This generic handling is aware of CPU hotplug events and CPU isolation
> >> such that:
> >>
> >> * When a housekeeping CPU goes up and is part of the node of a given
> >>   kthread, it is added to its applied affinity set (and
> >>   possibly the default last resort online housekeeping set is removed
> >>   from the set).
> >>
> >> * When a housekeeping CPU goes down while it was part of the node of a
> >>   kthread, it is removed from the kthread's applied
> >>   affinity. The last resort is to affine the kthread to all online
> >>   housekeeping CPUs.
> > 
> > But I am not really sure about this part. Sure it makes sense to set the
> > affinity to exclude isolated CPUs but why do we care about hotplug
> > events at all. Let's say we offline all cpus from a given node (or
> > that all but isolated cpus are offline - is this even
> > realistic/reasonable usecase?). Wouldn't scheduler ignore the kthread's
> > affinity in such a case? In other words how is that different from
> > tasksetting an userspace task to a cpu that goes offline? We still do
> > allow such a task to run, right? We just do not care about affinity
> > anymore.
> 
> AFAIU it handles better the situation where all houskeeping cpus from
> the preferred node go down, then it affines to houskeeping cpus from any
> node vs any cpu including isolated ones.

Doesn't that happen automagically? Or can it end up on a random
isolated cpu?

-- 
Michal Hocko
SUSE Labs

