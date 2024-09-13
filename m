Return-Path: <linux-kernel+bounces-328298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6A6978191
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F6CB21DE7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7296A1DB93B;
	Fri, 13 Sep 2024 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEe89d3e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDF643144;
	Fri, 13 Sep 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235638; cv=none; b=Rk+nzVjJ/srTWJP8INIxnwSMFGax+ra3tD0qWnn1lNmyuMLuSDBM/EBI+SdEFEsqK0HVNShFdjuelnGju3JMij1gbGEHkFG2ycCXz9jLMJFauENHClYWpEdieUj8k3MsBTqKAW7EtMrm7TIzaLPvJ/RPtXAnV81HT9gvWjTziW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235638; c=relaxed/simple;
	bh=rVevnvXuQWrdT9twLT7q7mUZss+Iqc2O3+KUpgpGlUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKpSaDs6xQgncB8gcSchyjrrjsVT1uBylOzovvHEkacT6zGqWFYnQNxIOGdXAvbM5w8NvG01tmzQOfuuMCvcdw0XWkQPB/bEK4soLK3lyuynsKYU8lJXUvHDEeXX3zd1fMrfFvxPCs/17S1BqjwMhnOVXFpCKZpWNy6iqNe9pIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEe89d3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16049C4CEC0;
	Fri, 13 Sep 2024 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726235638;
	bh=rVevnvXuQWrdT9twLT7q7mUZss+Iqc2O3+KUpgpGlUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uEe89d3eEaVXJi2XZjae5kuiBApmuYRrWnYHqeA1vN/X+IFB1ompbPefKlyZtTnsg
	 UFYjQ7/9OhK8+CldH1wEsTt2qx4PJxVMWYAqtfQMilWVn8+242eRc8B6g39DvFNoZg
	 coc80fKCd0c5VnN3j35zz99udzDXMKH4ILSrkyBRvckZbT6W8iKsrtgLyXgJYTO9B/
	 JtjuGe01uQso7OgyxEY46H1LAdCbEP3pVgebi8jO/vnTGNGrjcSKO3hhEbksUFJxXE
	 6flMoKm8tUjn9JzjUaGD7rvUYwpGS2FPB+f9pN29uu14Qf7EPEN0JcoT/ZRL6FBtbb
	 YXAciEquWNzGg==
Date: Fri, 13 Sep 2024 06:53:51 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: Re: [PATCH RFC 04/10] perf: Introduce deferred user callchains
Message-ID: <20240913135351.tyjuekjzvb5xtawn@treble>
References: <cover.1699487758.git.jpoimboe@kernel.org>
 <d5def69b0c88bcbe2a85d0e1fd6cfca62b472ed4.1699487758.git.jpoimboe@kernel.org>
 <CAM9d7chZcqR8WCEYtjpP4KzUOeNdJ=kSvae0UrjsO8OgsepjDw@mail.gmail.com>
 <20231111184908.ym4l6cwzwnkl7e6m@treble>
 <CAM9d7chgoiwc3ZfQ8SzO7gV0oQOKMK3bJAdxa63Pzgcqo4i7tQ@mail.gmail.com>
 <ZVTuK5VRQfY1JOEY@google.com>
 <20231120140334.GW8262@noisy.programming.kicks-ass.net>
 <20240913130834.hq4gj27fcklakkzb@treble>
 <20240913133629.GV4723@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913133629.GV4723@noisy.programming.kicks-ass.net>

On Fri, Sep 13, 2024 at 03:36:29PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 13, 2024 at 06:08:34AM -0700, Josh Poimboeuf wrote:
> > On Mon, Nov 20, 2023 at 03:03:34PM +0100, Peter Zijlstra wrote:
> > > On Wed, Nov 15, 2023 at 08:13:31AM -0800, Namhyung Kim wrote:
> > > 
> > > > ---8<---
> > > > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > > > index 39c6a250dd1b..a3765ff59798 100644
> > > > --- a/include/uapi/linux/perf_event.h
> > > > +++ b/include/uapi/linux/perf_event.h
> > > > @@ -456,7 +456,8 @@ struct perf_event_attr {
> > > >  				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
> > > >  				remove_on_exec :  1, /* event is removed from task on exec */
> > > >  				sigtrap        :  1, /* send synchronous SIGTRAP on event */
> > > > -				__reserved_1   : 26;
> > > > +				defer_callchain:  1, /* generate DEFERRED_CALLCHAINS records for userspace */
> > > > +				__reserved_1   : 25;
> > > >  
> > > >  	union {
> > > >  		__u32		wakeup_events;	  /* wakeup every n events */
> > > > @@ -1207,6 +1208,20 @@ enum perf_event_type {
> > > >  	 */
> > > >  	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
> > > >  
> > > > +	/*
> > > > +	 * Deferred user stack callchains (for SFrame).  Previous samples would
> > > 
> > > Possibly also useful for ShadowStack based unwinders. And by virtue of
> > > it possibly saving work when multiple consecutive samples hit
> > > the same kernel section, for everything.
> > 
> > [ necroing old thread as I'm finally working on a v2 ]
> > 
> > Peter, can you elaborate?  What did you mean by "same kernel section"?
> > 
> > Like if there's a duplicate kernel callchain?  Or something else?
> 
> Yeah, multiple samples hitting the same syscall invocation will, by
> necessity, have the same user callchain.

Ah, I thought you were talking about kernel callchains for some reason.
n/m...

-- 
Josh

