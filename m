Return-Path: <linux-kernel+bounces-512962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FA7A33FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 226137A46D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDA323F414;
	Thu, 13 Feb 2025 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gilxD+2N"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7740523F421
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739451825; cv=none; b=TBvFHc9XBf9gN+Z0qgy80AQObbxLLRqrKBHqgbJkGwLoXfwmZuP7rrg29/TnbUrqlC6TYgIgiL5dAfS6kSs3z7FC3jHCu4ks5PICCk71BFlClz4q5jas9yiqXE7ErD6F7ZpU1omOq1cMZ71/gGxIzyLXuOJjAMyq1iFwDSGesO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739451825; c=relaxed/simple;
	bh=YBujJtdVAbQwX/i31dVVrAgv+iZd7oY+ALf0PWoL+rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZcygK8F9UcJ2ss06gqJhgiS6N1UCQvLrfrnedHJwD67YT5Gd63gIxM6vSimgWWwf08UbkyS5ttpNzeoDPR7zU/jb9d95D6vY3raTJWc79R3xLn4V4DAb5gvxYv7z6+QNRfTN305tvbEHjQPnuwMQmqO2A3rSWSHgoVGMVuCNeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gilxD+2N; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E8E7840E0184;
	Thu, 13 Feb 2025 13:03:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1uI8pMxjy8rk; Thu, 13 Feb 2025 13:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739451806; bh=p7U5fpaXzy7aPH0eVZosSY1ljTgN/VL+7617IAc0fbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gilxD+2NXMqYvrBaE+92gOngNygML2PTJNovultw18cJHm6+d8lQt1Xp5JuetjwYy
	 OeAO6K3fghVKITGhmBRuvhKzCIBd2c0ZaaSg7CTXoS8qyv6ldaNMGxLiTJOwKq6Mw6
	 JT0XcfDi1vxIrlNLDe0Gzt53j5Dlu4Sc/HvIXl07mCELeWLjXDFR+3CeP9UKY1hXSb
	 THV+4kKAdwYOj5FCd4T4MZq2WKgg8Sba4yqbF+WoAfQHWxAdBb8A4/HhUN1fAtBHfx
	 WSf/mTVMnLaCR44zOAVq2f4D5QDUbA7/XwQBloNNWegzDvkTIHC0eouh06aVwqHevr
	 PSJQqnxXcvlsdYeO41G93R7kAKxE+EuQtquWXMJ2/LCXKspVcjdyJ3LLRHi+R/Z8gq
	 YU8omQ3aDO8gzAoa45HyFIj7wzVl/oY0+SJeHqKzDSXT1L0cnyYlVAKHIYuX+DGo2z
	 1xpNQiitoBp36FzCXX/ZYVWfEdFWhwLW6HTydDTH16CoTchqcsEbnqOCDQFbIbVFVP
	 Hq0/J7w4h02sEpi2d5zhlaB4+k0xaTR7aa9eRIeK6INKgYZODoBXblIh0bp1RBF/Aq
	 Fv0aX6vJnSu0ZOSiU2m3S8/du51jqoTafpl6YEtqoM9QiFnPLEYORlpgXMpwRc8ehc
	 p/ziAMSrp/iV+AjshwN4T+Gs=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 082A640E015D;
	Thu, 13 Feb 2025 13:03:10 +0000 (UTC)
Date: Thu, 13 Feb 2025 14:03:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
	zhengqi.arch@bytedance.com, nadav.amit@gmail.com,
	thomas.lendacky@amd.com, kernel-team@meta.com, linux-mm@kvack.org,
	akpm@linux-foundation.org, jannh@google.com, mhklinux@outlook.com,
	andrew.cooper3@citrix.com
Subject: Re: [PATCH v10 00/12] AMD broadcast TLB invalidation
Message-ID: <20250213130304.GAZ63tiJziORlbYhht@fat_crate.local>
References: <20250211210823.242681-1-riel@surriel.com>
 <20250212102349.GE19118@noisy.programming.kicks-ass.net>
 <CA+i-1C0Sbgkyfan=srXL8dRrqaLoT1g1F5tZesC1rrh6v7L68w@mail.gmail.com>
 <20250212105945.GG19118@noisy.programming.kicks-ass.net>
 <7288e28d6ada409b1b7dd6e9abea77b596bacf3c.camel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7288e28d6ada409b1b7dd6e9abea77b596bacf3c.camel@surriel.com>

On Wed, Feb 12, 2025 at 10:39:30AM -0500, Rik van Riel wrote:
> Let me rebase these against current tip/x86/mm
> and apply the latest suggested cleanups!

Please use tip/master - this is and has always been the branch tip patches
should be applied on.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

