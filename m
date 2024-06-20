Return-Path: <linux-kernel+bounces-222045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE9B90FC00
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A591C22DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 04:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E542D2B9D6;
	Thu, 20 Jun 2024 04:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nTT0muJC"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CE31BC5C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 04:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718858586; cv=none; b=J4cAKc1dL2ALKpyPsG0A/5nmwEqXOoNuDkFWi/H30Xbg1UCE137YTC4uwM+l3IoukDUsox02pGgJZ5D+tYibHhib16Cm9EoJK2EPax+T7IN+/co5pwjdkqV9EtzGz2FvyjelbwNhX16EQlxDeRZ1V7R4q8Xk4y8JBCJZjcaB7a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718858586; c=relaxed/simple;
	bh=4BsdsB1NNDFOOPxwlKxWYCAUl834rtxOIalzcmOl84U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fyb9eg6ItpalWmnWrj7UXiUy+mQEeXwmJ7Ej/YlyC2zEfLCqcPJfU/OggV8asApuzHoOdRp3rQ9clIPyTp7NueW29qrhE2fcZphWXwUSdSNH0wo1dlxeX6RsrJxW5SwItw1cP5i10bwSphd/Qdc6XOUHeIgVMYORTki8tkm8df4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nTT0muJC; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62f3ccc877eso11432847b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 21:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718858583; x=1719463383; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=01SZhB5ujI2y9fdmpPK1qf8cG1B/3CKult8+T23QD6E=;
        b=nTT0muJCPfJQybjExGLkj2vshf4e+8c5vkBjc6jdmYmVV/P/uySbGbhH04iT74w4Y9
         gPnlJO7aLUZFa7VPBBToEN7ZHLidmgLYW+9YP28YZKebANKnZgmgFOBjSSd3n71nSeyG
         Yx9rPx5fyoVkgfGSxGmE4bvr3G7D46rXJxjNy++s0FsW2boNzhqk5viaBZ4iEgkcptq+
         ntSH929sw7cY79PYsWlCMmpz90PY9BUK4E3PsxwpYMrAVwnM1wKzR6HfGreKyQpuVK3H
         T+6MV4zoaJi0Fw1Ai4XJEuH7ENz6m7qaaubdS3deHCDgrpLoBVYg+6S9cCbMUuZhqLxL
         MQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718858583; x=1719463383;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=01SZhB5ujI2y9fdmpPK1qf8cG1B/3CKult8+T23QD6E=;
        b=dFMXiC7cMqSVKxT+8awjkj68+nsaZm770ngYPQIBzW1C4sjQkTlef0ewVaS9EEKS6J
         hWRc/wmGAQv1AljtihoU9DLeA8g03XcV18RCm9XyZdM3BzJIHzrH2faKWbJkE490B8B7
         6WvlC3PR4zdeqzfpfiaYCW7iBaM8Fcgp/BJ4M0uux0EdfrbRwZvlwgulTf7DZH0RwTN8
         OeZtPReHp4EGMoF9kVEGq6osxSAb7nDUld2glS8/sgyzCfwOQ+evTVD479m68albzJqk
         DkWLoBJ/8mEB3q3YyeK9x/8WTQeXmNVGSOWNyC0GnJqPdTu+qI3VrwYkxngLhVugubx8
         yNpA==
X-Forwarded-Encrypted: i=1; AJvYcCU/h6Rj7k+Bz7Za9O7XMljlNzVNHjxwFrf5o5m/sZNQ4LUKA4LHuiGsRicNbt3Xmo2xg4RerubDkwFaSIAffFRZ7FsrIcFsUqLj+kbI
X-Gm-Message-State: AOJu0YzpHCBZCPBpF4ewsAmkk6kypuCtiVK0fNZJOKEl4uGDFagBvDjD
	JHOzBFul4q3W7eoM1qHcdt+zruRqCl3a12QpeFeKWBAGYX6QCpouUVckdzE+RQ==
