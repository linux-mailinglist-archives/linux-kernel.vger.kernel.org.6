Return-Path: <linux-kernel+bounces-373229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893949A5401
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 14:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A9F1C20AD7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 12:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA2C18E379;
	Sun, 20 Oct 2024 12:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cByJqmkv"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E436B183CA5
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729426720; cv=none; b=I2zzr6zsE3Xks0FmawIFbEATmSKDSDjzcecZAWZFYeI7Ylrr4owNpeCQGPpAUAiQt3ACXc6oYZ2lqIBb5qx+gVWlaA+SfLs9mF2dc/oChrMJL70uDa3daa6UcEFG6KrtJHG57aeCCc8kMwn0pVdXgaLL10h5kuOU3fe0QQTSY1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729426720; c=relaxed/simple;
	bh=wMhgcUBXxtcsocnR4dNWGr75VYXlxTVr1Ddc7Uy1nV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhKe0WdaxDErQH9rvAfYs911ACgtwwKSfamf8sY0l8yZIku9oVL5a7DkqNOIx50jDRYHtZLIjm01Xya90rUS6IYlmNzX5+07OtoH1PzYmFtcE8DOZSkDAW8uptulhZgiX8oEvKFoFa0BMW19FSc1fmtOqUYCjM39qNVyOYAlmSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cByJqmkv; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CD93640E0198;
	Sun, 20 Oct 2024 12:18:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DX8C6zHcCklr; Sun, 20 Oct 2024 12:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729426711; bh=ZpNTHcxB6velOMqReSBsWtZe67EJfLY/fM0C6X6is3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cByJqmkvq6vW9JKV8dhOz0CZyhG5xasKKwRmcuZkkZA8FPEaleMMMPbFnCBc5hTV1
	 2AzwR/l43H1h60jailIDpo6L665qZI0Q7CSY8MwME09CQNoF0mjxqEWpR4dsBwCT7c
	 eUG0STVMgVSD4JYpKGLJEABneDLacfaRiNVSGwTgGBEf4jv09PFaclxLUWlYNri/MZ
	 lkaVnrsrAU9N1IMe4cF4i9E+Y0RcCqeGJbq6pKjNbZOS1VAatOSptlYRCWn4Vah6e1
	 ppd6E0OYSlmFbUMYyMPM1obOvLI4Mwyh8Re9Qf1Fa+8Lt+5Z+pYP9brckRPfa+BnqG
	 5kU9w8KBCwsol40BEZFZ0k9QsocpgzbDUBW96UtiDDTQI5UeDQTIiancFAKQaPcpp7
	 UEUN/wsHmfxbjmIzIeD5LIEFWyVapHk3ma9tkxXz4HuVuR+nAc15/QJblTEHSrsygT
	 LyMwwVwFN5mt63T3apsCGs6PceofbObOgCcOTlgDk0rqdJkXlZ22LHqSDzHtSpXQL0
	 YftHJzHLTo2Kyd3Enno+GVcWlgRrMppvTlDK2UKsEHPz20LVvISAt8nk19i1zvCG0s
	 dNj9iQYcoZEjrtmUDydDCKWsWSxIJ2JoKMHgCtfC51jeTS8qAsEpSN7pdaL1hx+sNJ
	 4KBq9jHWVLpVTFqKSUa6nm5w=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE07F40E0169;
	Sun, 20 Oct 2024 12:18:25 +0000 (UTC)
Date: Sun, 20 Oct 2024 14:18:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: AMD zen microcode updates breaks boot
Message-ID: <20241020121819.GAZxT1CyR_5vLLZ5e6@fat_crate.local>
References: <79296353-1fa3-458a-b055-88bc6a772180@kernel.dk>
 <20241018155143.GIZxKED9YcF0Jg1CWZ@fat_crate.local>
 <320024ab-63af-45eb-a3ae-5486cb2015c0@kernel.dk>
 <20241018175606.GJZxKhNmW9nCLwNS6Z@fat_crate.local>
 <016ecb00-2331-472c-88e4-66b1dbecfc99@kernel.dk>
 <1bb5dd7f-15b5-4d9d-97ef-75ebdc24e7d9@kernel.dk>
 <20241019093748.GAZxN97LS_dJ3DNrpd@fat_crate.local>
 <436b4fc7-6369-40d9-8e88-556cbf5a5687@kernel.dk>
 <20241019232138.GDZxQ_AtkqA9iAR2td@fat_crate.local>
 <b2fd70bb-9414-49e0-bdb8-5c538f247dea@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2fd70bb-9414-49e0-bdb8-5c538f247dea@kernel.dk>

