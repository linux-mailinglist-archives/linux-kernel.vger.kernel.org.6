Return-Path: <linux-kernel+bounces-185679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD5D8CB8D6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 04:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD56280FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 02:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592018F6D;
	Wed, 22 May 2024 02:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="JZKYFQOu"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC0E1C680
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716343654; cv=none; b=sa6zOJpoeqdktx5isdapk0Du/7g1xWO9fEybqEMJAdkJIOxakZg5QY68rRJtQO3QpYBdaiHn9Kcj1XLFi8aDWdbA6wJPrpNolXfYr9Cs4lLc5+ZDNQDPKbwVjjfYSrY68j+X5Xv8oB3dtaEWq4XcIqOkFlAgQQHtdLj3gTYgnLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716343654; c=relaxed/simple;
	bh=bxl/lOFPSiCd4ykMkwouK0nVOpCXnivt9yMjnzRYgpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hx9ui7lIpTTjwPlbr3oRP3Ivh5cF/MOrGdr21nZjyfkp62hMbTpZADO7GjW+jm21Ralga5ogNnCOq6cbdjNLi9ouH4FnPnXVfbeCwvhTzefdcssvI76vnN+2oKhLdg97fT/puvXNEpuNNN/N6IZW0Bgpf5Chw0/ONW7+Zj8DWqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=JZKYFQOu; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1716343651;
	bh=bxl/lOFPSiCd4ykMkwouK0nVOpCXnivt9yMjnzRYgpQ=;
	h=From:To:Cc:Subject:Date:From;
	b=JZKYFQOuOUifgcqNuHj/S5NZuQ/q7Jb5H/GQCVgabpXFzmaXhIWWGs1zmgGIEZ9Mm
	 DX6fghyJHgTSFNHeVzl4nEIU3+oBNfOZvc4mLwRx1yvjko4APY4vqS4hZY3+oM+JyX
	 PHIl1Ct4T/GHlKG3Q5390Y5L1EX7xEzs1do4Y3OM=
Received: from stargazer.. (unknown [IPv6:240e:358:11a2:a00:dc73:854d:832e:3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 5A7851A3F25;
	Tue, 21 May 2024 22:07:25 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH v10 1/2] x86/mm: Don't disable PCID if "incomplete Global INVLPG flushes" is fixed by microcode
Date: Wed, 22 May 2024 10:06:24 +0800
Message-ID: <20240522020625.69418-1-xry111@xry111.site>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per the "Processor Specification Update" documentations referred by the
intel-microcode-20240312 release note, this microcode release has fixed
the issue for all affected models.

So don't disable PCID if the microcode is new enough.  The precise
minimum microcode revision fixing the issue is provided by engineer from
Intel.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michael Kelley <mhklinux@outlook.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.tip-bot2@tip-bot2/
Link: https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20240312
Link: https://cdrdv2.intel.com/v1/dl/getContent/740518 # RPL042, rev. 13
Link: https://cdrdv2.intel.com/v1/dl/getContent/682436 # ADL063, rev. 24
Link: https://lore.kernel.org/all/20240325231300.qrltbzf6twm43ftb@desk/
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/x86/mm/init.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index eb503f53c319..e960196e8058 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -264,27 +264,33 @@ static void __init probe_page_size_mask(void)
 
 /*
  * INVLPG may not properly flush Global entries
- * on these CPUs when PCIDs are enabled.
+ * on these CPUs when PCIDs are enabled and the
+ * microcode is not updated to fix the issue.
  */
 static const struct x86_cpu_id invlpg_miss_ids[] = {
-	X86_MATCH_VFM(INTEL_ALDERLAKE,	    0),
-	X86_MATCH_VFM(INTEL_ALDERLAKE_L,    0),
-	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, 0),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE,	    0),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,   0),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,   0),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,	    0x2e),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,    0x42c),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, 0x11),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,	    0x118),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,   0x4117),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,   0x2e),
 	{}
 };
 
 static void setup_pcid(void)
 {
+	const struct x86_cpu_id *invlpg_miss_match;
+
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
 	if (!boot_cpu_has(X86_FEATURE_PCID))
 		return;
 
-	if (x86_match_cpu(invlpg_miss_ids)) {
+	invlpg_miss_match = x86_match_cpu(invlpg_miss_ids);
+
+	if (invlpg_miss_match &&
+	    boot_cpu_data.microcode < invlpg_miss_match->driver_data) {
 		pr_info("Incomplete global flushes, disabling PCID");
 		setup_clear_cpu_cap(X86_FEATURE_PCID);
 		return;
-- 
2.45.1


