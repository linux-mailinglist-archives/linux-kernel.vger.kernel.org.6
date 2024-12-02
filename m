Return-Path: <linux-kernel+bounces-427307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D149DFFA5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA689B24DFE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CED11FC7E8;
	Mon,  2 Dec 2024 11:03:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329F31F9407
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137437; cv=none; b=IyU4c3HzXZwLTKPw8CfLg+1psruNyp13ZOokf9P49Cx7wlEyhcS1v2EfMqp3MOsz9clIe2Rxzm4qvw4fSHJHStg0xcE/b65sCPG/tqPW/0zECtt1rSO5+QifK8im2xABzBzlZCf1pBKG0j9d1v4q3sBjMqzF4Fagyqu1YRDPkTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137437; c=relaxed/simple;
	bh=At2+zhwX3ZTTQuxrsKtv3I9n9xEVkSviOAFMHbjmVJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQ9qbiONuGIVKSHEBRGqY4CQrwJ7WlTP9ZEAooVkD8ctzjj0XZv4xAXQQPfD3nNR+Wu9O5OMSa/vq92JYe3+JgP7wmjHpe5U9ilBLmd3s6B8FjmdAV09UaTzixhyFmWQsuRQIxRupxugdUx38SJiR1CpFfJOQm1l3nH2SLVP/2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3B761063;
	Mon,  2 Dec 2024 03:04:22 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C05443F71E;
	Mon,  2 Dec 2024 03:03:51 -0800 (PST)
Date: Mon, 2 Dec 2024 11:03:49 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] cacheinfo: Allocate memory during CPU hotplug if
 not done from the primary CPU
Message-ID: <Z02UFUQCwEVAnY7C@bogus>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
 <20241128002247.26726-2-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241128002247.26726-2-ricardo.neri-calderon@linux.intel.com>

On Wed, Nov 27, 2024 at 04:22:46PM -0800, Ricardo Neri wrote:
> Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> adds functionality that architectures can use to optionally allocate and
> build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo: Add
> arch specific early level initializer") lets secondary CPUs correct (and
> reallocate memory) cacheinfo data if needed.
> 
> If the early build functionality is not used and cacheinfo does not need
> correction, memory for cacheinfo is never allocated. x86 does not use the
> early build functionality. Consequently, during the cacheinfo CPU hotplug
> callback, last_level_cache_is_valid() attempts to dereference a NULL
> pointer:
> 
>      BUG: kernel NULL pointer dereference, address: 0000000000000100
>      #PF: supervisor read access in kernel mode
>      #PF: error_code(0x0000) - not present page
>      PGD 0 P4D 0
>      Oops: 0000 [#1] PREEPMT SMP NOPTI
>      CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc2 #1
>      RIP: 0010: last_level_cache_is_valid+0x95/0xe0a
> 
> Allocate memory for cacheinfo during the cacheinfo CPU hotplug callback if
> not done earlier.
> 
> Moreover, before determining the validity of the last-level cache info,
> ensure that it has been allocated. Simply checking for non-zero
> cache_leaves() is not sufficient, as some architectures (e.g., Intel
> processors) have non-zero cache_leaves() before allocation.
> 
> Dereferencing NULL cacheinfo can occur in update_per_cpu_data_slice_size().
> This function iterates over all online CPUs. However, a CPU may have come
> online recently, but its cacheinfo may not have been allocated yet.
> 
> While here, remove an unnecessary indentation in allocate_cache_info().
> 
> Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Reviewed-by: Radu Rendec <rrendec@redhat.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

In case old tags are deemed null 😄,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