On Sat, Oct 19, 2024 at 09:24:24PM -0600, Jens Axboe wrote:
> This was my initial thought when I saw where it crashed, is this being
> run before node masks are initialized?

Yap, looka here:

...
[   14.195542]  #253
[   13.435208] microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00009
[   13.435208] microcode: ucode_rev_to_cpuid: val: 0xaa00009, p.stepping: 0x0, c.stepping: 0x0
[   13.435208] microcode: ucode_rev_to_cpuid: val: 0xaa00009, p.stepping: 0x0, c.stepping: 0x0
[   13.435208] microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f00, n_cid.full: 0xaa0f00
[   13.435208] microcode: cache_find_patch: using 0xaa00009
[   14.203190]  #254
[   13.435208] microcode: ucode_rev_to_cpuid: val: 0xaa00009, p.stepping: 0x0, c.stepping: 0x0
[   13.435208] microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f00, n_cid.full: 0xaa0f00
[   13.435208] microcode: cache_find_patch: using 0xaa00009
[   13.435208] microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00009
[   14.223125]  #255
[   13.435208] microcode: ucode_rev_to_cpuid: val: 0xaa00009, p.stepping: 0x0, c.stepping: 0x0
[   13.435208] microcode: cache_find_patch: equiv_cpu: 0x0, patch_id: 0xaa00009

<--- Patching on the first node ends here and now it starts fixing up the
NUMA masks:

[   13.435153] numa_add_cpu cpu 1 node 0: mask now 0-1
[   13.435153] numa_add_cpu cpu 2 node 0: mask now 0-2
[   13.435153] numa_add_cpu cpu 3 node 0: mask now 0-3
[   13.435208] microcode: ucode_rev_to_cpuid: val: 0xaa00009, p.stepping: 0x0, c.stepping: 0x0
[   13.435153] numa_add_cpu cpu 4 node 0: mask now 0-4
[   13.435154] numa_add_cpu cpu 5 node 0: mask now 0-5
[   13.435208] microcode: ucode_rev_to_cpuid: val: 0xaa00009, p.stepping: 0x0, c.stepping: 0x0
[   13.435154] numa_add_cpu cpu 6 node 0: mask now 0-6
[   13.435208] microcode: patch_cpus_equivalent: p_cid.full: 0xaa0f00, n_cid.full: 0xaa0f00
[   13.435154] numa_add_cpu cpu 7 node 0: mask now 0-7
[   13.435154] numa_add_cpu cpu 8 node 1: mask now 8
[   13.435154] numa_add_cpu cpu 9 node 1: mask now 8-9
...

so we're clearly too early.

Ok, this diff at the end should fix it completely. I think. The same dance,
replace, build and boot.

I've moved the iteration over the nodes in the late loading path as this is
where we need it only anyway. If you wanna test that too and you feel brave,
do this after the machine boots:

# echo 1 > /sys/devices/system/cpu/microcode/reload

It should say

bash: echo: write error: File descriptor in bad state

because you don't have newer microcode but there will be output in dmesg and
the nodes should look all correct. Like here:

