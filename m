Return-Path: <linux-kernel+bounces-387159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7019B4CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C29CBB227CE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F0BEEC5;
	Tue, 29 Oct 2024 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="g15wgTdD"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E9BA50;
	Tue, 29 Oct 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214075; cv=none; b=WGMGH1Bb1IkkEj9R64XYzhohi4fsyQDFvZFqwKv94Mr38HcsLEvDe5OC0b1nxKRaZ9rjp8m87h33F39gwg8vSFdhOdegJde9mX1pQsktM9D1foUFftW1JshfLoJy4gIMpbNs9G6h5Yy9Xkw0bxvCN2d+1NwHv2SVHO18s45xDg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214075; c=relaxed/simple;
	bh=5V7TnhjLSxuQ4wNJlJDE3n0MdEfDCaLHH/wxrUBQ7Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKSqEUQ0N2CZAIQ/7L1CAFIDZgi6CNQf72X+rZvBaJrwMxMN56Bebfx/mgmNzbU013Z88jCnlWmTnGs8qEMD5x5Nvblz0qDv7VZm0IjLRykYlb32rqPY6Dbn99XX3f23AEVK5ZOLcD4B7qZp8fKSBcfFXari/dorD8VTtwGlH3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=g15wgTdD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9EA0E40E0198;
	Tue, 29 Oct 2024 15:01:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QlJVClWK1fkm; Tue, 29 Oct 2024 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730214056; bh=KOpQcw9nRB9EeS0gpi3ZtVgUYbOH/D9pZeyW+FzZPBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g15wgTdDZFYgcBpLRk56xoJhOtQsQMZuYz6uwo+OYrIWpod6c92RsQQs1ezsoQfaZ
	 9Q66CSZcIy3uixamWVSoF3QyXgESBy5v2IKvNGPjtTMpiD1ChQRlrI9S2aP7owP3p+
	 0QD0/2psOtaoAtlDTC7CsRIpPHrdsO51N0eTh2Vo6uEn0LtKAlLjrncTKzg0Od+BL9
	 2Hir7MMPd/2InRnQ9momIaPq6u6RawLDjvvLOIO9aTIdDPiESPC9CoXK4U6G/lkKMV
	 w7qo5g1tvHP9OTzjMRZetxLO5qSq0ztRCR3pOM17sMaKO6FLswpojrym00Rn9637NH
	 rbouFtGHpsx6u5fWlKC0/udE+jCnNUU6VLoJ9fUDVzfvPqxF7gNU/hYPERq2aIs2my
	 dUrvecH9bDY2g5G+ttJTMzFfBIpE+4HNfTPhNdBNM+Z5eTcVl0coVL0X7WFKgLAVFJ
	 82fm7kNVDJe5SOaShvXGhZJCd4EpShwep1VjYgC8e+VV+7CxPp0hBKamIYXuYpBedj
	 5/brviA5TLCsV33V0XoeHxYdxega511D7MVsg5YC7dl3GAbiq7mmxIttVnXeiq/pyT
	 biG0D54sEEXuQoU2bzb/N60POjVZT6U03mlINOYmA6Ne3j4WkRTmpNCzE8IFx6Ugml
	 Rl40Ot9W5qzs3SaMd2atA9Yc=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A076940E0284;
	Tue, 29 Oct 2024 15:00:43 +0000 (UTC)
Date: Tue, 29 Oct 2024 16:00:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	David Kaplan <David.Kaplan@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	hpa@zytor.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, pawan.kumar.gupta@linux.intel.com
Subject: Re: [PATCH 2/2] x86/bugs: Clean-up verw mitigations
Message-ID: <20241029150022.GJZyD4ht9wYcVetdDS@fat_crate.local>
References: <cover.1730158506.git.daniel.sneddon@linux.intel.com>
 <20992658d2c79f27de91a474a7b122782be5f04b.1730158506.git.daniel.sneddon@linux.intel.com>
 <20241029113702.GUZyDI3u_6IxiCWOBJ@fat_crate.local>
 <c5fa82d7-e5e9-4612-a238-3c58152c40d0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5fa82d7-e5e9-4612-a238-3c58152c40d0@linux.intel.com>

On Tue, Oct 29, 2024 at 07:40:28AM -0700, Daniel Sneddon wrote:
> Sure, I'll split this up as much as possible.

Actually, thinking about this more and looking at David's rework:

https://lore.kernel.org/r/20240912190857.235849-1-david.kaplan@amd.com

his basically is achieving what you're doing - a post-everything routine which
selects the final mitigation strategy once all the mitigation options have
been parsed and evaluated.

So I'm wondering if we should simply take his directly...

He removes that md_clear* function:

https://lore.kernel.org/r/20240912190857.235849-8-david.kaplan@amd.com

in favor of doing the final selection in the ->apply* functions and keeping
each mitigation functions simple.

Yours does this in a single function.

Practically speaking, the end result is the same.

Hmm...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

