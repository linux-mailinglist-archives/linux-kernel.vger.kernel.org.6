Return-Path: <linux-kernel+bounces-410137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8379CD505
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 02:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C38E6B24EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 01:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E5F143C45;
	Fri, 15 Nov 2024 01:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GY+DQUNA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44351E522
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731633714; cv=none; b=eDxZksHoKtMGDqSUPmqG2WR4vQZ9yUd+g/gUFmafSW6lTuk35WIcW9R2rGL/gfPJPPWc7tlCUW6mpWia/+d0gZYrMfK4eUGYBVhH89H2Ew5lRMoeRUBH239GOnPYgIvsmHS9CIBrcv4pipAXILm3MFx55KlsMB4O47wMGmtJSMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731633714; c=relaxed/simple;
	bh=rx6rKoISxTQ2TqVk5jocBzk88C5SjCsg+QLtNmT7Tm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=OF+cEmXZxCII6rhCaQ0O6V1m6ueO8EdawuxUfHkG0lwfoZlPhhmqO6ExbuxC6vEbWZoGEOsztcdqVF5cRbaDe60dYlk60Q7Odu8nxUAlJ69xrq4Ma3kG1c0GLPCCo8q6jcFfJOlFu62hsB5oxFJbOZ6/YaJjEfl+wDv3jVYViyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GY+DQUNA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731633711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNrA0Y0eLxm5pkvtcUoqqFPIPW27ZMWIeXhHj6rouCw=;
	b=GY+DQUNA03U3gifRz4NDbL/PYiuChd1jEbmhK1eq8AlWM/pUWpnTgLbFqhxqNg2DHRfuuk
	7WmVNo6FOofesu9FLWodH+ogiEYXNsid22kxWfsYfj16MQsKo5sRhpBw60n63Zfj5pUeZX
	7aljxIMIBp/7NvGJ7oTRHJcHzqT1qHg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-JMB7O4c0P4OVNieUVkie5g-1; Thu,
 14 Nov 2024 20:21:48 -0500
X-MC-Unique: JMB7O4c0P4OVNieUVkie5g-1
X-Mimecast-MFC-AGG-ID: JMB7O4c0P4OVNieUVkie5g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C5FE19560BE;
	Fri, 15 Nov 2024 01:21:47 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 238463003B71;
	Fri, 15 Nov 2024 01:21:43 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org,
	bp@alien8.de
Cc: x86@kernel.org,
	thomas.lendacky@amd.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/3] x86/ioremap: use helper to implement xxx_is_setup_data()
Date: Fri, 15 Nov 2024 09:21:30 +0800
Message-ID: <20241115012131.509226-3-bhe@redhat.com>
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

This simplifies codes a lot by removing the duplicated code handling.

And also remove the similar code comment above of them.

While at it, add __ref to memremap_is_setup_data() to avoid
the section mismatch warning:

WARNING: modpost: vmlinux: section mismatch in reference: arch_memremap_can_ram_remap.cold+0x6 (section: .text.unlikely) -> __memremap_is_setup_data (section: .init.text)
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/ioremap.c | 119 ++----------------------------------------
 1 file changed, 3 insertions(+), 116 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 5ef6182db630..5d1b5e4a8756 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -709,129 +709,16 @@ static bool __init __memremap_is_setup_data(resource_size_t phys_addr,
 }
 #undef SD_SIZE
 
-/*
- * Examine the physical address to determine if it is boot data by checking
- * it against the boot params setup_data chain.
- */
-static bool memremap_is_setup_data(resource_size_t phys_addr,
+static bool __ref memremap_is_setup_data(resource_size_t phys_addr,
 				   unsigned long size)
 {
-	struct setup_indirect *indirect;
-	struct setup_data *data;
-	u64 paddr, paddr_next;
-
-	paddr = boot_params.hdr.setup_data;
-	while (paddr) {
-		unsigned int len;
-
-		if (phys_addr == paddr)
-			return true;
-
-		data = memremap(paddr, sizeof(*data),
-				MEMREMAP_WB | MEMREMAP_DEC);
-		if (!data) {
-			pr_warn("failed to memremap setup_data entry\n");
-			return false;
-		}
-
-		paddr_next = data->next;
-		len = data->len;
-
-		if ((phys_addr > paddr) &&
-		    (phys_addr < (paddr + sizeof(struct setup_data) + len))) {
-			memunmap(data);
-			return true;
-		}
-
-		if (data->type == SETUP_INDIRECT) {
-			memunmap(data);
-			data = memremap(paddr, sizeof(*data) + len,
-					MEMREMAP_WB | MEMREMAP_DEC);
-			if (!data) {
-				pr_warn("failed to memremap indirect setup_data\n");
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
-		memunmap(data);
-
-		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
-			return true;
-
-		paddr = paddr_next;
-	}
-
-	return false;
+	return __memremap_is_setup_data(phys_addr, false);
 }
 
-/*
- * Examine the physical address to determine if it is boot data by checking
- * it against the boot params setup_data chain (early boot version).
- */
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


