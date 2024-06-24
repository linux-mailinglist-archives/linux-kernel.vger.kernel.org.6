Return-Path: <linux-kernel+bounces-226856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A390F9144D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4702856A2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24F64CDEC;
	Mon, 24 Jun 2024 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NSnDzzr8"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99D04436E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217702; cv=none; b=Dg+80dDBh8tKG/Yz010l+sUSSCcw7b3snqEoj7eGcGfLd2UaIqkwYbqo6EN5BNvnsKBLFFR9M+l/D2rBuQ7A2YkUTMC579C5bxfGCrh6tDw+AWwv6p8RK+exxuqnyg/7Q3EHENqZGYnti1OS8ToYCPnxPvhR03MgEA5oxD6vWrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217702; c=relaxed/simple;
	bh=ajiAfO+cDcoKo+9QiS52+/jBRTL6h9SBfyHvSj9bSDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLX0KJVWzKTJVABzk4O3ks1QA3p4t0CeTN7pVZ8KeOdfLKgQmaD+A7869eirhKS1qRA4GvmU2EuFvM4ksUZ5pCFjO7DISkIKITP+ZzHyToYJTeGNgBA1SEt6Hn+bmlQd0W7etMTh47Kbn5okKiZCniz9czKErryis/srIClxCec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NSnDzzr8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WXgC2rNgvnn+rQ+KdtcAxKeS+YAny2d2IdUeJZOfxRE=; b=NSnDzzr8G6rhkDhQp8UM6p3Oo1
	91I3sQlq344+GpoGmTkETsBzs2bZQfbvSx/Y4/CN69DdtM60JWQdg97abce9ecFfAJXpdOZ+x1oTm
	pQvjQDzplpjneprCeqTF8SB54qDu6s8f9AlPJD8VSn0L43AmEHPTwtQE6QbYYvW76jl8vZ06+S1dJ
	tpSdlq6e7jW24wip+Mun/BmSFeOPBOXW+5sZ1zMSaZngs7yfzSxpe3HJWnyT/NfAnEP6KfjsQpnVr
	CWilRlB3u6rStuJsnenSqy4obWAYEGUIESyMQf4i1XdVpViNT5u8UF2jkoYs3sQLyaMWW5bv65aq5
	zx79VikA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLf3a-00000008Cvz-0j42;
	Mon, 24 Jun 2024 08:28:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7114E300DCB; Mon, 24 Jun 2024 10:28:09 +0200 (CEST)
Date: Mon, 24 Jun 2024 10:28:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [RESEND PATCH 05/12] perf/x86: Add config_mask to represent
 EVENTSEL bitmask
Message-ID: <20240624082809.GC31592@noisy.programming.kicks-ass.net>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-6-kan.liang@linux.intel.com>
 <20240620074402.GS31592@noisy.programming.kicks-ass.net>
 <4cce9f37-7698-418d-a9c5-4aa1dc01b719@linux.intel.com>
 <ff25c37f-cb62-4687-adaa-596e8fc3a52a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff25c37f-cb62-4687-adaa-596e8fc3a52a@linux.intel.com>

On Fri, Jun 21, 2024 at 02:34:35PM -0400, Liang, Kan wrote:
> 
> 
> On 2024-06-20 12:16 p.m., Liang, Kan wrote:
> > 
> > 
> > On 2024-06-20 3:44 a.m., Peter Zijlstra wrote:
> >> On Tue, Jun 18, 2024 at 08:10:37AM -0700, kan.liang@linux.intel.com wrote:
> >>> From: Kan Liang <kan.liang@linux.intel.com>
> >>>
> >>> Different vendors may support different fields in EVENTSEL MSR, such as
> >>> Intel would introduce new fields umask2 and eq bits in EVENTSEL MSR
> >>> since Perfmon version 6. However, a fixed mask X86_RAW_EVENT_MASK is
> >>> used to filter the attr.config.
> >>>
> >>
> >>> @@ -1231,6 +1233,11 @@ static inline int x86_pmu_num_counters_fixed(struct pmu *pmu)
> >>>  	return hweight64(hybrid(pmu, fixed_cntr_mask64));
> >>>  }
> >>>  
> >>> +static inline u64 x86_pmu_get_event_config(struct perf_event *event)
> >>> +{
> >>> +	return event->attr.config & hybrid(event->pmu, config_mask);
> >>> +}
> >>
> >> Seriously, we're going to be having such major event encoding
> >> differences between cores on a single chip?
> > 
> > For LNL, no. But ARL-H may have an event encoding differences.
> > I will double check.
> 
> There are two generations of e-core on ARL-H. The event encoding is
> different.
> 
> The new fields umask2 and eq bits are enumerated by CPUID.(EAX=23H,
> ECX=0H):EBX. They are supported by CPU 11 but not CPU 12.
> 
> CPU 11:
>    0x00000023 0x00: eax=0x0000000f ebx=0x00000003 ecx=0x00000008
> edx=0x00000000
> CPU 12:
>    0x00000023 0x00: eax=0x0000000b ebx=0x00000000 ecx=0x00000006
> edx=0x00000000
> 

*groan*...

So we're going to be having 3 PMUs on that thing I suppose. Oh well.

