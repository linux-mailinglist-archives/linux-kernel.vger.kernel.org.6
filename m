Return-Path: <linux-kernel+bounces-240204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6E7926A3E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF79283D30
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A133194132;
	Wed,  3 Jul 2024 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1/HG1qd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A699191F9B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042169; cv=none; b=hvnewl64KrhumDmLBLKzWAd1vyF3+qhF+gc/NdGaS8CsWSTwoMJYEmoT0ifMaTZXKEki+cT6TwEk2doe3E3v4Fvc5LH1YQr4MMGaajDGv3ZVYzdfZd09xg25ky2QD+5fMBdMAOqqnqiedCz7fO4bR166/bDFQ3QyeVToBKRNxFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042169; c=relaxed/simple;
	bh=B0IpMvJzke/973HZPlLZKBuCQcswwxmVEGuJbnrmXVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dn2s9bLP7/oA3lN7rUr7xrJuGrYDy5/Ie9OI1Q7wKhu/+hX63ROiXoOIoUdcmlDq8LUdgvo67Bv1CSTaWCeelhcxf4XX7/ZrxrE5Qo2vZS/hI+nJhvE9yfkjPeUzv0o8dM+wQ1QvlxQnUlcnjGq8Zdnx+bf7jK5vBFO3PtaQ5Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1/HG1qd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720042166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xrFUBbcc9D0ORnx0qoNz81Y3Ewmb+xGo+hBykZs/BiM=;
	b=D1/HG1qdiZtGn30l8WJ65cSSZwTBAJrTPkbj1sJL5yGtz9sR02Zb0K8CrcQqys4P0mDx8N
	sPJKOZy2qMGewGkIPKxklLizLsu/0m6bRj2y5zr3fo4+DKQIySE75bG6U2PyAu90nyshUB
	Sz8svhkAapMItK7ciP1MGixxFaUNgb8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-vE8YFquDPL6UlTiv0VUJ-w-1; Wed, 03 Jul 2024 17:29:25 -0400
X-MC-Unique: vE8YFquDPL6UlTiv0VUJ-w-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-44671e02749so3589341cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 14:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042164; x=1720646964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrFUBbcc9D0ORnx0qoNz81Y3Ewmb+xGo+hBykZs/BiM=;
        b=tEcv4k+6x3NbBAATHaNMKWZwepsKNlNqTe21uifS2Y+kzZZbAuTIAR/JD/CVZBW2KD
         LqiSsp1wcDuuHB1UuzLxulLiEZC9lpgt5jJYgEao2+OueWROcBsoKFRDwtodZeuW5SLs
         UxnZmzU4CnGMQBikh9OpU0WO2QriyAoX6b2rSOPQchPPAzuaIMyKdxVB+mRiTgfoJ2Wo
         kL+G4iNk2jQJh4IWlkiEuR6ecBEGTf7Q0J6dXS5CBwlhVfM+DsrjxA02Lc+SfPY8EEWM
         4KI1XDrXOanJtHqsQMG/QHTYkZ3BwrZ6jU3TF4d1GL6SRSkOxHQeCAn/edFyXow8/HH/
         ILIg==
X-Gm-Message-State: AOJu0Yw+0ht1SYr1Z8nKE1dxSIX1LZVCQ4VbAJWjOpQaoPXw8AK5WcfG
	pxXLDom6jMfmfmiKfVlMpVvomawJj3BgMln0O2laUp0nP9pOEiPnh+F0gXg2Dnr03CHqCSbrOIk
	sagyl1nmzWft4tHhwRx72QRXq0OTaZIDDy2AIcbtg0+pEMkABpp/u9WMi4pXClPvLC2sp+Y0JlO
	wxc6hBVVgccwYRd8SX+9+bHI8kDB3ePVNBoxxY7j5VPw0=
X-Received: by 2002:a05:622a:20f:b0:446:395a:37c9 with SMTP id d75a77b69052e-44662e3a591mr137075871cf.4.1720042163979;
        Wed, 03 Jul 2024 14:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMTQtKzW3HcLgwCHDxSHbcORdQ9cM6uS4LGBZ0J8HIBqay3DdOq6gf2nTNP/Qtw7gCSEI+OA==
X-Received: by 2002:a05:622a:20f:b0:446:395a:37c9 with SMTP id d75a77b69052e-44662e3a591mr137075451cf.4.1720042163442;
        Wed, 03 Jul 2024 14:29:23 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465143eb1csm54337481cf.57.2024.07.03.14.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:29:22 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Dave Jiang <dave.jiang@intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Rik van Riel <riel@surriel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Dan Williams <dan.j.williams@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	peterx@redhat.com,
	Hugh Dickins <hughd@google.com>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v2 1/8] mm/dax: Dump start address in fault handler
Date: Wed,  3 Jul 2024 17:29:11 -0400
Message-ID: <20240703212918.2417843-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240703212918.2417843-1-peterx@redhat.com>
References: <20240703212918.2417843-1-peterx@redhat.com>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/dax/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index eb61598247a9..714174844ca5 100644
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


