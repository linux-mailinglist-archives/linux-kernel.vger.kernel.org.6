Return-Path: <linux-kernel+bounces-395200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1FF9BBA38
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8661C24304
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900841C3029;
	Mon,  4 Nov 2024 16:21:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861D21C1753
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737266; cv=none; b=ZH3mHgXrk5VmWtdVQwWi6Q7HCTE75OwxOJuLEtdKfSCDSMj5rwy62YdGkH6jAfrYLilG5IRoKUATyaC68f0Q3Jp9gBleseXgPdasXUZj53HvhiX4xdR5eicqSul9B6/tteIERkrTeCF+aXzNhpAv4l5n9ZszO6KQv/gGfGhAJzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737266; c=relaxed/simple;
	bh=haBLAcbl8Ieh97c/dW3nRm8TrGQapNDBWftSXYIampg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pc15AEz6G4MxyjcTFmZ081WEwBBFd+0R/K2SRw4TAkORCDGSWJgo8tpnyjZQPntzX68wtpZnqZoPds0PWLXyDQ09FQ8PwcOfTra9ZUX/Vg04zhtlZqw6N/+WYtjtxKsk0pK32m7XZow8cCnF0DwyhOafQ1HIJJP+hlyHwYRSVis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4f32b0007so41640855ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 08:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730737263; x=1731342063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxbDd/qx3m9u6LqN8nUobJ9+S9EzZkoCHKBHg8a1GPc=;
        b=hx754QAF3oTq7NtlnmXT2UGlR5Rg6rsDY48GZOI1NL+8rd88yguByNAYOpdiWYOBoR
         pEHEpzkfgLBKexyCA5uHO576XFV9YlfXXDaWhyIqB2CxY+Vnkj/+ex405iACKUXdBnqb
         vet7ZHQFyLDJW85jXUUM3dgbL0qpfgNLWINxh8vWfP09OgsjymcIJslHUsxVZ6qpgEPV
         8jAg/2DQwr9U3ch6JWDdzacSpzwmr0HhKlXJMmrAp36VyO3nWbypJYhKRU23gzqke1YE
         VtDRV1H57BuRfF6saLrOvCMn1Wn2q8fkaubvcSFXZwF/PuOPY2Y6pnoVIpPS8QHyhwRr
         slPA==
X-Forwarded-Encrypted: i=1; AJvYcCUUMHXd9cid/ddhqarTX81FcCnj1blohB8ME3xbpZcYUGkJ4mQkwvpVFdotYA6Jo7CoUxXfPSjHhtFWlfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRFc1x2Ihe1blL47i//zclnNyIl4uDDBsNwytI8hGgGV39xOt2
	hXbiar9PWyIxYNJH1eQRcCNWjxEgjlJJg/CeD5LbNJCSb9ibABc/VGwwfajnqpdS16+/bIXrYEl
	jrFLfLGSmFxmIiTZPv/63JpMuWGpvdKAkYXy9jIAOH5U1xlARd/ZBO8Y=
X-Google-Smtp-Source: AGHT+IGLcE5qtZ2CEjscGbnyM4HxcoGwrpQbQNV/en3k/x7LRl1VNKWBwZcOC0NHJOlhEd4+n0wKBvDvEZeyBT0iTcyNgJnaJA2i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6b:b0:3a6:ac4e:264a with SMTP id
 e9e14a558f8ab-3a6ac4e2800mr148495075ab.10.1730737263590; Mon, 04 Nov 2024
 08:21:03 -0800 (PST)
Date: Mon, 04 Nov 2024 08:21:03 -0800
In-Reply-To: <671fbcd6.050a0220.21b2f.0009.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6728f46f.050a0220.2edce.14f6.GAE@google.com>
Subject: Re: [syzbot] [kernel?] kernel BUG in binder_alloc_deferred_release (2)
From: syzbot <syzbot+dee8aa54cb2f5a150f9e@syzkaller.appspotmail.com>
To: Liam.Howlett@Oracle.com, akpm@linux-foundation.org, arve@android.com, 
	brauner@kernel.org, cmllamas@google.com, gregkh@linuxfoundation.org, 
	hdanton@sina.com, joel@joelfernandes.org, liam.howlett@oracle.com, 
	linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com, maco@android.com, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f8d112a4e657c65c888e6b8a8435ef61a66e4ab8
Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
Date:   Fri Aug 30 04:00:54 2024 +0000

    mm/mmap: avoid zeroing vma tree in mmap_region()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fc46a7980000
start commit:   c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13fc46a7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15fc46a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a34ca8ca33c0e535
dashboard link: https://syzkaller.appspot.com/bug?extid=dee8aa54cb2f5a150f9e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1484165f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132b2ebb980000

Reported-by: syzbot+dee8aa54cb2f5a150f9e@syzkaller.appspotmail.com
Fixes: f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

