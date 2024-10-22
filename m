Return-Path: <linux-kernel+bounces-376233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C4F9AA1E4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B7728171B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06B219F11E;
	Tue, 22 Oct 2024 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kJ/c0Gc/"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A732199938
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598931; cv=none; b=plylYtBzIKs/OspXoJ5IS79r6sugpuYO++JEc2ecorgTRxdxh11wuBoMpfgHxiEla4ribmSTTYsochAS1b0DSWV1fATSU6tI+/P6rCLUzf+uDDcxc+hKZkco+LYskjjkmwMLYdih6xHFYnr824AVKrWACqjgbcr5xaDmLc6Udtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598931; c=relaxed/simple;
	bh=qDQYLCYCnlwR0cMaWiw9SY4i5X875oM10wDDqXIxHW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HuFNyO/4F4Sb3Byl4BmCgCA6GV2A1HFNs0vsMiJMi84i7mnafH+BSKa+W31qCmbkuopNeriENVU1H8F5lynsNVvnXJ+qUdYxhmXOzxSkt1auR34ieCdGpjt5nL6gYGgyKFNczODLSwgfGZzNK6k78GnU/pxI0EPgno72i/q8Dtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kJ/c0Gc/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B141340E0198;
	Tue, 22 Oct 2024 12:08:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0wBELmNqvvwG; Tue, 22 Oct 2024 12:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729598922; bh=k+1OpO7hF6cIPSlbVyJiwsaLvziUmK4yVdE3fj4n//A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJ/c0Gc/PDz0tuOKXc7gSRHgf9e9/4VVXafkiG6UNq9SlMBoj6k+ir7Ewn4DevPoe
	 +Tai3sBeXAKvO5cgA2Fk6Jyco5oe9xZo/THQwU/KOm/YhWr+GaFm/k9eAf58GV2oea
	 Bun5ZL85duzVdNyoiTorUqJTRMSDEwZFXUVRG5eXE41JZYrWmZv8lIcwRbQUdeD3q7
	 w+XFBVP9QuVDFT8xm/t7q/FuqPJgRk4XQyACGYpdH1ZR6FZEVbj21ehvA8p0GUcVXA
	 aTCQNb9o92Asw9jJeK7sN3QREKKDiIIp6bvJWPzq0AiNjSb4jptvoowjc9Dc6m44hZ
	 D/fM7bhvTDN3Cd+ciuTPNkSwsgxccUtZ/Rj654slCzL3Uh8kNQUY4lGHcwOguSMry9
	 RNLx1rgFw3xJaWZDtGmqje9jiAZjbIwBY5bDRYcSCWLluZu/pM9Wgw/zSycPiZB7Ht
	 a5/H1uIOQnGoPS4W2Tmxze+AwNag5ZkS14TaPGLAde7xmSBOfZ8B4VXzvlQkzsd+IP
	 MYYYn01KwgA4HK8VNeX0o4fiOclc2KRf+a1XjBmMQP6ehLf94fs1BN1Nugc9n6p3Vx
	 SCaPBbtMNXv+Ey+krVw9DRZTbytnPUmd5ZgB0cvJkKt86R9qXMHYXueBuHSZDppeSX
	 8Nh46AYXPUuuHmHYLd9QtxWE=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8223840E0184;
	Tue, 22 Oct 2024 12:08:37 +0000 (UTC)
Date: Tue, 22 Oct 2024 14:08:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: [PATCH 2/2] x86/microcode/AMD: Split load_microcode_amd()
Message-ID: <20241022120836.GFZxeVxGQ6vWIScFWo@fat_crate.local>
References: <1bb5dd7f-15b5-4d9d-97ef-75ebdc24e7d9@kernel.dk>
 <20241019093748.GAZxN97LS_dJ3DNrpd@fat_crate.local>
 <436b4fc7-6369-40d9-8e88-556cbf5a5687@kernel.dk>
 <20241019232138.GDZxQ_AtkqA9iAR2td@fat_crate.local>
 <b2fd70bb-9414-49e0-bdb8-5c538f247dea@kernel.dk>
 <20241020121819.GAZxT1CyR_5vLLZ5e6@fat_crate.local>
 <df217737-6e2c-41fe-b558-3e2ab6dc0d9e@kernel.dk>
 <20241021073140.GAZxYDXCk02lSrG3-T@fat_crate.local>
 <daa98312-cc66-4c2f-8e64-01358ee99305@kernel.dk>
 <20241022120531.GDZxeVC0WeUPhInkYh@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022120531.GDZxeVC0WeUPhInkYh@fat_crate.local>

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Mon, 21 Oct 2024 10:38:21 +0200

This function should've been split a long time ago because it is used in
two paths:

1) On the late loading path, when the microcode is loaded through the
   request_firmware interface

2) In the save_microcode_in_initrd() path which collects all the
   microcode patches which are relevant for the current system before
   the initrd with the microcode container has been jettisoned.

   In that path, it is not really necessary to iterate over the nodes on
   a system and match a patch however it didn't cause any trouble so it
   was left for a later cleanup

However, that later cleanup was expedited by the fact that Jens was
enabling "Use L3 as a NUMA node" in the BIOS setting in his machine and
so this causes the NUMA CPU masks used in cpumask_of_node() to be
generated *after* 2) above happened on the first node. Which means, all
those masks were funky, wrong, uninitialized and whatnot, leading to
explosions when dereffing c->microcode in load_microcode_amd().

So split that function and do only the necessary work needed at each
stage.

Fixes: 94838d230a6c ("x86/microcode/AMD: Use the family,model,stepping encoded in the patch ID")
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/91194406-3fdf-4e38-9838-d334af538f74@kernel.dk
---
 arch/x86/kernel/cpu/microcode/amd.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 1ae36ab37fe8..31a73715d755 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -584,7 +584,7 @@ void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_
 		native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->new_rev, dummy);
 }
 
-static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size);
+static enum ucode_state _load_microcode_amd(u8 family, const u8 *data, size_t size);
 
 static int __init save_microcode_in_initrd(void)
 {
@@ -605,7 +605,7 @@ static int __init save_microcode_in_initrd(void)
 	if (!desc.mc)
 		return -EINVAL;
 
-	ret = load_microcode_amd(x86_family(cpuid_1_eax), desc.data, desc.size);
+	ret = _load_microcode_amd(x86_family(cpuid_1_eax), desc.data, desc.size);
 	if (ret > UCODE_UPDATED)
 		return -EINVAL;
 
@@ -954,21 +954,30 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
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
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

