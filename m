Return-Path: <linux-kernel+bounces-412311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E499D0761
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1860A281E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 01:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FCA17C7C;
	Mon, 18 Nov 2024 01:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWezKf1l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00B71EEE0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731892123; cv=none; b=jxJ6OTx2mKm9nIEpQ3VQycE3HVohNhpNtEfIVOr0rFI1aL6sGkRRNZhSS07W95BUXcZkYPEmCGBzn5E2Ale3ta+Ak7o59E40hSscLbkc2ZxWa1zBwSh78DvaH8ZWhL+36YdMBgyA/anAqQD3mAJOD7YeH+IMxGlqKuFdsw6o5aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731892123; c=relaxed/simple;
	bh=op7OKdRde168TntIHn22QHMGmYZuySYmn6eZrPmYniM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=NujHHEnk6Y+ehcFylyG4GT5U7tZFTgHR/OAjU3ZUzA6l0kQCSdW+Ig67hHb9BEKmyVL0hYcZlPMgxcA6sA3VD768kUGrB9MCiJ2irJVpDR+SREKLfLO+mgVXJOgTX9chJBn2cIiT02O4sXK/7sW+Qr6Va3N4u3w+vKWkoOUbWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NWezKf1l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731892119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zni2P8RXs1NIgqnGj1dvk2TFcixosLxM92vTQmUu8zE=;
	b=NWezKf1lbPzRAj1GRKDq6XDeqSpD457wVwD6kW3T2ycz5/77TU3qcffELMxhQgweBw24iQ
	tAiAr1WsEz4/KN5JlNRMwIzcwVNNUiS+PS5QIKviowRdGAv/vueTckIFmdVlczPyZePOy0
	PeEQVvUvQQplIbsCXzUGSX3LOTJLZRY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-SfR6VTcJOayfGfqzwCF1gQ-1; Sun,
 17 Nov 2024 20:08:34 -0500
X-MC-Unique: SfR6VTcJOayfGfqzwCF1gQ-1
X-Mimecast-MFC-AGG-ID: SfR6VTcJOayfGfqzwCF1gQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6CD71955F37;
	Mon, 18 Nov 2024 01:08:32 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.113.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2794A300019E;
	Mon, 18 Nov 2024 01:08:26 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	bp@alien8.de,
	thomas.lendacky@amd.com
Cc: x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 1/2] x86/ioremap: introduce helper to implement xxx_is_setup_data()
Date: Mon, 18 Nov 2024 09:08:18 +0800
Message-ID: <20241118010819.46602-2-bhe@redhat.com>
In-Reply-To: <20241118010819.46602-1-bhe@redhat.com>
References: <20241118010819.46602-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Functions memremap_is_setup_data() and early_memremap_is_setup_data()
share completely the same process and handling, except of the
different memremap/unmap invocations.

So add helper __memremap_is_setup_data() to extract the common part,
parameter 'early' is used to decide what kind of memremap/unmap
APIs are called. This simplifies codes a lot by removing the duplicated
codes, and also removes the similar code comment above them.

And '__ref' is added to __memremap_is_setup_data() to suppress below
section mismatch warning:

ARNING: modpost: vmlinux: section mismatch in reference: __memremap_is_setup_data+0x5f (section: .text) ->
early_memunmap (section: .init.text)

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/ioremap.c | 108 +++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 70 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 8d29163568a7..68d78e2b1203 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -628,12 +628,13 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
 	return false;
 }
 
+#define SD_SIZE sizeof(struct setup_data)
 /*
  * Examine the physical address to determine if it is boot data by checking
  * it against the boot params setup_data chain.
  */
