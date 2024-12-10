Return-Path: <linux-kernel+bounces-440331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FA29EBBE6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC9B281D16
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79908232399;
	Tue, 10 Dec 2024 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oXLUlW8B"
Received: from mail-ua1-f73.google.com (mail-ua1-f73.google.com [209.85.222.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29D91B0F25
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866264; cv=none; b=u0U07kkSF5Dks1C38SkdRgdzx07Oxj3EuTms+ZAiN9Rl3XBMq1PFOcCDbtxcDXPZ31jdrCIfVo4xyB0bdBHBkcMAW4aJJU3asvKIInJlBnEqZKiUe8C8ktVTzJ5nWIqfFwq3Yd0T5S0g2GwxM0BQbV74yn/1BIOf+WhNFQPf7fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866264; c=relaxed/simple;
	bh=cLn5rbfFYFPA2ZQZv+GbmAK03oo9d1PmaRYCNciDab8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LZDHHUPeBXaYQxb6I0MvKTfMFti2wfWNVhgEVBgXyLXoD0MwI60r94LiC6+d2XPghNygdcb8Gg5yT0n7GLMx0hqtNbtVl8Eeyv/2X/nNj8g9ATJMZy1NalBNUoRsjXXFlQTI3WyCKzz5hA9U+7MEztHZC4+f3JnkSNB25egbvoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oXLUlW8B; arc=none smtp.client-ip=209.85.222.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-ua1-f73.google.com with SMTP id a1e0cc1a2514c-85217018d93so815505241.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733866261; x=1734471061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dgSSzFrkXg1CYSEsBlnHDnKWydapEER+JZ1i3v6REhA=;
        b=oXLUlW8B+H98TPdSMAdDLUGi5iaTEXcN/wQJfDs8Jm9rBnXJJ9gH3bqKxeoPKYLreY
         A0CjGIAwv745qU879Uhhgz7sZK0UPt56AkrYAMozR1rdQQ7y6loGN5lIettJHEGac+Ka
         E7nNiED6ayHEzeSWAiXPLnkZUdnIowypo2CdBD2t2CISJu0wpBHhsrXDG4Dgsu6oU2zY
         gHr6iiUmowGxy6PllhFwV2v5sKtxaixozc8epaCQ/0S3bpETr0YGH95N/Y8HOyHAohAP
         njUd2z8aFX2i2usQjhlPS9CU+H0Z0dk71a/KDwyS1Wdpm05Amzx3wS1bozunOJsvykjF
         x8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866261; x=1734471061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dgSSzFrkXg1CYSEsBlnHDnKWydapEER+JZ1i3v6REhA=;
        b=GxzbJ73lVjQse/H57i6LXm4jfNLPagA+AvmHy25jIxgzDS625EkjHilYGDLTmAfHoA
         HL3SowblsQX+K8YsaoLp7Mj5PDMY6VzAq4DHRAT6a/v7xjaxF376Jab37F/aJppYpx3I
         vAr0irzZBCBhH/gNJGHV1qgHj0LrAdy3Vb7r1IZOQVmPKUPEiPNEQnQffQa7v+EIMXwq
         AHLMFGO285VD/MpjLBk/VO75+2l+QGEYkQUqamAAwfoe1oZr5N45zpgnaDJELmbbJtd1
         D0PcN1jQYF6N2oz7Z0TrCZpk8ZoK3WZVJEBe9WBaUlJDFbIgcJtsLzdiXKf9iBZGuVOb
         /U0g==
X-Forwarded-Encrypted: i=1; AJvYcCX4Blw7qCg8GzK3FYwi1gA/61l+sMuz3yZRGa0PH5MTZ1nCDF8sl0uvbG2z8l0g08CqipkdtNQ/D0LLqPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0OfPV7idaIed1gLv7jrrqsnRjAJcQm/J8iXeaIvwRsmfM3GXY
	XTSVDT57ztJNeZs0xlgcH+j9SrfISg210yDxACOGCVNP6pWfBgujYTBVjLqbdgv/6+FFPejs6O6
	Z060nhA==
X-Google-Smtp-Source: AGHT+IEKDfK3mB1Oud35BwI5L0PRyQfm0U+xeis8VT50pizsN9eNp+xwqUl3Ojn1lQWMegDIcvf/M2NcwiQC
X-Received: from vsvd7.prod.google.com ([2002:a05:6102:1487:b0:4b1:11cd:b284])
 (user=bgeffon job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:1629:b0:4af:4ae0:2320
 with SMTP id ada2fe7eead31-4b1291bba89mr1461879137.26.1733866260721; Tue, 10
 Dec 2024 13:31:00 -0800 (PST)
Date: Tue, 10 Dec 2024 16:30:46 -0500
In-Reply-To: <20241210213050.2839638-1-bgeffon@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210213050.2839638-1-bgeffon@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210213050.2839638-2-bgeffon@google.com>
Subject: [RFC PATCH 1/5] mm: mremap: Fix new_addr being used as a hint with MREMAP_DONTUNMAP
From: Brian Geffon <bgeffon@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Marco Vanotti <mvanotti@google.com>, linux-kernel@vger.kernel.org, 
	Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"

Two non-mutually exclusive paths can land in mremap_to, MREMAP_FIXED
and MREMAP_DONTUNMAP which are called from mremap(). In the case of
MREMAP_FIXED we must validate the new_addr to ensure that the new
address is valid. In the case of MREMAP_DONTUNMAP without MREMAP_FIXED
a new address is specified as a hint, just like it would be in the
case of mmap. In this second case we don't need to perform any checks
because get_unmapped_area() will align new_addr, just like it would in
the case of mmap.

This patch only fixes the behavior that was inadvertently added
with MREMAP_DONTUNMAP.

v2:
  - Addressed comment from Marco Vanotti to consolidate these checks
    into existing MREMAP_FIXED blocks.

Signed-off-by: Brian Geffon <bgeffon@google.com>
Reported-by: Marco Vanotti <mvanotti@google.com>
---
 mm/mremap.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 60473413836b..62aec72bbe42 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -912,16 +912,6 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	unsigned long ret;
 	unsigned long map_flags = 0;
 
-	if (offset_in_page(new_addr))
-		return -EINVAL;
-
-	if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
-		return -EINVAL;
-
-	/* Ensure the old/new locations do not overlap */
-	if (addr + old_len > new_addr && new_addr + new_len > addr)
-		return -EINVAL;
-
 	/*
 	 * move_vma() need us to stay 4 maps below the threshold, otherwise
 	 * it will bail out at the very beginning.
@@ -940,6 +930,25 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 		return -ENOMEM;
 
 	if (flags & MREMAP_FIXED) {
+		/*
+		 * Two non-mutually exclusive paths can land in mremap_to, MREMAP_FIXED
+		 * and MREMAP_DONTUNMAP which are called from mremap(). In the case of
+		 * MREMAP_FIXED we must validate the new_addr to ensure that the new
+		 * address is valid. In the case of MREMAP_DONTUNMAP without MREMAP_FIXED
+		 * a new address is specified as a hint, just like it would be in the
+		 * case of mmap. In this second case we don't need to perform any checks
+		 * because get_unmapped_area() will align new_addr, just like it would in
+		 * the case of mmap.
+		 */
+		if (offset_in_page(new_addr))
+			return -EINVAL;
+
+		if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
+			return -EINVAL;
+
+		/* Ensure the old/new locations do not overlap */
+		if (addr + old_len > new_addr && new_addr + new_len > addr)
+			return -EINVAL;
 		/*
 		 * In mremap_to().
 		 * VMA is moved to dst address, and munmap dst first.
-- 
2.47.0.338.g60cca15819-goog


