Return-Path: <linux-kernel+bounces-557064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1F5A5D324
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC61189D88D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0B91F4CAC;
	Tue, 11 Mar 2025 23:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhBMrSLA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645C742A87
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 23:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741735880; cv=none; b=hHhkCYUq9DQ9NnoXVNeDbTPp22JdF+L4R47jT+4oZP3XhHAoPtb5ouyO5iHgyW82saG2yVwn9MLlOguYSn3PCffza7DsjQhTCyIuEIyS3ck7OBvIRG7vx3IZFphyMr7ot7y7T7CcC182P4nLspAeOKJ0mSxsB7JiAIdH8ytiTgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741735880; c=relaxed/simple;
	bh=WQTgGWyDwEesTK+r9mqc7KbfBgqE9eIvIxfj1+z9MeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9E+uzEOV0xMV+8JwNZuQ1cgF9Ca6HWbKHaM4rArgP7NVIHaAd29sj/IB8xt7lfViOuFQOoZCCY87tkDkCZczO3YbJqXmeFmmpwKtQeMPC7nQhkuuHeG/sHk5+CQqsQdML0i6Ca8zu0A+ZGtDForSvPwJ52p7Q/tA0oEgNbNK18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhBMrSLA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741735876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFRXYsV6OcgqgN+/5AlzPbliPGGUfcZP8+g1uf56q6A=;
	b=LhBMrSLA/J3hRgtfTFuQ/PasKiI536jMaxOF0+J3gjBThaE3EzHTNj2vWQ96SSJ2SOpcBE
	pu/3fVRdnJ53hxDQMeGTe6+dP5aYhu5uXvAfJ+Mlr4GXJ1MH18lQn/0vKotHaOvfuzgGv3
	nlPd5Igp0xHRI6EBb986sB9K+XzV4lk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-2i3KdKclNQ2phTZIy6UYCQ-1; Tue,
 11 Mar 2025 19:31:11 -0400
X-MC-Unique: 2i3KdKclNQ2phTZIy6UYCQ-1
X-Mimecast-MFC-AGG-ID: 2i3KdKclNQ2phTZIy6UYCQ_1741735869
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC52A195608A;
	Tue, 11 Mar 2025 23:31:08 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.79])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76BAF1828A98;
	Tue, 11 Mar 2025 23:31:03 +0000 (UTC)
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
Subject: [PATCH v3 1/2] drivers/base/memory: Improve add_boot_memory_block()
Date: Wed, 12 Mar 2025 09:30:43 +1000
Message-ID: <20250311233045.148943-2-gshan@redhat.com>
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

It's unnecessary to count the present sections for the specified
block since the block will be added if any section in the block
is present. Besides, for_each_present_section_nr() can be reused
as Andrew Morton suggested.

Improve by using for_each_present_section_nr() and dropping the
unnecessary @section_count.

No functional changes intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/memory.c  | 17 ++++++++---------
 include/linux/mmzone.h |  5 +++++
 mm/sparse.c            |  5 -----
 3 files changed, 13 insertions(+), 14 deletions(-)

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
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9540b41894da..0f6646da34d7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2097,6 +2097,11 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
 	return -1;
 }
 
+#define for_each_present_section_nr(start, section_nr)		\
+	for (section_nr = next_present_section_nr(start - 1);	\
+	     section_nr != -1;					\
+	     section_nr = next_present_section_nr(section_nr))
+
 /*
  * These are _only_ used during initialisation, therefore they
  * can use __initdata ...  They could have names to indicate
diff --git a/mm/sparse.c b/mm/sparse.c
index 133b033d0cba..fe77d523ab8d 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -170,11 +170,6 @@ static void __section_mark_present(struct mem_section *ms,
 	ms->section_mem_map |= SECTION_MARKED_PRESENT;
 }
 
-#define for_each_present_section_nr(start, section_nr)		\
-	for (section_nr = next_present_section_nr(start-1);	\
-	     section_nr != -1;								\
-	     section_nr = next_present_section_nr(section_nr))
-
 static inline unsigned long first_present_section_nr(void)
 {
 	return next_present_section_nr(-1);
-- 
2.48.1


