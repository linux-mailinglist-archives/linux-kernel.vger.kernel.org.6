Return-Path: <linux-kernel+bounces-279772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE92394C1AC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7411C21CAB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA395190668;
	Thu,  8 Aug 2024 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="I3DvwFD1"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9203E190054
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131765; cv=none; b=qT9yErX7EtTLF03nUMv73SaHufirInJgwMa2jHePz+a6RkxIoLEB5tjfBagG1e7PKnfIsyn6sKQ+gkMPSVnb1I+m2LtZ/cobrVvT9Dg48w0a0hraGCKB7VLMhnookh64mKSyYX+EOzIOGciNpgYUm+GKxPwECFNb/QeLAO8p190=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131765; c=relaxed/simple;
	bh=8rI7joosp8awa/gMykJMhXumICc/dwUYMwOKiBmRUD4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSWMi1IYenJ8Nidm/O759UC+aaNhvgD9ddMnzeYdJxijshNCg3ySfN7gI8vRfPb5oOL9x/5WL52YngoNowYVNzfjo+4QC2tdJuHBfAatd1pjnxBrhUcr2jBw/QW5Y0CZS25zD7ZQPxcbqblTKl3bwcd6BN3H2lzJmjWmYOg///0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=I3DvwFD1; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44ff398cefcso6442391cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1723131762; x=1723736562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3neo5ZpPv5S0nCnjgNJX6IioRmVVyTly9egBg9Jmdk=;
        b=I3DvwFD1yhMhHA27hYSf3nIl/t5ZOozebJXKpgalRDOdU9Qu00yO9H8ytGey8tlumc
         jOh5vejH/4EFFp54iHDfGExLyL/rlWj3dMxal74NrMcyIrkNfIzXXLYvuL37OautftRr
         Ee7xb5IwGhaBUH4CSmSFzzi19U+viFrk3e9HzIcvGnkpldmFEqKoKTzdEeBUGXtFZKPq
         Htw4dOxPDuFXEEGTPjmNb+diCNQowH5pDTULCMMtX1SO6OkMLpSAhG3WG49pLICF3Z7o
         kNmNr/jBSuq+h+AVfpHzz7Fk3cEV/+wzAXfGpeFtg1wg2clPA8632We/y5ecED111U9N
         7jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723131762; x=1723736562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3neo5ZpPv5S0nCnjgNJX6IioRmVVyTly9egBg9Jmdk=;
        b=A8nHRW6O7OK9Fp6Esq2JdXlUuc07f/hsTx6w4tuzIeM+fpDNI2pqdmncBTiyGxodmH
         b2bItPjlcapbypZyn2+M7Ol/v007+Sj3bIY2Wz0km7RiydhQ9ss5wEndpQrLtidTOnoQ
         qYjip/dhgwHc6+w7+piKyyNPVQXoqaFp57b/A4zsSnUGCJd8vde5zmiF6Wia6RVQRoju
         65cVEiHFGFZuLgWfyOp0c9jlXZt5v90SRWT5RVpRfdOjz8PFRmfE74kwwGMHztxnHi9E
         laYviHISUgN+aTylTEhaHEFqvZXeZrd/i45rX4qotZEfRX+hmeg6kM+EqNCVyGbT/y1R
         CgSw==
X-Forwarded-Encrypted: i=1; AJvYcCWVDwUs2lY7sN402Yd/zK61OHwAwW+dT1bB+O5QiZvUYwgMwNOm5g9zTq5b+xizsTv6lVpHw6BwO21/Md+WjdaA5xo8zTMZya+2/Qed
X-Gm-Message-State: AOJu0YwRckwj6DskU/ApOWfmmIwG1+mpNbmZBDzKxVNx8cEwUfSvWgS1
	3RZlCscmWyrtRo3uFEVtTs1jqMvCUgCNC/YCGCXWTJef7RPS69pAWL2FLbTeNz4=
X-Google-Smtp-Source: AGHT+IESGfyB5HtXu4zt+BcOgb/gdPZpAEI0Yo2J7Xp64aGcrd7WAVMlzlbxNtl0uyZb/RHkn8qBZg==
X-Received: by 2002:a05:6214:3bc5:b0:6b4:4470:81a5 with SMTP id 6a1803df08f44-6bd6bcbb55fmr34927436d6.2.1723131762416;
        Thu, 08 Aug 2024 08:42:42 -0700 (PDT)
Received: from soleen.c.googlers.com.com (118.239.150.34.bc.googleusercontent.com. [34.150.239.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b72d9sm67160936d6.60.2024.08.08.08.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 08:42:41 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	cerasuolodomenico@gmail.com,
	hannes@cmpxchg.org,
	j.granados@samsung.com,
	lizhijian@fujitsu.com,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	pasha.tatashin@soleen.com,
	rientjes@google.com,
	rppt@kernel.org,
	souravpanda@google.com,
	vbabka@suse.cz,
	willy@infradead.org,
	dan.j.williams@intel.com,
	yi.zhang@redhat.com,
	alison.schofield@intel.com,
	david@redhat.com,
	yosryahmed@google.com
Subject: [PATCH v3 2/4] mm: don't account memmap on failure
Date: Thu,  8 Aug 2024 15:42:35 +0000
Message-ID: <20240808154237.220029-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240808154237.220029-1-pasha.tatashin@soleen.com>
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When in alloc_vmemmap_page_list() memmap is failed to allocate, do
not account, the memory is going to be release at the function exit.

Fixes: 15995a352474 ("mm: report per-page metadata information")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/hugetlb_vmemmap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index fa83a7b38199..70027869d844 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -392,13 +392,10 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 
 	for (i = 0; i < nr_pages; i++) {
 		page = alloc_pages_node(nid, gfp_mask, 0);
-		if (!page) {
-			mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, i);
+		if (!page)
 			goto out;
-		}
 		list_add(&page->lru, list);
 	}
-
 	mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, nr_pages);
 
 	return 0;
-- 
2.46.0.76.ge559c4bf1a-goog


