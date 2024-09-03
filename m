Return-Path: <linux-kernel+bounces-312790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFA6969B5A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925F31C22B5C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353DD1A3A9F;
	Tue,  3 Sep 2024 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hb/iH0j4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A9C1B12C2;
	Tue,  3 Sep 2024 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362125; cv=none; b=W/4GP6pu/NVwAKwrUbhwpxn0lYsegitrBK6Jg3/kYPl5MHfLdyHhpvyD2hKqyE9v+49MPn3hvCWU76oIH+ezpDOKxdRvygoocHdUTsMWj3C5FFr1aLSd/WVU4SVQgSJjCozcpOuUK7UeSNTbvwh7LHRStJMgb0u6sATKm6UZd4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362125; c=relaxed/simple;
	bh=KfGX1dn8HNVuzrnALRJ6/KgJTduArsS/FUwz9Q12b3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vvn25NjOWsN4xkjcgkmXQ50uqB7ODBK4Z3hBJQQJrqD7M04d7+1VKtlh0aFCYnFuTbXOcd8Fv13DqzwGsrjc2CPk/8Ipa7N0Q+WsmISBJcMyBAbvjMvo6eTN1W+igsuNL/hJL535mlc5wI6yzv+x16odjeBzpNfsVR/PPDFjVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hb/iH0j4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725362123; x=1756898123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KfGX1dn8HNVuzrnALRJ6/KgJTduArsS/FUwz9Q12b3I=;
  b=Hb/iH0j4a3Oau5osSCaRz6UaTpzryyMvxryLtHE8HHETN9SJkFQykZl+
   ptvtIh86RKW2qQdGQ69iJoTTizwLiF4lFH5lGluAA7rXsIw5mxfvQUEZM
   gvP8h5v4MkSVKGM1hFwaY0WSEUxvclIAeDq6oi2xRsn+/r9ZlMoc1TGmM
   H6/gQOfSCImxWPWHiqkp9b08WSoXjfQ7hVM87FJ3zMhnBWKYhjWVTf8fg
   p7ryTV53PY7h//ImoZCxhSQdieaHIoiELUPmwYi0eDTqwno2jLNgbGXXS
   5OOATdaGBKpvpL1M1XcJDGH1/IqqeKqmCUoL3G6q3lHuNVUab2F/jLsMz
   g==;
X-CSE-ConnectionGUID: /x4qRc6zQSa3AWu4pSheKQ==
X-CSE-MsgGUID: AghVxcb0T1yK7NWVZbq4cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="35322514"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="35322514"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 04:15:22 -0700
X-CSE-ConnectionGUID: JIDeYybnQVSbI/6PSXDR1w==
X-CSE-MsgGUID: gA1+HILmTOK07TZHYfFVnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="69013942"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa003.fm.intel.com with SMTP; 03 Sep 2024 04:15:19 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 03 Sep 2024 14:15:15 +0300
Date: Tue, 3 Sep 2024 14:15:15 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Anurag Bijea <icaliberdev@gmail.com>,
	Christian Heusel <christian@heusel.eu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: Re: [PATCH v2 1/2] usb: typec: ucsi: Enable ASUS zenbook quirk for
 VivoBooks
Message-ID: <Ztbvw5seWqRA5/8L@kuha.fi.intel.com>
References: <20240829100109.562429-1-lk@c--e.de>
 <ZtF/BJMls7kuD2dt@kuha.fi.intel.com>
 <ZtI8N5/SCt+dI/6z@cae.in-ulm.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtI8N5/SCt+dI/6z@cae.in-ulm.de>

On Fri, Aug 30, 2024 at 11:40:07PM +0200, Christian A. Ehrhardt wrote:
> 
> Hi Heikki,
> 
> On Fri, Aug 30, 2024 at 11:12:52AM +0300, Heikki Krogerus wrote:
> > Hi, Christian,
> > 
> > Sorry, I did not look at this properly in v1.
> > 
> > On Thu, Aug 29, 2024 at 12:01:08PM +0200, Christian A. Ehrhardt wrote:
> > > The quirk for some ASUS zenbook models is required for
> > > ASUS VivoBooks. Apply the quirk to these as well.
> > > 
> > > This is part of the fix for the builtin keyboard on ASUS
> > > VivoBooks.
> > 
> > I think that explanation goes to patch 2/2 and vise versa.
> 
> Obviously! Sorry about that.
> 
> > 
> > > Reported-by: Anurag Bijea <icaliberdev@gmail.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219108
> > > Bisected-by: Christian Heusel <christian@heusel.eu>
> > > Fixes: de52aca4d9d5 ("usb: typec: ucsi: Never send a lone connector change ack")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> > > ---
> > >  drivers/usb/typec/ucsi/ucsi.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > > index 4039851551c1..540cb1d2822c 100644
> > > --- a/drivers/usb/typec/ucsi/ucsi.c
> > > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > > @@ -38,6 +38,10 @@
> > >  
> > >  void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
> > >  {
> > > +	/* Ignore bogus data in CCI if busy indicator is set. */
> > > +	if (cci & UCSI_CCI_BUSY)
> > > +		return;
> > 
> > This does not look correct. Doesn't this mean you'll timeout always if
> > BUSY is set?
> 
> This is only in the notify function that would do the wakeup on
> command completion. The very point of this change is that we do no
> wakeup if UCSI_CCI_BUSY is set along with other bogus bits.
> 
> The UCSI controller is supposed to send another notification without
> the busy bit set once the command completes.
> 
> Note that the ASUS laptop actually sends notifications with the BUSY
> bit set while processing a command. This is presumably to let us know
> that the command is being processed but that it takes longer.
> 
> For example this is a possible sequence:
> ucsi_sync_control_common: cmd=20012	# GET_CONNECT_STATUS
> ucsi_notify_common: cci=0x10000002	# BUSY notification
> ucsi_notify_common: cci=0x80000904	# Command completion
> 
> > Couldn't you just check the BUSY as the first action, and then clear
> > the other bits in CCI if it is set, if that is the problem?
> 
> That would not make any difference. The value is only used in this function
> for a few other checks that look at fields that are supposed to be zero.
> Thus zeroing these fields would have the same effect.
> 
> I think you had the actual error handling in mind that happens _after_
> the timeout hits. CCI is read again there and if it still reports BUSY
> the command is canceled.
> 
> > Btw. Does 4f322657ade1 ("usb: typec: ucsi: Call CANCEL from single
> > location") affect the situation in any way?
> 
> I would have to check with the reporter of the bug but I don't think
> it makes a difference because this is the error recovery code that
> runs after the timeout. I only touched the notification code that would
> do the wakeup.

Okay. Can you resend this with the correct commit message.

thanks,

-- 
heikki

