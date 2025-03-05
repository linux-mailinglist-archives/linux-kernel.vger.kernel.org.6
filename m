Return-Path: <linux-kernel+bounces-547735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9FBA50CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01A567A69B2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4727D2571D2;
	Wed,  5 Mar 2025 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt9uW2h9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A330C2571C9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741208380; cv=none; b=kx/WaxopV9SlfpeK7FlVDzm9xztnGM3ja/vr62HgbAnkuQGQdmqnkQC6oAfy4zlzPfaIcoepz21FGBAcRMf4li3mZM5ZzEYls8eArQgQsc5ARBUNpkIl7Gbl2euRTLOqks129OK45BQRWGwRVwPnr79e0z+U80qDLRyFuvPQbhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741208380; c=relaxed/simple;
	bh=5tZ/H1V5nC0MfMdCRCS49fAZCgJNQdPJ/C4hIMVP4Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rfOryjddn5fN5Vuj9bfsa0syvvDqYgndPFXdyBcImgYC6DiO57hKnLedUbpLmK/viQLZm+bZLgrYS/9QRGE02J4TZjhqO7z8kXgiaRJRYJismnKXmkbL+jCGmEAfy76YAmCepVYaOUId87Ra5LbkreR84eyX19eyNcGPQVupgAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vt9uW2h9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D62C4CED1;
	Wed,  5 Mar 2025 20:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741208380;
	bh=5tZ/H1V5nC0MfMdCRCS49fAZCgJNQdPJ/C4hIMVP4Tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vt9uW2h9x9Ka3Qh8jJio75qlZkxW5hBmnbEnl7MPZ48NbXPkJzm7fBWWyrthyDQwC
	 ELgJ4vDxkoOrGd/CK9CqZ47qyHeGm+v41x1OwBLP51NzsF4ucEbNpYw4LwHMdiFHnM
	 1tQ9ZyXF7QCmIY2EIVGXW7ac5Voxg7UYG7AIDi/H3eJ98msyQ6U6gUUfPj0IRkBU6h
	 9T2uMzaPqh0q/U182s+l/CwQTe6XANs8UFoffwb6JinlIDyoZ/cl0s2bHEyg3FLMA6
	 /JbXzNtFs5BpBSytagD6oeDwfRmf2rLumXjdTBlDOK4rqq/G0y6jYP7exTl6JewA40
	 3XkAe16A6sGjg==
From: SeongJae Park <sj@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/16] mm/madvise: batch tlb flushes for MADV_DONTNEED and MADV_FREE
Date: Wed,  5 Mar 2025 12:59:38 -0800
Message-Id: <20250305205938.57904-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <7e151e6b-3f81-4e37-b314-c6e9f19c1b82@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 5 Mar 2025 20:49:13 +0100 David Hildenbrand <david@redhat.com> wrote:

> On 05.03.25 20:46, Shakeel Butt wrote:
> > On Wed, Mar 05, 2025 at 08:19:41PM +0100, David Hildenbrand wrote:
> >> On 05.03.25 19:56, Matthew Wilcox wrote:
> >>> On Wed, Mar 05, 2025 at 10:15:55AM -0800, SeongJae Park wrote:
> >>>> For MADV_DONTNEED[_LOCKED] or MADV_FREE madvise requests, tlb flushes
> >>>> can happen for each vma of the given address ranges.  Because such tlb
> >>>> flushes are for address ranges of same process, doing those in a batch
> >>>> is more efficient while still being safe.  Modify madvise() and
> >>>> process_madvise() entry level code path to do such batched tlb flushes,
> >>>> while the internal unmap logics do only gathering of the tlb entries to
> >>>> flush.
> >>>
> >>> Do real applications actually do madvise requests that span multiple
> >>> VMAs?  It just seems weird to me.  Like, each vma comes from a separate
> >>> call to mmap [1], so why would it make sense for an application to
> >>> call madvise() across a VMA boundary?
> >>
> >> I had the same question. If this happens in an app, I would assume that a
> >> single MADV_DONTNEED call would usually not span multiples VMAs, and if it
> >> does, not that many (and that often) that we would really care about it.
> > 
> > IMHO madvise() is just an add-on and the real motivation behind this
> > series is your next point.
> > 
> >>
> >> OTOH, optimizing tlb flushing when using a vectored MADV_DONTNEED version
> >> would make more sense to me. I don't recall if process_madvise() allows for
> >> that already, and if it does, is this series primarily tackling optimizing
> >> that?
> > 
> > Yes process_madvise() allows that and that is what SJ has benchmarked
> > and reported in the cover letter. In addition, we are adding
> > process_madvise() support in jemalloc which will land soon.

Shakeel is correct.  Thank you for making the early clarification Shakeel.

Also sorry for causing confuses.  I will make this point clearer on next spin.

> 
> Makes a lot of sense to me!

Seems Shakeel already addressed all question so far, but please feel free to
raise more question for anything not yet cleared!

> 
> -- 
> Cheers,
> 
> David / dhildenb


Thanks,
SJ

