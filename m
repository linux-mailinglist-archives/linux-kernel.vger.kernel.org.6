Return-Path: <linux-kernel+bounces-544926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C13A4E6C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA66E19C20E2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4852BEC2E;
	Tue,  4 Mar 2025 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C3ukYSEX"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995322BEC25
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105177; cv=none; b=ITdzvyAMZmfHNT6AeYEw6shp4nxz9hgfpNCzD+Zegjzco3+Yr/qHg7MI4mXDCoeAyAtqJ9VHEKJrs9+vUwEDGsPjlOCI6W12F65asy0PbIIm6qKy4y3k0H7HSuiMHUSwMpfcuyDGEAYqNIvMgmBN2xUIDw4nzgd0XQ+vO6eNy0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105177; c=relaxed/simple;
	bh=72oSp4NRTUL4iq6d9P9Lgt9+cjIJ73YL44iRj4VfVtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GW2+dGiYgBaVNK3GyKW/kXEuKHarx4+3K+UIusRyjakWx6JavnIgLcuFaqBHD9sowsysy2MLCXrSneYYYomi7LuGSDBy5ANYDjI/bc9QUeRs1Yua8KQnCxL6iCGGwc7B3/2EcwI1ZoyhPpNKVwQZi6LFENWBFAG+7NBF9ZI6Qis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C3ukYSEX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 74F8840E015E;
	Tue,  4 Mar 2025 16:19:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id P5fGbP63a4RC; Tue,  4 Mar 2025 16:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741105165; bh=tTPraD/2IkvxED+KlWLuIIiqPJz+rVst3iYy14q2FMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C3ukYSEXDjWqplXbxA5vfpYYc+aJWgHeM7JsgDFrfryALviCV3ZjQ6x36EoLPzfoT
	 vPindXjdoOekME5+igV8pTAVaLuTWI1XQDzgj0Dn2XeYfmzJiD2+vGuyBQwuUdrO4h
	 UXRuMhfPGE3Etje+qgiAO76g5FSC/qaxaZ8s4sfAvP4cZxL6F1KqpxtlSRPQx9lZqy
	 AvqPes7+sbz3CH8aoBFZvVYvFsHeflJigAra1vyvRGN6ZKT8H6Ex9eDJRLyE259WjC
	 MTTqybqBFZfsw+cHnI9U5/c+IO+ALCCcGUEALr76gXx78vKZadhBIiHPpYFGDlI3AZ
	 3RHcpeCMdvl/3n+8V1ZNVUdHhTzPoi9tMucrGTqOUC4i1a2wtqZw/uiE3771RJs9QQ
	 nz15Kp1m/oCV3C58N0NItVsuToEJidXJslWvfL5bSetGK560e2puPLUZkuS2L/IWv3
	 XYItMZzcZxOpStUr0ET4ZAzwtZV+yaADVuEEP+OkZP8Pitezs/bv50QRhMTQw8N+pL
	 7dpAWP9LfCnKuPh4IlX/N9r1jFdc/IH9WlQ32J+b/d+Ik0CqnlBV3P8CRmPyxF3JKU
	 8m75EUrlfCeX2pUkVBYHkV4cfPUkjr7hcUyWRU3pDgVGDWFOGt7lFRKVHEtqqV6RSW
	 t3Ttm2LDrAMR+uuL3T2YRbtA=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 68C4340E015D;
	Tue,  4 Mar 2025 16:19:07 +0000 (UTC)
Date: Tue, 4 Mar 2025 17:19:01 +0100
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
Message-ID: <20250304161901.GCZ8cn9d252LTzThpI@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-4-riel@surriel.com>
 <20250228194734.GGZ8IS1iFVpPzmEyYl@fat_crate.local>
 <30c721e0-338d-4172-989c-5226d584bcbc@intel.com>
 <34b80474-a309-493b-81e9-3a7d4de8a369@intel.com>
 <20250304110032.GEZ8bdUOg2WLUrhMcm@fat_crate.local>
 <ec7247d0-0379-487d-a2d7-21b81dcd0c38@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec7247d0-0379-487d-a2d7-21b81dcd0c38@intel.com>

On Tue, Mar 04, 2025 at 07:10:13AM -0800, Dave Hansen wrote:
> So, we could have the enum be totally divorced from the hardware type:
> 
> 	NO_STRIDE,
> 	PTE_STRIDE,
> 	PMD_STRIDE

How about we completely hide that NO_STRIDE thing and do a __invlpgb_all()
"sub-helper" which is basically telling you it is invalidating all kinds of
TLB entries and stride does not apply there:

---

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index e8561a846754..361b3dde2656 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -66,6 +66,12 @@ static inline void __invlpgb(unsigned long asid, unsigned long pcid,
 	asm volatile(".byte 0x0f, 0x01, 0xfe" :: "a" (rax), "c" (ecx), "d" (edx));
 }
 
+static inline void __invlpgb_all(unsigned long asid, unsigned long pcid,
+				 unsigned long addr, u16 nr_pages, u8 flags)
+{
+	__invlpgb(asid, pcid, addr, nr_pages, 0, flags);
+}
+
 static inline void __tlbsync(void)
 {
 	/*
@@ -84,6 +90,8 @@ static inline void __tlbsync(void)
 static inline void __invlpgb(unsigned long asid, unsigned long pcid,
 			     unsigned long addr, u16 nr_pages,
 			     enum addr_stride s, u8 flags) { }
+static inline void __invlpgb_all(unsigned long asid, unsigned long pcid,
+				 unsigned long addr, u16 nr_pages, u8 flags) { }
 static inline void __tlbsync(void) { }
 #endif
 
@@ -121,7 +129,7 @@ static inline void __invlpgb_flush_user_nr_nosync(unsigned long pcid,
 /* Flush all mappings for a given PCID, not including globals. */
 static inline void __invlpgb_flush_single_pcid_nosync(unsigned long pcid)
 {
-	__invlpgb(0, pcid, 0, 1, PTE_STRIDE, INVLPGB_FLAG_PCID);
+	__invlpgb_all(0, pcid, 0, 1, INVLPGB_FLAG_PCID);
 }
 
 /* Flush all mappings, including globals, for all PCIDs. */
@@ -134,7 +142,7 @@ static inline void invlpgb_flush_all(void)
 	 * as it is cheaper.
 	 */
 	guard(preempt)();
-	__invlpgb(0, 0, 0, 1, PTE_STRIDE, INVLPGB_FLAG_INCLUDE_GLOBAL);
+	__invlpgb_all(0, 0, 0, 1, INVLPGB_FLAG_INCLUDE_GLOBAL);
 	__tlbsync();
 }
 
@@ -148,7 +156,7 @@ static inline void __invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
 static inline void invlpgb_flush_all_nonglobals(void)
 {
 	guard(preempt)();
-	__invlpgb(0, 0, 0, 1, PTE_STRIDE, INVLPGB_MODE_ALL_NONGLOBALS);
+	__invlpgb_all(0, 0, 0, 1, INVLPGB_MODE_ALL_NONGLOBALS);
 	__tlbsync();
 }
 #endif /* _ASM_X86_TLB_H */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

