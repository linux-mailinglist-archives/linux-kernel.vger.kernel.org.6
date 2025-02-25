Return-Path: <linux-kernel+bounces-532529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCFFA44EF6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281EF3B1A2C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C211A4E98;
	Tue, 25 Feb 2025 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gfz5dt/B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81150213E87
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519132; cv=none; b=VaQLXTKgBrD8NJ4LBXTfBOW+OIdYIZeuhoXMAOHqLjLObcr+Yacqo8BzFmvRNa8x7UXy+KcinEgii+DZIO4GL5jlJ5n/hUPQGGhmxI0fW/29E7yXaw41YT9GtvOm5i7/6UASvN2hiee+sgY5mA+ZEKQNyOAbI5BdbZyVIb3qAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519132; c=relaxed/simple;
	bh=li+g/mmpE9Z+cfg0Zg5848p/bQTPJXln/+EAGmXR1PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fK9Behg/e2fP4vVhj6JcpHdpvcikRJaUc80A64wn/l3s6S7FI3rbwhcF36ppJZIvY3fbRvWBAWrh6B4O5QWaUtPdSLAPROogM133Dc88HSrGIt892YxfCDQD27zuV+F8muidO23qLyEjjGU3WRnBRr911lXD28S/FiJgDBpq3Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gfz5dt/B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740519129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JPm4MkJNuyAcesE/fA8MzWK9oiSIKGTrlxcF5Yd8m0s=;
	b=Gfz5dt/Ba3hVzUCvCUX31hf5g/MRuV4Maw+Pvzcd4MjkqFxh3/PX1X9wupKYhzWCXywcgI
	CGCBlx9sk8+mCouLx+7JHJVQvvKgWuWADfb3GaHIPpjIgpgFPdwcqDd0GTZjt9+ro+YMDv
	7zgd7dyfo8PuPjrM2YEEe1AF6tSnFu0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-auuDL8Q1MD-wDak_nj79PA-1; Tue, 25 Feb 2025 16:32:08 -0500
X-MC-Unique: auuDL8Q1MD-wDak_nj79PA-1
X-Mimecast-MFC-AGG-ID: auuDL8Q1MD-wDak_nj79PA_1740519127
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0ade6095bso1092471885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740519127; x=1741123927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPm4MkJNuyAcesE/fA8MzWK9oiSIKGTrlxcF5Yd8m0s=;
        b=rfjLGJu6ZcawEv+Zfp9Jknm/MMvjWnZv7ut7QaGIaNnYZ3LcZ6SNsu1ycc/bxmzRC1
         IUfBFBAv1wMQa8mqM830y+KEe7AbDkKbWPZmoUKScJpOaWd4/4rIvP+Jcx6PwGcqkMHn
         OPyiKTYfvZIZh3g4m0/n3phap5gJHIdh+1hDhCuPTDfcvr1kIgEv+z6b+1leKzGlNa3K
         pU7KUZ/jS7lMrtw8WzqTbJPTpA0ntD7pDOLnsVlXjr+pOhDU15hz+RhefYCmaQsxmYIx
         uxtSsuEfSIApg0nvcXoiQQNxjD5SNYZM6oYzDLPlMHWpjyS/5fYVIOgWt5tWnEf+6Si8
         ez4g==
X-Forwarded-Encrypted: i=1; AJvYcCXQJB59z3u89L/CuTxk7hitNCvKRxrAX2hWArn4DKqp1zTi3nLOlRyA82/Y051luRvcMPRAmxCv20Og9Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNoAn1JcO5MloPbIlBqzNuLB/CiXipT65BkQp5J4ykG3vIrahw
	hmfVSPQq3UCQ7+iHunMeqcIPY5UzuXg5li1Rl1ac5B/EhfXPq+4lazsHsV8QXh9Gcs/Q/sx+S0Q
	Wjji/pJUyJjyRp86Tmb6KDQxJIO+23anrZyewVqAjBG4Xs36kU5qxUaFSai16HA==
X-Gm-Gg: ASbGnculzj8yhBS6l3MqS1CJx9v+mdWoY4rMeXXasm+OcmJzexv2I2b06Cm/+XLq0z5
	cs8ZE5396Ad/EANEQnrX83+CGU8S6yXlgZf8C+Zj6rXu0ItM1YJTlTZHfWmV8WuYwUfGkCMtLTc
	8vs2yrTw5ZshgbEK8/P9fX2FrJ1Qobr0roHcF1FTLHGpDc+J6zYg/+bWyhXDbS7YTAcyj86r1do
	R1YWxwTYjEOmM8uEguYWDy+NsUlnHqsMsq4CnbD218IEf7pW+yemS28LzT+GMNrZGTPQw==
