Return-Path: <linux-kernel+bounces-369596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C41399A1F54
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70631C21582
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592D91D9327;
	Thu, 17 Oct 2024 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UxttWpvi"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20021D9665
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159405; cv=none; b=FnREV6NQkvqZ4zuIk9k6UVjBhlz78WMcCkPmYhe/MPQSNMurljZv/rzA1bnbcKZvxfY1yJ4n2weyQxpE/KZXRaQoV7vNfwc4TMggLwZJ9Su6NY1KSfnnlMmo/P/Z/BbHQqzpX6lQil7QQJGuyplcClxexxZH3Nv1hSBekb2pZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159405; c=relaxed/simple;
	bh=ygrGK82PCX2dAMosS7CWMo19c3iWobo+UGLhf9gtn2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XL/nhhXCO+nz3WdWgOa8cKUMPQCPBAsXg76x9B1LD41bQ25sCdIZGxgyDOUMN5v0puYb7zgIg0m4FVOqSuo4VcdjyMJX2zIzX9S6NSbsNBmEW73qk0e7iwbQJnGB1L/6H1poWT8rysrQ1dsDCs51BCfPOtVshdp3FNCOPtzJbyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UxttWpvi; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8C73E40E0219;
	Thu, 17 Oct 2024 10:03:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EsCnHj8DMX-4; Thu, 17 Oct 2024 10:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729159388; bh=V0GRidANyNTNe0dqShfeUwN5d4P9zDXZ9fBjbBPScR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UxttWpvi6M8q3qkc+waz/DaSIbDTDZfvy6odxhRE5F6QfF4X9oA0e144gO9iZXjR/
	 jHO9mqQqLy6VxqZTBshlxPHBJqQ2GosPSawg0CiYCjMcoZVC+4Zpd/Yj+tZLjSsuzL
	 Kq/TnXjsZpN4xptTc43w+LW2DJb8J/V1wTC5duK+VUXkQjg+idUK38o+ljTr/fA4hA
	 BLXU7/j4ghzx55bxqXUMO6kklOZ1JOp+8zP2iawWd+xLnn9F0ULl9sRweN4WwOQv3w
	 lNvPg5nFkE+l+3+dQp1eIqjQFt7w0ptnqEGxaZXzKpnf0DthGNcWAIabPjfFT3/KpG
	 bzQBLYhWWadAe8UKDJHb/F84wtnLe3mh+SmJ6YiXfUeIi12Dg2o2+pQmPwNLYsnJqY
	 DC66wbbGkVaKISXFrr/l5C/Q840aQCCCcYkV3soB5FdAoZFgH7Uf/DpTJG2SSlCSEc
	 ZTPk1Klo0Ylnl35D1HBesL/Whv7e0hDZQwIn44dYkoV7qH7jEhUOi7wNC6glZEzRAX
	 79dzUWgaSuwkOspYCw6crdF5NeguIB0wUsjmDMMEhAWB/uhdbgltkF+JeGeCpbQ6mp
	 UwHB24nIwSdNlEr9lteYUaP8cyLp66Z831jAsXmaCYn5CVvJS3m/B30PzRreExjNQf
	 tJebBFg7toT9P8Mb7kFai06s=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0841A40E0169;
	Thu, 17 Oct 2024 10:03:02 +0000 (UTC)
Date: Thu, 17 Oct 2024 12:02:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: AMD zen microcode updates breaks boot
Message-ID: <20241017100257.GAZxDg0VqDAesee00m@fat_crate.local>
References: <5fe1e264-c285-4988-b1e3-46771d07172b@kernel.dk>
 <20240930044313.GAZvosYZF5mHi2OZbC@fat_crate.local>
 <d7aff674-ad92-4a36-9ebf-8d3c42774723@kernel.dk>
 <CC418B80-5ED9-4F64-917F-BA6F94130F83@alien8.de>
 <ad9638b4-0a4a-4cd0-9fcb-2690693da157@kernel.dk>
 <20241009091247.GCZwZJDwFETmN5pEGe@fat_crate.local>
 <77f16324-47e1-41e6-a9e9-2cb7cbc8d14d@kernel.dk>
 <20241010134613.GDZwfapaZ8AKp0n72C@fat_crate.local>
 <842a76fe-3d6a-4846-83da-bb113634b8bc@kernel.dk>
 <13fe104b-d83b-4d6d-a348-1103d402540d@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13fe104b-d83b-4d6d-a348-1103d402540d@kernel.dk>

On Wed, Oct 16, 2024 at 08:34:09PM -0600, Jens Axboe wrote:
> And then I totally forgot... Got it done now, but it still just hangs
> after loading the kernel. No output.

Hmm...

Let's verify it still actually selects the correct patch. Diff below, it
should boot with it as it won't apply the microcode and you should be able to
gather dmesg.

Thx.

---

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f63b051f25a0..ed5474cf683f 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -158,6 +158,9 @@ static union cpuid_1_eax ucode_rev_to_cpuid(unsigned int val)
 	c.family    = 0xf;
 	c.ext_fam   = p.ext_fam;
 
