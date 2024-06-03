Return-Path: <linux-kernel+bounces-198785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEAC8D7D5E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA5D1C21A9F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493105A7AA;
	Mon,  3 Jun 2024 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHC57QyX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9362F111AD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403443; cv=none; b=GI+qWnsP23gk+Gzkt1TGQG+h5hASaJPf/t8llYw6H4J3ex+deciMWV+ABFKVGBF2GVrhbOTMUS5CFV/x1dEhEmX28hmXSRgxDZ2EbQaCRmxxDLWYwvkm/TsuiYnD3qX1lfcEOPIA0JDLOHSf4Hdl4lQlC4SdL+uddd63xUYnvNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403443; c=relaxed/simple;
	bh=qHk9ZMgx+Y3r7cbyMy8jKoU1ZUxSVBLcogFQF5N90CY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=seB70MRZBlGFdHCXrbUqugb1+KzLRppn6BRNTQLbpc1TNAPbbOxPQJAJzdkSNFU2Y3tleqXo2kMOwNx3T6bSrD1hcG/KzpuoqwkZF3sBV7sN5K61/UoPaWudCgUM3MX7KElcQ8yQmgEvFPgxk3nLtKui+KtHE/AhDqSVWAwNngo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHC57QyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FA4C2BD10;
	Mon,  3 Jun 2024 08:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717403443;
	bh=qHk9ZMgx+Y3r7cbyMy8jKoU1ZUxSVBLcogFQF5N90CY=;
	h=From:To:Cc:Subject:Date:From;
	b=lHC57QyX3D4WTOmuJnlpeDoHNuFbdt1UA2S3MUOJ+hfsyx1k2dS5SVF/ex+YlAClq
	 yhKvW9rwwkEpwPcn2ppfeg82cr7Rq8hKvhmgFjLc9prmL6h/ZtM3iPjaQBvdQ8Zc0W
	 dO3o9rRXXXbaizB3NCz9qUGXBcIXM0ElA2ITeBp3G+y+IqtyCGn01wRoLFWlV7B2Lb
	 z+GIvuH8h5dCWOMsTrDqwx+T3LxOH0d6pLPtzdevAy93TOKmZp89h4/+9YT3MobsQq
	 CvgvoIsV2RFnRuRyqKzC3p2vej9y5qm4az9pG/uvSLJ6D9iqg6xbkcstfuxZR12An3
	 Cqtv2W1Ug9WmA==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	LKML <linux-kernel@vger.kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86/kexec: Fix bug with call depth tracking
Date: Mon,  3 Jun 2024 10:30:36 +0200
Message-ID: <20240603083036.637-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Kaplan <david.kaplan@amd.com>

The call to cc_platform_has() triggers a fault and system crash if call depth
tracking is active because the GS segment has been reset by load_segments() and
GS_BASE is now 0 but call depth tracking uses per-CPU variables to operate.

Call cc_platform_has() earlier in the function when GS is still valid.

  [ bp: Massage. ]

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/machine_kexec_64.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index b180d8e497c3..90b1946c06e5 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -295,8 +295,15 @@ void machine_kexec_cleanup(struct kimage *image)
 void machine_kexec(struct kimage *image)
 {
 	unsigned long page_list[PAGES_NR];
-	void *control_page;
+        unsigned int host_mem_enc_active;
 	int save_ftrace_enabled;
+	void *control_page;
+
+	/*
+	 * This must be done before load_segments() since if call depth tracking
+	 * is used then GS must be valid to make any function calls.
+	 */
+	host_mem_enc_active = cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT);
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
@@ -358,7 +365,7 @@ void machine_kexec(struct kimage *image)
 				       (unsigned long)page_list,
 				       image->start,
 				       image->preserve_context,
-				       cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT));
+				       host_mem_enc_active);
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
-- 
2.43.0


