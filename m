Return-Path: <linux-kernel+bounces-532664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DD1A4507B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FE33ABFDA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79372230D0F;
	Tue, 25 Feb 2025 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWiTqVGq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40B8204F9B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523730; cv=none; b=d5VbFfH9YQFdggWcjOpQBdEm2cpNlqsGcvKHE11fB9BnatXE7/AJi9Hoq+/nUBeRrVdr7oFynyVkUMEvFRPGYt3IE1c1y7MHhLNxRRGi6f//a6KJo6tY5Mdd3ToNIO8Qaa34Ro8xANUc+ZsoSZWTMI/DZ/0xxieMhAgU8r/0Dx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523730; c=relaxed/simple;
	bh=SROdnK/ZiRoVcJIS6wLXsIZQl1DVurf0XQ5n7WzpUPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7pa/8SdsAcw6wiwGlCspv866LWfkloHC4TlbYK3y4CjOFaiQ/JRJOVZAde9AnVAyT3HLPjoDi0sxShiu+iYt7iwmN46OPhMGO2vGxA1A5kb1vwC2p9S6G64GPaKlz7tqwb925ogizGPZEj4ZvaSe47BejqiAVwoxvG1jlDsVAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWiTqVGq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740523727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9USmteYBOsJlbnz2c74ZK2ivD7zFdGWY3i53bXovAE=;
	b=gWiTqVGqjodaUGaZpAQsPcxgzjJD6f9DWPWU5f9StYxZ3fdny3xsvYrzbULo75oxtdF5WP
	V8pf0kcNZRGPXpFyrl/VQDgreiCKtMp7m2cNMJrCslB6FkQR2x1kPH0wJXuQoQ8jBPJjaB
	KPin0hZtpOdSv7ku9z15ropdFudHqbo=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-7daGC1jIMZaXucOjMgQotA-1; Tue, 25 Feb 2025 17:48:46 -0500
X-MC-Unique: 7daGC1jIMZaXucOjMgQotA-1
X-Mimecast-MFC-AGG-ID: 7daGC1jIMZaXucOjMgQotA_1740523726
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d2b6d933baso132247455ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740523725; x=1741128525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9USmteYBOsJlbnz2c74ZK2ivD7zFdGWY3i53bXovAE=;
        b=ZmabRXLw1oYQHswdQXUxkncNRQiso6HVY1TemCMNSGqa0/Gi3um+V2NQhnTqqHqZoS
         LRUl5p0ALNl+VN7wJjqw4LXux6rEzFQxj7EYzODRCNLC355cqR/cXUiJvCg2tY9ikO9f
         bvgF+IxuGRyfmZ49aRzYNjtQkVaHrYWM+WIm5PoaOf+UUA8U9yeitT3rdAhCYawLLAHa
         NXNnZCbdJX1pxoA7CQ/yV7mtp0YjsatdVYdNpGSqbA1SH4nu/yzsr7Si352dyPxjXq5w
         vyPwBXJChwU1VfRDC06LOGXzG/q+aRMu2+el+cOeGpFK7WU7NBrlt7sW3NQrugD/ZLHM
         0dIw==
X-Forwarded-Encrypted: i=1; AJvYcCXQeUQXnaoQTphuJDSsMNmK1PPKu4d6pHa5TI4bXQ16/qHGNpCXW+5yFO6UKjYJOxIGuXcLxnTMSb7rLDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZL5iIp0j97Yp7JKjtQ7bPWGVqbJHBEcY17VW8Rn3puVMwR1yX
	8/hRarmKN2W4yWSfeSqGRf1BDD4c36LmFI7t1/s0LFBGkI907assCbx1X9IySw46zuRUUKMmc1o
	xq8gUH1OC2YCuaYmCRB4xa5j0OgKIF8eeKxS65FehB9wXPq6KB4rphmyWtz7/Vg==
X-Gm-Gg: ASbGncspmmafA6qdpDeorZesuyRWHAsFYnDHntP+aVNS/sMNPVSqpwXYPAxLbrDZhrM
	na8EtHN7AkEV5ycjyTYYsMk4GVPOkR5ag/N6KC+RJDqxgzWQd2FlVvFxEfVrrU2tIAxJ+HdRfAo
	sNntEQF1ynzJ3nL02ZE0/1IbJ9R7+l5/Kx2mGihMKJ3pMFp6XkNEF2mWAIy2tEbKSgAS6ZOwODa
	LXemUdOkp/X42oBjxpqvfIbXq2E5p1ft6ENyoc9cDiWl58zNQhIHnlEcvibQNBVqSKeIg==
X-Received: by 2002:a05:6e02:1fec:b0:3d0:239a:c46a with SMTP id e9e14a558f8ab-3d2cae6c31cmr155256655ab.9.1740523725686;
        Tue, 25 Feb 2025 14:48:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQ7EnFgM3wQVUi5kFJpCaifI3VyCXEtwhDnx/oGpR/znVxALQ5e6RThgXAJT1QmJArmFzIlA==
X-Received: by 2002:a05:6e02:1fec:b0:3d0:239a:c46a with SMTP id e9e14a558f8ab-3d2cae6c31cmr155256395ab.9.1740523725319;
        Tue, 25 Feb 2025 14:48:45 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f0475309c9sm609890173.118.2025.02.25.14.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:48:44 -0800 (PST)
