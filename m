Return-Path: <linux-kernel+bounces-283561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDAC94F661
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0EC1C211DF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237AE18B480;
	Mon, 12 Aug 2024 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2COUIBU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB96189913
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486356; cv=none; b=QZ0MG15nYs0B0hADvHgxa0Q35iN3vSEQTy/TwPV3ll7/UCGKtIZZ3sun6/0/PRkUP0hU+iQkJ6g9F/zKA2Fj1zhNOfqbv9P6uBFzXbugvzYb7u1q5/5kcBida7/GzO/yLzmFdNzUeYYu05r7yEbHG2TFJCfkYIHLnHi9yYSazt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486356; c=relaxed/simple;
	bh=XL7oTSSTB/8YDtl+/bwPSSNlnKCeA31jQyxrFRfpnLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJHLLvvewbzEA3zIrYB2SCObmDEto1ic/nFldCGcPtiglzPvo9/UTAuCrlyGgV1r2YhKRJ6wTiqJKFNwpIP2VsYbq18S0vNw1uKW69uFuD6rAxRiDz02JzOgabzKypXq91NrvZteVdz+JWN7Zv9L8lcz6uaMxEGX+qZR+930SWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2COUIBU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723486353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Kq72BfB1Q9PD26Udwsuz2Gt7rCvKvwunl3vkpU7op8=;
	b=E2COUIBUrbYAlsFtjFi/ON/hA+WZdjwU9ziHl2Ev5A1+Xmmku2GcxruedYEQfrMQEWvu9l
	JLy4Ku9Wua6PbmI4nR5GxG47L+rSHUrlSkCS7Igf4uY+WaiuG0dRsSrYl+z4ExqEvk+Mqr
	Sp1QLy1w942MPoVd6eCfYopdhtkzcmw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-3AQrEc2mNLKlMAYw0isJHw-1; Mon, 12 Aug 2024 14:12:32 -0400
X-MC-Unique: 3AQrEc2mNLKlMAYw0isJHw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6ba92dd246fso10368636d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486351; x=1724091151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Kq72BfB1Q9PD26Udwsuz2Gt7rCvKvwunl3vkpU7op8=;
        b=QHnOa4hc5qzz6ND51nXGUUALWYU9PxJnrlFEKRX8PPga4km4aKsYUfG1RhEyg8OG2o
         eSubvyc4ngNDEWKJlgoxaaQkIc/LzzrDIxBOtvof9XfZY0uFjjyBzwkn8R5sksf3YpJD
         Q6jm0LycenRT/dCVvkKk3cf0qkRNeWcw1LP8kH4j3v/rA903kSSIy1xcYkZjBPRjWZf1
         e4LZEEspBHU4SbxHqRSVMmKHlMIsSnHtECG7C3q955aeYhsL5Jf5NZaNlGbrWJTYi/Ut
         6/thmH7AP39k6x655h9kViMum9vdUi6uaFQyrghIXNHazlO/UetIUnYivV4UmrnSX/Gu
         W+jA==
X-Gm-Message-State: AOJu0YzYWz3ctyv9ppWhtK56CQhBPsyuk0ZTBE+TaAfWYAWQxQYL2COs
	zO6QTyJvMrAn/AebEO3MnsTfiZ3CpLAsHY/Oh4gHuE/yVl3lAzDFs7TjhwZfJF4BDwXb5LQwbjq
	U5q4aWHOPKuZAVwvT+Zc65uhWIKPIPA3hgUGWEXrJsr7qncFpG5yubWwjW2Q3o4+u7L3V96yWXZ
	i+s3qTzFCCRQF0WK8pm0fq6QRW/8yCYQRqw/QaPDZT2MY=
X-Received: by 2002:a05:620a:4005:b0:7a3:49e2:d5 with SMTP id af79cd13be357-7a4e15b7f45mr75249885a.5.1723486351202;
        Mon, 12 Aug 2024 11:12:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGINV1er94KHea7itgcrlskkFbFJC5xxX91ZMY2mT7mbgIaqz9jLoR0x5JTp0pkA3b+65JpVA==
X-Received: by 2002:a05:620a:4005:b0:7a3:49e2:d5 with SMTP id af79cd13be357-7a4e15b7f45mr75245485a.5.1723486350655;
        Mon, 12 Aug 2024 11:12:30 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7dee013sm268663985a.84.2024.08.12.11.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 11:12:30 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Kirill A . Shutemov" <kirill@shutemov.name>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Huang Ying <ying.huang@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	peterx@redhat.com,
	Vlastimil Babka <vbabka@suse.cz>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rik van Riel <riel@surriel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 1/7] mm/dax: Dump start address in fault handler
Date: Mon, 12 Aug 2024 14:12:19 -0400
Message-ID: <20240812181225.1360970-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240812181225.1360970-1-peterx@redhat.com>
References: <20240812181225.1360970-1-peterx@redhat.com>
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


