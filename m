Return-Path: <linux-kernel+bounces-252981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 722F2931AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CEDA28508E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6439113BC3A;
	Mon, 15 Jul 2024 19:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPn1g5NK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4913AA5F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071321; cv=none; b=gOhP2sTNL/FPiuVnnONkOjGLmwkgLGJwHYJqtrAuC0jnHzddTKOTHiYrslCmEf5Nc5qiNf0Y1uuaNdnIive9Z5JHSxki51HcxlvSC6Goh4yxpAEtP/4IuvKEgSDg2zjyOh/hNBk3C5D+QKcoqlyB+MWzYcfcavxe6+WtTtTg0xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071321; c=relaxed/simple;
	bh=HvLeVYUQ3g1BzJ0yN4wtIuLe5eY6YeKrJD1Hba3arrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khngBQOFmUdjTfDQRtjEB3rr5k7GYrHS8R4nipuVCaLGWDqkO8KTjR52ZL/jNUwSj96sn43NHc0aZVghwCFrmhB3TING0qXwWh6/XM5nA/TBeWKwL/61swGhOQc3v3sSxyvRSfoXpulDDyLmQTtC6pJhyixSz5UsOc7EWBImGEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PPn1g5NK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721071319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFEuzrgphkpyKgRaMn/StFmQ1IWZKcW4qj9eIjoToHw=;
	b=PPn1g5NKBF6lvrQGMlHOWelZ0uJ/O94Nry5RLzJsxZDYlgLFZmFNUO2wXqe2fTnFIrNmT3
	nVWSAubG2Yzxpf7uAGJJa/DH6qTXN5A/s4MaS9IlogZDcFAZT7t0iOXWam2R/nGUPaMOHl
	WbXtZYp3bV/lXZKsKaGjeDQ1igZ47co=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-9oZnw7d3OIKqNFwAATir1g-1; Mon, 15 Jul 2024 15:21:57 -0400
X-MC-Unique: 9oZnw7d3OIKqNFwAATir1g-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5cea2c45403so518968eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721071317; x=1721676117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFEuzrgphkpyKgRaMn/StFmQ1IWZKcW4qj9eIjoToHw=;
        b=N4K6e84wvAPjB2Z0cbph8bewvvVv9YWH7C54wzDeMtpYHjJ0zWC7sYLuhNi1c8dNqe
         qXnZVsNJifcKC/1gBkB6i4bdX7R317gqTM0u+B7VVHRokTi7yVSlfc9iKvGsToDzkqUU
         3/ytHq2/yRu4QLYLX2rkhFpeDlnpUAiHsRuaJCnE+b7Kt5huwMjaYXBrMPvlfyScIs/y
         mLTib2bTMfw8z2HMw4pdJUWf/oB9Pz7KZrY7467z64wE5jsOZ99oj51X1kPyqpj7+crE
         baWD0iqrJ9oiZekqTk+yyXOOF3PuJgDvBSslAOzF8zQKy9Ca/w29AKx92sx2l6EZiAWs
         jedQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmFYBwCPISa80TWo3JxIVAdAi40LiydODTphIpSXC9zFj2dHiykResX02isM+5KnJs9jNjhiP7Q1BWiLk1IltcJYPqWfmbuxu9gBrR
X-Gm-Message-State: AOJu0YxglCvG2TSJPKTPLDVuskxOUtoLjwoGnv4F1/GI+eM94guit081
	A5yfZEuC5tENRmhVC7Erbcm0kXHq4zg0CNVlWSN9zjVrYB97CdN7db7zOi1umdzbQ+FNK2OyXZQ
	oTA6Gs5JQiwAYn9wQfmORHcTPmqZBig3y0XwtN+T+XcJb6ytRiy44VunGDchLSQ==
X-Received: by 2002:a4a:4308:0:b0:5c7:aeba:77a0 with SMTP id 006d021491bc7-5d25035be58mr500664eaf.0.1721071317070;
        Mon, 15 Jul 2024 12:21:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHclECHVFRdVYbFwnrtKH3lJcHIiAHM9jyDo1qTRx8+nslWI3GA72lYOtCld/HD9tYeAzQ33w==
X-Received: by 2002:a4a:4308:0:b0:5c7:aeba:77a0 with SMTP id 006d021491bc7-5d25035be58mr500637eaf.0.1721071316695;
        Mon, 15 Jul 2024 12:21:56 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b761978d30sm24039356d6.31.2024.07.15.12.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 12:21:56 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Matthew Wilcox <willy@infradead.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Mel Gorman <mgorman@techsingularity.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hugh Dickins <hughd@google.com>,
	x86@kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v3 5/8] mm/x86: Make pud_leaf() only cares about PSE bit
Date: Mon, 15 Jul 2024 15:21:39 -0400
Message-ID: <20240715192142.3241557-6-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240715192142.3241557-1-peterx@redhat.com>
References: <20240715192142.3241557-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An entry should be reported as PUD leaf even if it's PROT_NONE, in which
case PRESENT bit isn't there. I hit bad pud without this when testing dax
1G on zapping a PROT_NONE PUD.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/include/asm/pgtable.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 65b8e5bb902c..25fc6d809572 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1073,8 +1073,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
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


