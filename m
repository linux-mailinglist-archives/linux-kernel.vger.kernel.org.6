Return-Path: <linux-kernel+bounces-440330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630AF9EBBE5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A70B188A50E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B4823238B;
	Tue, 10 Dec 2024 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yR1thKEB"
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1771B0F3E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866264; cv=none; b=M947MCsAxnHuoNcGsiviNqNej95bpGzRaCWRP0tgOSp7Eg4YUaybabPNha+TacODLZnFBI6mTB2jaWAQkuml5TZVGgRGG/Ex9ZTMDpkrq9CQKc9+q8nAzMp/C3KNrttSbz5QRGwY6K0W3JFSWVj0wuuQKyDDr3B4AhM600IK4/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866264; c=relaxed/simple;
	bh=IOZAPs5Tx3+mzCRFJUlx/4J6iv0fhE1GwZLu+JUI+d8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hDjrlndu9JiBUUf1SGv5cKJ8hii0MOm0GGKCdcwz3Zapr8RWmCTwsum+Q9lvZp1nbDpI8N+3BwJ8pXHzlIvpSg+8hBvsqPmCDo8PtduYuQIpOYIuXR4wlYrPYyC0IA7P192Ocvn7/6ABPRPXycqWjNWTiVeSPxPe61aiPg9CDd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yR1thKEB; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4675c482d6cso50522811cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733866262; x=1734471062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G32JxFMabBUDQi+52by10jYMucvOr3O4hJ3hDDPHLcQ=;
        b=yR1thKEBGPljTAoRQ76gAJbwfqRmBVktKtuZG8qFNyxW2En1vEdfbyItXTpKJvhOF6
         QTMG0dQnObtI6ziv3xCwWmfcZoSfjpER7JmoFJ5UCZZnUbJc/jR9ch/kO2mMoBaDCirF
         ZwHMAncTL/jw73WQB0k11QLDkmWNHtaBVpbm3vfPT0HavL352lz7gnj2HXBUA5hft6I0
         7PUgb72+WKwvvHy34tCO3mEwUOA/grlG+SU8zYyAkZf+j3zbJodHqsZ7B/Fw9gycd0FO
         E+GO42dawTxgYybd8teReEkvV5jdcHKQDhFQUjwfSf+HJIW2yVLf2VfZKIW3TmTVaPJp
         Z3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866262; x=1734471062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G32JxFMabBUDQi+52by10jYMucvOr3O4hJ3hDDPHLcQ=;
        b=GwdLpEyjOwlaofgjcaaRpNbYmGMoMeVP5GTO0Gh00R+rk1CFWWDC9p2t1a90v6fppA
         4HA92iFJTMsMU4GDB506HhC2sEbTxna8MKjqdcxSK23fPdiUBvNkGylNugOPJdUErdrK
         VDc9MXdJm5r5I0UEeeUnBP01X+YkZ1mLeguanWblBhORD4sPorxwdLHoiGBT6mRaOhjW
         /aCQBbQnf4T0Sr4VK4O5PXc8cfjt3IwbmaospO9V7f/PL1BROzwfgX13VHOOZ99JujIk
         gPjjfyqA4GqEa84xCV9gBoY6zXibvQWqaAPG+s0w2khxLvBoR6s/AFWRgMq9iMuAp4zV
         T+Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVMrSm8IE3zwSqH14bIJYbFRF8ohCZEKxqEgGu/+OfvUx3jjXqz2BEie847mRMj9JIvgknFc7vnJ+gGXdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG8OsjexvAI5H29AB9upO6wn76v5/kxeASKu3/1MfAPdc/d15W
	CrUzNvrF2wyErpVP4nIJX8xp9yyv6Cyx/YtCqi+6RyZAjEhfMLiSkJbkHn/OsffAdFZQqGF/0Bd
	DP5NF9A==
X-Google-Smtp-Source: AGHT+IEpCtrL8H1FFUbminr4KvNlPmZTmCfZCaR3pkbbEKhlEMHUlCB45RdOMbWWkvCARQTAtmkhm4ng8J34
X-Received: from qtbbn6.prod.google.com ([2002:a05:622a:1dc6:b0:467:7fcc:751e])
 (user=bgeffon job=prod-delivery.src-stubby-dispatcher) by 2002:ac8:7f93:0:b0:466:b1fb:3028
 with SMTP id d75a77b69052e-467892e9a98mr7952001cf.4.1733866261754; Tue, 10
 Dec 2024 13:31:01 -0800 (PST)
Date: Tue, 10 Dec 2024 16:30:47 -0500
In-Reply-To: <20241210213050.2839638-1-bgeffon@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210213050.2839638-1-bgeffon@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210213050.2839638-3-bgeffon@google.com>
Subject: [RFC PATCH 2/5] mm: mremap: Use round_hint_to_min() for new_addr hints
From: Brian Geffon <bgeffon@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Marco Vanotti <mvanotti@google.com>, linux-kernel@vger.kernel.org, 
	Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"

MREMAP_DONTUNMAP allows for a get_unmapped_area() hint
when used without MREMAP_FIXED. This was behavior was introduced
inadvertently and should be rounded to the mmap_min_address like
in mmap(2).

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 include/linux/mm_inline.h | 14 ++++++++++++++
 mm/mmap.c                 | 13 -------------
 mm/mremap.c               |  3 +++
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 1b6a917fffa4..863143ec5bb0 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -9,6 +9,7 @@
 #include <linux/string.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/swapops.h>
+#include <linux/security.h>
 
 /**
  * folio_is_file_lru - Should the folio be on a file LRU or anon LRU?
@@ -613,4 +614,17 @@ static inline bool vma_has_recency(struct vm_area_struct *vma)
 	return true;
 }
 
+/*
+ * If a hint addr is less than mmap_min_addr change hint to be as
+ * low as possible but still greater than mmap_min_addr
+ */
+static inline unsigned long round_hint_to_min(unsigned long hint)
+{
+	hint &= PAGE_MASK;
+	if (((void *)hint != NULL) &&
+	    (hint < mmap_min_addr))
+		return PAGE_ALIGN(mmap_min_addr);
+	return hint;
+}
+
 #endif
diff --git a/mm/mmap.c b/mm/mmap.c
index d32b7e701058..04952ac21d58 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -215,19 +215,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	return origbrk;
 }
 
-/*
- * If a hint addr is less than mmap_min_addr change hint to be as
- * low as possible but still greater than mmap_min_addr
- */
-static inline unsigned long round_hint_to_min(unsigned long hint)
-{
-	hint &= PAGE_MASK;
-	if (((void *)hint != NULL) &&
-	    (hint < mmap_min_addr))
-		return PAGE_ALIGN(mmap_min_addr);
-	return hint;
-}
-
 bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
 			unsigned long bytes)
 {
diff --git a/mm/mremap.c b/mm/mremap.c
index 62aec72bbe42..fdc1b0f1b38e 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1109,6 +1109,9 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 			goto out;
 	}
 
+	if (!(flags & MREMAP_FIXED))
+		new_addr = round_hint_to_min(new_addr);
+
 	if (flags & (MREMAP_FIXED | MREMAP_DONTUNMAP)) {
 		ret = mremap_to(addr, old_len, new_addr, new_len,
 				&locked, flags, &uf, &uf_unmap_early,
-- 
2.47.0.338.g60cca15819-goog


