Return-Path: <linux-kernel+bounces-379907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C989AE5B6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA092B2566D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36B41D966F;
	Thu, 24 Oct 2024 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fub+cmzS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD011D966E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775244; cv=none; b=SSJ3Ai3KU8WcJb0kVgE0JDSPw7bDeKUFZk0hgeKxAzOCV+baftvfGBVy9mXcoMZuxfpCVZaC+8kL6tLlZ9UNvjGQ5ykwdLkZ+/hXeEkw65C10uRqabto2VshEkdEKms5JgQcGdL8S2U8lFFuN4HM8VRN5yuQCrBxtk3oKAevwe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775244; c=relaxed/simple;
	bh=hxnIEQF4yjjUNm7RNGCdPIAj/9PoOLc7jVR0R64HFPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smh/Hg64J4rLfLwWAC0+KUu7JhfCG78IQ8fvp730JGkT+NO1fRvyH0oZAchKQWCRnSjxXEJg+Hj2QYI3PnXwxaH0fs4AKxMWlK6sCi3U2G8O89T/uYEU9zSK1nBA0j+gnOWErHFwM3Hh4/WGK+QKbXSaGa/pEPQOt9zTuz0ehfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fub+cmzS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B025440E0285;
	Thu, 24 Oct 2024 13:07:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IXrtsMOI2Tod; Thu, 24 Oct 2024 13:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729775235; bh=yFYBy1zcl28tkPHzA0++7D+fuf7997rmxWtFo6WTLzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fub+cmzS1d6zXD9M0PEPUVVYw03DrTSyKwz/YYubEM2y6cHXkognV67/YJW7T2IAi
	 LQCervdzsHxOJdzPmQzqWmv143Dnk/O0woZAQLNbqQOB8sbwY6Mbgf0fkUgOxeN2H3
	 1iXB40T3qQ19sU5z10xrd3NWYUjQcqIlvNGN2aT7BpT3HCoh8r3g7VZRSD/rZaT0rA
	 NQK7K4iNeESILKab5Kk+wd+c6PggGfnoQg9MstFxLCix7p3+L7VK5q+Q++YN9b3a9T
	 dLsS4i1lvZFs8zXPgv2RDGJ2/0id3Z7a2FwDOfRtEhFvx1a+hoApZTCVLmK1IyzAiw
	 yBi2vYZkQfgMHW9vO6h5ODe6LmOjWs70ugI3fT97JiUON4A1bXqQ8CVhuY/OljrlX6
	 bhxbMuL4q78CyuHCMsSzIoq11ugNAJZN29YG4irdDh8BR2HglUKeyVYSZnHvXt/2Tb
	 OG4pZ8JCgYEcwH1gpwVdG0m+R6DzUggw0CSTiS8QTiAeWgPEKXO0OclPxriQPe0PP1
	 wfhzrwP4KYak3WEge0ogXR3N2DTasRA5OuoW4VUr2S2BYVI9Ky/leGhkgI/0Bqlwl4
	 GM74yaLzxer4VEjFQySVda4bNQRwpZjSLYmHDgnmVxpJne04i/nyVuc2dWzpElMmXt
	 JjJnle8H2+9IeQzyaTE6mf0g=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6629C40E0284;
	Thu, 24 Oct 2024 13:07:05 +0000 (UTC)
Date: Thu, 24 Oct 2024 15:07:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/34] x86/bugs: Relocate mds/taa/mmio/rfds defines
Message-ID: <20241024130704.GLZxpGePxPP_bvju0o@fat_crate.local>
References: <20240912190857.235849-1-david.kaplan@amd.com>
 <20240912190857.235849-2-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912190857.235849-2-david.kaplan@amd.com>

On Thu, Sep 12, 2024 at 02:08:24PM -0500, David Kaplan wrote:
> Move the mds, taa, mmio, and rfds mitigation enums earlier in the file
> to prepare for restructuring of these mitigations as they are all
> inter-related.

Add here

"No functional changes."

to denote that the patch is solely doing code movement.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

