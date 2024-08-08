Return-Path: <linux-kernel+bounces-279467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F4794BD9D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A9C8B23E94
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B16418C910;
	Thu,  8 Aug 2024 12:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W4l5kV2W"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACEA18B483
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120577; cv=none; b=pMCNsnzT8o54ZdFVdqN1b+k7A9HjFCr39C0/gkkScCERU49/US7hziO8u7boYcp5CxIfIqnY2FLUyRY7WvNNMACJFSRthCBfxi6K0X3253W7bI0YKainv1mZrOSidR869AUdS9Erlj96q5O//JMvgCXAXNmaTt/uDabFqhcrWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120577; c=relaxed/simple;
	bh=7ofthn9fWNqwiBDdg+Cdp16HkiNPCgwT3bdlNC+/Y3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWWgy5D939ixk3Ev7B7MPVJSb84Uxft97cBT0TCSIAnmnWfQis8iN7DqHoztPiq9ml3ZiMzUJ0uZWxWoqmI0WNLJMaXLcihIiom4KOougX6vaKMLsl+zGgoXfWuvRabGAH9vep5xaL898sWOwvIjSVQKAt0Nz5IPzLbQt4yE1mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W4l5kV2W; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=80WY7rRQcsnevxNgLPvxd3JxKyV7kjYdbGhJOpykh04=; b=W4l5kV2WAQHyyk9mjyXIPPVd4f
	KiUTFdKk8OwXM3U6niGM7aHjMZt/s4YGvFp6QtozFLi+1BtBgnTKFzJjC9p+o3Bz0PErBmYbChzfD
	V3kFeBXQa4Zr8TkW+o3QbRayxQ9dhIAzT/4z3x/0gEy9n5rMhlNligxbinfM4kIPr+tES4QrBEKxv
	XnQ9FPiRCLmdjydVu7tHzYYv8/RBnjSgpymChVEvbuhtMXKRoBcruAm53eyg447nyExgWUiuegCky
	jXJgO6KplvGralRS5hZ937FJWBhBczxYWUxoPGIdy5FyU3Vtn7Zw36MeiERzJRn04GD6oUAG1syVf
	rE+29zew==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sc2N1-00000008rL7-0XOw;
	Thu, 08 Aug 2024 12:35:55 +0000
Date: Thu, 8 Aug 2024 13:35:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
	hughd@google.com, wangkefeng.wang@huawei.com, chrisl@kernel.org,
	ying.huang@intel.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
	shy828301@gmail.com, ziy@nvidia.com, ioworker0@gmail.com,
	da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v4 01/10] mm: vmscan: add validation before spliting
 shmem large folio
Message-ID: <ZrS7qvQj8gP-fhrR@casper.infradead.org>
References: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
 <8a8c6dc9df0bc9f6f7f937bea446062be19611b3.1723012159.git.baolin.wang@linux.alibaba.com>
 <9b45a0dc-fa12-428a-8702-c7690c26aedc@redhat.com>
 <770190a2-3938-4ba9-9aaf-7320b34addf4@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <770190a2-3938-4ba9-9aaf-7320b34addf4@linux.alibaba.com>

On Thu, Aug 08, 2024 at 10:36:23AM +0800, Baolin Wang wrote:
> On 2024/8/7 23:53, David Hildenbrand wrote:
> > But now I am wondering under which circumstances we end up calling
> > shmem_writepage() with a large folio. And I think the answer is the
> > comment of
> > folio_test_large(): via drivers/gpu/drm/i915/gem/i915_gem_shmem.c.
> > 
> > 
> > ... so if shmem_writepage() handles+checks that, could we do
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index a332cb80e928..7dfa3d6e8ba7 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1257,11 +1257,6 @@ static unsigned int shrink_folio_list(struct
> > list_head *folio_list,
> >                                                  goto
> > activate_locked_split;
> >                                  }
> >                          }
> > -               } else if (folio_test_swapbacked(folio) &&
> > -                          folio_test_large(folio)) {
> > -                       /* Split shmem folio */
> > -                       if (split_folio_to_list(folio, folio_list))
> > -                               goto keep_locked;
> >                  }
> > 
> >                  /*
> > 
> > instead?
> 
> Seems reasonable to me. But we should pass the 'folio_list' to
> shmem_writepage() to list the subpages of the large folio. Let me try.
> Thanks.

We should be trying to remove shmem_writepage(), not make it more
complex.  We're making good progress removing instances of ->writepage;
just ceph, ecryptfs, f2fs, gfs2, hostfs, nilfs2, orangefs, vboxsf, shmem
& swap are left.  gfs2 patches are out for review.

As you can see from previous patches, the approach is to use
->writepages instead of ->writepage.  There should be no need to
handle a folio split list as splitting a folio leaves the folios in the
page cache and they'll naturally be found by subsequent iterations.

