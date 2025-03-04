Return-Path: <linux-kernel+bounces-545609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41477A4EF39
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B40DE7A8B90
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864E926B09A;
	Tue,  4 Mar 2025 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eRif0Ako"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC061FDA9D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122802; cv=none; b=GmPhMDcJ6FEEQ9UJxKi3Er5IBz1ey0P5w5/9ihu/ALMwJ9G/9Eu6WEqqLuvaFFGKuhOBCqbu9mqtOs9bvH19FDiJNsunsjgHmlpBUU0CVcJCQ30mvd4mvjHx60OgzdYtPwoGPaaBHX1lFRruC2miXTobPce9lnF0O8Fgay5gXQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122802; c=relaxed/simple;
	bh=LskRZcu6xVm6LtybvTSkdUfkBkzhutfp9Vg/z40f/Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFncZrJBX+1c7KzuQbmAshmDC1aOI5SnYCS9I1i6N4a9K7qo2VtPcsTiZha+QbGz8k2fU8tpuWjnlIUqi1Q3LDgVSPSxCtIh5EfNZEvymX/3JZVWus9ynFhK/c3C48qXX9AvwwJM2N8XzWgWIjRLGimmueCKWVbDqGrYFRbJSo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eRif0Ako; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 05F7E40E0202;
	Tue,  4 Mar 2025 21:13:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aLboqJJ2XNmr; Tue,  4 Mar 2025 21:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741122791; bh=LdcTYFTwyxAe0GTULnC1Hf3ftMeeyMOzsLoDFCVxUvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eRif0AkobBlshUnkYnyAxHfz3/LiY9xn44cegODjZ8eneK3mlVCMp20IUquamBbZk
	 xHPgq8mI2ciE8K5jPYcoXECz3Y/CBzexDk3+rD1cDk8p8EusF3S+82WZJ+PZtPGqnc
	 9gD8OnD2m7bg52fC6+aLWVGCE6NpBHFuP0/Q1yFUTxatM/YkTIcIMKLCyc1IQs8Y9o
	 pQrdCoYwyq/At4tUkkirdXvpa90K5gui8MW/7G/m1w9v5WjOH7gyViGLF6XAXALOCQ
	 G+/uepIEzIKGePlN0d8JZaDa6oErHD05ppN5eSNfn93IHtjWu0QFgW3pj62S36EG5S
	 TfX0CPPFSi7KcIy0JgMcq8aojRDmVw2DaGfUAFBsNHIpEsRlm5O0sfWCdookDgWNjH
	 EPACJIoSwHvpa0e5Nxcho24xV2Ea2LwEPKCHnVhIGth9Vz0S+DOtaKbKhznlj25ucg
	 HlcZ7vojtBTM0Bu07SGY5Lbhdr/Y2Jy2emha0tyPNCbZ4b1YAqU+2EtMlKEFoZCP+l
	 JayZFadjUGeeHx37yACs7neRmKdxGUgqZ6X+lDnRgVH8+L7k81hzfje6nd5IFEPfN9
	 Rzbnau/7P8Ut1gLQbjQGzlTHTbMCt5Dbzqc4xdJN8ScBiJv4j8Z5haCI4X2PnT+vGv
	 ZKGuWIB1GUZ2334z6qV33UYY=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3B3E540E015D;
	Tue,  4 Mar 2025 21:12:53 +0000 (UTC)
Date: Tue, 4 Mar 2025 22:12:45 +0100
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
Message-ID: <20250304211245.GJZ8dszTlbuRhxZ3To@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-4-riel@surriel.com>
 <20250228194734.GGZ8IS1iFVpPzmEyYl@fat_crate.local>
 <30c721e0-338d-4172-989c-5226d584bcbc@intel.com>
 <34b80474-a309-493b-81e9-3a7d4de8a369@intel.com>
 <20250304110032.GEZ8bdUOg2WLUrhMcm@fat_crate.local>
 <ec7247d0-0379-487d-a2d7-21b81dcd0c38@intel.com>
 <20250304161901.GCZ8cn9d252LTzThpI@fat_crate.local>
 <2efa96d5-b26a-4058-a353-5dd2180ed502@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2efa96d5-b26a-4058-a353-5dd2180ed502@intel.com>

On Tue, Mar 04, 2025 at 08:57:30AM -0800, Dave Hansen wrote:
> Why would __invlpg_all() need an 'addr' or 'nr_pages'? Shouldn't those be 0?

Yap, good idea. It makes the _all helper even better:

static inline void __invlpgb_all(unsigned long asid, unsigned long pcid, u8 flags)
{
        __invlpgb(asid, pcid, 0, 1, 0, flags);
}

