Return-Path: <linux-kernel+bounces-434223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B800F9E637A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931BC16521F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E51F13C8F4;
	Fri,  6 Dec 2024 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTMLvYoF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E2176048
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733449250; cv=none; b=LAb/fCLrSV3152KrqIRmY6/REqfMfNxASUZG1ay504kEa3qK0AtTbLCFtZYD3ESd67srP3jssQp5QzDYp5ELdXXUntK/NzjYaSi4QrrrJbf2rHDsaEmIGkn5OACWFz6E4/sPc+dtnFYOz8Gk9W457+VQVz8Y5A2oBiU9nIUu8lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733449250; c=relaxed/simple;
	bh=4mJL3/BImbjt/HWeBf6SjqXOI7xx9d17v+h2nW/AlFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWXt+L/am4ywZq6/VUJg3Ewya7J8PpWnwleYIJryqKr0xJSCegjfeROAM2wcK6Rjc2COwb7Q6MNToRV8kzL6iYVpZVoLHvKytXe71xd/jn0fBgqksrzdkbwnAXWI5D2iIO/Kg2JphD7Es2Vy7soUPpA9NcbO1963GvIlsJL/iPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTMLvYoF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733449248; x=1764985248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4mJL3/BImbjt/HWeBf6SjqXOI7xx9d17v+h2nW/AlFU=;
  b=cTMLvYoFUNoHTHuVKGHIO1bCmFkTUIhhoUigHHJsunf18+qHw8kvuVO+
   j8Et0ROs4ybOfiF49d9Pbl9vWvchX8mEiR8d6W1ZFhKhhXAxrD9T+FK7/
   9zwZBfJHzcBjbGdESZWD06qyu1qDeewxuDEfrsNJ2RIN8TuzxwRfCDOxN
   IVFykcG2MBZGkUF3HyGh2Tv+G/eGiFCkfysDDHDaEmZqrM7usUfHfz5Tv
   oL74bA6oY4ScHbu8IQh9xQ9PrzG2Az/xU6lICNEfnUF2xTmaiZCBkU6eV
   q+C8c9QFVKbIRmvK8Z5s+i3nucebcYdHynlLA7KmqQNxnEVFz+bLWQIeF
   Q==;
X-CSE-ConnectionGUID: WHIb//iCQnqfN3qsGQvj3Q==
X-CSE-MsgGUID: qyZCiQ31QKSE2VyRC46I3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="51208121"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="51208121"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 17:40:47 -0800
X-CSE-ConnectionGUID: DMmfCKvAQL2+kqfdNAkxWg==
X-CSE-MsgGUID: G9UbU2utRHmAxXBCX2X8Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="93941537"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 17:40:47 -0800
Date: Thu, 5 Dec 2024 17:47:29 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] x86/cacheinfo: Delete global num_cache_leaves
Message-ID: <20241206014729.GA1505@ranerica-svr.sc.intel.com>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
 <20241128002247.26726-3-ricardo.neri-calderon@linux.intel.com>
 <20241204143206.GAZ1Bn5jsTCvI_1ci0@fat_crate.local>
 <20241204163911.GA31633@ranerica-svr.sc.intel.com>
 <20241204193205.GBZ1CuNX-6hIDibZam@fat_crate.local>
 <20241204222238.GA31904@ranerica-svr.sc.intel.com>
 <20241205151445.GAZ1HDZYWWRUFvuVBA@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205151445.GAZ1HDZYWWRUFvuVBA@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Thu, Dec 05, 2024 at 04:14:45PM +0100, Borislav Petkov wrote:
> On Wed, Dec 04, 2024 at 02:22:38PM -0800, Ricardo Neri wrote:
> > Sure! Thanks! I can test it on Meteor Lake and non-Meteor Lake.
> 
> Ok, pls run this:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-urgent-wip

I tested this branch on Alder Lake, Meteor Lake, Sapphire Rapids,
Broadwell server, Granite Rapids, Icelake server, Sierra Forest, and Rome.
/sys/devices/system/cpu/cpu*/cache is populated correctly.

I ran the tests documented in

https://lore.kernel.org/lkml/20230912032350.GA17008@ranerica-svr.sc.intel.com/

Thanks and BR,
Ricardo

