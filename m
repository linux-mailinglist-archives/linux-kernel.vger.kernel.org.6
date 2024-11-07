Return-Path: <linux-kernel+bounces-399890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C229C05E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78DC51F222AE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D8920C474;
	Thu,  7 Nov 2024 12:35:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371FB1E9096
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982936; cv=none; b=eToY7gmb0/1o1Kz1F9Aru76f54x1POfvo0SJYj8GNxK1TeyBYyj+ZzCKOayo6WQozhGCBK8Xn+1qT4MbTzDq3T8Z5Q31PqgPISFnSDUYtGsOehx0+4Nzpx51SYOoOuWg9V1qMElbsRiaImlkyoeS1p9LjJl3vsyIiu0KPjJJviM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982936; c=relaxed/simple;
	bh=bHYyx9VSQMMVjl5yxNco7V3t9XCwwSZayOdt/JyZkP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDNotFQ0uZc+dntSePWidzKq9BalUElIkHn524NRRb697vutDZ3pagzwl49rdGWJavAOVMvaUM72T/HPEBko4wMGjqaMfYNFfDCUB2R5ZuaoMZtY/YC1UC6uEAFgcanI2en72F/C0quxdo07AZo8VCCUOmPjoULL02ybfxosSvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F6EC4CECC;
	Thu,  7 Nov 2024 12:35:32 +0000 (UTC)
Date: Thu, 7 Nov 2024 12:35:26 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Message-ID: <Zyy0DpOIu63isKZR@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <ZyPxhF34JjT3Ky9K@arm.com>
 <083d9e98-b6b8-4702-a700-24aea95cef9e@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <083d9e98-b6b8-4702-a700-24aea95cef9e@arm.com>

On Wed, Nov 06, 2024 at 11:37:58AM +0000, Ryan Roberts wrote:
> On 31/10/2024 21:07, Catalin Marinas wrote:
> > So, first of all, I'd like to understand the overall maintainability
> > impact better. I assume you tested mostly defconfig. If you run an
> > allmodconfig build with make -k, how many build failures do you get with
> > this patchset? Similarly for some distro configs.
> 
> I've roughly done:
> 
>     make alldefconfig &&
>         ./scripts/config --enable CONFIG_ARM64_BOOT_TIME_PAGE_SIZE &&
> 	make -s -j`nproc` -k &> allmodconfig.log

Is it alldefconfig or allmodconfig? The former has a lot less symbols
enabled than even defconfig (fairly close to allnoconfig actually):

$ make defconfig
$ grep -v "^#\|^$" .config | wc -l
4449

$ make alldefconfig
$ grep -v "^#\|^$" .config | wc -l
713

$ make allmodconfig
$ grep -v "^#\|^$" .config | wc -l
14401

> In the end, I decided to go for r'(\S+\.[ch]):.*(error|note):', which is any
> files described as having an error or being the callsite of the thing with the
> error. I think this is likely most accurate from eyeballing the log:

I think that's good enough to give us a rough idea.

> |            |     C&H files | percentage of |
> | directory  |      w/ error | all C&H files |
> |------------|---------------|---------------|
> | arch/arm64 |             7 |          1.3% |
> | drivers    |           127 |          0.4% |
> | fs         |            25 |          1.1% |
> | include    |            27 |          0.4% |
> | init       |             1 |          8.3% |
> | kernel     |             7 |          1.3% |
> | lib        |             1 |          0.2% |
> | mm         |             6 |          3.2% |
> | net        |             7 |          0.4% |
> | security   |             2 |          0.8% |
> | sound      |            21 |          0.8% |
> |------------|---------------|---------------|
> | TOTAL      |           231 |          0.4% |
> |------------|---------------|---------------|

This doesn't look that bad _if_ you actually built most modules. But if
it was alldefconfig, you likely missed the majority of modules.

> > Do we have any better way to detect this other than actual compilation
> > on arm64? Can we hack something around COMPILE_TEST like redefine
> > PAGE_SIZE (for modules only) to a variable so that we have a better
> > chance of detecting build failures when modules are only tested on other
> > architectures?
> 
> I can certainly look into this. But if the concern is that drivers are not being
> compiled against arm64, what is the likelyhood of them being compiled against
> COMPILE_TEST?

Hopefully some CIs out there catching them. Well, if we are to fix them
anyway, we might as well eventually force a non-const PAGE_SIZE
generically even if it returns a constant.

I'm building allmod now with something like below (and some hacks in
arch and core code to use STATIC_PAGE_* as I did not apply your
patches). alldefconfig passes with my hacks but, as you can see, the
non-const PAGE_SIZE kicks in only if MODULE is defined. So, not an
accurate test, just to get a feel of the modules problem.

----------8<---------------------------
diff --git a/arch/arm64/include/asm/page-def.h b/arch/arm64/include/asm/page-def.h
index 792e9fe881dc..71a761f86b15 100644
--- a/arch/arm64/include/asm/page-def.h
+++ b/arch/arm64/include/asm/page-def.h
@@ -12,7 +12,19 @@
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT		CONFIG_PAGE_SHIFT
-#define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
+#define STATIC_PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
+#define STATIC_PAGE_MASK	(~(STATIC_PAGE_SIZE-1))
+
+#if !defined(MODULE) || defined(__ASSEMBLY__)
+#define PAGE_SIZE		STATIC_PAGE_SIZE
+#else
+static inline unsigned long __runtime_page_size(void)
+{
+	return 1UL << PAGE_SHIFT;
+}
+#define PAGE_SIZE		(__runtime_page_size())
+#endif
+
 #define PAGE_MASK		(~(PAGE_SIZE-1))
 
 #endif /* __ASM_PAGE_DEF_H */
----------8<---------------------------

-- 
Catalin

