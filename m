Return-Path: <linux-kernel+bounces-411338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7EE9CF667
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 21:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58902B2CF4B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EF61E1C1F;
	Fri, 15 Nov 2024 20:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OftRhs0q"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE97153800
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703895; cv=none; b=JESJ3r0O72xLCPLS2SPQLqF2IbFyDW1w9bP5ZGcBIICK+Gd4L1hfBzbgbvgQMG+Eu6vyVXVnkCUbyXcD2bILsaitftIqL41O/ibyZVvdD72JCBjNBwf6RycJBQd6UnaHMAx9LrC+awvfKJRUaRchRsUzUPyV7z/fP6o2BcR8bQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703895; c=relaxed/simple;
	bh=W6UhL1DKsGa4aQZ5xbQ2Ij8+hstJlBcFtk6mvx1RMM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZOEWiBV0VtFa9JpXxJHCxajENr7FF49HnGOrcGTVviUYoqGLmETEPplhgNdYHux5M0joOJYP5scKiuQR0vXOP7icQRyJsDEeIxenGzQslnlsxUfexHE74OfaElwcbZg9tDtxpFnIEP2FPpcEoXEwWiWKP1ywU6t2sboc4PH/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OftRhs0q reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9853F40E0220;
	Fri, 15 Nov 2024 20:51:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VnSskKyvX2tW; Fri, 15 Nov 2024 20:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731703883; bh=p6RY9rUR70Ge2i3mH9dtFytlPyOxJdsGa0g+hfgXb2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OftRhs0qW9YnkO/wjSK0Q095GG9vvSJSRW7+fhBfrxX/kT0GmRGk4vbkc2ro7fjLB
	 F4KpQLZHbjnyvKJWUJg0WeXTPWSOCuhXf8RsFuGfyUnvaN4ef5YuaBdpgq3Wv89zQb
	 l/oBgTKhKsvhF6Ridbt2DAyf5tdVwSwW9r29QaABtL0XuXZ01LxFjVS5auwqcJnrt1
	 jm7L3Favzqv1ZNvi2sQGErJD7NXY9VAycU3Xf09drRR3VHgLDnhBKsrWBKW5nkt5ta
	 YaNIiBcUjblLY72BcssADgf+NyIuoMGL3YMcsuxhydLKTDlo4ktMUv8Xp9xuhd/tWI
	 xQQC2oIfgUFNDPZKJuaaEWFoRJz+uCYJBuLW0+cdSj4+Y2TsHoCGL9ZmloD6WBML/F
	 Dys1llX2hppH31ZwnEJ6OUECBbssrZfK5Cq0IjqxoxCcUOL2dD90D07OTRv4dYIovk
	 lxAe7B8G90UFc4BfekIZYBR3W/nupi6I4bPE2a5SZZE/dHqkz05NOCp6dIQkeXFoQz
	 1tKg+9m8hrTpUblfhbk2KsbeGpIbt8KMxOXs2bP7G97Qv59OR3Vx1kAQKEHRRe9PBa
	 dOFdIBZ/vajHilNiUk7Pa4Ubv6BEYASym9m/2E5GVk5Td3iJlvj2HXIcb5mrsW5Wya
	 5SNX6bTxj1tRlLLQDK3nbteQ=
Received: from zn.tnic (p200300ea9736a1b1329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a1b1:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6538C40E0276;
	Fri, 15 Nov 2024 20:51:19 +0000 (UTC)
Date: Fri, 15 Nov 2024 21:51:14 +0100
From: Borislav Petkov <bp@alien8.de>
To: Andrew Cooper <andrew.cooper3@citrix.com>,
	Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: x86/amd late microcode thread loading slows down boot
Message-ID: <20241115205114.GCZze0QtUKbeXdFEHe@fat_crate.local>
References: <ZyulbYuvrkshfsd2@antipodes>
 <6449aa6c-43b1-40eb-ab54-48803481d11b@citrix.com>
 <20241107153036.GCZyzdHEwm9-LPQOzY@fat_crate.local>
 <Zy0p5DT0SOWsCDn7@antipodes>
 <20241114095639.GDZzXJV1EDJlMqv24c@fat_crate.local>
 <3f6a84bd-af4a-4ffa-8205-25b2c9084893@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f6a84bd-af4a-4ffa-8205-25b2c9084893@citrix.com>
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 12:03:41PM +0000, Andrew Cooper wrote:
> "invlpg %0" :: "m" (*(char *)addr) : "memory"
>=20
> The compiler can usually do a better job than forcing it into a plain
> register.

I guess. I'll do that in the final version as the invlpg carve out will b=
e
a separate patch.

> Ok, so it's Fam17h specific.=C2=A0 That's good to know.=C2=A0 Any forma=
l statement
> on the matter from AMD ?

You can use my commit message for now... I'm working on something more
formal although I have no idea yet what format that should have ...

> However, these blobs are 3200 bytes long and come with a good chance of
> crossing a page boundary.=C2=A0=C2=A0 If you're invlpg'ing, you need to=
 issue a
> second one for the final byte of the image too.

Right, see below. It works here, Thomas you could give it a try too.

---
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 580636cdc257..4d3c9d00d6b6 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -34,4 +34,8 @@ static inline void __tlb_remove_table(void *table)
 	free_page_and_swap_cache(table);
 }
