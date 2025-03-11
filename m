Return-Path: <linux-kernel+bounces-557066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56B4A5D329
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0439417BEE1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F231DE4CD;
	Tue, 11 Mar 2025 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iy/6icOT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2167F1E9B22
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 23:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741735924; cv=none; b=oIFFMsaVc1mYiU5vp0IfdTjUDdsxzPvH8SmZeK3Q616lE+2U3k9uAUQYar8Xu0gb0GHaSezirlPPSLiCzau5uIC1uRUEInDPgB+LuZpVoAetfM52CBBUqcwlT4JPnklvckJ5RmG1qh0/X9ApSav08SZ7zeiFdQCRGH6vpufdtq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741735924; c=relaxed/simple;
	bh=kDfaDRFD6shsKdu/pMXIHDEcVnk7SY3SaYRPT4Slv7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxE7v4Yw0qfsJc5CFFKGgpkOTyOFWeTLx1KxFXGrX/moSUENZTUI2oDP3y1DLiVjA05iQRAbHbalG5560gaaGXAWIKQai/XUqMDQiFEqXjpGcKwBnnrTIoGhdVthdHY4XdNLH97xChzegy1UYbIU8VMYWhyaJjxa0nQQr7mP5VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iy/6icOT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741735922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8INPd9WvtcPC9yCOdy3J5xeTgC7shZeUYjpA84y5sNU=;
	b=iy/6icOTiIzV5NQERclvpmQvA7Jr3Pa9EB7PCG7fyOU2gNHYowGw2OPT+huc4EFG0kX9wX
	o7L0mO9UO2IrO9fdKqtrDYvjBRowHhPpQqSWpTRGu89jcgG66EPuhaRQ9j+IiNijt8C0cs
	Pdjd/d3WFMFEERANCHLta3EvvKAtwIY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-ABJnKkzSOTuhZSaNGXI1aA-1; Tue,
 11 Mar 2025 19:31:16 -0400
X-MC-Unique: ABJnKkzSOTuhZSaNGXI1aA-1
X-Mimecast-MFC-AGG-ID: ABJnKkzSOTuhZSaNGXI1aA_1741735875
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3983419560B0;
	Tue, 11 Mar 2025 23:31:15 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F41F61828A93;
	Tue, 11 Mar 2025 23:31:09 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	akpm@linux-foundation.org,
	shan.gavin@gmail.com
Subject: [PATCH v3 2/2] drivers/base/memory: Correct the field name in the header
Date: Wed, 12 Mar 2025 09:30:44 +1000
Message-ID: <20250311233045.148943-3-gshan@redhat.com>
In-Reply-To: <20250311233045.148943-1-gshan@redhat.com>
References: <20250311233045.148943-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Replace @blocks with @memory_blocks to match with the definition
of struct memory_group.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memory.h b/include/linux/memory.h
index c0afee5d126e..12daa6ec7d09 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -25,7 +25,7 @@
 /**
  * struct memory_group - a logical group of memory blocks
  * @nid: The node id for all memory blocks inside the memory group.
- * @blocks: List of all memory blocks belonging to this memory group.
+ * @memory_blocks: List of all memory blocks belonging to this memory group.
  * @present_kernel_pages: Present (online) memory outside ZONE_MOVABLE of this
  *			  memory group.
  * @present_movable_pages: Present (online) memory in ZONE_MOVABLE of this
-- 
2.48.1


