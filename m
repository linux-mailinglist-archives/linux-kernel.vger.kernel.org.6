Return-Path: <linux-kernel+bounces-422485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E399D9A32
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D146162279
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CD01D61A1;
	Tue, 26 Nov 2024 15:09:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2111D54E3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633745; cv=none; b=gE0FoeAvFeqIx7TjQPv8WaUCuuAGTSQBHRXMfXeXJqgW/b2Q8QiZ6yocAymk4xyPMuxhJTqLbNghPaKO6p9p/VeLeziWk66PRXEg8sTSW0cPAGUcWiTd0Xoh7LZMBJWOpCzMS10beY6vFN2CwHaES4IMAaJOWJY5pGJmRzTCPSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633745; c=relaxed/simple;
	bh=fuVpuR6FLrCWdq0itV3XyHACPw0SeAl2kHGnGJHphyg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Snr42vpSF386I3Tf0R8ID0vkEtHnExNqPNpvnBY8mKM8qMmrvLXH8o46SQY5Wr1VFt8VbkKWdVT4BmXuKz8J38QBunpfARLk7VlrRcmVutaDbwZEmGAqy4Q0ePpaK8tixJ6JDhyjj4mNvpfhPaswvKhFCQu+nt3sEdX9fTy8xg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a778ce76fbso65183515ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 07:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732633743; x=1733238543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtIa5CkWCoY9wh4/7Pgf9YivYWQAu2aerhFzocU1+7k=;
        b=kG3CWO8+i9CbH7htzzh97wiDmtZMKFXESNVwl/qM8cBxDbyTlQ12NGTY9v9Vnj5XE1
         Aq3kh7U8lIKEDmitAcAvp0s/pKLy5jqH+3EWlnSKCpyf6GVJbeDEvHhbDqpngXrYk5wL
         K+Z7Y4Jx5XZlKwXDs2IB36fvLetdEdkyGdtIdV//sn4EcWYgUYV/wFD8ZA2f8cyNi+g+
         u8/vEDAemujCTVGVBOzQnqwEqceAMPhhPwkJqRE2CopH2BVqs8qvsjFzF9W+Omao9m3O
         KJyHQ4XN+1FZyKt3aj/L5fJEropQn73Gfum7Pea8BBSCemjRCXOp5JexBSClsfLUGoDF
         pUZg==
X-Forwarded-Encrypted: i=1; AJvYcCXov5dVYTT3NZSu/Md14wS+vTNKzsuQlx+eKavSYmyPY485v2lWarkBLiXNiSp96PqEAsjusnl6uG2MUmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDzI0WPzbH+Da9+fVGmH0lgVQLe624qSctfUdPgxlpa+ovyCnn
	AFp8YALBvWivnHcYdB24PhEVXkXy1mS2lQ+RQiiRQH1QfBTm7cD5zhiT3Os/h2v/FoHMt1QQRpg
	g+n4AkUsBsuPOp84EYtKiQC/A37JnwSNwg4qEnZsH6nfcpkzu2Dsm0qU=
X-Google-Smtp-Source: AGHT+IFXl9AvQfPieQxZrCq3J+eQGWqfS9kUdzOIaFTleM7PmWs5QCDXQd1+D3+qve/oA+62Kqkxcn0w5UigMF3ItzyWxxxptKpH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:3a7:4826:b947 with SMTP id
 e9e14a558f8ab-3a79aeff36amr165028645ab.17.1732633742787; Tue, 26 Nov 2024
 07:09:02 -0800 (PST)
Date: Tue, 26 Nov 2024 07:09:02 -0800
In-Reply-To: <20241126145108.49mT4Lc9@linutronix.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6745e48e.050a0220.1286eb.001f.GAE@google.com>
Subject: Re: [syzbot] [kernel?] WARNING: locking bug in get_random_u8
From: syzbot <syzbot+7f4f9a43a9c78eaee04f@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, boqun.feng@gmail.com, hdanton@sina.com, 
	jason@zx2c4.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7f4f9a43a9c78eaee04f@syzkaller.appspotmail.com
Tested-by: syzbot+7f4f9a43a9c78eaee04f@syzkaller.appspotmail.com

Tested on:

commit:         5cb0bc2a kasan: Make kasan_record_aux_stack_noalloc() ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15f9f5c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8839d3e536c93ebf
dashboard link: https://syzkaller.appspot.com/bug?extid=7f4f9a43a9c78eaee04f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

