Return-Path: <linux-kernel+bounces-434976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59C09E6DCF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689221606F6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B747200B90;
	Fri,  6 Dec 2024 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ie46qGFS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD15E1FF7A1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486948; cv=none; b=j1IeLRdYwYddJ92ekOEWjOBs4nXgBnP6lr2gtFLqSgF2s2UpZ8cmXJhxhg/ELo7Fucr9pnDKi7YMhUVHVM2zx9LsszcoFieb8Lna/Px3j0X/G3uHW7j5w3l07h8v5cggipsjQ9oV4vgOyKo1NpcihntlufcmqgoOXVEhlC9G/hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486948; c=relaxed/simple;
	bh=kh8JQkIWkIL2KD1SDmEkrpvJEvBz7RUlLDk3IN1G15w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HP0nsZTYblHH1tyDLQFDVj+Vs0/av1If34MDSK1SI9AsxzMbITeTIyw/PTg0Bmf7lzu0OMHZJDyXoCkC2ao149hIiK/z7Jz/qw8xOGvPW57i2qZbMefMC4gAkG7urKLfxE3eb+nagvAPwlyy8zaO7MZFxkQWlxNgi+L3yTnL7Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ie46qGFS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0A9A040E0269;
	Fri,  6 Dec 2024 12:09:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id C6JTdnx4UORr; Fri,  6 Dec 2024 12:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733486938; bh=mys18o8HdONE1BA5qacGKxzs8AnUjtfh/SB2sjv080M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ie46qGFSGcXuCO9kWOMq5HMA/ULFWz0cHANAfizqMK9f8qCnJ1gXnvXOs616//Uzn
	 6TNM+KBk6OBPiAZHMs2jMoUJ86WOAuFlnlFNWXN37XBqNCB2GACVjkPRlCRnUy+wc4
	 Lr6S8iisMECpA/xVy3wgsYffNJnMaAtxks2t/ljefrsCUT1bFSi6m9nflhInhzjs5p
	 Sme8DhPqNdbvVjOK4vH6HqOBVLLUk6asfqLDQf839vXWXr/7xCxk4Jt5ZiB84RzZM6
	 0+vzOjDjsk/i2nkPMaSEiDHfaxIm10OCcnFpQXEYs9MZQUZcP6ZAecDtUQynhLlhTW
	 xKLz7O9DS+xdzQgMnQRxxA9dCVjaBIJGi0EopVijYdNxXI/vHL+M9/BrEoVFi4FI6J
	 pCE2WAdmbhcRBXEilUXXM845l8wVphjgtvmsfZyJlsZV+aBeUA7QerUyFoaENq3m9b
	 BkQMsqrWTpOU4s//uk5YZvkTPNGtoOlAdiNc1SANloymQT0jn0iz0pdMPlaNMWt3Mw
	 nCDokt9PkAM8Uqeoeqibp6zfyEb1VbB3bvSpk5/xKVxhdRSQa9Z5NC4rtLWUMDC8pE
	 Kxao3iVKM1YzYtyXL39b38AHFYYiE08knGs2Xz3L10wKRziLwKIxlVP3IaAJ6ZDQHq
	 dtQxSM5lkL/nm2Ef5I6pKYtA=
Received: from zn.tnic (p200300EA971f939C329c23FffEa6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:939c:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E38B640E0287;
	Fri,  6 Dec 2024 12:08:39 +0000 (UTC)
Date: Fri, 6 Dec 2024 13:08:32 +0100
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
Message-ID: <20241206120832.GAZ1LpQONAo-YHE7-C@fat_crate.local>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
 <20241128002247.26726-3-ricardo.neri-calderon@linux.intel.com>
 <20241204143206.GAZ1Bn5jsTCvI_1ci0@fat_crate.local>
 <20241204163911.GA31633@ranerica-svr.sc.intel.com>
 <20241204193205.GBZ1CuNX-6hIDibZam@fat_crate.local>
 <20241204222238.GA31904@ranerica-svr.sc.intel.com>
 <20241205151445.GAZ1HDZYWWRUFvuVBA@fat_crate.local>
 <20241206014729.GA1505@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241206014729.GA1505@ranerica-svr.sc.intel.com>

On Thu, Dec 05, 2024 at 05:47:29PM -0800, Ricardo Neri wrote:
> I tested this branch on Alder Lake, Meteor Lake, Sapphire Rapids,
> Broadwell server, Granite Rapids, Icelake server, Sierra Forest, and Rome.
> /sys/devices/system/cpu/cpu*/cache is populated correctly.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

