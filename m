Return-Path: <linux-kernel+bounces-434777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200809E6B34
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145AF1675C5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E3D1F8F1F;
	Fri,  6 Dec 2024 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOPmxwen"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962381F472F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479201; cv=none; b=CldbCZJ2QAYjl1eLt+iKjLsxnAnOnzmXfeyKPR3/8cC3npQQ01/w2FL2oEw2wPjXXDyKSPN2vOj8Bpq8M0pp9B0p9azLzUf6+a/4F++Agrm1fFpVLMppBVijNABBQEVXi5hPN124lA9MaqsXc8jmUNJzd7PuD0TCU11LnjQCkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479201; c=relaxed/simple;
	bh=/zEfHNTaz2pqA8B6/MKZ/BIfzYg8R3MK9heJ8b5KsjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pySb447nxT0oLBEU1mlFrHtHR2Lar3R3NNBvSFoba730cONxepunaXauSTnBKLcrq0rhXqXxXTnx3yJPsmQhHp+sCtj4ulSr/vkDCW+Ix+dlaYbm3HAdOmLp/HkLFtkisPm4mLi3NaFt34kMOKJEBPxmJlZIgvhR7Q2j/sSNrPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fOPmxwen; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733479197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LTMkpEFSseFO32cP/f+vLN1CBb0AvUaOTImxXTbbB78=;
	b=fOPmxwen3ZN8Jxz7Ls8PI689ws0wKKOyRK1FoWbcmKfGcrx1+d4OTXdfhYBi/q1YLh13aU
	yspzpDZY2KHDfNQL9MIlhN1ZPPHyR4kIWdIeh4hFNxtHZrnCEqF0hk15lP8amLksHLwqTB
	LY5WKmBKrSDFWhep/m9kqBOp/DWPPp4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-YNAofVHrMCm856nP6djDNA-1; Fri, 06 Dec 2024 04:59:56 -0500
X-MC-Unique: YNAofVHrMCm856nP6djDNA-1
X-Mimecast-MFC-AGG-ID: YNAofVHrMCm856nP6djDNA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434a90febb8so11378025e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733479195; x=1734083995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTMkpEFSseFO32cP/f+vLN1CBb0AvUaOTImxXTbbB78=;
        b=IOuq+Wm2AGs82fcKtsvm4lY3K7BzMuoSE6NSvkoxRRpslbkYB7+6hGt833t2LDlvti
         O8Re6HUQE7ts1PTn1aPR40yyGcKh0QcZU6OXQi5xpwrKMPsBOjdK3PPZrNYRANwfiTjT
         RezVTSanvmYObLkCtn/e/n5VAfRVH1qSDe1KvNFOljx7I5ZZlp+NG+b6TBK6GvXgTr3j
         s5tfWdekECHXiqXqP5Ui6Ix7dPPJbTQvNSZ987tFPCIr3fYDbtQ2RBi+KtOvHxOZ0MVp
         xxkZ89KDJyGUZCAY21nhktLNLxm7bDkL0cxwX7cWrWBHe97I5IH+KOIPaQuY+rETPlz9
         XiOw==
X-Gm-Message-State: AOJu0YyGDYLgm47ea9TQCISAzdC3yTDUFnDET2fD/KqmF/o5HBeDpSmX
	oRFfhlGDn06btzaVRyLI/ZKJIBbGj2TRXJciFYn2s6IJXIvQ46E4wJyPk/v0ZT5Hcdgw0RM+90+
	Ng5DrfxFU2mX6kHAOw+xHeXdfvmdIXUBlfx9XcIEUx9xOzNF8Jw0G+DA1UYLqU5srqj/86hEE06
	cd5qhk55uq3NgoKGLrtKjSTGa1M8zpNVGRZRYYN2Sdsq6a
X-Gm-Gg: ASbGncvsV1ItDi6+Akuo8kBXUp7JsultYGYXLQYmK/I7q+aj0Z74so5wpB8naF1PH0O
	DFrS6YSi5RPZvhMnXkD4DDEzBX4o2q3hg5slLCLFBdZWpVE8hVHZcuzeC8bkFIh5JSgda/goRIO
	Rv0AdPZDW0C2WJChhragZpPC1ksYnbFht5lhSyf+eMkPBQ6WyeEgIeHxEff1kVwcM7oVCiZ1tVL
	cE9YZIa+P3pFcSOIrAF6Tl0Ll/8/Vx4pT/j6sFbFwgDQCGi7ojX7TlbWGVsaW3GbtbntF4Fme+2
	icmQovtnwcndQQz3UDpS/DMpoBTvg6+A54E=
X-Received: by 2002:a5d:6c69:0:b0:385:e013:39ec with SMTP id ffacd0b85a97d-3862b33f0d1mr1630915f8f.8.1733479194985;
        Fri, 06 Dec 2024 01:59:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkNmgJD9hn/EQiOmOvCb8sPlPYIIl6Kex5KTN3jtxwAtKApW8MzqmIerHVsbe30yftdPAcYA==
X-Received: by 2002:a5d:6c69:0:b0:385:e013:39ec with SMTP id ffacd0b85a97d-3862b33f0d1mr1630887f8f.8.1733479194617;
        Fri, 06 Dec 2024 01:59:54 -0800 (PST)
Received: from localhost (p200300cbc71bd0001d1f238eaeafdbf7.dip0.t-ipconnect.de. [2003:cb:c71b:d000:1d1f:238e:aeaf:dbf7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-386220b01c5sm4138557f8f.94.2024.12.06.01.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:59:53 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yu Zhao <yuzhao@google.com>
Subject: [PATCH v1 0/2] mm/page_alloc: rework conditional splitting >= pageblock_order pages when freeing
Date: Fri,  6 Dec 2024 10:59:49 +0100
Message-ID: <20241206095951.98007-1-david@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looking into recent alloc_contig_range(__GFP_COMP) support, I realized that
we now unconditionally split up high-order pages on the page freeing path
to free in pageblock granularity, just to immediately let the buddy merge
them again in the common case.

Let's optimize for the common case (all pageblock migratetypes match), and
enable it only in configs where this is strictly required. Further, add
some comments that explain why this special casing is required at all.

Alongside, a fix for a stale comment in page isolation code.

Tested with runtime allocation of gigantic pages and virtio-mem.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yu Zhao <yuzhao@google.com>

David Hildenbrand (2):
  mm/page_alloc: conditionally split > pageblock_order pages in
    free_one_page() and move_freepages_block_isolate()
  mm/page_isolation: fixup isolate_single_pageblock() comment regarding
    splitting free pages

 mm/page_alloc.c     | 71 ++++++++++++++++++++++++++++++++++++---------
 mm/page_isolation.c |  9 +++---
 2 files changed, 61 insertions(+), 19 deletions(-)

-- 
2.47.1


