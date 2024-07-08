Return-Path: <linux-kernel+bounces-244259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0DF92A1C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB30D287254
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B737F7F5;
	Mon,  8 Jul 2024 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1lH0qAq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47DD13ACC;
	Mon,  8 Jul 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440031; cv=none; b=jR3iVQtueNqsqbaTqcthXBIFxbFXG+Aj5G9h5TvRjDJTxHwChe/se3MwS/gN6XPcG6hlrqMPZdwKZKZbA5utgA3ysl4Z4iBvOukLxreCCDJKMWRYatzCdDX3UXwKyqvrEraNOrTVKLzIgaD2fAdfIOPnP6BhZ0ur9lIXeZ27l+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440031; c=relaxed/simple;
	bh=UHaB+noDuK6djyp9soKq/KV4rz/uj79BNWXm0lcZWa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEwpoog+UA/kcprBqnJMouB6ZPs/BGZGlfQEAYkhGVpvTLCdP2yMcgvcpMt89SEJdWaNLcKKiuQCgfmxAjJpXvCtz9nvRuv7vd86AeuDUr/rFztZ8TQza63bgWRdBYz3Zrs6yRkNJalChLu23l8nGTHes1L8QYSF1K6bpRR8eYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1lH0qAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AECC116B1;
	Mon,  8 Jul 2024 12:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720440031;
	bh=UHaB+noDuK6djyp9soKq/KV4rz/uj79BNWXm0lcZWa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f1lH0qAq6UGJmgMO1TstfsAY0es5762ajHpP4gGsc2dSNlg0kOLgVjiZcvouLkkdt
	 +IVz4cmw+kTTL8x8YtmXF428KfUgfwXgWimQU39vL5Vt3gwC6AVRkK5D5cjw6Rqb12
	 /zsetAeUp6lq8TbLS87RcSnvlmrLc/zxiiOdppKX4joQAtQbYyQ1ayINj/S9o4NSDe
	 5kSb3R7Zk1lcIyER3VYUc2sjW9SEVF7hMnJctvmraL5QjYvic/wqQFDKdRLb37zUoP
	 Npgw2lgiv2peA4WxqAkrOisXsZtsaD9gHwaRJr6Tip8U0XPvtnyNYpEjU9JLuckQMV
	 sFW0pUKLwPofg==
Date: Mon, 8 Jul 2024 13:00:26 +0100
From: Will Deacon <will@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>, Janne Grunau <j@jannau.net>,
	Hector Martin <marcan@marcan.st>, Asahi Lina <lina@asahilina.net>,
	asahi@lists.linux.dev,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] drivers/perf: apple_m1: fix affinity table for event
 0x96 and 0x9b
Message-ID: <20240708120026.GC11771@willie-the-truck>
References: <tencent_7B71486CE305DF8AE084B6BB6313EE550C06@qq.com>
 <20240701140148.GE2250@willie-the-truck>
 <87cynxp52o.wl-maz@kernel.org>
 <87bk3hp3z7.wl-maz@kernel.org>
 <tencent_371517268623E4A61194EF4C70497BDC5105@qq.com>
 <8634oshxhj.wl-maz@kernel.org>
 <20240702121340.GB3542@willie-the-truck>
 <tencent_A6F18ECEB80131BA21638D187C6782F6DA08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A6F18ECEB80131BA21638D187C6782F6DA08@qq.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Jul 02, 2024 at 08:43:16PM +0800, Yangyu Chen wrote:
> 
> 
> > On Jul 2, 2024, at 20:13, Will Deacon <will@kernel.org> wrote:
> > 
> > On Tue, Jul 02, 2024 at 11:58:00AM +0100, Marc Zyngier wrote:
> >> On Tue, 02 Jul 2024 11:22:21 +0100,
> >> Yangyu Chen <cyy@cyyself.name> wrote:
> >>> 
> >>>> Yangyu, can you please clarify how you came to the conclusion that
> >>>> these events didn't count anywhere other than counter 7?
> >>>> 
> >>> 
> >>> IIRC, I came across some web page that says events 0x96 and 0x9b
> >>> can only be installed on counter 7 to count Apple AMX, but I can't
> >>> find the page now. Since AMX is not usable in Linux, I don't know
> >>> if this will affect some other instructions that are usable in
> >>> Linux.
> >> 
> >> As you said, AMX cannot be used with Linux, and that's unlikely to
> >> ever change. But when it comes to the standard ARM ISA, we can only
> >> witness counters 5,6 and 7 being incremented with at the exact same
> >> rate.
> >> 
> >> So reading between the lines, what I understand is that AMX
> >> instructions would only have their effects counted in counter 7 for
> >> these events, while other instructions would be counted in all 3
> >> counters.
> >> 
> >> By extension, such behaviour could be applied to SME on HW that
> >> supports it (wild guess).
> >> 
> >>> There are some other reasons, but I can't say in public.
> >> 
> >> Fair enough, I'm not asking for the disclosure of anything that isn't
> >> public (the least I know, the better).
> >> 
> >>> Even though I can't find the actual usage, I think using count 7
> >>> only for these 2 events is safer. If this reason is insufficient,
> >>> we can ignore this patch until we find other evidence that this
> >>> affinity affects some instructions usable in Linux.
> >> 
> >> I honestly don't mind.
> >> 
> >> The whole thing is a black box, and is more useful as an interrupt
> >> generator than an actual PMU, due to the lack of freely available
> >> documentation. If the PMU maintainers want to merge this, I won't
> >> oppose it.
> > 
> > I'd rather leave the code as-is than tweak specific counters based on
> > a combination of guesswork and partial information.
> > 
> > Of course, if somebody who knows better wants to fix up all of the
> > mappings (because this surely isn't the only corner-case), then we can
> > take that. But at least what we have today has _some_ sort of consistent
> > rationale behind it.
> 
> Actually, anyone who has macOS software can learn the whole affinity
> table of PMU. The detailed information can be extracted from a plist
> file stored in the macOS root filesystem. I also provide that script
> [1] to extract this information.
> 
> However, I can't directly use this information for legal concerns.
> Would this be acceptable if the information I provide matches Apple's
> information? I can't say whether it matches or not in public. I can
> only say we can easily find someone who uploaded this file to the
> internet.
> 
> [1] https://github.com/cyyself/m1-pmu-gen

I can't say I feel hugely comfortable with this, so I'll leave the code
as-is unless a patch shows up fixing all the events.

Thanks for the reply, though. You've clearly spent a bunch of effort on
this and it's a pity we can't easily apply your results to the driver :/

Will

