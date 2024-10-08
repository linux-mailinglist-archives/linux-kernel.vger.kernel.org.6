Return-Path: <linux-kernel+bounces-355545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFE39953CF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537DF1C257B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EE11E04BA;
	Tue,  8 Oct 2024 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kSiP49cC"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E761E0DA9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728402700; cv=none; b=dboZVdNpef1y12XDmZG4fw4i7oXvDdREJCPKmOsF1ryjOc4tIForrpGtG+xjxBbqq0XjUA3DmEp7kNZ9ay+kLU6mATFpVmm+f122xvWZf2qGHxOG1D/2aQWj62pPbmanFL3pxwgY34KvlGmaCDExxeMYHZO087XwAPAqDc7HtHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728402700; c=relaxed/simple;
	bh=4Zp2Jg6nQbDpjHsHz67WBRpmpkV3cCZk599vvUQkRd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMmKJ/FrM0jM10CdEIG4abnKwlfCqD3GWPTyx4840l3VAr/KNsknYOVzN+/IqC39gy4Xh2a4sn3GDhQBCcU3wiX1hmM5nZKeuTV6sMG3Y/hW2Yk7LgDYoOREQsBM4hNhzoM8E6941hkH3Qyvsnoz6HiYa1wLyPvS57dIeR4gl6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kSiP49cC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 45AE540E0198;
	Tue,  8 Oct 2024 15:51:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cIvbvKpd3mtK; Tue,  8 Oct 2024 15:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728402685; bh=EzllisSvLO3xP1CxKXHQQI2U92ojuO9qENfZt7qwVrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kSiP49cCwKwCu/mbbiwUY347eLpFIwVokCnIyha/rWIfRGEid0TSNNQSnduM50eNa
	 Ui2W+KP8h+rCo0pZewZp1gZmsbM5wgVAkxFUrNm/XbWuzG4T9xHuvy2Qud6R6kbA0F
	 ua3P7A937S94+mfUvNQUkFvQK7dLqFaVi1a7cAQVCj0RqTT7gUsZoPy2WrRtqtnJk3
	 /xJZ5EmBNT5HVJwekcN0xBbtVgg242unqlhDfxTk7njDcdbO3hVOZaMmm8ia/aN8jN
	 Rv4v07imtPjqG4H0ALtUTTY8b0jp7AaNXstXYDfCAPS2Mz6K5J7u+Yq3OBqPHWF27X
	 9TuMHNzzr3tLOCbH8MOq3le22wutCLvuzS7Eft8vM4UI88BPrVg0Cls7zpYu5lgp2f
	 5PeL+3nRm4pV65GG+ihK7qC79mjpz7HQx41cqIwcHwaikW0yPq2HrUPiuMTIX3+xH4
	 3jDtsRQbrx1UPZiuYmFxB3jP8b64vNoRs3qLyoGR4XU6XQK44dxw2KJC1fzMC0rSq6
	 Ej0InXw00GpYLtd17bNBYjWmu5dDcvsOjAEtoMpctHwNmXY2kgbMgOlhbBYVqev5Pf
	 LcrJ/FESraWwfloAceqhESojsdL16+gDxrqo0EyQ8cTJubPLcWCxGUZDs2NwRPDOkB
	 ohuhw0mPbSHv6YbihhRpoeSQ=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1A40540E0163;
	Tue,  8 Oct 2024 15:51:07 +0000 (UTC)
Date: Tue, 8 Oct 2024 17:51:06 +0200
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
Subject: Re: [PATCH v7 1/3] cacheinfo: Allocate memory during CPU hotplug if
 not done from the primary CPU
Message-ID: <20241008155106.GMZwVU6gjw45z2gn8x@fat_crate.local>
References: <20240913083155.9783-1-ricardo.neri-calderon@linux.intel.com>
 <20240913083155.9783-2-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913083155.9783-2-ricardo.neri-calderon@linux.intel.com>

On Fri, Sep 13, 2024 at 01:31:53AM -0700, Ricardo Neri wrote:
> The motivation for commit 5944ce092b97 was to prevent a BUG splat in
> PREEMPT_RT kernels during memory allocation. This splat is not observed on
> x86 because the memory allocation for cacheinfo happens in
> detect_cache_attributes() from the cacheinfo CPU hotplug callback.
> 
> The dereference of a NULL cacheinfo is not observed today because
> cache_leaves(cpu) is zero until after init_cache_level() is called
> (during the CPU hotplug callback). A subsequent changeset will set
> the number of cache leaves earlier and the NULL-pointer dereference
> will be observed.

Lemme get this straight: this NULL ptr deref will happen after your changes so
we don't really need this patch in stable and thus no Fixes: tag at all,
right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

