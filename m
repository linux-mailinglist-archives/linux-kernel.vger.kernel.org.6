Return-Path: <linux-kernel+bounces-556451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 263CDA5C9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3F63A566D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9C626156B;
	Tue, 11 Mar 2025 15:56:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231E5261396
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708567; cv=none; b=Xy6OcC/5CkegqCjbWx6G76a82Y9QK5LqFVKj39c3p3ghDMd7D6+G0ON6Howmc7ChU1C12syrr3MUjT60Xhlm6g26JncfHu7vXoPwsDaKgOsW+L+w3YwIYT/g8Iz1CnZlhWqcps+UPbh0A4c/tzmqBA/nGRR9+2CeQBGHUZZ5EYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708567; c=relaxed/simple;
	bh=sc10Pl/zyyF8BPF2JK1mZI7HV2hkrXbUl05fR/5+oFc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RZuDUGCi7zK98ck1dxLcR2zMlYpzf0PrTZoVJb8/8zBAo1ob0PK8tswHZ3xAxYTNHfjalYqQiI92UKlEw2oSxK8UcvAgenizsBRpKAk+4BmIBoSu1ujgEMaAohmeZmQeP9owEDXBSc96CjcoOgw98Ze0QVfbQgBp7M3APJ5j8Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85aec8c9633so1156680439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741708565; x=1742313365;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRrgZHOV3bUp6D7hSoq5Vx4W3eVh7jENoQ0JRVmYyRo=;
        b=UxggJNLmlTUxd65Fs4VnclL48bxHTKQ4/4aEnBZ3wRO6rY4Ary273Gmy7VsQyRV0qN
         trjalfvVGCRkAnB/wOflASz+F026Jsl2e2Dq/uMt83eUWSlFrgLUbPXQo44KJu5y6srg
         Oa+idZG81Juau1Wg24b2wdyVvtfo9GdwNrLaR3F+mZID8dcytTsgGSGfY19PLp7ZYdto
         ruLFm2ZwJRGKgke1cunT8zNua5fgXqWUlo6ML/9QLfA5eTKhPCL6KawhAQNNu8AmL5wv
         5lbvY8pDDNeNN9k537VRoS0a86yMnmwj+xNLNm8qauO6bU4ry0v/7s5M2wdCNkSWdDuc
         kYlw==
X-Forwarded-Encrypted: i=1; AJvYcCUrenIb9qMIUxtabXVk4lfKC48DD2DLKxOfS+MDXgToTjjy0WKM/g9aQJa4xksW3fwN6YSHgOQIXMFwlFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFW6K68a0QRcfBROfeKZb23dtgW7iv5cAuhU6Oj0I4VOcQOtrL
	M1GnqjnTnuq44VGcTHNJfnD8vbWmXZ2raMWkXoJaQ5/Xt0Ue2hdeujBzRg6DmLOr8nNAf6dVHdL
	d1JG9djHUztf0MzEbP2gC65jolCKxMu7klDCwT8g/8PC53sHT2UQfzOg=
X-Google-Smtp-Source: AGHT+IHxXFdrlN/sWn5qmnyi6aWSNe1Tfz8GvTH5kIuQ4yiObhgacWvV92BKVdx3Qc4jr17Dky5O7qoBZ1EQgvO7cpheIb/kTS5Z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:240b:b0:3d4:244b:db20 with SMTP id
 e9e14a558f8ab-3d4419296b0mr188445365ab.16.1741708565295; Tue, 11 Mar 2025
 08:56:05 -0700 (PDT)
Date: Tue, 11 Mar 2025 08:56:05 -0700
In-Reply-To: <000000000000ba5cfd0609d55c40@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d05d15.050a0220.1939a6.001a.GAE@google.com>
Subject: Re: [syzbot] [tipc?] [nfs?] INFO: rcu detected stall in sys_unshare (9)
From: syzbot <syzbot+872bccd9a68c6ba47718@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, bristot@kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, jmaloy@redhat.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, juri.lelli@redhat.com, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, peterz@infradead.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, vineeth@bitbyteword.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 5f6bd380c7bdbe10f7b4e8ddcceed60ce0714c6d
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Mon May 27 12:06:55 2024 +0000

    sched/rt: Remove default bandwidth control

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176de7a8580000
start commit:   45ec2f5f6ed3 Merge tag 'mtd/fixes-for-6.8-rc7' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fad652894fc96962
dashboard link: https://syzkaller.appspot.com/bug?extid=872bccd9a68c6ba47718
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b890ca180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154fbfe2180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: sched/rt: Remove default bandwidth control

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

