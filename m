Return-Path: <linux-kernel+bounces-263425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154D193D5A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CD48B216D9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E4A17BB25;
	Fri, 26 Jul 2024 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IT9gLPRs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE5B17334E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006497; cv=none; b=g0alFH5XAu+U7By+qTdmN1yos5P+wDKcPbHWvG+Mba25e5PrfclJwtaQ/hzndV/R3UA6xeONvGbeBTPrfy/mWqBI9fM01PD/sIQjBqrpG2kSq6rE3gGz3jO+DhT8bXMt0dkUba6Ja8O/1LtWe/PMxgBP217xOqV0Nq+VjHrBP5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006497; c=relaxed/simple;
	bh=LOfrXGw3pFL0AFHi7Ko+dN4kqf7gwT4HzWn2H79vThs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1Wb2xB/VN0lpIcStUgCoZWeetU7P0b7atNNI5K+aWJKKN9NpvcWR/3TdUx/Vo9nW0s9ufzLHdOaJUbclu4rcIh77+D91leclBxVcRs4LxcFg8LPuj066YnK74UKQUy9L6TYw8oz0LAput/hHHLE4JKcNWQ2euMe4dHDz2O/NaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IT9gLPRs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722006495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h2hZ5iaP0GGncGDVruB29gu4r9/BL7FMsu+FThy8pbQ=;
	b=IT9gLPRsMJ951XIHWdNcKo4gxbq+J0yOGfK8sQI9VRd3fFb1/6EjQeX53897WStOJ1IJ1z
	extsAMNwRPZK1ujzUEDw0EOgcxc3UVrNCbeidS9R1qmq5TH6IEDtSsah/TFzIq4N7TkqwV
	XV+pgMI0UKADRbaQLvA8fceCwt9jxQ8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-HOHS8bHhPF-HxdWbNQ7urA-1; Fri,
 26 Jul 2024 11:08:13 -0400
X-MC-Unique: HOHS8bHhPF-HxdWbNQ7urA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CD891955BF7;
	Fri, 26 Jul 2024 15:08:10 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.153])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB2841955D48;
	Fri, 26 Jul 2024 15:08:00 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Russell King <linux@armlinux.org.uk>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v1 3/3] powerpc/8xx: document and enforce that split PT locks are not used
Date: Fri, 26 Jul 2024 17:07:28 +0200
Message-ID: <20240726150728.3159964-4-david@redhat.com>
In-Reply-To: <20240726150728.3159964-1-david@redhat.com>
References: <20240726150728.3159964-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Right now, we cannot have split PT locks because 8xx does not support
SMP.

But for the sake of documentation *why* 8xx is fine regarding what
we documented in huge_pte_lockptr(), let's just add code to enforce it
at the same time as documenting it.

This should also make everybody who wants to copy from the 8xx approach of
supporting such unusual ways of mapping hugetlb folios aware that it gets
tricky once multiple page tables are involved.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/mm/pgtable.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index ab0656115424f..7316396e452d8 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -297,6 +297,12 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 }
 
 #if defined(CONFIG_PPC_8xx)
+
+#if defined(CONFIG_SPLIT_PTE_PTLOCKS) || defined(CONFIG_SPLIT_PMD_PTLOCKS)
+/* We need the same lock to protect the PMD table and the two PTE tables. */
+#error "8M hugetlb folios are incompatible with split page table locks"
+#endif
+
 static void __set_huge_pte_at(pmd_t *pmd, pte_t *ptep, pte_basic_t val)
 {
 	pte_basic_t *entry = (pte_basic_t *)ptep;
-- 
2.45.2


