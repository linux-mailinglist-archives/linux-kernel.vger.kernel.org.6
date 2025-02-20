Return-Path: <linux-kernel+bounces-523962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D583A3DD64
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570ED16D8F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770591D54CF;
	Thu, 20 Feb 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InovFzdw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64595258;
	Thu, 20 Feb 2025 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063280; cv=none; b=o7nQxrl1AT/PLcjx5CVmwnHVN1Jsfd38+VMGvMrnofiYaN65NwNp2aG1kJSSDOefpEsoQrZwTmbcgWRlXpN2Figdkf85kFGfydhml0zYehMNZDdWJBs1ApDhdal2CpoRa4Prh6VcTE30oPuHl2QK0u+P7by4rpGNvVraKHQnr8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063280; c=relaxed/simple;
	bh=BC0dhBX7Eg81uhggtuEZHVM8dUwnpQ+dA2ufHLGdn4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smtc9dhUTBEpcNFX4/RmRpXTYtGyTo7VxjGzZJE1Lnpa3o2fXIkD12G0ZDLiEdPRutEaGycYbCIp1xqPaWdhEaG1psqQ74mS8M33V2OHuJVnPLtYuz/yfqA+nUx6vbK0kkPjqJLWDQP4LIKgPHpWQYx2HldJn1KoMWLNHxzePOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InovFzdw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63166C4CED1;
	Thu, 20 Feb 2025 14:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740063280;
	bh=BC0dhBX7Eg81uhggtuEZHVM8dUwnpQ+dA2ufHLGdn4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=InovFzdwowCfkaS3mdofhqdbNRDT0QPSXwLh3w3Ks3gabjyfLh3ZoKBTtSmNarqnX
	 NWSycHqGlN7yNd+0eWaOU0+ODeMj6drkyWUBF0F3RDCZrjku80gpxCYmc+kAAFUIhF
	 cIdOH8Da91vYXQfiFliQAi78+0x05PEFtzKvkt3XktgkdC4Zn64/wMsF41e4w438lb
	 73um6//H3gzH4CFINfnDIYtLDsWM0e8qrbcvmRP2pP+F9H/e6WTApFpXNGqIxMY23P
	 l5ycIRreRRuogv2tc/sBZpVOPGfjbPnHoaxZx2Ce/d5jWstSBddCKPXyzlLKyYjqF8
	 fPv0Kjhu6R8bQ==
Date: Thu, 20 Feb 2025 16:54:19 +0200
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
Message-ID: <Z7dCG3ihTnDuJ8_c@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-2-rppt@kernel.org>
 <20250218145904.x57chhz3whvckzu3@master>
 <Z7WEktyNoCPylytL@kernel.org>
 <20250220083601.4p6ehmfhyvs5q5io@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220083601.4p6ehmfhyvs5q5io@master>

On Thu, Feb 20, 2025 at 08:36:01AM +0000, Wei Yang wrote:
> On Wed, Feb 19, 2025 at 09:13:22AM +0200, Mike Rapoport wrote:
> >Hi,
> >
> >On Tue, Feb 18, 2025 at 02:59:04PM +0000, Wei Yang wrote:
> >> On Thu, Feb 06, 2025 at 03:27:41PM +0200, Mike Rapoport wrote:
> >> >From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >> >
> >> >When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, init_reserved_page()
> >> >function performs initialization of a struct page that would have been
> >> >deferred normally.
> >> >
> >> >Rename it to init_deferred_page() to better reflect what the function does.
> >> 
> >> Would it be confused with deferred_init_pages()?
> >
> >Why? It initializes a single page, deferred_init_pages() initializes many.
> >
> 
> See below.
> 
> >> And it still calls __init_reserved_page_zone(), even we __SetPageReserved()
> >> after it. Current logic looks not clear.
> >
> >There's no __init_reserved_page_zone(). Currently init_reserved_page()
> >detects the zone of the page and calls __init_single_page(), so essentially
> >it initializes one struct page.
> >
> >And we __SetPageReserved() in reserve_bootmem_region() after call to
> >init_reseved_page() because pages there are indeed reserved.
> > 
> 
> Hmm... I am not sure we are looking at the same code. I take a look at current
> mm-unstable, this patch set is not included.

I was looking at Linus tree, it was not there yet :)

> So I am looking at previous version with this last commit:
> 
>   8bf30f9d23eb 2025-02-06 Documentation: KHO: add memblock bindings
> 
> Here is what I see for init_deferred_page()'s definition:
> 
> init_deferred_page()
>   __init_deferred_page()
>     __init_reserved_page_zone()   <--- I do see this function, it is removed?
>       __init_single_page()
> 
> What I want to say is __init_deferred_page() calls
> __init_reserved_page_zone(). This sounds imply a deferred page is always
> reserved page. But we know it is not.  deferred_init_pages() initialize the
> pages are not reserved one. Or we want to have this context in
> __init_deferred_page()?

If the commit that introduced __init_reserved_page_zone goes in before KHO,
I'll just rename both functions, there is nothing about reserved pages
there.
 
> >-- 
> >Sincerely yours,
> >Mike.
> 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.