Date: Tue, 25 Feb 2025 17:48:39 -0500
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
Message-ID: <Z75Ix6eXr972N5y6@x1.local>
References: <20250225204613.2316092-1-surenb@google.com>
 <Z7420bbHoz3y73xh@x1.local>
 <CAJuCfpGLcxSLNek7bUALKcg8HwF8vd9piaBf+cvjYRhY=xOfrA@mail.gmail.com>
 <CAJuCfpH8-LrNuK8xWHU9kGM7QjYqWBdjy1TKe4DuuPd1s+g11Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpH8-LrNuK8xWHU9kGM7QjYqWBdjy1TKe4DuuPd1s+g11Q@mail.gmail.com>

On Tue, Feb 25, 2025 at 02:21:39PM -0800, Suren Baghdasaryan wrote:
> On Tue, Feb 25, 2025 at 2:12 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Tue, Feb 25, 2025 at 1:32 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Tue, Feb 25, 2025 at 12:46:13PM -0800, Suren Baghdasaryan wrote:
> > > > Lokesh recently raised an issue about UFFDIO_MOVE getting into a deadlock
> > > > state when it goes into split_folio() with raised folio refcount.
> > > > split_folio() expects the reference count to be exactly
> > > > mapcount + num_pages_in_folio + 1 (see can_split_folio()) and fails with
> > > > EAGAIN otherwise. If multiple processes are trying to move the same
> > > > large folio, they raise the refcount (all tasks succeed in that) then
> > > > one of them succeeds in locking the folio, while others will block in
> > > > folio_lock() while keeping the refcount raised. The winner of this
> > > > race will proceed with calling split_folio() and will fail returning
> > > > EAGAIN to the caller and unlocking the folio. The next competing process
> > > > will get the folio locked and will go through the same flow. In the
> > > > meantime the original winner will be retried and will block in
> > > > folio_lock(), getting into the queue of waiting processes only to repeat
> > > > the same path. All this results in a livelock.
> > > > An easy fix would be to avoid waiting for the folio lock while holding
> > > > folio refcount, similar to madvise_free_huge_pmd() where folio lock is
> > > > acquired before raising the folio refcount.
> > > > Modify move_pages_pte() to try locking the folio first and if that fails
> > > > and the folio is large then return EAGAIN without touching the folio
> > > > refcount. If the folio is single-page then split_folio() is not called,
> > > > so we don't have this issue.
> > > > Lokesh has a reproducer [1] and I verified that this change fixes the
> > > > issue.
> > > >
> > > > [1] https://github.com/lokeshgidra/uffd_move_ioctl_deadlock
> > > >
> > > > Reported-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >
> > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > >
> > > One question irrelevant of this change below..
> > >
> > > > ---
> > > >  mm/userfaultfd.c | 17 ++++++++++++++++-
> > > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > > index 867898c4e30b..f17f8290c523 100644
> > > > --- a/mm/userfaultfd.c
> > > > +++ b/mm/userfaultfd.c
> > > > @@ -1236,6 +1236,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
> > > >                */
> > > >               if (!src_folio) {
> > > >                       struct folio *folio;
> > > > +                     bool locked;
> > > >
> > > >                       /*
> > > >                        * Pin the page while holding the lock to be sure the
> > > > @@ -1255,12 +1256,26 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
> > > >                               goto out;
> > > >                       }
> > > >
> > > > +                     locked = folio_trylock(folio);
> > > > +                     /*
> > > > +                      * We avoid waiting for folio lock with a raised refcount
> > > > +                      * for large folios because extra refcounts will result in
> > > > +                      * split_folio() failing later and retrying. If multiple
> > > > +                      * tasks are trying to move a large folio we can end
> > > > +                      * livelocking.
> > > > +                      */
> > > > +                     if (!locked && folio_test_large(folio)) {
> > > > +                             spin_unlock(src_ptl);
> > > > +                             err = -EAGAIN;
> > > > +                             goto out;
> > > > +                     }
> > > > +
> > > >                       folio_get(folio);
> > > >                       src_folio = folio;
> > > >                       src_folio_pte = orig_src_pte;
> > > >                       spin_unlock(src_ptl);
> > > >
> > > > -                     if (!folio_trylock(src_folio)) {
> > > > +                     if (!locked) {
> > > >                               pte_unmap(&orig_src_pte);
> > > >                               pte_unmap(&orig_dst_pte);
> > >
> > > .. just notice this.  Are these problematic?  I mean, orig_*_pte are stack
> > > variables, afaict.  I'd expect these things blow on HIGHPTE..
> >
> > Ugh! Yes, I think so. From a quick look, move_pages_pte() is the only
> > place we have this issue and I don't see a reason for copying src_pte
> > and dst_pte values. I'll spend some more time trying to understand if
> > we really need these local copies.
> 
> Ah, we copy the values to later check if PTEs changed from under us.
> But I see no reason we need to use orig_{src|dst}_pte instead of
> {src|dst}_pte when doing pte_unmap(). I think we can safely replace

That looks like something we just overlooked before, meanwhile it's
undetectable on !HIGHPTE anyway.. in which case the addr ignored, and that
turns always into an rcu unlock.

> them with the original ones. WDYT?

Agreed.  Maybe not "the original ones" if we're looking for words to put
into the commit message: it could be "we should kunmap() whatever we
kmap()ed before", or something better.

Thanks,

-- 
Peter Xu


