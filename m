Return-Path: <linux-kernel+bounces-432783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7454B9E5044
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3064F2851ED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C6E1D54F4;
	Thu,  5 Dec 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdTpacrp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821561D47C1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388758; cv=none; b=CsQbJKv+fuf7wj2KNWdYg2rR6gbIiZvvPlpHxS/PUOe2YrgpBHXa7/oWGcYtY7fpppLa01Q1Egdd3fSZ4wAssaDYa4L2r2fHW6CPLlYqUgJtbiWCHaNsEmGFI9cubL3AYyrX0LqgYJmfEDsLJ7w7FIr39N8+XCswcG9tAZVZavE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388758; c=relaxed/simple;
	bh=IujUqxIIz9or27UE5qj0dIk5ibqYWO46P31Yzdy8bcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ynruao2yg21kCqcWiVmWoT9oaku8/yIdbf4AHe93e+ye9nTyUog2b8c2Y1U7EIzQittNgpSQ0PmOXz9wOcsmorguv0ua7q4HsVzruJI1QF7IbMxTwuU/U0qwZBHMeAbAi/53iUwaI8+ata9el0cX/Qw2KUDkWXGA5ePxT8CuNOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SdTpacrp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733388755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/0LS59BHWZxT7JElUljbxSyn36zBZn8FjqEt24DcDM=;
	b=SdTpacrp9YE50hytqMr1B+vdR9RizDrpradrrcGmlcTvQ9xQ6zZ4MzxVfc4NQDklJqbgyZ
	hdS3OQKsOPzF0QhA6UJRFzdYyOse1y/npy6PcVDDaySoHXWTgU9CKSn7HpvhvK/6lNhzft
	YWA7SVuMv+cBZzKYPHNS50L4COGhCr4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-FzyjMJjlOHicLiRvrIQLYQ-1; Thu,
 05 Dec 2024 03:52:30 -0500
X-MC-Unique: FzyjMJjlOHicLiRvrIQLYQ-1
X-Mimecast-MFC-AGG-ID: FzyjMJjlOHicLiRvrIQLYQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7201195608C;
	Thu,  5 Dec 2024 08:52:28 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.64.94])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 47B051956052;
	Thu,  5 Dec 2024 08:52:25 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v1 2/2] mm/memory_hotplug: don't use __GFP_HARDWALL when migrating pages via memory offlining
Date: Thu,  5 Dec 2024 09:52:17 +0100
Message-ID: <20241205085217.2086353-3-david@redhat.com>
In-Reply-To: <20241205085217.2086353-1-david@redhat.com>
References: <20241205085217.2086353-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

We'll migrate pages allocated by other context; respecting the cpuset of
the memory offlining context when allocating a migration target does not
make sense.

Drop the __GFP_HARDWALL by using GFP_KERNEL.

Note that in an ideal world, migration code could figure out the cpuset
of the original context and take that into consideration.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 5f497ccf473d..3b6f93962481 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1838,7 +1838,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		nodemask_t nmask = node_states[N_MEMORY];
 		struct migration_target_control mtc = {
 			.nmask = &nmask,
-			.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+			.gfp_mask = GFP_KERNEL | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
 			.reason = MR_MEMORY_HOTPLUG,
 		};
 		int ret;
-- 
2.47.1


