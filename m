Return-Path: <linux-kernel+bounces-262090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D9493C0A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE89282A32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67F81991D7;
	Thu, 25 Jul 2024 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="H1wUPdb1"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FD873440
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721906459; cv=none; b=P3Y2pCRmP/m9hoVQUYB0O5B6UoQlEZ6UcNrQs77cOiDAIFySZzLaCP+3KjAm+lcAPLlBPkyz/JHcwlDyC7pgMCYugBZNSBWMEdWQatCfD7RVzP1s0yRpVV1UqKG0dfAWEZNKvoOgTk3OApt0+7owCoXTkD+BgiBFw2ZnoAna1to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721906459; c=relaxed/simple;
	bh=SVIVQ98eWlp3ti4NbrRQgitmINxY8s/p7G5VDJQYfZo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T11WD7ybxDfZjYTqxuUPRw2/LnKpmI/BwI3eS1n97A+su1d0C31ncYoppqnXrR9/uaLNaIGFG1Ehc0rUUF9XH/AI3KU2EKQS44/7EpjLD2iEavRJ4FwkyiSWCz5qoKEpL/bgABE1OPAvGLAZAUtpWVl6zhhNF/qs1FQVqudyqho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=H1wUPdb1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 04ABC40E0206;
	Thu, 25 Jul 2024 11:20:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id msHIAvOitGbm; Thu, 25 Jul 2024 11:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721906448; bh=fP9y1XKRzFHuFQ4NNdPnynKzo0pKHQvLxZHs1S/Hg4o=;
	h=Date:From:To:Cc:Subject:From;
	b=H1wUPdb1dijZR/McXP5R5hAj74fOG+N09wyPr0Sq3JupzjWtsJiy/IDPUrZA45uji
	 CrMGDjaM9K5VHu197dPeZUj+lFp2NY16rEPRanPw9SOK4EQKQi3++ipiBgOjZ4+z16
	 SFX5bzSs1xLE+r6oGMhtlZn/4wrGMd/aJ+HpSUBeSFo2g5cOi99wZDq2r+jHIx8pbp
	 ogGTRxYN3Gwz8yHNR6AihjsOa1NA/iAMjxANgFOiKDwhMRsvwQhI7ava0uYvvU19Vk
	 VMWKtvSlAJ44FhvzSXn86sVYqidTLCtQDLFFxtPx/kOoytBa8XeCATuid6UZww1l6R
	 g9poE0FaFGutJ4SSScL1sJCP++rObsKF8G32+/Mu7G9tKNUQ3IOBv//pTzn+Ea53SR
	 C+rbkcGw5osJcMZzVNy5O2gHCKAVI22bGYV4KppnMEUQeM7QMoNsWULCQjEbjFUL3q
	 VnmVwyRlvRBJta+m/QzzOcBDXidJu8DKzc19JQNpnxCPsR0oZgq13NB6XTsib2EhgT
	 WwfFaETepWv398w6VB/ysQpQLIWEPTzD7goaCecwX3HZbE3KvXsLcfWEdWLl0kVpTy
	 FpPi0AIPGZgZopdOjiPcOVt+p5dF0Ylvvo6NaCLItPwznlthi823XZK/19V/goqhVy
	 tOM46A8ZStHXYck+kuO+DdTU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0BA8840E01B3;
	Thu, 25 Jul 2024 11:20:44 +0000 (UTC)
Date: Thu, 25 Jul 2024 13:20:37 +0200
From: Borislav Petkov <bp@alien8.de>
To: John Allen <john.allen@amd.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/microcode/AMD: Use the family,model,stepping encoded in
 the patch ID
Message-ID: <20240725112037.GBZqI1BbUk1KMlOJ_D@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
x86/microcode/AMD: Use the family,model,stepping encoded in the patch ID

On Zen and newer, the family, model and stepping is part of the
microcode patch ID so that the equivalence table the driver has been
using, is not needed anymore.

So switch the driver to use that from now on.

