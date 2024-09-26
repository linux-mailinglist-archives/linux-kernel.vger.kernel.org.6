Return-Path: <linux-kernel+bounces-340494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD34B98741F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7222F1F21AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAB510F4;
	Thu, 26 Sep 2024 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UrR01HyR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1477629405;
	Thu, 26 Sep 2024 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355819; cv=none; b=oJlQr5UNk9wyDkIb/Z5RoCH74cuSWf0FbxPSP7ZOywh/NBU7sC6dq7Ju4691XlGAFitbmAQPh/b6fDP/trwnxtWmU31GxMxWient4jLK9FhpMUsZPojSaN+9ykRrkLTXPY8z8imQRlhkKIZdVU79AUXNpN69WePtI56j4LmWp34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355819; c=relaxed/simple;
	bh=CWUWM8m6b1Qw94pSynMxLnjyr7+M5JzFKYlB7l8u8Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+Ygt1tY0c7So4UwTxUeYYVg10ec0R4zErhbBzYBp0uXNUPNlbBOjqHBCu/mhZYSm8/zGXW2sDjWNFdRXvswt/NWNZbge6e3Aq512Pg224BRrdCzNi9es/aDyHOlw/frc0fyG+s6uVmY1RASTn4K9AjWO8bNNurD6+bR9vVqAyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UrR01HyR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727355817; x=1758891817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CWUWM8m6b1Qw94pSynMxLnjyr7+M5JzFKYlB7l8u8Kk=;
  b=UrR01HyR1PQSe+3W2jhLFg5odG/vIZSC0Cc9knAJPpZKNciplAHmoSO/
   Lkb79NThuLEq52eyxcyPNVJBxiSQ+cnttlY544ekoqa/f6YgiOPhh8OTV
   Br3SVdMR6uro3fY9HSoCCmMwj7aA2ULDc+hkEVx3sN8SDz5hPV3EP1q3S
   wpCphEaSQ5Uu8sNRE6IOAh5VWF5MlRTrtBgOwUuy0anmtb+uvPa9yqg9U
   EygcPaVgr/UryRX1Q0HkbGoWb+kLJBxjzerqc6G732Gz69mvDH4ruhZwb
   KSpf75jOkLB0G3fty9Emz3dqUzQJfzg7RHLhtguXHdJkTdN2Ra6HVFlyV
   A==;
X-CSE-ConnectionGUID: lnyFDtCzTU2pRIMONQIVdw==
X-CSE-MsgGUID: wYGVLPejRRquUe4YRtHixg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26628065"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="26628065"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 06:03:36 -0700
X-CSE-ConnectionGUID: exck/QanT7aQpNtwsp9p4A==
X-CSE-MsgGUID: GKsE3N+ETVCD6fHNKu5BqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="76919448"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa005.jf.intel.com with SMTP; 26 Sep 2024 06:03:32 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 26 Sep 2024 16:03:30 +0300
Date: Thu, 26 Sep 2024 16:03:30 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: R Sundar <prosunofficial@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	RD Babiera <rdbabiera@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Kyle Tso <kyletso@google.com>, Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	frank.wang@rock-chips.com, kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH linux-next] usb: typec: tcpm: use max() to get higher
 value
Message-ID: <ZvVbogBA_mlelt8H@kuha.fi.intel.com>
References: <20240925122014.552221-1-prosunofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925122014.552221-1-prosunofficial@gmail.com>

On Wed, Sep 25, 2024 at 05:50:14PM +0530, R Sundar wrote:
> Use max() for better readability and to fix cocci warnings.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Closes: https://lore.kernel.org/r/202409231009.2efXAh9b-lkp@intel.com/
> Signed-off-by: R Sundar <prosunofficial@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Reported in linux repo.
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> cocci warnings: (new ones prefixed by >>)
> >> drivers/usb/typec/tcpm/tcpm.c:6356:20-21: WARNING opportunity for max()
> 
> vim +6356 drivers/usb/typec/tcpm/tcpm.c
> 
> compile-tested only.
> 
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index fc619478200f..aac4de1d53a8 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -7367,7 +7367,7 @@ static int tcpm_psy_get_input_power_limit(struct tcpm_port *port,
>  			src_mv = pdo_fixed_voltage(pdo);
>  			src_ma = pdo_max_current(pdo);
>  			tmp = src_mv * src_ma;
> -			max_src_uw = tmp > max_src_uw ? tmp : max_src_uw;
> +			max_src_uw = max(tmp, max_src_uw);
>  		}
>  	}
>  
> -- 
> 2.34.1

-- 
heikki

