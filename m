Return-Path: <linux-kernel+bounces-206863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026DA900F03
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 02:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C852844F7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA106125;
	Sat,  8 Jun 2024 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGnrWb/V"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0A53233
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717807908; cv=none; b=OY7GkVNfiLay0nyDvkuLrQFH5czrQR4FvmvP4diOktA6liYbCMKvTkbY031HvrBfLH33jHcz9AK/9IGIc1Jx+TGN5gj+VeNwqSIVZFrfu3G5g4lXyfW5+qmRKK3SeiwPwonXnVzILwWm9rm6gfW3HC+OoMYhsp9/OxNBLwcJ08s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717807908; c=relaxed/simple;
	bh=Xpu0TVdYt8IpgyfcyM8eBR3e+Lim84wZBPFs4RaabSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzogoOSIxzQuhXpMYX5KxnlqLnHbjy/zPjac6zN/a5+6HX39iLK59kUEpjQajCG+bdb56HH/7cM02vO0BTpgMvLjs1efHJ495cGBmDSd32LKeT+sKrqhotS7OxRdX2BkOaPMgQOW9hssi/VzkW9WShfzT1GiQ/WdQU56VqkQPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGnrWb/V; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a68bf84d747so260664366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 17:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717807905; x=1718412705; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKmEYYbLN6RZt0gVgrc1uNmBvZwEN49C/Juti4dcLvY=;
        b=EGnrWb/V4544W3QbThGepQK4c1Re0FWTkkfbnqhGD6OwMVrXW6cfM2PrmT4FTV5X6c
         8euBije/injFQAH3YdoZUXPYTrKkN+D/f5GKQc41uEGkfWFZhNevVP8LUPDLvYIdXZaE
         V+OhV8+AbTYRhpjg850VlvfzZPRqtXkFq9IJ1pshPzv62N0ES5Bnz1DyfDUCUb4TvSBu
         EJ4Aat0094Gs97WC3h0TSq5i++ME4fdkZHif7XfBiQ8G49OBSgD5I0sjg95prZWfFm/W
         juLOKfjY9N2wx9uPQYMOB1Jybn4ky0hFfd0tLzMJk2j40lHyvEMtJl6begdkbZPtWfSY
         6XbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717807905; x=1718412705;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GKmEYYbLN6RZt0gVgrc1uNmBvZwEN49C/Juti4dcLvY=;
        b=Q5S5RNLXLRxTnO8JW2m+vp4kVfVkX+8yA8tve1N+Nta+CYODjSaWfU92t/RwBtWQgu
         Lj6uwNs/Pds/ehjxdDi+mDIUYS14r0ffx81+no0IELAD1mysWMbKNr4Fm+6JtkgKZ5Dn
         7UTxLmgmYVUUNYmOM5Zr0P3HgKelrm8Ady419wLUvEA5h2kkD04TNcWFRYtx6qX/glHQ
         GTXFWqA0P3oKwkv56CRwscW4v9NkNnzSuqAHDJRkuZLOmJenwVPlfYsRDkGZI1voYkbm
         QcLw+hJyTWa89txSGdSBTyGZQ2Ma0w+j4egZClwGu6sAXsg/VLfYCGsGIdWOCpbXpkke
         FKOA==
X-Gm-Message-State: AOJu0YzelCa0obsiyO0lHcefnQMg1oEzuWkDjP9veMNYm2HTxQ5jcpxW
	KhkaT9J3kCT4cp7r99DtpAz/Nd7kKrZqzDrQz2/nOARJm9jBAVQ1
X-Google-Smtp-Source: AGHT+IFFEYhn95X5wlp0yvy/g7BNLOY7hnRErafTSEW36dxiClkkU80brBOdzArkxY2Ye0XwiTQFZw==
X-Received: by 2002:a17:906:3610:b0:a69:7d72:b0d6 with SMTP id a640c23a62f3a-a6cdbef7773mr244615066b.71.1717807905171;
        Fri, 07 Jun 2024 17:51:45 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805ccb1csm317710066b.80.2024.06.07.17.51.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2024 17:51:44 -0700 (PDT)
Date: Sat, 8 Jun 2024 00:51:44 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 2/2] mm/highmem: make nr_free_highpages() return
 "unsigned long"
Message-ID: <20240608005144.ypbq4442bh46tmqb@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240607083711.62833-1-david@redhat.com>
 <20240607083711.62833-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607083711.62833-3-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Jun 07, 2024 at 10:37:11AM +0200, David Hildenbrand wrote:
>It looks rather weird that totalhigh_pages() returns an
>"unsigned long" but nr_free_highpages() returns an "unsigned int".
>
>Let's return an "unsigned long" from nr_free_highpages() to be
>consistent.
>
>While at it, use a plain "0" instead of a "0UL" in the !CONFIG_HIGHMEM
>totalhigh_pages() implementation, to make these look alike as well.

I am not sure why not use 0UL for both?

>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> include/linux/highmem-internal.h | 8 ++++----
> include/linux/highmem.h          | 2 +-
> mm/highmem.c                     | 4 ++--
> 3 files changed, 7 insertions(+), 7 deletions(-)
>
>diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
>index 65f865fbbac04..dd100e849f5e0 100644
>--- a/include/linux/highmem-internal.h
>+++ b/include/linux/highmem-internal.h
>@@ -131,10 +131,10 @@ static inline void __kunmap_atomic(const void *addr)
> 		preempt_enable();
> }
> 
>-unsigned int __nr_free_highpages(void);
>+unsigned long __nr_free_highpages(void);
> unsigned long __totalhigh_pages(void);
> 
>-static inline unsigned int nr_free_highpages(void)
>+static inline unsigned long nr_free_highpages(void)
> {
> 	return __nr_free_highpages();
> }
>@@ -234,8 +234,8 @@ static inline void __kunmap_atomic(const void *addr)
> 		preempt_enable();
> }
> 
>-static inline unsigned int nr_free_highpages(void) { return 0; }
>-static inline unsigned long totalhigh_pages(void) { return 0UL; }
>+static inline unsigned long nr_free_highpages(void) { return 0; }
>+static inline unsigned long totalhigh_pages(void) { return 0; }
> 
> static inline bool is_kmap_addr(const void *x)
> {
>diff --git a/include/linux/highmem.h b/include/linux/highmem.h
>index 6b0d6f3c8580c..930a591b9b616 100644
>--- a/include/linux/highmem.h
>+++ b/include/linux/highmem.h
>@@ -179,7 +179,7 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
> static inline void *kmap_atomic(struct page *page);
> 
> /* Highmem related interfaces for management code */
>-static inline unsigned int nr_free_highpages(void);
>+static inline unsigned long nr_free_highpages(void);
> static inline unsigned long totalhigh_pages(void);
> 
> #ifndef ARCH_HAS_FLUSH_ANON_PAGE
>diff --git a/mm/highmem.c b/mm/highmem.c
>index 3c4e9f8c26dcd..1ece1e69031e7 100644
>--- a/mm/highmem.c
>+++ b/mm/highmem.c
>@@ -111,10 +111,10 @@ static inline wait_queue_head_t *get_pkmap_wait_queue_head(unsigned int color)
> }
> #endif
> 
>-unsigned int __nr_free_highpages(void)
>+unsigned long __nr_free_highpages(void)
> {
>+	unsigned long pages = 0;
> 	struct zone *zone;
>-	unsigned int pages = 0;
> 
> 	for_each_populated_zone(zone) {
> 		if (is_highmem(zone))
>-- 
>2.45.1

-- 
Wei Yang
Help you, Help me

