Return-Path: <linux-kernel+bounces-321943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25359721B6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD5D1C21DED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AEB16F0F0;
	Mon,  9 Sep 2024 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6x4Jdbc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04973168BD
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725905766; cv=none; b=sbpGsF0OVTvoC+RcQFFJsWX9zxD0Qal6aeHZFnYq7h/898nQ/oUVkJnnY1STw0Cf5LG5PJcj0EE4w1WTNdncZpdt+mpuxZyBcJQKpBstTpYfIisPhPU+fioj9ubVKUV4vSs616EFoEd/NzCYwFqKnYRIbAex5H/NWQgaCtimQPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725905766; c=relaxed/simple;
	bh=cxdmetCL9XfmhK7k3+eMi9cdkYfDF0g/tvIZWFp9QN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzagnUM6S8iwDPDuPDMV2EVzH2xLRZbmZTZwtiqrEVizpRK9U0muQy9TUcHmnsikTzkT1kRf3SCuIBCyBaTTXmC8nml394mxSgMgAb5rV+cTSwhFZ/FydxTB0dPCenOvIsMLbQQC5mm27FxPzU4FVkRRDr+/pWfCjIdBYBoj920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6x4Jdbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339DFC4CEC5;
	Mon,  9 Sep 2024 18:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725905765;
	bh=cxdmetCL9XfmhK7k3+eMi9cdkYfDF0g/tvIZWFp9QN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6x4JdbcpehgK1+75T739VjtuRE6V6T0H3vOEtIYIda6HP8NZa/2Foz5Jj0+t0W6e
	 gRiQ1oCLzvOVFEJjjES80SoecP3zuwhzTgV4gZHW3WQBb+l2w8cKbvQGaLF5FJkOM2
	 P8e2Fgj2U9U4oZfqErbea8kHYHFChC4FWXTxHJyep8jJ+tr5zqaKnw8+Nxz2SIqrve
	 AZfg56zt/JkvLCqAr9KBYElAraN6ulwdttXOj0r4dgbQFzJCXwsBN+9J69m8UhjkX5
	 c+5rU9Vmzy2kjUOlD76rFC92aiK4RHNYf/cVZE7egDsrXxz+4zq8y18H9JEBLgoD6Y
	 ROlaq8LmItQKA==
Date: Mon, 9 Sep 2024 11:16:03 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [RFC/PATCH 0/5] perf: Relax privilege restriction on AMD IBS (v3)
Message-ID: <Zt87YyzKFS4jes2n@google.com>
References: <20240905031027.2567913-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240905031027.2567913-1-namhyung@kernel.org>

On Wed, Sep 04, 2024 at 08:10:22PM -0700, Namhyung Kim wrote:
> Hello,
> 
> This is RFC v3 to allow AMD IBS to regular users on the default settings
> where kernel-level profiling is disabled (perf_event_paranoid=2).
> Currently AMD IBS doesn't allow any kind of exclusion in the event
> attribute.  But users needs to set attr.exclude_kernel to open an event
> on such an environment.
> 
> v3 changes)
> 
> * fix build on s390
> * add swfilt format for attr.config2
> * count powerpc core-book3s dropped samples
> 
> v2) https://lore.kernel.org/lkml/20240830232910.1839548-1-namhyung@kernel.org/
> 
> * add PERF_FORMAT_DROPPED
> * account dropped sw events and from BPF handler
> * use precise RIP from IBS record
> 
> v1) https://lore.kernel.org/lkml/20240822230816.564262-1-namhyung@kernel.org/
> 
> While IBS doesn't support hardware level privilege filters, the kernel
> can allow the event and drop samples belongs to the kernel like in the
> software events.  This is limited but it still contains precise samples
> which is important for various analysis like data type profiling.
> 
> This version added format/swfilt file in sysfs to expose the software
> filtering by setting the attribute config2 value.  I think it's easier
> to add a new config rather than adding a new PMU in order to handle
> event multiplexing across IBS PMU.  Users can use the perf tool to
> enable this feature manually like below.  Probably the perf tool can
> handle this automatically in the future.
> 
>   $ perf record -e ibs_op/swfilt=1/uh $PROG
> 
> (Not sure if it's better to accept or ignore exclude_hv so that it can
> use ":u" modifier only.)
> 
> In order to count those dropped samples correctly, I'd propose a new
> read format PERF_FORMAT_DROPPED same as we did for the lost samples.
> With this, it can count dropped samples in the software events and
> from the BPF overflow handler as well.
> 
> Let me know what you think.

Hi Peter and Ingo,

can I get your opinion on this?

Thanks,
Namhyung

> 
> Namhyung Kim (5):
>   perf/core: Add PERF_FORMAT_DROPPED
>   perf/core: Export perf_exclude_event()
>   perf/core: Account dropped samples from BPF
>   perf/powerpc: Count dropped samples in core-book3s PMU
>   perf/x86: Relax privilege filter restriction on AMD IBS
> 
>  arch/powerpc/perf/core-book3s.c |  4 ++-
>  arch/s390/kernel/perf_cpum_sf.c |  8 ++++--
>  arch/x86/events/amd/ibs.c       | 50 ++++++++++++++++++++++++---------
>  include/linux/perf_event.h      |  7 +++++
>  include/uapi/linux/perf_event.h |  5 +++-
>  kernel/events/core.c            | 27 ++++++++++++++----
>  6 files changed, 77 insertions(+), 24 deletions(-)
> 
> -- 
> 2.46.0.469.g59c65b2a67-goog
> 

