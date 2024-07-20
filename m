Return-Path: <linux-kernel+bounces-257793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7331937EFC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 07:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B27282061
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 05:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4B2DDA5;
	Sat, 20 Jul 2024 05:02:48 +0000 (UTC)
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A9D50F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 05:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721451767; cv=none; b=d2aqDU0u40YgJmuHAJdx+uYAGWOUv62Rwv4Ma7gKHwqbKugfSuapXGJ2IGdYrzxsogulRz0Gzze5T+halGjDkEvuxeEukPnSK0YlI3wdbeUKqigib4+qFwLMzMZHuFosH7Yw0nD0+nZQluPI4t3CqkHlDeLJKoyZzJoejUrZPQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721451767; c=relaxed/simple;
	bh=Ow5qbjUeR84RpHEnGhteEjD122Y1Hpzbkqjv2KF3oVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTrX4z2TAXSJMdd0KjDZk7jitdJPp/8dpUnB+b0IYjvhrAK0LOjwN+gi9J6MH42FbZpFs4GecGBpLQTif9FhIcJ9a5/U71jo5zuWpNcl/xwVWyvaDhtM6SjS6CHldOrX9l7Yj5iSwuydLM4udDwrfh141mMFZzUaJkTxxb3Rq0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.143])
	by sina.com (10.185.250.23) with ESMTP
	id 669B44E400006706; Sat, 20 Jul 2024 13:02:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8592158913410
X-SMAIL-UIID: 7BA4A1FEA08A4E7CB7EE4F33C27A4070-20240720-130230-1
From: Hillf Danton <hdanton@sina.com>
To: David Hildenbrand <david@redhat.com>
Cc: syzbot <syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com>,
	hughd@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com,
	Matthew Wilcox <willy@infradead.org>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [syzbot] [mm?] BUG: Bad page map (8)
Date: Sat, 20 Jul 2024 13:02:19 +0800
Message-Id: <20240720050219.1813-1-hdanton@sina.com>
In-Reply-To: <9e26dd3a-f983-4d54-b162-52a9938d0dcd@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Jul 2024 13:21:30 +0200 David Hildenbrand <david@redhat.com>
> On 19.07.24 00:51, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    4d145e3f830b Merge tag 'i2c-for-6.10-rc8' of git://git.ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11321495980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=6b5a15443200e31
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ec4b7d82bb051330f15a
> > compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113e054e980000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1366ab85980000
> > 
> 
> The reproducer involves udmabuf. I suspect it has to do with it.
> 
> But I'm curius, does the reproducer not trigger before 4d145e3f830b on 
> mainliny?
> 
> Viveks changes are not upstream yet, but I can only speculate that we 
> have some issue similar to the one we had with hugetlb: udmabuf doing 
> things with memfd/shmem pages that it shouldn't do, because it doesn't 
> "own" these pages.
> 
> "udmabuf: Use vmf_insert_pfn and VM_PFNMAP for handling mmap" might help.

	cpu1				cpu2
	---				---
	evict()				find folio2 in page cache
	truncate_inode_folio()
	truncate_cleanup_folio();
	  // unmap folio2 from mmA
	  unmap_mapping_folio(folio2);
					mmap folio2 to mmB
	filemap_remove_folio(folio2);


If the window exists for mapping folio to userspace while indoe is evicted,
is this report false positive?

