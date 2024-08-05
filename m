Return-Path: <linux-kernel+bounces-274891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19191947DF7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD55128275A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9BF16BE0B;
	Mon,  5 Aug 2024 15:22:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB9615DBAE
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871325; cv=none; b=LjJfw17MFFc/WuYXqymL+bO/mNS5iFE5b/EZV/y54v+24HSyJOpZHo8rVo50u/AWaZe19Y95XQKx/rF/FKlMs7hndzbuIIkqlE0Z8dKXSDdu1D61fCgpmAdo7VVlH7wPGDoWsN4tPEVLNXYFDX7wZZ3rcrqyAuam8ct1QzJ+tis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871325; c=relaxed/simple;
	bh=py4U0a4P6WFhADIVqpEy/7j4JcuX1EsWHjwU8fblFvs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ONOmtqsf+Q40RuCAZpad1KXC3H0qElXvKL7C1s8L7eJ7Jgn2TEHiXBy/mBnsedU185u1buMvZHPv37DpEpJHb8hr0MCgVbr0hw5qwTs3sqRKY7fnjXM/eZtb4UUUmlYx+msUBkWfn66ce1f/Vy0K2V+oOW/KHPmQjAfYUxGDBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f6218c0d68so1658769839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722871323; x=1723476123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqYQ1rnc25cZh5MXJtV/NcibaXRvGQIgXbkVXCpo9Vg=;
        b=iDgqIjnosix8vgRQViB1Mhlw1EaotGjuSltPhcnAAPdUhqZ67iN3UM9IcWa0/OFc41
         Qewz07tkFkwSJoqg6oWzdUqE3RYsJKdzmdRKWAL5Wb/5T2EZGf6VgZzEVNYSYhckH8r7
         LYtCyVscmG22aVnLW+tsVDCFuTuKNTcFzJfzQX+AXYucyML7Mbf4M2WEp/iO91t0fXsB
         rdr3Y2rrJhtRUsBg3EPtZA1asWI+JtEKEGzLwtEHT5RCYLKzQidToXdwCoOqmkkFbpcE
         ff1LA/Aw0Vh5MfWMthlmCteNNLpMp9pQCuQvC4hAx34PhoPRFS+y+9B5B72qvdu5hwC4
         DSBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF1kk5mEAkfxgK2xM7NemegTrlBaB9060piPtWk2W8i5ascnop46Z7gIjVjqKTBJCEEfHcKUzq/Icze30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze5cVuwWte9qW26YOAOojBxUHg0eTOW6QahBmjzuOoL6HQWf3x
	XidvNWJ4uUmQpObPYhpYhPCF6i3diIN/ZR93Uq8gTwnePETqG6odUA0lTVuR9OdbcJo/ttPC6hy
	PE25XiyN0z4fT22qLK5T+ZkJlX2D0ks9WRRa/B481rFJgCCk/wFFXLrs=
X-Google-Smtp-Source: AGHT+IHIVNrWhdKuYXvlWP06vdiuw1dl3ZRddzqrJ/HvcfeJ2tl/ButFA0z7NeffmCSpRGbYFawwBfu5eYDV1ordM3AX4Z51JLo3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410b:b0:4be:d44b:de24 with SMTP id
 8926c6da1cb9f-4c8d560df7amr526272173.2.1722871323340; Mon, 05 Aug 2024
 08:22:03 -0700 (PDT)
Date: Mon, 05 Aug 2024 08:22:03 -0700
In-Reply-To: <0000000000004d2e4d061a401e51@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038c729061ef13d67@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_vm_page_mkwrite
From: syzbot <syzbot+f195123a45ad487ca66c@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a8eb3de28e7a365690c61161e7a07a4fc7c60bbf
Author: Chao Yu <chao@kernel.org>
Date:   Mon Jun 3 01:07:45 2024 +0000

    f2fs: fix return value of f2fs_convert_inline_inode()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1055414b980000
start commit:   83814698cf48 Merge tag 'powerpc-6.10-2' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=238430243a58f702
dashboard link: https://syzkaller.appspot.com/bug?extid=f195123a45ad487ca66c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1129d362980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d4ce06980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: f2fs: fix return value of f2fs_convert_inline_inode()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

