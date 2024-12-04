Return-Path: <linux-kernel+bounces-432072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738D79E4627
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BD37B30EE7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B677C1C3C0A;
	Wed,  4 Dec 2024 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eQmLleXg"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E3E18BBB4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733340760; cv=none; b=vEWXqRDMNjRl2P1sJMVuDuaqp2MKiuNX9kEnZVHgpa5BeYveUw7SUQGBOWcU3SSNrzwIqGHLexBUiAsgTBqNQW4N4aMozUaKiC1xVESTuihG+wbL0w5MhFkpif1Ikirdhjqg2oXdRJ4vo9Nfyt0Zj193T1+mhcSSOcJjUhyFzUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733340760; c=relaxed/simple;
	bh=4ImsMshXq70GCs05U4zFpgYi2Y2kGCHA1Yjn3GGf+4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joRjH6QXBl/nyVGmZI9JlATakNzHr1Wdg+Qg6pYSBUGc18lsXdUmzB1cY6t7pG7WOSIQrFrKkkerhgWYZOrtrKSAL0E4h3XPewU6uw3lZECv2E9RWp1+eYoRRtzroH8pVllKq277oCbJXupRCo1068ds/gCWEmjOhUQBggirF6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eQmLleXg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 68FAE40E0269;
	Wed,  4 Dec 2024 19:32:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 60p1bFvwO-N9; Wed,  4 Dec 2024 19:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733340750; bh=ObZMG/8DhCJxzrcSOVq+o1GpLQC/JV0Pczv/SCXoi6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eQmLleXgqbYKySPUTLAt1s7bGPGYhpEwrF33/UtLTHo8kJA+51Twz74jOvwYbltsq
	 PABpV3SpDY0eGQ8mhzA5Zw3bT+Fu8jrLmFLo6prBjUfeqsCnHn91rDqSiSuG/2W/Fq
	 XbM7Iu/AFH8fiGQTtBWxkDA8CXgZfnOky65LDfUhWP3vDccBVenE/hRKdqyJuhb99D
	 t+mkxVv4yUPKPqrC1HI+7jDFnmr0CxIfE3vkMMjMWuSPyEIfZSMBNxktYOwWDX2oo7
	 a1IxBv1cfmGE26KCPKzjt1vRgEgIB3V56GfdrzonjduQ/OWU4yyKA+i9mmb1n/JkE2
	 S3mex4wUlbroZhox2wJUydDoBrGU4UQeKu3GZ4KSvlNrdapfRVpf756AwZdEtFEn/Q
	 8krz6z2xS00EF5RlfYPVgbwlJwdE6HAgFVlxwBqkbsPM/4Cn6cABPJSPyC5jsVj1Kr
	 BJlROPwcq2OgP2aU2K/g6krsqtvY1l60fmBnULTkZ1p30DvfKnjIEUbPCymLdIZCIm
	 q7cOsEq4TY4jG5uArk02x1pLheRtyBOOJqXhIYMr5YN2+MaJWmRqmpm/Po+kFAJ+2r
	 e43Ldyz3Qowe4eALjx0k3JKz5e1coeBRwPi9YyA1NyBfcTsSQ7pEzoZ4YyUE2BOhlU
	 en9su+Itvx4hXv94yb8OKLlQ=
Received: from zn.tnic (p200300EA9736A14b329c23FFFEa6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a14b:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 304B240E0286;
	Wed,  4 Dec 2024 19:32:12 +0000 (UTC)
Date: Wed, 4 Dec 2024 20:32:05 +0100
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
Subject: Re: [PATCH v8 2/2] x86/cacheinfo: Delete global num_cache_leaves
Message-ID: <20241204193205.GBZ1CuNX-6hIDibZam@fat_crate.local>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
 <20241128002247.26726-3-ricardo.neri-calderon@linux.intel.com>
 <20241204143206.GAZ1Bn5jsTCvI_1ci0@fat_crate.local>
 <20241204163911.GA31633@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204163911.GA31633@ranerica-svr.sc.intel.com>

On Wed, Dec 04, 2024 at 08:39:11AM -0800, Ricardo Neri wrote:
> Yes, this looks OK to me and is an improvement.
> 
> I can post a v9 with these changes.

No need - I have everything here. I can give you a branch to test one last
time before I queue.

> I think I can keep the Reviewed-by tags as they were given to Patch 1.

I'll take care of that too.

Just sit tight and wait for a note from me. :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

