Return-Path: <linux-kernel+bounces-223058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD54910CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5E81C21AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E241B3735;
	Thu, 20 Jun 2024 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TFcZEDvH"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73B81AED25
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900853; cv=none; b=S1WB2snYAF6hVvV2fvSrP3OYNz8iiTnzcaJ4nR9TDHBKw7n0y0UUU6yBVRqb1Rou1pND9n9IzKnZH8KiprrN+iO9kdFGYr2zBK1J7L3KieZDK7ksQIbeNk5zsSae8gS3pvCoJS5q9REoPQT3UkNhDV9IKOkY3fv+Yuo6sopj+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900853; c=relaxed/simple;
	bh=0RDIkzXmOAAwwI9w2XKdRkdKut7hbZ0XTe9e/pJUQLs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cm0yzFRIUyAoc+gTgMLJOJrLgH8HbLf6Ng4w0wi/BbApkErME2aHmNSHygz+Idd7d12X+vwAGZJ9nCjIAwVcYFpZ7Lt9WlpSqQtgH/G4TRHnG+sqzxguo4RwWg4C4yKYdpxTX4MicN+t4pb3ZpRMp4Y8p/asM/iJ65C55rQcW7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TFcZEDvH; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6fa11ac8695so575410a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718900851; x=1719505651; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LJOyqSR9lG9EDrbgCSZX5dpQpgzoCzpoMZm9oXH8nto=;
        b=TFcZEDvH+5gtIJWPJ+8OUSjZerPHWy+eY6tGT3YSqrcrWyXAMzZjdlS+wRC1RxRqXE
         uge08VPEzfWvF/i/PpJr05HV7d8gJ63DTdn72/vXA/OQWoFKKOCPiCaRilPSSxnTyvYR
         9bAgnizmUHykNjE/HE+tFUOEWtONP/PAcKyDxkP0nCsQ3xz68aNwe13fqOcr2a1hSVzT
         lDyOpgFGMwPzupJDV9rto/ImLM+dkwhTU8eP2EvzgXdt10QWtQAmCyh8Ch2genWe5W/B
         U74eigfkkSo5eJMqYUkMwtskwYEvR+tFqlBgNP+PF8er1YO9QdWBb576jEcWavUVYDKX
         E0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718900851; x=1719505651;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJOyqSR9lG9EDrbgCSZX5dpQpgzoCzpoMZm9oXH8nto=;
        b=IShRcZLQdNzCIU1UcHua8zEhOxSxb0Sai3qZKjrqHCDJYg7JabCnVZxqtJjqX860sB
         u8q4Ugn7JFYgzJUs/YPs+qtp+0YzuGjViG6peq3t9SVx3opn53zS7ZIJahUoKAmNwI1n
         7RdAhr7gjAnoNXB/SlhYqcOihAyZr3O3Pgc7xvLhUZqTOdCeSacGEuoBLC85CDous2ur
         P9Z9cj8MizAAnfAhKA1Mt5koT80hz9GtSSxvBGgqXlmFtavrsp+axn7SzmKP3M92x2JL
         6WWlttm0L9NvozeInwEEgpyCaFBhfjwjw6ORHYlTQBnVUh7GkrbH1zSVaj4O9b/ptvYs
         dK0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOxqDwMwbquy5gIMZk5vm9OxtTlrOcKMDzZvJIUCz2ozt8hudsRKTX3hCY/wdIq4mFRpVGm39dgTU1u5YuLybmMCBRW3RV+SO6BzCp
X-Gm-Message-State: AOJu0Yzg47UjkeMxitJvfd+7rIcZKFSHIUSu4GBFQE1IfTCKsuKGcM4N
	4DBlOQmjlWwwcI4jD3gZg21zXUp/UIOZgkuUVqOoC9M9DvczuL/bDSTEiQ/jLA==
