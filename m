Return-Path: <linux-kernel+bounces-393040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB409B9B41
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056BF1C21231
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 23:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C661D2238;
	Fri,  1 Nov 2024 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnXnosvs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF18165F0C;
	Fri,  1 Nov 2024 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730504918; cv=none; b=nO6yaeRt2/oiLplXsiJql2Wue58mhedy+CjDG3naG8vZWsAt/aST3AbQTOJZB1562DJK56Vb0jiyYEtngKwY4V4lihsbJmP9Vkoyu0ekoAvaFS1nsKiyqpQfHJfLuAOtlShgOalHcLfykmQr3LI5pXK7CUeyX8Ejy6lah9I74Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730504918; c=relaxed/simple;
	bh=21sE4yu3fLR3GE+R+fbN8Kwt1qsk+dJsWr1o3Qpjm84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ME8iYO8Wie79v8DlzmusDlEsHhu3W8IoWjAozyHp+xLMMmOVfZK6xY+51ptR5YAGAX50As16vNpkfFgdh2Y3NBrA09pcM6Na5A0CZ00XcUXsGe6DbFQB6JPMVjbpaYm8TYI9D1uLIuqBTy+iki10k+Hi3j3WIAdrrd5R4RWH0yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnXnosvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D8EC4CECD;
	Fri,  1 Nov 2024 23:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730504917;
	bh=21sE4yu3fLR3GE+R+fbN8Kwt1qsk+dJsWr1o3Qpjm84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XnXnosvsFADcp34ib5vlgimxIxx2hd7Pjef5THJI9VVq5Ojoyv5PIg77XyeSWqkpu
	 66nPXvTGBe2GebhBXvtmRRmwEtCk6RHvBJXW6UE5brLsMjvfjRq52vt7zjy57ah1L4
	 TW9+pfOdpOxnHJeZwW7BbBB+PwAmxii+sHR0im5Ij8jEg3EReC9JifYlEDoVOlRsSC
	 WH/IjMU5p8vyRKtPIlhikn2jrYpahswiqsXIGxGWZ8Yc/oSThSDzBdSkhZZ6lcSrvo
	 SOb6qjGufmi09tVcOozs2eIJlHpLpdh0ReTQ9UOP47rKb7ityr7c6maIluBPiYmE6L
	 X2IiZu85paz9w==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Date: Fri,  1 Nov 2024 16:48:32 -0700
Message-Id: <20241101234832.56873-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <8e02f3a4-d498-401d-aaba-e53ed2ac6a3a@lucifer.local>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 1 Nov 2024 20:58:39 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

[...]
> On Fri, Nov 01, 2024 at 06:50:33PM +0000, Lorenzo Stoakes wrote:
> > Locking around VMAs is complicated and confusing. While we have a number of
> > disparate comments scattered around the place, we seem to be reaching a
> > level of complexity that justifies a serious effort at clearly documenting
> > how locks are expected to be interacted with when it comes to interacting
> > with mm_struct and vm_area_struct objects.
> >
> > This is especially pertinent as regards efforts to find sensible
> > abstractions for these fundamental objects within the kernel rust
> > abstraction whose compiler strictly requires some means of expressing these
> > rules (and through this expression can help self-document these
> > requirements as well as enforce them which is an exciting concept).
> >
> > The document limits scope to mmap and VMA locks and those that are
> > immediately adjacent and relevant to them - so additionally covers page
> > table locking as this is so very closely tied to VMA operations (and relies
> > upon us handling these correctly).
> >
> > The document tries to cover some of the nastier and more confusing edge
> > cases and concerns especially around lock ordering and page table teardown.
> >
> > The document also provides some VMA lock internals, which are up to date
> > and inclusive of recent changes to recent sequence number changes.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: SeongJae Park <sj@kernel.org>

> > ---
> >
> > REVIEWERS NOTES:
> >    You can speed up doc builds by running `make SPHINXDIRS=mm htmldocs`. I
> >    also uploaded a copy of this to my website at
> >    https://ljs.io/output/mm/vma_locks to make it easier to have a quick
> >    read through. Thanks!
> >
> >
> >  Documentation/mm/index.rst     |   1 +
> >  Documentation/mm/vma_locks.rst | 527 +++++++++++++++++++++++++++++++++
> >  2 files changed, 528 insertions(+)
> >  create mode 100644 Documentation/mm/vma_locks.rst
> >
> > diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
> > index 0be1c7503a01..da5f30acaca5 100644
> > --- a/Documentation/mm/index.rst
> > +++ b/Documentation/mm/index.rst
> > @@ -64,3 +64,4 @@ documentation, or deleted if it has served its purpose.
> >     vmemmap_dedup
> >     z3fold
> >     zsmalloc
> > +   vma_locks

This is the "Unsorted Documentation" section.  If the document is really for
the section, I'd suggest putting it in alphabetically sorted order, for the
consistency.  However, if putting the document under the section is not your
real intention, I think it might be better to be put under "Process Addresses"
section above.  What do you think?


Thanks,
SJ

[...]

