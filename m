Return-Path: <linux-kernel+bounces-547896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F6CA50EF7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151EC188F349
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F427205ABE;
	Wed,  5 Mar 2025 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7Vyqi2+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EAA13AC1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214791; cv=none; b=rxsRxEzjkO0fVWbzxG1SigwLWHpqrm8P8g+Rz3zKzUe9vxefxZ9xzkGQPiGvOMRg9IwwRpZtohvPJATtxfNeWyZyHJ751rZ5t/KlnZX0EmvqsmHyNf5h5qo9B6BmLcZWZ41aVugdugjUIVgccl9Nud80LnOPe+tfVTEwLvHDYUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214791; c=relaxed/simple;
	bh=3Tg2RBK2X/sKpN0IUIrDSPGWkJ7RP0iQK0OMYcbbzUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dhh0PFf3ly4BUKOZMDmDyw6WOg31g/BKEVtgnd8im7W7gjexE99GAUmE+GMEMUEsv/c7Q2ovw6QzNqQna/5SKlmoX8X0U4iFSI5agJBQfjkh4vy//4lIp7iMK5sNCJ6RlFZXTZieykfT5yXuaZW/WlnbFFRHYml43ao5Q1nbHEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7Vyqi2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33409C4CED1;
	Wed,  5 Mar 2025 22:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741214790;
	bh=3Tg2RBK2X/sKpN0IUIrDSPGWkJ7RP0iQK0OMYcbbzUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7Vyqi2+sWOFn/mQ+3Z6oWceG1MLz4QQAB+wS2Rys3hiHQd6GUqH7+kK18077Uh/q
	 4qWbYq1pymPuv5tzt0yqsDQibPMocIc85wIbYd3Z/AQvCGOqh6wxyL52OID2hhi+ZD
	 WBrQy0yFyVuJtstZNMlR/pYr7ci2gkD/jWgPDWNHMpNJtj3Vt4cilslsYaxwXNKG5q
	 CPdB4mHlW7j2tHPWba9/qKZg5fEIqOT+ewSNpinX8gGLpmyvN7IZvqrguEGngsMwpp
	 0NxaWHk2KwXO8EMWIdKFcNofvJdMw/8UMyrB+CI9sbY/El94YbJuoXnYUrQR/mWfDq
	 05oapb7VpEoEQ==
From: SeongJae Park <sj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/16] mm/madvise: batch tlb flushes for MADV_DONTNEED and MADV_FREE
Date: Wed,  5 Mar 2025 14:46:28 -0800
Message-Id: <20250305224628.60041-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <yhfyhovnztn3m224tdbq4hrth3bulq23ym57rp7prvodaapjdo@any7cn33suh3>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 5 Mar 2025 11:57:34 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Wed, Mar 05, 2025 at 07:49:50PM +0000, Lorenzo Stoakes wrote:
> > On Wed, Mar 05, 2025 at 11:46:31AM -0800, Shakeel Butt wrote:
> > > On Wed, Mar 05, 2025 at 08:19:41PM +0100, David Hildenbrand wrote:
> > > > On 05.03.25 19:56, Matthew Wilcox wrote:
> > > > > On Wed, Mar 05, 2025 at 10:15:55AM -0800, SeongJae Park wrote:
> > > > > > For MADV_DONTNEED[_LOCKED] or MADV_FREE madvise requests, tlb flushes
> > > > > > can happen for each vma of the given address ranges.  Because such tlb
> > > > > > flushes are for address ranges of same process, doing those in a batch
> > > > > > is more efficient while still being safe.  Modify madvise() and
> > > > > > process_madvise() entry level code path to do such batched tlb flushes,
> > > > > > while the internal unmap logics do only gathering of the tlb entries to
> > > > > > flush.
> > > > >
> > > > > Do real applications actually do madvise requests that span multiple
> > > > > VMAs?  It just seems weird to me.  Like, each vma comes from a separate
> > > > > call to mmap [1], so why would it make sense for an application to
> > > > > call madvise() across a VMA boundary?
> > > >
> > > > I had the same question. If this happens in an app, I would assume that a
> > > > single MADV_DONTNEED call would usually not span multiples VMAs, and if it
> > > > does, not that many (and that often) that we would really care about it.
> > >
> > > IMHO madvise() is just an add-on and the real motivation behind this
> > > series is your next point.
> > >
> > > >
> > > > OTOH, optimizing tlb flushing when using a vectored MADV_DONTNEED version
> > > > would make more sense to me. I don't recall if process_madvise() allows for
> > > > that already, and if it does, is this series primarily tackling optimizing
> > > > that?
> > >
> > > Yes process_madvise() allows that and that is what SJ has benchmarked
> > > and reported in the cover letter. In addition, we are adding
> > > process_madvise() support in jemalloc which will land soon.
> > >
> > 
> > Feels like me adjusting that to allow for batched usage for guard regions
> > has opened up unexpected avenues, which is really cool to see :)
> > 
> > I presume the usage is intended for PIDFD_SELF usage right?
> 
> Yes.

Indeed. Thank you for opening up the door, Lorenzo :)

> 
> > 
> > At some point we need to look at allowing larger iovec size. This was
> > something I was planning to look at at some point, but my workload is
> > really overwhelming + that's low priority for me so happy for you guys to
> > handle that if you want.
> > 
> > Can discuss at lsf if you guys will be there also :)
> 
> Yup, we will be there and will be happy to discuss.

Me, too.  Looking forward to the day!


Thanks,
SJ

[...]

