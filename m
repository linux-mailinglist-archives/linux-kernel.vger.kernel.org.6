Return-Path: <linux-kernel+bounces-520048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A58A3A51C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C1C3ADDC7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375AD271260;
	Tue, 18 Feb 2025 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLQ2W+P3"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C38A27292D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902637; cv=none; b=tT7muX3hprueuDaCebEvmYjsZNO3D1P7+uKnWavSK5AsKoKxiTVWu8vmB1C6mpPHPzR0pi9LIF6FxtLmx7Fhqa+2vybLBOc/jddRVCvmaR8oHFvMvMpt21zOs8VP4wmJu8qtiOT9uS67l4Ds//A0cwab6q85ta15ilTiRk1W7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902637; c=relaxed/simple;
	bh=fow4xQaB74E7iIbvsaveqKGwdtA43VpX3C+imLYMWio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jdgZpESCPj9fEZLgzdSIYH75/KVrxuJlbzIpWln3/Jx6M2bBgKlJgs6wyZbxk71/92/Sqp4Vfu5r2fFKbmgek5qAU/gFpMVzJ2u7TtWVjlvthTf0h1NbCjoHHvW1N73hvKptbhBtohHeQLD0Zsq3Ys1wTkSUXZSMDCz3zNGhKgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oLQ2W+P3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc46431885so10134793a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902634; x=1740507434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u/xuszDLPFK7URQqd9Wqbe7y8mvvdnw5mOni6+3Gut4=;
        b=oLQ2W+P3YdiaRwTaVHkTxrM83QESKfziaIOw49Fbw95P32/g1Y/It35+DQMmBu+26w
         gfXiXX2DVDDyTo9n/iwhDy6p/hMghy+2X09s5ppqTZDtaQqUtWy3t1qyR0pEg0IPy1So
         cRLFZ9T9MDyKDUA2WjP3VI8FvxdDWyH/kMZo4AMSzTGGEob0THHBR0kqNJ6EX/dedj32
         BSi7ZzQQUVpwxmvqIlHEbEHLmFzWcx6AIGFMQHDNyqyhsMx2DixnF/afn56rJVRh6IE+
         2md39SZrzBvRBc+XU/CiJl4+kDphTX1kMTnjEs1EEX0zD3l7x5I1UXiToAC9JAlSMaIi
         foag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902634; x=1740507434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/xuszDLPFK7URQqd9Wqbe7y8mvvdnw5mOni6+3Gut4=;
        b=ColXf6CDlnodTFA/3Ec9tG3W9+CDAEIdxSmV3Gg2sUSdROKlZ7WHla1+OFiuQQ2hZu
         1ocOnOMExMG+cdvaVpE0HKy54d99NKW981sbSz+ygYejkKhcyqSiKpGjKsNeJiu39zWp
         7xcrLNnq+mahk1KyPUwf3Mb5g2Jdre8t2FFs0n9VUsl+KZu3pyaMT68iXfQLEdK1Ujtz
         chxPDyixuQAuHO2iip8A0OkObTKUWdtJfLqIeUVF6AgfS8a43RgdpWVbFmqmvQWbjk6z
         13B/4/tqoT+ynlUDCOQ0LX/GsAx17wg987uoR4ytepfC6uW4A8K+eBWm89P1FqIOEAZl
         hE7g==
X-Forwarded-Encrypted: i=1; AJvYcCUJu0XIhMpx3R2pQrVGSFZNVwT/5z2bJY06J/IZgQSznbKyipbIyctU1+fl5a6aynb22KZf8q87Dc5fTak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt1bZXoz6WghC5bd3wVWCf8G4//xmrLJfS8quUWt1TA9NpZVxA
	p/k94/NOky7yKXyp1WCSaHVBMs+5YgfDRCmMm5mM9aV1/VdGZplPA1w/pOajxASffynC7A==
X-Google-Smtp-Source: AGHT+IG+/GahjgZk9wH9MMpH5rIkZMWL8OoiRoUarubQVIw+Za1lYfVaSifBByt4Dpo+odnYODGrih6V
X-Received: from pfbce6.prod.google.com ([2002:a05:6a00:2a06:b0:730:8e17:ed06])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7898:b0:1ee:7c7d:d699
 with SMTP id adf61e73a8af0-1ee8cc08368mr27621857637.35.1739902634501; Tue, 18
 Feb 2025 10:17:14 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:33 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-6-fvdl@google.com>
Subject: [PATCH v4 05/27] mm/hugetlb: remove redundant __ClearPageReserved
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>, 
	Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"

In hugetlb_folio_init_tail_vmemmap, the reserved flag is cleared for
the tail page just before it is zeroed out, which is redundant.
Remove the __ClearPageReserved call.

Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/hugetlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fadfacf56066..d6d7ebc75b86 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3198,7 +3198,6 @@ static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
 	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
-		__ClearPageReserved(folio_page(folio, pfn - head_pfn));
 		__init_single_page(page, pfn, zone, nid);
 		prep_compound_tail((struct page *)folio, pfn - head_pfn);
 		ret = page_ref_freeze(page, 1);
-- 
2.48.1.601.g30ceb7b040-goog


