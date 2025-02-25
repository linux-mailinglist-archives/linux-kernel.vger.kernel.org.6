Return-Path: <linux-kernel+bounces-531182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32324A43D36
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 880307A5077
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B3C33CFC;
	Tue, 25 Feb 2025 11:10:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8571DF73D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481857; cv=none; b=F+xaIZFQkq8ISZsx6k9hK5Ycsn3jddqG4XxYdqENNdwZ80KuFqAucDzu/c0yn10G5lMZPyHNMrCEYKZz7wfQ0jTrx4FMPsAEVw14FcfWCX7TeRNfQI0EIQWby8QIN8Rt9WdouhMfmlI3tArVgXC7Z8JfoVhlranwkzaFXIHZhF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481857; c=relaxed/simple;
	bh=BwZq8RSTyie3qwAAeo2SkjKBI+dDwj3DOLncsyX+0Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NizTMoXSfBdWGW76R5hOkzZnwfL0jvkP9b50ePzZJcvJKCf+mV8lRp63sQFaC788KjOhZ9qgId/2aF5JfM5HrEnPop8QkLU98gboFUdYT9xk9i0JyQ35BWZNBX2IXvuHVYNWZdb9bUjE0UPqXd+I1IrQ4cODE7zHP5clKDhFFtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D71D81516;
	Tue, 25 Feb 2025 03:11:09 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D357D3F673;
	Tue, 25 Feb 2025 03:10:51 -0800 (PST)
Date: Tue, 25 Feb 2025 11:10:46 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Luiz Capitulino <luizcap@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	ardb@kernel.org,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: kernel BUG at arch/arm64/mm/mmu.c:185!
Message-ID: <Z72lNoOdZp5_kiT7@J2N7QTR9R3>
References: <a3d9acbe-07c2-43b6-9ba9-a7585f770e83@redhat.com>
 <fe95f4c8-4b09-4d8e-99c9-987ddc2761e3@arm.com>
 <9f5600b3-6525-4045-ad1f-4408dfc9ce0f@redhat.com>
 <cf2b32a4-2217-4a31-b6d7-e60a9f4ef7dd@arm.com>
 <789c17e6-5ebc-4e37-93cd-19d24f148fd8@redhat.com>
 <dee18de8-7938-4df1-badb-c00832d6995f@redhat.com>
 <b39a37c8-c9b5-406d-a97a-24fa67622b49@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b39a37c8-c9b5-406d-a97a-24fa67622b49@arm.com>

On Tue, Feb 25, 2025 at 09:47:30AM +0000, Ryan Roberts wrote:
> (Adding arm folks for visibility)
> 
> See original report here for context:
> https://lore.kernel.org/all/a3d9acbe-07c2-43b6-9ba9-a7585f770e83@redhat.com/
> 
> TL;DR is that 6.14 doesn't boot on Ampere Altra when kaslr is enabled.
> 
> 
> On 20/02/2025 20:08, Luiz Capitulino wrote:
> > On 2025-02-19 09:40, Luiz Capitulino wrote:
> > 
> >>>> Btw, I'll try to bisect again and will also try to update the system's firmware
> >>>> just in case.
> > 
> > I tried to bisect it and again, got nowhere.
> > 
> > Git bisect says the first bad commit is 8883957b3c9de2087fb6cf9691c1188cccf1ac9c .
> > But I'm able to boot that tree...
> > 
> 
> OK, think I've found the dodgy commit:
> 
> Commit 62cffa496aac ("arm64/mm: Override PARange for !LPA2 and use it consistently")
> 
> Based on the changes it certainly looks like it could be the issue, but I
> haven't spotted exactly what the problem is yet. Ard, could you take a look?
> 
> I managed to hack multi ram bank support into kvmtool, so I can now repro the
> issue in virtualization. Then was able to bisect to get to the above commit.

If you're able to repro this, could you please say the configuration of
memory banks you're using, and could you hack the BUG() to dump more
info, e.g. something lihke the below, UNTESTED patch.

Knowing the VA will tell us whether we're spilling out of the expected VA
region otherwise going wildly wrong with addressing, and the values in the PTEs
will tell us what's specifically triggering the warning.

Also, if you're able to test with CONFIG_DEBUG_VIRTUAL, that might spot if we
have a dodgy VA->PA conversion somewhere, which can 

Mark.

---->8----
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b4df5bc5b1b8b..d04719919de33 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -171,19 +171,22 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 {
        do {
                pte_t old_pte = __ptep_get(ptep);
+               pte_t new_pte =  pfn_pte(__phys_to_pfn(phys), prot);
 
                /*
-                * Required barriers to make this visible to the table walker
-                * are deferred to the end of alloc_init_cont_pte().
+                * After the PTE entry has been populated once, we
+                * only allow updates to the permission attributes.
                 */
-               __set_pte_nosync(ptep, pfn_pte(__phys_to_pfn(phys), prot));
+               if (!pgattr_change_is_safe(pte_val(old_pte), pte_val(new_pte))) {
+                       panic("Unsafe PTE change @ VA:0x%016lx PA:%pa::0x%016llx -> 0x%016llx\n",
+                              addr, &phys, pte_val(old_pte), pte_val(new_pte));
+               }
 
                /*
-                * After the PTE entry has been populated once, we
-                * only allow updates to the permission attributes.
+                * Required barriers to make this visible to the table walker
+                * are deferred to the end of alloc_init_cont_pte().
                 */
-               BUG_ON(!pgattr_change_is_safe(pte_val(old_pte),
-                                             pte_val(__ptep_get(ptep))));
+               __set_pte_nosync(ptep, pfn_pte(__phys_to_pfn(phys), prot));
 
                phys += PAGE_SIZE;
        } while (ptep++, addr += PAGE_SIZE, addr != end);
 

