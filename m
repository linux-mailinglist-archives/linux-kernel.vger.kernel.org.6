Return-Path: <linux-kernel+bounces-428620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7249E1172
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCD92824A5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703C513C67C;
	Tue,  3 Dec 2024 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHV2WSCH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1343D364AE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 02:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733194062; cv=none; b=jFEBS4HGkyI5vdYgh+TBEVbxxBJ+KWmCyOJUEjiIkGaxSm1m4eWyycKVlBDFoXuucWJPJON80ogeZYxdIaKT7sUi4gjU6eEM/lKkH2hGF9UpvKTarqgiPQnxF2VOJeAwBBHVNfVK+dWsv5r3skojfOoU220XgsgLhk/INWk+sZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733194062; c=relaxed/simple;
	bh=WKyDI479E4aDsVyy+KFk9yYInIWD02NKG8DUEFxYmYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0RZQj8BVKUMJtbiTbXQRRkbO9OmCP8+eWC4TYkNv+hqG/QKmWP3HWYTqcSQtFXat0z1yTo9dlMpQ0MjlODmFprqrru7fdZNgGfBmjYoN1ZpTegCGPHYs6C1Raf8V8tqv5w6CLi0qtDzlEHqjbH8dp3Jp2DJg9t9ZK/0ovsTbJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHV2WSCH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733194061; x=1764730061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WKyDI479E4aDsVyy+KFk9yYInIWD02NKG8DUEFxYmYE=;
  b=gHV2WSCHmY5Z0OrbrDhOOsjIhwzA8zDKTAmkrI51xmAg9ueIZcBDtxky
   DQ8g2sGt5+eFLh1d1dvFWZMt+FoEaxi+y2aCC+r68jkhKzBQbbQcd9exU
   bzknusIRnX99x3R70TLCyRNmsUMz7kfdhg73kGdQlwbMQL3F1usCpa3gV
   oDXWoltAfMWcY+36YVRlHD+DwQQN7u5aKvXpKUFOsD2E/hkR9I8Efbv66
   HiGMk+pTFHMD7X/UzROU1QjYgZbG8N1Es/kfD8+y4vWU/a/QW/C4d0rWd
   8h6AsnQk1OTXJQdHoTjKO/9rUmsNGVXJJwjkPmXFONZqkmSdYw28YtSXA
   w==;
X-CSE-ConnectionGUID: Oi/vbg0GS7uGlbqQAShjiQ==
X-CSE-MsgGUID: bPRbbrRwRd6+/j0wkksmEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33318273"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33318273"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 18:47:40 -0800
X-CSE-ConnectionGUID: 8kcZYcQ8RNKsXLCIUksW8w==
X-CSE-MsgGUID: mf8Lio6/SLiwW1gBcF9W4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="98378730"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 18:47:40 -0800
Date: Mon, 2 Dec 2024 18:47:38 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>,
	Ming Lei <ming.lei@redhat.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>,
	Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: resctrl mount fail on v6.13-rc1
Message-ID: <Z05xSqIeNeHh19MZ@agluck-desk3>
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
> 
> I am also not running with any btrfs filesystems. 
> 
> Is this your usual setup in which you are seeing this the first time? Is it
> perhaps possible for you to bisect?

Bisection says:

$ git bisect bad
f1be1788a32e8fa63416ad4518bbd1a85a825c9d is the first bad commit
commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
Author: Ming Lei <ming.lei@redhat.com>
Date:   Fri Oct 25 08:37:20 2024 +0800

    block: model freeze & enter queue as lock for supporting lockdep

> 
> The subject states "resctrl mount fail" - could you please confirm if
> resctrl cannot be mounted in addition to the lockdep warning?
> 
> Reinette
> 

