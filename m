Return-Path: <linux-kernel+bounces-570178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE513A6AD27
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412C68A1414
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD7422577D;
	Thu, 20 Mar 2025 18:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9KMjh8R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C691E8359
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495655; cv=none; b=DdSbY89q6K5Aqbm2HTq1cIuZWSqvuC6Y/2/yxpfnhfesiLvyUmS1ZNt8G4bdkkCznqKwopJyyT2Qg8NG/bj0ASwgD3gf22WHa3in0pUkwxjWKg7w9A4Ct4B22gt9tFDF0Vsj34RN8GFXoJc4EPPxQH/ewaGh5yeUSFPND1hIRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495655; c=relaxed/simple;
	bh=1sUYRElZKjIS/rss6TTPKm153TtFKpC13+ZuB4ekwgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qoydSv1sK9flgzyGuOR/sQSFDTUSBRhfKwYqtgz6Teygg0jUJoXjpn/pueCGVWLFQTtGG4DibGu4StcK8Dn3cpWw7jPHVpFSLjyK8GnD8y51aEQOIrXtkFgBPqpwbsouI1WzZlbr2cwKkr8KpYapC4CRJ5xfUWKhf4PtSH8OJUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9KMjh8R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742495653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yXEpNUNvMJczWLH6F16nUPMt8SelM1hyuMq3p4nEu7Y=;
	b=P9KMjh8R81OonNqTuHXyCr+e6LTQx879tMRfzgM7MmU4Pm+KdkOsQJcOpvxbud2RYFkD9I
	dvpGmS22ex/JQMhuWPol1D3GUroq6/de1PCfTaMDJ6wmTd8lPuRMqYE8TyA1qrvJPcgOjW
	FmlY5sHoLKP4bZMofVJsyIQkhPu/xX8=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-E_NcLjsRNTmjvD93y6OF-Q-1; Thu, 20 Mar 2025 14:34:10 -0400
X-MC-Unique: E_NcLjsRNTmjvD93y6OF-Q-1
X-Mimecast-MFC-AGG-ID: E_NcLjsRNTmjvD93y6OF-Q_1742495649
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d44a3882a0so10704065ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742495649; x=1743100449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXEpNUNvMJczWLH6F16nUPMt8SelM1hyuMq3p4nEu7Y=;
        b=taBE/3Zbs9rLfJkXJIMChvf9pyHvRdR4wrUQ1sxOjEf0N4+Bb/xs9U2h+u1FXH8Qiv
         KcSX1xjhmqQys3d9oXq4JGjhRntl7AdgAA37Y+j2OYDSsbrdOb9fhITJz8qnlvYek8Sp
         Jo7dnZfkPPPVzFdzUr6k3Pn2bkFMdWOsWqT1JkpTQx98/w5AHrNpq/PIMqVuNix+GnI4
         +L0l5YH+pGA7d8T9icNZNM3xE+D9iAKTgNXHppGY5WxOjp6XZqV/AtTsxoihQYOFosZA
         T/5u8lYEkHViDH8YGCdL4KxecqfnmNWoqN+YKaWa1GjUzsNUYuwfVTKk7/Pl7sP7nKn5
         Vlrg==
X-Forwarded-Encrypted: i=1; AJvYcCXgehrHVXotvrAmy7V4xqHDY4WTtDw5BgmsQ04zXRIjHOmk3LMnNZhvBYmxZfnqzLrB7QpDsdYxLxhZOGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQUMf6GMVntonB1R/+l+8kxDOeVvMs/pe2qSeI8wufhisO9+TE
	RLqqoydWtRvwhkAL8lzhoahv8KDQlvlQHVYnMUkob1tNucj5US5ggJtSldp6YC5NXVp9OFrhQyD
	cgYq01myIpRq01mOd3i6oFnl7e46A88JHKCSNDJiIOb2peNhD93A/+ykr7NrdspKKexAGSA==
X-Gm-Gg: ASbGncsij5yVd0dI7A1iGnf/s3btzCKlZQyu4pI8L6FWgCngaUwSkbUJdBDdkwFJPHZ
	3tgxA6EKRK/DdNv3O3hsmyZkC40tDNANhc0uF4Mj0j0r6Oh1nDZnvGvU6wNTKaSoLgSPLQwxko0
	1aafl2PT3oW1YdbEt1EfgSRnsspfoPDupPZ+WUc3iVeuGIiUykBZSK/aoWB/eWeL/38uIuTQ0Ja
	Sc/m7ss39Jy4ame1RuARq6FcLZ0HLVy4GVSg06l78+6ObvM+Myq4DXczwXY6ttr6nhD2lNMWqjk
	50hL
X-Received: by 2002:a05:6e02:1848:b0:3d4:2306:fbb6 with SMTP id e9e14a558f8ab-3d58e8f5525mr53116525ab.10.1742495649175;
        Thu, 20 Mar 2025 11:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqjj87HxkKt58np7yqIa0Leoo/iM8T6oRSnV06QwiZuA50SJhDFlh9/vL8Yy51xEZPNgP+AA==
X-Received: by 2002:a05:6e02:1848:b0:3d4:2306:fbb6 with SMTP id e9e14a558f8ab-3d58e8f5525mr53115925ab.10.1742495648712;
        Thu, 20 Mar 2025 11:34:08 -0700 (PDT)
Received: from x1.com ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdeb818sm44991173.65.2025.03.20.11.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:34:08 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Alex Williamson <alex.williamson@redhat.com>,
	Donald Dutile <ddutile@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] mm/arm64: Drop dead code for pud special bit handling
Date: Thu, 20 Mar 2025 14:34:05 -0400
Message-ID: <20250320183405.12659-1-peterx@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keith Busch observed some incorrect macros defined in arm64 code [1].

It turns out the two lines should never be needed and won't be exposed to
anyone, because aarch64 doesn't select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD,
hence ARCH_SUPPORTS_PUD_PFNMAP is always N.  The only archs that support
THP PUDs so far are x86 and powerpc.

Instead of fixing the lines (with no way to test it..), remove the two
lines that are in reality dead code, to avoid confusing readers.

Fixes tag is attached to reflect where the wrong macros were introduced,
but explicitly not copying stable, because there's no real issue to be
fixed.  So it's only about removing the dead code so far.

[1] https://lore.kernel.org/all/Z9tDjOk-JdV_fCY4@kbusch-mbp.dhcp.thefacebook.com/#t

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Donald Dutile <ddutile@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Fixes: 3e509c9b03f9 ("mm/arm64: support large pfn mappings")
Reported-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/include/asm/pgtable.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0b2a2ad1b9e8..15211f74b035 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -620,11 +620,6 @@ static inline pmd_t pmd_mkspecial(pmd_t pmd)
 #define pud_pfn(pud)		((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT)
 #define pfn_pud(pfn,prot)	__pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
-#ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
-#define pud_special(pte)	pte_special(pud_pte(pud))
-#define pud_mkspecial(pte)	pte_pud(pte_mkspecial(pud_pte(pud)))
-#endif
-
 #define pmd_pgprot pmd_pgprot
 static inline pgprot_t pmd_pgprot(pmd_t pmd)
 {
-- 
2.48.1


