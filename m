Return-Path: <linux-kernel+bounces-209620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DCE903881
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22091C23917
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62520178CC3;
	Tue, 11 Jun 2024 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zg4zrlwd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECBF178381
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100833; cv=none; b=LyHDkZtlGaRt5pCo8VeObzcFwatgrrkVzTR8GPsnbF/lXLz3AOUa6d0ABckQBvAV2mGNJ9BvUM57GYcn2w8k5S8l82vEsWE8YV/PDz498soujPBGHLNO9rd56GbOBAKKtrl0hkq637nTB9IpCLJJMnzShMUPPIKfZ66ckU+ihVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100833; c=relaxed/simple;
	bh=e91cTJatErGbekBWqz/uJfJ12erNRYVk96MmOGDg5qo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EBfP9woU2BF6abjoj2h0vVLlEgHjYoP1BNSL2EmUV15QSOpDBndF4m9BuyxN1MnXvBWcXkhd0f3AibrwGmtr75qtLrKGLkKn5W0PjrVrPzwy8xBZbECqP7diiaKz6cZfo5K0Jp+qsWzikuDzBl+3U8kLJbGffhT1tQKwbnLk9/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zg4zrlwd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718100831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6VhMwq6IV8ojsetECI+veTLijBZyD+BQ/+V7gyTzsOM=;
	b=Zg4zrlwdy8sstz/LPXPoNvrh/qrMcfjwJVD5Gf3WqLh5U/5nZ7LjvK9hpLwnurwr2LjTkU
	1qov6wcaDuVdQpu+FwGgb/OzfmLblpOoUZuWDnavrRwxwxxV+Mp5NQXYAPs9v5w1Tl8/cM
	jbHxmK5vmcv3jrNRm48In/tH/VduYy4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-UvMBWYR4OwK4leQOJdabBg-1; Tue,
 11 Jun 2024 06:13:47 -0400
X-MC-Unique: UvMBWYR4OwK4leQOJdabBg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBE5C19560B0;
	Tue, 11 Jun 2024 10:13:46 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 609DF30000C4;
	Tue, 11 Jun 2024 10:13:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH] virt: guest_memfd: fix reference leak on hwpoisoned page
Date: Tue, 11 Jun 2024 06:13:45 -0400
Message-ID: <20240611101345.42233-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

If __kvm_gmem_get_pfn() detects an hwpoisoned page, it returns -EHWPOISON
but it does not put back the reference that kvm_gmem_get_folio() had
grabbed.  Move the whole check to kvm_gmem_get_folio(), via an __-prefixed
function.  This removes a "goto" and simplifies the code.

Now even fallocate() is prevented from picking an hwpoisoned page successfully.
This is temporary until the page allocation flow is cleaned up.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/guest_memfd.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 9714add38852..53742ec34a31 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -49,7 +49,7 @@ static int kvm_gmem_prepare_folio(struct inode *inode, pgoff_t index, struct fol
 	return 0;
 }
 
-static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index, bool prepare)
+static struct folio *__kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 {
 	struct folio *folio;
 
@@ -58,6 +58,19 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index, bool
 	if (IS_ERR(folio))
 		return folio;
 
+	if (folio_test_hwpoison(folio)) {
+		folio_unlock(folio);
+		folio_put(folio);
+		folio = ERR_PTR(-EHWPOISON);
+	}
+
+	return folio;
+}
+
+static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index, bool prepare)
+{
+	struct folio *folio = __kvm_gmem_get_folio(inode, index);
+
 	/*
 	 * Use the up-to-date flag to track whether or not the memory has been
 	 * zeroed before being handed off to the guest.  There is no backing
@@ -549,7 +562,6 @@ static int __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
 	struct kvm_gmem *gmem = file->private_data;
 	struct folio *folio;
 	struct page *page;
-	int r;
 
 	if (file != slot->gmem.file) {
 		WARN_ON_ONCE(slot->gmem.file);
@@ -566,23 +578,14 @@ static int __kvm_gmem_get_pfn(struct file *file, struct kvm_memory_slot *slot,
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-	if (folio_test_hwpoison(folio)) {
-		r = -EHWPOISON;
-		goto out_unlock;
-	}
-
 	page = folio_file_page(folio, index);
 
 	*pfn = page_to_pfn(page);
 	if (max_order)
 		*max_order = 0;
 
-	r = 0;
-
-out_unlock:
 	folio_unlock(folio);
-
-	return r;
+	return 0;
 }
 
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
-- 
2.43.0


