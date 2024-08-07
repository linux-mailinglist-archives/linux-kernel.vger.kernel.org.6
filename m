Return-Path: <linux-kernel+bounces-277901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BC094A7EA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C250E284ED4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45921E6742;
	Wed,  7 Aug 2024 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="rouwZkpk"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D701C44366
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034481; cv=none; b=gSTEOkal3hjv8L97qwuhCOJC4m+/b3E8gNsqIPiGiimWQvgMZqE61umA3bRjsPcVfS7ug+AeYtdgam+cDujcPsvb6Tx5Kl5CwxbKFIZMpg4wSWZKhaE47RLWrrCEteyB3rgCD+EAG565iS0uXo6+mg33oWFXu4UWjevDcSpsjks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034481; c=relaxed/simple;
	bh=XT6OZNWGYzIxYdVySaYbm4LJJTkDHxMq495VN2H1fDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kbbg6r3DvNGIUnW1cKRks1wXQyf+X1a5FkyJnFC6Bg8Fx6eYmq6kxgcFHgtmuPO32GpiEbf3g6i/QPGxYidiY9h3YbDN/+/0NzX5w2fhqjESrOqiBOmauinxKjwO2RojQZTdtsizC+sFAixFdt4g1bijOMQoytrsS8wbdjEU7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=rouwZkpk; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1723034477;
	bh=MLPB8NX1mr26290JEeNr8bLoMbPmIYChrue1EMzqpmE=;
	h=From:To:Cc:Subject:Date:From;
	b=rouwZkpkpwvm1AETzWWBAHxWziQvMhXI7iOx9YMA0xiCUgpuaCB3OE5HF0Pg+RlNh
	 G3daTz+Tsbz6MpBaGyhhCCfsnSMzZEqGECM/XMXVS0nwgP7kft0v880B3rAe+saMjf
	 Vaycc+vl9gc6KZb6bgn9Iwgvf4n8ltCZJf0qL3Wb1XQlc/uZPj6bWNvwrIwNDQd1Ty
	 i/WYNEUltvKBnhZslmbUBSN8NbtC8QkEhwoxdlSN69lR65z2WWM5C+U4vXNkH1GIVs
	 pWyjJA/ZkK4lL+5TXTmGDVLroUA6EGt+g5M4B9aaZMjjKnIqpl5mATpNfWxGm2H0Md
	 DxfcMry9PYr8g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wf8tN6TY9z4wd6;
	Wed,  7 Aug 2024 22:41:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linux-mm@kvack.org>
Cc: <linuxppc-dev@lists.ozlabs.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	christophe.leroy@csgroup.eu,
	jeffxu@chromium.org,
	jeffxu@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	npiggin@gmail.com,
	oliver.sang@intel.com,
	pedro.falcato@gmail.com
Subject: [PATCH 1/4] mm: Add optional close() to struct vm_special_mapping
Date: Wed,  7 Aug 2024 22:41:00 +1000
Message-ID: <20240807124103.85644-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an optional close() callback to struct vm_special_mapping. It will
be used, by powerpc at least, to handle unmapping of the VDSO.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 include/linux/mm_types.h | 2 ++
 mm/mmap.c                | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 485424979254..ef32d87a3adc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1313,6 +1313,8 @@ struct vm_special_mapping {
 
 	int (*mremap)(const struct vm_special_mapping *sm,
 		     struct vm_area_struct *new_vma);
+	void (*close)(const struct vm_special_mapping *sm,
+		      struct vm_area_struct *vma);
 };
 
 enum tlb_flush_reason {
diff --git a/mm/mmap.c b/mm/mmap.c
index d0dfc85b209b..24bd6aa9155c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3624,6 +3624,9 @@ static vm_fault_t special_mapping_fault(struct vm_fault *vmf);
  */
 static void special_mapping_close(struct vm_area_struct *vma)
 {
+	const struct vm_special_mapping *sm = vma->vm_private_data;
+	if (sm->close)
+		sm->close(sm, vma);
 }
 
 static const char *special_mapping_name(struct vm_area_struct *vma)
-- 
2.45.2


