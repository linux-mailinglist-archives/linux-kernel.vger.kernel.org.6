Return-Path: <linux-kernel+bounces-212375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A43D905F26
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E21A1F23F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ECC12D76B;
	Wed, 12 Jun 2024 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vvRvrmOg"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F912D747
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234612; cv=none; b=jBAgIxTxFnlbrWwjj/4PXfNzAhfMyL59NMVUwOKd9YXzxpV+HOtcq7jh+khTH+872kyOQ8laXjL4djOAq+TKnOQEXvMIWyoe1Bu7RznAcCNjAJCH0l8d17Dsqh14BQTqmjMe40CsxX7rzZp3tcatUyVClSNhUdrgXYA/HytanRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234612; c=relaxed/simple;
	bh=5aSk5Tw4BwV1oVn84Ww5dWnqilYd/7WMiFNsqsYA5J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuebMAULdsNye55Cqey+KGjf7A8Ui2gkfiohHGVsI8CQJpm+xirZiBpuL/cdLx5Y6AgKoDGzjkon8VTKtw7pKj6kFF8PQ/7xI+Nfmf80jO6qHUvYaI+MTGsxDPd6ref/UrFu0/5a9zThsrHDn8oRHfdyiE65Ud09ih0TGqg4xBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vvRvrmOg; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: syzbot+9757fdbdabd69eae08ad@syzkaller.appspotmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718234607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hShnFUKstoRtjqCzTP8h5BDJSr2jj3rHDsqGfTLM4vQ=;
	b=vvRvrmOgXYrLenhqo8q+KubvNDP4PrJSffoOK6gw0PjH68VMULOSjDt5zPQHyP/YSiLm3b
	ocPskV/XHuKQsgxQxwogrizRXw8NQiG7Nxk8AXXhAKlRyu7+1615gnUY8h8qZ8V0rAdHKu
	iEvw+6km9O1ZZOHMaT7SztaJL7NxGiE=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
Date: Wed, 12 Jun 2024 19:23:23 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+9757fdbdabd69eae08ad@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, bfoster@redhat.com, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_fs_ioctl
Message-ID: <c6ghw5solj4fcwibbhjtn5faibyye2gcsuigp6g3qbvgscujl5@7u2pbk4ebcyv>
References: <0000000000003aacfb061aa140ad@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003aacfb061aa140ad@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 11, 2024 at 11:15:29AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    83a7eefedc9b Linux 6.10-rc3
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=116b64de980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c79815c08cc14227
> dashboard link: https://syzkaller.appspot.com/bug?extid=9757fdbdabd69eae08ad
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109726ee980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f2c4fe980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b45273014a8f/disk-83a7eefe.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/94cd5708292e/vmlinux-83a7eefe.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a89698812e8b/bzImage-83a7eefe.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/2b8f6b18fd8a/mount_0.gz
> 
> The issue was bisected to:
> 
> commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
> Author: Kent Overstreet <kent.overstreet@linux.dev>
> Date:   Sat Sep 23 22:41:51 2023 +0000
> 
>     bcachefs: Ignore unknown mount options

these bisects are all wrong...

> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1538cd96980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1738cd96980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1338cd96980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9757fdbdabd69eae08ad@syzkaller.appspotmail.com
> Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5079 at mm/page_alloc.c:4654 __alloc_pages_noprof+0x36a/0x6c0 mm/page_alloc.c:4654

this is already fixed in the disk accounting rewrite, queued up for 6.11

