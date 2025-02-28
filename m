Return-Path: <linux-kernel+bounces-539154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105D8A4A197
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753143A8737
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD53A275617;
	Fri, 28 Feb 2025 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cFwHs9lX"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8431F4C85
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767398; cv=none; b=fiOtLdoo/Xowlrl0hQB53xXKRf+9kNBQwFrOUou+oqlCxYrp7ffCdePHBRdzCMmOx5sTOmAcr98NKMLTPPtL+V4jiobUlVx29ddRDh+AJhiHm3RAZHH33ggvS5XIBuQaximvsSElPGvYoEOVbgUfnGoARyRHU13mH2xMEuBl6cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767398; c=relaxed/simple;
	bh=2LQrg0zUkb/TTwCKsSCtWsYItLgKQyWOhb8ym+5nzxI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KDPpElN+1Y8kFLKgoS7cJl0zjwJappUKVkZHRzSCfI1Srh6PZpG6gxCskiOX60bmMdA4RTD+WNwRI54Oa75oCA2jGxSbRQilAx54WYd0c8HpF/vJok+pA6ITOAaTpQuXrMwV6cn0B0AEcwi+/MotC8nH1bKvEZxH2sy8pUQ7LNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cFwHs9lX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc1eadf5a8so5048833a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767396; x=1741372196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W6gZ1EoDBME1HGkx1DBWcAG+gCVdWdKNzaRnW4BhOvY=;
        b=cFwHs9lXI6B9JqRZQzUtpi5B45rhuRQnn6kr7Es3ZYMXwuyiB1wwfIbZeCiTvk1iDk
         Qnv5f/T9iUKvzFtW4gbrYhOK74Sla0hyqihqs3fonv01UGyecMPcmn1JRi7AI1VP3h8u
         CB1KiGK2KZUY770Fmpz3kh5SqmSJVBlLyGZ/g/glPljRsMNgJRR0p4Va0elrF9a/h8Rh
         9T7Z9ZRWxpjtpyPzedOW0SaDU071wj2COt+Lj2mZF3NGOdl50KYWt9VHPO54hT5ssfpb
         SYs4wuItHfGrnWxh1zXBfQJH2dMcd1AVUaZp97rpYu62zraAdj/UJwubderp6UyV8Zsd
         ek6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767396; x=1741372196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6gZ1EoDBME1HGkx1DBWcAG+gCVdWdKNzaRnW4BhOvY=;
        b=O/5WQ6bRrb0tm21vUSe5BdFZs6NoYFOrLopv5oxO41kaJ5C11bb9/EaPegC+NKSUh6
         8Cu48p8l7hofRGQlZl9Kk9+tQRdsC/Mc4emL+77o1yrRvi8Pr/dFqfz1vfmU705ukq2k
         fX1EhbGJqWQJgVK67+AXCXpHyEe6U6xEXyMV0B2J1D3vMy7GT/vCkbfxQNKJQwe2IWDO
         MeMeQXvFnoR5wQaw7s42eLMp3luuKkRrXma0CFYzFfgB82V86fOWiL6QDaTox9fPPxBK
         YTP1At6DiWl16/BUH8SiCMu5VuDC9LBcw7V68l18VYvp/ozBR9i8RavNRiu5L0uqCizH
         d5RA==
X-Forwarded-Encrypted: i=1; AJvYcCXsDPAtCbDP3/ns4BX+WF3ITeGxNIS6ah3ZEd39bC0B7k78L1dk0icmxbx3xVmrTL5p/Pz+ZgR8BdbEL0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD8pB5OtfqODX1J1XZwGT8Z+oe/hJbL4vsOoFNh+/iciyLYn0e
	DncKGSH9SKZZUIOq1C4Et1zET1dwp4iv10sUxfJsxMaJljZSpxSO/c6Rsv5yQF/CMvmYgg==
X-Google-Smtp-Source: AGHT+IGBekA9yH+3WWdUMJNOD5Pd3PBDucriRK0CwTmdQpzZ//urtl/q/fvn5N6SAkEkZtWc1aZX3AbQ
X-Received: from pjn14.prod.google.com ([2002:a17:90b:570e:b0:2ea:aa56:49c])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e01:b0:2ee:ad18:b30d
 with SMTP id 98e67ed59e1d1-2febab30c86mr6700197a91.6.1740767395727; Fri, 28
 Feb 2025 10:29:55 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:05 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-5-fvdl@google.com>
Subject: [PATCH v5 04/27] mm, hugetlb: use cma_declare_contiguous_multi
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

hugetlb_cma is fine with using multiple CMA ranges, as long as it
can get its gigantic pages allocated from them. So, use
cma_declare_contiguous_multi to allow for multiple ranges,
increasing the chances of getting what we want on systems
with gaps in physical memory.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/hugetlb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 163190e89ea1..fadfacf56066 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7738,9 +7738,8 @@ void __init hugetlb_cma_reserve(int order)
 		 * may be returned to CMA allocator in the case of
 		 * huge page demotion.
 		 */
-		res = cma_declare_contiguous_nid(0, size, 0,
-					PAGE_SIZE << order,
-					HUGETLB_PAGE_ORDER, false, name,
+		res = cma_declare_contiguous_multi(size, PAGE_SIZE << order,
+					HUGETLB_PAGE_ORDER, name,
 					&hugetlb_cma[nid], nid);
 		if (res) {
 			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
-- 
2.48.1.711.g2feabab25a-goog