+	pr_info("%s: val: 0x%x, p.stepping: 0x%x, c.stepping: 0x%x\n",
+		__func__, val, p.stepping, c.stepping);
+
 	return c;
 }
 
@@ -487,11 +490,13 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
 {
 	u32 rev, dummy;
 
-	native_wrmsrl(MSR_AMD64_PATCH_LOADER, (u64)(long)&mc->hdr.data_code);
+//	native_wrmsrl(MSR_AMD64_PATCH_LOADER, (u64)(long)&mc->hdr.data_code);
 
 	/* verify patch application was successful */
 	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
+	pr_info("%s: applying 0x%x, rev: 0x%x\n", __func__, mc->hdr.patch_id, rev);
+
 	if (rev != mc->hdr.patch_id)
 		return -1;
 
@@ -613,16 +618,22 @@ static int __init save_microcode_in_initrd(void)
 }
 early_initcall(save_microcode_in_initrd);
 
-static inline bool patch_cpus_equivalent(struct ucode_patch *p, struct ucode_patch *n)
+static inline bool patch_cpus_equivalent(struct ucode_patch *p,
+					 struct ucode_patch *n,
+					 bool ignore_stepping)
 {
 	/* Zen and newer hardcode the f/m/s in the patch ID */
         if (x86_family(bsp_cpuid_1_eax) >= 0x17) {
 		union cpuid_1_eax p_cid = ucode_rev_to_cpuid(p->patch_id);
 		union cpuid_1_eax n_cid = ucode_rev_to_cpuid(n->patch_id);
 
-		/* Zap stepping */
-		p_cid.stepping = 0;
-		n_cid.stepping = 0;
+		if (ignore_stepping) {
+			p_cid.stepping = 0;
+			n_cid.stepping = 0;
+		}
+
+		pr_info("%s: p_cid.full: 0x%x, n_cid.full: 0x%x\n",
+			__func__, p_cid.full, n_cid.full);
 
 		return p_cid.full == n_cid.full;
 	} else {
@@ -641,16 +652,22 @@ static struct ucode_patch *cache_find_patch(struct ucode_cpu_info *uci, u16 equi
 	n.equiv_cpu = equiv_cpu;
 	n.patch_id  = uci->cpu_sig.rev;
 
+	pr_info("%s: equiv_cpu: 0x%x, patch_id: 0x%x\n",
+		__func__, equiv_cpu, uci->cpu_sig.rev);
+
 	WARN_ON_ONCE(!n.patch_id);
 
-	list_for_each_entry(p, &microcode_cache, plist)
-		if (patch_cpus_equivalent(p, &n))
+	list_for_each_entry(p, &microcode_cache, plist) {
+		if (patch_cpus_equivalent(p, &n, false)) {
+			pr_info("%s: using 0x%x\n", __func__, p->patch_id);
 			return p;
+		}
+	}
 
 	return NULL;
 }
 
-static inline bool patch_newer(struct ucode_patch *p, struct ucode_patch *n)
+static inline int patch_newer(struct ucode_patch *p, struct ucode_patch *n)
 {
 	/* Zen and newer hardcode the f/m/s in the patch ID */
         if (x86_family(bsp_cpuid_1_eax) >= 0x17) {
@@ -659,6 +676,9 @@ static inline bool patch_newer(struct ucode_patch *p, struct ucode_patch *n)
 		zp.ucode_rev = p->patch_id;
 		zn.ucode_rev = n->patch_id;
 
+		if (zn.stepping != zp.stepping)
+			return -1;
+
 		return zn.rev > zp.rev;
 	} else {
 		return n->patch_id > p->patch_id;
@@ -668,22 +688,32 @@ static inline bool patch_newer(struct ucode_patch *p, struct ucode_patch *n)
 static void update_cache(struct ucode_patch *new_patch)
 {
 	struct ucode_patch *p;
+	int ret;
 
 	list_for_each_entry(p, &microcode_cache, plist) {
-		if (patch_cpus_equivalent(p, new_patch)) {
-			if (!patch_newer(p, new_patch)) {
+		if (patch_cpus_equivalent(p, new_patch, true)) {
+			ret = patch_newer(p, new_patch);
+			if (ret < 0)
+				continue;
+			else if (!ret) {
 				/* we already have the latest patch */
 				kfree(new_patch->data);
 				kfree(new_patch);
 				return;
 			}
 
+			pr_info("%s: replace 0x%x with 0x%x\n",
+				__func__, p->patch_id, new_patch->patch_id);
+
 			list_replace(&p->plist, &new_patch->plist);
 			kfree(p->data);
 			kfree(p);
 			return;
 		}
 	}
+
+	pr_info("%s: add patch: 0x%x\n", __func__, new_patch->patch_id);
+
 	/* no patch found, add it */
 	list_add_tail(&new_patch->plist, &microcode_cache);
 }



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

