Return-Path: <linux-kernel+bounces-377065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C9E9AB96E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446C22818ED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6339E1CCEF9;
	Tue, 22 Oct 2024 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeYQK7DP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE35F1CCEE7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635870; cv=none; b=Fa0C75NWeJ46XVNJeYuw5BJtrjjonnJoG4Sg2vj8ykm3FZTM182OIgZTGvJjRXGLH58P+n4/UK+0sEGvYWBz/dkSQKCF4e9iHCsVNOPcdX5Z9F7KRf0Yiigg1C4+DhLWUg1XbK2FVpjFVs4xIHNBYPkuwEZCDmBtRdGeFQq2qlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635870; c=relaxed/simple;
	bh=aO/xI4cfVljE7AbUAmNt36EHxk0qELyvxWnrtGsLhm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3fsTZdhE630YG1bnrMVfpSkmbtnOuXDPan5Cp4TZrp5hLZp/tXWO1YYwOfVK5Q6WfNOYrSG/M45fOskwiJxDeI1y2x5tVf3GGtuGf/cBMNgxlNkb3jdeQyNlOvkEt2YxPfICGKfyCZ0w9moE7cx+HC96dZuDHsM0tF4VAf/aoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeYQK7DP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E345FC4CEC3;
	Tue, 22 Oct 2024 22:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729635870;
	bh=aO/xI4cfVljE7AbUAmNt36EHxk0qELyvxWnrtGsLhm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DeYQK7DP4sSDAnHjRP/Kh6UauD97v6LNuYonqJgaW6AGKh+fNqN+mIEEvObcoJaZV
	 UsmRpk7i8vekGB440RNCOF/hgvk6o1mNE9ZbSJKa8i3pSlkhe4GJYyPc/oEOuzin/G
	 n67gMWdALdQNrtjRxuXs7i95ebMReQVP1MfPU8LF1/nbNV7XD30onDQGkxv4IFFsAD
	 hbgi11NNymjrkmsleecAfMQLwNYktsuTaCj5M/nUXIVyneqUpfT/LuH9/qahTcFck/
	 2iNoK7Rbm2Po7HuhN9W+AXVV1vCuYvZEMGMjgoFEWHp+/AFUpSF7ZjrN1+YimN5yc9
	 25U+2kiTtUzuA==
Date: Tue, 22 Oct 2024 15:24:28 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH 5/5] perf/x86: Relax privilege filter restriction on AMD
 IBS
Message-ID: <ZxgmHJooUPE5-i0O@google.com>
References: <20240905031027.2567913-1-namhyung@kernel.org>
 <20240905031027.2567913-6-namhyung@kernel.org>
 <e9ddcfb1-b3d3-4ac7-a21a-b7543f449547@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9ddcfb1-b3d3-4ac7-a21a-b7543f449547@amd.com>

Hello,

On Mon, Sep 23, 2024 at 04:03:47PM +0530, Ravi Bangoria wrote:
> Hi Namhyung,
> 
> > While IBS is available for per-thread profiling, still regular users
> > cannot open an event due to the default paranoid setting (2) which
> > doesn't allow unprivileged users to get kernel samples.  That means
> > it needs to set exclude_kernel bit in the attribute but IBS driver
> > would reject it since it has PERF_PMU_CAP_NO_EXCLUDE.  This is not what
> > we want and I've been getting requests to fix this issue.
> 
> I'm working on some IBS improvements that impacts this change as well.
> Is it be possible to hold off this patch for some time. I'll try to
> post my patches soon.
> 
> > @@ -1111,6 +1127,12 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
> >  		regs.flags |= PERF_EFLAGS_EXACT;
> >  	}
> >  
> > +	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
> > +	    perf_exclude_event(event, &regs)) {
> > +		throttle = perf_event_account_interrupt(event);
> > +		goto out;
> > +	}
> 
> Throttling can give surprises when the sample period is very small.
> For ex,
> 
>   $ ./perf record -e cycles:uh -c 192 -- make
>   [ perf record: Woken up 52 times to write data ]
>   [ perf record: Captured and wrote 23.016 MB perf.data (705634 samples) ]
> 
>   $ ./perf record -e ibs_op/swfilt=1/uh -c 192 -- make
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 1.608 MB perf.data (19 samples) ]
> 
> It seems like the IBS event gets throttled (and disabled) before the
> cpu get a chance to go back to userspace), hence we end up with very
> few samples.

Thanks for raising this issue.  This indeed looks like a surprising
result.  Not sure what we can do here other than adding a documentation
to refrain from using such a small period.  I don't think we want to
skip the throttling logic for the filtered samples.  Otherwise it can be
used for DoS-like attacks IMHO.

Thanks,
Namhyung




