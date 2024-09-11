Return-Path: <linux-kernel+bounces-325100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF67975500
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2F81F2146C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8F419E98B;
	Wed, 11 Sep 2024 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ggAwbRwZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2319DF85
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063751; cv=none; b=jx5eJ/RK0kg8BtOpbBoAMcPYXMRdk2AgQZCVMFpwMbcdZfDkISsspeQc8eUeCqBN2uuIlPVImtNnfHIJIyugbu27nIa/DRey/1hSdzT55oHxn6J9tDVa/oCxZ1bol/thmnHk1s8nH94LX7o/wi3ZWtDqiN/TqZb1hUpt5vjqIkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063751; c=relaxed/simple;
	bh=9MT3be9s25N9PEo90C/2H9gArrtyx/4oC7wbYEtp1Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUnYIjZfTNJrAVPN4l/C7FXpaY5mjDb/+AeUdk0ETapnSVhfMH9LQFcxh+YlZvgK83/PmeuGq7TlkJNuBQnvlz/pAk0ztka1XIlYpFZtNjTTi7e167SruxpMtU9ZoydDKLz7vwK6e3vf5ZWQEL5dY/iIAom31Tdm4pXw4J/HP+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ggAwbRwZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8002140E0284;
	Wed, 11 Sep 2024 14:09:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0qFjfHCNQk6z; Wed, 11 Sep 2024 14:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1726063743; bh=CPsFsYwBzYYLEQd7bSK6nqRccz2MBePUWvblyEL5O3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ggAwbRwZ3b2VobZiEO+tk+uR1zoAsk7rD486DBqiqZvXO1y2Oxbl2a4ifBni0L2o5
	 kyXqfQ5MlVIBS/i/NY+ShJ9bD75cu3mP7c+sbH8fc9OaPciNm1zrqfFeCTjXFjNWNR
	 ADNg0BT+BFgxKcU0d8Muxlq+MbfbOup7nAK6MQVHcOvay+WtDbMGE+5tz3pRdRkFQ9
	 ZSsJyvk2eSWdZbw09YC1FbnUsuHZMYZtx2DHn8X3QcTI1l0xeETIVRAMowUV48qdFk
	 9tclW7ADzWpveEpcEjVyTOLsWhBEPGDqigGb3OYFoR5gBFV3BBBhkqcJTWI2/TLUZo
	 ZUn9/2IgvxBTSbGWZnHiyxyihP78i0r9FXg6C+FS6AEE8/A1Htp/11+tOLH15GCs0/
	 z9jUWiO6jQhtT7xlM1ghsOYLDo67vU6nOwKsfEltlq5skXjrSg+yiGQndfeqPC3AUO
	 1IiO7WBkns21AR8buPJzAnEdE8YqNXbCseAJHM5IeUqy0UX+O9EK5cPqDhk5rP8l0l
	 d0AMNFg5qa4wk1E66CsAO7RJioVE/ev6qaoPORdF5RjSVvLXkF/5lB8WlnamUCcVVp
	 EwGZtm3gTwSYqE2msyKtaK/d3z2WMz7ofMgwVRfAQ0OXdiTMNjWMVr+Ex8dyd9LByx
	 Vl/BD+aPPxq+sT/Oi0NYFeHY=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7FFED40E021C;
	Wed, 11 Sep 2024 14:08:45 +0000 (UTC)
Date: Wed, 11 Sep 2024 16:08:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
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
Subject: Re: [PATCH v6 2/4] cacheinfo: Allocate memory during CPU hotplug if
 not done from the primary CPU
Message-ID: <20240911140844.GFZuGkbHQ_E-K5LW1q@fat_crate.local>
References: <20240905060036.5655-1-ricardo.neri-calderon@linux.intel.com>
 <20240905060036.5655-3-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240905060036.5655-3-ricardo.neri-calderon@linux.intel.com>

On Wed, Sep 04, 2024 at 11:00:34PM -0700, Ricardo Neri wrote:
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

Why is this a separate patch?

It sounds like it should be merged with the first one as both address a CPU
hotplug issue AFAICT.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

