Return-Path: <linux-kernel+bounces-520981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C0FA3B207
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A00857A5A29
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175781C1F05;
	Wed, 19 Feb 2025 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qduPPg28"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1BA1B6D0F;
	Wed, 19 Feb 2025 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739949225; cv=none; b=mWfHALtI4PlYo17sDggwkYEHwMOajGpufFI0NaUoJER8b7UyMn1FSQaTzA+5l7Gfmh9GAgQzpJrty/kP/fpFbEw5xLItQKBnh1k5yv+dkMAsr95oifOeo2voXb3qQz2R0iXWxWN7UHQn0l46ZgBrBHGkBXlL2CmVhaNADHoThoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739949225; c=relaxed/simple;
	bh=OOkIIvDjmX+t2iEfuOMs0YPPPkHDOiOCixy3iRv3A8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xnqo2AsGgbLimvXAjLjOOYyhXTiTqOyOWJwyAI7DSMnhaj4WgsHbXaiocSiKIEHuKQScd7VyVB9baFLU6g35+y/n3CgGijgmznL0aaOcsVqbAgcdqJKkQq0JHNkqVpTwaN2j8Lm/qZpYoiD4VSoOMvNwt9LwycjCTkpVi+QXfLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qduPPg28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC035C4CED1;
	Wed, 19 Feb 2025 07:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739949225;
	bh=OOkIIvDjmX+t2iEfuOMs0YPPPkHDOiOCixy3iRv3A8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qduPPg28qy6v/QB2ER32fPvjQoDtpyv930crMRnp0aN8TEE8OmFoqthIOFykZwRUv
	 Pu5NZzJrifM/eee11PWKY563kbOVj9pdGQINPO0kLF/ykiEYMlFp8If0rTc0bF+qMH
	 z4jFYGZUOaph33hZ8GK2cqPKJAyLPh1mo2vjjrA51c1No2p8SQlBkCAgrWnZQda/KS
	 v6D8f2jjdG79HKjq8kSAwlDcO8BzV7Sa2td93q5On4iUy0BIocozKb6VSGbhwKR88x
	 Ia27HNWGMlRKtVxcp2oFAUWuILbF8hDquZj1kRt4RWMWLpZKKmNxCS+wn4F23U8iXo
	 Mew6Mqit71sDA==
Date: Wed, 19 Feb 2025 09:13:22 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 01/14] mm/mm_init: rename init_reserved_page to
 init_deferred_page
Message-ID: <Z7WEktyNoCPylytL@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-2-rppt@kernel.org>
 <20250218145904.x57chhz3whvckzu3@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218145904.x57chhz3whvckzu3@master>

Hi,

On Tue, Feb 18, 2025 at 02:59:04PM +0000, Wei Yang wrote:
> On Thu, Feb 06, 2025 at 03:27:41PM +0200, Mike Rapoport wrote:
> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> >When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, init_reserved_page()
> >function performs initialization of a struct page that would have been
> >deferred normally.
> >
> >Rename it to init_deferred_page() to better reflect what the function does.
> 
> Would it be confused with deferred_init_pages()?

Why? It initializes a single page, deferred_init_pages() initializes many.

> And it still calls __init_reserved_page_zone(), even we __SetPageReserved()
> after it. Current logic looks not clear.

There's no __init_reserved_page_zone(). Currently init_reserved_page()
detects the zone of the page and calls __init_single_page(), so essentially
it initializes one struct page.

And we __SetPageReserved() in reserve_bootmem_region() after call to
init_reseved_page() because pages there are indeed reserved.
 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.

