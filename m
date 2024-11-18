Return-Path: <linux-kernel+bounces-412312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A22329D0762
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE041F21F93
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 01:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7160428373;
	Mon, 18 Nov 2024 01:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sl6ceI7G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121EE17BA2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731892125; cv=none; b=JI4k+s2NaemH9qpH2/sjeYPTyhjZaIFBx5G4Plmxkuv4WMozPxyW0lx2M1qrUOY9fjD8v7MasPovwnv+kAUelPNdLEVodgBaeRDflv0uSCLJ8wh9OfadNRKE680lnoibMJfU77kbkXFJuIscvN6KHxDfgaI7fU78k4zQ0820GMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731892125; c=relaxed/simple;
	bh=PoW4nNs0VhdihucMJl2U7xHf/YDFPe+84CxzxjrHMkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=UZBQaX1WnKw+LVXzrE9LTMKlat+HGG3hEXlGHpSmwSYr+FbST+ZrAnjzmkSa0JiswJP8HIHbooYO+Ugki1/buhnCuidotRRTESPcGWF1SpbsMH0Ja7i9izem3QJEfPPSPlgsT3m0CP9SF/0O2mLmfxyHgwF+QhVMTMZcCnSzmKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sl6ceI7G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731892123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ojwUhaZ6QLal1kPk+jXM8dL/jirGYZcv159NaGpG9I0=;
	b=Sl6ceI7GQvI9Hk2pitvrJp0Id47OzX7veINR7KsAnIRDtW7sPo18W06h2GFSkKyeT52EXo
	qmBbfBxUd7ZEo+zyiIfvEpZGtG23RF1O1+XIAfP63cxNuITbB4+gTPWFWh3rZyyFNFus8y
	ET0NayBiIAwNSzk77miPclY5y8iPE0U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-xP2-gD_rPEyjdu5w_AlxeA-1; Sun,
 17 Nov 2024 20:08:39 -0500
X-MC-Unique: xP2-gD_rPEyjdu5w_AlxeA-1
X-Mimecast-MFC-AGG-ID: xP2-gD_rPEyjdu5w_AlxeA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 072FA19560AD;
	Mon, 18 Nov 2024 01:08:38 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.113.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3968300019E;
	Mon, 18 Nov 2024 01:08:33 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	bp@alien8.de,
	thomas.lendacky@amd.com
Cc: x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 2/2] x86/mm: clean up unused parameters of functions
Date: Mon, 18 Nov 2024 09:08:19 +0800
Message-ID: <20241118010819.46602-3-bhe@redhat.com>
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

For functions memremap_is_efi_data(), memremap_is_setup_data and
early_memremap_is_setup_data(), their parameter 'size' is not used
and sometime cause confusion. Remove it now.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/ioremap.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 68d78e2b1203..569a62b047a0 100644
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
 
-static bool early_memremap_is_setup_data(resource_size_t phys_addr,
-						unsigned long size)
+static bool early_memremap_is_setup_data(resource_size_t phys_addr)
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


