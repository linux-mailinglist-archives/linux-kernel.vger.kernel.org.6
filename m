Return-Path: <linux-kernel+bounces-325093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 313349754EA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD9F285E50
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CBB192B96;
	Wed, 11 Sep 2024 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eMrIskXP"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D622224F6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063544; cv=none; b=ufSje3WqQu+tMvT5XJ9DpodXgQrJSgKadjeDJy+OAyeIlbTYaLCJ+kkPNPQL1m99W+zDSGwEhHJ6dRYiDkUQdpLOlpyFHl6Xi0Yc623pSZHR63u0RLJnM/NGRAXWSh5E/NATnqb9HWErJYfFHt94vuOj+MNgtclQK0dcMOAh5GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063544; c=relaxed/simple;
	bh=hfTtx0idlru0o/9cZjfVOd8xbkDN9N0akBn+0OjRy24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1jPfGIqpyhXQK2BwI9ooHOEdCOUtOOQngpoDOQx6fFFWW4K1v9XGMlaNZ3FNJKmTdSIB1rnWl85am9opfyZnXGnGqjGZc3SkudRxefM9rFhI4Ee23ToGYZm9Od6gshvoxEuE7VktxDi214MjyncBuBRAOG+fxqfAdsBrOBJ11g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eMrIskXP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C066140E0263;
	Wed, 11 Sep 2024 14:05:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VUjFv9VhFejv; Wed, 11 Sep 2024 14:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1726063533; bh=rMc9BCJks/dYjAJh5XKHYqysLxW6V4HORxTSura01oE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eMrIskXPG6+zYglIQHrZhToZen0r/iQfR0cm6KAveDstGwRCrsmfSlRGbiMxISQSd
	 +ZIRqfkbZN5ODPDHo/oDOOtlUO7eyKqXKzzQgpBaGR8nyl6gFG1nPMau7KkhUHAgoM
	 nNQITi/pTMCjLU5s1A4mejQx+goTRnC4pAelSzhrdgH1EGw3J21RdnBqN+oDlMkq+8
	 ijBhbIWASPakj3i1iONNAkhImrluSVae9W+X7CUorSOHWZBBFlmzQ9atEo5KNgW4Z2
	 lQ7SWU1gJN0IbLt5c/Y733K+RGykiiphIMY7jUtJTa9LzzJrKTNPpQ/qs2pBH8kiVJ
	 moxJ5SKDi45IrYAgGsJJd/X3n1cT5dt/3RPXOVrtVYuqukgCEvPKiPVkK85pjrmfWi
	 yM3sTNx1OslTt7oMu1iyFcYJw94I3XpXesFsgj3v2H6BJy/T42gsIcP1/bJFoZt8Oz
	 SJ65YZrXaGupticE0xOARq18KVEJsdIIB42JHLkbpehIO1mndgJgGfSFbtYVJKRQ8L
	 7RmqgYAh10Jdr8cb7BQefG3fKdNcJh2tjDE1AHojw26NbeWiATgVqIx/gKmwpvDYa5
	 YVkXaRUMDurjX9s/HeixiEfJRw79NMmZhfZEbyL/6d0pgcQleZGLPp5P7xZaP3FhEI
	 vJtaMNBvmSZoiRvx6/Dkv4+M=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0354440E0081;
	Wed, 11 Sep 2024 14:05:14 +0000 (UTC)
Date: Wed, 11 Sep 2024 16:05:09 +0200
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
Subject: Re: [PATCH v6 1/4] cacheinfo: Check for null last-level cache info
Message-ID: <20240911140509.GEZuGjlfyxj5hvSDYU@fat_crate.local>
References: <20240905060036.5655-1-ricardo.neri-calderon@linux.intel.com>
 <20240905060036.5655-2-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240905060036.5655-2-ricardo.neri-calderon@linux.intel.com>

On Wed, Sep 04, 2024 at 11:00:33PM -0700, Ricardo Neri wrote:
> Before determining the validity of the last-level cache info, ensure that
> it has been allocated. Simply checking for non-zero cache_leaves() is not
> sufficient, as some architectures (e.g., Intel processors) have non-zero
> cache_leaves() before allocation.
>
> Dereferencing NULL cacheinfo can occur in update_per_cpu_data_slice_size().
> This function iterates over all online CPUs. However, a CPU may have come
> online recently, but its cacheinfo may not have been allocated yet.
> 
> Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Tested-by: Andreas Herrmann <aherrmann@suse.de>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

While at it, pls fix the formatting insanity of allocate_cache_info() into:

static inline int allocate_cache_info(int cpu)
{
        per_cpu_cacheinfo(cpu) = kcalloc(cache_leaves(cpu), sizeof(struct cacheinfo), GFP_ATOMIC);
        if (!per_cpu_cacheinfo(cpu)) {
                cache_leaves(cpu) = 0;
                return -ENOMEM;
        }
            
        return 0;
}

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