> It's _better_ of course when it happens at a single site and it's close
> to a prototype for __invlpgb(). But it's still a magic '0' that it's
> impossible to make sense of without looking at the prototype.

Yes.

> Looking at the APM again... there really are three possible values for
> ECX[31]:
> 
>  0: increment by 4k
>  1: increment by 2M
>  X: Don't care, no increment is going to happen
> 
> What you wrote above could actually be written:
> 
> 	__invlpgb(asid, pcid, addr, nr_pages, 1, flags);
> 
> so the 0/1 is _actually_ completely random and arbitrary as far as the
> spec goes.

Yes.

> Why does it matter?
> 
> It enables you to do sanity checking. For example, we could actually
> enforce a rule that "no stride" can't be paired with any of the
> per-address invalidation characteristics:
> 
> 	if (stride == NO_STRIDE) {
> 		WARN_ON(flags & INVLPGB_FLAG_VA);
> 		WARN_ON(addr);
> 		WARN_ON(nr_pages);
> 	}
> 
> That's impossible if you pass a 'bool' in.
> 
> But, honestly, I'm deep into nitpick mode here. I think differentiating
> the three cases is worth it, but it's also not the hill I'm going to die
> on. ;)

Yap, and now I've massaged it so much so that it doesn't really need that
checking. Because I have exactly two calls which use the stride:

1.

static inline void __invlpgb_flush_user_nr_nosync(unsigned long pcid,
                                                  unsigned long addr,
                                                  u16 nr, bool stride)
{
        enum addr_stride str = stride ? PMD_STRIDE : PTE_STRIDE;
        u8 flags = INVLPGB_FLAG_PCID | INVLPGB_FLAG_VA;

        __invlpgb(0, pcid, addr, nr, str, flags);
}

This one is fine - I verify it.

2.

/* Flush addr, including globals, for all PCIDs. */
static inline void __invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
{
	__invlpgb(0, 0, addr, nr, PTE_STRIDE, INVLPGB_FLAG_INCLUDE_GLOBAL);
}

This one controls it already.

So the only case where something could go bad is when one would use
__invlpgb() directly and that should hopefully be caught early enough.

But if you really want, I could add sanitization to __invlpgb() to massage it
into the right stride. And print a single warning - the big fat WARN* in an
inline functions are probably too much. Hm, I dunno...

Current diff ontop:

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index e8561a846754..8ab21487d6ee 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -66,6 +66,11 @@ static inline void __invlpgb(unsigned long asid, unsigned long pcid,
 	asm volatile(".byte 0x0f, 0x01, 0xfe" :: "a" (rax), "c" (ecx), "d" (edx));
 }
 
+static inline void __invlpgb_all(unsigned long asid, unsigned long pcid, u8 flags)
+{
+	__invlpgb(asid, pcid, 0, 1, 0, flags);
+}
+
 static inline void __tlbsync(void)
 {
 	/*
@@ -84,6 +89,7 @@ static inline void __tlbsync(void)
 static inline void __invlpgb(unsigned long asid, unsigned long pcid,
 			     unsigned long addr, u16 nr_pages,
 			     enum addr_stride s, u8 flags) { }
+static inline void __invlpgb_all(unsigned long asid, unsigned long pcid, u8 flags) { }
 static inline void __tlbsync(void) { }
 #endif
 
@@ -121,7 +127,7 @@ static inline void __invlpgb_flush_user_nr_nosync(unsigned long pcid,
 /* Flush all mappings for a given PCID, not including globals. */
 static inline void __invlpgb_flush_single_pcid_nosync(unsigned long pcid)
 {
-	__invlpgb(0, pcid, 0, 1, PTE_STRIDE, INVLPGB_FLAG_PCID);
+	__invlpgb_all(0, pcid, INVLPGB_FLAG_PCID);
 }
 
 /* Flush all mappings, including globals, for all PCIDs. */
@@ -134,7 +140,7 @@ static inline void invlpgb_flush_all(void)
 	 * as it is cheaper.
 	 */
 	guard(preempt)();
-	__invlpgb(0, 0, 0, 1, PTE_STRIDE, INVLPGB_FLAG_INCLUDE_GLOBAL);
+	__invlpgb_all(0, 0, INVLPGB_FLAG_INCLUDE_GLOBAL);
 	__tlbsync();
 }
 
@@ -148,7 +154,7 @@ static inline void __invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
 static inline void invlpgb_flush_all_nonglobals(void)
 {
 	guard(preempt)();
-	__invlpgb(0, 0, 0, 1, PTE_STRIDE, INVLPGB_MODE_ALL_NONGLOBALS);
+	__invlpgb_all(0, 0, INVLPGB_MODE_ALL_NONGLOBALS);
 	__tlbsync();
 }
 #endif /* _ASM_X86_TLB_H */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

