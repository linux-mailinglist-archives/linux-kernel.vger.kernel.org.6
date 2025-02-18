Return-Path: <linux-kernel+bounces-520049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7E7A3A51D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB913B0FC4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1D927426D;
	Tue, 18 Feb 2025 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8VE9vZe"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9806274251
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902639; cv=none; b=rbwdf+IP9NV5Xbnb4rF/fPw0yx2ujl/Dr5nDt8FFa+kTwDU1ELEgR/thXOHqgPb1inqHNnPUcegHGmDDdzO9VdOCqbzM81Q3xipbIz/mvjaFcb3VmqLbZv8wg5XBI8w9F1EkskkSM4pnwQ9PjBC9w2Sqp1pFXKwiIfdcHs2iW38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902639; c=relaxed/simple;
	bh=zGZHu719XR5T2Nz5TfckVe8Ct9usRdZo0lQ901z9elc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PNwjw56lvBHSfwNEI/QqSkQ3T82UTYzb5np40p50DXgq01rBJE3lzGlfXPxTJN9bxii8ERsGumxm17Ls/g2zveeE78l6hLze1uGPl37F1CacyXSX+0poFlzwCB4ljiEkvB2t5A6CbUoKZVPyX/frBx5cTFbunGeSb2TY6PKXUFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O8VE9vZe; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220fb031245so77788395ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902636; x=1740507436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3u+CTmqwrQrYV/K3zHrRFLHLK3NiyuJYp7ufpVwRU0E=;
        b=O8VE9vZezczYsVhMtWEzdSq6GoCwNyj2WlQ5toaNl3Knpv0cXH+DVjn3AiscRmb0lv
         ORFvX4hMtOKY1QaDO3MIHeMMlgAbHLYgDypt+G3IyaNSpQ+1s6zyC/jmBcagx/KHNBbB
         KEqkYTwL+yc3vQv1yr+lbW1AeJsH4+IVRn0kuQ8sgCMs65QJKiMeahzcGL/RVuU9LnV2
         iC9R0dh4g6DqIcNu4NouDnG5n3qtIygR4J83lu81gJCrKPqFd/XrFsEBtN+I3RYm3lbI
         ACk02vWfGjobg8yvjDZ4y/Wu6dwMku0xfFxG6np909Q7EA4bsldtc+Tm74I3TYDfaV6R
         2rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902636; x=1740507436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3u+CTmqwrQrYV/K3zHrRFLHLK3NiyuJYp7ufpVwRU0E=;
        b=RS8EQkQar+L+9h+Qit67azl7XpNOwmcb5lyFxAjcFyDB2W0UjtGmML6vqFccRqLuT4
         PmHOcXAc4VAzypgnUzBlS9WZlc/EGPiCJ5h/BMeyJhuHU8MLiJcOrHpSfSaBTKKCNmsQ
         NWXnT2eEoiCgl1LB9yJ2edDqw6OA0Ir1BsfKA4pItAq5nljAXgHTmu/v8b53X3akUBm9
         udVaJ+POsRKx+1ocm4cjsVVJr6GQyQjc1+K3nVldPKX+dOv6vlCuBXtLgsZKwIWnXIkd
         hQ3flRpxMVcbvesy6Ni8U7ZdxCHMlmXFsJWFgM/YhzRz46KtIrnVajQw0HRshGSBKB6F
         OQew==
X-Forwarded-Encrypted: i=1; AJvYcCWwa++UYMyjyQH8HAHQu40XjSI4xOT3cxWrPUzxBo9+rL4XIUgNK4KSE5nvVa6D/xaOVNdxUj2jKxUeFFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw18BvJrTJaLYb99V25Y6FqxevbjlKcgmNkp2JrD9YpReG752fI
	urRskaR9TPMoAqAxAire1+HY1jDNG0L6jYtkfK1GxBVz6je48pnpGcBfFI0ynXqhZRtjrQ==
X-Google-Smtp-Source: AGHT+IEVyVGfhy0mXXOBmh74w/Y/vdmVPddLDcQdO/svtyI1/ROIig9nA5bmpgS18LLbayg6zPhWAxMS
X-Received: from pfbfu14.prod.google.com ([2002:a05:6a00:610e:b0:730:9654:30f])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b05:b0:1ed:e7cc:ee89
 with SMTP id adf61e73a8af0-1ee8cc0335fmr25038306637.26.1739902636141; Tue, 18
 Feb 2025 10:17:16 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:34 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-7-fvdl@google.com>
Subject: [PATCH v4 06/27] mm/hugetlb: use online nodes for bootmem allocation
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Later commits will move hugetlb bootmem allocation to earlier
in init, when N_MEMORY has not yet been set on nodes. Use
online nodes instead. At most, this wastes just a few cycles
once during boot (and most likely none).

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/hugetlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d6d7ebc75b86..0592c076cd36 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3152,7 +3152,7 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 		goto found;
 	}
 	/* allocate from next node when distributing huge pages */
-	for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node, &node_states[N_MEMORY]) {
+	for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node, &node_states[N_ONLINE]) {
 		m = memblock_alloc_try_nid_raw(
 				huge_page_size(h), huge_page_size(h),
 				0, MEMBLOCK_ALLOC_ACCESSIBLE, node);
@@ -4546,8 +4546,8 @@ void __init hugetlb_add_hstate(unsigned int order)
 	for (i = 0; i < MAX_NUMNODES; ++i)
 		INIT_LIST_HEAD(&h->hugepage_freelists[i]);
 	INIT_LIST_HEAD(&h->hugepage_activelist);
-	h->next_nid_to_alloc = first_memory_node;
-	h->next_nid_to_free = first_memory_node;
+	h->next_nid_to_alloc = first_online_node;
+	h->next_nid_to_free = first_online_node;
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/SZ_1K);
 
-- 
2.48.1.601.g30ceb7b040-goog