The equivalence table in the microcode blob should still remain in case
there's need to pass some additional information to the kernel loader.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index c0d56c02b8da..1f5d36f92b8a 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -89,6 +89,31 @@ static struct equiv_cpu_table {
 	struct equiv_cpu_entry *entry;
 } equiv_table;
 
+union zen_patch_rev {
+	struct {
+		__u32 rev	 : 8,
+		      stepping	 : 4,
+		      model	 : 4,
+		      __reserved : 4,
+		      ext_model	 : 4,
+		      ext_fam	 : 8;
+	};
+	__u32 ucode_rev;
+};
+
+union cpuid_1_eax {
+	struct {
+		__u32 stepping    : 4,
+		      model	  : 4,
+		      family	  : 4,
+		      __reserved0 : 4,
+		      ext_model   : 4,
+		      ext_fam     : 8,
+		      __reserved1 : 4;
+	};
+	__u32 full;
+};
+
 /*
  * This points to the current valid container of microcode patches which we will
  * save from the initrd/builtin before jettisoning its contents. @mc is the
@@ -96,7 +121,6 @@ static struct equiv_cpu_table {
  */
 struct cont_desc {
 	struct microcode_amd *mc;
-	u32		     cpuid_1_eax;
 	u32		     psize;
 	u8		     *data;
 	size_t		     size;
@@ -109,10 +133,42 @@ struct cont_desc {
 static const char
 ucode_path[] __maybe_unused = "kernel/x86/microcode/AuthenticAMD.bin";
 
+/*
+ * This is CPUID(1).EAX on the BSP. It is used in two ways:
+ *
+ * 1. To ignore the equivalence table on Zen1 and newer.
+ *
+ * 2. To match which patches to load because the patch revision ID
+ *    already contains the f/m/s for which the microcode is destined
+ *    for.
+ */
+static u32 bsp_cpuid_1_eax __ro_after_init;
+
+static union cpuid_1_eax ucode_rev_to_cpuid(unsigned int val)
+{
+	union zen_patch_rev p;
+	union cpuid_1_eax c;
+
+	p.ucode_rev = val;
+	c.full = 0;
+
+	c.stepping  = p.stepping;
+	c.model     = p.model;
+	c.ext_model = p.ext_model;
+	c.family    = 0xf;
+	c.ext_fam   = p.ext_fam;
+
+	return c;
+}
+
 static u16 find_equiv_id(struct equiv_cpu_table *et, u32 sig)
 {
 	unsigned int i;
 
+	/* Zen and newer do not need an equivalence table. */
+	if (x86_family(bsp_cpuid_1_eax) >= 0x17)
+		return 0;
+
 	if (!et || !et->num_entries)
 		return 0;
 
@@ -159,6 +215,10 @@ static bool verify_equivalence_table(const u8 *buf, size_t buf_size)
 	if (!verify_container(buf, buf_size))
 		return false;
 
+	/* Zen and newer do not need an equivalence table. */
+	if (x86_family(bsp_cpuid_1_eax) >= 0x17)
+		return true;
+
 	cont_type = hdr[1];
 	if (cont_type != UCODE_EQUIV_CPU_TABLE_TYPE) {
 		pr_debug("Wrong microcode container equivalence table type: %u.\n",
@@ -222,8 +282,9 @@ __verify_patch_section(const u8 *buf, size_t buf_size, u32 *sh_psize)
  * exceed the per-family maximum). @sh_psize is the size read from the section
  * header.
  */
-static unsigned int __verify_patch_size(u8 family, u32 sh_psize, size_t buf_size)
+static unsigned int __verify_patch_size(u32 sh_psize, size_t buf_size)
 {
+	u8 family = x86_family(bsp_cpuid_1_eax);
 	u32 max_size;
 
 	if (family >= 0x15)
@@ -258,9 +319,9 @@ static unsigned int __verify_patch_size(u8 family, u32 sh_psize, size_t buf_size
  * positive: patch is not for this family, skip it
  * 0: success
  */
-static int
-verify_patch(u8 family, const u8 *buf, size_t buf_size, u32 *patch_size)
+static int verify_patch(const u8 *buf, size_t buf_size, u32 *patch_size)
 {
+	u8 family = x86_family(bsp_cpuid_1_eax);
 	struct microcode_header_amd *mc_hdr;
 	unsigned int ret;
 	u32 sh_psize;
@@ -286,7 +347,7 @@ verify_patch(u8 family, const u8 *buf, size_t buf_size, u32 *patch_size)
 		return -1;
 	}
 
-	ret = __verify_patch_size(family, sh_psize, buf_size);
+	ret = __verify_patch_size(sh_psize, buf_size);
 	if (!ret) {
 		pr_debug("Per-family patch size mismatch.\n");
 		return -1;
@@ -308,6 +369,15 @@ verify_patch(u8 family, const u8 *buf, size_t buf_size, u32 *patch_size)
 	return 0;
 }
 
+static bool mc_patch_matches(struct microcode_amd *mc, u16 eq_id)
+{
+	/* Zen and newer do not need an equivalence table. */
+	if (x86_family(bsp_cpuid_1_eax) >= 0x17)
+		return ucode_rev_to_cpuid(mc->hdr.patch_id).full == bsp_cpuid_1_eax;
+	else
+		return eq_id == mc->hdr.processor_rev_id;
+}
+
 /*
  * This scans the ucode blob for the proper container as we can have multiple
  * containers glued together. Returns the equivalence ID from the equivalence
@@ -336,7 +406,7 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 	 * doesn't contain a patch for the CPU, scan through the whole container
 	 * so that it can be skipped in case there are other containers appended.
 	 */
-	eq_id = find_equiv_id(&table, desc->cpuid_1_eax);
+	eq_id = find_equiv_id(&table, bsp_cpuid_1_eax);
 
 	buf  += hdr[2] + CONTAINER_HDR_SZ;
 	size -= hdr[2] + CONTAINER_HDR_SZ;
@@ -350,7 +420,7 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 		u32 patch_size;
 		int ret;
 
-		ret = verify_patch(x86_family(desc->cpuid_1_eax), buf, size, &patch_size);
+		ret = verify_patch(buf, size, &patch_size);
 		if (ret < 0) {
 			/*
 			 * Patch verification failed, skip to the next container, if
@@ -363,7 +433,7 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 		}
 
 		mc = (struct microcode_amd *)(buf + SECTION_HDR_SIZE);
-		if (eq_id == mc->hdr.processor_rev_id) {
+		if (mc_patch_matches(mc, eq_id)) {
 			desc->psize = patch_size;
 			desc->mc = mc;
 		}
@@ -421,6 +491,7 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
 
 	/* verify patch application was successful */
 	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
+
 	if (rev != mc->hdr.patch_id)
 		return -1;
 
@@ -438,14 +509,12 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
  *
  * Returns true if container found (sets @desc), false otherwise.
  */
-static bool early_apply_microcode(u32 cpuid_1_eax, u32 old_rev, void *ucode, size_t size)
+static bool early_apply_microcode(u32 old_rev, void *ucode, size_t size)
 {
 	struct cont_desc desc = { 0 };
 	struct microcode_amd *mc;
 	bool ret = false;
 
-	desc.cpuid_1_eax = cpuid_1_eax;
-
 	scan_containers(ucode, size, &desc);
 
 	mc = desc.mc;
@@ -463,9 +532,10 @@ static bool early_apply_microcode(u32 cpuid_1_eax, u32 old_rev, void *ucode, siz
 	return !__apply_microcode_amd(mc);
 }
 
-static bool get_builtin_microcode(struct cpio_data *cp, u8 family)
+static bool get_builtin_microcode(struct cpio_data *cp)
 {
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
+	u8 family = x86_family(bsp_cpuid_1_eax);
 	struct firmware fw;
 
 	if (IS_ENABLED(CONFIG_X86_32))
@@ -484,11 +554,11 @@ static bool get_builtin_microcode(struct cpio_data *cp, u8 family)
 	return false;
 }
 
-static void __init find_blobs_in_containers(unsigned int cpuid_1_eax, struct cpio_data *ret)
+static void __init find_blobs_in_containers(struct cpio_data *ret)
 {
 	struct cpio_data cp;
 
-	if (!get_builtin_microcode(&cp, x86_family(cpuid_1_eax)))
+	if (!get_builtin_microcode(&cp))
 		cp = find_microcode_in_initrd(ucode_path);
 
 	*ret = cp;
@@ -499,16 +569,18 @@ void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_
 	struct cpio_data cp = { };
 	u32 dummy;
 
+	bsp_cpuid_1_eax = cpuid_1_eax;
+
 	native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->old_rev, dummy);
 
 	/* Needed in load_microcode_amd() */
 	ucode_cpu_info[0].cpu_sig.sig = cpuid_1_eax;
 
-	find_blobs_in_containers(cpuid_1_eax, &cp);
+	find_blobs_in_containers(&cp);
 	if (!(cp.data && cp.size))
 		return;
 
-	if (early_apply_microcode(cpuid_1_eax, ed->old_rev, cp.data, cp.size))
+	if (early_apply_microcode(ed->old_rev, cp.data, cp.size))
 		native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->new_rev, dummy);
 }
 
@@ -525,12 +597,10 @@ static int __init save_microcode_in_initrd(void)
 	if (dis_ucode_ldr || c->x86_vendor != X86_VENDOR_AMD || c->x86 < 0x10)
 		return 0;
 
-	find_blobs_in_containers(cpuid_1_eax, &cp);
+	find_blobs_in_containers(&cp);
 	if (!(cp.data && cp.size))
 		return -EINVAL;
 
-	desc.cpuid_1_eax = cpuid_1_eax;
-
 	scan_containers(cp.data, cp.size, &desc);
 	if (!desc.mc)
 		return -EINVAL;
@@ -543,26 +613,65 @@ static int __init save_microcode_in_initrd(void)
 }
 early_initcall(save_microcode_in_initrd);
 
+static inline bool patch_cpus_equivalent(struct ucode_patch *p, struct ucode_patch *n)
+{
+	/* Zen and newer hardcode the f/m/s in the patch ID */
+        if (x86_family(bsp_cpuid_1_eax) >= 0x17) {
+		union cpuid_1_eax p_cid = ucode_rev_to_cpuid(p->patch_id);
+		union cpuid_1_eax n_cid = ucode_rev_to_cpuid(n->patch_id);
+
+		/* Zap stepping */
+		p_cid.stepping = 0;
+		n_cid.stepping = 0;
+
+		return p_cid.full == n_cid.full;
+	} else {
+		return p->equiv_cpu == n->equiv_cpu;
+	}
+}
+
 /*
  * a small, trivial cache of per-family ucode patches
  */
-static struct ucode_patch *cache_find_patch(u16 equiv_cpu)
+static struct ucode_patch *cache_find_patch(struct ucode_cpu_info *uci, u16 equiv_cpu)
 {
 	struct ucode_patch *p;
+	struct ucode_patch n;
+
+	n.equiv_cpu = equiv_cpu;
+	n.patch_id  = uci->cpu_sig.rev;
+
+	WARN_ON_ONCE(!n.patch_id);
 
 	list_for_each_entry(p, &microcode_cache, plist)
-		if (p->equiv_cpu == equiv_cpu)
+		if (patch_cpus_equivalent(p, &n))
 			return p;
+
 	return NULL;
 }
 
+static inline bool patch_newer(struct ucode_patch *p, struct ucode_patch *n)
+{
+	/* Zen and newer hardcode the f/m/s in the patch ID */
+        if (x86_family(bsp_cpuid_1_eax) >= 0x17) {
+		union zen_patch_rev zp, zn;
+
+		zp.ucode_rev = p->patch_id;
+		zn.ucode_rev = n->patch_id;
+
+		return zn.rev > zp.rev;
+	} else {
+		return n->patch_id > p->patch_id;
+	}
+}
+
 static void update_cache(struct ucode_patch *new_patch)
 {
 	struct ucode_patch *p;
 
 	list_for_each_entry(p, &microcode_cache, plist) {
-		if (p->equiv_cpu == new_patch->equiv_cpu) {
-			if (p->patch_id >= new_patch->patch_id) {
+		if (patch_cpus_equivalent(p, new_patch)) {
+			if (!patch_newer(p, new_patch)) {
 				/* we already have the latest patch */
 				kfree(new_patch->data);
 				kfree(new_patch);
@@ -593,13 +702,22 @@ static void free_cache(void)
 static struct ucode_patch *find_patch(unsigned int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+	u32 rev, dummy __always_unused;
 	u16 equiv_id;
 
-	equiv_id = find_equiv_id(&equiv_table, uci->cpu_sig.sig);
-	if (!equiv_id)
-		return NULL;
+	/* fetch rev if not populated yet: */
+	if (!uci->cpu_sig.rev) {
+		rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
+		uci->cpu_sig.rev = rev;
+	}
+
+	if (x86_family(bsp_cpuid_1_eax) < 0x17) {
+		equiv_id = find_equiv_id(&equiv_table, uci->cpu_sig.sig);
+		if (!equiv_id)
+			return NULL;
+	}
 
-	return cache_find_patch(equiv_id);
+	return cache_find_patch(uci, equiv_id);
 }
 
 void reload_ucode_amd(unsigned int cpu)
@@ -649,7 +767,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	struct ucode_cpu_info *uci;
 	struct ucode_patch *p;
 	enum ucode_state ret;
-	u32 rev, dummy __always_unused;
+	u32 rev;
 
 	BUG_ON(raw_smp_processor_id() != cpu);
 
@@ -659,11 +777,11 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	if (!p)
 		return UCODE_NFOUND;
 
+	rev = uci->cpu_sig.rev;
+
 	mc_amd  = p->data;
 	uci->mc = p->data;
 
-	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
 	/* need to apply patch? */
 	if (rev > mc_amd->hdr.patch_id) {
 		ret = UCODE_OK;
@@ -709,6 +827,10 @@ static size_t install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 	hdr = (const u32 *)buf;
 	equiv_tbl_len = hdr[2];
 
+	/* Zen and newer do not need an equivalence table. */
+	if (x86_family(bsp_cpuid_1_eax) >= 0x17)
+		goto out;
+
 	equiv_table.entry = vmalloc(equiv_tbl_len);
 	if (!equiv_table.entry) {
 		pr_err("failed to allocate equivalent CPU table\n");
@@ -718,12 +840,16 @@ static size_t install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 	memcpy(equiv_table.entry, buf + CONTAINER_HDR_SZ, equiv_tbl_len);
 	equiv_table.num_entries = equiv_tbl_len / sizeof(struct equiv_cpu_entry);
 
+out:
 	/* add header length */
 	return equiv_tbl_len + CONTAINER_HDR_SZ;
 }
 
 static void free_equiv_cpu_table(void)
 {
+	if (x86_family(bsp_cpuid_1_eax) >= 0x17)
+		return;
+
 	vfree(equiv_table.entry);
 	memset(&equiv_table, 0, sizeof(equiv_table));
 }
@@ -749,7 +875,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover,
 	u16 proc_id;
 	int ret;
 
-	ret = verify_patch(family, fw, leftover, patch_size);
+	ret = verify_patch(fw, leftover, patch_size);
 	if (ret)
 		return ret;
 
@@ -774,7 +900,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover,
 	patch->patch_id  = mc_hdr->patch_id;
 	patch->equiv_cpu = proc_id;
 
-	pr_debug("%s: Added patch_id: 0x%08x, proc_id: 0x%04x\n",
+	pr_debug("%s: Adding patch_id: 0x%08x, proc_id: 0x%04x\n",
 		 __func__, patch->patch_id, proc_id);
 
 	/* ... and add to cache. */


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

