Return-Path: <linux-kernel+bounces-539499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C428EA4A52F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98EF83B4BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820AB1D8E12;
	Fri, 28 Feb 2025 21:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OJLwt0qI"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942BF1CCEDB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 21:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779043; cv=none; b=bap49NC/CwESBuKcQFrMBzGlsDXiUsqWK7vRnchraj7R4nbt2kTTl4gVCHVDhT4yC7g2ie+3cWwB+3Gqvk22vPkipK8YDDEEz04rLXupuwoQa11GHc0A4FjaMmzUvvd7PJTGeY5Cz2qDf9j2P+3Jfn314gd8wJEAl5NPu4djcW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779043; c=relaxed/simple;
	bh=GkQ7MhUHfw6q4SHBOfDDFk+xQCZP9hTnlu76RQ/cczY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b73pTUscmiay84bcAE3wTfQ9uX8242OzmJ1PFaLwMhhQKZBOa/Dwf7JkRdhdvGrzWokUl9RytWdDT9H29CN5mqoY9KkGwBBhcq9xph8Yh18G8uzhLNlau3NVVDlD3sCnbU8jkE5avB1P1ZJZPKpZHYBCxX6lVbsx0IiodBTv/IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OJLwt0qI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DEDB540E01AE;
	Fri, 28 Feb 2025 21:43:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PIOsHn8YW_Vu; Fri, 28 Feb 2025 21:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740779032; bh=9UV1IcJ900touH3JTaTltIhj++lVmzYmB/lL+8OAMUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJLwt0qIS4tB6CaY/OYGn6tBWhWzFkvn2lu4L9zDlanRYogIDVGS2XQfYMdNaGezE
	 8iUB+dNpMTlttLT6sjnLqMsivArWwiv8LUj9vaJvIYoOMWcIPPQjAkV0Cxg+5rgTyF
	 quv4bxUP/RCWuUm+AF4Q/33tBTkjDdpakHjCGMK7scrFGt56zxVCJ0DNqdiZgvhmRx
	 900Rhrcb1o+/w44treZ4Nb982ZTu+DlLZQ4kzKyAwq00myJYukBcCMA8kBZr/uaqXY
	 z3ojT2KDB9KD33XzTE8aVLpcuUYrzi007E61ILHMVdWMhWnkfb1jEJjLrrpizeOG60
	 D297S1AjssmhC65Oo6VJk6ShpD0Vo/WebS0ZdseGe6Y2Fe3gBPdOX/+8Fyf71NNzvc
	 5SEjEvn+bW7PijkuhLZ88ZqyLdtU5VcpRtc/9LHn8Y0vs83+I/7iCGfnFONtaBnvKt
	 tv7UTu6U5nw6dy+onKmHt2qrTNEnc6K13uDGYdbAprauG2OvMLZcRybmaVxN/xApLb
	 fV3VS6+oJq61Pow/ecCx1p93hi5RdoXd3bvzffcRAddTz9SHC0qPksuSTOO9gJWIci
	 NH/ugoCtvAOCj/OkAd2Oekx2XPxyB8w168k94KNOpu9bSXQB+MB2Ae0lWNg7nplmYY
	 Mqza9MqJr0+z+6Yl/iHqWKUM=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C559740E015E;
	Fri, 28 Feb 2025 21:43:34 +0000 (UTC)
Date: Fri, 28 Feb 2025 22:43:28 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v14 04/13] x86/mm: use INVLPGB for kernel TLB flushes
Message-ID: <20250228214328.GGZ8IuAMKL4FeSTBER@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-5-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226030129.530345-5-riel@surriel.com>

On Tue, Feb 25, 2025 at 10:00:39PM -0500, Rik van Riel wrote:
> Use broadcast TLB invalidation for kernel addresses when available.
> 
> Remove the need to send IPIs for kernel TLB flushes.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Tested-by: Manali Shukla <Manali.Shukla@amd.com>
> Tested-by: Brendan Jackman <jackmanb@google.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  arch/x86/mm/tlb.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)

Changes ontop:

--- /tmp/current.patch	2025-02-28 22:39:33.236465716 +0100
+++ /tmp/0001-x86-mm-Use-INVLPGB-for-kernel-TLB-flushes.patch	2025-02-28 22:39:59.432310072 +0100
@@ -1,36 +1,43 @@
+From b97ae5e31069cd536b563df185de52d33a565077 Mon Sep 17 00:00:00 2001
 From: Rik van Riel <riel@surriel.com>
 Date: Tue, 25 Feb 2025 22:00:39 -0500
-Subject: x86/mm: Use INVLPGB for kernel TLB flushes
+Subject: [PATCH] x86/mm: Use INVLPGB for kernel TLB flushes
 
 Use broadcast TLB invalidation for kernel addresses when available.
-
 Remove the need to send IPIs for kernel TLB flushes.
 
+   [ bp: Integrate dhansen's comments additions. ]
+
 Signed-off-by: Rik van Riel <riel@surriel.com>
 Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
-Tested-by: Manali Shukla <Manali.Shukla@amd.com>
-Tested-by: Brendan Jackman <jackmanb@google.com>
-Tested-by: Michael Kelley <mhklinux@outlook.com>
+Acked-by: Dave Hansen <dave.hansen@intel.com>
 Link: https://lore.kernel.org/r/20250226030129.530345-5-riel@surriel.com
 ---
- arch/x86/mm/tlb.c | 32 ++++++++++++++++++++++++++++++--
- 1 file changed, 30 insertions(+), 2 deletions(-)
+ arch/x86/mm/tlb.c | 39 +++++++++++++++++++++++++++++++++++++--
+ 1 file changed, 37 insertions(+), 2 deletions(-)
 
 diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
-index dbcb5c968ff9..f44a03bca41c 100644
+index dbcb5c968ff9..5c44b94ad5af 100644
 --- a/arch/x86/mm/tlb.c
 +++ b/arch/x86/mm/tlb.c
-@@ -1077,6 +1077,18 @@ void flush_tlb_all(void)
+@@ -1077,6 +1077,25 @@ void flush_tlb_all(void)
  	on_each_cpu(do_flush_tlb_all, NULL, 1);
  }
  
++/* Flush an arbitrarily large range of memory with INVLPGB. */
 +static void invlpgb_kernel_range_flush(struct flush_tlb_info *info)
 +{
 +	unsigned long addr, nr;
 +
 +	for (addr = info->start; addr < info->end; addr += nr << PAGE_SHIFT) {
 +		nr = (info->end - addr) >> PAGE_SHIFT;
++
++		/*
++		 * INVLPGB has a limit on the size of ranges it can
++		 * flush. Break up large flushes.
++		 */
 +		nr = clamp_val(nr, 1, invlpgb_count_max);
++
 +		invlpgb_flush_addr_nosync(addr, nr);
 +	}
 +	__tlbsync();
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