=20
+static inline void invlpg(unsigned long addr)
+{
+	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
+}
 #endif /* _ASM_X86_TLB_H */
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/mi=
crocode/amd.c
index c4991226c86b..fdd4f8ef3696 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -34,6 +34,7 @@
 #include <asm/setup.h>
 #include <asm/cpu.h>
 #include <asm/msr.h>
+#include <asm/tlb.h>
=20
 #include "internal.h"
=20
@@ -483,11 +484,23 @@ static void scan_containers(u8 *ucode, size_t size,=
 struct cont_desc *desc)
 	}
 }
=20
-static int __apply_microcode_amd(struct microcode_amd *mc)
+static int __apply_microcode_amd(struct microcode_amd *mc, unsigned int =
psize)
 {
+	unsigned long p_addr =3D (unsigned long)&mc->hdr.data_code;
 	u32 rev, dummy;
=20
-	native_wrmsrl(MSR_AMD64_PATCH_LOADER, (u64)(long)&mc->hdr.data_code);
+	native_wrmsrl(MSR_AMD64_PATCH_LOADER, p_addr);
+
+	if (x86_family(bsp_cpuid_1_eax) =3D=3D 0x17) {
+		invlpg(p_addr);
+
+		/*
+		 * Flush next page too if patch image is crossing a page
+		 * boundary.
+		 */
+		if (p_addr >> PAGE_SHIFT !=3D (p_addr + psize) >> PAGE_SHIFT)
+			invlpg(p_addr + psize);
+	}
=20
 	/* verify patch application was successful */
 	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
@@ -529,7 +542,7 @@ static bool early_apply_microcode(u32 old_rev, void *=
ucode, size_t size)
 	if (old_rev > mc->hdr.patch_id)
 		return ret;
=20
-	return !__apply_microcode_amd(mc);
+	return !__apply_microcode_amd(mc, desc.psize);
 }
=20
 static bool get_builtin_microcode(struct cpio_data *cp)
@@ -748,7 +761,7 @@ void reload_ucode_amd(unsigned int cpu)
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
=20
 	if (rev < mc->hdr.patch_id) {
-		if (!__apply_microcode_amd(mc))
+		if (!__apply_microcode_amd(mc, p->size))
 			pr_info_once("reload revision: 0x%08x\n", mc->hdr.patch_id);
 	}
 }
@@ -801,7 +814,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 		goto out;
 	}
=20
-	if (__apply_microcode_amd(mc_amd)) {
+	if (__apply_microcode_amd(mc_amd, p->size)) {
 		pr_err("CPU%d: update failed for patch_level=3D0x%08x\n",
 			cpu, mc_amd->hdr.patch_id);
 		return UCODE_ERROR;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 86593d1b787d..b0678d59ebdb 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -20,6 +20,7 @@
 #include <asm/cacheflush.h>
 #include <asm/apic.h>
 #include <asm/perf_event.h>
+#include <asm/tlb.h>
=20
 #include "mm_internal.h"
=20
@@ -1140,7 +1141,7 @@ STATIC_NOPV void native_flush_tlb_one_user(unsigned=
 long addr)
 	bool cpu_pcide;
=20
 	/* Flush 'addr' from the kernel PCID: */
-	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
+	invlpg(addr);
=20
 	/* If PTI is off there is no user PCID and nothing to flush. */
 	if (!static_cpu_has(X86_FEATURE_PTI))


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

