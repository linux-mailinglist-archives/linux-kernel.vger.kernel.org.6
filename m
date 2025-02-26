Return-Path: <linux-kernel+bounces-533951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30506A460A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3AC31897E91
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A486721D3FB;
	Wed, 26 Feb 2025 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czH4shhU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542BC21CC40
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576188; cv=none; b=POcdSeHqgIpz3YmcfQaotyxt79txwViZSqZfNN7rLkCBS1rK8REsTZAPQ/JQ3V7ycMwIFw3n8NuOZ4EorNid2HB+z4Ienr2Ftk/Yn4Kw4Z4PXRn5C19rmeovI5wpQBNOWAz8QNfT+u4t9hGCemQOS2dAmzBLwzMFbmnR5nc9bOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576188; c=relaxed/simple;
	bh=4OiIV5QxsFJTk6e24Gas31Y5wOcO3/LK71vDpcBsZvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=its5/3R34bFYKiqRbUOUDRsNc468dzm7krs3VRvj/0J6zknml7CdVYJNgOZLKs6/SWnhnPJuHg62C3J8RuhyzRv6uh4cMhb3wZAB+3DuUJyMOTm9obZL1kPz3iN4fDsdlo0/6xZsj55B30g2h6OG89dnmV47391mkCK9iJiMArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=czH4shhU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740576185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HdgkEm0fuuu6fB71h9i6WnSRavi+zx73Ldo39ZrlKw=;
	b=czH4shhUkxVPZj3XPzriVIylgqMbsPPCWVv+hUhdIPwJ/XOmZ2ZXzf9pQ5DNqbi6PMYdet
	b9FDpSK05oB4+/ZBtBZiGnIDbHOzoMPIzs3xrj2VCeVzcHzioTM3cwoz8UiZfrodluZyoX
	dZ0f2prWIJa0v3eVt5nOMfYMdlrjBRU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-vZQIL6F4MyuiI7yRwaMF6w-1; Wed, 26 Feb 2025 08:23:03 -0500
X-MC-Unique: vZQIL6F4MyuiI7yRwaMF6w-1
X-Mimecast-MFC-AGG-ID: vZQIL6F4MyuiI7yRwaMF6w_1740576183
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f37b4a72fso393458f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740576182; x=1741180982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HdgkEm0fuuu6fB71h9i6WnSRavi+zx73Ldo39ZrlKw=;
        b=JlHSLMGYLwUDa2lY3Pjsphkf99Qx0XIPRk8rWP4ezW4YSZ9AH4NulR+YeSPbdEAPiP
         hz2E29H54aq83pzl7+vpmiz/EmS5mopgj3uNgf4FtCLYhcblT+dOlEcy6PYB5jXd8CEA
         ZaIrRVoyw24EQ13x6YLEpYLVVgx9DT54mfmmuGPelvFqO2QoF0CVQjuBil6Q9KuMbtgS
         n+DTTkzGc5R0eADoEmdoQzhoA08rwXB6pOK2lJdaisgfucigxF6DHHwA3/8Jg17Jmnut
         PPVKjEALxygDzZaiwhBdHFZgURfuKi+lPQ2QDFn22ZN8+1N1nu15IRl4NJrTIyJ1BqoR
         zgdA==
X-Gm-Message-State: AOJu0Yy3FAxFlmxgSjtZiTRYyvJYLGf/r9P8Hz/QvacYhGI6iY8hEJRx
	talFglZ12BfWfDXl7c9j3SrHVSDGklK8rrif1D3Ef1hO1tMCw/GO4InzpMmq/S2M/McrQZdL27+
	/wK5lH71mWxMffsSAgMf5eRgsAa2v0CCieenoRpQ2JtWO967M2ugpuCFiKaOZH977+vraEDx19E
	Ns4TTPaP7yrNeHwhqjxI7nfcQojAxR2WmLNmoUKwdGPDrZ
X-Gm-Gg: ASbGncvAcX0TXg6SdvuOti8AWOmaHbdJWaQq9kAwCvSVu2M2dt0gMCUuQDZyuwjLARF
	9SUfKbqU1DV+wC1L5Hjg2WQX2o/s6fG+BXNxUMU5UCitf0fr/pFGGJesdna97u7Af9kjIgi13zk
	N9kWsjFrPEKJBaIEjMGjxdb+zYJXUw4XQqtoXdvvdAmBIlyiWkWffY6UdfNjylshG1zoej2PNXo
	fJCwBMRqrZKA8OwQxD/aTp0qQSX7FqU4mkmtrXjMZq8mN0G76W57eVpfIn3SKU41F29s80sGVFO
	suqomYc5K4fFBn6X72FuGPqjPllXbftt/JHDaOrmmMG3K6MqM98lru9YqPaJJbpFSiPWacDov43
	N
X-Received: by 2002:a05:6000:1f87:b0:38d:ae4e:2267 with SMTP id ffacd0b85a97d-38f6f3cd3cbmr16504304f8f.11.1740576182668;
        Wed, 26 Feb 2025 05:23:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGt1VK8Qha+1uMsU2pDIjFygOFfguhh8q3wgw54Ai6Omd0rtqWpAarTyKRjr67o5nrATFNkDw==
X-Received: by 2002:a05:6000:1f87:b0:38d:ae4e:2267 with SMTP id ffacd0b85a97d-38f6f3cd3cbmr16504283f8f.11.1740576182313;
        Wed, 26 Feb 2025 05:23:02 -0800 (PST)
Received: from localhost (p200300cbc747ff009d854afba7df6c45.dip0.t-ipconnect.de. [2003:cb:c747:ff00:9d85:4afb:a7df:6c45])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390d6a32299sm2059535f8f.55.2025.02.26.05.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 05:23:01 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 2/5] mm/memory: remove PageAnonExclusive sanity-check in restore_exclusive_pte()
Date: Wed, 26 Feb 2025 14:22:54 +0100
Message-ID: <20250226132257.2826043-3-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226132257.2826043-1-david@redhat.com>
References: <20250226132257.2826043-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit b832a354d787 ("mm/memory: page_add_anon_rmap() ->
folio_add_anon_rmap_pte()") we accidentally changed the sanity check to
essentially ignore anonymous folio by mis-placing the "!" ... but we really
always only get anonymous folios in restore_exclusive_pte().

However, in the meantime we removed the separate "writable
device-exclusive entries" and always detect if the PTE can be writable
using can_change_pte_writable() -- which also consults
PageAnonExclusive.

So let's just get rid of this sanity check completely.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 567b45e5d149e..507045fa719cc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -740,9 +740,6 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
 			pte = pte_mkdirty(pte);
 		pte = pte_mkwrite(pte, vma);
 	}
-
-	VM_BUG_ON_FOLIO(pte_write(pte) && (!folio_test_anon(folio) &&
-					   PageAnonExclusive(page)), folio);
 	set_pte_at(vma->vm_mm, address, ptep, pte);
 
 	/*
-- 
2.48.1


