Return-Path: <linux-kernel+bounces-564591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEAEA657E8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B403718936BF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A4619F120;
	Mon, 17 Mar 2025 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/DSMUty"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D3F19992D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228631; cv=none; b=q5RtW94r4MrbuYR5t6Knos+asy3layWA5L/Z8EduuJGPAq1+pEnVnCHHKi0Nyr02TmZShfrgjRM/lYemVlS4gFh3o0p19/74jiXAniknD7I4LpwiH8f37WFXU6YP+LnYd1VtqMTha1OaBXGqKe//4Pho1PghxpR38YNfLlQwUOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228631; c=relaxed/simple;
	bh=aV/yanZJIXli1pcrOKQsZ9hWz9PMDSmBVNch4gPOhZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtF6qCJgF+3svrEXn9QHWgy57sfUx58BaIqXEzRawBAdeBiyTm+DS6bN1dOnO1B36gjk94WVhPnVjuZMyvHAr+Q/xIEPjbM2aBj9ZRdclDgRIkcKEjmvUvHf9TnGyg15NNw0IO3NznvbJp/QjMNbz0VauvLm4KbY0g0bbfCLU4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/DSMUty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3FCC4CEE3;
	Mon, 17 Mar 2025 16:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742228630;
	bh=aV/yanZJIXli1pcrOKQsZ9hWz9PMDSmBVNch4gPOhZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/DSMUtyT0S/QCwTtFGLz2hW7zK84kxlRctbI2KzNLVla4ZrXuuwTvbECT/Wagcjo
	 m8nuRXxIIn7XZy/XMvpumhAxLi0k4wz3p0Pm7T24kdN6XdyfHAspkSzniQB+6PU58+
	 MvEqFp7GRQfDrMPXyrolTXUxxAybQF/Jzv1phA0myUFFCQmAjCv3oDFFhXBMThCqge
	 eIic98oPf2nr4O5CBHRh0eJlYLWsCkOppybLq6hqLKzeaa4csfONULPOAJ/BGAZUR4
	 Z5vYUnIRFNujpzJHeti1txp0ygGHfv5cyaQXCIDAmpVTiDXSwSALZ5kiuVzTTulHN2
	 G6eFuoYNvK1Gw==
Date: Mon, 17 Mar 2025 09:23:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Matteo Rizzo <matteorizzo@google.com>
Subject: Re: [PATCH] perf/x86: Check data address for IBS software filter
Message-ID: <Z9hMlYsjeSmmnZCl@google.com>
References: <20250317081058.1794729-1-namhyung@kernel.org>
 <28663df2-31f2-4726-9dad-a78e1b19afc9@amd.com>
 <Z9hHhKwUoQMAqZAa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9hHhKwUoQMAqZAa@google.com>

On Mon, Mar 17, 2025 at 09:02:12AM -0700, Namhyung Kim wrote:
> Hi Ravi,
> 
> On Mon, Mar 17, 2025 at 06:59:33PM +0530, Ravi Bangoria wrote:
> > Hi Namhyung,
> > 
> > > @@ -1286,6 +1286,13 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
> > >  	if (perf_ibs == &perf_ibs_op)
> > >  		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
> > >  
> > > +	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
> > > +	    (event->attr.sample_type & PERF_SAMPLE_ADDR) &&
> > > +	    event->attr.exclude_kernel && !access_ok(data.addr)) {
> > > +		throttle = perf_event_account_interrupt(event);
> > > +		goto out;
> > > +	}
> > 
> > Can this move up where it checks perf_exclude_event()? Use
> > ibs_data.regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)] instead
> > of data.addr.
> 
> Sure, will do.

Hmm.. but I think it also needs to check op_data3_dc_lin_addr_valid bit.
Can we move up the perf_ibs_parse_ld_st_data() too and check data.addr?

Thanks,
Namhyung


