Return-Path: <linux-kernel+bounces-281204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D861494D44C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9EF1C21D89
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DF319D884;
	Fri,  9 Aug 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pwy5jr0F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E9019D07A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219786; cv=none; b=aynlJnUOUy9s+2amdi1Bl0Hb7Yyas4DBmjH2URvMD4Gh+nRCQFl5qX1ne0rrzte4S1TeHxnZo77zNvMy6B8zZF9fAyUEGd5fqiayFwZuE20wTwa+yU4Ymcspp14zxnYJ3XYQgoD8hZRP4wmb+nnZWfQU9pJAINHZ6IBmIk3ZdNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219786; c=relaxed/simple;
	bh=cEBXN2JPB5h1OhPiVAJoVLWyvN7G/G3nl780c90YYQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kc3gA+srep9hOAke50W9eQfGFZ/lPqgo1LkKSZENj0CbatY7vEVH/129FQ3upvZnVVBh9ZHn0J3KoM/Ae1akQEXvVdJ1AXfu268J2TJuvPE9LwJFngm6HzVaE6tTIo5nIMAQmX5tC1JkhAehtIyERTFb/n1QNrrpDLQ4QCWMK6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pwy5jr0F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723219784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHUdq0ZI2fvSzmSbu56kn/TFI4mY4GVPslnR6ZzQETQ=;
	b=Pwy5jr0FWp9f9lKMhTPNW66YCIQpcq7yB16eGBtHYi0Yz1mpYI/WG1e7dtaZC8N/Ik1H3B
	A9R6jrD2AmYijGzdH3kk5y9Ue3DZzoMj7kWtQRQkET0Ag4kfZRosAeixyTWusG0h16eNlH
	Qu2Ls129nThiUeO0Slrj93TkAn/BbfU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-kXcikbWxNe6zokwn0c0b-Q-1; Fri, 09 Aug 2024 12:09:43 -0400
X-MC-Unique: kXcikbWxNe6zokwn0c0b-Q-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b79c5c972eso2605466d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723219783; x=1723824583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHUdq0ZI2fvSzmSbu56kn/TFI4mY4GVPslnR6ZzQETQ=;
        b=wSZVfotLjvyl1R0c9c3dUfwFQclO3GYbbvYcxKyvJ+vjK114sutcZ32ce1YSrFF9Dw
         T9QT7QyEZmYJE4k5ID3KjRmcOHL07549KVDR7c7pAJB3VcmvHnURQN0YoqLTsCL9KqoL
         i3S4aGOtFF3U/iOiNNSFpEBMbJ6N4QXaafcGMjjLQHoexqiOuIj4nAW7m7P+WCrbrTJF
         Up7VJQB7lWCz1tSTQHIfMyiDhVXy4Mw2HbXxOoKKmm4JIYw/udbc12obWs87vFGLNZxY
         9j7IxNhvCyah7kk6Lkhhg1/mq3srqybKYlWC6SNI69FZxfJlvA/IKknUWDo+rpf3QPt0
         MyKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUKuKkI5pQM0BsGLXRrVS90YbYZCcKymsbGq1PNQiDhnjbVdk4DId413Fz3gRVR807bPmZFfDa3m9S3ZiTaJBeHZ7VYobgIme0mqg1
X-Gm-Message-State: AOJu0YwXL1doIxqhMBsqCU2husM/TBZat2BPVQL/tlpyoCLRCEvz+Vx5
	MyC2CQD31tx69e3xtKA3j9Mi9dgCt5VJ/RCyzFHwfqyI7wYuHI0oXPPMsYz0eCRuKa9Ex/lqga0
	nglwMkMqoXZ+SeqGQNH7c1WNvf/mHG6i2o1FL4VEuN6wZG1KSGk9YzACCddh1nw==
X-Received: by 2002:a05:620a:460d:b0:7a3:5e3f:cbf4 with SMTP id af79cd13be357-7a4c18467b6mr127414785a.8.1723219782734;
        Fri, 09 Aug 2024 09:09:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqMMArTR19FgmAq+7tz35tycS6tSaD4MMjthIpuW8WNcff+L3Yj5M2c5Huoz5dZxDipeszqw==
X-Received: by 2002:a05:620a:460d:b0:7a3:5e3f:cbf4 with SMTP id af79cd13be357-7a4c18467b6mr127412385a.8.1723219782335;
        Fri, 09 Aug 2024 09:09:42 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c870016csm22526741cf.19.2024.08.09.09.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:09:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	peterx@redhat.com,
	Will Deacon <will@kernel.org>,
	Gavin Shan <gshan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH 12/19] mm/x86/pat: Use the new follow_pfnmap API
Date: Fri,  9 Aug 2024 12:09:02 -0400
Message-ID: <20240809160909.1023470-13-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240809160909.1023470-1-peterx@redhat.com>
References: <20240809160909.1023470-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new API that can understand huge pfn mappings.

Cc: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/mm/pat/memtype.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index bdc2a240c2aa..fd210b362a04 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -951,23 +951,20 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 static int follow_phys(struct vm_area_struct *vma, unsigned long *prot,
 		resource_size_t *phys)
 {
-	pte_t *ptep, pte;
-	spinlock_t *ptl;
+	struct follow_pfnmap_args args = { .vma = vma, .address = vma->vm_start };
 
-	if (follow_pte(vma, vma->vm_start, &ptep, &ptl))
+	if (follow_pfnmap_start(&args))
 		return -EINVAL;
 
-	pte = ptep_get(ptep);
-
 	/* Never return PFNs of anon folios in COW mappings. */
-	if (vm_normal_folio(vma, vma->vm_start, pte)) {
-		pte_unmap_unlock(ptep, ptl);
+	if (!args.special) {
+		follow_pfnmap_end(&args);
 		return -EINVAL;
 	}
 
-	*prot = pgprot_val(pte_pgprot(pte));
-	*phys = (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
-	pte_unmap_unlock(ptep, ptl);
+	*prot = pgprot_val(args.pgprot);
+	*phys = (resource_size_t)args.pfn << PAGE_SHIFT;
+	follow_pfnmap_end(&args);
 	return 0;
 }
 
-- 
2.45.0


