Return-Path: <linux-kernel+bounces-224850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF10912799
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BCD61F24642
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CDE2231F;
	Fri, 21 Jun 2024 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hztr9O+9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D2208CA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979913; cv=none; b=RfV9AEN4lCXMR9yeVKXQOHn17aBtSn61c6HAPPKplXtp1CQ0PiMpdPLzINndv9kNpMYQR7lJFBto2+kujIbRWqejV+WY2C5D9Ss6fijNyOnDeB2CJ64fb0O0+V1u/bX72nO2KCz+cD1K4pH6vEfeGkMg23F2GES8y9HcBd/ZCOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979913; c=relaxed/simple;
	bh=B0IpMvJzke/973HZPlLZKBuCQcswwxmVEGuJbnrmXVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0roAcPq6Ij56PQ+vt+u4Be+wdfhWshXSnT3JxyXG5AxlQf2SdqDrfEzbkIppj56seuWf941pfNaK+QuHbhsSiC/HqvRxiNoVO4tKPHfcS7QJwBNXbF/3+oGYlVfejDnWQwsEAIS7QL7pJ4rNZsjDNMFw5p271sV0D/uFJ/BUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hztr9O+9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718979911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xrFUBbcc9D0ORnx0qoNz81Y3Ewmb+xGo+hBykZs/BiM=;
	b=hztr9O+9RQjLft0R3OQFTYkSEnXqTJGyf3snN6xN4n/3QIrB9Bz+kM/LP/axzC9pff2teG
	StaDaOhESiKbjq6OyqmnbjBjImQ9Xky+OdUVVVDHpbF88zAL1gv2M2FQqL6Vwc6rQTcM7t
	1nyjHTOIbWeiNwp9x06DLKAkeie5/Tk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-hujXe9HNPFqsONgCzwvAMQ-1; Fri, 21 Jun 2024 10:25:10 -0400
X-MC-Unique: hujXe9HNPFqsONgCzwvAMQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-797cde3c2f8so18599985a.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718979909; x=1719584709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrFUBbcc9D0ORnx0qoNz81Y3Ewmb+xGo+hBykZs/BiM=;
        b=ELLKMvTBEqNx2+xN0CZ3Ig3G+/XtVevbKYPeaeJ12yh1JjgFlwixLspbzQg2Mb9WlM
         xLJfB++Hf8jJM2FfoW9QE/bYV9J5bDd4cjG36Xg99MAMp6F7kNSML8UE1TCrsoRQBvUm
         lBzDyxsauOpx+jCrIttjeHFsehEciOFAu+YZvkI5KDAdTYVBVPiUaJFFnh50UjnSGT12
         Syv6anUzGFW57d/8gk9XzXfpYq0pVABVAtCioPDa9iPqDRjl8P22YjVSiA1DcaShQcv5
         gk9HCylerZFZFIxGtA+H8l9XTUTCxr2ZHaVUwXtmo9Tn/eRyXBCFWqYS4wC4dUr5y0fE
         YysQ==
X-Gm-Message-State: AOJu0Yy+R5dSOgHm1/6zvyDIDajl9Fz06Bh5bWySKU7YnaQc59ZBEsy0
	wW7MPsb1Q/uHR5zvgsUZAs2lYTYeT7mqLXcm2AL8i2QhZPq4Ah6+yPTFyZkzNsqOgAgpe6YT0Cy
	qYL+4H/P75qjGG4k9PVNqY4IuRQUrOURGEM7TV/yqtNQrSNUT/oL9yjzBuREjTs6Jc5NCso6kvp
	RZEwN08EX9rOPw7JghgRuc1MQYySPsGy9pXl6MQf9HPYU=
X-Received: by 2002:a05:620a:1a1f:b0:795:c5a1:cbac with SMTP id af79cd13be357-79bb3ee371bmr869909685a.5.1718979909549;
        Fri, 21 Jun 2024 07:25:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBrJ7N3pmBZU3UlBHH/5YVIoMtOfK+G61+YRt17HXeINLiGOOyCA8EM9L/R3OdwJcsLTRnFw==
X-Received: by 2002:a05:620a:1a1f:b0:795:c5a1:cbac with SMTP id af79cd13be357-79bb3ee371bmr869904185a.5.1718979908847;
        Fri, 21 Jun 2024 07:25:08 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce944cb2sm90564785a.125.2024.06.21.07.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 07:25:08 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Jiang <dave.jiang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Ingo Molnar <mingo@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	peterx@redhat.com,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Huang Ying <ying.huang@intel.com>
Subject: [PATCH 1/7] mm/dax: Dump start address in fault handler
Date: Fri, 21 Jun 2024 10:24:58 -0400
Message-ID: <20240621142504.1940209-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240621142504.1940209-1-peterx@redhat.com>
References: <20240621142504.1940209-1-peterx@redhat.com>
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


