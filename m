Return-Path: <linux-kernel+bounces-410314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8653B9CD9CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEBB282B33
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECDA187FE8;
	Fri, 15 Nov 2024 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+stSF71"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A9B523A;
	Fri, 15 Nov 2024 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655203; cv=none; b=NN0OD+HFqQLYEJAKBuFSJdUTaotDW+GV3CDB+7umGUr1blyfRwrsCth1kzNrPvnZ/VH/RH5S4Yd28GzX+Yc1/ch1WyTNI+7mGIX2IHL/ih97CfXSBPqCkYG8yiA5tATqilmR8u+hUZejLCKWsLL5g8eBscmhWaqWKxD9QhF2SOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655203; c=relaxed/simple;
	bh=pkFLuOnuVU4cIsrNOTFdM80z9a1NziY/kk1IdFhaUFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyJDLUJlGePxHBSf15BalBMoxOfSKjIheOffOE7MbWdjTio8oEEm2AK+jTk2aZAFWQm1ucWfwK1H6tvU59/Ijh5cKhDUrT8EjwnQLzZAeC0WpXBZoCLi4b8kCJG6wfb7SXduRYW/1gXTs0gM3qbwusFhVJ6mY1OhifMLEQ/MxoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+stSF71; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731655202; x=1763191202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pkFLuOnuVU4cIsrNOTFdM80z9a1NziY/kk1IdFhaUFM=;
  b=K+stSF71GAtIhez5LwJNy6zZ12OoWD0y/bbqo8mp/mgGlFFF/6nLWozl
   Gi+XdaczDEDCoRsBwEiO3mPL1W3AfLVSCZfVg8PChSlpLr14OE+MHYURI
   qYOy/nXXKxXTrlGGFUqYZbb4p4sEXuFavmQ21ggqiiRsjfydrFT9IOipD
   oX/kaRGGP3gcKl1/zfzTI21BjurME5oYQ57DIo6d7gNECAuwWS4sQ9AQs
   +AfRvHiVpQD2ofE6Kd9lsgNGgDNNGMVyAcMBDdOFJBmSerFH4ZoR6e8hR
   yXjbIWFk/7Hjrq49T8t1L25+mKWACYXupbn24oHovEytf2z85Lsil80am
   w==;
X-CSE-ConnectionGUID: kJCVF4m2Q/yhZjGVPtes9A==
X-CSE-MsgGUID: HUFnz2c0TwiW+poQ7nCPoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="49181538"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="49181538"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 23:19:45 -0800
X-CSE-ConnectionGUID: n2gyKpt/R3+bahmM3mewng==
X-CSE-MsgGUID: LOWwPhyTTr24X81aHVY/Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="88580045"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa008.fm.intel.com with SMTP; 14 Nov 2024 23:19:41 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 15 Nov 2024 09:19:40 +0200
Date: Fri, 15 Nov 2024 09:19:39 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	gregkh@linuxfoundation.org, dmitry.baryshkov@linaro.org,
	kyletso@google.com, rdbabiera@google.com, badhri@google.com,
	linux@roeck-us.net, xu.yang_2@nxp.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 3/3] usb: typec: tcpm: Add support for
 sink-bc12-completion-time-ms DT property
Message-ID: <Zzb2CxPPZc09WfqV@kuha.fi.intel.com>
References: <20241103034402.2460252-1-amitsd@google.com>
 <20241103034402.2460252-4-amitsd@google.com>
 <f244542a-7160-4f05-acaa-0e2574ee289d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f244542a-7160-4f05-acaa-0e2574ee289d@google.com>

On Thu, Nov 14, 2024 at 11:59:41AM -0800, Amit Sunil Dhamne wrote:
> Hi Heikki,
> 
> On 11/2/24 8:43 PM, Amit Sunil Dhamne wrote:
> > Add support for parsing DT time property "sink-bc12-completion-time-ms".
> > This timer is used to relax the PD state machine during Sink attach to
> > allow completion of Battery Charging (BC1.2) charger type detection in
> > TCPC before PD negotiations. BC1.2 detection is a hardware mechanism to
> > detect charger port type that is run by some controllers (such as
> > "maxim,max33359") in parallel to Type-C connection state machines.
> > This is to ensure that BC1.2 completes before PD is enabled as running
> > BC1.2 in parallel with PD negotiation results in delays violating timer
> > constraints in PD spec.
> > 
> > This is an optional timer and will not add any delay unless explicitly
> > set.
> > 
> > Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> > Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> >   drivers/usb/typec/tcpm/tcpm.c | 16 +++++++++++++++-
> >   1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index b3d5d1d48937..8b325b93b5a9 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -319,6 +319,7 @@ struct pd_timings {
> >   	u32 sink_wait_cap_time;
> >   	u32 ps_src_off_time;
> >   	u32 cc_debounce_time;
> > +	u32 snk_bc12_cmpletion_time;
> >   };
> >   struct tcpm_port {
> > @@ -4978,7 +4979,16 @@ static void run_state_machine(struct tcpm_port *port)
> >   		if (ret < 0)
> >   			tcpm_set_state(port, SNK_UNATTACHED, 0);
> >   		else
> > -			tcpm_set_state(port, SNK_STARTUP, 0);
> > +			/*
> > +			 * For Type C port controllers that use Battery Charging
> > +			 * Detection (based on BCv1.2 spec) to detect USB
> > +			 * charger type, add a delay of "snk_bc12_cmpletion_time"
> > +			 * before transitioning to SNK_STARTUP to allow BC1.2
> > +			 * detection to complete before PD is eventually enabled
> > +			 * in later states.
> > +			 */
> > +			tcpm_set_state(port, SNK_STARTUP,
> > +				       port->timings.snk_bc12_cmpletion_time);
> >   		break;
> >   	case SNK_STARTUP:
> >   		opmode =  tcpm_get_pwr_opmode(port->polarity ?
> > @@ -7090,6 +7100,10 @@ static void tcpm_fw_get_timings(struct tcpm_port *port, struct fwnode_handle *fw
> >   		port->timings.cc_debounce_time = val;
> >   	else
> >   		port->timings.cc_debounce_time = PD_T_CC_DEBOUNCE;
> > +
> > +	ret = fwnode_property_read_u32(fwnode, "sink-bc12-completion-time-ms", &val);
> > +	if (!ret)
> > +		port->timings.snk_bc12_cmpletion_time = val;
> >   }
> >   static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode)
> 
> 
> I wanted to gently follow up with you on this patchset if this looks okay to
> you?

Sorry, this is okay by me. I thought that there's still some problem
with the device property itself, but I must have misunderstood.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

-- 
heikki

