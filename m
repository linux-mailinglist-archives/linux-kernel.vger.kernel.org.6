Return-Path: <linux-kernel+bounces-410138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 300499CD506
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 02:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B359BB24FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 01:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4E91531E9;
	Fri, 15 Nov 2024 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMDit7rQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFCD14A4FF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731633718; cv=none; b=lhAymBCRYMrYGJ0VoG6tYySRWGtiSAaXFbuThu785KvBVU/P9OkKxE9woPPyw0BN4T4+MIiLqugi8GSrS3sG14SCE06a6BSXeaXPdzxS5CXl6zS5hsWszh3cU2Yq/jSX+GHdjU0gHB4KJhKHE5P8k9mz5spCYyYLjVw33Oqfnls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731633718; c=relaxed/simple;
	bh=Epzqu6Gp+71wWEolEIdEuva8cFbESZtGGGK9glHCG+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=iHtLQvdsic4rXHs9lnnVFhym61InblTuBEagfuP6okFc561SIQD3ySYQMgFN7zkNefeA6YT9+0QQyyLwySkEFSnpowwaFkjVdgi8YD9KPocuE0pnhplbCD+7sjuMaPFDOrwMjx+srKVFtgzPb8JNt60s5k6+/AqpUcW406nMJ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hMDit7rQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731633715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNFaxOngUrH/H+a3peOD/o/2VYRIzGn5AfsekXcACs0=;
	b=hMDit7rQ929FLZ0YdJBKLIKRRHg6lxxayyaDSe3yEwmLEniHFLRPtULeBvQ8rBq6SDBWZo
	FpD3LyBNla1fetfDELdsnZTgVTstZzrfloctzqPLM0HyeVXTb4oY9s05hJ/0asFnvl2Opq
	1q5/GF8ULZ5Q0rr+F7jX32x8rjWR9sc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-ruwQ4RPbNYGJyM4Iu1R9pQ-1; Thu,
 14 Nov 2024 20:21:52 -0500
X-MC-Unique: ruwQ4RPbNYGJyM4Iu1R9pQ-1
X-Mimecast-MFC-AGG-ID: ruwQ4RPbNYGJyM4Iu1R9pQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D09119560B4;
	Fri, 15 Nov 2024 01:21:51 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31EB43003B71;
	Fri, 15 Nov 2024 01:21:47 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org,
	bp@alien8.de
Cc: x86@kernel.org,
	thomas.lendacky@amd.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/3] x86/mm: clean up unused parameters of functions
Date: Fri, 15 Nov 2024 09:21:31 +0800
Message-ID: <20241115012131.509226-4-bhe@redhat.com>
In-Reply-To: <20241115012131.509226-1-bhe@redhat.com>
References: <20241115012131.509226-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

For functions memremap_is_efi_data(), memremap_is_setup_data and
early_memremap_is_setup_data(), their parameter 'size' is not used
and sometime cause confusion. Remove it now.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/ioremap.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 5d1b5e4a8756..71b282e5a4a0 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -593,8 +593,7 @@ static bool memremap_should_map_decrypted(resource_size_t phys_addr,
  * Examine the physical address to determine if it is EFI data. Check
  * it against the boot params structure and EFI tables and memory types.
  */
-static bool memremap_is_efi_data(resource_size_t phys_addr,
-				 unsigned long size)
+static bool memremap_is_efi_data(resource_size_t phys_addr)
 {
 	u64 paddr;
 
@@ -709,14 +708,12 @@ static bool __init __memremap_is_setup_data(resource_size_t phys_addr,
 }
 #undef SD_SIZE
 
-static bool __ref memremap_is_setup_data(resource_size_t phys_addr,
-				   unsigned long size)
+static bool __ref memremap_is_setup_data(resource_size_t phys_addr)
 {
 	return __memremap_is_setup_data(phys_addr, false);
 }
 
-static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
-						unsigned long size)
+static bool __init early_memremap_is_setup_data(resource_size_t phys_addr)
 {
 	return __memremap_is_setup_data(phys_addr, true);
 }
@@ -739,8 +736,8 @@ bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
 		return false;
 
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-		if (memremap_is_setup_data(phys_addr, size) ||
-		    memremap_is_efi_data(phys_addr, size))
+		if (memremap_is_setup_data(phys_addr) ||
+		    memremap_is_efi_data(phys_addr))
 			return false;
 	}
 
@@ -765,8 +762,8 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 	encrypted_prot = true;
 
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-		if (early_memremap_is_setup_data(phys_addr, size) ||
-		    memremap_is_efi_data(phys_addr, size))
+		if (early_memremap_is_setup_data(phys_addr) ||
+		    memremap_is_efi_data(phys_addr))
 			encrypted_prot = false;
 	}
 
-- 
2.41.0


