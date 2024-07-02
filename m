Return-Path: <linux-kernel+bounces-237729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835E7923D5C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C30B2535F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB751662F4;
	Tue,  2 Jul 2024 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1rjxOnI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BB615CD75;
	Tue,  2 Jul 2024 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719922426; cv=none; b=fLIJyFTMiNmXesFUqj4K0d0kla0tyD4b3e+FJoRV3BU+56xHa10Y9djiCQukPxjvRzRbczS713/+nbBsOfcWO2CRFy/NCMbXN+yqgXOtlXooQBnoeafoi2zJoXKkb5clZ083HtPja7F3OK4v9oIZ6DT6Pi3B20yBCsefBf3U5Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719922426; c=relaxed/simple;
	bh=Bf2wlVUAC4llSs8EkU+I8ySlnGn5ovG0nUk6KILafEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1n3JhROY5dI+SeH8/BKlR7rAIWwPC0L8Ei/rI34S+d+kcS4mxoetP1D1eJyjeJNYbRn4vJyjPyKm7pHIhs/RhB5Wcf+InEKs21vJ3YiriIckCgyeg/kgCXpN53+U/Jjvd4lMWt80nyjq5ZahK0OaT61zUdQIuGNvKA8c1/kb94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1rjxOnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17318C32781;
	Tue,  2 Jul 2024 12:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719922425;
	bh=Bf2wlVUAC4llSs8EkU+I8ySlnGn5ovG0nUk6KILafEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j1rjxOnI7wPme9phxNtAAD8YnUXRJAhBnrQAb0/wrXahT8rZwRg+jAjlxq4ZSsBDn
	 PiplLOSUmpkdLF9thsweqx+Xx6I4XnL70P0/klizHUQUGLivvzGIDOnjws6cdgxn7l
	 GOPonwNWWNmxMb2yiEf/atO1ZPyyTKGC67otwU3uLF3d1RiKuzJjDF6taQQERE7sap
	 cnC11CLC95d5P2NlAbWWXLhFwRjm/qEMilUDx8ylkkTno2f+dM61Knek+eUmeqQEBz
	 XKx8kp8UGd+t+zaw2dYBbi0CW02fVTN9shHT4M4Mh2aSqienFqtgMQC5OmAMngQkJY
	 J07hzEB7IiLrQ==
Date: Tue, 2 Jul 2024 13:13:40 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Yangyu Chen <cyy@cyyself.name>, linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>, Janne Grunau <j@jannau.net>,
	Hector Martin <marcan@marcan.st>, Asahi Lina <lina@asahilina.net>,
	asahi@lists.linux.dev,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] drivers/perf: apple_m1: fix affinity table for event
 0x96 and 0x9b
Message-ID: <20240702121340.GB3542@willie-the-truck>
References: <tencent_7B71486CE305DF8AE084B6BB6313EE550C06@qq.com>
 <20240701140148.GE2250@willie-the-truck>
 <87cynxp52o.wl-maz@kernel.org>
 <87bk3hp3z7.wl-maz@kernel.org>
 <tencent_371517268623E4A61194EF4C70497BDC5105@qq.com>
 <8634oshxhj.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8634oshxhj.wl-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jul 02, 2024 at 11:58:00AM +0100, Marc Zyngier wrote:
> On Tue, 02 Jul 2024 11:22:21 +0100,
> Yangyu Chen <cyy@cyyself.name> wrote:
> > 
> > > Yangyu, can you please clarify how you came to the conclusion that
> > > these events didn't count anywhere other than counter 7?
> > > 
> > 
> > IIRC, I came across some web page that says events 0x96 and 0x9b
> > can only be installed on counter 7 to count Apple AMX, but I can't
> > find the page now. Since AMX is not usable in Linux, I don't know
> > if this will affect some other instructions that are usable in
> > Linux.
> 
> As you said, AMX cannot be used with Linux, and that's unlikely to
> ever change. But when it comes to the standard ARM ISA, we can only
> witness counters 5,6 and 7 being incremented with at the exact same
> rate.
> 
> So reading between the lines, what I understand is that AMX
> instructions would only have their effects counted in counter 7 for
> these events, while other instructions would be counted in all 3
> counters.
> 
> By extension, such behaviour could be applied to SME on HW that
> supports it (wild guess).
> 
> > There are some other reasons, but I can't say in public.
> 
> Fair enough, I'm not asking for the disclosure of anything that isn't
> public (the least I know, the better).
> 
> > Even though I can't find the actual usage, I think using count 7
> > only for these 2 events is safer. If this reason is insufficient,
> > we can ignore this patch until we find other evidence that this
> > affinity affects some instructions usable in Linux.
> 
> I honestly don't mind.
> 
> The whole thing is a black box, and is more useful as an interrupt
> generator than an actual PMU, due to the lack of freely available
> documentation. If the PMU maintainers want to merge this, I won't
> oppose it.

I'd rather leave the code as-is than tweak specific counters based on
a combination of guesswork and partial information.

Of course, if somebody who knows better wants to fix up all of the
mappings (because this surely isn't the only corner-case), then we can
take that. But at least what we have today has _some_ sort of consistent
rationale behind it.

Will

