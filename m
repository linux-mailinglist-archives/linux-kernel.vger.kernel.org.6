Return-Path: <linux-kernel+bounces-315215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF84C96BF63
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7DE288764
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081AB1DC05B;
	Wed,  4 Sep 2024 13:58:12 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633FE144316;
	Wed,  4 Sep 2024 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458291; cv=none; b=W9z75NbgULhWFTyVxCNjf5iKeJzUL06908UdNVC0yHk2jrPDCdldydrd/s7n5ALWm4fsEus2QvAJ249pTHVmqFkodAdDs8YubxBv2XQ/zFwE2jsJLAJlXj9O5TQedvdOYlEH53owR6et/CHI0SXivcCXK0P/24w+Q54Zx5Ahgzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458291; c=relaxed/simple;
	bh=YAplyYgWPO6E3YUZiymtzPbxWQuvUbJnGyWt94aPRRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/S2pgdJE9l3Or6dBapNxNSg4co/VHEvAfZHG5tg6DagzzjtdNcSNK+pQKhuQvQzI/0NckMXbiLp/YeneeEa4mnhRW+3FEOD9fTXi52bDT3HV+2Ssnj5SWrkA7PGOojYsKwJHEVgpQ8by8USHtFdQKH973HeQM6Q/saSCMd4cTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 39C5D140551; Wed,  4 Sep 2024 15:58:05 +0200 (CEST)
Date: Wed, 4 Sep 2024 15:58:05 +0200
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anurag Bijea <icaliberdev@gmail.com>,
	Christian Heusel <christian@heusel.eu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: Re: [PATCH v3] usb: typec: ucsi: Fix busy loop on ASUS VivoBooks
Message-ID: <ZthnbdKig//kPKgF@cae.in-ulm.de>
References: <20240903181917.617400-1-lk@c--e.de>
 <ZthNkY4MEpUgw3We@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZthNkY4MEpUgw3We@kuha.fi.intel.com>


Hi Heikki,

On Wed, Sep 04, 2024 at 03:07:45PM +0300, Heikki Krogerus wrote:
> On Tue, Sep 03, 2024 at 08:19:17PM +0200, Christian A. Ehrhardt wrote:
> > If the busy indicator is set, all other fields in CCI should be
> > clear according to the spec. However, some UCSI implementations do
> > not follow this rule and report bogus data in CCI along with the
> > busy indicator. Ignore the contents of CCI if the busy indicator is
> > set.
> > 
> > If a command timeout is hit it is possible that the EVENT_PENDING
> > bit is cleared while connector work is still scheduled which can
> > cause the EVENT_PENDING bit to go out of sync with scheduled connector
> > work. Check and set the EVENT_PENDING bit on entry to
> > ucsi_handle_connector_change() to fix this.
> > 
> > Reported-by: Anurag Bijea <icaliberdev@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219108
> > Bisected-by: Christian Heusel <christian@heusel.eu>
> > Tested-by: Anurag Bijea <icaliberdev@gmail.com>
> > Fixes: de52aca4d9d5 ("usb: typec: ucsi: Never send a lone connector change ack")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> > ---
> >  drivers/usb/typec/ucsi/ucsi.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > index 4039851551c1..540cb1d2822c 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -38,6 +38,10 @@
> >  
> >  void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
> >  {
> > +	/* Ignore bogus data in CCI if busy indicator is set. */
> > +	if (cci & UCSI_CCI_BUSY)
> > +		return;
> 
> I started testing this and it looks like the commands never get
> cancelled when the BUSY bit is set. I don't think this patch is the
> problem, though. I think the BUSY handling broke earlier, probable in
> 5e9c1662a89b ("usb: typec: ucsi: rework command execution functions").
> 
> I need to look at this a bit more carefully, but in the meantime, can
> you try this:
> 
> 	if (cci & UCSI_CCI_BUSY) {
> 		complete(&ucsi->complete);
> 		return;
>         }

I really don't think this is the correct thing to do and it will
likely make things worse.

A notification with the UCSI_CCI_BUSY bit does _not_ mean that
the controller is busy doing other things and cannot complete the
command.

Instead it is an indication that the controller _is_ working to
complete our command but will take somewhat longer:

Citing:
| Note: If a command takes longer than MIN_TIME_TO_RESPOND_WITH_BUSY ms
|       for the PPM (excluding PPM to OPM communication latency) to complete,
|       then the PPM shall respond to the command by setting the CCI Busy
|       Indicator and notify the OPM.
|       Subsequently, when the PPM actually completes the command, the
|       PPM shall notify the OPM of the outcome of the command via an
|       asynchronous notification associated with that command.

Unless I misunderstand what you are trying to do your change would
cause us to needlessly abort/cancel every command that takes more than
MIN_TIME_TO_RESPOND_WITH_BUSY to complete.

What am I missing?

Best regards,
Christian


