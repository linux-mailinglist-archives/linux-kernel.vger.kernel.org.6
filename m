Return-Path: <linux-kernel+bounces-564561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56760A65760
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB8617C7F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13BD17A31B;
	Mon, 17 Mar 2025 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQ99zAvg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7AF1632E6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227336; cv=none; b=cr+TqcmQ+lgSmo14Oy/ndZ8pjnCSrLlJx90E5q0A35lI+aWOEopO3tPb1RZPK55iC9fVGyPRVvpsJC1Hmv+0am3rjbHqBa7kKQxl630Q9EVXYRHRM8uVHjSh/LUDUEwa6Ig6TA0gaNrai0tiaYft73XjqxnATOiVzvw61NaA/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227336; c=relaxed/simple;
	bh=kQRSI6HqW/M9m+YUXG6Wg3RVbmCmjiLyAJK1Ms0MjcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5NMFZba+8x5ApbfGqNAc3PL5CA8n8i2ke846IFfdFsAjJb5nryG2i9onlf8omfPO3g4jXwfXRHx4BIWmf8ROAcmNoHJUV+hi2fScPHJh0fPsZqYc7ehEY2v4C4V3CvhhuBaqtAxktuawjWinLIlQ3OlQlbDjign1gt0NNfhTwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQ99zAvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C93C4CEE3;
	Mon, 17 Mar 2025 16:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742227335;
	bh=kQRSI6HqW/M9m+YUXG6Wg3RVbmCmjiLyAJK1Ms0MjcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LQ99zAvgvIGmypcDTWXGZ29tuCpNjixNow6ot7iq7NnfWa8ia/Wfo9nVZTuRnql7I
	 glps4k7oz6xPHE30Y2ptzlhGppAqoJVI7MtgYbMwCa5s782U6sb82jvq7sAhsaoR6s
	 pIkY0mUwmOdoEwycXg56spP9W+WhrD3F8tHe2V7ypInATdZNudKb4UIF/g2/lNefGQ
	 EIssw8N2IHtb+5Re9czr7A0AEm8uOygCwq0y7Noobm4G5/0uqunUtgj+aGAuTQaLLr
	 wg0yqF24NEDmZEySHQ/plk/iiIpopNHLaC/+DNxEOyVf3O8AeIHS5nzIPbFw1qafSW
	 sT7cdCIk1oyPA==
Date: Mon, 17 Mar 2025 09:02:12 -0700
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
Message-ID: <Z9hHhKwUoQMAqZAa@google.com>
References: <20250317081058.1794729-1-namhyung@kernel.org>
 <28663df2-31f2-4726-9dad-a78e1b19afc9@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28663df2-31f2-4726-9dad-a78e1b19afc9@amd.com>

Hi Ravi,

On Mon, Mar 17, 2025 at 06:59:33PM +0530, Ravi Bangoria wrote:
> Hi Namhyung,
> 
> > @@ -1286,6 +1286,13 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
> >  	if (perf_ibs == &perf_ibs_op)
> >  		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
> >  
> > +	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
> > +	    (event->attr.sample_type & PERF_SAMPLE_ADDR) &&
> > +	    event->attr.exclude_kernel && !access_ok(data.addr)) {
> > +		throttle = perf_event_account_interrupt(event);
> > +		goto out;
> > +	}
> 
> Can this move up where it checks perf_exclude_event()? Use
> ibs_data.regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)] instead
> of data.addr.

Sure, will do.

Thanks,
Namhyung


