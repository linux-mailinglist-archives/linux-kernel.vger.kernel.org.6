Return-Path: <linux-kernel+bounces-377067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B219AB974
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843D01F23999
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5291CCEF9;
	Tue, 22 Oct 2024 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKAdn1N3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84211BD4F9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635944; cv=none; b=r4jF/c1jU1cF5kLGDegSu0+Ybl1R5Ep6xIS/alfQtIN59sCVBdD2LMnER2fM7q1TrwSTA+G7UeAleMAf8XWSmBUuU7nIr0aS4XZ885H2sfystuwPgm6f6zJMX1hH/tKfpX4QUX8y1wnrgOs+hZK/O5AQ3Gbxmw7bbkF6nvdaQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635944; c=relaxed/simple;
	bh=N0LPDcrfLkRnaKSBZN0tR4CqQGZZHF+TGNXD4iKi6Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFniih3yn4IFtDszeYFPJYO2ohC89LqwfUfE4z1a2yCgDxTebrQY8n+ubUUN1yCLoXZtX6HHpqlVYTe9j7aSDfQeu33HPE8D3SE+N3uiDH9RHDEdIwzpenSdBIFrovF7pQM5hwn+CElJTKVJsJkVcFI5bJbv5BD8RtfBhLlOBtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKAdn1N3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF03C4CECD;
	Tue, 22 Oct 2024 22:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729635944;
	bh=N0LPDcrfLkRnaKSBZN0tR4CqQGZZHF+TGNXD4iKi6Wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nKAdn1N3X0Goqp4kpdQMRFOHhBUnjmJ2NUzonqI4QR/Mm/A8eh4Nq9oFbrbJ80+jy
	 +i7UBMau9Ly88rl+OXlkIilDVmciUVIBmGrMJzVo2X1CPOVvNIfTqTf26uiUGgR8YG
	 BROjYjqkVRcwQESnV2corM8B8iFCMoWVAzYceTtlm6I3WLKj46tbzlfN+rpySDUCBH
	 sa2D1OzlzkyE+5hQvSsSCtylvnmrJUAcx/9WhjI/6zlrVdaBgJGbOstUKTIMbGhO2x
	 hs4tep7o/f+9u5eW1Bhdlj9p9pwRHnQPmMwGo/ZAK80et2JT1BBG4/i7BscPuT9zmr
	 Q/ObYbx/du8vA==
Date: Tue, 22 Oct 2024 15:25:41 -0700
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
Message-ID: <ZxgmZd0Hryqr6BoN@google.com>
References: <20240905031027.2567913-1-namhyung@kernel.org>
 <20240905031027.2567913-6-namhyung@kernel.org>
 <49fd4eb5-ee7b-45f5-a40f-dbfd793cdff4@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <49fd4eb5-ee7b-45f5-a40f-dbfd793cdff4@amd.com>

On Tue, Oct 15, 2024 at 07:06:24PM +0530, Ravi Bangoria wrote:
> Hi Namhyung,
> 
> On 05-Sep-24 8:40 AM, Namhyung Kim wrote:
> > While IBS is available for per-thread profiling, still regular users
> > cannot open an event due to the default paranoid setting (2) which
> > doesn't allow unprivileged users to get kernel samples.  That means
> > it needs to set exclude_kernel bit in the attribute but IBS driver
> > would reject it since it has PERF_PMU_CAP_NO_EXCLUDE.  This is not what
> > we want and I've been getting requests to fix this issue.
> > 
> > This should be done in the hardware, but until we get the HW fix we may
> > allow exclude_{kernel,user} in the attribute and silently drop the
> > samples in the PMU IRQ handler.  It won't guarantee the sampling
> > frequency or even it'd miss some with fixed period too.  Not ideal,
> > but that'd still be helpful to regular users.
> > 
> > To minimize the confusion, let's add 'swfilt' bit to attr.config2 which
> > is exposed in the sysfs format directory so that users can figure out
> > if the kernel support the privilege filters by software.
> > 
> >   $ perf record -e ibs_op/swfilt=1/uh true
> 
> Shall we add an example in tools/perf/Documentation/perf-amd-ibs.txt?

Yep, I'll update the document when I send the tooling changes.

> 
> 
> > +static struct attribute *swfilt_attrs[] = {
> > +	&format_attr_swfilt.attr,
> > +	NULL,
> > +};
> > +
> >  static struct attribute *fetch_l3missonly_attrs[] = {
> >  	&fetch_l3missonly.attr.attr,
> >  	NULL,
> > @@ -598,6 +604,11 @@ static struct attribute_group group_rand_en = {
> >  	.attrs = rand_en_attrs,
> >  };
> >  
> > +static struct attribute_group group_swfilt = {
> > +	.name = "format",
> > +	.attrs = swfilt_attrs,
> > +};
> > +
> >  static struct attribute_group group_fetch_l3missonly = {
> >  	.name = "format",
> >  	.attrs = fetch_l3missonly_attrs,
> > @@ -612,6 +623,7 @@ static struct attribute_group group_zen4_ibs_extensions = {
> >  
> >  static const struct attribute_group *fetch_attr_groups[] = {
> >  	&group_rand_en,
> > +	&group_swfilt,
> >  	&empty_caps_group,
> >  	NULL,
> >  };
> 
> Causes:
> 
>   # dmesg
>   sysfs: cannot create duplicate filename '/devices/ibs_fetch/format'
>   Failed to register pmu: ibs_fetch, reason -17
> 
> Rename rand_en_attrs[] to fetch_attrs[], add &format_attr_swfilt.attr
> to it and remove &group_swfilt from fetch_attr_groups[]. And I guess
> it should work.

Thanks for the review, I'll update the code as you suggested.

Namhyung


