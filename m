Return-Path: <linux-kernel+bounces-555306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB718A5B54B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CBA189516F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA2E1E25F9;
	Tue, 11 Mar 2025 00:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhCg4FLI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFBD1DE8B4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 00:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741654088; cv=none; b=Qh6zZejHt/VjwHk3i1hJ4qXyARUGAaMr2V+in4gFwPUNyEkA+xFfOpwNX+nsw0aDruAaqEXDuBzZk4XjgtuBmOL1nmyBW5+rbQNrmFn8pAbEIyz+E8qicRJjUOqvEQt4v4b4URYhDkoulf9h/p5HwK4kxg32EZiKWA62CmEP+Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741654088; c=relaxed/simple;
	bh=YmERs+rW+18w2qxrqcTji7wgIx7X4oERW4u69t6kWLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scCtj1KgzW1bI97YNyN9R7GI9dOq3Nxv2wbztOfBTeMzOML8PFVR5HNTbp39rs3Hnn8aVOAy9czOtSMO+QFqE6aztVskVif2urg8tnc4ofFnFfmSXIGZRU7HlICeBjavTVXlhvHvqGsqBfGp63ktcsr4wfJ/ZbyOgCqAYn1p+O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhCg4FLI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741654085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0HbzPi7UYXU5CIv0zG6CMHVf7Xivfr/axNQwtv2yW0=;
	b=RhCg4FLIhjJPxApp0lapcLBA+uRfJUHe+LJoMFR5vayfGZ08fo5M+AZtSshnxWDE7s2Rhe
	GNOeRURrMsBENanr38wOI8rCzq/euSxAEL1DE8mS/5DIbtd9C9YnUcoHUB1CFQXjUr9vE6
	fJ39oyIbtSL8WgqjOIDZP1s3wep5vSg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-2V7kjy-6PcKacCUXDWDGxA-1; Mon,
 10 Mar 2025 20:48:02 -0400
X-MC-Unique: 2V7kjy-6PcKacCUXDWDGxA-1
X-Mimecast-MFC-AGG-ID: 2V7kjy-6PcKacCUXDWDGxA_1741654081
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC2F01800263;
	Tue, 11 Mar 2025 00:48:00 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEDBC18001E9;
	Tue, 11 Mar 2025 00:47:55 +0000 (UTC)
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
Subject: [PATCH v2 2/3] drivers/base/memory: Improve add_boot_memory_block()
Date: Tue, 11 Mar 2025 10:46:56 +1000
Message-ID: <20250311004657.82985-3-gshan@redhat.com>
In-Reply-To: <20250311004657.82985-1-gshan@redhat.com>
References: <20250311004657.82985-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

It's unnecessary to count the present sections for the specified
block since the block will be added if any section in the block
is present. Besides, for_each_present_section_nr() can be reused
as Andrew Morton suggested.

Improve by using for_each_present_section_nr() and dropping the
unnecessary @section_count.

No functional changes intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/base/memory.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 348c5dbbfa68..f66e9d537c12 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -822,18 +822,17 @@ static int add_memory_block(unsigned long block_id, unsigned long state,
 
 static int __init add_boot_memory_block(unsigned long base_section_nr)
 {
-	int section_count = 0;
 	unsigned long nr;
 
-	for (nr = base_section_nr; nr < base_section_nr + sections_per_block;
-	     nr++)
-		if (present_section_nr(nr))
-			section_count++;
+	for_each_present_section_nr(base_section_nr, nr) {
+		if (nr >= (base_section_nr + sections_per_block))
+			break;
 
-	if (section_count == 0)
-		return 0;
-	return add_memory_block(memory_block_id(base_section_nr),
-				MEM_ONLINE, NULL,  NULL);
+		return add_memory_block(memory_block_id(base_section_nr),
+					MEM_ONLINE, NULL, NULL);
+	}
+
+	return 0;
 }
 
 static int add_hotplug_memory_block(unsigned long block_id,
-- 
2.48.1


