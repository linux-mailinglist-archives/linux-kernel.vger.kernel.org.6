Return-Path: <linux-kernel+bounces-429181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C15A9E183D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BE9281800
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1C81E009F;
	Tue,  3 Dec 2024 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4TXOAcb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8343C1E0DC4
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219272; cv=none; b=j9Qy+FhE18c7le9CMUwUXBOj0jb10l5mkCpYx5CKT/63Uwf6/CC7D0Y2NV5JOJ5WbFugfD0425wYqDb4ap4IX1yH5rv14+FeSLku/foi9nTDEQHZQ+m5BgdvUezDvkBIjiY76pF/XyKI6T3yVnmQdmuSqYcc3pAJVr3kfvXgkDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219272; c=relaxed/simple;
	bh=zs3lLNFK3QoHU77IaNQAuxta7H4Ik319E+q8Lswq4rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKnJwfopJXjCMo5XcVqastZ69W3Gs2FLW/OxQ4k9BphCPyKvTdlDSGxZnRkR/rojnOKBzAIghsIqShltTp3EuGj9RcyhfGM9An5RudTxpTbV3lioQlQ6kHCzmBNUEQXd8TeYG8d3wid4qHAySdJ4AVA+j3kjRwE6H4nAVM/YEJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4TXOAcb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733219269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjBW/vjYP3nNfvObrA09IpRDh5cADITJHgvHLWqOgrU=;
	b=N4TXOAcbSH2OiSPNKu3Z3l5x4x1EGT/x5IPwRkbbrjJKG0WbVLk6mRhKY7/8Y5ZYQksA3w
	/d2U/XjPdoZti1gUJi2NPHrutegP7Frq2X7DK0kOSTL8dX84u1piSHaQYDKgpd8AS0/LdQ
	EPwp/2+f/46GigSemwCbtP/LznNnNEU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-GCpHrBm5NYeFep_CBKnv4w-1; Tue, 03 Dec 2024 04:47:48 -0500
X-MC-Unique: GCpHrBm5NYeFep_CBKnv4w-1
X-Mimecast-MFC-AGG-ID: GCpHrBm5NYeFep_CBKnv4w
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385d6ee042eso3248456f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733219267; x=1733824067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjBW/vjYP3nNfvObrA09IpRDh5cADITJHgvHLWqOgrU=;
        b=h1p/GnLHd4loqzQGNMtIGw/Au2+GFVj4lskTNTx75AavdtvOo658NWkP5DARBiBrxB
         1MVW5ho/DvcVjU5ryvNNV2jxGF82f/VzKWFwZacv6UrJCu7igqJ/EAai/Zu5tjOVYyNC
         9LcLi9KjHDpaSv+80IQXe+syu+i9ZEhYqHvdHHAOZXkKxq4smgSE02UhA2Q7/lMiMQoJ
         x54guurvo3xwK11n95lWq9qxfrH1eDUmZbJN3mWbWd/TZd+MrIoc+GderDArJiKHS+iq
         lBHuOvCg5mXj6LygXQ6GPSsLfVu4jkFrzuyZTsmzHR97SbDmus4uRp/sKg2MEPJjTxQg
         oR1g==
X-Gm-Message-State: AOJu0YwlA/6mwxd1VRpsJHCwcE9BCiosJhS04K11amW5GpCJIWUCwKR0
	reUh+DP+xDO7LnH/kW9kHp9ZjwkFrnxXYB7L7eNxRvb75GFCo1D9+T7+v4ziuQIKVDJeoYLSSEt
	mUY1BQciVrTz/4v/iZO/H1qVdCsURrJ33eQ2q54cX8nx3+sETV6PlHAQFyVnAqplVjCgferti3S
	0cBCTLEL+zyDS7q/T7QCkYkjUQpfS7A2h1Ut8u6JqINHVo
X-Gm-Gg: ASbGncsWlTiYQoV2T9o35fDLU2dbdwYF9jchK2/JNr10X0NGqGfJ1wIdqbhm/7Uwyzy
	58AcQ+N+EX4tNzUfwCob6yYGr9o7lR5nJX2viBJpLTG5KOYDyIY5UraPnuruV3Iwvz5m87Y1bVa
	2frxw2oxWE1DZQKoo1R1WlrUpdgryPR1J/C1a0ifmjY0hHzsvFuI2sl3r01g1FOJNkVLSzCeI3w
	1RF0pvuHK135R0himhzDTbJNzQrDN1Vq33a4sNagkU7UI5L7FS46NI1fF0dvATDxCl8/T1Hc7nx
	B0O0Tpg3TsgxDoUSCbFlgaJ4u02SlDaBDgM=
X-Received: by 2002:a05:6000:70c:b0:385:efc7:932d with SMTP id ffacd0b85a97d-385fd423ae4mr1564042f8f.46.1733219267519;
        Tue, 03 Dec 2024 01:47:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaOJ9gxKaUnP3CbsR1qXN6hxrElYasKjqPVFXIuPLpn506OYh8TYc8ohv1ITpz8dyfapfkFg==
X-Received: by 2002:a05:6000:70c:b0:385:efc7:932d with SMTP id ffacd0b85a97d-385fd423ae4mr1564014f8f.46.1733219267074;
        Tue, 03 Dec 2024 01:47:47 -0800 (PST)
