Return-Path: <linux-kernel+bounces-228302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62115915DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847361C21A24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A830413C9DE;
	Tue, 25 Jun 2024 04:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nlaYdgp/"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C25D12E1D2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719291294; cv=none; b=ukYTiio9wumI8lCuc6pnCnoElDwQRukTMUd/Y2OuDRHCX8sJgZ0Omw1C/BQ+ljeXfXK6380GsDmAmoHtYGR7+cZcuX1QqbgXOHCaKhY0SMtNk+1xCYrBMnOL+HLO4v1dI7eOvxAveni1VLmUdmAMHtwzAMrGyfyqanIs/9UT3yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719291294; c=relaxed/simple;
	bh=jbnHnMjBfNezXwhs3YRMiasJNGUpHVbIybIR5R6hmWE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tgUDQ6mnZfEY4+N995LSCDOcCWFaD/DI5S1LM3E/9U4nGy1OPyKZWqoULZISZcLHEdxPVlENPvogheOtL4kAJU0jWs6vIsm9jyDSK19jMvVOL/Q7ahs6oAbHyPG7+nt2p4YsUlcWEnL0/1x9AVEt8EximGA0aFvViaNHWfAiRJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nlaYdgp/; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-632bcf111ffso48836007b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 21:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719291292; x=1719896092; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtwAbstTTXWhbiqTYTn63sZCI1kd2+HDy1+CHZY+TrA=;
        b=nlaYdgp/tsPPAe6+noC6iipijXXr4dNTHS7BWeMvvOTdDxYZikzhUyECpSqiYURWnU
         IVH9/IvzUVouV1Be06e1+v/S9U/MFsYVCyqQlDlU/AsG/vgdwNIJoaBEAxm5jeHCuxEh
         Ba8eohyD6nGWbGJyE460owES7Fe7Li72qPx+f9k1dSrKzEuuKHxwXy0ti/UZ7KC49Dk8
         9UXid6h+odMWqLCv4E381MATF4UH1IVnM23ufPNaOxN3v95YvwRHuKNJD7dGXfA1hp4e
         Ua2BvLND51D+btmqrBr6aTSjlU9IKO0dtMGQ0BKXqiKgbbrsfmPf48GDLC56c3IBp67U
         XDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719291292; x=1719896092;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtwAbstTTXWhbiqTYTn63sZCI1kd2+HDy1+CHZY+TrA=;
        b=aPcbe+jZjMpUnBGrz982Rxk+iFnzN5iPRnuXWoL+s4Fozq8t1laXyOceCh5FyA7Tao
         4MYn6BD4QcJfhb+i636bje1yXPi3NTKMvLUPkJa3BIrPzFmxl6YokFiP3v1ambYkYXDX
         2j9JonlbDpqRje0vmG9p0XJyeBFAmLi6mflp0kTOx5JZACsHPd5u15udX31/z5/2xQ/z
         J82Gj5T6lSQOezGopb/n6Adl5Zs85nCFBpAq+2f+VRIGG/+qtM6GDZc4LJnIs8VGzN53
         HlqCEzoQ5GBvrU+tJjogPX+3WVDOyv760F7LASzr1EE6lfxzpSuZNoPYpjSEsChNgzAs
         VcHg==
X-Forwarded-Encrypted: i=1; AJvYcCVlG55/a2UUPEsSV0EUvoYv5q1cEEN0gQfR90OOeXBXa8rVyPt7z9jk7qIWbgbt+vq2qzlGmFNzKOjmfUOjwwIuWYxOMPMjN5j9IwqS
X-Gm-Message-State: AOJu0Yy8gBGqZAOHWXjLL79q7JjTYslUjcjbnRlXuKSUO/UfZl0M+BQK
	0pKeXFWZeJEC+o/86sNGQh+UdOEO21jsNt+YXtSSk0IgxJp0p3J2y3mBMETkvw==
X-Google-Smtp-Source: AGHT+IFWDp3NNaxpCABF0X4STIcfJgY41MVmcNp7/xPmE5jFZbXgAsfp/9PE+kWj8w1emUGzMeo3NQ==
X-Received: by 2002:a05:690c:4b02:b0:61a:cd65:3010 with SMTP id 00721157ae682-643aa5a259bmr71230307b3.30.1719291292081;
        Mon, 24 Jun 2024 21:54:52 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-63f14a3caa9sm33515867b3.86.2024.06.24.21.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 21:54:51 -0700 (PDT)
