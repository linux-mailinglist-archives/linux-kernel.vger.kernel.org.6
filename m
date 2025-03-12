Return-Path: <linux-kernel+bounces-557134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F77A5D408
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB911897EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878FC7DA6C;
	Wed, 12 Mar 2025 01:32:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C2F2A1D1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 01:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741743125; cv=none; b=XAG3/iZvs8ahbBNQ7x96KHJ1rMKqSrGv/V+Xe8saXUMu1ypg82R/7Kqy5LjDkV0095xT57/xEpn8V+rjFL5wuvRdN59XULh7VrdAFmH93MouoWwzFChs/KKd4U+78qy2OA1BLHIGbVlDoLq81z7dSYIpKH+fCjS0uOdHGYAYu+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741743125; c=relaxed/simple;
	bh=F4l7NZLB0Rm6adwPa4hHZJV6NQ9v9upadFqBynFDWg0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UKAMAoZgw/1HdGhu0SYlvgggviBrnKEe7Gn7Tv7ms/1Oz78XuGfRgHFjo147xmLwiV2m1zUrP7wYSKxQyBMF2vptuIvbhYceXpDz7iH9SjTeGzOu4IjI2swXuO+o70cur8XcKou15Ev5JbiennQEE4plh/8OPKD5mvTRITaykI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85b4ee2e69bso330733439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741743123; x=1742347923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XAb8u3Wz9Zo/YhLhIkXP826nMoU4uGw8wY7NG1Aw4u0=;
        b=f5liNlPEDkvn2jNmR0nkiHNJO/Km/6QzJ77SvABBvDr0s2i72Vo8d58qlp8tWE9yOg
         lX4eiw+z9sHFtIvarQN5IMsZEQinFCiLcI3yhO0Nao7uKhmpMQ0MUpKmyfcbMoRwm2GF
         CLqa0uU3sslO/2Qy+RpQC3CXa+7aYMYdFi2mlqUx8iUsrH77NMKjcOwP34UCKi6VPI9Q
         jmOtAVHo57mETlKCxrfuIP2C17HscuUD8ZfUhzGGpGKqnHDaU4DgOabmtGYN5/1EoUzC
         q1dCXvpg7RMPb/Qpj/+4NqG5iSp+Rui5MO4aefyWWxRurUH2IXnS1eBO+/n5fZHG54tf
         zNOA==
X-Forwarded-Encrypted: i=1; AJvYcCXGFRKo0C+a7sOxCA3CL7hri9qOIEdl3AVTMf3D+f1FzQ6SOLhAOdG4/OW1qudq1jWZr30IUtzIUPELOAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwsB6zzYFhieersXmQNO2MRar6g/MtzTYHNc4lj+z37f7r4S1v
	Cb4kiuaEpDFnnqLqhQFunN/AnDioRXM4xHjbbEZDxwO5vLaW4M7DgRTz4+tZK9wZRFTOu9c+SVW
	oTLXkuc7yFlXdSxRyRqlB0rJNIAN+Pfa9FkdSV6I5p7KZ+L9V+AJuxVc=
X-Google-Smtp-Source: AGHT+IFVesQKcXqzbhSDZRVb3dMC47FpyAhRu+PzTx/pQcJli2sL7nUnmtuGIpcf1Zg9eOmXXDj12iJY4Jv6k1EUegT7+Z6OEBJa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2142:b0:3cf:c7d3:e4b with SMTP id
 e9e14a558f8ab-3d441a12ceemr254723385ab.21.1741743122823; Tue, 11 Mar 2025
 18:32:02 -0700 (PDT)
Date: Tue, 11 Mar 2025 18:32:02 -0700
In-Reply-To: <67923cb2.050a0220.2eae65.0006.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d0e412.050a0220.14e108.0020.GAE@google.com>
Subject: Re: [syzbot] [usb?] [input?] WARNING: ODEBUG bug in devres_release_group
From: syzbot <syzbot+cf5f2dd02bbd4d2d411c@syzkaller.appspotmail.com>
To: bentiss@kernel.org, gregkh@linuxfoundation.org, jikos@kernel.org, 
	jkosina@suse.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, lizhi.xu@windriver.com, rafael@kernel.org, 
	stuart.a.hayhurst@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 48e487b002891eb0aeaec704c9bed51f028deff1
Author: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Date:   Tue Jan 21 20:00:07 2025 +0000

    HID: corsair-void: Add missing delayed work cancel for headset status

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16abd478580000
start commit:   c4b9570cfb63 Merge tag 'audit-pr-20250121' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d46425e33fe266e
dashboard link: https://syzkaller.appspot.com/bug?extid=cf5f2dd02bbd4d2d411c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1233c9f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147eb618580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: HID: corsair-void: Add missing delayed work cancel for headset status

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

