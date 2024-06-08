Return-Path: <linux-kernel+bounces-206862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB224900F02
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 02:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0C41F22373
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3A56125;
	Sat,  8 Jun 2024 00:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG0R0nT0"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8CF17C8
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 00:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717807692; cv=none; b=A82BHyYQfVQOIGkhY7wjK6//xcAszDK2hVCfveq+BBw0zoAQMv4aShiJ1TUCgoLj/NQ94173JaCcdeJblohDfIi5265xPHe3OLF032ax0bUTPSViYk0FByQyRQvulpf5CX4TrxSvKjZdowsKip40oAwy/iZSjd+M9y1+KkxV/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717807692; c=relaxed/simple;
	bh=NSkc49Onqy2tr71FEloI4qlRyzZEmp77JkoBbXc+lUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBqjAD0p1Q+O9gBkF6QpduCWyM8wkR6J+1Z3onI5BrBrkOgzdrN3wRL5Gcrzu6hQN7EwlzGowOfK941aGtJ95boxYBiN4XEc6//l49HPzdoeVOJ15UddWBspJh5dWcvyJxFqbW7elh9amoL+48MrL39rjccj/Xua4l1x6agHp5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HG0R0nT0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso3501709a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 17:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717807689; x=1718412489; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZclPfKbJOXFHX4eNEjcs6y6LlWAX+uot7YacNhsz1I=;
        b=HG0R0nT0xqW0P7Wl2n9+BIIRGBWA0CfaODI82Tz5uZOHwAxHUODnfaK2HRt4fFCEzf
         HkLQfaoDNjuPerBGE2p9DYZE/0fdT88l6j4mkm3M1B6UB5VCvDXWPSWD4cQPI0BQhX8E
         C9qsKPPwNljuFXHYzlkuJcLd1CNiWcOV+xvNUjf9OJXbVNSpH6cuoHnD8CY5J0RHHE7Y
         oMeY4FotYYxv2AzQAq0nsiF0hsgblcrIPCa2eJjdJ6gciZFXSR8IYHg+vUnre6cXtQ2F
         IRPuItO3KFNlrGk4fEF/hCJ4wAIEFU6UHWRRashtJorfT1Hybm8NWQZKzJIFwE6ECOqP
         vfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717807689; x=1718412489;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ZclPfKbJOXFHX4eNEjcs6y6LlWAX+uot7YacNhsz1I=;
        b=dW6Lea5tpuVS6VDfL8+GueyDPkcwdpDmmx79B8ftIO7xkhDBYryYNUN4MCigRBjphC
         ISCVJUWKQdqnsAVfDpUE3V2FbDQGM3ukXSGYFUZOdnXgh1o3xXTXzLL/ck13QrA4QMge
         BNPAwXRLH8HFIjnf11Ir6Lh6KvU9+tq6He/HaZzcdMaLMAyU+M2q6s+c1bEES13ZPCmT
         xv7ghc7nr9mbmhQfMCA9MX/7OJi2/W3svJUcKJrr4yGX9gSqdjNyCl5iaKSGDI3xkLDD
         Zgl7JjUUciWD2I2mhH9i8u/LcFkvgzpY32KTaKNhgeLgkWRv1CR/HMKHu8QiXqdoijW1
         pw2g==
X-Gm-Message-State: AOJu0YymAPu3bzqoBpkP1YMiNywZQ00qlUmEsiy1kHtS8Ura7t8LfJPk
	TAZLxUWIAmXWKqMmL3BW4sJJ0aKG4JaYbV7ns+Uuv1hDXywHaEbd
X-Google-Smtp-Source: AGHT+IH0gfd/+frh1rvb/qdnYUlnif0r/zC8iisL7n2FQvT/mEeDVimHRpf1N4z1dLx6EfPIgJd3Xg==
X-Received: by 2002:a50:cdc2:0:b0:574:ebf4:f786 with SMTP id 4fb4d7f45d1cf-57c4e3f5be7mr3340803a12.16.1717807688962;
        Fri, 07 Jun 2024 17:48:08 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae2340f6sm3533008a12.90.2024.06.07.17.48.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2024 17:48:08 -0700 (PDT)
