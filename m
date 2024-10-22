Return-Path: <linux-kernel+bounces-376230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC949AA1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE59628110A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBC419D89D;
	Tue, 22 Oct 2024 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IxpDD1OI"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ADA1E495
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598846; cv=none; b=dpjde0CT6czozKAMVslqWqO6jGtGyxVbDJ1rbqRn045VpGe6gH+PqHu49gy7KQbLefYF/vg8gU7pVc0t0n8vaiOIUKX7aVqPmQQ0qFLRuXZnhcBoCj88jawjYxHBTcYP3A2lpPnK23+EHQl334zd7nBLRUYjAxPAozIL0kStsuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598846; c=relaxed/simple;
	bh=ypVmF3KckB4SDotlID4pbkX5I4usC60b1WU/JnwgWoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfiLehIDBPtXYwHvhxn/yRqz+TGEpFyTj9Wj5k0cNk825Ut70qDMXEsOdzFJI0sMF2HxCNA+UbXrd1LtXu5uJaWRSUxCDoxRTfMX4VVSPulnPZ/46dBLz4obuC7H7gkKMujS/2QKabXSyiWVxjkbgLRPeOej5hzuApzE9+TVTaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IxpDD1OI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BEEC140E0198;
	Tue, 22 Oct 2024 12:07:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id k6ikJ325I-qD; Tue, 22 Oct 2024 12:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729598837; bh=opQibdbvwFuAxShZh1e267678NsYFG3zr2t3eyY8z7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IxpDD1OIhPq8XsSfQf9UMihV/jtK8PLggX/PdrQcgEgI3L8zsjzSf/2+UZd0KWf/u
	 n1Qd9CWvvm9VahQfEvEOfMz1jaGh78//5TzadKBz9YYXOCRKj+aTKlNaOFq3uG+3kN
	 kTXI7P9E48fszkV6N052EoGwJmL5rvteBtILJBaUQt7itOQSSck7jbVd2Fbvn+oNDB
	 yRyNsyDT+hpy6FboP9+hPpHgk5rhFQlVlJLPUhCkPLnTTHn5B87vkags05bzR3AvOn
	 UJmTVMUOW45CXZ+4mr+l+WZE1fn0HnZVbXXgqH9dDJ6YO0hXNwZS2K0oruZ5+Nu38N
	 kLB/98V4jyiPQBUNsh1ZEXTX93g8/1V4yMVX+Gv6Kv3kNOY6Ep/5J3R0YOuFqNXMhO
	 BbKfLUV4PsQuzbwal2Gm2nOjsUEzJqG4dBOX3EDb6CMmKLVcXyxK/S2NqquELq/W0b
	 KAtRfxWWAZVKgF8olU6DBujjgT8R0le/T8I/Su5W6pVgn5vE3yEQY0J/5lrlmUeATN
	 /M4e335Fvitk3aQS6qjn3T/oPpEKkprarO42oLiUCOJhJ0p9l0Eh3nuf3ZXIgXjYlI
	 6j+Or9PImkF2jMaBZzQgSJkNn5oG1gU1tE2CDZ7UOsLpYW/ls986gU4b7L5/O8jFej
	 Ce6XzxwAu4MsNEQbOd6H9VGk=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0AEF540E0184;
	Tue, 22 Oct 2024 12:07:11 +0000 (UTC)
Date: Tue, 22 Oct 2024 14:07:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	the arch/x86 maintainers <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: [PATCH 1/2] x86/microcode/AMD: Pay attention to the stepping
 dynamically
Message-ID: <20241022120711.GEZxeVbw_NzT_U1Cu4@fat_crate.local>
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
Date: Mon, 21 Oct 2024 10:27:52 +0200

Commit in Fixes changed how a microcode patch is loaded on Zen and newer
but the patch matching needs to happen with different rigidity,
depending on what is being done:

1) When the patch is added to the patches cache, the stepping must be
   ignored because the driver still supports different steppings per
   system

2) When the patch is matched for loading, then the stepping must be
   taken into account because each CPU needs the patch matching its
   stepping

Take care of that by making the matching smarter.

Fixes: 94838d230a6c ("x86/microcode/AMD: Use the family,model,stepping encoded in the patch ID")
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/91194406-3fdf-4e38-9838-d334af538f74@kernel.dk
---
 arch/x86/kernel/cpu/microcode/amd.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f63b051f25a0..1ae36ab37fe8 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -613,16 +613,19 @@ static int __init save_microcode_in_initrd(void)
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
 
 		return p_cid.full == n_cid.full;
 	} else {
@@ -644,13 +647,13 @@ static struct ucode_patch *cache_find_patch(struct ucode_cpu_info *uci, u16 equi
 	WARN_ON_ONCE(!n.patch_id);
 
 	list_for_each_entry(p, &microcode_cache, plist)
-		if (patch_cpus_equivalent(p, &n))
+		if (patch_cpus_equivalent(p, &n, false))
 			return p;
 
 	return NULL;
 }
 
-static inline bool patch_newer(struct ucode_patch *p, struct ucode_patch *n)
+static inline int patch_newer(struct ucode_patch *p, struct ucode_patch *n)
 {
 	/* Zen and newer hardcode the f/m/s in the patch ID */
         if (x86_family(bsp_cpuid_1_eax) >= 0x17) {
@@ -659,6 +662,9 @@ static inline bool patch_newer(struct ucode_patch *p, struct ucode_patch *n)
 		zp.ucode_rev = p->patch_id;
 		zn.ucode_rev = n->patch_id;
 
+		if (zn.stepping != zp.stepping)
+			return -1;
+
 		return zn.rev > zp.rev;
 	} else {
 		return n->patch_id > p->patch_id;
@@ -668,10 +674,14 @@ static inline bool patch_newer(struct ucode_patch *p, struct ucode_patch *n)
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
-- 
2.43.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

