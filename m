Return-Path: <linux-kernel+bounces-419048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6142D9D68EA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22212281DDE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41440189F36;
	Sat, 23 Nov 2024 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHw2rtZK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15411991CD
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732362161; cv=none; b=MRJd1Cb98cK4QhSEos50eqMPLFsUY6LHT0MxK/V0Q8b1xcQCLvyUUK4ca/Gg42sGPMl9BVgnr54/9B1qM9VVfZC75eP65EGuhDDw2OZj9h+ocd70Hi/8arpQcirKKMULfVM20bN6SGJs5+1DpCgzhCAyink6UYaXFIvBd/euPS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732362161; c=relaxed/simple;
	bh=G3swD89QHBnyzx01W3vlbAk/XxQvcjBt0CJORcbm3VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=cVrv6c/uExa3VLOU7PeGQv6DS9xSaBaWsUlp27/KDWZDoi/B3gCRHvbT3VjNXF0odEumzOLkpe3YhUtJQOj4talAmFhSyJdKW7IH0v808/3RomaBg7I4vXbQF8mH+QN2L4h+2ER+zWUqr5EbLRCVUpIbKwcEi4Ur1usPEw9p5uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHw2rtZK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732362158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QmyYa2oCHPzw0Id7SpWheJapKne0y94rnLOSTdXdXFM=;
	b=jHw2rtZKmXSZGRQPCCBwDEBN0jbgKHSVIMtStfM9X11ZX/z9oWtDzUmFUxE2xDpnusj0mf
	SKi7U8ECFnnEzjoH8Jwpk4aXxgBlOoiaKK39d8pZgLjewGdP+Z92lGoVXDKpc0NIvZIkKP
	QcnJOfhcaarVh4NCSf5CblyxwZGngAc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-Zkr-myXKOhudvE7e7Bz1CQ-1; Sat,
 23 Nov 2024 06:42:35 -0500
X-MC-Unique: Zkr-myXKOhudvE7e7Bz1CQ-1
X-Mimecast-MFC-AGG-ID: Zkr-myXKOhudvE7e7Bz1CQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E11141955EE7;
	Sat, 23 Nov 2024 11:42:33 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.113.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C8DE30000DF;
	Sat, 23 Nov 2024 11:42:30 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: mingo@kernel.org,
	thomas.lendacky@amd.com,
	bp@alien8.de,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 1/3] x86/ioremap: introduce helper to implement xxx_is_setup_data()
Date: Sat, 23 Nov 2024 19:42:19 +0800
Message-ID: <20241123114221.149383-2-bhe@redhat.com>
In-Reply-To: <20241123114221.149383-1-bhe@redhat.com>
References: <20241123114221.149383-1-bhe@redhat.com>
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
 arch/x86/mm/ioremap.c | 104 ++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 69 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 8d29163568a7..aaf40a712b04 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -632,8 +632,8 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
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
@@ -641,31 +641,45 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 
 	paddr = boot_params.hdr.setup_data;
 	while (paddr) {
-		unsigned int len;
+		unsigned int len, size;
 
 		if (phys_addr == paddr)
 			return true;
 
-		data = memremap(paddr, sizeof(*data),
-				MEMREMAP_WB | MEMREMAP_DEC);
+		if (early)
+			data = early_memremap_decrypted(paddr, sizeof(*data));
+		else
+			data = memremap(paddr, sizeof(*data),
+					MEMREMAP_WB | MEMREMAP_DEC);
 		if (!data) {
 			pr_warn("failed to memremap setup_data entry\n");
 			return false;
 		}
 
+		size = sizeof(*data);
+
 		paddr_next = data->next;
 		len = data->len;
 
 		if ((phys_addr > paddr) &&
-		    (phys_addr < (paddr + sizeof(struct setup_data) + len))) {
-			memunmap(data);
+		    (phys_addr < (paddr + sizeof(*data) + len))) {
+			if (early)
+				early_memunmap(data, sizeof(*data));
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
+				early_memunmap(data, sizeof(*data));
+				data = early_memremap_decrypted(paddr, size);
+			} else {
+				memunmap(data);
+				data = memremap(paddr, size,
+						MEMREMAP_WB | MEMREMAP_DEC);
+			}
 			if (!data) {
 				pr_warn("failed to memremap indirect setup_data\n");
 				return false;
@@ -679,7 +693,10 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 			}
 		}
 
-		memunmap(data);
+		if (early)
+			early_memunmap(data, size);
+		else
+			memunmap(data);
 
 		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
 			return true;
@@ -690,67 +707,16 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 	return false;
 }
 
-/*
- * Examine the physical address to determine if it is boot data by checking
- * it against the boot params setup_data chain (early boot version).
- */
+static bool memremap_is_setup_data(resource_size_t phys_addr,
+				   unsigned long size)
+{
+	return __memremap_is_setup_data(phys_addr, false);
+}
+
 static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 						unsigned long size)
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
-
-	return false;
+	return __memremap_is_setup_data(phys_addr, true);
 }
 
 /*
-- 
2.41.0


