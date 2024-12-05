Return-Path: <linux-kernel+bounces-432781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E0E9E5042
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209E518821D9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DD21D0E26;
	Thu,  5 Dec 2024 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpEfni1c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592F21C2323
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388750; cv=none; b=rZ+v4XfoYRmKwnERx5i6xrbcDm3zpzuxpapeiI9fN/3QM5pxODwJ9C7io8Et3NYZVvYfdcqjxPYaaNwMQR4nJ8Djiq8C0VaWOGDnzYxs+F/tXmAItEDJmxmzNNMBDoODByY/C39YAFjUi1amfkDKqF0+qxzvGZcuvBBF8oItgEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388750; c=relaxed/simple;
	bh=g62pkvCUBWzMNtuIunTVP3PllBdhURw+gpEUkoF6f0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rw6FDJtTlW74BxiMZzYooTz64yTkIMDm02GoJ61mIRO4nGkU5rWotQLapYdmpMpVx+bOmOR8u2aUHoN57c1c2eiZZ8GipK2gQru/KOa5B0sCG1tFYStxoCo0hY1hjfPm7VK8qxIjWm/vJJA+/wRMv1TMiGxlxg/+x/JbxOQpxbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpEfni1c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733388745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0SHiuhau4MQj9NvLl55cWuaRJpWQzDVP/XF/moI9fhs=;
	b=gpEfni1cdSuXztmJbymxT2SYkUw8s/lnvWBCAF5XCZnlSyCZmY1p0mVR345lkEdIrf/ImY
	tc33hfJYUf7nAj+6I2CaFarS9td+zGGOFLuU/uOpsnW+TRVTvew9ojb9iP69J8CGNgNWGL
	Vl4WAQCis2k6GboiPKE2a0uAkrqzofE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-4xB9CSX2Oz6TQYDG2slVfw-1; Thu,
 05 Dec 2024 03:52:24 -0500
X-MC-Unique: 4xB9CSX2Oz6TQYDG2slVfw-1
X-Mimecast-MFC-AGG-ID: 4xB9CSX2Oz6TQYDG2slVfw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84B4F1956048;
	Thu,  5 Dec 2024 08:52:22 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.64.94])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 53AAC1956052;
	Thu,  5 Dec 2024 08:52:19 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Oscar Salvador <osalvador@suse.de>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v1 0/2] mm: don't use __GFP_HARDWALL when migrating remote pages
Date: Thu,  5 Dec 2024 09:52:15 +0100
Message-ID: <20241205085217.2086353-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Sending this via the RH SMTP first, because IT doesn't see any obvious
problems why the mails shouldn't be reaching linux-mm, so let's see if
the problems are gone now. If this doesn't work, I'll resend them
using the known-working gmail SMTP. Sorry already for the noise ...

---

__GFP_HARDWALL means that we will be respecting the cpuset of the caller
when allocating a page. However, when we are migrating remote allocations
(pages allocated from other context), the cpuset of the current context
is irrelevant.

For memory offlining + alloc_contig_*(), this is rather obvious. There
might be other such page migration users, let's start with the obvious
ones.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Zi Yan <ziy@nvidia.com>

David Hildenbrand (2):
  mm/page_alloc: don't use __GFP_HARDWALL when migrating pages via
    alloc_contig*()
  mm/memory_hotplug: don't use __GFP_HARDWALL when migrating pages via
    memory offlining

 mm/memory_hotplug.c | 2 +-
 mm/page_alloc.c     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.47.1


