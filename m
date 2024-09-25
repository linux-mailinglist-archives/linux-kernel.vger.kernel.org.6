Return-Path: <linux-kernel+bounces-338432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB609857ED
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 13:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B576FB21084
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FB716D33F;
	Wed, 25 Sep 2024 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeaFx9Yx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2A915AAB6;
	Wed, 25 Sep 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727263129; cv=none; b=TRRITFz9R4JFmIVBcz9Vcd2EKu8c1M6YxnwyzKoz8Nqt7IQOszbWK6tAAf+rNV3gAKsbxT/J9eZjunPLEKbRWQhpLVpO+z9M0zQqyxVNwGw04/DHPu6Hv9gpmhifv3eurY3xg9HhwjygOXyHbu9tfKIz1Hjy3WCCAQJ9UlanPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727263129; c=relaxed/simple;
	bh=hxbnpZILYLfhpFIePux7F3TZ1IaKkzgGbm4ZXDk/BZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRxglqGqMjD2EE27gYDaBiABjzUQ0WbxSpzHOeuncjbIDHxTEKsiQ9wQftmweG1aG/Cjm2cJSEoydYZSKsmvI0HpHQnmDF+pp4prlO2hmdef8b0BDd3rRMp+9SQBfQLkJmHzNv1gbdEofldMOuUociV9zlkA1278Vwcb13ClWDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeaFx9Yx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727263127; x=1758799127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hxbnpZILYLfhpFIePux7F3TZ1IaKkzgGbm4ZXDk/BZk=;
  b=GeaFx9YxD/sdEyr8wVd5Dwqrn7egUUntQPx51bGM9xw1wnrQf5OBnebn
   4f5x/ECikpE+IN6H33CUSlyXMzQITCdxi5Rcz/IqzUzUzZofME7DfRhli
   SmtFYbVQYAvY0rzt8aDTVP7OCSXaRgpq5jO86lcfiWTMHLhKWmnNg1LJD
   1jjqEN8riQ9E/7eVfuo2OcLkLldWlJzn6PeALbZGsUTAt7IUuR8e+Uwk2
   TMe18AXcTB6noB7AwOcf4mwMND4mRBBOdbV/OFRYZL7pt6rZW6vub4h4W
   8LjXC6AY5/t9zQWPRRF5UYoWcpMIGoT8DSdYY/Ep5NNQFrupbnVuTNydn
   A==;
X-CSE-ConnectionGUID: L35UuXa/Sja3EX0hiZ0qxw==
X-CSE-MsgGUID: O94ObgXiQ+KZ77nkwGYgGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="36882963"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="36882963"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 04:18:46 -0700
X-CSE-ConnectionGUID: obFrx28UTsKDOymWZ0OkMA==
X-CSE-MsgGUID: Wde9/ASRTMah02v3auHlPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="95064325"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa002.fm.intel.com with SMTP; 25 Sep 2024 04:18:43 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 25 Sep 2024 14:18:42 +0300
Date: Wed, 25 Sep 2024 14:18:42 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	RD Babiera <rdbabiera@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Kyle Tso <kyletso@google.com>, Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] usb: typec: Fix typo in comment
Message-ID: <ZvPxkvq8BTOBpP_l@kuha.fi.intel.com>
References: <20240919014646.1635774-1-yujiaoliang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919014646.1635774-1-yujiaoliang@vivo.com>

On Thu, Sep 19, 2024 at 09:46:26AM +0800, Yu Jiaoliang wrote:
> Fix typos:
> reseet->reset,
> reaach->reach,
> compatiple->compatible.
> 
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/altmodes/displayport.c | 2 +-
>  drivers/usb/typec/tcpm/tcpm.c            | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 92cc1b136120..2f03190a9873 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -729,7 +729,7 @@ int dp_altmode_probe(struct typec_altmode *alt)
>  
>  	/* FIXME: Port can only be DFP_U. */
>  
> -	/* Make sure we have compatiple pin configurations */
> +	/* Make sure we have compatible pin configurations */
>  	if (!(DP_CAP_PIN_ASSIGN_DFP_D(port->vdo) &
>  	      DP_CAP_PIN_ASSIGN_UFP_D(alt->vdo)) &&
>  	    !(DP_CAP_PIN_ASSIGN_UFP_D(port->vdo) &
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index fc619478200f..b6486beda6ab 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5270,7 +5270,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
>  		break;
>  	case SNK_HARD_RESET_SINK_OFF:
> -		/* Do not discharge/disconnect during hard reseet */
> +		/* Do not discharge/disconnect during hard reset */
>  		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, 0);
>  		memset(&port->pps_data, 0, sizeof(port->pps_data));
>  		tcpm_set_vconn(port, false);
> @@ -6066,7 +6066,7 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
>  		break;
>  	case SNK_ATTACH_WAIT:
>  	case SNK_DEBOUNCED:
> -		/* Do nothing, as TCPM is still waiting for vbus to reaach VSAFE5V to connect */
> +		/* Do nothing, as TCPM is still waiting for vbus to reach VSAFE5V to connect */
>  		break;
>  
>  	case SNK_NEGOTIATE_CAPABILITIES:
> -- 
> 2.34.1

-- 
heikki

