Return-Path: <linux-kernel+bounces-283466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425A994F547
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C124B255F5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A20E18754F;
	Mon, 12 Aug 2024 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7jBI1sN"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C5018733E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481439; cv=none; b=HT1na+EWPYSRIc/btnG7L3Th4AgXFhg3Pd3OXI4dNwMRRJ2jGS1kqAyDUlg+NqUiezZHeGqymkicf1sBhfTNr2QmL+Ko0v5Ij8L2FAzVSJbwbB7i2RHLtQm+zp6gPxG3cyUo0qZdOVoXNVvFoj14Ol6IgnIZ8KQzvPhZBpgwH0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481439; c=relaxed/simple;
	bh=DZesoZHTRWCbLwwNstyM7gJ5jwQEg9bMdX+DVGz6a38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X52QUjRLGmE3wlWFI4EauYuw/m/CLd7AwuLWcSS9IcgKFTGgYNsTNpwaX8vk4EtWAGzkAhFd2/Vf2s8LaVAR39RRfZVQqLmbpfAdhhWQ99MRZHXNOYCqFjzZi5aFZ9ybzgCEm4GHKUNTrvxcN4CQ6VqCG/BWn3COHwFECcNwwQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7jBI1sN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-429d1a9363aso1095e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723481436; x=1724086236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Pwh5Yck0NJ63ftZanRvFS8ng+FvBnwXPy4oihzU0QE=;
        b=u7jBI1sNG2GpbW+11ThXucQ7Af/EK0mwEbMae6PEyatOY7XfkVzh9bdadozuzyG2un
         R0X9SGIEMC6h1zvwkraY4GlhEWaZox9/jTQwn9hwI+9IHdh6mS01GW6rIo42YlklgpSl
         /RsGPbJg/6qhHvt9awfjyt1YhMXNTi5YKWhIhu/FdIbi4BC8sIMjixPw+DrNbUKlTJKP
         Fp+/CIbkUALY0gKcTY2pAdiOM0Zpt+BRuMrNj1odstIeWtVTp6P7M4XZnnQ73LFAHeV+
         8JIssFc6Vay0fMVECJkLWOXLYSvSusaapr/jTagDfsG16rcij9JsFkAOlh0f2Aped+4q
         kY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481436; x=1724086236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Pwh5Yck0NJ63ftZanRvFS8ng+FvBnwXPy4oihzU0QE=;
        b=QVJuJd+3ooRMUqAx6b1kqyhVwCIBU0XUs2pluZSxUMd+HAp3KfmLPFrV2gccSnsCOt
         QQX9TKIHgrfW20f5sXi4B4UdxRpm+zaj2TklqoDHeVvWfSNDowZm7Xn77pF+IJieDdVg
         sgrIARHFUjRhoOwNybYq607zvinpNdXmddG5LC3aKRfZBhx6Dkp2ehgDpMJRQvRYaeeE
         mJ1fTDes4NAWQ+Mq1+BPiKCy9zL7A9GQiRxrz2BPws++q7yvklaCo6ZrGwRsqHVuUWLd
         eCBike8G0pRmjZQcomPEFQ+1gr5AElUyBAy3MJTyo1bY5qbSVTy0APyf9iayrlVAVFi/
         bjPA==
X-Forwarded-Encrypted: i=1; AJvYcCX1RSivQbPhK22UzrXxi8llflIEHO58DjcEq56uRZDYfPoeMU6rsVgwXVeZEpT7TeGi7WkQ1FdTeJK0I+36VFr3Ik072CjbWr8LgX7X
X-Gm-Message-State: AOJu0YygoiMiUgb3IBl4v4qDAqlBBJTgIOUTxjDgeIbTFCpTt3SZwKLQ
	gBEkuZpC+AVaQ/cNlRdccIXPtBSD4cm95BkhVpKOM3WBlrFgnR/AN0TavwRHnED4s+BqBXl6bPU
	jeTvF
X-Google-Smtp-Source: AGHT+IHfHCfh/WSuaqttUqyZE+PyNP9LtWGsB/jH2gcAVk2r+RVkhkgxxEdBJPnJp7LHUeTtjOy/kw==
X-Received: by 2002:a05:600c:3d0f:b0:424:898b:522b with SMTP id 5b1f17b1804b1-429c827a41dmr2993975e9.1.1723480961958;
        Mon, 12 Aug 2024 09:42:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:731e:4844:d154:4cec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd3416sm7942206f8f.100.2024.08.12.09.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:42:41 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 12 Aug 2024 18:42:17 +0200
Subject: [PATCH 2/2] userfaultfd: Don't BUG_ON() if khugepaged yanks our
 page table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-uffd-thp-flip-fix-v1-2-4fc1db7ccdd0@google.com>
References: <20240812-uffd-thp-flip-fix-v1-0-4fc1db7ccdd0@google.com>
In-Reply-To: <20240812-uffd-thp-flip-fix-v1-0-4fc1db7ccdd0@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Pavel Emelyanov <xemul@parallels.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723480955; l=1297;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=DZesoZHTRWCbLwwNstyM7gJ5jwQEg9bMdX+DVGz6a38=;
 b=ZH3EnaCLnxnBAMGfLvSGP0Eka8HeLuZeSjPlA42GsqIFj8e3TEDej8ARd5JVzffIeA0SjAHpP
 K2ENAU38N1DDTzCRll9WxUJ6b3Q4wSjqJacAcWC80k9zPshbwINOyyv
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Since khugepaged was changed to allow retracting page tables in file
mappings without holding the mmap lock, these BUG_ON()s are wrong - get rid
of them.

We could also remove the preceding "if (unlikely(...))" block, but then
we could reach pte_offset_map_lock() with transhuge pages not just for file
mappings but also for anonymous mappings - which would probably be fine but
I think is not necessarily expected.

Cc: stable@vger.kernel.org
Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/userfaultfd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index ec3750467aa5..0dfa97db6feb 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -806,9 +806,10 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 			err = -EFAULT;
 			break;
 		}
-
-		BUG_ON(pmd_none(*dst_pmd));
-		BUG_ON(pmd_trans_huge(*dst_pmd));
+		/*
+		 * For shmem mappings, khugepaged is allowed to remove page
+		 * tables under us; pte_offset_map_lock() will deal with that.
+		 */
 
 		err = mfill_atomic_pte(dst_pmd, dst_vma, dst_addr,
 				       src_addr, flags, &folio);

-- 
2.46.0.76.ge559c4bf1a-goog


