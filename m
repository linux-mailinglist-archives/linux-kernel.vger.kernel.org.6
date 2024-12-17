Return-Path: <linux-kernel+bounces-448895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF2F9F46F2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C943188E9C6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A421DE4C0;
	Tue, 17 Dec 2024 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GY1cYrqU"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D141DA313
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426747; cv=none; b=egkpRvCa052lnz/90R7mBkYvPO7BwN517P85LTEEQeeZ+L5t/MR2wY1t2JcPSaesQ9J6aGFVSI2NnLLUL217LBjOW29U0F8dmofft3hSbiglps6UgMGuRAaVV4DQ5wqvSdEIDy+mQDmoe8rsY+UwqECYxUmy5TxZo2R7m/mClXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426747; c=relaxed/simple;
	bh=p9jO5lSXdelSFC6CayBo+BvRCoASRBaBHRre2sHzw1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8DLBLh+NgzP53zQfE8+qh3wlgavph4+Jn8dDAUbr6cdFSFIrwVKc0VoO0jiHFsWpmDi1fjTzmXnuPx8oWQJYmx/Q8rvAdaL+CWU1gAAAtbUd+I7x+SQcCO4kweFgKIcZslBlnISP/HhuY8nQq3jirst9+ilmIP+5ol4f/YJqUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GY1cYrqU; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uSbP7gXqYJZocfKFbwndGsTE/Q35OQmnvkaSMGVNT+0=; b=GY1cYrqUlheN34CxAaRss4iOBQ
	QPOM5K/PF5zhTiHLZnVhzT3lU4xiSE5Qdp/OvmZyS8mo7psyLDejEDmfzDcGPUADWWofnZTHj0Wa3
	reQiO53N0nAfF2qkDmSJwgCplYn8ap5WBmd3j86u5k3ZZJC5mHoOTlGPZ7O7vht0q186dDOy4fVLe
	L9HwBCeCS6HFKAmzlU6/XbnFwUgv+ugVIWrb747fwMyavewjbQ+BOnfx/5N7HBUlAOAXN00DrqPt/
	Khh2I8WHSCIiTqKGMvJ3y9tHV+wWON4l0dmvWxYFWcu71ZN/aGviyny2AtfVXJvQct2QOxGkSUFCU
	mMQVSsQw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTcn-0000000536t-15lv;
	Tue, 17 Dec 2024 09:12:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8E2F630015F; Tue, 17 Dec 2024 10:12:16 +0100 (CET)
Date: Tue, 17 Dec 2024 10:12:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: "mingo@kernel.org" <mingo@kernel.org>,
	"lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"willy@infradead.org" <willy@infradead.org>,
	"acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>
Subject: Re: [PATCH 19/19] perf: Make perf_pmu_unregister() useable
Message-ID: <20241217091216.GK35539@noisy.programming.kicks-ass.net>
References: <20241104133909.669111662@infradead.org>
 <20241104135519.715883982@infradead.org>
 <ae1f9492-dae0-4ce8-aa6b-f1890faf67e7@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae1f9492-dae0-4ce8-aa6b-f1890faf67e7@amd.com>



Oh sorry, I seem to have missed this email :/

On Mon, Nov 25, 2024 at 09:40:28AM +0530, Ravi Bangoria wrote:
> Hi Peter,
> 
> > @@ -6507,6 +6540,7 @@ static void perf_mmap_close(struct vm_ar
> >  	unsigned long size = perf_data_size(rb);
> >  	bool detach_rest = false;
> >  
> > +	/* FIXIES vs perf_pmu_unregister() */
> >  	if (event->pmu->event_unmapped)
> >  		event->pmu->event_unmapped(event, vma->vm_mm);
> 
> I assume you are already aware of the race between __pmu_detach_event()
> and perf_mmap_close() since you have put that comment. 

That comment was mostly about how we can't fix up the whole
->event_unmapped() thing and have to abort pmu_unregister for it.

> In any case, below sequence of operations triggers a splat when
> perf_mmap_close() tries to access event->rb, event->pmu etc. which
> were already freed by __pmu_detach_event().
> 
> Sequence:
> 
>     Kernel                       Userspace
>     ------                       ---------
>     perf_pmu_register()
>                                 fd = perf_event_open()
>                                 p = mmap(fd)
>     perf_pmu_unregister()
>                                 munmap(p)
>                                 close(fd)

Right, let me go have a look. Thanks!

