Return-Path: <linux-kernel+bounces-282420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3E994E3BB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 00:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C528D1C20F90
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 22:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06065165EEE;
	Sun, 11 Aug 2024 22:43:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D21F1494C2
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723416184; cv=none; b=hTN4XJdZaH+0OvIVrmm9swMR9Pva137d+vvkZ3SX2WPWe3FKzLAyXyydcrYYPQ01CL7qgZhyk+lLfNZA+2arqVcrAJUzI11BEs7Jem0k69lFtkvhP65S4uNio8h4XtV8tznYgZrC4VIXRsZNgXDh/wYY+kP8vIJdTMs7B+ZkAz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723416184; c=relaxed/simple;
	bh=L4Lv+V3TAvpIqLu3MSz4+YFRq/dbvUKkqeQBE+ixKpw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uRQe39dxrJIBpEBACkFU8Gm4BjTejfsP4IWcggor0riQ4DaK6koWQtJ/UkEq5WMwdEPuJR8IQqpjcKhaFpv8ULz9CrHvahjkKLu+wnx5aYYLkpn/aa9JdCKLJbt+66XXIar0YOwCJxKxuONSXnHvjrQPW8wbyGFzT3gBaYKzVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b3d3c0dbfso56284505ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 15:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723416182; x=1724020982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVqFzBryEujNvLyT47tPqWQBFIh9FtkAq+KHfk8fPj4=;
        b=GvFOChnL5YMVqfp59P3lrSE8JzL8hCBDMDXIyBK6iYggNfQG9sc0Cz9RK9Ac6LbPGX
         gBOWX24TYV5h7Y+PxLIzZGSzUtis6bUqlJPZlFn4KIDF6ougt+hMqTA0gw6u4r5moc9F
         keXKFd/m732VGqrtkuJQz7xZDJCheKRGyHaBdgcTWDOUjBCaYQlM+py9JgaxrBKsB8rJ
         bS2UKghr1iPFUVGG8gUvz7UzIhxih5x70j9Uu3ncXkf8yHeDFiYoTJepDoxVWo6N+qDi
         fMXdtoYf+UjY4DkF9fq84iCk+rW27zQC19ys9bgo5Eea/4fMP/MZb+a2B6ECD0jZR75x
         cZ3A==
X-Forwarded-Encrypted: i=1; AJvYcCVT1Az4nXb8MswPZPc+07koXEKCqKLjcohx3dsC/8A1Eae8tN9iByzM8NG0Uo12pGBP3UcKhcNniZDrsFHKKXGbWbl50Da7eMrZJEmi
X-Gm-Message-State: AOJu0YzID2xYf8LerMRKoqK/OfFWYhB+tR3KOgAf5jmEKrOL2sIBW7dt
	RTEZRCTDKry4U13X8STiz3UU4So1ozea4UDOW7fNSk6NhMuaF5mAn74AlV2Y75z5U5mHiVRjwAe
	lgacCQY+Y1h1v3NhEgQg5LDtsI6cRA2fPIwLDcomuomChC9Xbhym7QvY=
X-Google-Smtp-Source: AGHT+IF7jkF4oBqJtIkn6QuGeZP/SaW+o6WVuB+UpJ1Q7K+E62/xT80ADTCE4nj7LwY0M348sXjLlvffGGJyVNNQbX8hhCmM1l+c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:376:1fae:4604 with SMTP id
 e9e14a558f8ab-39b8709bc57mr6384475ab.4.1723416182349; Sun, 11 Aug 2024
 15:43:02 -0700 (PDT)
Date: Sun, 11 Aug 2024 15:43:02 -0700
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005971a8061f70191d@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	eadavis@qq.com, ericvh@kernel.org, jack@suse.cz, jlayton@kernel.org, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lizhi.xu@windriver.com, 
	lucho@ionkov.net, marc.dionne@auristor.com, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2df86547b23dabcd02ab000a24ed7813606c269f
Author: David Howells <dhowells@redhat.com>
Date:   Fri Mar 8 12:36:05 2024 +0000

    netfs: Cut over to using new writeback code

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148b014b980000
start commit:   5189dafa4cf9 Merge tag 'nfsd-6.11-1' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=168b014b980000
console output: https://syzkaller.appspot.com/x/log.txt?x=128b014b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16828c5d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103c7805980000

Reported-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
Fixes: 2df86547b23d ("netfs: Cut over to using new writeback code")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

