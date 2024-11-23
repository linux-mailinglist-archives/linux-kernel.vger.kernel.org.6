Return-Path: <linux-kernel+bounces-419050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EDE9D68EC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F97161473
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D0519A297;
	Sat, 23 Nov 2024 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMJKtkKM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8FD19F132
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732362170; cv=none; b=SmIuA136RqSJWMFscgiyEtHhPn8h/wxWlBeBGwVmqyIOwrOnlh1V4QZGvVz2biDYoiNpVNJF3ZhOPgTcKM52HcTfExhYoUu9w/YpAO20Hi3kktq/vtXWpvOf5NLH3xs+3AnM+R9s6ANOFLro6PIIwOsmda3qSlP8+Hsxk5twBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732362170; c=relaxed/simple;
	bh=uECwqsF+UkX8OwEsyxyIkz4yOVeW9YjoPdbUuywnYm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=gEDWHXZKrylw8jdJvCQfA1JWsWQWO5599QCnwttYnIUXNSL90+IdZzhAJ9r/RlN2pGg3UKhdH+t8dG9HNrZA9eC32M6xpcVAn4vi9YP5PxTpYTsGCSxB7LGfy33VVKPUWNwTSC04Lis92EN/cEaSaDgAHQ+qYXLmdNYZnnv+twc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMJKtkKM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732362168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NoH0Y2WcxRDLIytNosGD2VXHqriS8fyOCwsa9auaVRQ=;
	b=WMJKtkKMRvJMRa6o+rfW7X72CsrZHTIqfWZMfRjPijuRgWAut8fvfSp+2PLyqm15DroDNN
	tP1VBI+3l52m5nxxe2KbKTRj8Z574aGLKlt8wdFGYcFNb0wroh5WZzX5/f9A0BR/OWv/bp
	HPBxx8K4SlsCbkc9j9dTLhH+NcqUnAc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-777IVqaFM2OHh_EBYHwBeA-1; Sat,
 23 Nov 2024 06:42:44 -0500
X-MC-Unique: 777IVqaFM2OHh_EBYHwBeA-1
X-Mimecast-MFC-AGG-ID: 777IVqaFM2OHh_EBYHwBeA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB65E19560AA;
	Sat, 23 Nov 2024 11:42:42 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.113.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4881A30000DF;
	Sat, 23 Nov 2024 11:42:38 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: mingo@kernel.org,
	thomas.lendacky@amd.com,
	bp@alien8.de,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 3/3] x86/mm: clean up unused parameters of functions
Date: Sat, 23 Nov 2024 19:42:21 +0800
Message-ID: <20241123114221.149383-4-bhe@redhat.com>
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

For functions memremap_is_efi_data(), memremap_is_setup_data and
early_memremap_is_setup_data(), their parameter 'size' is not used
and sometime cause confusion. Remove it now.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/ioremap.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 76be3d664e09..a11890692e4d 100644
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
 
@@ -709,14 +708,12 @@ static bool __ref __memremap_is_setup_data(resource_size_t phys_addr,
 }
 #undef SD_SIZE
 
-static bool memremap_is_setup_data(resource_size_t phys_addr,
-				   unsigned long size)
+static bool memremap_is_setup_data(resource_size_t phys_addr)
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


