Return-Path: <linux-kernel+bounces-208892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD05E902A48
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2DBB1C21CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9038373464;
	Mon, 10 Jun 2024 20:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h4QetuE9"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E396F30A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052869; cv=none; b=YKvcZlfR+oJeeL5/2d6KAzlc0/U0DWBDHlpj5YkA5rEOkF4WEJHk+SK6Qc6CAJBTYtRSQW67eLtvZBGuV3hYAR22ncdOhKSm+kCXUhw4z+lO34uRDFQi33AtDrLU6pB4G8t2ZMn6UnkUd6/7hCHy+MurwoPsse9tyCqun8DNHLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052869; c=relaxed/simple;
	bh=3IJ170TfkXxgGvDgJ3RTbvUYPnXkd2ZZUF0wrDSkLBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDXL+R/t9LsPm9gwl6NpDjFPtgUoPoI1VHEceHxmxtkQvyNiqcnW3cQKUjpj+ACska7F5xmGV8Tigd5GBz2CYlft5DxC/AylhmpX+NNC+NcHupEmt1N/JKUG/PcuVGBpwMTjOFzqsXJRUO89FrzW0IjUxWmkduUPe5ONP0uU7h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h4QetuE9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VS6xSyzjS3Rv5GrMxcihCiEJx2R82kJuQhsJU9W0eQI=; b=h4QetuE99k/oK0fB+yhlDQMS7E
	ASpUJ7PkP1CZkbUAihiNHKnnyYnp0GCutTdDF+rvdWDDb0o9zZh1VQU92ehwOZh+L2RcBfjKL6ICC
	NeSyV9F7yJoO04n9EtF1CkLfaHuFKnLTMsOQ8AB73DEFfLfaSS7XCJ5V8Bgs+IJVgW2X63DXsVNLW
	yuDPLVkmEro+0o0d1xeGmtIRXVWhdwEtfwCpVOhJgTTSKvNVZQ7BoeDxst93PhAE/cR0sNMG3HlRy
	NOZm0ApS/UeFTd7wsbM2Oz6q/oKgYFURlQ11uiIV6JE2aqgaweOmBAh1f3TuCxIn5/BH5KCWK9CAV
	RE+Cm0uw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGm1i-00000001fHm-3JMy;
	Mon, 10 Jun 2024 20:54:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5BE00300439; Mon, 10 Jun 2024 22:54:05 +0200 (CEST)
Date: Mon, 10 Jun 2024 22:54:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Stephane Eranian <eranian@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Narayan, Ananth" <ananth.narayan@amd.com>,
	"Bangoria, Ravikumar" <ravi.bangoria@amd.com>,
	Namhyung Kim <namhyung@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zhang Xiong <xiong.y.zhang@intel.com>
Subject: Re: [RFC] perf_events: exclude_guest impact on
 time_enabled/time_running
Message-ID: <20240610205405.GA8774@noisy.programming.kicks-ass.net>
References: <CABPqkBQ3LQ_dXQSQVSrriinvSSXm2fHx4yOms=jRsa2WaXSsog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQ3LQ_dXQSQVSrriinvSSXm2fHx4yOms=jRsa2WaXSsog@mail.gmail.com>

On Thu, Jun 06, 2024 at 12:57:35AM -0700, Stephane Eranian wrote:
> Hi Peter,
> 
> In the context of the new vPMU passthru patch series, we have to look
> closer at the definition and implementation of the exclude_guest
> filter in the perf_event_attr structure. This filter has been in the
> kernel for many years. See patch:
> https://lore.kernel.org/all/20240506053020.3911940-8-mizhang@google.com/
> 
> The presumed  definition of the filter is that the user does not want
> the event to count while the processor is running in guest mode (i.e.,
> inside the virtual machine guest OS or guest user code).
> 
> The perf tool sets is by default on all core PMU events:
> $ perf stat -vv -e cycles sleep 0
> ------------------------------------------------------------
> perf_event_attr:
>   size                             112
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   enable_on_exec                   1
>   exclude_guest                    1
> ------------------------------------------------------------
> 
> In the kernel, the way this is treated differs between AMD and Intel
> because AMD does provide a hardware filter for guest vs. host in the
> PMU counters whereas Intel does not. For the latter, the  kernel
> simply disables the event in the hardware counters, i.e., the event is
> not descheduled.  Both approaches produce pretty much the same desired
> effect, the event is not counted while in guest mode.
> 
> The issue I would like to raise has to do with the effects on
> time_enabled and time_running for exclude_guest=1 events.
> 
> Given the event is not scheduled out while in guest mode, even though
> it is stopped, both time_enabled and time_running continue ticking
> while in guest mode.  If a measurement is 10s long but only 5s are in
> non-guest mode, then time_enabled=10s, time_running=10s. The count
> represents 10s worth of non guest mode, of which only 5s were really
> actively monitoring, but the user has no way of determining this.
> 
> If we look at vPMU passthru, the host event must have exclude_guest=1
> to avoid going into an error state on context switch to the vCPU
> thread (with vPMU enabled). But this time, the event is scheduled out,
> that means that time_enabled keeps counting, but time_running stops.
> On context switch back in, the host event is scheduled again and
> time_running restarts ticking. For a 10s measurement, where 5s here in
> the guest, the event will come out with time_enabled=10s,
> time_running=5s, and the tool will scale it up because it thinks the
> event was multiplexed, when in fact it was not. This is not the
> intended outcome here. The tool should not scale the count, it was not
> multiplexed, it was descheduled because the filter forced it out.
> Note that if the event had been multiplexed while running on the host,
> then the scaling would be appropriate.
> 
> In that case, I argue, time_running should be updated to cover the
> time the event was not running. That would bring us back to the case I
> was describing earlier.
> 
> It boils down to the exact definition of exclude_guest and expected
> impact on time_enabled and time_running. Then, with or without vPMU
> passthru, we can fix the kernel to ensure a uniform behavior.
> 
> What are your thoughts on this problem?

So with those patches having explicit scheduling points, we can actually
do this time accounting accurately, so I don't see a reason to not do
the right thing here.

Hysterically this was left vague in order to be able to avoid the
scheduling for these scenarios -- performance raisins etc.

The thing is, if you push this to its limits, we should start time
accounting for the ring selectors too, and that's going to be painful.



