Return-Path: <linux-kernel+bounces-296774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D96A495AF0C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96902287304
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35EA187FEE;
	Thu, 22 Aug 2024 07:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Gay50H9m"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A6187877
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310882; cv=none; b=Jmcu2YxaMMvMKQhtOj8vsEJcV1CKhFYx+dMr2bdumCqLVi5+xyt02HedvhUr8R3snrVW/KnZPa1Bj2dqRhrVoHF5CHQWs21NV+eqVGjOZmGjwBFucfJhA8I9mY9qPtskGddG8tOBGe/0ZByIxV9erini48PCYTtvGksG7Y26aUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310882; c=relaxed/simple;
	bh=g7vfX863SYbCR0NBqllFlwtVsFEJGXyQFbet06hRe4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+bDg40Yh+BYvlbo+xKeTs7OcDrAZPAKHj/AFS1taV2QOk3hm/yR5iW4gp2YNKfJzXbzgnTkHHa5+CrOIFgw8wpb7W1xy0bwj4Gw8nanNXa5NyUXGaUiwifc+88nefcgv8hCyw5ZP0VHUBxuj/mBdk9H4WAAxQy22gB6Y9MEtEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Gay50H9m; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db1eb76702so323966b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724310879; x=1724915679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCwbwV/YmKb9rcRCZPyi2vEyGZwxl6QKnoBllHH347k=;
        b=Gay50H9mT8GjjGyVsbWP8oRTPvazyrfrkHQNLggD4tWJAvcUx8EpIEHbIZi+lsqMly
         uS2nxE0KEDluiuTMnycVI8DdwCcdSRT9UgKN/kr7lSOMldmvFlFMziR82qNIl6Z+3mV8
         7jEkE/PG8OPuv9bmcmDvGsufFxPGO6R5WYUfLUglLyKPOpb8+X97KW+GiP5p9RYBqYJK
         ipWWXyxJuRLvGuMMb2V2YY3xOH48bCSVnCIsistevtzzCYpfspf2ZW5LLy6conJu8dMU
         k8p7SHIMbZpiYhYMiJ8QQtUPU70/Uyaf/Ui+qRkb3GPbkYLDfbndVGfYBBf1l/CgbMPV
         yaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310879; x=1724915679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCwbwV/YmKb9rcRCZPyi2vEyGZwxl6QKnoBllHH347k=;
        b=AM1loo33rEDHEebWwQXrChFx+PB9NaCHhME1rL8Ni9sxBWgMJ2IiUK6Yc3TD61pSd4
         r0ExUvBxUOVY+NngBzKq/iy8eZ04ILnnU4FKg6OIjLk+LOetgYjcPAbVlaZ2XDl6BkGm
         /gNx0n6GxYTKOFMrU/cL09QKv8scPUHkneRHR6v9RCDfifKzc0u+53toISGJ0bSjOO1L
         yH9c/TMoYGxy+AMG24kLCNhLEre+HOFKjwGC3C54D5mGvViZxl/zmO2APrbpxoTMRb0X
         ugvq47W1yIUAEofkdY2na4TZvvSHXbyWSdqQ/5eUHTKU7pOvJvkDDTi2kn4ryC49/CFR
         HJaQ==
X-Gm-Message-State: AOJu0Ywc/IJbda/u09DPgzPQ9/A01Esan0zih1bVHhKaTT0M2knBy5Cy
	NDiZdQ2yhPjljCD2SA9TEa0AWSsYNs24aTGub3qw4xxLKiQuyhXssZTbfWkYPfL2ZUEwI/tWa4i
	FQuk=
X-Google-Smtp-Source: AGHT+IFsTn+Q5A1WOhbyPTAjHclYiOvt3nhLZV/Hi5KOu9NOtbxQa/3JykhMvHE3PrFxCVBhO2k7lw==
X-Received: by 2002:a05:6871:149:b0:268:afc3:648e with SMTP id 586e51a60fabf-273cffcb557mr1073020fac.42.1724310879532;
        Thu, 22 Aug 2024 00:14:39 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([240e:473:c90:f96:d029:ea8a:4e6d:d272])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm695095a12.16.2024.08.22.00.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:14:39 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	vishal.moola@gmail.com,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 09/14] mm: mremap: move_ptes() use pte_offset_map_rw_nolock()
Date: Thu, 22 Aug 2024 15:13:24 +0800
Message-Id: <12097a187fee5f21860d4f87e7aa103f822e298e.1724310149.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724310149.git.zhengqi.arch@bytedance.com>
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In move_ptes(), we may modify the new_pte after acquiring the new_ptl, so
convert it to using pte_offset_map_rw_nolock(). But since we already hold
the exclusive mmap_lock, there is no need to get pmdval to do pmd_same()
check, just pass a dummy variable to it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/mremap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 24712f8dbb6b5..f96b025c09079 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -143,6 +143,7 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	spinlock_t *old_ptl, *new_ptl;
 	bool force_flush = false;
 	unsigned long len = old_end - old_addr;
+	pmd_t dummy_pmdval;
 	int err = 0;
 
 	/*
@@ -175,7 +176,13 @@ static int move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		err = -EAGAIN;
 		goto out;
 	}
-	new_pte = pte_offset_map_nolock(mm, new_pmd, new_addr, &new_ptl);
+	/*
+	 * Use the maywrite version to indicate that new_pte will be modified,
+	 * but since we hold the exclusive mmap_lock, there is no need to
+	 * recheck pmd_same() after acquiring the new_ptl.
+	 */
+	new_pte = pte_offset_map_rw_nolock(mm, new_pmd, new_addr, &dummy_pmdval,
+					   &new_ptl);
 	if (!new_pte) {
 		pte_unmap_unlock(old_pte, old_ptl);
 		err = -EAGAIN;
-- 
2.20.1


