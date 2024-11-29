Return-Path: <linux-kernel+bounces-425835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F499DEB8F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC407B217FF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ED019E7D0;
	Fri, 29 Nov 2024 17:15:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14319E7EB
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732900508; cv=none; b=OPNt20d4ZKYEHlPhPRqBx9UUm3eVBSTQhq+RYAkLQZMwylxRVl8rrZ7pqL6ut+dVW1SMql/9oS7ilYAGe+JFnqWqnFtFxD0e6yi2qZa34qxVosJonLCf3Wfvz8jrckR5vbB9MqMfDZpFC45f7FEmxvkmRgrSRQ5bXZ7Ml6lzgHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732900508; c=relaxed/simple;
	bh=GnhFjpEQk2QTU3xMRMxYSIU7Dc+xnhMFHvUYOX0FzPs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WzykQwAeM+3kTa+crFDRkHad4d2qyEYEscVp3JaIOYqlA1MIAw9Te8f73EmFjsF8QSSMpXmERfWpopT+QEwe9NIJaCfWjoCSpphmoy8SugF1kQRZlLmhgi6nyTHVU+46P5xPP3kiSKxYaEIgiMf4MJ3qXzETBU5uUEoV0mbv1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-843fef4b9dfso146927939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 09:15:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732900505; x=1733505305;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cabndGigWtS979m0rIc0e06+sfnwrdqk4oGx1hUPQVw=;
        b=E1NBUqi+ZnVEvN4AwLbvheVjNe6ky7kMnYGbGKUR/wCnmYmlBNth/gJSU+wy4ok94L
         A2AThSXhs8sMIjAYj2B3iTCsLhcr6gfrK+ZH8WBDmZq01ljc2E7Kpb9HOzjqHQyfL5th
         GLLUQ57FK+wT/xUP4NHy/gdVyQhuPi4H8fVWm2eOFGEiFicem7rqKU8Q6GLTwn0iVEE0
         a65jnldIFssYct1n3pTWTITsGS7bnk1M8SGwdqdR8jfVnyKfYVFy8ZSLy1JUuJsi61FO
         QdHWOikt3NSbNWQprp5cAseb8Sjdan07Bi9GA2HqhpI1fow4AH/BkAMLdV7+c/g/jYX1
         HlAw==
X-Forwarded-Encrypted: i=1; AJvYcCUJXh5zn8GdnsqRgGfRSlhNx2nmans+TUWharMb11+6JybYS7tO96wWZdgO+NicjLHisQqaDL0WPqQkQg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrCDut8BCRiEUwUXKsOEXpsXrAP89ttbmwpq7B/BIYM+dVX1Lj
	niQK6ZiCWe0nh/hc/3rBOxzfb5wCwa+9oW3hT1TgNozJ37kh0ztNp3QiQrVTeTbBgtuapqtBxo2
	Urq/mGrNW4088zPNdt7W3BOpqPnOBwQI4L+bgppSASzTCrTXNORTN1uw=
X-Google-Smtp-Source: AGHT+IHe8uD7Va/t9RghiydunC7nRHm/GXM4J1aMUOaYHKIypML+ORhOP4P4xsuLh0/azcIVXHk232/8no/NPRjgk/tTxHq54l6N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a46:b0:3a7:c81e:825f with SMTP id
 e9e14a558f8ab-3a7cbd23d37mr83760205ab.9.1732900504111; Fri, 29 Nov 2024
 09:15:04 -0800 (PST)
Date: Fri, 29 Nov 2024 09:15:04 -0800
In-Reply-To: <4020304.1732897192@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6749f698.050a0220.253251.00bd.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_read_iter
From: syzbot <syzbot+8965fea6a159ab9aa32d@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, bharathsm@microsoft.com, brauner@kernel.org, 
	dhowells@redhat.com, ericvh@kernel.org, jlayton@kernel.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	marc.dionne@auristor.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netfs@lists.linux.dev, pc@manguebit.com, ronniesahlberg@gmail.com, 
	rostedt@goodmis.org, samba-technical@lists.samba.org, sfrench@samba.org, 
	sprasad@microsoft.com, syzkaller-bugs@googlegroups.com, tom@talpey.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8965fea6a159ab9aa32d@syzkaller.appspotmail.com
Tested-by: syzbot+8965fea6a159ab9aa32d@syzkaller.appspotmail.com

Tested on:

commit:         2aece382 netfs: Report on NULL folioq in netfs_writeba..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git netfs-writeback
console output: https://syzkaller.appspot.com/x/log.txt?x=159cf3c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=225053d900535838
dashboard link: https://syzkaller.appspot.com/bug?extid=8965fea6a159ab9aa32d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1328f3c0580000

Note: testing is done by a robot and is best-effort only.

