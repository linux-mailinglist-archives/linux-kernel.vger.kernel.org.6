Return-Path: <linux-kernel+bounces-281202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A066494D447
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54F61C216E1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB05B19CD08;
	Fri,  9 Aug 2024 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIqRy2EI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84DF19B5BB
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219782; cv=none; b=KMeIlVjvslhx3BywLTCKqn5vWi44qBbBp+T79sC1nTDUTMD3O8z4itRAdq/TI7csumdseq2QfD3HvaQ+DSIytl7A8Io1WyEnk7ZPOlpXCJXq0eI3eC3usm4PrwMqTRplTkxFtfTuw+XC080hEKNZ8XGOgrxjYyjlhOzYRXOjK+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219782; c=relaxed/simple;
	bh=KfYE5tIQA4wIRG7So5bdir7+S/1uf3KsBeoybnD12MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okGw8q/Cj5OPGcCx7WTb2+QfGm8hVpeuA7QPV3b8HhOXcYSUEDbfD6SyUycodaA0qfdojfn5dsOi0l7GpMC1iiBQNO3pDSK8/PjhfJstUWgR2TXar4bG33lg0sZZ/Z9MMcWVNhVcdB1tql5p4d9fZUsgkzs9hQuI2WIa1sMubHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIqRy2EI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723219779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XgMG3z25w/FU4W74BEAmfGyy8QhkBSj3TNUPa/vYriM=;
	b=TIqRy2EImh13LF9Tik9GZH3xJzc1lPS+wiNM7dsnnExr1qw4HQ6mDxtiioK56kckDg87My
	JQU8Voh1rQqf8zBJujTop2z8tRY6e9olbz2RJAHT8oVmXRyB/n8H0AnaPF5Wf5nXfDJX/f
	h0sRaPjy+qnqCOMCr4C597+u+UhDZKg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-Zo-85lzRMh6B9-EeD9lNHQ-1; Fri, 09 Aug 2024 12:09:38 -0400
X-MC-Unique: Zo-85lzRMh6B9-EeD9lNHQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a1dd7e9a72so5254685a.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723219778; x=1723824578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgMG3z25w/FU4W74BEAmfGyy8QhkBSj3TNUPa/vYriM=;
        b=siRjja8YJVmwTllXIOF4Kz7fxf6nFOucNhK9Ko44seJGYeUV4ZZosTCKIbNWj3SsMG
         JOPVlcZ5Eh+soSt9U1bPcA3WxIuNfu+ny/+hiL/T6RBJVWajSFZp+/+AYPiRRexOz77V
         EkFgv0Nwzs2gCb5zGQtURbHXc763NM1qWcbOgR36jUkFzgpZ0/4c2TPcNlcklVU+Znv7
         2nDSkMBnOCyuPYmX9sJpbJKLuxuihelCqTifwTySdNxcD5YPLbCWu4d7xTgrqtydjt+2
         MxRGWL1PnceC4KCsZOCvBjDgTzx1DYUlTYnQ1YecqeO7glCwtDREArs/FZ3MRr5+u/R8
         on8A==
X-Forwarded-Encrypted: i=1; AJvYcCUxJneLoP+hw9IGKCIjpprnbet5eOSfm4L5p4zEJaHh3Ja6GX6Rv6hP/Jl4KV6Gx34bE/lU7QCM16iCgStmJ08t5OOIZtRFYyBK4q7D
X-Gm-Message-State: AOJu0Yy7cap8VbvpV0Wr+4QQ8S+OaFuYCblNru6WRNqhSBTPE9qGFIvm
	lkXTtC/0Kul3YxtYcwBJ8VxW7IjCMvgAPvrOtgqmWEEZeEe4dR87MKtC9z2o60QmFeCQdc/8K2/
	xs7GolB8kmiIylBrJVNOcnJsj28go2mpgbTKVG938Xk4ip0dqvnnG164MLpadWg==
X-Received: by 2002:ac8:5dd3:0:b0:447:dfa0:283e with SMTP id d75a77b69052e-4531251fe34mr11225471cf.1.1723219777985;
        Fri, 09 Aug 2024 09:09:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6MoN+Dd8Hdt5Y2cXuQIqSY6AztxI8VpmGorOFfK4YC2KlFlbKhz5m1DVHT1NSvONycoblfw==
X-Received: by 2002:ac8:5dd3:0:b0:447:dfa0:283e with SMTP id d75a77b69052e-4531251fe34mr11225161cf.1.1723219777518;
        Fri, 09 Aug 2024 09:09:37 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c870016csm22526741cf.19.2024.08.09.09.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:09:36 -0700 (PDT)
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
Subject: [PATCH 10/19] KVM: Use follow_pfnmap API
Date: Fri,  9 Aug 2024 12:09:00 -0400
Message-ID: <20240809160909.1023470-11-peterx@redhat.com>
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

Use the new pfnmap API to allow huge MMIO mappings for VMs.  The rest work
is done perfectly on the other side (host_pfn_mapping_level()).

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 virt/kvm/kvm_main.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d0788d0a72cc..9fb1c527a8e1 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2862,13 +2862,11 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 			       unsigned long addr, bool write_fault,
 			       bool *writable, kvm_pfn_t *p_pfn)
 {
+	struct follow_pfnmap_args args = { .vma = vma, .address = addr };
 	kvm_pfn_t pfn;
-	pte_t *ptep;
-	pte_t pte;
-	spinlock_t *ptl;
 	int r;
 
-	r = follow_pte(vma, addr, &ptep, &ptl);
+	r = follow_pfnmap_start(&args);
 	if (r) {
 		/*
 		 * get_user_pages fails for VM_IO and VM_PFNMAP vmas and does
@@ -2883,21 +2881,19 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 		if (r)
 			return r;
 
-		r = follow_pte(vma, addr, &ptep, &ptl);
+		r = follow_pfnmap_start(&args);
 		if (r)
 			return r;
 	}
 
-	pte = ptep_get(ptep);
-
-	if (write_fault && !pte_write(pte)) {
+	if (write_fault && !args.writable) {
 		pfn = KVM_PFN_ERR_RO_FAULT;
 		goto out;
 	}
 
 	if (writable)
-		*writable = pte_write(pte);
-	pfn = pte_pfn(pte);
+		*writable = args.writable;
+	pfn = args.pfn;
 
 	/*
 	 * Get a reference here because callers of *hva_to_pfn* and
@@ -2918,9 +2914,8 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 	 */
 	if (!kvm_try_get_pfn(pfn))
 		r = -EFAULT;
-
 out:
-	pte_unmap_unlock(ptep, ptl);
+	follow_pfnmap_end(&args);
 	*p_pfn = pfn;
 
 	return r;
-- 
2.45.0


