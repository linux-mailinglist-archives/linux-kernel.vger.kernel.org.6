Return-Path: <linux-kernel+bounces-316181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FED996CC44
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110E81F24342
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11228C152;
	Thu,  5 Sep 2024 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYxiTxLO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75815BA49
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 01:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725499674; cv=none; b=UnsF+V+IS6HOr4uZJp1+m6AWUxUZxi5g6LxE1rpwiOINUFBWAsYBW+WUYI2AoDErcWl95NXFUovEQKFL9larZTVRaRsGD6LOKFEHwyg3APexSF8CURlAsbq0aEQiqlfGBB/cnzjHjaCl210xvqeVfqYXw4SpKACHsda5lI/0JZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725499674; c=relaxed/simple;
	bh=FbC1cPPSzbfW5w56+Cy7QKMrwCfrGMBGayVp6e5oT2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HSXdPc+M6iJx8NunZqYkG21VxniQqOSlnPwXHp+02PPQdzIbwWf1gUOmZLO4yR1wSYIuVxl7gIUdMSuez4RkwQHvdS4Yi3xxDS/sMRbCJ8nW8B/LjJyIfkKr78ZQETb2mLOXGMay3q09/k+FvtVTKKWa7wQZloP5E1bLmoE8N5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYxiTxLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFD1C4CEC2;
	Thu,  5 Sep 2024 01:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725499674;
	bh=FbC1cPPSzbfW5w56+Cy7QKMrwCfrGMBGayVp6e5oT2I=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=cYxiTxLOAgjYv9AVW0GhChagMznZzQF4EUUgIWpX1ah/LnkRVuMwy8Imu6NFO7nN1
	 6HleT0LVmRFP/jw3Xs8wfuU+WSScNSHtTKgQLAD1AMRovibJMznmIveTWX02OR8d7E
	 8ap1EDoIl0Yxf0eF65vO8AqtpvBuxis6UdKJULpYjcmjgp1YOdzJm6o9NUMLVfn4zA
	 MN0bQNgs4wtrN1k9wgnJryWf6slS5EJvs3Y2WmLNRmHv4H3Tr7VR59Rf1US1fDFemq
	 jt5nHreQMyHJXtwiVcOBAcxslpt0Hy9jnizBUuQlst2JwouWCjGLkIUn3ylfIkCabI
	 SNsmk3UVZcKKA==
Message-ID: <ef3966b1-aa76-4bd7-a9c6-becdf996496d@kernel.org>
Date: Thu, 5 Sep 2024 09:27:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] WARNING: lock held when returning
To: syzbot <syzbot+16c06d2c27b585e352f8@syzkaller.appspotmail.com>,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000ac12e3061fd623b8@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <000000000000ac12e3061fd623b8@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz invalid

Becuase commit "f2fs: atomic: fix to not allow GC to pollute atomic_file" has
been dropped.

On 2024/8/17 8:27, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9e6869691724 Add linux-next specific files for 20240812
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=177f4b7d980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
> dashboard link: https://syzkaller.appspot.com/bug?extid=16c06d2c27b585e352f8
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e46af5980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158ea2ed980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f1b086192f50/disk-9e686969.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b457920fb52e/vmlinux-9e686969.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e63ba9cce98a/bzImage-9e686969.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/b1fc2a52ac10/mount_0.gz
> 
> The issue was bisected to:
> 
> commit 7566a155c666dd23b413a002a50cd9ae7b95f053
> Author: Chao Yu <chao@kernel.org>
> Date:   Tue Jun 25 03:13:49 2024 +0000
> 
>      f2fs: atomic: fix to not allow GC to pollute atomic_file
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1416b183980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1616b183980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1216b183980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+16c06d2c27b585e352f8@syzkaller.appspotmail.com
> Fixes: 7566a155c666 ("f2fs: atomic: fix to not allow GC to pollute atomic_file")
> 
> F2FS-fs (loop0): Mounted with checkpoint version = 48b305e5
> syz-executor161: attempt to access beyond end of device
> loop0: rw=2049, sector=45096, nr_sectors = 8 limit=40427
> ================================================
> WARNING: lock held when returning
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


