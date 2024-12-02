Return-Path: <linux-kernel+bounces-428478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 385079E0F00
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E2F16416E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1712F1DF748;
	Mon,  2 Dec 2024 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i35Qtqtb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691992EAF7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733179609; cv=none; b=P9gCCs5vKBO3I6Ipb1y5inOyRfbdmcN9/pff5Y0LexhKHqBuDdSgnmqEYvRb6yDAPGiBfALpvs2OltQr+8vVKvcwhLQL7/xafXkYva1EO2W42aDIU+piJVjSFfQa16EyTUS82+CRy39bt98tskFqzR02dELZZxLEhGmftu6g9bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733179609; c=relaxed/simple;
	bh=wfRpOa0nyEPW+MNFlq72vEEJTWVvlJi872U1Psy+zdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OV58uiea9C7u8dikoDnSG2WjjJilxAM9Qe70AhTM0oKBcv+dcqFnOcvMedwMkmJWOmq4zKMxZQRLD6vhu1fcYCpacYrV0w2Flzpbdw/fx/GV/hhTEZbW/HDbE83XFF6bnGaJINzLheajfh0DvQryOun4wLei1MUOF6+PuIJ5rh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i35Qtqtb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733179607; x=1764715607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wfRpOa0nyEPW+MNFlq72vEEJTWVvlJi872U1Psy+zdE=;
  b=i35QtqtbsT1320FJhRwtR8OE0O0Q+ZpE0b/2htenbN3JCQeuat40mMfR
   M0mHKJAh4LNz1LVBzaFd0fdcXpKPgZC0d3qPgn9pdvDsRawwIVG/I8gAS
   Jj+hlK5wQtdxv6z1UjxZAwXfsfobuOEaDRWU0SHdyregvoezW7j/S6yoS
   CwwFjZj5CDqdSAXeWaeiF045OzCq3FKo8AUuEBsBhxME8AT+RfrKmzFXs
   Z/14EhY0dDfbPhTrSj3n6i38IL7Qcp6VpSLoySXDxWdP329/E/2Nqz3vX
   jiyMpZZ06qMze+E0i49N9UORXdAP0AhBl6kyGcsFisLPqvVmjZ1dlm+k2
   A==;
X-CSE-ConnectionGUID: qko/oIvLR+Gqyo0DOxYZFA==
X-CSE-MsgGUID: 1LkMqXaiQ8yl97KwNI87DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33500270"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="33500270"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 14:46:47 -0800
X-CSE-ConnectionGUID: XYVxYna0TFKhMy8Dc4Ci4g==
X-CSE-MsgGUID: p7q7LfeRTsedUcbD/ZRiNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="130701505"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 14:46:47 -0800
Date: Mon, 2 Dec 2024 14:46:45 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>,
	Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: resctrl mount fail on v6.13-rc1
Message-ID: <Z0441XN_KoCP-fNz@agluck-desk3>
References: <Z04pz3AlvI4o0Mr8@agluck-desk3>
 <868b451a-fdba-4b45-bff1-9ac1023080c8@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868b451a-fdba-4b45-bff1-9ac1023080c8@intel.com>

On Mon, Dec 02, 2024 at 02:26:48PM -0800, Reinette Chatre wrote:
> Hi Tony,
> 
> On 12/2/24 1:42 PM, Luck, Tony wrote:
> > Anyone better a decoding lockdep dumps then me make sense of this?
> > 
> > All I did was build v6.13-rc1 with (among others)
> > 
> > CONFIG_PROVE_LOCKING=y
> > CONFIG_PROVE_RAW_LOCK_NESTING=y
> > CONFIG_PROVE_RCU=y
> > 
> > and then mount the resctrl filesystem:
> > 
> > $ sudo mount -t resctrl resctrl /sys/fs/resctrl
> > 
> > There are only trivial changes to the resctrl code between
> > v6.12 (which works) and v6.13-rc1:
> > 
> > $ git log --oneline v6.13-rc1 ^v6.12 -- arch/x86/kernel/cpu/resctrl
> > 5a4b3fbb4849 Merge tag 'x86_cache_for_v6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> > 9bce6e94c4b3 x86/resctrl: Support Sub-NUMA cluster mode SNC6
> > 29eaa7958367 x86/resctrl: Slightly clean-up mbm_config_show()
> > 
> > So something in kernfs? Or the way resctrl uses kernfs?
> 
> I am not seeing this but that may be because I am not testing with
> selinux enabled. My test kernel has:
> # CONFIG_SECURITY_SELINUX is not set

I did have SELINUX configured. Disabling this CONFIG option
makes the lockdep splat go away.
> 
> I am also not running with any btrfs filesystems. 

My root and home filesystems are btrfs, so difficult to
check if this is also connected.
> 
> Is this your usual setup in which you are seeing this the first time? Is it
> perhaps possible for you to bisect?
> 
> The subject states "resctrl mount fail" - could you please confirm if
> resctrl cannot be mounted in addition to the lockdep warning?

The filesystem did get mounted despite all the lockdep noise.

> 
> Reinette

-Tony

