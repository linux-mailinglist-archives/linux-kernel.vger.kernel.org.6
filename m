Return-Path: <linux-kernel+bounces-188081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4058CDCE9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E84D1C244A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FD7128826;
	Thu, 23 May 2024 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSIyzsT8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B3F12838A
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716503877; cv=none; b=jNsjH89mViCYV07YI9Tsrgi3KihE029/5qFmI8jtn3N7JDb22EcnmaR/Fe0s0oz6qHcLXc6fX/DmxHGG0oEJB6FdufIxv3kSD9k9IpgpUF+7BuyXqRo2QWD2aVUnOLYImyzFSoLURdAbgUbgmkUy9MuMZzUAK0LFA7Y2hHY13OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716503877; c=relaxed/simple;
	bh=IAoDeqErEbowA433PRO2cf3pYs3R6ar9OHpikfiY1LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWmaV15UWGKqlFzorTGf7VwE6CBCIhyOI8yKNk+3j1zbYs859aIfO8+ZBmrhUzbareMJH6xwkxIy0S5ZITj+8R+tfq3rN0JOdK4fPt7gj0gpY3+Fov7JMY5UxLLE1ea6c2sFIqa5pHCCGzSDv4TyMDr4vCFMwdhK7rVcOZvFxmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSIyzsT8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716503874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8kmpLF+0wb5DY59Z4GvPb8KdcMgneGoHIufiMB6jJ8=;
	b=TSIyzsT8rrQWMtJowea1OMG7lKrV8MUZpiv4xd7V8EVmnE3Hdw7L3Eaai87NmcySnl+Yw/
	ULdVDkKYMJqiDGQbS5sSpxdW3xxy3Rq+C6dnWTFc0lk49iq/+sDtrL6Sqf/KVqn3lBufyR
	Y6AY/H5s8E7Xwgy8we2XclmjgTZ4rhU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-EOqndksYNAGt_CQ4J5IOLQ-1; Thu, 23 May 2024 18:37:52 -0400
X-MC-Unique: EOqndksYNAGt_CQ4J5IOLQ-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5b96a8bb2faso56440eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716503872; x=1717108672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8kmpLF+0wb5DY59Z4GvPb8KdcMgneGoHIufiMB6jJ8=;
        b=fc8ejNcZktfp5ALohnITglqAsVoJg1JI0OftK/wAakQ3ILc2a8bYyhKswGJerWPmHG
         /eWHsuZHP0+JPR7NbSTIBDGnDtvOLju9N4wJsoFxOiZy2coZlr7eNrgHNpOVsuejk90w
         tu4Q2STBNXz3WVE22JBKKNdZx9pOMFT7goIDOQLlQnifEibqIGIt+HFxIWX7DKL8i+Lf
         By/bZ8OShze7iRghwwDzi49FRo8spcWDpBlsjPi5xw3pOHVPMiG557WJ9FOrlJ4vdfhN
         ILYRAWMxymz8PAK57V0fZnlasfFkXYR1x4aeCtYX6htlq/2/QcJVBALAGk84K0MSVEYQ
         GtqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYJNy7q1hEnVymmI7LGiaPlTgbLyszcrM7w9C8OF68oSduNcvB6Uve6lbNJckzGhAKDtNNkXs+hmohYutstlr6a+ReElInBLVM9vAA
X-Gm-Message-State: AOJu0Yx7T732Sx1sOLUzp4a33g+LRhTqB+gQEEbXunZkcwrdEkLKu6/h
	tawd2nJRORJXbWV8l5a2ueseM+XTqIl63aRUMTDzf8jTK854azBQyUTW9SHUA16fi/OzjWbu75V
	hTHJtdHT9ZuTjao/PfEGKKiViIwSL31wn/zodycrTzPZIjWA6QqGLWASuOoRW5w==
X-Received: by 2002:a05:6870:f708:b0:24c:67b8:2cb8 with SMTP id 586e51a60fabf-24ca0d87c0amr711186fac.0.1716503872034;
        Thu, 23 May 2024 15:37:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv6EB8iQs0dh9WTeZd8gUJptLRKFfW4krudfOlO5TrsX7uonwQfj9xz3QTacSLo6+IAfGxJA==
X-Received: by 2002:a05:6870:f708:b0:24c:67b8:2cb8 with SMTP id 586e51a60fabf-24ca0d87c0amr711127fac.0.1716503871277;
        Thu, 23 May 2024 15:37:51 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb18af1d2sm1066701cf.65.2024.05.23.15.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 15:37:50 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	peterx@redhat.com,
	Dan Williams <dan.j.williams@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Rapoport <rppt@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org
Subject: [PATCH RFC 2/2] mm/x86/pat: Do proper PAT bit shift for large mappings
Date: Thu, 23 May 2024 18:37:45 -0400
Message-ID: <20240523223745.395337-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240523223745.395337-1-peterx@redhat.com>
References: <20240523223745.395337-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For large mappings, the pgtable PAT is set on bit 12 (_PAGE_PAT_LARGE)
rather than bit 9 (_PAGE_PAT), while bit 9 is used as PAE hint.  Do proper
shifting when inject large pfn pgtable mappings to make cache mode alright.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: x86@kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 317de2afd371..c4a2356b1a54 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1135,7 +1135,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 		goto out_unlock;
 	}
 
-	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
+	entry = pmd_mkhuge(pfn_t_pmd(pfn, pgprot_4k_2_large(prot)));
 	if (pfn_t_devmap(pfn))
 		entry = pmd_mkdevmap(entry);
 	if (write) {
@@ -1233,7 +1233,7 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 		goto out_unlock;
 	}
 
-	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
+	entry = pud_mkhuge(pfn_t_pud(pfn, pgprot_4k_2_large(prot)));
 	if (pfn_t_devmap(pfn))
 		entry = pud_mkdevmap(entry);
 	if (write) {
-- 
2.45.0


