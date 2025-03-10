Return-Path: <linux-kernel+bounces-553705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F29A58DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01603AC560
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE25F22257D;
	Mon, 10 Mar 2025 08:16:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB5D13E41A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594564; cv=none; b=Pd1Z7ixFSfSNkoP7uOz+LO8iDNqO2UlL8dGqwFvgEFnNN1Eq7GHBm1GAC8ITUsoXDTGlOhD76LFdeHB01bYCFnnqnAvSWlWuPD0I/6SYia8/5XkYBedYGCHNW59hOfZJwQeuQ6La7IzgcFiK3btKSPVhKLyjlVdm7Z/b7CfO+F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594564; c=relaxed/simple;
	bh=JTF1lZEOEkNPM9MrYB2hrKVjp4XeMgvXRmaOZv8Jd8Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=agzwP4ZxLXNx6KsL0fYIQVNYWwDf7qgrE4zKCwqVi5R3TJUKPRB+yqd7O26Q0f7ZFd6hezHSDGQ0FeJxAods38CGaYOxObq5jSvbiGdWSdHe+Z88hj5f6JzAT86UqaHGw4BCEIxEHiXoHLqSPmq2zrJHwZcSE3aKKbFupFjQTEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d060cfe752so30848315ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 01:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741594562; x=1742199362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22y5blgPG/7lHh8Yv1Qxh3X8BqbkqE0oG9zwwdSyRpc=;
        b=Xy+uBp/G4trUzYwQ+sPNONgLKdnysAWy309hVY3Jq/hdtY4kRb+zOAWSdB/oLd2bRX
         m+GSsfCUwPDLdgzYLdvq5Hc+yrD8kxDUghNO2jN3J7doWfMva+e/16T18AxP2UrDkJQ3
         EfAMZaCNSAN6N3Z0J9DwaqVHrfzJ1/BJIB1HbygnJjHeLN6XWDXl3UraVbsx1gM+EC2h
         2OA3cN0bj0wj5Zkeyomo7eV50MVUnFe6AT6KK8TsZZcbGFwXeNh/gidTnZJOktnoCqkN
         vb6M+n8Mf8gWpzvsvdJ2nxXI/1hJ+wPghY/qjV21v+A9Qho7GU+hH65E5bGEOlMxJ5lw
         HZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV05lYaFwHivUMw2a62E8RGGGoUESOMdF4sFHaJs/fIRbnjvCg+Sl9QucbHCtxRmu3W8fLpDRZuAGgBZGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWfYiKsOr8pEM2EPMSKELrQTamWKjtRIovh2gBGeAVFBgagoAE
	6TIOSkK3XBVUX4Wmxi79z9k2EN4UOkqYNlBJAw9GNrFpzxTvy57QCwM+DHt5H7WfByoeKosgpzn
	7pYkN3WdhQDb9ajAQbVZvrKreEmb9U0swlNKCBV9UrmOMMdi6lYSxcgo=
X-Google-Smtp-Source: AGHT+IFN0yQHYbThJi2b8lhndx403095CWT60RxPFOrDTXJSjATNNhBCFXSWA7A8o55d1zQEIdoDw1HchtFAFGxO9e6Nl+uQ3feh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b07:b0:3d4:36da:19a9 with SMTP id
 e9e14a558f8ab-3d44196ffc2mr143152735ab.15.1741594562162; Mon, 10 Mar 2025
 01:16:02 -0700 (PDT)
Date: Mon, 10 Mar 2025 01:16:02 -0700
In-Reply-To: <67b1f949.050a0220.173698.000c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ce9fc2.050a0220.e1a89.01f2.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] possible deadlock in get_partial_node (2)
From: syzbot <syzbot+725322cc4ff5c53abfac@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, axboe@kernel.dk, frederic@kernel.org, 
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 14152654805256d760315ec24e414363bfa19a06
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Mon Nov 25 05:21:27 2024 +0000

    bcachefs: Bad btree roots are now autofix

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1688a7a8580000
start commit:   b7c90e3e717a Merge tag 'x86-urgent-2025-03-08' of git://gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1588a7a8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1188a7a8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=523d3ff8e053340a
dashboard link: https://syzkaller.appspot.com/bug?extid=725322cc4ff5c53abfac
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137c1fa0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e0fa54580000

Reported-by: syzbot+725322cc4ff5c53abfac@syzkaller.appspotmail.com
Fixes: 141526548052 ("bcachefs: Bad btree roots are now autofix")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

