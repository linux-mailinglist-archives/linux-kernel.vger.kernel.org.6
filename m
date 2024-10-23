Return-Path: <linux-kernel+bounces-377716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D96E9AC2D8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E511F25332
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AFA16190B;
	Wed, 23 Oct 2024 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZxBCbYh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A904174A;
	Wed, 23 Oct 2024 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674313; cv=none; b=EfGaYXzgK3xlomjj1Fxxdlpmore5HYYf6Wf4PW6SThZuGtccp3/TZBXZsJWB6lNeuGUcoLhna3aF2hxU4SIsCru/RCukx9clylth85c3j9MexpapQCLL2OBkD9YpJkAkVopZfVXKBOfeEKx4U9xziktDq3cEUl1VOyfsPgmrD+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674313; c=relaxed/simple;
	bh=2yzPufncmcpJjCH1gTSV1OHjr+QXJZYq2bvrYb0mM8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHwrXoW6NFFvqRe1v0BqRRX9F6hCBvsbYSZ1KH/NeB/rp97qwYUJ+7X8hUFaHRYsEVC2r6JtJNyY18YPAddUEXENweRctI7+8Va2mF/uqU/fXrl0raMVSqU3JxFTiTK/JnOzz+Nby+3dgD/Sp5KzOpZQ5+qCNiKT4p2dAi+67gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mZxBCbYh; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729674311; x=1761210311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2yzPufncmcpJjCH1gTSV1OHjr+QXJZYq2bvrYb0mM8Y=;
  b=mZxBCbYh6WNTb1Cn7e/CfCpEuGa0929XdJWHU1VltDgcCl3Ahj5dIMDw
   345jEj2vMVoFS234PUVK4AQCGwmZCrsLkKQoCns+V3V6Uyev7uvJJ2CAa
   MVtepXk+3zmGeGBesPzzhELBG5kDoV52HlK//1AP55jjBxBFyLT6WzlVn
   wZJrgIO5GKqrIEQ48h1YhasEkjQoPPG7UGUyklWigmmPCy7sddUpBplLB
   nHC7AdtGAY/a3nuzLqEPbgcHT/TgjnvfcIlbfhC8kzUEXVn1l4bIsmBlW
   zCOB1MZN9TDtgHc2t1ZE3LCHmQBnb8nssk4d6JCtc5NjJwGlr9Yr8lntw
   g==;
X-CSE-ConnectionGUID: xs4MQWe2S6GATCEP/c1iVg==
X-CSE-MsgGUID: W3NL+UySRLur7CN83m0aBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="28693288"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="28693288"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 02:05:10 -0700
X-CSE-ConnectionGUID: /N2HKzGXQuCLJu8G3kAqRw==
X-CSE-MsgGUID: QiKb5Z7XToGM6j4A31kbwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="79707452"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa006.fm.intel.com with SMTP; 23 Oct 2024 02:05:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 23 Oct 2024 12:05:04 +0300
Date: Wed, 23 Oct 2024 12:05:04 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Yanik Fuchs <Yanik.fuchs@mbv.ch>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"rdbabiera@google.com" <rdbabiera@google.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	"kyletso@google.com" <kyletso@google.com>,
	"badhri@google.com" <badhri@google.com>,
	"xu.yang_2@nxp.com" <xu.yang_2@nxp.com>,
	"amitsd@google.com" <amitsd@google.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: tcpm: Prevent Hard_Reset if Vbus was never
 low
Message-ID: <Zxi8QGi78HgK7FNx@kuha.fi.intel.com>
References: <GVAP278MB0662F98EAAFAD95645E7010A974C2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <GVAP278MB0662F98EAAFAD95645E7010A974C2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>

Hi Yanik,

On Tue, Oct 22, 2024 at 05:28:51PM +0000, Yanik Fuchs wrote:
> Good Evening
> 
> Here is a Patch to resolve an issue with TCPM if Vbus was never low.
> Please consider that this is one of my first kernel pull requests, I may have missunderstood the process.

Welcome aboard :)

Thank you for the patch. Unfortunately it is not properly formatted.
As this is a patch, you can't really comment it like this here.
Instead you should put any additional comments...

> Freundliche Grüsse
> Best regards
> 
> 
> Yanik Fuchs
> 
> ---
> 
> >From 604b97b6394b5643394bc63d4ac691c098c99c40 Mon Sep 17 00:00:00 2001
> From: yfu <yanikfuchs@me.com>
> Date: Tue, 22 Oct 2024 18:23:18 +0200
> Subject: [PATCH] usb: typec: tcpm: Prevent Hard_Reset if Vbus was never low
> 
> Before this patch, tcpm went into SOFT_RESET state, if Vbus was never low
> resulting in Hard_Reset, if power supply does not support USB_PD Soft_Reset.
> 
> In order to prevent this, I remove the Vbus check completely, so that 
> we go as well into the SNK_WAIT_CAPABILITIES_TIMEOUT state. There, we send 
> PD_CTRL_GET_SOURCE_CAP which many power supply do support.
> (122968f8dda8 usb: typec: tcpm: avoid resets for missing source capability messages)
> 
> Additionally, I added SOFT_RESET (instead of Hard_Reset) as Fallback solution
> if we still not have gotten any capabilities. Hard_Reset is now only done, 
> if PD_CTRL_GET_SOURCE_CAP and SOFT_RESET fail to get capabilities.
> ---

... here after those three lines. The proper format, and the whole
development process is documented here:
https://docs.kernel.org/process/development-process.html

You have also not signed your patch with a Signed-off-by tag. The
importance of the signature in patches is explained in the fifth
section of the development process documentation, here:
https://docs.kernel.org/process/5.Posting.html

>  drivers/usb/typec/tcpm/tcpm.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index fc619478200f..c7a59c9f78ee 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5038,14 +5038,8 @@ static void run_state_machine(struct tcpm_port *port)
>  		 * were already in a stable contract before this boot.
>  		 * Do this only once.
>  		 */
> -		if (port->vbus_never_low) {
> -			port->vbus_never_low = false;
> -			tcpm_set_state(port, SNK_SOFT_RESET,
> +		tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
>  				       PD_T_SINK_WAIT_CAP);

Here you should fix the alignment of the code so it matches the
parentheses. You can use the scripts/checkpatch.pl script, which is
part of the kernel source, to detect this kind of issues in your code
by supplying your patch to it.

> -		} else {
> -			tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
> -				       PD_T_SINK_WAIT_CAP);
> -		}
>  		break;
>  	case SNK_WAIT_CAPABILITIES_TIMEOUT:
>  		/*
> @@ -5064,7 +5058,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		 * according to the specification.
>  		 */
>  		if (tcpm_pd_send_control(port, PD_CTRL_GET_SOURCE_CAP, TCPC_TX_SOP))
> -			tcpm_set_state_cond(port, hard_reset_state(port), 0);
> +			tcpm_set_state_cond(port, SNK_SOFT_RESET, 0);
>  		else
>  			tcpm_set_state(port, hard_reset_state(port), PD_T_SINK_WAIT_CAP);
>  		break;
> -- 
> 2.34.1

Otherwise the code looks very good to me, but I can't yet say if the
change is appropriate. Let's fix the patch format first.

Br,

-- 
heikki