X-Received: by 2002:a05:620a:40c1:b0:7c0:abe0:ce4b with SMTP id af79cd13be357-7c247efcb22mr153620585a.12.1740519127631;
        Tue, 25 Feb 2025 13:32:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEy1G5ZQ5qaqa3S8e95ScSceHmfp+x9BMsy0EsZrltR4KBLBIK8l1gnOWF3g5A7O3cTRRe+Bw==
X-Received: by 2002:a05:620a:40c1:b0:7c0:abe0:ce4b with SMTP id af79cd13be357-7c247efcb22mr153617685a.12.1740519127350;
        Tue, 25 Feb 2025 13:32:07 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c3271e2sm155457385a.88.2025.02.25.13.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 13:32:06 -0800 (PST)
Date: Tue, 25 Feb 2025 16:32:01 -0500
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, lokeshgidra@google.com, aarcange@redhat.com,
	21cnbao@gmail.com, v-songbaohua@oppo.com, david@redhat.com,
	willy@infradead.org, Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com, hughd@google.com, jannh@google.com,
	kaleshsingh@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] userfaultfd: do not block on locking a large folio
 with raised refcount
Message-ID: <Z7420bbHoz3y73xh@x1.local>
References: <20250225204613.2316092-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225204613.2316092-1-surenb@google.com>

On Tue, Feb 25, 2025 at 12:46:13PM -0800, Suren Baghdasaryan wrote:
> Lokesh recently raised an issue about UFFDIO_MOVE getting into a deadlock
> state when it goes into split_folio() with raised folio refcount.
> split_folio() expects the reference count to be exactly
> mapcount + num_pages_in_folio + 1 (see can_split_folio()) and fails with
> EAGAIN otherwise. If multiple processes are trying to move the same
> large folio, they raise the refcount (all tasks succeed in that) then
> one of them succeeds in locking the folio, while others will block in
> folio_lock() while keeping the refcount raised. The winner of this
> race will proceed with calling split_folio() and will fail returning
> EAGAIN to the caller and unlocking the folio. The next competing process
> will get the folio locked and will go through the same flow. In the
> meantime the original winner will be retried and will block in
> folio_lock(), getting into the queue of waiting processes only to repeat
> the same path. All this results in a livelock.
> An easy fix would be to avoid waiting for the folio lock while holding
> folio refcount, similar to madvise_free_huge_pmd() where folio lock is
> acquired before raising the folio refcount.
> Modify move_pages_pte() to try locking the folio first and if that fails
> and the folio is large then return EAGAIN without touching the folio
> refcount. If the folio is single-page then split_folio() is not called,
> so we don't have this issue.
> Lokesh has a reproducer [1] and I verified that this change fixes the
> issue.
> 
> [1] https://github.com/lokeshgidra/uffd_move_ioctl_deadlock
> 
> Reported-by: Lokesh Gidra <lokeshgidra@google.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

One question irrelevant of this change below..

> ---
>  mm/userfaultfd.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 867898c4e30b..f17f8290c523 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1236,6 +1236,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>  		 */
>  		if (!src_folio) {
>  			struct folio *folio;
> +			bool locked;
>  
>  			/*
>  			 * Pin the page while holding the lock to be sure the
> @@ -1255,12 +1256,26 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>  				goto out;
>  			}
>  
> +			locked = folio_trylock(folio);
> +			/*
> +			 * We avoid waiting for folio lock with a raised refcount
> +			 * for large folios because extra refcounts will result in
> +			 * split_folio() failing later and retrying. If multiple
> +			 * tasks are trying to move a large folio we can end
> +			 * livelocking.
> +			 */
> +			if (!locked && folio_test_large(folio)) {
> +				spin_unlock(src_ptl);
> +				err = -EAGAIN;
> +				goto out;
> +			}
> +
>  			folio_get(folio);
>  			src_folio = folio;
>  			src_folio_pte = orig_src_pte;
>  			spin_unlock(src_ptl);
>  
> -			if (!folio_trylock(src_folio)) {
> +			if (!locked) {
>  				pte_unmap(&orig_src_pte);
>  				pte_unmap(&orig_dst_pte);

.. just notice this.  Are these problematic?  I mean, orig_*_pte are stack
variables, afaict.  I'd expect these things blow on HIGHPTE..

>  				src_pte = dst_pte = NULL;
> 
> base-commit: 801d47bd96ce22acd43809bc09e004679f707c39
> -- 
> 2.48.1.658.g4767266eb4-goog
> 

-- 
Peter Xu


