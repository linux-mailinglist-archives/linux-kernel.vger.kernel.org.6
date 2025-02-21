Return-Path: <linux-kernel+bounces-525817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809F9A3F5CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833C6862667
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9141178F54;
	Fri, 21 Feb 2025 13:20:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ABB20DD62
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144005; cv=none; b=as+dG+U87HKEPuNBCC/XjDrpGNm1jIEHT0wFccHoczkVs3j72UzuhLliTOkkNqcr2tWO+yiQ4ocTP6Li9AkrsgX64LEgA570LXkTejY+/7XKt6XdWes48odOOTGP2xgkpcEVR8YR/sOjO2zYUqMx9bsUg6AovbznsZReVTqLWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144005; c=relaxed/simple;
	bh=4vCKVNEsEgWIs64ubjYODu9ezwCabVqJz8/9mUMtinc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O6vYExR6uNmOmq40fsPM5QD02kbukanmLFAAWoN7OyXzllYiSeWq2RkNJYmPA+GBibp9gCXywckvTWJV2nEP+B9USkSA41AXQvjKyi49f62qMbaeQPcXddPExM4Pz+Hh8gw6sVq1E9zyWnbPUoAtj/gfTVXOKi0XYmYJZoDQoZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce8cdf1898so15284375ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740144002; x=1740748802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKOeUNmgFq9mGFTlFKpVDLkAHhwJwc1BYdbAZYlmsac=;
        b=AoW3+Z5FX7jJPD6FZ2yAoe+FNzKEPiAxbOJFkUMio9L7HOqdhwHGkwefW2PcEq/6zU
         rCBFozs6YrNmKBm0f1fw7kBrHJL0T7OIkKJmwP3bk9zqozq3XBzni7wnNs2SaMfWyIa4
         AQVc5oV9B+vsnESiGTYtGKtmvUV8RM8vzyDBUHsV2ZGuQB3KZYoO70kfrIGL8SlS+qRR
         fwj51QGSM2Rn1ZH7xZFMdZWZMrji9WT00nDC8ioxp0bJ2EzPYtZPgMgbaHnXRCuUOEpj
         IgXn+TCTv+hfwpMYtUL4/8vm4FZaN1YOjVcyt2cDmYjWpGrFfCUfOrEkHeruR4HiCIqP
         WttA==
X-Forwarded-Encrypted: i=1; AJvYcCVvbQk5J8v1X4e/6km4b6VnougsNbBeR6+YUpaJKiwY181AKIHOkNaZH2jxfy1ynUQLMwm70fymQ2/w3Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLQVQzoEED+djdAzzGl37kptPm+syHU0He/Jc4iVbBt4amylJ4
	dGrBp1e4EzrK8YE/f4HRIoVH7oIAbUwPrs3ukrf3J8N3kFaQuj3LgVmm7TEh8WhKrDxaEDmGY93
	wGAC9FlHuDi8JIhnC5NtfZDlz0gmQhUp19snTxUNDSkA0D/enPvJeEY0=
X-Google-Smtp-Source: AGHT+IFk7iXIGjPM3Cd4yMSgfW4vr1fE96DRJ9EACQSHU1A21Wn9X6x85b6VG+vkzitZxJM+02ayoLSehtNh39Na0i/XwqFmq+M9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c5:b0:3d2:5a0a:7227 with SMTP id
 e9e14a558f8ab-3d2cb48229dmr21416275ab.13.1740144002400; Fri, 21 Feb 2025
 05:20:02 -0800 (PST)
Date: Fri, 21 Feb 2025 05:20:02 -0800
In-Reply-To: <6792ffb7.050a0220.3ab881.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b87d82.050a0220.14d86d.04d4.GAE@google.com>
Subject: Re: [syzbot] [mm?] [v9fs?] BUG: stack guard page was hit in sys_openat
From: syzbot <syzbot+1f18c9b1bb51239d82f2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, asmadeus@codewreck.org, bharathsm@microsoft.com, 
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	ericvh@kernel.org, idryomov@gmail.com, jlayton@kernel.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, marc.dionne@auristor.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, netfs@lists.linux.dev, 
	pc@manguebit.com, ronniesahlberg@gmail.com, rostedt@goodmis.org, 
	samba-technical@lists.samba.org, sfrench@samba.org, sprasad@microsoft.com, 
	syzkaller-bugs@googlegroups.com, tom@talpey.com, v9fs@lists.linux.dev, 
	xiubli@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit e2d46f2ec332533816417b60933954173f602121
Author: David Howells <dhowells@redhat.com>
Date:   Mon Dec 16 20:41:17 2024 +0000

    netfs: Change the read result collector to only use one work item

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15cb3ae4580000
start commit:   9528d418de4d Merge tag 'x86_urgent_for_v6.13' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7f05e16f48c5834
dashboard link: https://syzkaller.appspot.com/bug?extid=1f18c9b1bb51239d82f2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17808824580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129252b0580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: netfs: Change the read result collector to only use one work item

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

