Return-Path: <linux-kernel+bounces-359159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D9899882D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C009BB2620F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A1A1CC165;
	Thu, 10 Oct 2024 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C9nWdS5K"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828F41CC166
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567994; cv=none; b=ZDqe8q+ARITD9Dsix2PYhAZzSRZd2cnEunTDN/kOY0TAMH09lAp/WAp6jF1g3FkN1gfIBhMnxxFQeBALyOi1dYouMiI/fLR9b0NvJekxbWICRfqDltWHFCGXBlyXDj3XpcNFt3H3JtU2MzvrTSszKHZRTVF664dddQpmxid9riI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567994; c=relaxed/simple;
	bh=kxwnuoRgznzMWKR1GUcu3Eeo6EmHiTHQfQGeaHhFH2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMaEZi9pFP9CWMOcb4ydGi0HSlYIk0n6GntlimQxRlx64yy5zh1TnS8NeK+dgy8TWLQxeO22ziC1qhSp91O49bHNNz5mVNYzS9PQ8UCc4vPkv+pKddXNyNo2I9I5GvWMk12YZYZM8F2wrSOHypUIx3yvDFVdpVmRLYQIRfmkcV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C9nWdS5K; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D951240E021E;
	Thu, 10 Oct 2024 13:46:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yLkKMBmRAwUH; Thu, 10 Oct 2024 13:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728567984; bh=7hjuHc4jpSAMiGb3DODnY0ZTD80hGS4JorsPjBzexME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9nWdS5Kf877iBM2QC7vcodXj9HVpF9awID6I+luFtR+J09aXPYvmuzwYUytOv4jf
	 oIf8ynERYeFE3GsAFwEdIW4xlsw7aD2EfI3Tbx/zuzLOjIkg2oRl21SQIebM3TmxIg
	 rbOaL4PKuas5m7xh1OctJ/pTUiVRzeFok5cY3iC56mhoUrPpS5t3ppjVPmJZEZZR0l
	 8ECYtWJgr7O199rMiB8D7cM4WrgXSeKZ3fRhoQ3etdEkH27frQVXwe5r2jwpTTyPPU
	 yHXG8BOlbz15t23x9icUbWhHxE21TujUWUXuDx6Nixi/9xWo/Zx4dAWtDQCrBT9YI0
	 uJqkaTK0QH1qRySCpZ6HrLX60B/pSyur2kvoWrjDv1zfuZMNFXXCIKs8L2nJjtt7zO
	 n6Lw7W9rK4tOT6nHnCN57GpRuLlUzHp0f7WjpimRcUaDciVQVmBusXnZOMkU3trj7N
	 zrTl4TatYFFh4rkgjyTfRulPqfAZc03BDhUVMcUP7jYWDQfBakWQKINxdY0H0YqA6T
	 EzdmxSQDDXUR5UNhvYsFaSchS5zLYzWe4M2yrJY+qimLKCMMuFXgaQDKGlZuUjF+HP
	 VcVMK2GMytnIB43MfGYTiB+T3scjuj/z+mqTx0It2fafPgcuMIm3Th90Los5ANqdw5
	 rXeWK1eQ+dTNKdh5VvJJztB0=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 859A240E0191;
	Thu, 10 Oct 2024 13:46:19 +0000 (UTC)
Date: Thu, 10 Oct 2024 15:46:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: AMD zen microcode updates breaks boot
Message-ID: <20241010134613.GDZwfapaZ8AKp0n72C@fat_crate.local>
References: <91194406-3fdf-4e38-9838-d334af538f74@kernel.dk>
 <20240928061038.GAZved3hMSU3XahWrJ@fat_crate.local>
 <5fe1e264-c285-4988-b1e3-46771d07172b@kernel.dk>
 <20240930044313.GAZvosYZF5mHi2OZbC@fat_crate.local>
 <d7aff674-ad92-4a36-9ebf-8d3c42774723@kernel.dk>
 <CC418B80-5ED9-4F64-917F-BA6F94130F83@alien8.de>
 <ad9638b4-0a4a-4cd0-9fcb-2690693da157@kernel.dk>
 <20241009091247.GCZwZJDwFETmN5pEGe@fat_crate.local>
 <77f16324-47e1-41e6-a9e9-2cb7cbc8d14d@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <77f16324-47e1-41e6-a9e9-2cb7cbc8d14d@kernel.dk>

On Wed, Oct 09, 2024 at 05:04:23AM -0600, Jens Axboe wrote:
> Yep, 0xaa00215

Found something: I'm not handling the stepping properly, below is a big diff
along with debug printks. Can you pls run it and send me dmesg. I'm assuming
the box will boot with it.

Thx.

---

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f63b051f25a0..a86fd2684913 100644
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
 
@@ -613,16 +616,22 @@ static int __init save_microcode_in_initrd(void)
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
@@ -641,16 +650,22 @@ static struct ucode_patch *cache_find_patch(struct ucode_cpu_info *uci, u16 equi
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
@@ -659,6 +674,9 @@ static inline bool patch_newer(struct ucode_patch *p, struct ucode_patch *n)
 		zp.ucode_rev = p->patch_id;
 		zn.ucode_rev = n->patch_id;
 
+		if (zn.stepping != zp.stepping)
+			return -1;
+
 		return zn.rev > zp.rev;
 	} else {
 		return n->patch_id > p->patch_id;
@@ -668,22 +686,32 @@ static inline bool patch_newer(struct ucode_patch *p, struct ucode_patch *n)
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

