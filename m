Return-Path: <linux-kernel+bounces-283564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2546794F668
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B1C1C21AEF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FC71917CE;
	Mon, 12 Aug 2024 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hjqWdEIw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98C618E032
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486363; cv=none; b=Mo8c5NsO++MiylIUcIwyjIco0IihwEnKI2nn22MfrTa8SgT1GPfpoOgWThbHZN4y1TNdSVf9u8FMz2Q9FIHn9VxkbSB7+19BU2G1eiIiLxhh4YHDn36oo/420TJ906sYB6pbuwnKlHRpqRwxl/kY9eJj+5ziGpvTSrRJ/L58apY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486363; c=relaxed/simple;
	bh=eVlNM3RWSSKYGV6tJtfXOIxVdytT5Dtgp/zet5o+aYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcqAKfIFB2nLRgj4HDoku4M1rBDW3E7EGWHZUrpXg0mUi/VLoyFtcg+ZQu+o3VjpMNvvTwRAbs9YmwjvG3VjznnVQgIZEvsXx6N+5rN5ZbQKnPCXD4XvTcWqaOYM47YJ0DLfCFcuV4Ue1sQgIvldkOEzRG/RhCFDbszN1sVynsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hjqWdEIw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723486360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51AsM4wPs8z1MhF0DnEEQJIHR/NiBzvmhfDXZZK2UA8=;
	b=hjqWdEIwtOeHy3+I0WAw2YGaQSp6lv+OQ5wjtuKSKgkHR1zVkp7ygtdVm3z904LFG3lcdo
	/PJihmCTA929zFA8ArfcPep5CtkhAZRwLDVKCM3CIZsNGDlDeP7MRfl2h3LNVWZwJNlp80
	42AJ1ZzuZ+joGeuKPld3fmDvRLnfukc=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-AO90M49PPLqvhLtaJLhrTg-1; Mon, 12 Aug 2024 14:12:39 -0400
X-MC-Unique: AO90M49PPLqvhLtaJLhrTg-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4929d50431bso219676137.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 11:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486358; x=1724091158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51AsM4wPs8z1MhF0DnEEQJIHR/NiBzvmhfDXZZK2UA8=;
        b=A4rMFfh0HX4EXxyqfWL/t1+v2N3AhxFbhVWorfDpf+z0vjbwiNTw7h0HXXxFLXctO4
         gd6kKuBB42ehOBVtRP0FGCsyPI31RDrJTMNo6nawhCbe6jkLiX3BNHD95LH7OEOeIJKK
         9XHD1DzGAjR16BP4OdoRgk9j4LhNn09VJknC1s/Uoh4MkC8ely10fZv3r/smS/gL0m/v
         jCDQA6RA7SI5iopf+ahTJlnY3ZV/JZSW6al/iVGo+B39nvr1UltPi02p56NKPEhpfJ11
         zIGlezH82NItcc8xDq+FC4fp/YJ+ZA7spZzb6l1pDj4a0RpE/AOgHCUpB9wFUOQO/7MO
         slNw==
X-Gm-Message-State: AOJu0YwfHFVUt/+/0qVdbYTr8PMk8PC1jhqipsAyKPqMD2+FmXPqqPYT
	iUFuuuJSxUgHiNLz0OJhTLPoUCY7JNqR9xDlaObOcqGJ2zm0znVuIPUBHN+3Ub/cI5DqCG4sOza
	UNIOsSNWTkFnMehlqTjJ8xHthrJFjoRh1FzKwAIk/k54P6A+2xBe44l/MVeuGOgzO/gJ80Lakdp
	tDtUbt4yMwLFTMlWdDxDiy7XgcLqaPLiyl3jAo/uezxhg=
X-Received: by 2002:a05:6102:3ecb:b0:48f:1db0:e268 with SMTP id ada2fe7eead31-49743b3bcadmr808484137.3.1723486358258;
        Mon, 12 Aug 2024 11:12:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqoB9/0mESDqYSEBNTj9AtHyzcMfWYv34FSY6okF36kkcu051ygwC1i1HRAV7+0kWzcEuDbQ==
X-Received: by 2002:a05:6102:3ecb:b0:48f:1db0:e268 with SMTP id ada2fe7eead31-49743b3bcadmr808432137.3.1723486357628;
        Mon, 12 Aug 2024 11:12:37 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7dee013sm268663985a.84.2024.08.12.11.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 11:12:37 -0700 (PDT)
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
Subject: [PATCH v5 4/7] mm/x86: Make pud_leaf() only care about PSE bit
Date: Mon, 12 Aug 2024 14:12:22 -0400
Message-ID: <20240812181225.1360970-5-peterx@redhat.com>
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

When working on mprotect() on 1G dax entries, I hit an zap bad pud
error when zapping a huge pud that is with PROT_NONE permission.

Here the problem is x86's pud_leaf() requires both PRESENT and PSE bits
set to report a pud entry as a leaf, but that doesn't look right, as
it's not following the pXd_leaf() definition that we stick with so far,
where PROT_NONE entries should be reported as leaves.

To fix it, change x86's pud_leaf() implementation to only check against
PSE bit to report a leaf, irrelevant of whether PRESENT bit is set.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e39311a89bf4..a2a3bd4c1bda 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1078,8 +1078,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 #define pud_leaf pud_leaf
 static inline bool pud_leaf(pud_t pud)
 {
-	return (pud_val(pud) & (_PAGE_PSE | _PAGE_PRESENT)) ==
-		(_PAGE_PSE | _PAGE_PRESENT);
+	return pud_val(pud) & _PAGE_PSE;
 }
 
 static inline int pud_bad(pud_t pud)
-- 
2.45.0


