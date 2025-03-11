Return-Path: <linux-kernel+bounces-555722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7939DA5BBD9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92EE172F9C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A9F225A20;
	Tue, 11 Mar 2025 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ReHkJGdJ"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125564431
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684652; cv=none; b=m+hO3Bf0ki2udBWQGDn/GQBqh7hY+PGVYaXQJQNgZK4USKQUecIm9RmEG1Wded/IBAtQizoYvHSRLOeLUUDK2BU5EZyrimLNxOW9qfJCTygjOwYANaOODENArxT+BUQxMxNldCAeY/DFWQ/kMUhqIz3KSpus1VkkNnV++gjPErE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684652; c=relaxed/simple;
	bh=vSRBR6JVW9kfsloXzWOfps2gPOA+TmIHogOfqXovEpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QfUcMExrrZHZvjZScHizzXlTkdxsO385QtEwEnPMg1WCrA6DdBJzgkgdHAY278X+EfJdGB/53ORDLmNevZKkmUUy/Ozuq81qb9/IJYH7sDOSq6G0/cj5k5HtNULVVJkFdJ+SPVh1reywbs4JZbJX0OoFphtQ4m26Ei4EsE97P/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ReHkJGdJ; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741684636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vs7ucL2qVfTeNJVnGw+KUc65l6Ql6UNvI1z2Xqd8sIw=;
	b=ReHkJGdJOQevrZcH/C5Pk/mlXkT8yoWWVZnS+NzhZAXZMd9e4ugiNhG7qQrC9uS36JYRIA
	MRKmHYR+Dl9DTC0JlEfb2wXzabAAU5X0r5Bd6db3NOGC9ZxfSXg2kvcwgxT0BjM2DMkg0A
	wsbJG0PG3qIWOLHGLjACi0VBE9sTKTc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] hyperv: Remove unused union and structs
Date: Tue, 11 Mar 2025 10:16:34 +0100
Message-ID: <20250311091634.494888-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The union vmpacket_largest_possible_header and several structs have not
been used for a long time afaict - remove them.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Remove unused struct vmadditional_data as suggested by Michael Kelley
- Link to v1: https://lore.kernel.org/r/20250310192629.443162-1-thorsten.blum@linux.dev/
---
 include/linux/hyperv.h | 56 ------------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 4179add2864b..094395f4be24 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -371,19 +371,6 @@ struct vmtransfer_page_packet_header {
 	struct vmtransfer_page_range ranges[];
 } __packed;
 
-struct vmgpadl_packet_header {
-	struct vmpacket_descriptor d;
-	u32 gpadl;
-	u32 reserved;
-} __packed;
-
-struct vmadd_remove_transfer_page_set {
-	struct vmpacket_descriptor d;
-	u32 gpadl;
-	u16 xfer_pageset_id;
-	u16 reserved;
-} __packed;
-
 /*
  * This structure defines a range in guest physical space that can be made to
  * look virtually contiguous.
@@ -394,30 +381,6 @@ struct gpa_range {
 	u64 pfn_array[];
 };
 
-/*
- * This is the format for an Establish Gpadl packet, which contains a handle by
- * which this GPADL will be known and a set of GPA ranges associated with it.
- * This can be converted to a MDL by the guest OS.  If there are multiple GPA
- * ranges, then the resulting MDL will be "chained," representing multiple VA
- * ranges.
- */
-struct vmestablish_gpadl {
-	struct vmpacket_descriptor d;
-	u32 gpadl;
-	u32 range_cnt;
-	struct gpa_range range[1];
-} __packed;
-
-/*
- * This is the format for a Teardown Gpadl packet, which indicates that the
- * GPADL handle in the Establish Gpadl packet will never be referenced again.
- */
-struct vmteardown_gpadl {
-	struct vmpacket_descriptor d;
-	u32 gpadl;
-	u32 reserved;	/* for alignment to a 8-byte boundary */
-} __packed;
-
 /*
  * This is the format for a GPA-Direct packet, which contains a set of GPA
  * ranges, in addition to commands and/or data.
@@ -429,25 +392,6 @@ struct vmdata_gpa_direct {
 	struct gpa_range range[1];
 } __packed;
 
-/* This is the format for a Additional Data Packet. */
-struct vmadditional_data {
-	struct vmpacket_descriptor d;
-	u64 total_bytes;
-	u32 offset;
-	u32 byte_cnt;
-	unsigned char data[1];
-} __packed;
-
-union vmpacket_largest_possible_header {
-	struct vmpacket_descriptor simple_hdr;
-	struct vmtransfer_page_packet_header xfer_page_hdr;
-	struct vmgpadl_packet_header gpadl_hdr;
-	struct vmadd_remove_transfer_page_set add_rm_xfer_page_hdr;
-	struct vmestablish_gpadl establish_gpadl_hdr;
-	struct vmteardown_gpadl teardown_gpadl_hdr;
-	struct vmdata_gpa_direct data_gpa_direct_hdr;
-};
-
 #define VMPACKET_DATA_START_ADDRESS(__packet)	\
 	(void *)(((unsigned char *)__packet) +	\
 	 ((struct vmpacket_descriptor)__packet)->offset8 * 8)
-- 
2.48.1


