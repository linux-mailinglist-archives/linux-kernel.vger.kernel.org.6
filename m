Return-Path: <linux-kernel+bounces-324000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D2C9746A2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A95E1C21FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1731BB6A0;
	Tue, 10 Sep 2024 23:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dw+mGHtC"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30651BA87B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011890; cv=none; b=p79K5mgvTrsM/iPr+nnIopa1P7MmZZ/yfSVkpGDoE9buGm/78BgYb9gO8xI62f5In64R+tryeBUop/Vr1LyK3QCflogx6nl+Sv6nnJIr46MojCJVsoujQwtzk2ZIaFG2Kk+1pf1qECL3IxReYNv9uRmXUcavlAtLB645RJPRnOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011890; c=relaxed/simple;
	bh=vKn6pjIRFyRt8Opg+2dj1UETcidGMMZpXY2Tm+1+Wnk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ux7qo+YNPn/NxzPY1cbPaihI34Tv1H+9ghlCTqyDathissR4Qv3rtAk2IRpsyUOk9MYBLd03uA8HxWx+BBWVartkqlpDsg+juwxJiyRpbt0c/HzAay9jzfZnqKDnluUwUKf12h8CVZasPC3sw9N732op9R4HkmpshcqU63+iNxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dw+mGHtC; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1d46cee0b0so7046988276.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011888; x=1726616688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wON4ebge/JtWXTatH36Oz8RnYdWXk0aZ0I0s+pE884Y=;
        b=dw+mGHtCedFwjPpV2akhGZwfEIzo4Q+I/jMx0YlaJ94gpmUFT4uSefXAEesPERKn2w
         yB1GdmTrvwkbEiReBiwyVjmWhWGmWJbn0RggjTfVJEczO95G/vBJF/EmZEp0OoKvwQeW
         J0NKem+YA19uMgUWNiz4AiekLupwvfGMVCNCj8ZMgP2+sfXteu5JofGJCGl3+eNA5cwz
         G6CByNX3QNzKBwsB0rcf11MW5eg4YGRBgcw2NRWFRn9VIqUDTo4aTraEGr8ySvrXUfsh
         amdnmlrpkoBhbwWVtZ7KU4ytNIAHJav0NY6+vzyGad+gO+/LiuD1znHVvZCTIfIwuX15
         esfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011888; x=1726616688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wON4ebge/JtWXTatH36Oz8RnYdWXk0aZ0I0s+pE884Y=;
        b=tUtcBbbzsLA0tLator6UHAAO1Cki3mUrcBkzeFbTtKkwP1IaD5ZFR4zY4FxmtNssW5
         G72qA51NImFq46RnIdmK3tKNtL7qboEiSS1goOxJMIDpMCIS0sFBIJLSYC9n1UeHnZ+o
         SmWk62wEtB8yPtSeU+41fC4gCLG73t6y3Ln335rEkPrGg5Ug4uhU8D3MlWpTduJqqhgi
         urVoxoKoSw/IcVYNG34gjknth/kLdAd5eZY54qcqJ/hE3r1yQquZ1H+myaaCJMM+QhpF
         wTkh/e6xedayqcRygjQdWsZO9tx68noG1X5ghj9xmN6/DCZwylywTCU247jvbNGM87ku
         Gn2g==
X-Forwarded-Encrypted: i=1; AJvYcCUxOrwYz5YOOuWfHPWJkX3kYv6+icJZj1FCNRDDvxfyIV0bo3E9WaFT3DUHyLvH8a6GkAD03PWLoYNgKm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWiHlGdzcvorYnQTHJie6bCGFYvyir1OLSdwt52q+usoMGFr7Q
	llX35/0WoxyYB7r5t3MDgeBtPLRbDBKyuNPxYSWxO/a1TC9jjemepY29UdhKwq5NCkK1McktHow
	xE32YLrrLar0K+LRt7/1O5A==
X-Google-Smtp-Source: AGHT+IGifFJzomPV42kuvxwSOW6D8KRl1ZUZcLgu/9vMTp3RDdNsVY265K9HmTBfWg/leXDMNAyCn73aN71Ukp8ufA==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:d347:0:b0:e16:51f9:59da with SMTP
 id 3f1490d57ef6-e1d349e2dd5mr43068276.6.1726011887733; Tue, 10 Sep 2024
 16:44:47 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:40 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <f8dd00f4bcc4328d440b77bc2ea2c1b75370dd58.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 09/39] mm: hugetlb: Expose hugetlb_subpool_{get,put}_pages()
From: Ackerley Tng <ackerleytng@google.com>
To: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, ackerleytng@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

This will allow hugetlb subpools to be used by guest_memfd.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/hugetlb.h | 3 +++
 mm/hugetlb.c            | 6 ++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e4a05a421623..907cfbbd9e24 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -119,6 +119,9 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
 						long min_hpages);
 void hugepage_put_subpool(struct hugepage_subpool *spool);
 
+long hugepage_subpool_get_pages(struct hugepage_subpool *spool, long delta);
+long hugepage_subpool_put_pages(struct hugepage_subpool *spool, long delta);
+
 void hugetlb_dup_vma_private(struct vm_area_struct *vma);
 void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
 int move_hugetlb_page_tables(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7e73ebcc0f26..808915108126 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -170,8 +170,7 @@ void hugepage_put_subpool(struct hugepage_subpool *spool)
  * only be different than the passed value (delta) in the case where
  * a subpool minimum size must be maintained.
  */
-static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
-				      long delta)
+long hugepage_subpool_get_pages(struct hugepage_subpool *spool, long delta)
 {
 	long ret = delta;
 
@@ -215,8 +214,7 @@ static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
  * The return value may only be different than the passed value (delta)
  * in the case where a subpool minimum size must be maintained.
  */
-static long hugepage_subpool_put_pages(struct hugepage_subpool *spool,
-				       long delta)
+long hugepage_subpool_put_pages(struct hugepage_subpool *spool, long delta)
 {
 	long ret = delta;
 	unsigned long flags;
-- 
2.46.0.598.g6f2099f65c-goog


