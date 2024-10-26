Return-Path: <linux-kernel+bounces-382978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F7C9B15C6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 09:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8AE283EA7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 07:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CCD18562F;
	Sat, 26 Oct 2024 07:13:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089C47083C
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729926786; cv=none; b=I4iDYCw26exFmsY0CoFoFYmOmv0z6t3r7ynV26mLXkEPZMVdpzQPuZ4V+x8H3/rKuyC9Krps/qd9YAos24TKkRhCiDoj/1gYjoZq0r4AKVhLTb7pLKEGoUqPLXBfLKKUbqb1LSollgVTD45rXM2YZHzUWXzRunMdSUlFFA6KaYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729926786; c=relaxed/simple;
	bh=Xx/dOFi2i3DQpUhONQ6NZLtMbO64BylT5PURJHWmgGk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kortyPUKPIq2V5OV5rukPmsZcrX/lANEHSoAON6K/hjwrFGYVP/D0qkhQBVkMHcyzKzepGwYYLDVk0nGBBXeGZUsBp5W6g594Fo2cmciCsDTDFVMg6WHmOwNbZhj6ZYyySsWGvYR45/fWEE5e36pxiybbc+C0wSAsA6gi+DIn1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3a6afd01eso24696795ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 00:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729926784; x=1730531584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0rp67qhLwfATV5QRd3EQ8f+xX7gPSztVkNegQS8yK9s=;
        b=txX+08X4rv7b7be2c6sfsMqjTrz2/twqNKSuZMR47PEVjGjv0BpJCT99tSDLC0MqDN
         gmujQr8erSd6YaV6FjegiAqKHVByFtNAzYYvBrt5h5hKJiZumLzqvwtW5RW3BsonEzJA
         APe+aarJFcgUIewJ42G28p1mrCAcichnFcLe/g4ewtzfzZyfzote6piMG7dKRQof+isV
         D0fgonGiC7u/Esj3m2sF1UY/vC5GTH7ZV/n8e2pYPBzhmhnGHVF2g/2K22WLk5tc6r8m
         dR8s+C30OYlnMwVWmO5sfuWBKCzHyUvK398oTlYg8lyLG4vBAcVZPrhEV/ZRUbfana0Q
         bjXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiyr3mW6Ut17hSWK84yVyb/0J78D0XEJVyqqVwUPDknKjDFGc2gge/lzhkajCqz7Cv+RhSbbtDKGqxPEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRFAYR7tCrp5F8kG5nP1EwNGn82bu5R9O48ke9H1tu1cMM5Hru
	myjG5h/20oOTfhbjijxZy08ZGz8o7pCgtGexR2/hQLz0Q4zMxkX6GiAjeV+3yzIEvlHWJ6Xn4TF
	CEpa5SOCaqEDlhmBae6M7bK6h0PuQSJjjbXQjVB09nl8q8YqKdV515Zg=
X-Google-Smtp-Source: AGHT+IEwNTJMMh9GL3u+5fqFWDrHSeRggHiL5wVZQYC+bX3hzCIM1anpITxxzi11pKTVt/BttYsvYuwTcKbUU4p56PLuF976Bm/s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa8:b0:3a0:a0bd:f92b with SMTP id
 e9e14a558f8ab-3a4ed2837a1mr14801475ab.10.1729926784248; Sat, 26 Oct 2024
 00:13:04 -0700 (PDT)
Date: Sat, 26 Oct 2024 00:13:04 -0700
In-Reply-To: <66f76648.050a0220.46d20.002c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671c9680.050a0220.2fdf0c.0224.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_fs_btree_write_buffer_exit
From: syzbot <syzbot+e4b5080f1e963225063e@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	terrelln@fb.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit bf4baaa087e2be0279991f1dbf9acaa7a4c9148c
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Oct 5 21:37:02 2024 +0000

    bcachefs: Fix lockdep splat in bch2_accounting_read

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106e6f57980000
start commit:   c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=126e6f57980000
console output: https://syzkaller.appspot.com/x/log.txt?x=146e6f57980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
dashboard link: https://syzkaller.appspot.com/bug?extid=e4b5080f1e963225063e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1218165f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d0a8a7980000

Reported-by: syzbot+e4b5080f1e963225063e@syzkaller.appspotmail.com
Fixes: bf4baaa087e2 ("bcachefs: Fix lockdep splat in bch2_accounting_read")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

