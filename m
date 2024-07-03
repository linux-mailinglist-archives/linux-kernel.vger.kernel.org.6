Return-Path: <linux-kernel+bounces-240207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8E2926A43
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296491C212BA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A27194A61;
	Wed,  3 Jul 2024 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jpe3rZ6s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BA91946AD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042177; cv=none; b=qTUKr7Noxra90pUqPDyuUCXdANELr6UlgXZ06J72D77CfDibES4PKALu72Xq/dI6ARqwLJKAjLQ0oD2cEqf+41YVOy4fRR7xyGkjWsoEgzOuaxOeOFbUXjy7OMAfKAaQaI/dkD8A2qBIz88PIK0cCfEixcnHTZES9bPYdJZ3tQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042177; c=relaxed/simple;
	bh=HvLeVYUQ3g1BzJ0yN4wtIuLe5eY6YeKrJD1Hba3arrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XB6idAYII3sgbyLvhWQZscycX0ekmzt7D7mj9UNqAdn1WNlSNR3M7KxNMo3BRLsq5KBLdf/M9EuLxu+G36QBsCtbE4nASr+ErGo5wXihhJdMDL+m5PMxb2/sBb3UCEg8qop1vmq5zPHA56Z6NwrnesOeNkWm4UNFlzXSd0RSRrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jpe3rZ6s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720042174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFEuzrgphkpyKgRaMn/StFmQ1IWZKcW4qj9eIjoToHw=;
	b=Jpe3rZ6s0I9P3NGIxEklmOwxwXwhB3m8LS1t8oOXyfS8iH1bjH/Zx/qbswNGICkawDpX7L
	+fIT1AQ3voRmNtGnhE3PDhOM0l3hNIYllYGm2Ni0nx7xtSHFMp4hvw2hGRr9irTdlaCJtT
	d0Z99hok70P72wOlC/n/DT0FK1C15dI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-eaXcqT8gPA6MpjGjm-TfEw-1; Wed, 03 Jul 2024 17:29:33 -0400
X-MC-Unique: eaXcqT8gPA6MpjGjm-TfEw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4466fe59a3dso2086351cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 14:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042172; x=1720646972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFEuzrgphkpyKgRaMn/StFmQ1IWZKcW4qj9eIjoToHw=;
        b=MIfHp0DAgJw7zsEj+izesc4pO+Lyj6XgSJ2aMzXTr+3JAWOtJh5QQkjrCYsG1iwgL3
         JDnCS5Td523oI9e3CfCrCBj5QPQ8d8cJkKwQI/C1UZJkkmMYVI5iv0G39ZjbCxDEBs4p
         rHlB2Wj4visO4RGhXtp2NmmTXcbjjobxUsE4oFs6ZhGMiqmj0yWEISmpdA3Q8dve39dN
         ZPFUk7aD8H+o3k6ZOCcmNUlMSuNyAyfZdScrbUekt2XTLRbaZAxVWg5Ay9edKASmqrxe
         4g15rxm8rcqnhTgeWqApS8BQOL+tVgUGMrlZaKXrw5NNhCiynl3e4hpTUcepbdTba15+
         4EtA==
X-Gm-Message-State: AOJu0YyTVHds4jAn6vzEU3jcnX9E34yzYC9inK2uoxKnDW2mU1/CDvZa
	oxOnLm4+SfAZGfmtRMil9uwKUTjCa+Sb00GrxVVanEaNV9DkmI4pn3ieBa96nYDFFRFl6GWmnJn
	SSmSflRRVCGQh+NPpivfxUBvuiEkz1DhjUuYibpAIrWzkBlsVQIcyo+2Q3KUcVU++qrptc1pxHo
	yw/9kuneBub9o9Gc42ZmDrLQYslbsRccRnHK7uEdARue8=
X-Received: by 2002:ac8:7c4f:0:b0:446:4428:2d8f with SMTP id d75a77b69052e-44662fe8d5dmr138289861cf.6.1720042171952;
        Wed, 03 Jul 2024 14:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMHO5UTPVYkVSEJYbLjxCcukt7PlLC0h81KBHiBOgwFBj/wiCFjtQJqk/7gb0k9Iu8HJBYNg==
X-Received: by 2002:ac8:7c4f:0:b0:446:4428:2d8f with SMTP id d75a77b69052e-44662fe8d5dmr138289521cf.6.1720042171603;
        Wed, 03 Jul 2024 14:29:31 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465143eb1csm54337481cf.57.2024.07.03.14.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:29:31 -0700 (PDT)
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
Subject: [PATCH v2 5/8] mm/x86: Make pud_leaf() only cares about PSE bit
Date: Wed,  3 Jul 2024 17:29:15 -0400
Message-ID: <20240703212918.2417843-6-peterx@redhat.com>
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


