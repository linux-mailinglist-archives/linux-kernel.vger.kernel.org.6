Return-Path: <linux-kernel+bounces-401582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B312D9C1C86
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF123B23A40
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E4A1E47A8;
	Fri,  8 Nov 2024 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TiYOH3B1"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB501BD9D1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067138; cv=none; b=i+vu2NVdZm97Lo0lS8UVqwN9Rl97zbOTWlpLnkgkcVIPq3OZhJYljn1q80Ux57R3iBc8WcSELGzsAIt9dj4v5Ub3j1woNJriUKmGJMx80E/ctTERz/KdKJ3MxVmhJdZU4IlfuXVbfEcQJbCXkq/YluvFU8wrDqhcz7nkGd9Q940=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067138; c=relaxed/simple;
	bh=cwgsaJajxt5+m6tI7PtMCX0EK0Em5P4cxRyEI8HX3do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB+TdbIsN5GwQuiQPRqdPdt4PZ/IwajG8jmEfghMMDbcaS9zsm3yyb1netjGaJBCZgDHa4OORZiJNS6xlCivf7Uh7vhRA8db7pUoyMq3QzBin/UqEFbaLusdUGLTS09PnI8lNYpNi7raErMme8mNdoDVqWUhPliva+dV6dNrQ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TiYOH3B1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6B4BC40E0220;
	Fri,  8 Nov 2024 11:58:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XTQPbOCGZXeh; Fri,  8 Nov 2024 11:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731067129; bh=T8mwdP4fg3UOt17jMQ568IPqHu6VUYZ3Jw3fpUICMR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TiYOH3B1yMqtYWlsErslizpPCH+eWauVDBszUhIzKcspF/lB4Gtgo+RcVL+D+Beos
	 enKvxy/bVU6BCqYkbuHxPreDzJSXTV2Bd6sye/OqJMHPEIF1QKSg07gaTzhiyq45Cy
	 0Gqg6gaHwXEby8uYTu407Fy/qAzHpdPVkjwX/z/2sU95Z9iLdGtTY96fDvsAYzpgFL
	 eVEyGb9YA9NicPBvp8N9gRo8tOqpjJR3ohRr+pZwqSoJ/St33F0hALY0Fd43LDnYQO
	 6M3CB8nrg0W/Yi+xC8sXRfP8Yc9X2YcuWh+qsyipifzsWnb38/6H3m48gKZdQaBfdB
	 v1CJzN8Ft9PVz+KcuyuxtGZ7i/l1AKFnMBkgiU+rkOpHig0j7hW2F2imDNvByKBX7U
	 MmVdOxmdtSTCh8+z7uY+jpNLExypNtZtHTpry6XogC4k6hjKKDuBMaPUYmRkzESBDA
	 l8l/6+p2HHGLjX2BoGRlZ2mNCUBHEOuv/laS2TyQKw/efK89RJAoGy9kNKxUPChCRM
	 f3g/9MvGTPzsuTzxaYOH0x3OmDGQ3UEf674ftKbRTfYUOwpAcVE0Z8Wx3/TrXpq76F
	 JL843q2Nkv0FE2Pw+L6xPq7Op0W5liXwW0LT8/SJVriJNLTr2se+14KdJZWA2fdUqQ
	 bY5Y1LNBNIUxhCYTnB7L7yBo=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E1A3F40E0191;
	Fri,  8 Nov 2024 11:58:30 +0000 (UTC)
Date: Fri, 8 Nov 2024 12:58:25 +0100
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
Subject: Re: [PATCH v7 2/3] x86/cacheinfo: Delete global num_cache_leaves
Message-ID: <20241108115825.GAZy384e9IEr7DWvaJ@fat_crate.local>
References: <20240913083155.9783-1-ricardo.neri-calderon@linux.intel.com>
 <20240913083155.9783-3-ricardo.neri-calderon@linux.intel.com>
 <20241022132050.GHZxemsmJSLg8Q_7U7@fat_crate.local>
 <20241023035022.GA2484@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023035022.GA2484@ranerica-svr.sc.intel.com>

On Tue, Oct 22, 2024 at 08:50:22PM -0700, Ricardo Neri wrote:
> I agree. Another wrapper is not needed. I did not use cache_leaves() because
> it was internal to drivers/base/cacheinfo.c I can convert it to a function
> and expose it in include/linux/cacheinfo.h. I can rename it as
> get_cacheinfo_leaves(unsigned int cpu).
> 
> Would that make sense?

I think you should use get_cpu_cacheinfo() everywhere and simply access the
struct members like ->num_leaves where you need it. No need for a bunch of
other silly one-liners.

> The only caller of init_cache_level() also checks for !cache_leaves(cpu). I
> saw no need to repeat the check here.
> 
> Also, I understand that the purpose of the function is to initialize
> cpu_cacheinfo::num_levels, which is not used on x86. Moreover,
> cpu_cacheinfo::num_levels do not depend on num_leaves.
> 
> Having said that, I see other architectures initializing both num_levels
> and num_leaves in this function.
> 
> Adding this check probably makes the x86 implementation more future-proof
> in case callers change their behavior.

But you're practically zapping its body in the next patch. So why does patch
3 even exist as a separate patch instead of being part of patch 2?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

