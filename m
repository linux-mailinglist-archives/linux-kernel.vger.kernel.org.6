Return-Path: <linux-kernel+bounces-437870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C8A9E99EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B44188A3CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608021E9B2E;
	Mon,  9 Dec 2024 15:02:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D8E1C5CD6
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756526; cv=none; b=BLtKMbT84I+b6bfv4SM1443v6lK5baq43laqPDg4j0nhg4nr5jNFGiqjylq+r2awATKFXgdYO7S3YsbT8DGtBEYTA+fw64Sc4cNakyY3dmYSWMHEi1kpYUnWmJFjV8nIhP4HL/dVGUSW4eUq+FfXEwDPPcPIR9P7cH6wRRpMm/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756526; c=relaxed/simple;
	bh=B9vCo6F2T9+u26g8w2gYtFYxPMZXNfMUdvNWm9sd/3s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SYC1KMHVsWwMEhaMParlZXXMYCpiKzyxhNcMGXW1DeSveB5RnZtCKcXe+vzBAwP1QGPrqrZGDFMSwbeU1cgMemUlW1oQk4HHWIC0tWtCUVZkDLhiPPhPe1aBEIXfTRYquwFXtZ8sh1PixnOKIrJZE9+m6NyvKWbwPMWPPPZnQ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-841a9ae0f26so816755939f.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 07:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756523; x=1734361323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7dxMIMKDt3gcnaZaUT4OJRPNLlt1pmTTMSZqablmuo=;
        b=XfoI0TeeVSj5sD0c3WUOIMIs7wNh1BQSKnT7sClLIajvYHsO280X9B3Q3uo5IfCCbS
         Xs3l4tUKOIVg6Pngwl+aE0MMlKC8fHAv0ezjQT9JIsCK7eYy35NEERkPC7trd15NFv2m
         kCwBPHH+Wr5qpJHlMdd6rLQoztEJMhfGXcvRS/NQ2PWLPvegiYzLkkjMlmPYcWut35Wq
         RKprZeVOGKNb9uFgog/vcvVoZtn7cefYP5qmjqArWZun3RBWk3Gfzfh76fZcxsvROlPp
         2q2JKUfJLyM7xKr+CAh6CtUlurI+wXhoizyLxKdUl6WbdL1oHQQRtC5dSlohUKLDj3vE
         +NFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuZIeBBsmrG3FGReCPDd+qgMHq2HlVobL6mIPELwV5azsxlj5DG0H8H1kEFmTZV853OujOy3tv1ZVbLis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ39+d95DXcYbniSdd6+xonooVe3yjFDqryjl/dCI7s5MCdBT9
	F6KKRAC69QW3O2fO0PQ950vSrb9aFVyGs5nLVcSkqtx9szjSKaWW27smZky5nTIJK5yx7yCiCuc
	VFu16TANlEwr535ZPgkgCApYILI3L7YZkelPG+BB/S0RtStcQO57hoXs=
X-Google-Smtp-Source: AGHT+IG5EZZkKQl19WgC0D4C2LkJ6p6XjW5sCN2xk5PuMegB5QYhkucX1Ulr+XYUmcB3kitlouArvVWSFe0dfVvl6kteP9HNI4Vr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6001:b0:843:eaee:287a with SMTP id
 ca18e2360f4ac-8447e3e4383mr1406808039f.15.1733756523454; Mon, 09 Dec 2024
 07:02:03 -0800 (PST)
Date: Mon, 09 Dec 2024 07:02:03 -0800
In-Reply-To: <00000000000065deef0604e8fe03@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6757066b.050a0220.a30f1.01a5.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] INFO: task hung in
 process_measurement (2)
From: syzbot <syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, andy.wu@sony.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, hpa@zytor.com, jmorris@namei.org, 
	linkinjeon@kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	mingo@redhat.com, paul@paul-moore.com, roberto.sassu@huawei.com, 
	serge@hallyn.com, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, wataru.aoyama@sony.com, x86@kernel.org, 
	yuezhang.mo@sony.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f55c096f62f100aa9f5f48d86e1b6846ecbd67e7
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Tue May 30 09:35:00 2023 +0000

    exfat: do not zero the extended part

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15275944580000
start commit:   b5f217084ab3 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17275944580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13275944580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=335e39020523e2ed
dashboard link: https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126a8820580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153e70f8580000

Reported-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com
Fixes: f55c096f62f1 ("exfat: do not zero the extended part")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

