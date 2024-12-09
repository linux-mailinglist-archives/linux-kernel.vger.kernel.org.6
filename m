Return-Path: <linux-kernel+bounces-438169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413A79E9DC1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF735166283
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5B31553BC;
	Mon,  9 Dec 2024 18:01:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5991F5F6;
	Mon,  9 Dec 2024 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767277; cv=none; b=M2BtDRsS/tG1ZUtdW3u1uDvDSW+LXJqDxdz1l12k6XsvXsGOvtDE0cpeIEWV6N/TAdysOZfqgKOR7DSiKFU6QV21M0tJKScNVkseQILMtg3TC6xbo0i7KBhL+ZTHmVdBwjrAJAzxGVkNPHX7ZRa9aAvHctGpo52FzHLLoIxAK+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767277; c=relaxed/simple;
	bh=+iaVJMfn0BpWfZQvHC+iHLFzfPxT6r31cjn3niCeErQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzPdfoz5OBR0he0p/ZJFpoD5/+Z6piBdtqgo26l8Hom8x3NVAlCY49jefM4myWDssLumwLlcXi6DpLrOso8rthpVcgqPkRLlUZ2+0iKMJcjEgBAN4Cj/jI+UV90v4Q8fQ/d7TbcYpUT1yk4AMuQS6LqLaeNi8WcAzFlDg6i2nB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD8141650;
	Mon,  9 Dec 2024 10:01:42 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F373F3F720;
	Mon,  9 Dec 2024 10:01:12 -0800 (PST)
Date: Mon, 9 Dec 2024 18:01:00 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] firmware: arm_scmi: get only min/max clock rates
Message-ID: <Z1cwTWQWamv3lywB@pluto>
References: <20241203173908.3148794-1-etienne.carriere@foss.st.com>
 <20241203173908.3148794-2-etienne.carriere@foss.st.com>
 <Z1bHgf_4qqZgSnDt@bogus>
 <22ff786d1e034169be21ef7dc32c4a3a@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22ff786d1e034169be21ef7dc32c4a3a@foss.st.com>

On Mon, Dec 09, 2024 at 01:48:48PM +0000, Etienne CARRIERE - foss wrote:
> On Monday, December 9, 2024, Sudeep Holla wrote:
> > On Tue, Dec 03, 2024 at 06:39:07PM +0100, Etienne Carriere wrote:
> > > Remove limitation of 16 clock rates max for discrete clock rates
> > > description when the SCMI firmware supports SCMI Clock protocol v2.0
> > > or later.
> > >
> > > Driver clk-scmi.c is only interested in the min and max clock rates.
> > > Get these by querying the first and last discrete rates with SCMI
> > > clock protocol message ID CLOCK_DESCRIBE_RATES since the SCMI
> > > specification v2.0 and later states that rates enumerated by this
> > > command are to be enumerated in "numeric ascending order" [1].
> > >
> > > Preserve the implementation that queries all discrete rates (16 rates
> > > max) to support SCMI firmware built on SCMI specification v1.0 [2]
> > > where SCMI Clock protocol v1.0 does not explicitly require rates
> > > described with CLOCK_DESCRIBE_RATES to be in ascending order.
> > >
> > > Link: https://developer.arm.com/documentation/den0056 [1]
> > > Link: https://developer.arm.com/documentation/den0056/a [2]
> > > Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > > ---

Hi,

> > 
> > [...]
> > 
> > > +
> > > +static int scmi_clock_get_rates_bound(const struct scmi_protocol_handle *ph,
> > > +                                   u32 clk_id, struct scmi_clock_info *clk)
> > > +{
> > 
> > This new function seem to have unwraped the scmi_iterator_ops(namely
> > prepare_message, update_state and process_response instead of reusing them.
> > Can you please explain why it wasn't possible to reuse them ?
> 
> Since we're interested here only in min and max rates, let's query the
> first and last rates only. This can save a bit of useless transactions between
> agent and firmware in case there are many clocks with somewhat large
> the discrete rate lists.
> 
> I though using the iterator for this specific case would add a bit more
> complexity: it's expected to iterate (st->desc_index incremented from the
> common scmi_iterator_run() function) whereas here I propose to send
> only 2 messages.

Yes, indeed the core iterator helpers are meant to issue a 'full scan'
retrievieng all the resources that are returned while handling in a
common way the underlying machinery common to all messages that, like
DESCRIBE_RATES, could possibly return their results in chunks as a
multi-part reply...

...having said that I can certainly extend the iterators to be configurable
enough to fit this new usecase and retrieve only the desired part of the
'scan' so that can be used for this kind of max/min query or for the
bisection case.

I would avoid to re-introduce ad-hoc code to handle these new usecases
that do not fit into the existing iterator logic, since iterators
were introduced to remove duplication and unify under common
methods...and this new iterator scenario seems to me that has already 2
usecases and certainly more protocol could want to perform similar 'lazy
partial queries' in the future, so I'd prefer to address this in a more
general way upfront if possible...I will think about it and post something
next week in the form of some new iterator extensions, if it's fine for you.

Thanks,
Cristian