X-Google-Smtp-Source: AGHT+IFpakVSGf3XU9qQllNR2HV7g2LeVRfmuNU9kl2neAt8H43cyClnXpBsdywJYuZZUq5lClUtYQ==
X-Received: by 2002:a81:d809:0:b0:630:4fab:a090 with SMTP id 00721157ae682-6394a5c92bfmr52378587b3.22.1718858583387;
        Wed, 19 Jun 2024 21:43:03 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-631183d7d84sm27099397b3.19.2024.06.19.21.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 21:43:01 -0700 (PDT)
Date: Wed, 19 Jun 2024 21:42:59 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>
cc: Hugh Dickins <hughd@google.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, willy@infradead.org, 
    david@redhat.com, wangkefeng.wang@huawei.com, chrisl@kernel.org, 
    ying.huang@intel.com, 21cnbao@gmail.com, ryan.roberts@arm.com, 
    shy828301@gmail.com, ziy@nvidia.com, ioworker0@gmail.com, 
    da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] support large folio swap-out and swap-in for
 shmem
In-Reply-To: <2683b71d-aebd-5527-348c-18c0e021b653@google.com>
Message-ID: <25ae21b4-23d5-73ba-2e0a-e642ec4b69a0@google.com>
References: <cover.1718690645.git.baolin.wang@linux.alibaba.com> <20240618130538.ffab3ce1b4e66e3ba095d8cf@linux-foundation.org> <475f0f2c-afc7-4225-809f-93c93f45c830@linux.alibaba.com> <2683b71d-aebd-5527-348c-18c0e021b653@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 19 Jun 2024, Hugh Dickins wrote:
> 
> and on second attempt, then a VM_BUG_ON_FOLIO(!folio_contains) from
> find_lock_entries().
> 
> Or maybe that VM_BUG_ON_FOLIO() was unrelated, but a symptom of the bug
> I'm trying to chase even when this series is reverted:

Yes, I doubt now that the VM_BUG_ON_FOLIO(!folio_contains) was related
to Baolin's series: much more likely to be an instance of other problems.

> some kind of page
> double usage, manifesting as miscellaneous "Bad page"s and VM_BUG_ONs,
> mostly from page reclaim or from exit_mmap(). I'm still getting a feel
> for it, maybe it occurs soon enough for a reliable bisection, maybe not.
> 
> (While writing, a run with mm-unstable cut off at 2a9964cc5d27,
> drop KSM_KMEM_CACHE(), instead of reverting just Baolin's latest,
> has not yet hit any problem: too early to tell but promising.)

Yes, that ran without trouble for many hours on two machines. I didn't
do a formal bisection, but did appear to narrow it down convincingly to
Barry's folio_add_new_anon_rmap() series: crashes soon on both machines
with Barry's in but Baolin's out, no crashes with both out.

Yet while I was studying Barry's patches trying to explain it, one
of the machines did at last crash: it's as if Barry's has opened a
window which makes these crashes more likely, but not itself to blame.

I'll go back to studying that crash now: two CPUs crashed about the
same time, perhaps they interacted and give a hint at root cause.

(I do have doubts about Barry's: the "_new" in folio_add_new_anon_rmap()
was all about optimizing a known-exclusive case, so it surprises me
to see it being extended to non-exclusive; and I worry over how its
atomic_set(&page->_mapcount, 0)s can be safe when non-exclusive (but
I've never caught up with David's exclusive changes, I'm out of date).

But even if those are wrong, I'd expect them to tend towards a mapped
page becoming unreclaimable, then "Bad page map" when munmapped,
not to any of the double-free symptoms I've actually seen.)

> 
> And before 2024-06-18, I was working on mm-everything-2024-06-15 minus
> Chris Li's mTHP swap series: which worked fairly well, until it locked
> up with __try_to_reclaim_swap()'s filemap_get_folio() spinning around
> on a page with 0 refcount, while a page table lock is held which one
> by one the other CPUs come to want for reclaim. On two machines.

I've not seen that symptom at all since 2024-06-15: intriguing,
but none of us can afford the time to worry about vanished bugs.

Hugh

