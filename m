Return-Path: <linux-kernel+bounces-269227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA55942F77
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89A3287458
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775081B4C26;
	Wed, 31 Jul 2024 12:55:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087551AC43E;
	Wed, 31 Jul 2024 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430503; cv=none; b=DMV7vOGw/Ftcxinl4K8M8OOOyJ/SRWW/fXzfuEH+SvGW1FOQdE0/MVj6ugUQnbSBz6RaNRNWUKdR6FlKiaXSkZe8WClPRF2/80VujFpdNysAJM1gGfuyT+Q/Epwxv0ALei7EpHw/l2hZKwAXiLU2//EZShzYL/WRdubVjisCmpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430503; c=relaxed/simple;
	bh=rXJN/m0SY2VySI8/Zb1NUZlygvm5O4/4DKDvwUgyCu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvKGeyxcrpb0gvyzsAB88ed4Q52ayBK5AiG34PRLO28z0w290qdzfNeObFdLnwu7QOrCMas6If2x7vczRurk+NqAgMlPpB01qHJ2aDicDdtfKGPt0GH64jRx4B+ICAIWrH+SQvh9UJy+fkd7a+d4toLR3R8lXRReHmpoZs3iZ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 170CE1007;
	Wed, 31 Jul 2024 05:55:26 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80E553F766;
	Wed, 31 Jul 2024 05:54:59 -0700 (PDT)
Date: Wed, 31 Jul 2024 13:54:57 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Luke Parkin <luke.parkin@arm.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, arm-scmi@vger.kernel.org
Subject: Re: [PATCH v4 4/5] firmware: arm_scmi: Create debugfs files for
 counts
Message-ID: <Zqo0IWvrdUUNIAGL@pluto>
References: <20240730093342.3558162-1-luke.parkin@arm.com>
 <20240730093342.3558162-5-luke.parkin@arm.com>
 <Zqop6qq0jibefw0g@bogus>
 <ZqouwIJUYDJB64xP@pluto>
 <Zqow0WOz0eVf6fwv@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqow0WOz0eVf6fwv@bogus>

On Wed, Jul 31, 2024 at 01:40:49PM +0100, Sudeep Holla wrote:
> On Wed, Jul 31, 2024 at 01:32:00PM +0100, Cristian Marussi wrote:
> > On Wed, Jul 31, 2024 at 01:11:22PM +0100, Sudeep Holla wrote:
> > > On Tue, Jul 30, 2024 at 10:33:41AM +0100, Luke Parkin wrote:
> > > > Create debugfs files for the metrics in the debug_counters array
> > > > 
> > > > Signed-off-by: Luke Parkin <luke.parkin@arm.com>
> > > > ---
> > > > v3->v4
> > > > Use new locations for debug array
> > > > Use counter instead of stats
> > > > v2->v3
> > > > Add extra statistics also added in v3
> > > > v1->v2
> > > > Only create stats pointer if stats are enabled
> > > > Move stats debugfs creation into a seperate helper function
> > > > ---
> > > >  drivers/firmware/arm_scmi/driver.c | 38 ++++++++++++++++++++++++++++++
> > > >  1 file changed, 38 insertions(+)
> > > > 
> > > > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > > > index 5acd3d324def..ec6434692d1a 100644
> > > > --- a/drivers/firmware/arm_scmi/driver.c
> > > > +++ b/drivers/firmware/arm_scmi/driver.c
> > > > @@ -2847,6 +2847,41 @@ static int scmi_device_request_notifier(struct notifier_block *nb,
> > > >  	return NOTIFY_OK;
> > > >  }
> > > >  
> > > > +static void scmi_debugfs_counters_setup(struct scmi_debug_info *dbg,
> > > > +					struct dentry *trans)
> > > > +{
> > > > +	struct dentry *counters;
> > > > +
> > > > +	counters = debugfs_create_dir("counters", trans);
> > > > +
> > > > +	debugfs_create_atomic_t("sent_ok", 0400, counters,
> > > > +				&dbg->counters[SENT_OK]);
> > > > +	debugfs_create_atomic_t("sent_fail", 0400, counters,
> > > > +				&dbg->counters[SENT_FAIL]);
> > > > +	debugfs_create_atomic_t("sent_fail_polling_unsupported", 0400, counters,
> > > > +				&dbg->counters[SENT_FAIL_POLLING_UNSUPPORTED]);
> > > > +	debugfs_create_atomic_t("sent_fail_channel_not_found", 0400, counters,
> > > > +				&dbg->counters[SENT_FAIL_CHANNEL_NOT_FOUND]);
> > > > +	debugfs_create_atomic_t("response_ok", 0400, counters,
> > > > +				&dbg->counters[RESPONSE_OK]);
> > > > +	debugfs_create_atomic_t("notif_ok", 0400, counters,
> > > > +				&dbg->counters[NOTIF_OK]);
> > > > +	debugfs_create_atomic_t("dlyd_resp_ok", 0400, counters,
> > > > +				&dbg->counters[DLYD_RESPONSE_OK]);
> > > > +	debugfs_create_atomic_t("xfers_resp_timeout", 0400, counters,
> > > > +				&dbg->counters[XFERS_RESPONSE_TIMEOUT]);
> > > > +	debugfs_create_atomic_t("response_polled_ok", 0400, counters,
> > > > +				&dbg->counters[RESPONSE_POLLED_OK]);
> > > > +	debugfs_create_atomic_t("err_msg_unexpected", 0400, counters,
> > > > +				&dbg->counters[ERR_MSG_UNEXPECTED]);
> > > > +	debugfs_create_atomic_t("err_msg_invalid", 0400, counters,
> > > > +				&dbg->counters[ERR_MSG_INVALID]);
> > > > +	debugfs_create_atomic_t("err_msg_nomem", 0400, counters,
> > > > +				&dbg->counters[ERR_MSG_NOMEM]);
> > > > +	debugfs_create_atomic_t("err_protocol", 0400, counters,
> > > > +				&dbg->counters[ERR_PROTOCOL]);
> > > 
> > > Just curious and wonder if we can keep all these read-only and have another
> > > debugfs file which is write only to just reset the counters ?
> > > 
> > > Cristian,
> > > 
> > > Thoughts ? Or am I missing somthing ?
> > 
> > Do you mean creating a bunch of additional reset_sent_ok
> > reset_<your_counters> that are just WO and used to reset each single
> > counter ?
> 
> No, not at all. Sorry if my response meant that.
> 
> > (...I suppose because a global WO reset-all is already there...)
> >
> 
> Indeed, I hadn't seen it carefully. Do we really need per counter reset ?
> For me one global reset all with all files read-only should suffice.
> Let me know if and why you think otherwise.

Well we don't need strictly anything since it is a debug/devel feat, it
just seemed handy to have a way to just reset one of the counters you are
actively working on, if you think about a testing or live devel
scenario...but it is not really needed and I have no strong opinion
about this...it was just a nice to have I asked Luke to add last minute...

...patch 5 indeed already adds also a global WO reset, beside switching all
the above counters to RW...it is just a matter to drop those RO->RW perms
changes in patch 5.

Thanks,
Cristian

