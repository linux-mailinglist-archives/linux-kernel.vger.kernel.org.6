Return-Path: <linux-kernel+bounces-278466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D392B94B09B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B841C2136C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2573E145359;
	Wed,  7 Aug 2024 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVpcwFW1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF941448FF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060102; cv=none; b=IeO69GHuZ/EiLxYaimMTmluzUCCmTiAREZkGcpw/3RErZGHUqX08AbQbg77d7a45a7lRkMmuAAxwCEzqxg304EFgIKKqdcx1bAg2f0EwEZziSI7AKLdqI6ceamnPyVVJtDuShF+P2vqr2WZVrCOhj63Pv5qLN5yXL/P9tiwckvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060102; c=relaxed/simple;
	bh=XL7oTSSTB/8YDtl+/bwPSSNlnKCeA31jQyxrFRfpnLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNeq5y0VrB86jOr9xG5MTa+a0IT53ew2PwaFyaiofmR/hQWZMOQ5nwXckQi87T0SKENzbVT6FypoFZ1HbZ/IuMc5WGXtQlEZmJ029KUNCmWFY/G65gfu0FNWLtbhhoAO7KoS1Xe9KBw5BsxHC9Abkif0uQYLq+ddacB00f1LWlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XVpcwFW1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723060099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Kq72BfB1Q9PD26Udwsuz2Gt7rCvKvwunl3vkpU7op8=;
	b=XVpcwFW1S7v+Z2qL7qm9Ot6NiZFICCdE9T1xZUptlXwv1bTZ7errLgfcHnn8FrVyolJs2s
	Z2vYP91jsLadMuJuJl34M4jWTWdDTpNLRQo1nb+DCvXGB5AHauTEIKxsdhLXCE1mIs2CX8
	5kzTkIvc2pQyIJdDgg7jQyNQILmKgvE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-rfhsveJVOXW7rEfvh9HXtg-1; Wed, 07 Aug 2024 15:48:18 -0400
X-MC-Unique: rfhsveJVOXW7rEfvh9HXtg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b95c005dbcso498486d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723060098; x=1723664898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Kq72BfB1Q9PD26Udwsuz2Gt7rCvKvwunl3vkpU7op8=;
        b=lppUPqLS9cudKwKApeN1sCQMQ97n1GcW/NOe87Ju/a6oxjG18wHECUR4Us3iXI2L1W
         pKZa3LZNO4afibOcn6p/XUidknILK7XBJ1lr89sjvt+MZ91/90sELfRI59VVGVip8i40
         Z1slDuHO0/GvFuYMhcVM7SCey2hXhHOV2B6cpNxyMJYVuMvsK2S13Ewct3miuDe3neP7
         YYSaNeTcxFCIBg5lnI9ytrPh0shh2T1UUmRSyMZyYhTlLhgpi8CAFwwe8ZZfBAFxdt6Z
         I1mjhMW9ZWVJvWP2UmB/PFzldGJM02AZIIg7pQ4sH8TAGhSgwMXI74oOh35AokgdUzE0
         AaKg==
X-Gm-Message-State: AOJu0YwO7lSdAzb9GWLOlbpS+F03lVBSoXYyhEl2VSut1HSf/prc1Zf0
	PqxZXf+thmYM9F5O3Fx0qsTxMUGW9Oj7aJzFeva8GHTtvjIUx6Cuoiflhs4C3suQgCCLYlqgi4H
	Yma7I/hd1UdNGkwPpJBfocRhS6Mw3D+L+heEjWNDWoleZgdDX+Iu2CDk7ygtvzR179xqc9LgpLR
	jriT4jogzmPGADqglIDmK2feipfCxUxTKxJ86T1cNlZPc=
X-Received: by 2002:ad4:5f89:0:b0:6b2:b5b5:124e with SMTP id 6a1803df08f44-6bb98201fe5mr130641606d6.0.1723060097570;
        Wed, 07 Aug 2024 12:48:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2kwiMDYWwjAOmnvJrXFpiL3DqhuBYXy1c4XYYU13it34Yz8NGLRxRmyIIbMBrd7nnJuhzgA==
X-Received: by 2002:ad4:5f89:0:b0:6b2:b5b5:124e with SMTP id 6a1803df08f44-6bb98201fe5mr130641186d6.0.1723060096990;
        Wed, 07 Aug 2024 12:48:16 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c78ae4asm59853256d6.33.2024.08.07.12.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:48:16 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Oscar Salvador <osalvador@suse.de>,
	Dan Williams <dan.j.williams@intel.com>,
	James Houghton <jthoughton@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Rik van Riel <riel@surriel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	peterx@redhat.com,
	linuxppc-dev@lists.ozlabs.org,
	Mel Gorman <mgorman@techsingularity.net>,
	Hugh Dickins <hughd@google.com>,
	Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>
Subject: [PATCH v4 1/7] mm/dax: Dump start address in fault handler
Date: Wed,  7 Aug 2024 15:48:05 -0400
Message-ID: <20240807194812.819412-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240807194812.819412-1-peterx@redhat.com>
References: <20240807194812.819412-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the dax fault handler dumps the vma range when dynamic debugging
enabled.  That's mostly not useful.  Dump the (aligned) address instead
with the order info.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/dax/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 2051e4f73c8a..9c1a729cd77e 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -235,9 +235,9 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf, unsigned int order)
 	int id;
 	struct dev_dax *dev_dax = filp->private_data;
 
-	dev_dbg(&dev_dax->dev, "%s: %s (%#lx - %#lx) order:%d\n", current->comm,
-			(vmf->flags & FAULT_FLAG_WRITE) ? "write" : "read",
-			vmf->vma->vm_start, vmf->vma->vm_end, order);
+	dev_dbg(&dev_dax->dev, "%s: op=%s addr=%#lx order=%d\n", current->comm,
+		(vmf->flags & FAULT_FLAG_WRITE) ? "write" : "read",
+		vmf->address & ~((1UL << (order + PAGE_SHIFT)) - 1), order);
 
 	id = dax_read_lock();
 	if (order == 0)
-- 
2.45.0


