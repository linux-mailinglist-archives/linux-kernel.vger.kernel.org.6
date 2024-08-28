Return-Path: <linux-kernel+bounces-305100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA54396297C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA671C237CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C25188014;
	Wed, 28 Aug 2024 13:57:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626F0184535
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853447; cv=none; b=UjEaC2YxIp/ZbkRw4fZSoSsnfT20yOzQgeweB1wHlPvcsatgppJpoSMcJLFwvkoMUKjXKnsh08v7i9bQKi6v1kc1cVkID+aObWgk54H8GK3IeekdQ5u6Rx/EjDDFqeAOgFz5aGmW3XktvZokQXIsBtCz42IyzNo+GppeSuLKZss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853447; c=relaxed/simple;
	bh=31TFdvikpdgOvXbO/nGOAAXIG8EhOT55qKFYtM9UY98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zo5f7SlrT9gvrXWkK97nhCk5WM1qSXOSKh1Tj+KfRt0fnH0d2ZWB8lTf3kYa3RfXBADZNFrPSXcVEzA32eU7ECiDbBFtH+6iB3X9Bzp4sK81QADZpax446oNdjj3utJ7xlVvLCzwhY3QnXkLv8w6oT69KjZD+86uIhMtLGTKFgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3AE9DA7;
	Wed, 28 Aug 2024 06:57:50 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.198.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05C2D3F762;
	Wed, 28 Aug 2024 06:57:21 -0700 (PDT)
Date: Wed, 28 Aug 2024 14:57:19 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org,
	Andreas Herrmann <aherrmann@suse.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] cacheinfo: Allocate memory for memory if not done
 from the primary CPU
Message-ID: <Zs8svzZPTUmF7NP0@bogus>
References: <20240827051635.9114-1-ricardo.neri-calderon@linux.intel.com>
 <20240827051635.9114-3-ricardo.neri-calderon@linux.intel.com>
 <c613d2d5-cb7b-40fe-b322-45ddb43c6382@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c613d2d5-cb7b-40fe-b322-45ddb43c6382@suse.com>

On Wed, Aug 28, 2024 at 04:16:00PM +0300, Nikolay Borisov wrote:
> 
> On 27.08.24 г. 8:16 ч., Ricardo Neri wrote:
> > Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> > adds functionality that architectures can use to optionally allocate and
> > build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo: Add
> > arch specific early level initializer") lets secondary CPUs correct (and
> > reallocate memory) cacheinfo data if needed.
> > 
> > If the early build functionality is not used and cacheinfo does not need
> > correction, memory for cacheinfo is never allocated. x86 does not use the
> > early build functionality. Consequently, during the cacheinfo CPU hotplug
> > callback, last_level_cache_is_valid() attempts to dereference a NULL
> > pointer:
> > 
> >       BUG: kernel NULL pointer dereference, address: 0000000000000100
> >       #PF: supervisor read access in kernel mode
> >       #PF: error_code(0x0000) - not present page
> >       PGD 0 P4D 0
> >       Oops: 0000 [#1] PREEPMT SMP NOPTI
> >       CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc2 #1
> >       RIP: 0010: last_level_cache_is_valid+0x95/0xe0a
> > 
> > Allocate memory for cacheinfo during the cacheinfo CPU hotplug callback if
> > not done earlier.
> 
> I assume instead of duplicating "memory" in the subject you meant
> "cacheinfo" ?
>

Good point, +1 for the $subject change. I clearly missed to notice that.

-- 
Regards,
Sudeep

