Return-Path: <linux-kernel+bounces-306687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA3F96421C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27F91C24762
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EA618E36B;
	Thu, 29 Aug 2024 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoNL6Apw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5097318CC07
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928036; cv=none; b=GDRL1OZIoQhuvKCDH221XoirSmPRzhSJV2MwroLOvcJ9TYgILw09M2IJRpSq+1OllxESXWFwJL1haJSTJKfnaLH73WjOIT634SfUwXceXsGArROo7epDOXrhPRTlvruvodOBe7UlYi5NeavOl7oGAJZCrWxyowhMihlE+MRPkUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928036; c=relaxed/simple;
	bh=TeO4cN7N0/VGadJCcqMbQsNAEnsiHgNeee5o/Z+Kcow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=D+xmgDUs5yDDmrfzbchfT4zuKQNPcsFXvKwQMACc5A5xVglrcGyBO+6nQ8Rq0kL6NOFHCuMkaROl/wHaYdXRZFidNQA5VdZcpp1PQ/GpfX15M4khjAqilVArS/tUXGNb+nJB53MKJOYsmrg1HY+sbmArnuI5Wx5hb2h9HeKiDeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QoNL6Apw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724928032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHcFyd24V34lOmEbXBxWKp9v8JyyTdWT1cJNwjQiQ5g=;
	b=QoNL6ApwoyyE1A2bd/9h4nguacXv1UyAn8WMiD0VNFy/SYNaDhvbWsFRD+S4xn8q3YRJvY
	hfBukRbLhPmRCc5sT0PiVKXSZFKC+6zDl7mT/Ty6q8I5c5P9x3AF2PPf+eYwe9Uga+iFZX
	QtlH5RnnSkM/LUzKoeaGiWI5XI4UN9w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-ZeTETdOyP-GoaoS1_s5QLg-1; Thu,
 29 Aug 2024 06:40:31 -0400
X-MC-Unique: ZeTETdOyP-GoaoS1_s5QLg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33A581955D54;
	Thu, 29 Aug 2024 10:40:30 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.42])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E9301955BE3;
	Thu, 29 Aug 2024 10:40:25 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: thomas.lendacky@amd.com,
	dyoung@redhat.com,
	daniel.kiper@oracle.com,
	noodles@fb.com,
	lijiang@redhat.com,
	kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 1/2] x86/mm: rename the confusing local variable in early_memremap_is_setup_data()
Date: Thu, 29 Aug 2024 18:40:15 +0800
Message-ID: <20240829104016.84139-2-bhe@redhat.com>
In-Reply-To: <20240829104016.84139-1-bhe@redhat.com>
References: <20240829104016.84139-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

In function early_memremap_is_setup_data(), parameter 'size' passed has
the same name as the local variable inside the while loop. That
confuses people who sometime mix up them when reading code.

Here rename the local variable 'size' inside while loop to 'sd_size'.

And also add one local variable 'sd_size' likewise in function
memremap_is_setup_data() to simplify code. In later patch, this can also
be used.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/ioremap.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index aa7d279321ea..f1ee8822ddf1 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -640,7 +640,7 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 
 	paddr = boot_params.hdr.setup_data;
 	while (paddr) {
-		unsigned int len;
+		unsigned int len, sd_size;
 
 		if (phys_addr == paddr)
 			return true;
@@ -652,6 +652,8 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 			return false;
 		}
 
+		sd_size = sizeof(*data);
+
 		paddr_next = data->next;
 		len = data->len;
 
@@ -662,7 +664,9 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 
 		if (data->type == SETUP_INDIRECT) {
 			memunmap(data);
-			data = memremap(paddr, sizeof(*data) + len,
+
+			sd_size += len;
+			data = memremap(paddr, sd_size,
 					MEMREMAP_WB | MEMREMAP_DEC);
 			if (!data) {
 				pr_warn("failed to memremap indirect setup_data\n");
@@ -701,7 +705,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 
 	paddr = boot_params.hdr.setup_data;
 	while (paddr) {
-		unsigned int len, size;
+		unsigned int len, sd_size;
 
 		if (phys_addr == paddr)
 			return true;
@@ -712,7 +716,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 			return false;
 		}
 
-		size = sizeof(*data);
+		sd_size = sizeof(*data);
 
 		paddr_next = data->next;
 		len = data->len;
@@ -723,9 +727,9 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 		}
 
 		if (data->type == SETUP_INDIRECT) {
-			size += len;
+			sd_size += len;
 			early_memunmap(data, sizeof(*data));
-			data = early_memremap_decrypted(paddr, size);
+			data = early_memremap_decrypted(paddr, sd_size);
 			if (!data) {
 				pr_warn("failed to early memremap indirect setup_data\n");
 				return false;
@@ -739,7 +743,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 			}
 		}
 
-		early_memunmap(data, size);
+		early_memunmap(data, sd_size);
 
 		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
 			return true;
-- 
2.41.0


