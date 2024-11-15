Return-Path: <linux-kernel+bounces-410136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA3B9CD504
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 02:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A03CEB24D18
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 01:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0FB44375;
	Fri, 15 Nov 2024 01:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2yLqftE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F471E522
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731633709; cv=none; b=CjUegeYJqXpV0oe5/onY/slf6fKSYqlMCHC4R1cb/cv2HmjydGrQrCYieCSGJozQDalcQutSwiwYPpqkU9x3LQiY157CHcq22zKx/xvdqt9LYJlqG+pOoV4BaGwK5rrp+C02nyVo73yC6UMuCT14vj1UswgJiHxbj2Ex12GyLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731633709; c=relaxed/simple;
	bh=uDcZIIbz0+WPEIzGh1sdc3TfrrracFPlsupkkxm6rvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=jdR1VIZcgfXvyvEVB8epcwrypWwOEQJxCSn+eokWZGRpHqkSnGzZDSNbCuIFInnx+hCaTo2tPzMYZpt/eiRwwgSzdQVJXJxjfEsQ5Wxfo4iNdAStJJihkx/4R0GlfMTg5NCSRFOnMLWjMWe0TOSPXk0c9f8k9hCNLWurEgxF33Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2yLqftE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731633706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBAI7kp1alNZNqlSIDUgviK0JRdKueloTz4aSb5nzkc=;
	b=E2yLqftETaqMn1yb87r8yga3jFsH8D7dy/gQTPGtLkhegk0MI7upZA/v1qAHBZzfK2C9lK
	oauA45tEHkmt3lm0l0o+KKhSC06L0rwVxQ+ANR771CZJVcd6AM4eGXeY5dbbIuv7s2G8m6
	yjTcmh11cGqOlyeZPgs2LHwiFOD4q5s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-OLExu5N6Nu2yr4lDK_DhfA-1; Thu,
 14 Nov 2024 20:21:44 -0500
X-MC-Unique: OLExu5N6Nu2yr4lDK_DhfA-1
X-Mimecast-MFC-AGG-ID: OLExu5N6Nu2yr4lDK_DhfA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 512441955F69;
	Fri, 15 Nov 2024 01:21:43 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.16])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A63E3003B71;
	Fri, 15 Nov 2024 01:21:39 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org,
	bp@alien8.de
Cc: x86@kernel.org,
	thomas.lendacky@amd.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/3] x86/ioremap: introduce helper to check if physical address is in setup_data
Date: Fri, 15 Nov 2024 09:21:29 +0800
Message-ID: <20241115012131.509226-2-bhe@redhat.com>
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

Functions memremap_is_setup_data() and early_memremap_is_setup_data()
share completely the same process and handling, except of the
different memremap/unmap invocations.

Add helper __memremap_is_setup_data() to extract the common part,
parameter 'early' is used to decide what kind of memremap/unmap
APIs are called.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/mm/ioremap.c | 81 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 8d29163568a7..5ef6182db630 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -628,6 +628,87 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
 	return false;
 }
 
+#define SD_SIZE sizeof(struct setup_data)
+/*
+ * Examine the physical address to determine if it is boot data by checking
+ * it against the boot params setup_data chain.
+ */
+static bool __init __memremap_is_setup_data(resource_size_t phys_addr,
+						bool early)
+{
+	struct setup_indirect *indirect;
+	struct setup_data *data;
+	u64 paddr, paddr_next;
+
+	paddr = boot_params.hdr.setup_data;
+	while (paddr) {
+		unsigned int len, size;
+
+		if (phys_addr == paddr)
+			return true;
+
+		if (early)
+			data = early_memremap_decrypted(paddr, SD_SIZE);
+		else
+			data = memremap(paddr, SD_SIZE,
+					MEMREMAP_WB | MEMREMAP_DEC);
+		if (!data) {
+			pr_warn("failed to memremap setup_data entry\n");
+			return false;
+		}
+
+		size = SD_SIZE;
+
+		paddr_next = data->next;
+		len = data->len;
+
+		if ((phys_addr > paddr) &&
+		    (phys_addr < (paddr + SD_SIZE + len))) {
+			if (early)
+				early_memunmap(data, SD_SIZE);
+			else
+				memunmap(data);
+			return true;
+		}
+
+		if (data->type == SETUP_INDIRECT) {
+			size += len;
+			if (early) {
+				early_memunmap(data, SD_SIZE);
+				data = early_memremap_decrypted(paddr, size);
+			} else {
+				memunmap(data);
+				data = memremap(paddr, size,
+						MEMREMAP_WB | MEMREMAP_DEC);
+			}
+			if (!data) {
+				pr_warn("failed to memremap indirect setup_data\n");
+				return false;
+			}
+
+			indirect = (struct setup_indirect *)data->data;
+
+			if (indirect->type != SETUP_INDIRECT) {
+				paddr = indirect->addr;
+				len = indirect->len;
+			}
+		}
+
+		if (early)
+			early_memunmap(data, size);
+		else
+			memunmap(data);
+
+		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
+			return true;
+
+		paddr = paddr_next;
+	}
+
+	return false;
+}
+#undef SD_SIZE
+
 /*
  * Examine the physical address to determine if it is boot data by checking
  * it against the boot params setup_data chain.
-- 
2.41.0