X-Google-Smtp-Source: AGHT+IFOtBQNQsP0PLBL4sB1EhF5m77tG7xFzLzDAYZH9IhuN2sIE01sJKRp2pkHtfQQ6NLCYY/KYw==
X-Received: by 2002:a05:6870:a447:b0:254:b1b1:7ea4 with SMTP id 586e51a60fabf-25c9498fcadmr6894761fac.12.1718900850745;
        Thu, 20 Jun 2024 09:27:30 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567aa10337sm4289189fac.22.2024.06.20.09.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 09:27:29 -0700 (PDT)
Date: Thu, 20 Jun 2024 09:27:18 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: David Hildenbrand <david@redhat.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Barry Song <baohua@kernel.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, willy@infradead.org, 
    wangkefeng.wang@huawei.com, chrisl@kernel.org, ying.huang@intel.com, 
    21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com, 
    ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com, 
    p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] support large folio swap-out and swap-in for
 shmem
In-Reply-To: <2a358ff4-4219-4262-9225-d9aab14445f6@redhat.com>
Message-ID: <f302f177-44e6-b74d-f140-b3bdf734b4b1@google.com>
References: <cover.1718690645.git.baolin.wang@linux.alibaba.com> <20240618130538.ffab3ce1b4e66e3ba095d8cf@linux-foundation.org> <475f0f2c-afc7-4225-809f-93c93f45c830@linux.alibaba.com> <2683b71d-aebd-5527-348c-18c0e021b653@google.com>
 <25ae21b4-23d5-73ba-2e0a-e642ec4b69a0@google.com> <2a358ff4-4219-4262-9225-d9aab14445f6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 20 Jun 2024, David Hildenbrand wrote:

> > 
> > (I do have doubts about Barry's: the "_new" in folio_add_new_anon_rmap()
> > was all about optimizing a known-exclusive case, so it surprises me
> > to see it being extended to non-exclusive; and I worry over how its
> > atomic_set(&page->_mapcount, 0)s can be safe when non-exclusive (but
> > I've never caught up with David's exclusive changes, I'm out of date).
> 
> We discussed that a while ago: if we wouldn't be holding the folio lock in the
> "folio == swapcache" at that point (which we do for both do_swap_page() and
> unuse_pte()) things would already be pretty broken.

You're thinking of the non-atomic-ness of atomic_set(): I agree that
the folio lock makes that safe (against other adds; but not against
concurrent removes, which could never occur with the old "_new" usage).

But what I'm worried about is the 0 in atomic_set(&page->_mapcount, 0):
once the folio lock has been dropped, another non-exclusive add could
come in and set _mapcount again to 0 instead of to 1 (mapcount 1 when
it should be 2)?

> 
> That's I added a while ago:
> 
> if (unlikely(!folio_test_anon(folio))) {
> 	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> 	/*
> 	 * For a PTE-mapped large folio, we only know that the single
> 	 * PTE is exclusive. Further, __folio_set_anon() might not get
> 	 * folio->index right when not given the address of the head
> 	 * page.
> 	 */
> 	...
> 
> We should probably move that VM_WARN_ON_FOLIO() to folio_add_new_anon_rmap()
> and document that it's required in the non-exclusive case.
> 
> > 
> > But even if those are wrong, I'd expect them to tend towards a mapped
> > page becoming unreclaimable, then "Bad page map" when munmapped,
> > not to any of the double-free symptoms I've actually seen.)
> 
> What's the first known-good commit?

I cannot answer that with any certainty: we're on the shifting sands
of next and mm-unstable, and the bug itself is looking rather like
something which gets amplified or masked by other changes - witness
my confident arrival at Barry's series as introducing the badness,
only for a longer run then to contradict that conclusion.

There was no sign of a problem in a 20-hour run of the same load on
rc3-based next-2024-06-13 (plus my posted fixes); there has been no
sign of this problem on 6.10-rc1, rc2, rc3 (but I've not tried rc4
itself, mm.git needing the more urgent attention). mm-everything-
2024-06-15 (minus Chris's mTHP swap) did not show this problem, but
did show filemap_get_folio() hang. mm-everything-2024-06-18 (minus
Baolin's mTHP shmem swap) is where I'm hunting it.

Hugh

