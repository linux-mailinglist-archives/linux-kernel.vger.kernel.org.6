Return-Path: <linux-kernel+bounces-426356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577CD9DF20E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 17:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894B1162B64
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B1A1A070E;
	Sat, 30 Nov 2024 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEkvieh2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8401A3AB1
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732985044; cv=none; b=spmG7G8eVT4Iphc/e0lCjahsTeuAu3aVKYwth0qwVJkHHsk2DsoHmVFnNjegHOhju7oS+fuDfehoYIQBcR6JS6AtLdcAOJjdUGZa4RCMr/MTeFVFrKStuTVGSnCH1QbGkrbeSFpKXAmwG4RX1T7hkoZgTpFt1G4g/fbnc+wvu3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732985044; c=relaxed/simple;
	bh=vB6UsFiG66vbE5/IPyqCPbwyZgfipTjRzyCCphUvdRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Myv7SKDPmJWznpXCyqae6ps6GokE89UvbaSoycBCuS1djC4hp8EP2KFCyc0bapy8dbSoAcC7WgyLF+wcwP+T7zj4Ix0m2MWzQzV7EY5ncimd4IwRt4B4+Pxqkh8+eWHWLK7lJa0sbVzz6brIKMygh5RnLFE/Pxoc3OjS4ogbAxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dEkvieh2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732985041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=REyeVoRX10hydiXMzUjbEHtT4HCsZjLURReys2nYjK0=;
	b=dEkvieh2pJvA8x7QCD/nECsweKK5IomLMIaxx+lRzmJAvFUA/PJHraBYM309E6Ortz8Dn0
	IWmLrBPWS9MPv9EdQN+L+kCy9UbGMDwEfU5ehD22EveMjnUenD3tWJL9g1EF3BuT70TKLQ
	UiYZMEUkRANJKeKKTwuG3kYybT1ug+k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-w16SiC6vPDm7_bQ2fuvIDQ-1; Sat,
 30 Nov 2024 11:43:56 -0500
X-MC-Unique: w16SiC6vPDm7_bQ2fuvIDQ-1
X-Mimecast-MFC-AGG-ID: w16SiC6vPDm7_bQ2fuvIDQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94F99195608C;
	Sat, 30 Nov 2024 16:43:55 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6DD97300018D;
	Sat, 30 Nov 2024 16:43:53 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	mgorman@techsingularity.net,
	snishika@redhat.com
Subject: [PATCH] mm: vmscan: account for free pages to prevent infinite Loop in throttle_direct_reclaim()
Date: Sun,  1 Dec 2024 01:43:46 +0900
Message-ID: <20241130164346.436469-2-snishika@redhat.com>
In-Reply-To: <20241130164346.436469-1-snishika@redhat.com>
References: <20241130164346.436469-1-snishika@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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


