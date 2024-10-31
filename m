Return-Path: <linux-kernel+bounces-390662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E959B7CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF0A281D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFFA1A0AFE;
	Thu, 31 Oct 2024 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUxE6R6l"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA8181B8D;
	Thu, 31 Oct 2024 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385192; cv=none; b=ihwhHeCc20TED5jyfxjC5atrSkCCe8o7xcMaqS2r1nlDkQj/Ii/4Yh61f6ZJEoo8u9yXW3A0J5RlKrPFS1n5EtAT4bmFhKb5IV4ocQI9faXD1g5FkEmxHfujPCrlJQofQ/8D9wZ6TU3rx1WwFVMpZ43ilzKbaebDq5TVBiIeRrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385192; c=relaxed/simple;
	bh=ynPJoLvXglmyEg/wsGynZevUE2X2f/JoNLwfJ1zvlCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6am7neuXrpaBr9YWm4fd6R6fIIMh7yfVE4OIUkvSBuKhBQlzhZsZc84ZOxCipxX06BYhOPUDakO30orJIdP0fIHpLGTOC6zFqw2kwrNrvS7QUGERZ977lfnVLc3+46qj++BdIDa2MoXxbQQ270AlNkCMpppAQgGGGM6i7PDxEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUxE6R6l; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730385190; x=1761921190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ynPJoLvXglmyEg/wsGynZevUE2X2f/JoNLwfJ1zvlCg=;
  b=mUxE6R6lPriGl2JQ0aUchsY6TMWsqKFBieWgJFb0fkdM3r42F5kdxHdj
   GRIj6IE8MKsONkdRNcxK/aGSkTFGBPsKloj/AOgQ8IVYH7WqTVWYpfriE
   zp0WqLoYdOEVPXDY7YiPcCrTd4UP5X+dwZhr03exzhLCQsiGH3YkkU1xR
   RZSLpm+wgDUrCf6220zAJAExxKahd2Kqmfu37MK316SBV+3KFZWk3mjXZ
   ww9G2h2cG8CF76THY3QVBVNX8Ezb3eWVqCKctSj0ybIjnWzc7sMYJmobC
   C3T5PRzcQt0kzc8mXTe1AaD8a0UMJUdlFmUOM3qiSFkaS0rC7LIslVLJg
   A==;
X-CSE-ConnectionGUID: jexEkTjSRlChI9y2QDTPxA==
X-CSE-MsgGUID: bVYE8268TACIRemOcANF4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="41492948"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="41492948"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 07:33:09 -0700
X-CSE-ConnectionGUID: 7RIA3JY0S6ih93TR62tj0Q==
X-CSE-MsgGUID: axgnRfM8SoyjurbkOhcMdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="87778818"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa004.jf.intel.com with SMTP; 31 Oct 2024 07:33:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 31 Oct 2024 16:33:04 +0200
Date: Thu, 31 Oct 2024 16:33:04 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: tzungbi@kernel.org, linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev, dmitry.baryshkov@linaro.org,
	jthies@google.com, akuchynski@google.com, pmalani@chromium.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] usb: typec: Auto enter control for alternate modes
Message-ID: <ZyOVIKGlrlj7kc9-@kuha.fi.intel.com>
References: <20241030212854.998318-1-abhishekpandit@chromium.org>
 <20241030142833.v2.3.I439cffc7bf76d94f5850eb85980f1197c4f9154c@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030142833.v2.3.I439cffc7bf76d94f5850eb85980f1197c4f9154c@changeid>

On Wed, Oct 30, 2024 at 02:28:34PM -0700, Abhishek Pandit-Subedi wrote:
> Add controls for whether an alternate mode is automatically entered when
> a partner connects. The auto_enter control is only available on ports
> and applies immediately after a partner connects. The default behavior
> is to enable auto enter and drivers must explicitly disable it.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  Documentation/ABI/testing/sysfs-bus-typec |  9 +++++++
>  drivers/usb/typec/altmodes/displayport.c  |  6 +++--
>  drivers/usb/typec/altmodes/thunderbolt.c  |  3 ++-
>  drivers/usb/typec/class.c                 | 31 +++++++++++++++++++++++
>  include/linux/usb/typec.h                 |  2 ++
>  include/linux/usb/typec_altmode.h         |  2 ++
>  6 files changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-typec b/Documentation/ABI/testing/sysfs-bus-typec
> index 205d9c91e2e1..f09d05727b82 100644
> --- a/Documentation/ABI/testing/sysfs-bus-typec
> +++ b/Documentation/ABI/testing/sysfs-bus-typec
> @@ -12,6 +12,15 @@ Description:
>  
>  		Valid values are boolean.
>  
> +What:		/sys/bus/typec/devices/.../auto_enter
> +Date:		September 2024
> +Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +Description:
> +		Controls whether a mode will be automatically entered when a partner is
> +		connected.
> +
> +		This field is only valid and displayed on a port. Valid values are boolean.

So, why can't this be controlled with the "active" property of the
port altmode instead? That's why it's there.

Sorry if I missed something in v1 related to this question.

thanks,

-- 
heikki

