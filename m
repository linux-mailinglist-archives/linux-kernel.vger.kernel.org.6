Return-Path: <linux-kernel+bounces-212156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3330C905BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32BC01C23065
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CF782D9E;
	Wed, 12 Jun 2024 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PyY9f9Kj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F13882D86
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 19:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718220607; cv=none; b=heb1VFEDDUAlAxlH/Qm+3wHz1pWan5X5OP7WvI6fHgXyMKtQNO19WgcYWfIQBw0M3VUKetKWnPRf49YWcA4iryJVyRq12VF+zVdRl2OPBow/2XrvVZycJoQTebMRomG/bfjliG6gi2xHtUElBf8SKOktXuYN1WZoe1RxZtrRW5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718220607; c=relaxed/simple;
	bh=G7xaNCNg6qnygPHz7z+qFHlj+ktFcgmMk2t93MGQomA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VQsghvfXYaiAbIP9Q9Q8+ZBG4Lgf9SVDEPlMkGhpmtbh2YqpsxK9bbQGwX97MEPlWcyLMnhfevjifaytFWH5SBZR1bSGwRoOB4LXvKLb9WXkPmn2DSPmv/Itl8dIOilAuM+nv99a4/C7xofsfXy2zwsWpXTKsGicCSusbSgUJqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PyY9f9Kj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800E7C116B1;
	Wed, 12 Jun 2024 19:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718220606;
	bh=G7xaNCNg6qnygPHz7z+qFHlj+ktFcgmMk2t93MGQomA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PyY9f9KjXDi7DeicYHnRbGuAK4ICleU3PyOFxlJls8GNKvdWSgjW92Dj/DuO9OWAT
	 xn32zCrZiqAmXEZ6yoa1ZGlWlzQu2MbvMdu2Aczx7/yEcAGSC9WRycRfcGpFWn4JR0
	 Yrwisb9WcdGY/Whsxk+S0WIOf3s2yknrVl9tp6+A=
Date: Wed, 12 Jun 2024 12:30:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Xu <peterx@redhat.com>
Cc: syzbot <syzbot+0b56d6ed0d0c0c9a79dc@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in __page_table_check_ptes_set (2)
Message-Id: <20240612123005.d5872e92a8f60e8dd459cdee@linux-foundation.org>
In-Reply-To: <ZmnmNkexK5CGacN9@x1n>
References: <000000000000b7b11a061ab49122@google.com>
	<20240612104735.ee6405d2096236bf18c51a41@linux-foundation.org>
	<ZmnmNkexK5CGacN9@x1n>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 14:17:26 -0400 Peter Xu <peterx@redhat.com> wrote:

> Hi, Andrew,
> 
> On Wed, Jun 12, 2024 at 10:47:35AM -0700, Andrew Morton wrote:
> > On Wed, 12 Jun 2024 10:18:21 -0700 syzbot <syzbot+0b56d6ed0d0c0c9a79dc@syzkaller.appspotmail.com> wrote:
> > 
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    8867bbd4a056 mm: arm64: Fix the out-of-bounds issue in con..
> > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=146b3d96980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3b4350cf56c61c80
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=0b56d6ed0d0c0c9a79dc
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > userspace arch: arm64
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > ...
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 1 PID: 1 at mm/page_table_check.c:198 page_table_check_pte_flags mm/page_table_check.c:198 [inline]
> > > WARNING: CPU: 1 PID: 1 at mm/page_table_check.c:198 __page_table_check_ptes_set+0x324/0x398 mm/page_table_check.c:211
> > 
> > 	if (pte_present(pte) && pte_uffd_wp(pte))
> > 		WARN_ON_ONCE(pte_write(pte));
> > 
> > Let me optimistically cc Peter ;)
> 
> Looks like this is the same issue that the other patch wanted to fix:
> 
> [PATCH] mm/debug_vm_pgtable: Drop RANDOM_ORVALUE trick
> https://lore.kernel.org/r/20240523132139.289719-1-peterx@redhat.com
> 
> I had a look, and indeed that patch hasn't reached arm64/for-kernelci
> branch.

Thanks.

I currently have that patch queued for 6.11-rc1.  I'm thinking it
should have Fixes: 8430557fc5846 ("mm/page_table_check: support
userfault wr-protect entries") and that it should be moved to hotfixes
for 6.10-rcX, yes?

