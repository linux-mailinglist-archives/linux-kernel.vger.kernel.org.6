Return-Path: <linux-kernel+bounces-554953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F0CA5A3C2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D322C3ADD12
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAA8235C0F;
	Mon, 10 Mar 2025 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uJavZm+h"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B09235371
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634796; cv=none; b=RWF2BlC/e29JXiu5zDdeVSpGgS0libHqjTp3pogZuvW0SYYdcnldLVSeHgZuY8mrfvU3HaisExCn2dYEGIJQWE9uzRnKh7Y3sT4hbE/IO41sFGDSbFkSwUfsJtfFTLgQiidRXU6MmSiN+yyxcB/NRBO2yPSd7MvvIEu1OKfZMq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634796; c=relaxed/simple;
	bh=aMGKEDfrbum8nYqKksNtLhPPEJw4CitcdWmFichjJN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hfJ0y+nukYS0OK1P6PhWAhtpZJN26I33cG+IZ50+uXncrdI7iJjVECOVENldzd4jAxv94YxsN8AkaHBzodZqwgk604d5atItOa7nkBdwXmCFXSzExFlYHI5/qemUHaPrvoWa+6/4sUAYRDtYlhDmVrc5gKsoFvgQBe7af+1NYEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uJavZm+h; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741634792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zoz7U82cuSBuipZrq5cc1/YujrMio5TtbgMMrkTdaHQ=;
	b=uJavZm+hVT+Sn4mwU2rlaDFBjFkhD/ISd9k/37fv8gMHOZoBVwiFz81wleAyqi+cdMi657
	xRJN3fx6QhhvxuTI5wgSuVxercBU1S1GNy9VjIqVt69YIQnJ7cA+w8gmlnlrgsjVgc0JLH
	CDbDK2bx1XRk/iefHJxFAwwZs4ltgNU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hyperv: Remove unused union and structs
Date: Mon, 10 Mar 2025 20:26:28 +0100
Message-ID: <20250310192629.443162-1-thorsten.blum@linux.dev>
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

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/hyperv.h | 47 ------------------------------------------
 1 file changed, 47 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 4179add2864b..bff91788c8a3 100644
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
@@ -438,16 +401,6 @@ struct vmadditional_data {
 	unsigned char data[1];
 } __packed;
 
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


