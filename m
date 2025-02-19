Return-Path: <linux-kernel+bounces-522205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F47A3C752
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78AC2188DA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7A3214A6E;
	Wed, 19 Feb 2025 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FSh8FygM"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC11FCFD2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989427; cv=none; b=DYhQ0DyxG4GFJ+WUirlnyHEeSJ2hoFNmgCbMaKTv7yzc1zzF32+3/ANbEaGWuqdfxyu45/ckyx9P6MlorxiW5rUvjwGC5kaFMI9QQKjkCW78winKnJgVjvaR8+pjsonhl1hzm6salKpSRwjH1dU24dh8DN3d27A1uaSjp90bzso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989427; c=relaxed/simple;
	bh=F3QQLn5iHEqa61zNY6HqpiLPzAagm6AWvPWfS3ckb3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvnLUkO7iosLCTcv003bTUNC9rSMBTjsM8Q9HfT8vdyQerXzwaayZYqykiElaEi05ZoTIR+TpdBppWl7nOcoEEaYD1PAY4oCPdH3pEoYsOeWXwOx+0SALjjg179YuxdncZ64HbT6iG+18jsLZ5cnCjYKT9mIxNedL0wCi9RiHCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FSh8FygM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D8C8540E015F;
	Wed, 19 Feb 2025 18:23:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id M-9yfGl9isMo; Wed, 19 Feb 2025 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739989419; bh=v0HTPPPJwvOYn4e7z6j0xoj8hH1coAAx24Lf63l4oeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSh8FygMwhSOUfjaGnlTdRKcC6BR/AiyuJB2sUSS5Jf51d7CxQT/TJ+EgfzIQJmVa
	 UeqGLDJ2Ktx3AHls5U/2lHSRB6Z57WgoGMCGJJTfmEIupnOTqZQmrI4TUfM5HjQFEO
	 /ILWWahkfZXx19PADct2AiG0bxIOOdlO180Fz6wPp+MqFtlZ9l92jw75PAErXTTYkR
	 SfxKJw0J0k7fB3jX2yGdzbFLHvmsG4r7pznYn9pxh6qUbPBT23JNjmD0+eRUFefb0e
	 oeb+o/wWTwRBJZpvNOhze42XXWbBGR3dVnPi0OleQy91t+8q5ha94NuG9BodzukeTs
	 Xlsnc1eDMTDTiirky4Dal1Z+phevYuBYpW+StIBrELOAfwzAAyFfWkgH/4o1tO23Ud
	 hlBEXRng82XhOiOI5OI1qxqQzCLuh+FZX0NmLWeiehkujuMPjjGu5hgffG5uwjB4u9
	 YkhLT9CNipXxBNtc73HsHB7W95UfMWdnPiQ5XEgsBqVnZi3ycfYIFeUAu3UAdYJXqm
	 rRm1ioN1PMXTZKi1UGKeXVvLovyNVS1ENkV2X+y+AUgT+qv05CFl/b4c6dsqN2ERX7
	 T4dchjZVbMwaPaxBRxA1D0eSkw3mC3ZOVr9o9nLE2NhbXUCqppt6SkoYAu2qycFvHj
	 odJ/x9ySPL6jopfW4PJ7GHUA=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1AC5840E0176;
	Wed, 19 Feb 2025 18:23:23 +0000 (UTC)
Date: Wed, 19 Feb 2025 19:23:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali Shukla <Manali.Shukla@amd.com>
Subject: Re: [PATCH v11 04/12] x86/mm: get INVLPGB count max from CPUID
Message-ID: <20250219182322.GBZ7YhmoQw13Welm_d@fat_crate.local>
References: <20250213161423.449435-1-riel@surriel.com>
 <20250213161423.449435-5-riel@surriel.com>
 <20250219115626.GMZ7XG6s-5ftg1XLoZ@fat_crate.local>
 <b749384b7dea020880057359d06d4e9172c7aaec.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b749384b7dea020880057359d06d4e9172c7aaec.camel@surriel.com>

On Wed, Feb 19, 2025 at 12:52:56PM -0500, Rik van Riel wrote:
> Should I modify get_cpu_cap() to store
> c->x86_capabilities[CPUID_8000_0008_EDX] ?
> 
> Currently only the EBX data is stored there,
> while invlpgb_count_max comes from EDX.

No, you should simply assign invlpgb_count_max there.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

