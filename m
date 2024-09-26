Return-Path: <linux-kernel+bounces-340694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCB49876BD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AB41C21111
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C831C15350B;
	Thu, 26 Sep 2024 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFlPTLWr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09C514D71D
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365366; cv=none; b=IRmdVceBVJhMExmhjPEWPACwSghF8bFy2Xb6vO0UAojs8eJj0+CM3WcPIGdqBmy/JJCDoBH1pjXnI/RlJ9GKbI9W8Z/lCI3VeLzaHKd6TCWO39Z1rtD53hPdUBp3Sqa6mssQ3tzYgoErN630MgqRasszoVKtXE6KIbi2pPNZwGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365366; c=relaxed/simple;
	bh=AmEBfJ3O4AmNv+bXXAupVkm9jBGx/su12GiScKSpURo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hxADea0TCfa5NeCxFNIEou4LgpCS2+02b1vJZQrVw1BJZwcfkGO5/uu1pnNw9f3k7SZVEed88Pp+UYPc+HJhfpPUlFm9eb6SUSGxQGOr4vQsRBXtvcZamA5YbNqFFBJTBRpEnFdhK/JZ+W4ygyc3YRKISi5wBbtIo6GKxNzyki0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFlPTLWr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727365363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QzpXW0kqGG/nfjNuZXnte9cVrtF0I2kkpQcSvMv8nk8=;
	b=XFlPTLWrc/v9exiNtjLNP452X4mm3tt6aHZJLCgGcbLvlOlV3f5Nke0pwR4HSNSqR2ep89
	5/817e9fF6Fn+oLDBDZk799t62p0qOX6cUXL0abxSVumgBmEi3g3AH25208phHXvkzHnlw
	FuY4SVRU/t99tOBYhAYetlWg5EJsOpY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-P_ZYmrDuOzSD45jTD3BBiQ-1; Thu,
 26 Sep 2024 11:42:39 -0400
X-MC-Unique: P_ZYmrDuOzSD45jTD3BBiQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9555F1903080;
	Thu, 26 Sep 2024 15:42:38 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.16.71])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 198AA3003DEC;
	Thu, 26 Sep 2024 15:42:35 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v1] mm/huge_memory: check pmd_special() only after pmd_present()
Date: Thu, 26 Sep 2024 17:42:34 +0200
Message-ID: <20240926154234.2247217-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

We should only check for pmd_special() after we made sure that we
have a present PMD. For example, if we have a migration PMD,
pmd_special() might indicate that we have a special PMD although we
really don't.

This fixes confusing migration entries as PFN mappings, and not
doing what we are supposed to do in the "is_swap_pmd()" case further
down in the function -- including messing up COW, page table handling
and accounting.

Reported-by: syzbot+bf2c35fa302ebe3c7471@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/66f15c8d.050a0220.c23dd.000f.GAE@google.com/
Fixes: bc02afbd4d73 ("mm/fork: accept huge pfnmap entries")
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

I yet have to do more testing, but sending this out already.

---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0580ac9e47b9..e55efcad1e6c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1586,7 +1586,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	int ret = -ENOMEM;
 
 	pmd = pmdp_get_lockless(src_pmd);
-	if (unlikely(pmd_special(pmd))) {
+	if (unlikely(pmd_present(pmd) && pmd_special(pmd))) {
 		dst_ptl = pmd_lock(dst_mm, dst_pmd);
 		src_ptl = pmd_lockptr(src_mm, src_pmd);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
-- 
2.46.1