Received: from localhost (p200300cbc7461b00fd9ec26cc5521de7.dip0.t-ipconnect.de. [2003:cb:c746:1b00:fd9e:c26c:c552:1de7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385e4a54b71sm9361779f8f.79.2024.12.03.01.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 01:47:45 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Zi Yan <ziy@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH RESEND v2 4/6] mm/page_alloc: sort out the alloc_contig_range() gfp flags mess
Date: Tue,  3 Dec 2024 10:47:30 +0100
Message-ID: <20241203094732.200195-5-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203094732.200195-1-david@redhat.com>
References: <20241203094732.200195-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's all a bit complicated for alloc_contig_range(). For example, we don't
support many flags, so let's start bailing out on unsupported
ones -- ignoring the placement hints, as we are already given the range
to allocate.

While we currently set cc.gfp_mask, in __alloc_contig_migrate_range() we
simply create yet another GFP mask whereby we ignore the reclaim flags
specify by the caller. That looks very inconsistent.

Let's clean it up, constructing the gfp flags used for
compaction/migration exactly once. Update the documentation of the
gfp_mask parameter for alloc_contig_range() and alloc_contig_pages().

Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ce7589a4ec01..54594cc4f650 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6294,7 +6294,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 	int ret = 0;
 	struct migration_target_control mtc = {
 		.nid = zone_to_nid(cc->zone),
-		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+		.gfp_mask = cc->gfp_mask,
 		.reason = MR_CONTIG_RANGE,
 	};
 	struct page *page;
@@ -6390,6 +6390,39 @@ static void split_free_pages(struct list_head *list)
 	}
 }
 
+static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
+{
+	const gfp_t reclaim_mask = __GFP_IO | __GFP_FS | __GFP_RECLAIM;
+	const gfp_t action_mask = __GFP_COMP | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
+	const gfp_t cc_action_mask = __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
+
+	/*
+	 * We are given the range to allocate; node, mobility and placement
+	 * hints are irrelevant at this point. We'll simply ignore them.
+	 */
+	gfp_mask &= ~(GFP_ZONEMASK | __GFP_RECLAIMABLE | __GFP_WRITE |
+		      __GFP_HARDWALL | __GFP_THISNODE | __GFP_MOVABLE);
+
+	/*
+	 * We only support most reclaim flags (but not NOFAIL/NORETRY), and
+	 * selected action flags.
+	 */
+	if (gfp_mask & ~(reclaim_mask | action_mask))
+		return -EINVAL;
+
+	/*
+	 * Flags to control page compaction/migration/reclaim, to free up our
+	 * page range. Migratable pages are movable, __GFP_MOVABLE is implied
+	 * for them.
+	 *
+	 * Traditionally we always had __GFP_HARDWALL|__GFP_RETRY_MAYFAIL set,
+	 * keep doing that to not degrade callers.
+	 */
+	*gfp_cc_mask = (gfp_mask & (reclaim_mask | cc_action_mask)) |
+			__GFP_HARDWALL | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
+	return 0;
+}
+
 /**
  * alloc_contig_range() -- tries to allocate given range of pages
  * @start:	start PFN to allocate
@@ -6398,7 +6431,9 @@ static void split_free_pages(struct list_head *list)
  *			#MIGRATE_MOVABLE or #MIGRATE_CMA).  All pageblocks
  *			in range must have the same migratetype and it must
  *			be either of the two.
- * @gfp_mask:	GFP mask to use during compaction
+ * @gfp_mask:	GFP mask. Node/zone/placement hints are ignored; only some
+ *		action and reclaim modifiers are supported. Reclaim modifiers
+ *		control allocation behavior during compaction/migration/reclaim.
  *
  * The PFN range does not have to be pageblock aligned. The PFN range must
  * belong to a single zone.
@@ -6424,11 +6459,14 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 		.mode = MIGRATE_SYNC,
 		.ignore_skip_hint = true,
 		.no_set_skip_hint = true,
-		.gfp_mask = current_gfp_context(gfp_mask),
 		.alloc_contig = true,
 	};
 	INIT_LIST_HEAD(&cc.migratepages);
 
+	gfp_mask = current_gfp_context(gfp_mask);
+	if (__alloc_contig_verify_gfp_mask(gfp_mask, (gfp_t *)&cc.gfp_mask))
+		return -EINVAL;
+
 	/*
 	 * What we do here is we mark all pageblocks in range as
 	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
@@ -6571,7 +6609,9 @@ static bool zone_spans_last_pfn(const struct zone *zone,
 /**
  * alloc_contig_pages() -- tries to find and allocate contiguous range of pages
  * @nr_pages:	Number of contiguous pages to allocate
- * @gfp_mask:	GFP mask to limit search and used during compaction
+ * @gfp_mask:	GFP mask. Node/zone/placement hints limit the search; only some
+ *		action and reclaim modifiers are supported. Reclaim modifiers
+ *		control allocation behavior during compaction/migration/reclaim.
  * @nid:	Target node
  * @nodemask:	Mask for other possible nodes
  *
-- 
2.47.1


