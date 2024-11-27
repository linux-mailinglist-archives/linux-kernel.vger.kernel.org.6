Return-Path: <linux-kernel+bounces-423477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF5C9DA819
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1D7281FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BB21FBCA4;
	Wed, 27 Nov 2024 12:53:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5AD4315D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732711984; cv=none; b=X8lEqevvPKjg0Mno1AMrCZ3I29RA5S9h8n662otiYdDUey3JbRCF2pfkgda0Jmt+t3OD8Kba3GxUCs/2rm8GTLxZjvs2cT4fbqzHZVJYiqc9hK/ZI6QWTrZBXBR8e5Uo3rC4KDIbjvlsT/kE9zRJUx2xuMTlnGH+FyYhS1C4ntY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732711984; c=relaxed/simple;
	bh=xjPIjiSLj2qSUGGn3KuFkn/JtDdj5QT2U5LNX0c/IoY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cgFbN/NfQvsWpcV+zChF8F8aTjAn3IhFVi4kWLKZ4uhFZmuC2agFtFZWzVM0pCrdfqJ1+RFJkuxdHBUEcvIreXxvTE2NsL0H52RvimEjT+uzWrlAu+HzSbSQlLiG53ZivqyhK4GIcD+fZkBBkjIRYkt2NFcc1+U6sA2xzO565mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a78589df29so58647465ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732711982; x=1733316782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d04jGaNrIT6mQifbCfwGC0CEwBJsC/NBvU26ZyXmy18=;
        b=UdjsnDrb2XFc2x7k9vUP/cEH4cbR/S9fGKGtoahrpyR6zruZpCdR+JrKe14TOb+Uzb
         TM9XtF8ziaSakiCW/EoRehEiIpCw2F+sPlHwk0ynZIhdj3ySNSY0cVP5gEDddAEbcwRo
         mrRch1wYixE9Kp5mDZCMsmm2wdiuxQRGTUNJzebCtJo5IlGxKCdMP7K5cJdffh+Bo1Yo
         mHu8xj8CGH9Qp4+LrHwzR8tqnkHNsACpa7Az1oF7QWylfv71PkZiBES/hWf/uqY1euW0
         3nR3lzjRR8hyCCVr159jt46wJ9rYN71YQ/EsRKWU4eg6rHS4gFOdZawSwd547h0LqwMO
         9alA==
X-Forwarded-Encrypted: i=1; AJvYcCWdR090TPnRx8JUOWsHmj+TbZCQwVg2CyYFGVv1xmYk6C3bXHoAc3HSiOI+Ii8+vhxMwwX/H5GNhO4220M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvAegNHpVWeogCQ9uGKlpH0n1qqBJJ15KOsxkpo3a5ZUyYreb
	tSxmD7S27OeF1scbOf5kqSO4Tf1P6dM+cI87u2GJPtZFVKosoWiCPngzFCTSMw1Pk9i8dLl5tcv
	91FiwLW2zDMUWZnt/45GFc9XG6hvAGduUuXvhyIR2GhBE3uvItopqu9c=
X-Google-Smtp-Source: AGHT+IHFbYN4PHoZhAy2Ap0eVBG57YJgaBuU4VAYOcRbFvC6ua7Sf8lpRHfa1f+KL3Ku8bbnxFWWi964nH4c5eaAmANGcMdy1agt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0e:0:b0:3a7:635e:d365 with SMTP id
 e9e14a558f8ab-3a7c5540e9cmr37418815ab.6.1732711982732; Wed, 27 Nov 2024
 04:53:02 -0800 (PST)
Date: Wed, 27 Nov 2024 04:53:02 -0800
In-Reply-To: <67447b76.050a0220.1cc393.0086.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6747162e.050a0220.1286eb.0031.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] BUG: corrupted list in bch2_btree_and_journal_iter_exit
From: syzbot <syzbot+2f7c2225ed8a5cb24af1@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d1adfe4e7e4e7ea225547a07c4b79c314c50c6fb
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sun Apr 7 03:26:36 2024 +0000

    bcachefs: move root node topo checks to node_check_topology()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e6e1e8580000
start commit:   9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1416e1e8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1016e1e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e92fc420ca55fe33
dashboard link: https://syzkaller.appspot.com/bug?extid=2f7c2225ed8a5cb24af1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cf575f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14be0530580000

Reported-by: syzbot+2f7c2225ed8a5cb24af1@syzkaller.appspotmail.com
Fixes: d1adfe4e7e4e ("bcachefs: move root node topo checks to node_check_topology()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

