Return-Path: <linux-kernel+bounces-438329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF6D9E9FCD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CBD118861C1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9A1198A07;
	Mon,  9 Dec 2024 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YUos6xh8"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB5D15853B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733773425; cv=none; b=M30xRdFKQGcILslDwkK+0ew89hNlmxb+njn+VAmC61xKpIh4GuuEXdnlPl/LjUdr2du7tsZf2DVHh1GxUuiJd0XNc6HjylED+ZMkgqCwHB0DuhM5NlwR3n0N1iYgnWLQXb4LLowkf770biUAu6AO5FZIHUm+h4S5hJlExXevz2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733773425; c=relaxed/simple;
	bh=5cske+h1cwz4/u74zkYKedrFpT+WEKmqbX/AiAELYfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAW1ZeZ6K8+/oE8hzyVQ7XAuGCts7ZqfQVdH9SsgEIDdgrrb6MYqIyUJsl2CcFuJoGQuNQ24GvjH6gkgiHdfdEg4asI3km1zJ6Ky/za/n7ApVnROAA6ToaknbSzUV2PgsWraiEfxoYccVZd8eJpBE1cmF9g6lO29fENxgd2FgBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YUos6xh8; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 452BE40E019C;
	Mon,  9 Dec 2024 19:43:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sECcoUH-ySmI; Mon,  9 Dec 2024 19:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733773417; bh=0OCqH7uQhN2YE4e6oR3q/aP4Snqf341796Sry+Byy4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUos6xh8GMVfcRkRdhn84L4phP5O3JYkIK0bZAqsb/k/rwT+W40ux21cWhiYZg73O
	 0rHy2ehNDOCA2sTgKniooH+17T8s00x6N3R9q3m64d6U8DGtbSBZv+xg5JsX7RuxMV
	 tLGN9m7nsqDVDMssURIJy2AqCccIKXkAA8CvGi3GM1dt1zztrDqPOws1LA1IB6XipT
	 zdcBHNOJKqxcv62HDu7mP+GwMCr1LJiPVWBNcWGF0zVJEh14lrELzcx4U3X0jjbLzL
	 puvx/zkUXR+eHJIWqwWhp9KoGiinyGgYHpzn+uc2njJCzQff3fqEad2mVF+FZo1Onq
	 fjUyjAQpBPAUI1w9RuNQ+jd7vlQ8vgN5ugAJjRy3n1S6ersl/2RUEgotDdxuXf6kW5
	 eg44UyfRfx8cRXMbBeRF7UlS4/jf/cDs28AnIHZ//514TuBdZOgVHT1+ZxgbmCf+Ua
	 25clmsFUIeL6BLi17GP1C7s6akChiMFkwuWbyjfT5KAOYWQw7lzD/OLOJW0s687JSh
	 G7w3T2nBwemrbI1d0yWnKgp/bD9UVmxAbkwlR2xCNYgQ3eURsXBbGXVBDWdMM8XXzQ
	 /z6wK90x7NT3odwXE5ZxrcIqpU4u9VliQFRmQluutCS8zSJWJpknuIpNUx7rVVqSGP
	 2NHxgfl/i3xJUIUTEE1c0g9g=
Received: from zn.tnic (p200300Ea971f9307329C23fFfea6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9307:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 229C240E015E;
	Mon,  9 Dec 2024 19:43:27 +0000 (UTC)
Date: Mon, 9 Dec 2024 20:43:20 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH v6 6/8] x86/sev: Treat the contiguous RMP table as a
 single RMP segment
Message-ID: <20241209194320.GCZ1dIWDMPppdXgzxJ@fat_crate.local>
References: <cover.1733172653.git.thomas.lendacky@amd.com>
 <8c40fbc9c5217f0d79b37cf861eff03ab0330bef.1733172653.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c40fbc9c5217f0d79b37cf861eff03ab0330bef.1733172653.git.thomas.lendacky@amd.com>

On Mon, Dec 02, 2024 at 02:50:51PM -0600, Tom Lendacky wrote:
>  static struct rmpentry_raw *get_raw_rmpentry(u64 pfn)
>  {
> -	if (!rmptable)
> +	u64 paddr, rst_index, segment_index;
> +	struct rmp_segment_desc *desc;
> +
> +	if (!rmp_segment_table)
>  		return ERR_PTR(-ENODEV);
>  
> -	if (unlikely(pfn > rmptable_max_pfn))
> +	paddr = pfn << PAGE_SHIFT;
> +
> +	rst_index = RST_ENTRY_INDEX(paddr);
> +	if (unlikely(rst_index >= rst_max_index))
> +		return ERR_PTR(-EFAULT);
> +	rst_index = array_index_nospec(rst_index, rst_max_index);

I think we should collect the deliberation why we're doing this nospec stuff
from here:

https://lore.kernel.org/r/79be2e29-6487-dd60-9b6f-3daa48a2e93f@amd.com

into a comment around here for future reference.

This is the best example for those: "uff, why did we do it back then"?
questions when we stare at this months, years from now.


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