Date: Sat, 8 Jun 2024 00:48:07 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 1/2] mm/highmem: reimplement totalhigh_pages() by
 walking zones
Message-ID: <20240608004807.3t6pnjvut3vmp23m@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240607083711.62833-1-david@redhat.com>
 <20240607083711.62833-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607083711.62833-2-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Jun 07, 2024 at 10:37:10AM +0200, David Hildenbrand wrote:
>Can we get rid of the highmem ifdef in adjust_managed_page_count()?
>Likely yes: we don't have that many totalhigh_pages() users, and they
>all don't seem to be very performance critical.
>
>So let's implement totalhigh_pages() like nr_free_highpages(),
>collecting information from all zones. This is now similar to what we do
>in si_meminfo_node() to collect the per-node highmem page count.
>
>In the common case (single node, 3-4 zones), we really shouldn't care.
>We could optimize a bit further (only walk ZONE_HIGHMEM and ZONE_MOVABLE
>if required), but there doesn't seem a real need for that.
>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
>---
> include/linux/highmem-internal.h |  9 ++-------
> mm/highmem.c                     | 16 +++++++++++++---
> mm/page_alloc.c                  |  4 ----
> 3 files changed, 15 insertions(+), 14 deletions(-)
>
>diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
>index a3028e400a9c6..65f865fbbac04 100644
>--- a/include/linux/highmem-internal.h
>+++ b/include/linux/highmem-internal.h
>@@ -132,7 +132,7 @@ static inline void __kunmap_atomic(const void *addr)
> }
> 
> unsigned int __nr_free_highpages(void);
>-extern atomic_long_t _totalhigh_pages;
>+unsigned long __totalhigh_pages(void);
> 
> static inline unsigned int nr_free_highpages(void)
> {
>@@ -141,12 +141,7 @@ static inline unsigned int nr_free_highpages(void)
> 
> static inline unsigned long totalhigh_pages(void)
> {
>-	return (unsigned long)atomic_long_read(&_totalhigh_pages);
>-}
>-
>-static inline void totalhigh_pages_add(long count)
>-{
>-	atomic_long_add(count, &_totalhigh_pages);
>+	return __totalhigh_pages();
> }
> 
> static inline bool is_kmap_addr(const void *x)
>diff --git a/mm/highmem.c b/mm/highmem.c
>index bd48ba445dd41..3c4e9f8c26dcd 100644
>--- a/mm/highmem.c
>+++ b/mm/highmem.c
>@@ -111,9 +111,6 @@ static inline wait_queue_head_t *get_pkmap_wait_queue_head(unsigned int color)
> }
> #endif
> 
>-atomic_long_t _totalhigh_pages __read_mostly;
>-EXPORT_SYMBOL(_totalhigh_pages);
>-
> unsigned int __nr_free_highpages(void)
> {
> 	struct zone *zone;
>@@ -127,6 +124,19 @@ unsigned int __nr_free_highpages(void)
> 	return pages;
> }
> 
>+unsigned long __totalhigh_pages(void)
>+{
>+	unsigned long pages = 0;
>+	struct zone *zone;
>+
>+	for_each_populated_zone(zone) {
>+		if (is_highmem(zone))
>+			pages += zone_managed_pages(zone);
>+	}
>+
>+	return pages;
>+}
>+
> static int pkmap_count[LAST_PKMAP];
> static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(kmap_lock);
> 
>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>index fc98082a9cf9c..2224965ada468 100644
>--- a/mm/page_alloc.c
>+++ b/mm/page_alloc.c
>@@ -5794,10 +5794,6 @@ void adjust_managed_page_count(struct page *page, long count)
> {
> 	atomic_long_add(count, &page_zone(page)->managed_pages);
> 	totalram_pages_add(count);
>-#ifdef CONFIG_HIGHMEM
>-	if (PageHighMem(page))
>-		totalhigh_pages_add(count);
>-#endif
> }
> EXPORT_SYMBOL(adjust_managed_page_count);
> 
>-- 
>2.45.1

-- 
Wei Yang
Help you, Help me