-static bool memremap_is_setup_data(resource_size_t phys_addr,
-				   unsigned long size)
+static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,
+						bool early)
 {
 	struct setup_indirect *indirect;
 	struct setup_data *data;
@@ -641,31 +642,45 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 
 	paddr = boot_params.hdr.setup_data;
 	while (paddr) {
-		unsigned int len;
+		unsigned int len, size;
 
 		if (phys_addr == paddr)
 			return true;
 
-		data = memremap(paddr, sizeof(*data),
-				MEMREMAP_WB | MEMREMAP_DEC);
+		if (early)
+			data = early_memremap_decrypted(paddr, SD_SIZE);
+		else
+			data = memremap(paddr, SD_SIZE,
+					MEMREMAP_WB | MEMREMAP_DEC);
 		if (!data) {
 			pr_warn("failed to memremap setup_data entry\n");
 			return false;
 		}
 
+		size = SD_SIZE;
+
 		paddr_next = data->next;
 		len = data->len;
 
 		if ((phys_addr > paddr) &&
-		    (phys_addr < (paddr + sizeof(struct setup_data) + len))) {
-			memunmap(data);
+		    (phys_addr < (paddr + SD_SIZE + len))) {
+			if (early)
+				early_memunmap(data, SD_SIZE);
+			else
+				memunmap(data);
 			return true;
 		}
 
 		if (data->type == SETUP_INDIRECT) {
-			memunmap(data);
-			data = memremap(paddr, sizeof(*data) + len,
-					MEMREMAP_WB | MEMREMAP_DEC);
+			size += len;
+			if (early) {
+				early_memunmap(data, SD_SIZE);
+				data = early_memremap_decrypted(paddr, size);
+			} else {
+				memunmap(data);
+				data = memremap(paddr, size,
+						MEMREMAP_WB | MEMREMAP_DEC);
+			}
 			if (!data) {
 				pr_warn("failed to memremap indirect setup_data\n");
 				return false;
@@ -679,7 +694,10 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 			}
 		}
 
-		memunmap(data);
+		if (early)
+			early_memunmap(data, size);
+		else
+			memunmap(data);
 
 		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
 			return true;
@@ -689,68 +707,18 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 
 	return false;
 }
+#undef SD_SIZE
 
-/*
- * Examine the physical address to determine if it is boot data by checking
- * it against the boot params setup_data chain (early boot version).
- */
-static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
-						unsigned long size)
+static bool memremap_is_setup_data(resource_size_t phys_addr,
+				   unsigned long size)
 {
-	struct setup_indirect *indirect;
-	struct setup_data *data;
-	u64 paddr, paddr_next;
-
-	paddr = boot_params.hdr.setup_data;
-	while (paddr) {
-		unsigned int len, size;
-
-		if (phys_addr == paddr)
-			return true;
-
-		data = early_memremap_decrypted(paddr, sizeof(*data));
-		if (!data) {
-			pr_warn("failed to early memremap setup_data entry\n");
-			return false;
-		}
-
-		size = sizeof(*data);
-
-		paddr_next = data->next;
-		len = data->len;
-
-		if ((phys_addr > paddr) &&
-		    (phys_addr < (paddr + sizeof(struct setup_data) + len))) {
-			early_memunmap(data, sizeof(*data));
-			return true;
-		}
-
-		if (data->type == SETUP_INDIRECT) {
-			size += len;
-			early_memunmap(data, sizeof(*data));
-			data = early_memremap_decrypted(paddr, size);
-			if (!data) {
-				pr_warn("failed to early memremap indirect setup_data\n");
-				return false;
-			}
-
-			indirect = (struct setup_indirect *)data->data;
-
-			if (indirect->type != SETUP_INDIRECT) {
-				paddr = indirect->addr;
-				len = indirect->len;
-			}
-		}
-
-		early_memunmap(data, size);
-
-		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
-			return true;
-
-		paddr = paddr_next;
-	}
+	return __memremap_is_setup_data(phys_addr, false);
+}
 
-	return false;
+static bool early_memremap_is_setup_data(resource_size_t phys_addr,
+						unsigned long size)
+{
+	return __memremap_is_setup_data(phys_addr, true);
 }
 
 /*
-- 
2.41.0


