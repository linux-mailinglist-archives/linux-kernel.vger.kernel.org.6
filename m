Return-Path: <linux-kernel+bounces-541809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BB3A4C1E2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC5816F6F8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB54B2116F3;
	Mon,  3 Mar 2025 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fjNHbC55"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142CB78F32
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008593; cv=none; b=H+Qe+97Eem8gPGQ/YyZy4pg/2+9XxdzbG/wbrUpqH4+dOyWO9CJNt09BRkPwf1U41T47R7knh1NZTq6lA3loTinHUqaECC+bM9sPTeRg/iNY0C13t7AebTkfbK7lE4fTk0NquEol362aoPgvw3lgrtCzVQy1kdp9AKcaRV7FksA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008593; c=relaxed/simple;
	bh=wEzFHzy1glZBw2Z/RrNH8Ihb0OTydiGM9PFVnr1OsS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sn0fLt1N5YVGBwwJMGw+O93mVeVXlZG5ExG5L/jUQKac4NPrLZdR6tZs42vE4sUDZ+o4T34NpbR/Uq0SVB9E1q+g85N4p7hpWueR+Ta8DS5z6JE4UFEG+s7bT43eGRaXmQCNi+30gJkMY5pcHI/PKQnnCnyKOc+f9mlR+l8KBOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fjNHbC55; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AB96040E01D1;
	Mon,  3 Mar 2025 13:29:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YfO9NUWfSbnz; Mon,  3 Mar 2025 13:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741008584; bh=5ZM1dOgoW1JHSGK4Mmwvg8eKmcKpPSwvQ1JwXK6NGeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fjNHbC55QcEkE65WxVH4jKBYF1ehLhXCXxAfYjv67JcZ6lKjxjVwQRdnpK9YtJCvI
	 y8vTM0ittBdvtCQEHVtFDxNpay7NtkTaMW1E2SWka79aiIrUkboA0WKGYUtYam6xWy
	 piTmQ2Aw0OSfwSKDMqvHkDeM/FRsTcHX6TSTZqhET67k7EMLnyRp3XFuJCLZmj4b2s
	 +VHpNExGz3MCg2YSQx/GNoqI7lcav3zmqkZ3eI8vWLiV7ps3qqK/2Ey7dLkrDgxZYa
	 l3wvawb9iASawnnlpMal5LR6dh6KjBTSecMVCQqlEp1Mq8PJywDDnSNZcLqSdIkRvg
	 1MYBCjzEpbDzSIUYu59GEX+II8TDTG1QNb4Twh+qqWziacdljtYX6n6oSBjLyj9eVY
	 un7InXbJneMSQY1x7THa6PI6AyytiLvQcJBv0fGPS1MigqHfASVJOx6UKvBxvBukK3
	 Xq3GahxU0y3BGF9DOttNB+py++4S1Hhe4xsoajJfyFBacuS6G/PKJ6sKNCBbkg+sEh
	 k9QW7NntpFfcPDFqIHc6L2rOzwwdah+jJq12EXAZs6GW9/6p9kcMSPzYaagYPxNmmT
	 Z9CuRaVW44JRtyHtYPyJyRdtF9koijGRnRxl+PHTxYW3cDKsCOfbn2/1UuYZwesup9
	 YfOEfKe0AVzr88XDLiOxW2k4=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 757AC40E0214;
	Mon,  3 Mar 2025 13:29:27 +0000 (UTC)
Date: Mon, 3 Mar 2025 14:29:26 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v14 00/13] AMD broadcast TLB invalidation
Message-ID: <20250303132926.GFZ8WutnF7GXcUjPoB@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250303124214.GDZ8Wjpn7l4bOy8LYI@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303124214.GDZ8Wjpn7l4bOy8LYI@fat_crate.local>

On Mon, Mar 03, 2025 at 01:42:14PM +0100, Borislav Petkov wrote:
> On Tue, Feb 25, 2025 at 10:00:35PM -0500, Rik van Riel wrote:
> > Add support for broadcast TLB invalidation using AMD's INVLPGB instruction.
> 
> Ok, I've got the whole thing here now:
> 
> https://web.git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-cpu-tlbi
> 
> Lemme take it for a spin on my machines, see whether the cat catches fire...

Well, it boots on Zen3 and 4, laptops and servers - although only server has
the broadcast thing - but all look good.

I guess ship it!

:-)

Srsly, I'll send out the whole set tomorrow to have it on the ML and see
whether people have more opinions.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

