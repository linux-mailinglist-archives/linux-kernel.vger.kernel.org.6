Return-Path: <linux-kernel+bounces-539231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28600A4A245
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0451F189A291
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0630B277033;
	Fri, 28 Feb 2025 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jHaLIwOg"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E3277001
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769074; cv=none; b=IUk5bQMGU9o2Mk4+wqdL/UrBfMSy/CwFMvOwh2HEd+bLSjj3q/r6UFnByxsV9yVw22ru6k6J+CJRtVartNcT1068n1rvLI5wIVsoPCwZ8PJ8VibHaktGN3kozUQjQF53SHfO055P9yMuDHGCJ5TT/HQX5i4uZIsCNFMhinnaEdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769074; c=relaxed/simple;
	bh=bQQb9xG2Jc7tIQR73xhk2PUE68AVu1xPv1psSe8l9A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iueIkYl8LjaK/fS/VZXYKP10w4gmBqDaQfJlA7drG2O7q+vW7r/biOsufBu5l5A1HKsZSRhT+Zh59ozm8Kt8jXhL8IMeTSrob6qhe+lcLresCEEQqmLpMRxSkB8LLU+iXRcQXL7kOXQm8lrfv3peXpzeIr5mRyw3fV0pC/fZm40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jHaLIwOg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8E5CD40E019C;
	Fri, 28 Feb 2025 18:57:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id roGHl8cJet9Y; Fri, 28 Feb 2025 18:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740769065; bh=pXVDuBMKpUtgMtGyRbUlZRZSsfyLj/5MpDTqbtNqe24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHaLIwOg2LgCMZembJa0+82tNeEx37kUF7jjud3rWlc4ye4U7drSCXH9vV9M12k/Q
	 DGuQgr/06sQKRqbktx9hYUkSB5eAbUd0qTW6gQcDcSvvJ7mkpHFAqRzehU7uw6z/YG
	 SPib/TsqiU8kxoHLBKfd+qiuv1nzR0v8H6WK77Oi3JFIN5FTc54/Hru/62SIemnIX4
	 wUFpkjrhoPjz8dAC5Hzx/KjLckgHSwm59Jna6e/yLV+CCZQbQrQbSV1GA9+t33Xx9L
	 4rATTS3gNih/PatrXm/yYzBsL0S7XzQEeNhIQGwQUHR6AB8C0cbG39KbaAtQcBfXA4
	 Si1ZQaIO5NPnP+q3hm0XpdIPRHpzMoTvNOg2BeR/UhbxpiP2G0Qo9S+dGzGUxAUmMU
	 NCQXaSJo21fX42G2UmCOf36Z4c1jKnv2NAZqOjOpu+A2kmyJfTzHUCnCAvg9/TnYfN
	 o4XwPt1imtAjXloI+SUOhnJDmWF+qkKx12GCOsqsfZKOGhdma6rlWG6IxXRjpJmfb/
	 bMHDRDZZ7nfjmNL8LOUb1PsCIqQqEHCNf3a5x8K2GJOHGHkFr84rxb8RfJXZ8m56ap
	 OFJ1K9CdTL1BDqbmU0IffB2JCHTR2Rzpql7+e8GX6E/Wb0kHCunpr4h+/SxURrei9X
	 epvBl1Lm2lGfYJK1G4en36wo=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 770FF40E0173;
	Fri, 28 Feb 2025 18:57:28 +0000 (UTC)
Date: Fri, 28 Feb 2025 19:57:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v14 06/13] x86/mm: use broadcast TLB flushing for page
 reclaim TLB flushing
Message-ID: <20250228185721.GFZ8IHEap-MWvwswsu@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-7-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226030129.530345-7-riel@surriel.com>

On Tue, Feb 25, 2025 at 10:00:41PM -0500, Rik van Riel wrote:
> In the page reclaim code, we only track the CPU(s) where the TLB needs
> to be flushed, rather than all the individual mappings that may be getting
> invalidated.
> 
> Use broadcast TLB flushing when that is available.
> 
> This is a temporary hack to ensure that the PCID context for
> tasks in the next patch gets properly flushed from the page
> reclaim code, because the IPI based flushing in arch_tlbbatch_flush
> only flushes the currently loaded TLB context on each CPU.

Ok, why am I bothering to review stuff again if you're going to ignore it?

https://lore.kernel.org/r/20250224132711.GHZ7xzr0vdhva3-TvK@fat_crate.local

Please go through all review feedback to v13 and incorporate it properly.

It is not nice to ignore review feedback: you either agree and you incorporate
it or you don't and you explain why.

But ignoring it silently is very unfriendly. :-(

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

