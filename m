Return-Path: <linux-kernel+bounces-419049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74C49D68EB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E49FB21B0F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C55197549;
	Sat, 23 Nov 2024 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZYTAjyQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFBB19D062
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732362166; cv=none; b=p0DyIKkNYtwHN/H5+DK/Ai8M3rDd1F9OqU5dbu6XHPhm64jhfXjJDpI+vB4Ag1wzzEe9L/TN/GptGPUIUryNdOjVkksGeC/LQiZuDvLZ5W+HVBUyOZISvaFrrwR3NiEsVQv2ET1/FkUExonA/an/lO9cbJTapU/VDaBSu8fNaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732362166; c=relaxed/simple;
	bh=dKRraXEvvBIiELg1KVw+pNKsQ+dISM0Y2Qkzpj0lXyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=X7jvl7Sm+VUJe0yWQWMm1M1gAwCBENrcMvcSZhAZPdMTS6hy63DWyGjmqHoFcQ0CZlba88Rg8ZpL5fvbwfTQSCsJ5k3AgGXxGAa9pPfcL9FggVRMP+gzFtZ6wjkTeXifhxcWiIfj5R5K+Rfzi4yZWXcM1ATdJt5UBI8MwNVptu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZYTAjyQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732362163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BkUrFTWxTUqZBwu2Upg8aNpuqaNWXe8OYfpatQKY0cI=;
	b=XZYTAjyQhWwEY60hSQ5AiVDxcf6uASjkZyvKguDniXJ7xS99R6uFpu3Vs3bzGZVnFhsF9Z
	ARuylcjR4ra6bPfsGUQZmAYEsop23vmWw3z9+6zxQrYYhd6YgrylREb+llg8DhIZ+sOUqL
	vwHClyNbkIgwQzunZhstbwpnQL4Gug8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-GIE6mWTtMF-ooV23Sg5D5Q-1; Sat,
 23 Nov 2024 06:42:39 -0500
X-MC-Unique: GIE6mWTtMF-ooV23Sg5D5Q-1
X-Mimecast-MFC-AGG-ID: GIE6mWTtMF-ooV23Sg5D5Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67A7119560B4;
	Sat, 23 Nov 2024 11:42:38 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.113.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BDF6C30000DF;
	Sat, 23 Nov 2024 11:42:34 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: mingo@kernel.org,
	thomas.lendacky@amd.com,
	bp@alien8.de,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 2/3] x86/ioremap: Clean up size calculations in xxx_is_setup_data()
Date: Sat, 23 Nov 2024 19:42:20 +0800
Message-ID: <20241123114221.149383-3-bhe@redhat.com>
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

while *normally* we'd use the 'sizeof(*data)' pattern, this particular
size repeats a number of times and not all contexts are obvious - so
abstracting it out into a trivial define SD_SIZE looks like the proper
cleanup.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/ioremap.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index aaf40a712b04..76be3d664e09 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -628,6 +628,7 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
 	return false;
 }
 
+#define SD_SIZE sizeof(struct setup_data)
 /*
  * Examine the physical address to determine if it is boot data by checking
  * it against the boot params setup_data chain.
@@ -647,24 +648,24 @@ static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,
 			return true;
 
 		if (early)
-			data = early_memremap_decrypted(paddr, sizeof(*data));
+			data = early_memremap_decrypted(paddr, SD_SIZE);
 		else
-			data = memremap(paddr, sizeof(*data),
+			data = memremap(paddr, SD_SIZE,
 					MEMREMAP_WB | MEMREMAP_DEC);
 		if (!data) {
 			pr_warn("failed to memremap setup_data entry\n");
 			return false;
 		}
 
-		size = sizeof(*data);
+		size = SD_SIZE;
 
 		paddr_next = data->next;
 		len = data->len;
 
 		if ((phys_addr > paddr) &&
-		    (phys_addr < (paddr + sizeof(*data) + len))) {
+		    (phys_addr < (paddr + SD_SIZE + len))) {
 			if (early)
-				early_memunmap(data, sizeof(*data));
+				early_memunmap(data, SD_SIZE);
 			else
 				memunmap(data);
 			return true;
@@ -673,7 +674,7 @@ static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,
 		if (data->type == SETUP_INDIRECT) {
 			size += len;
 			if (early) {
-				early_memunmap(data, sizeof(*data));
+				early_memunmap(data, SD_SIZE);
 				data = early_memremap_decrypted(paddr, size);
 			} else {
 				memunmap(data);
@@ -706,6 +707,7 @@ static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,
 
 	return false;
 }
+#undef SD_SIZE
 
 static bool memremap_is_setup_data(resource_size_t phys_addr,
 				   unsigned long size)
-- 
2.41.0


