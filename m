Return-Path: <linux-kernel+bounces-426345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8099DF1F2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 17:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AB5281797
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C161A38C4;
	Sat, 30 Nov 2024 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4lC0DWv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB201A265D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732983175; cv=none; b=rYINiz9CHjZv7ExJFVmNfML5NfGqpuKZ+f7YBe2F1G01aEe4gRzvqK+Oj8lP+U/ippyP1LUDbBYS15ZVTsvev50N58LBXcMfHto9ngFFXnCnZfYesQiATwsNHmvJ+OZ4otPcIDFzw7RKQ33ly/7J88njnncDplxKfA7hhrJsIAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732983175; c=relaxed/simple;
	bh=vB6UsFiG66vbE5/IPyqCPbwyZgfipTjRzyCCphUvdRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h49H7NhVfgVe0b05HdfCICRqz4oK9GaIcbUeLjvt7kYHhza7i+MqE8f9Vpb5BdK4gYvI+Umjjd7NWqmGdHGcI4f4o1fkFLKJEvJAOB7wYnfBYwFEuOhSjqKxBNFzxcgMx+KXCKs4r4dj1+KUy/lC7D+AbbcOcQ/2aX+Ga9SqbN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4lC0DWv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732983172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=REyeVoRX10hydiXMzUjbEHtT4HCsZjLURReys2nYjK0=;
	b=Z4lC0DWvKfv0duKvAvhQGSN2Moe8vWADQ8kQEBSXtdM/OusvPqD/HRFb8cPHm/7l+7ZZfl
	Gx9539/ywkEkJHGKRZkExyTy3wa42d81xhenv6PJ5Q0BGamMnJ1nku6LdeEL20DGtA7TAw
	pHx+dyp4NMiPuE7WLMuk4lSgtJeioCI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-i5hcru3xOe25Lp_c-5LywA-1; Sat,
 30 Nov 2024 11:12:49 -0500
X-MC-Unique: i5hcru3xOe25Lp_c-5LywA-1
X-Mimecast-MFC-AGG-ID: i5hcru3xOe25Lp_c-5LywA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 93A461955F43;
	Sat, 30 Nov 2024 16:12:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.33])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5326C1956089;
	Sat, 30 Nov 2024 16:12:45 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	mgorman@techsingularity.net,
	snishika@redhat.com
Subject: [PATCH] mm: vmscan: account for free pages to prevent infinite Loop in throttle_direct_reclaim()
Date: Sun,  1 Dec 2024 01:12:34 +0900
Message-ID: <20241130161236.433747-2-snishika@redhat.com>
In-Reply-To: <20241130161236.433747-1-snishika@redhat.com>
References: <20241129043936.316481-1-snishika@redhat.com>
 <20241130161236.433747-1-snishika@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The kernel hangs due to a task stuck in throttle_direct_reclaim(),
caused by a node being incorrectly deemed balanced despite pressure in
certain zones, such as ZONE_NORMAL. This issue arises from
zone_reclaimable_pages() returning 0 for zones without reclaimable file-
backed or anonymous pages, causing zones like ZONE_DMA32 with sufficient
free pages to be skipped.

The lack of swap or reclaimable pages results in ZONE_DMA32 being
ignored during reclaim, masking pressure in other zones. Consequently,
pgdat->kswapd_failures remains 0 in balance_pgdat(), preventing fallback
mechanisms in allow_direct_reclaim() from being triggered, leading to an
infinite loop in throttle_direct_reclaim().

This patch modifies zone_reclaimable_pages() to account for free pages
(NR_FREE_PAGES) when no other reclaimable pages exist. This ensures
zones with sufficient free pages are not skipped, enabling proper
balancing and reclaim behavior.

Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
---
 mm/vmscan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 76378bc257e3..fb6b4056dcce 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -374,7 +374,14 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
 	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
 		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
 			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
-
+	/*
+	 * If there are no reclaimable file-backed or anonymous pages, 
+	 * ensure zones with sufficient free pages are not skipped. 
+	 * This prevents zones like DMA32 from being ignored in reclaim 
+	 * scenarios where they can still help alleviate memory pressure.
+	 */
+	if (nr == 0)
+	    nr = zone_page_state_snapshot(zone, NR_FREE_PAGES);
 	return nr;
 }
 
-- 
2.47.0


