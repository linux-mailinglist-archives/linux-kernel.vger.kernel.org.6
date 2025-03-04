Return-Path: <linux-kernel+bounces-543948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C305A4DBBE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1229179232
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5136D1FF1DB;
	Tue,  4 Mar 2025 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="agbvZhRk"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492661FECAD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086073; cv=none; b=kFqUJhBP3ZA7lIQVIOZ37XKLFgixoiIzFukWNUXFmBezqGnGI8JrFRNknuscOuU3+sNe+ig6ud0KwfzmdoVTOlwaYoXzc6RXkW3MQT3h6AJWg1mvOY85T45ew8VVjYAQP0X3NfuDloMoPfsU0fL+VqIxsm/3XLC/bFDeRXil4iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086073; c=relaxed/simple;
	bh=YHxz1GkiwWKxt6+4CmoRdSpYwOkZzszkYTmGXFib52I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTIGXNKbN5MZOpAMV8/tF4xaw1AetYsx9K+AxoP0sL+rtdpm5YwUzdnV28kQ1Gd4Y/UIh1YLnPNU5o2J9eCyi1DQxPH8hVojsGNk0WmItdfwjE8XR8fQVRUQXKwldRIkXxuePIfgI2nJaVRvdvIxBHB2BhHQDZtOJlaIb+1ReyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=agbvZhRk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 91B1240E0215;
	Tue,  4 Mar 2025 11:01:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8Rx0Nk4klulw; Tue,  4 Mar 2025 11:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741086061; bh=F5mv4iED1rr2rJ7SCsELcpcVz62iO8EDzCtAjovfhLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=agbvZhRk1Su3jPL8rGiKwTEAO/7GD0UwfXSxP+ZcC31uvsFfTFaB7SXirBevkxMQr
	 R4xMVLf0DlGVZkAP47+QPhw9OzIIsq6U/oDUC8w5x2whKV8n2+qJCLZEtNHLgWwoLV
	 57xKybmBkauzo2CCVuL0WSO4nhlUEK0k6ce5sVU5xRecvFzEr/vtkHcNi5iz8LnU0B
	 XCeR51ZSD0caO63FVwP3HE7gVfY4u0vWQtHRU/2qL5ipfID9yeMzmSPlz5sExdVKzt
	 9oUdlCovyemquEeWkRb3zBX3uzt/vzCTM3FFievF6NuBaxxjYX95iMaKDHpOcaw3+E
	 rxn+cxcZo3GrYtTZa9l6zYuZZQDBWxoTiBlnCOH5IC5KAP6MtZPTL/b+NDXcMndFDo
	 b08HSMH+1CpCl5XE2oeXEAizNYc2clrpQ/7Ni2VrqiD0LNodeH+wBcJeSZtaK/WQxy
	 6KBhMDU3KFTFrGNVuIjqIoZ/ajjH1pvK8gcyCPhuT5+WvZWTqGu/vQzTS/E0PA/5KB
	 IHD0G2Mg/d9eOgnXxuzQIFwwBZdnnbQsjtF2nPqezEiT59KeBWI4ifrtCFcbEkZi9u
	 YusuMG788xZ3SQdPFzPCXlMkcxrTvc7eQUxHctRAK5OHLetzDDGo+2FoLY56KYcc5L
	 KdsGNaUvJF8/dI2Xzk3K3/h0=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0E14A40E0214;
	Tue,  4 Mar 2025 11:00:42 +0000 (UTC)
Date: Tue, 4 Mar 2025 12:00:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Rik van Riel <riel@surriel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v14 03/13] x86/mm: add INVLPGB support code
Message-ID: <20250304110032.GEZ8bdUOg2WLUrhMcm@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-4-riel@surriel.com>
 <20250228194734.GGZ8IS1iFVpPzmEyYl@fat_crate.local>
 <30c721e0-338d-4172-989c-5226d584bcbc@intel.com>
 <34b80474-a309-493b-81e9-3a7d4de8a369@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <34b80474-a309-493b-81e9-3a7d4de8a369@intel.com>

On Mon, Mar 03, 2025 at 11:23:58AM -0800, Dave Hansen wrote:
> Here's a plain diff if you just want to squish it in.

> diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
> index 5375145eb9596..3bd617c204346 100644
> --- a/arch/x86/include/asm/tlb.h
> +++ b/arch/x86/include/asm/tlb.h
> @@ -28,6 +28,11 @@ static inline void invlpg(unsigned long addr)
>  	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
>  }
>  
> +enum invlpgb_stride {

Right, this is an address stride, as the text calls it.

> +	NO_STRIDE  = 0,
> +	PTE_STRIDE = 0,

Ok, so those are confusing. No stride is PTE stride so let's just zap
NO_STRIDE.

> +	PMD_STRIDE = 1
> +};
>  
>  /*
>   * INVLPGB does broadcast TLB invalidation across all the CPUs in the system.

...

>  static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
>  						unsigned long addr,
>  						u16 nr,
>  						bool pmd_stride)

You're relying on the fact that true == PMD_STRIDE and false to PTE_STRIDE but
let's make it Right(tm), see below.

Rest looks ok.

IOW, I'm merging this into patch 3:

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 5375145eb959..6718835c3b0c 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -28,6 +28,10 @@ static inline void invlpg(unsigned long addr)
 	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
 }
 
+enum addr_stride {
+	PTE_STRIDE = 0,
+	PMD_STRIDE = 1
+};
 
 /*
  * INVLPGB does broadcast TLB invalidation across all the CPUs in the system.
@@ -48,10 +52,10 @@ static inline void invlpg(unsigned long addr)
  */
 static inline void __invlpgb(unsigned long asid, unsigned long pcid,
 			     unsigned long addr, u16 nr_pages,
-			     bool pmd_stride, u8 flags)
+			     enum addr_stride stride, u8 flags)
 {
 	u32 edx = (pcid << 16) | asid;
-	u32 ecx = (pmd_stride << 31) | (nr_pages - 1);
+	u32 ecx = (stride << 31) | (nr_pages - 1);
 	u64 rax = addr | flags;
 
 	/* The low bits in rax are for flags. Verify addr is clean. */
@@ -78,33 +82,38 @@ static inline void __tlbsync(void)
 /*
  * INVLPGB can be targeted by virtual address, PCID, ASID, or any combination
  * of the three. For example:
- * - INVLPGB_VA | INVLPGB_INCLUDE_GLOBAL: invalidate all TLB entries at the address
- * - INVLPGB_PCID:			  invalidate all TLB entries matching the PCID
+ * - FLAG_VA | FLAG_INCLUDE_GLOBAL: invalidate all TLB entries at the address
+ * - FLAG_PCID:			    invalidate all TLB entries matching the PCID
  *
- * The first can be used to invalidate (kernel) mappings at a particular
+ * The first is used to invalidate (kernel) mappings at a particular
  * address across all processes.
  *
  * The latter invalidates all TLB entries matching a PCID.
  */
-#define INVLPGB_VA			BIT(0)
-#define INVLPGB_PCID			BIT(1)
-#define INVLPGB_ASID			BIT(2)
-#define INVLPGB_INCLUDE_GLOBAL		BIT(3)
-#define INVLPGB_FINAL_ONLY		BIT(4)
-#define INVLPGB_INCLUDE_NESTED		BIT(5)
+#define INVLPGB_FLAG_VA			BIT(0)
+#define INVLPGB_FLAG_PCID		BIT(1)
+#define INVLPGB_FLAG_ASID		BIT(2)
+#define INVLPGB_FLAG_INCLUDE_GLOBAL	BIT(3)
+#define INVLPGB_FLAG_FINAL_ONLY		BIT(4)
+#define INVLPGB_FLAG_INCLUDE_NESTED	BIT(5)
+
+/* The implied mode when all bits are clear: */
+#define INVLPGB_MODE_ALL_NONGLOBALS	0UL
 
 static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
 						unsigned long addr,
-						u16 nr,
-						bool pmd_stride)
+						u16 nr, bool stride)
 {
-	__invlpgb(0, pcid, addr, nr, pmd_stride, INVLPGB_PCID | INVLPGB_VA);
+	enum addr_stride str = stride ? PMD_STRIDE : PTE_STRIDE;
+	u8 flags = INVLPGB_FLAG_PCID | INVLPGB_FLAG_VA;
+
+	__invlpgb(0, pcid, addr, nr, str, flags);
 }
 
 /* Flush all mappings for a given PCID, not including globals. */
 static inline void invlpgb_flush_single_pcid_nosync(unsigned long pcid)
 {
-	__invlpgb(0, pcid, 0, 1, 0, INVLPGB_PCID);
+	__invlpgb(0, pcid, 0, 1, PTE_STRIDE, INVLPGB_FLAG_PCID);
 }
 
 /* Flush all mappings, including globals, for all PCIDs. */
@@ -117,21 +126,21 @@ static inline void invlpgb_flush_all(void)
 	 * as it is cheaper.
 	 */
 	guard(preempt)();
-	__invlpgb(0, 0, 0, 1, 0, INVLPGB_INCLUDE_GLOBAL);
+	__invlpgb(0, 0, 0, 1, PTE_STRIDE, INVLPGB_FLAG_INCLUDE_GLOBAL);
 	__tlbsync();
 }
 
 /* Flush addr, including globals, for all PCIDs. */
 static inline void invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
 {
-	__invlpgb(0, 0, addr, nr, 0, INVLPGB_INCLUDE_GLOBAL);
+	__invlpgb(0, 0, addr, nr, PTE_STRIDE, INVLPGB_FLAG_INCLUDE_GLOBAL);
 }
 
 /* Flush all mappings for all PCIDs except globals. */
 static inline void invlpgb_flush_all_nonglobals(void)
 {
 	guard(preempt)();
-	__invlpgb(0, 0, 0, 1, 0, 0);
+	__invlpgb(0, 0, 0, 1, PTE_STRIDE, INVLPGB_MODE_ALL_NONGLOBALS);
 	__tlbsync();
 }
 #endif /* _ASM_X86_TLB_H */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