Date: Mon, 24 Jun 2024 21:54:40 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, willy@infradead.org, 
    david@redhat.com, wangkefeng.wang@huawei.com, chrisl@kernel.org, 
    ying.huang@intel.com, 21cnbao@gmail.com, ryan.roberts@arm.com, 
    shy828301@gmail.com, ziy@nvidia.com, ioworker0@gmail.com, 
    da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] support large folio swap-out and swap-in for
 shmem
In-Reply-To: <25ae21b4-23d5-73ba-2e0a-e642ec4b69a0@google.com>
Message-ID: <d186f398-4f40-7760-1a2a-2a88f041c6d3@google.com>
References: <cover.1718690645.git.baolin.wang@linux.alibaba.com> <20240618130538.ffab3ce1b4e66e3ba095d8cf@linux-foundation.org> <475f0f2c-afc7-4225-809f-93c93f45c830@linux.alibaba.com> <2683b71d-aebd-5527-348c-18c0e021b653@google.com>
 <25ae21b4-23d5-73ba-2e0a-e642ec4b69a0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 19 Jun 2024, Hugh Dickins wrote:
> On Wed, 19 Jun 2024, Hugh Dickins wrote:
> > 
> > and on second attempt, then a VM_BUG_ON_FOLIO(!folio_contains) from
> > find_lock_entries().
> > 
> > Or maybe that VM_BUG_ON_FOLIO() was unrelated, but a symptom of the bug
> > I'm trying to chase even when this series is reverted:
> 
> Yes, I doubt now that the VM_BUG_ON_FOLIO(!folio_contains) was related
> to Baolin's series: much more likely to be an instance of other problems.
> 
> > some kind of page
> > double usage, manifesting as miscellaneous "Bad page"s and VM_BUG_ONs,
> > mostly from page reclaim or from exit_mmap(). I'm still getting a feel
> > for it, maybe it occurs soon enough for a reliable bisection, maybe not.
> > 
> > (While writing, a run with mm-unstable cut off at 2a9964cc5d27,
> > drop KSM_KMEM_CACHE(), instead of reverting just Baolin's latest,
> > has not yet hit any problem: too early to tell but promising.)
> 
> Yes, that ran without trouble for many hours on two machines. I didn't
> do a formal bisection, but did appear to narrow it down convincingly to
> Barry's folio_add_new_anon_rmap() series: crashes soon on both machines
> with Barry's in but Baolin's out, no crashes with both out.
> 
> Yet while I was studying Barry's patches trying to explain it, one
> of the machines did at last crash: it's as if Barry's has opened a
> window which makes these crashes more likely, but not itself to blame.
> 
> I'll go back to studying that crash now: two CPUs crashed about the
> same time, perhaps they interacted and give a hint at root cause.
> 
> (I do have doubts about Barry's: the "_new" in folio_add_new_anon_rmap()
> was all about optimizing a known-exclusive case, so it surprises me
> to see it being extended to non-exclusive; and I worry over how its
> atomic_set(&page->_mapcount, 0)s can be safe when non-exclusive (but
> I've never caught up with David's exclusive changes, I'm out of date).

David answered on this, thanks: yes, I hadn't got around to seeing that
it only got to be called this way when page anon was not already set:
so agreed, no problem here with the _mapcount 0.

But eventually I came to see what's wrong with folio_add_new_anon_rmap():
this Baolin thread is the wrong place to post the fix, I'll send it now
in response to Barry's 2/3.  With that fix, and another mentioned below,
mm-unstable becomes very much more stable for me.

There is still something else causing "Bad page"s and maybe double
frees, something perhaps in the intersection of folio migration and
deferred splitting and miniTHP; but it's too rare, happened last night
when I wanted to post, but has refused to reappear since then; not
holding up testing, I'll give it more thought next time it comes.

> 
> But even if those are wrong, I'd expect them to tend towards a mapped
> page becoming unreclaimable, then "Bad page map" when munmapped,
> not to any of the double-free symptoms I've actually seen.)
> 
> > 
> > And before 2024-06-18, I was working on mm-everything-2024-06-15 minus
> > Chris Li's mTHP swap series: which worked fairly well, until it locked
> > up with __try_to_reclaim_swap()'s filemap_get_folio() spinning around
> > on a page with 0 refcount, while a page table lock is held which one
> > by one the other CPUs come to want for reclaim. On two machines.
> 
> I've not seen that symptom at all since 2024-06-15: intriguing,
> but none of us can afford the time to worry about vanished bugs.

That issue reappeared when I was testing on next-20240621:
I'll send the fix now in response to Kefeng's 2/5.

Hugh

