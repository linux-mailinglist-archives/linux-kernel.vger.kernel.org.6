Return-Path: <linux-kernel+bounces-324431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D4B974C55
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAF9286659
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD771175D29;
	Wed, 11 Sep 2024 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edJGh4cJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3ED2C859
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042598; cv=none; b=YCtNBc1WizikXT+E78eJSJx4RKJAFeBxaIrjZPcs1E2GhptZo1dzxT7CWkuHobTtwo8wcWBfBh1aNwK+wRuF8ReXPUmmmoJXaQwCvBbxxeYgcVmX3WCRXDIF7A/tRPIa6FG1qCuTGv6W685uhxKgSQz1WfmUVhkJAdppShVxluY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042598; c=relaxed/simple;
	bh=K3DJKQ/2on8Wyw9uNsUdV1aywXO/YuL1o5WES5cGGvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=FAGkxIrjTkB0CXB1agnngsJaVYW9LK/yqAdkA3Jo7/ucxIyVjxYDRiScrcuuaT99pFoX/7WMep5QPIuspb3Y5x0fu4J5puEtwiFsmQK6yaEnavhyMHvYokdc0TRI+wfWAn6FHs2PNMg+oS3phmahLIdRH9+MBLuh+FuxPkZO+UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=edJGh4cJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726042595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5yv95X4eG3twwLNvJXq61BcdIuFvnrT30obkauJq40=;
	b=edJGh4cJ+5EunFZ7X8SqzqRGAaVW4A95xsJo3vjWyFU7mWWrHbR3nhWJHOYlGrJyldsbRE
	wk8Nm7G7asHfO9LNF0ZpaqAcyGedd4x4fhyemDBa/gxTj2i3HyNsD9Nq2F+UxZaqPDLTZ6
	L8UB+QhVkyYumlgWmopMUF1s2Ud/dzg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-l4hOSEeuM0OsJUmBcCcalA-1; Wed,
 11 Sep 2024 04:16:32 -0400
X-MC-Unique: l4hOSEeuM0OsJUmBcCcalA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18BE91955F29;
	Wed, 11 Sep 2024 08:16:31 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.58])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 291A830001A1;
	Wed, 11 Sep 2024 08:16:25 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: thomas.lendacky@amd.com,
	dyoung@redhat.com,
	daniel.kiper@oracle.com,
	noodles@fb.com,
	lijiang@redhat.com,
	kexec@lists.infradead.org,
	x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 1/2] x86/mm: rename the confusing local variable in early_memremap_is_setup_data()
Date: Wed, 11 Sep 2024 16:16:14 +0800
Message-ID: <20240911081615.262202-2-bhe@redhat.com>
In-Reply-To: <20240911081615.262202-1-bhe@redhat.com>
References: <20240911081615.262202-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In function early_memremap_is_setup_data(), parameter 'size' passed has
the same name as the local variable inside the while loop. That
confuses people who sometime mix up them when reading code.

Here rename the local variable 'size' inside while loop to 'sd_size'.

And also add one local variable 'sd_size' likewise in function
memremap_is_setup_data() to simplify code. In later patch, this can also
be used.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
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


