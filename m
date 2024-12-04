Return-Path: <linux-kernel+bounces-432210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A889E47A7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86661285416
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1725D193404;
	Wed,  4 Dec 2024 22:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gU3AYVJu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A55023919C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350558; cv=none; b=aUHmTmijnfb0NBXVt5WiTUIVS+wbbc3d/yb4gXAQjjwDScup46s1rmuOn+hrsiSunx2gksDB/jYCFCwMQawePwICchOFVfphowCeBIUZKmJkxj3w779wP9urEIwpbgP26lszgHOAtLxiuxV0qNofD3hMaP2H1gMpQrlSNIjPYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350558; c=relaxed/simple;
	bh=otn8A1nLuF8/RUzJm2XwzVa1rlWyGGo1vK8UJOv/A3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJd/BldeNeRPKrs/TRqjkwpz263KOU+YPc5xxD8Rgeu8Lkh5CcRfls7CVsQBNPaLJMQ4kvcZn+V0w55MQ90qGqZxb50CyXEDoc/I5ONYagaeeRHm/9BLPZFiryI61t68MOLOH2OSsPTU6LwzMn5x7o11c+e+rG+jl8b8ANuP+JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gU3AYVJu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733350557; x=1764886557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=otn8A1nLuF8/RUzJm2XwzVa1rlWyGGo1vK8UJOv/A3k=;
  b=gU3AYVJuwJh6vINnBDNnjXzzVpJZPUVNQPvMc5DuIVI+a2eo39qs5dK/
   3USRmeiKFZkfH4llZogNmCJieHB80BiONoKXUlSrG03MhiubhmAqzIiff
   8V/XJTX0Q5rcxeKkFx0ik+aFlnrg3UoH2X0/gMEzkDJ10mKXSxVbmpl6j
   2Oc3kjnIYYdWsvap2Ic80clpJqgcCezSJPvrWFRKLU5rSFBGX6b9f19rm
   y7+IznZ/vmB377s9bH/kSWWg+dhjQDi45Tu2BuOja3SmI8ClTcCJWNx6X
   /9vgJrEa+xd6swDXAR34+I1tBMuqvgsFbnBR5t1cTUpL/5PENhEREyl6o
   w==;
X-CSE-ConnectionGUID: K+vQW9ZLTCmE0D9uGEhQnQ==
X-CSE-MsgGUID: Vsz7Oa6IQA6CXbQKBZn3lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33559766"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="33559766"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 14:15:56 -0800
X-CSE-ConnectionGUID: Z4tGM0s7TjKPaPT3aXiixw==
X-CSE-MsgGUID: aJ1YZkFBQTm3uSQeYD7AOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="124714009"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 14:15:55 -0800
Date: Wed, 4 Dec 2024 14:22:38 -0800
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
Message-ID: <20241204222238.GA31904@ranerica-svr.sc.intel.com>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
 <20241128002247.26726-3-ricardo.neri-calderon@linux.intel.com>
 <20241204143206.GAZ1Bn5jsTCvI_1ci0@fat_crate.local>
 <20241204163911.GA31633@ranerica-svr.sc.intel.com>
 <20241204193205.GBZ1CuNX-6hIDibZam@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204193205.GBZ1CuNX-6hIDibZam@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Dec 04, 2024 at 08:32:05PM +0100, Borislav Petkov wrote:
> On Wed, Dec 04, 2024 at 08:39:11AM -0800, Ricardo Neri wrote:
> > Yes, this looks OK to me and is an improvement.
> > 
> > I can post a v9 with these changes.
> 
> No need - I have everything here. I can give you a branch to test one last
> time before I queue.

Sure! Thanks! I can test it on Meteor Lake and non-Meteor Lake.

