Return-Path: <linux-kernel+bounces-545367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9EFA4EC19
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083451893F97
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0F62803E3;
	Tue,  4 Mar 2025 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fjNHbC55"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246AB27EC9C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113119; cv=pass; b=sgvFUx0qFdCiwu10fOqmr8c1ABMpBmWtnx8EANYhlDgYZZ6WNXaYPoIaeMPBsaklvnE/Iv72uB8hKgqeAPiRtQ1zBIkPXjXkuLTiqghVpt6whz0YQRioT0Rw8psuHfaUEi7Zj8ZTTb7uYSTocWUmXe1SlVWpIXp72bjwEDYRKVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113119; c=relaxed/simple;
	bh=wEzFHzy1glZBw2Z/RrNH8Ihb0OTydiGM9PFVnr1OsS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osPM3Wi7hNu5Je45DZl3doI2r1kS3g/xF9h+vRZlaFNG50yCSZXc9k5z5wnsNJPk49KwodbG1flynB13IEy1s8k9M+9TqIZryZPp+vkBlMIq7nqydPGLVoKXvIGraok1sJzokZzW9FUW04HjBvhpE7EBssqTkfVAE1nTXziLk/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fjNHbC55; arc=none smtp.client-ip=65.109.113.108; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 5556140CFBBE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:31:56 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=fjNHbC55
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g3V0ZBrzG13n
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:44:38 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id AA7DB4274E; Tue,  4 Mar 2025 18:44:28 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fjNHbC55
X-Envelope-From: <linux-kernel+bounces-541809-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fjNHbC55
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 8EC2D41C96
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:30:18 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 69FDB2DCE1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:30:18 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED9B188BFF3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718B2212D69;
	Mon,  3 Mar 2025 13:29:56 +0000 (UTC)
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303124214.GDZ8Wjpn7l4bOy8LYI@fat_crate.local>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g3V0ZBrzG13n
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741717801.73843@1nkqFiyw6PeDh26tNuC+Cg
X-ITU-MailScanner-SpamCheck: not spam

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


