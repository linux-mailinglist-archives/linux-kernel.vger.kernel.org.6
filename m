Return-Path: <linux-kernel+bounces-293617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24FE958204
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007F81F24269
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F6B18C006;
	Tue, 20 Aug 2024 09:23:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6876718A6C6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145810; cv=none; b=LGF1W6miYmlocb63vU/8B15sytjDndR6RTWUy2uwWvtXG+JEKVP00AZDcSeZhuImqWJPUN+jdURlaHCtXIcJPIFtHypVWRP/n8aqYyegnPHv4ZNsFhuvItgPulFE3gC7YAgplF4ZjKPUXTV71n0fFIFgI9Ti7TEhPiGssUr5KFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145810; c=relaxed/simple;
	bh=Xss8elNucEqQcEh0xvoi0XGtJyWr72ha7UGWzDogZRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJ3eWlEIay6f4OXApi8CjHn85ra3BptdHTWQbNT8B2xbnrOpBkQl7u8MWXbRUpRwU3WM/yknoi4eHkjxZg94onxh7ATNHovWqZnRjkIoQUhnt98ZT8FTmXHCMCA3lzuW/QJE0VxIOK6JNOaqm/GLGBsITncmYz3TjEfd7Rkt0bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1324DA7;
	Tue, 20 Aug 2024 02:23:54 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3D463F66E;
	Tue, 20 Aug 2024 02:23:27 -0700 (PDT)
Date: Tue, 20 Aug 2024 10:23:25 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, ilkka@os.amperecomputing.com
Subject: Re: [PATCH 6/8] perf/arm-cmn: Refactor DTC PMU register access
Message-ID: <ZsRgjV8vUQ6AuaLK@J2N7QTR9R3>
References: <cover.1723229941.git.robin.murphy@arm.com>
 <e1aac7d482e6f4a75819edcde1fd3198099a658c.1723229941.git.robin.murphy@arm.com>
 <Zr8p96jwMHepFeq7@J2N7QTR9R3>
 <4854a6b2-805a-4705-b2d2-df723cfc1311@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4854a6b2-805a-4705-b2d2-df723cfc1311@arm.com>

On Mon, Aug 19, 2024 at 05:41:30PM +0100, Robin Murphy wrote:
> On 16/08/2024 11:29 am, Mark Rutland wrote:
> > On Fri, Aug 09, 2024 at 08:15:45PM +0100, Robin Murphy wrote:
> > > Annoyingly, we're soon going to have to cope with PMU registers moving
> > > about. This will mostly be straightforward, except for the hard-coding
> > > of CMN_PMU_OFFSET for the DTC PMU registers. As a first step, refactor
> > > those accessors to allow for encapsulating a variable offset without
> > > making a big mess all over.
> > > 
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > >   drivers/perf/arm-cmn.c | 64 ++++++++++++++++++++++++------------------
> > >   1 file changed, 36 insertions(+), 28 deletions(-)
> > 
> > Aside from a minoe comment below this looks fine to me.
> > 
> > >   struct arm_cmn_dtc {
> > >   	void __iomem *base;
> > > +	void __iomem *pmu_base;
> > >   	int irq;
> > > -	int irq_friend;
> > > +	s8 irq_friend;
> > 
> > Unrelated change?
> > 
> > AFAICT there's no reason for 'irq_friend' to change from 'int' to 's8',
> > and nothing in the commit message explains it.
> 
> Oops, I had meant to note in the commit message that this is a little
> structure repacking where there was a hole already, to compensate for adding
> the new member... I shall un-forget that for v2.

Cool, with that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