dmesg | grep nid:
[  156.770267] microcode: load_microcode_amd: nid: 0, cpu: 0, c ptr: 0xff11000c1f819020
[  156.829217] microcode: load_microcode_amd: nid: 1, cpu: 8, c ptr: 0xff1100181f619020
[  156.888810] microcode: load_microcode_amd: nid: 2, cpu: 16, c ptr: 0xff11006c1f619020
[  156.950003] microcode: load_microcode_amd: nid: 3, cpu: 24, c ptr: 0xff1100781f619020
[  157.011062] microcode: load_microcode_amd: nid: 4, cpu: 32, c ptr: 0xff11003c1f619020
[  157.071976] microcode: load_microcode_amd: nid: 5, cpu: 40, c ptr: 0xff1100481f619020
[  157.132870] microcode: load_microcode_amd: nid: 6, cpu: 48, c ptr: 0xff11009c1f619020
[  157.193847] microcode: load_microcode_amd: nid: 7, cpu: 56, c ptr: 0xff1100a81f619020
[  157.254828] microcode: load_microcode_amd: nid: 8, cpu: 64, c ptr: 0xff1100541f619020
[  157.315782] microcode: load_microcode_amd: nid: 9, cpu: 72, c ptr: 0xff1100601f619020
[  157.376709] microcode: load_microcode_amd: nid: 10, cpu: 80, c ptr: 0xff1100b41f619020
[  157.437826] microcode: load_microcode_amd: nid: 11, cpu: 88, c ptr: 0xff1100c01f619020
[  157.498932] microcode: load_microcode_amd: nid: 12, cpu: 96, c ptr: 0xff1100241f619020
[  157.559974] microcode: load_microcode_amd: nid: 13, cpu: 104, c ptr: 0xff1100301f619020
[  157.621153] microcode: load_microcode_amd: nid: 14, cpu: 112, c ptr: 0xff1100841f619020
[  157.682331] microcode: load_microcode_amd: nid: 15, cpu: 120, c ptr: 0xff1100901f619020
[  157.743529] microcode: load_microcode_amd: nid: 16, cpu: 128, c ptr: 0xff1101080f619020
[  157.804669] microcode: load_microcode_amd: nid: 17, cpu: 136, c ptr: 0xff1101104f619020
[  157.865863] microcode: load_microcode_amd: nid: 18, cpu: 144, c ptr: 0xff11014a0f619020
[  157.927048] microcode: load_microcode_amd: nid: 19, cpu: 152, c ptr: 0xff1101524f619020
[  157.988263] microcode: load_microcode_amd: nid: 20, cpu: 160, c ptr: 0xff1101290f619020
[  158.049464] microcode: load_microcode_amd: nid: 21, cpu: 168, c ptr: 0xff1101314f619020
[  158.110717] microcode: load_microcode_amd: nid: 22, cpu: 176, c ptr: 0xff11016b0f619020
[  158.171976] microcode: load_microcode_amd: nid: 23, cpu: 184, c ptr: 0xff1101734f619020
[  158.233168] microcode: load_microcode_amd: nid: 24, cpu: 192, c ptr: 0xff1101398f619020
[  158.294369] microcode: load_microcode_amd: nid: 25, cpu: 200, c ptr: 0xff110141cf619020
[  158.355615] microcode: load_microcode_amd: nid: 26, cpu: 208, c ptr: 0xff11017b8f619020
[  158.416845] microcode: load_microcode_amd: nid: 27, cpu: 216, c ptr: 0xff110183c3019020
[  158.478043] microcode: load_microcode_amd: nid: 28, cpu: 224, c ptr: 0xff1101188f619020
[  158.539273] microcode: load_microcode_amd: nid: 29, cpu: 232, c ptr: 0xff110120cf619020
[  158.600503] microcode: load_microcode_amd: nid: 30, cpu: 240, c ptr: 0xff11015a8f619020
[  158.661735] microcode: load_microcode_amd: nid: 31, cpu: 248, c ptr: 0xff110162cf619020

Every node has 8 CPUs in it, as it should.

Anyway, full conglomerate diff below.

Thx.

---
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f63b051f25a0..602fd382e0b5 100644
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
 
@@ -584,7 +587,7 @@ void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_
 		native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->new_rev, dummy);
 }
 
-static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size);
+static enum ucode_state _load_microcode_amd(u8 family, const u8 *data, size_t size);
 
 static int __init save_microcode_in_initrd(void)
 {
@@ -605,7 +608,7 @@ static int __init save_microcode_in_initrd(void)
 	if (!desc.mc)
 		return -EINVAL;
 
-	ret = load_microcode_amd(x86_family(cpuid_1_eax), desc.data, desc.size);
+	ret = _load_microcode_amd(x86_family(cpuid_1_eax), desc.data, desc.size);
 	if (ret > UCODE_UPDATED)
 		return -EINVAL;
 
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
@@ -944,30 +972,45 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 	return UCODE_OK;
 }
 
-static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size)
+static enum ucode_state _load_microcode_amd(u8 family, const u8 *data, size_t size)
 {
-	struct cpuinfo_x86 *c;
-	unsigned int nid, cpu;
-	struct ucode_patch *p;
 	enum ucode_state ret;
 
 	/* free old equiv table */
 	free_equiv_cpu_table();
 
 	ret = __load_microcode_amd(family, data, size);
-	if (ret != UCODE_OK) {
+	if (ret != UCODE_OK)
 		cleanup();
+
+	return ret;
+}
+
+static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size)
+{
+	struct cpuinfo_x86 *c;
+	unsigned int nid, cpu;
+	struct ucode_patch *p;
+	enum ucode_state ret;
+
+	ret = _load_microcode_amd(family, data, size);
+	if (ret != UCODE_OK)
 		return ret;
-	}
 
 	for_each_node(nid) {
 		cpu = cpumask_first(cpumask_of_node(nid));
 		c = &cpu_data(cpu);
 
+		pr_info("%s: nid: %d, cpu: %d, c ptr: 0x%px\n",
+			__func__, nid, cpu, c);
+
 		p = find_patch(cpu);
 		if (!p)
 			continue;
 
+		pr_info("%s: microcode: 0x%x, patch_id: 0x%x\n",
+			__func__, c->microcode, p->patch_id);
+
 		if (c->microcode >= p->patch_id)
 			continue;
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

