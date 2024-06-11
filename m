Return-Path: <linux-kernel+bounces-210334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1A090426D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542091C25016
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F11855E5B;
	Tue, 11 Jun 2024 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2MCxWJVL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689504F883
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127007; cv=none; b=AsOXkLI5zf+pGavN8SsWEBl42yENKZAtLhVsukbtrfzJh4E6Zz5L9+C6VjTb/KynbFDuIr+UDw8vRtBLFpT+/mqcIWuVOyPiiP84XL0XVGebPDhsydTN8aMtzfbX/hepVjEXLoLBgUutjydqdqwIyWkhJ0i+fBmVJiYHEk9meGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127007; c=relaxed/simple;
	bh=T3EWslxjAsU7h6lchFAg4Shsv2DXVnhbls8Bv1615MM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Sv3SCiPHxoEF4yncIbJOfLjuilh1O2IhIT/TDHIZcxaVgY+ac7b5f4sEtIZ9CCajqNxd+beVK42lo8XnEQ7DBsKG4RhtheWozIlq2q7dwxgoLF/LUwq6MJ+H/3FYdys8SzPirxnXd+k1U4YzTp7U5M8X90GhqMHyBcMIDaDqUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2MCxWJVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8A7C2BD10;
	Tue, 11 Jun 2024 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718127006;
	bh=T3EWslxjAsU7h6lchFAg4Shsv2DXVnhbls8Bv1615MM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2MCxWJVLaV4p9IUJ3yEQKhjBd+GDc+KxqDvDeyLYngyo97242qa6hNuQFycP/1qoG
	 +zjH3FrCKNXaBPmM93H4M4N4qBjEW4kgUhP7joC/iWwQW9pk/TwWSEbIqDYonKMlZ6
	 vYGlWstDDrAhGpxdTDiPagwHQBLFZHYDp4FGz/9k=
Date: Tue, 11 Jun 2024 10:30:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev,
 syzkaller-bugs@googlegroups.com, Vivek Kasireddy
 <vivek.kasireddy@intel.com>
Subject: Re: [syzbot] [mm?] general protection fault in
 dequeue_hugetlb_folio_nodemask (2)
Message-Id: <20240611103005.ae4170608bd15d63adee2492@linux-foundation.org>
In-Reply-To: <0000000000004f12bb061a9acf07@google.com>
References: <0000000000004f12bb061a9acf07@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 03:34:25 -0700 syzbot <syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:

Thanks.

> Call Trace:
>  <TASK>
>  alloc_hugetlb_folio_nodemask+0xae/0x3f0 mm/hugetlb.c:2603
>  memfd_alloc_folio+0x15e/0x390 mm/memfd.c:75
>  memfd_pin_folios+0x1066/0x1720 mm/gup.c:3864
>  udmabuf_create+0x658/0x11c0 drivers/dma-buf/udmabuf.c:353
>  udmabuf_ioctl_create drivers/dma-buf/udmabuf.c:420 [inline]
>  udmabuf_ioctl+0x304/0x4f0 drivers/dma-buf/udmabuf.c:451
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

I think we can pretty confidently point at the series "mm/gup:
Introduce memfd_pin_folios() for pinning memfd folios".  I'll drop the
v14 series.  

