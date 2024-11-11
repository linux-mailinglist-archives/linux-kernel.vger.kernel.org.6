Return-Path: <linux-kernel+bounces-403650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E149C3885
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C044282309
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 06:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBD5155A30;
	Mon, 11 Nov 2024 06:40:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47890155382
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 06:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731307206; cv=none; b=sJHnCe8HoXM0HCh4SVzc7Hc6ohv1kiAld5O5Xbo2AeTGl6QrVsRjUwFcw8JEe5GmITaOxwJIVbURVqn27RLXacjxrpOkiUrE1VxwmPlpwwX64hef20Qgmn0Pv1KGaVZoEBOskIoLec1ns8CTilVx6PXI3U91l2I9DQKYJEpolfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731307206; c=relaxed/simple;
	bh=EbEkTKtYltYcleYCY2ECP0L6Wbig9QekbCKMJWCfVeA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J6zXCOxoXeb9qBoNQOFpLyDrzPvxIWbPoq8Cf7Z9tSROEWGOmDSYOKenU+YW9s93KfS73yB9PWbev8VMkANJDJAbzwWLbTGCu4yfrOSax8uZ3gprvf90zBb0J0xsVM7yiD8mdr8mix7bNQmR4M/QlJoOWIkKrKcGor9FNw0KKgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83aac7e7fd7so525182939f.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 22:40:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731307204; x=1731912004;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hphkCB1iP3K+OyNx8UIKZQK39Qpf6Uhh5LCO7fqBJ7k=;
        b=YaNNgTASdipQbL392AqixTdT7JemlDiMRFYlcLWgynsJ9rmoeYbHp6/aML1LbW4VQn
         dNt6teNWPq+dECiCptYx968U6JXO7nOy55EsHZ0GgX1Glq4PJvs/gdRxZmAEZhYUaTSF
         cpgoJ0MxxfRFSruT0zmVve/2Ccwt9nFVKjXZZBuXF5oDNUQMQPeVsEV5yt/pZNfYjnwv
         +yVVNTSvEUDtn3xc9Ke5c9SXKyak49Os2fN+Hmo8fNZuV8gWfWsyzw+meagPFBEjLMKt
         46TqC4RUJ3ngrPK/5IghlAMqW572P2qzxKDqnqPfxL8ay0+qcg5njwh+Lk3gpcjjYsJt
         idMw==
X-Forwarded-Encrypted: i=1; AJvYcCUwIYtzzwY0+ZMk3ZJ61c/w3RpA1PX21Ofnb1DgKwV4ei/7rKs4b0TDt4gX4XyUhHECot2ibyQTh8LSjN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI56vNoVG00sF7POwI1ifgsMe6+7tWyKYJrGL/rhE8RCZ5N+62
	eV7yyyhD6FqWR4hphJJHJEXuwdMA2Mrad6kh+P5Po4mOylYHDQVfuH/WuXbYjhvcy6AXV79BYms
	IwWRodbCv9kUA3oiyYz/djfSOBSwgFmUb25MUeFHk4NGudlE8DxG0kAY=
X-Google-Smtp-Source: AGHT+IFVnhP2WMzQG+W8Y6ZP1xF+odHxVWxvFzMvPyZMAub77bZXbGYs3RyRRBhCFKSc+EYGswXxXBEOhSaSK2A2m8uVf7NrX+zf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a43:b0:3a6:b258:fcd with SMTP id
 e9e14a558f8ab-3a6f19a01c1mr123989715ab.1.1731307204314; Sun, 10 Nov 2024
 22:40:04 -0800 (PST)
Date: Sun, 10 Nov 2024 22:40:04 -0800
In-Reply-To: <000000000000ebc1a306219068a5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6731a6c4.050a0220.138bd5.005e.GAE@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in get_pat_info
From: syzbot <syzbot+16b1da89309a06cd0e3a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bhelgaas@google.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, david@redhat.com, guohui.study@gmail.com, 
	hpa@zytor.com, jannh@google.com, kirill.shutemov@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, seanjc@google.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	torvalds@linux-foundation.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 79a61cc3fc0466ad2b7b89618a6157785f0293b3
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Sep 12 00:11:23 2024 +0000

    mm: avoid leaving partial pfn mappings around in error case

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11df65f7980000
start commit:   7758b206117d Merge tag 'tracefs-v6.12-rc6' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13df65f7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15df65f7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=921b01cbfd887a9b
dashboard link: https://syzkaller.appspot.com/bug?extid=16b1da89309a06cd0e3a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148adf40580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1704ae30580000

Reported-by: syzbot+16b1da89309a06cd0e3a@syzkaller.appspotmail.com
Fixes: 79a61cc3fc04 ("mm: avoid leaving partial pfn mappings around in error case")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

