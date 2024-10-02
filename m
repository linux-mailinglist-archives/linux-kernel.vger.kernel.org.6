Return-Path: <linux-kernel+bounces-347008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D1498CC35
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 06:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B68B2127E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6A617C60;
	Wed,  2 Oct 2024 04:48:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647702F43
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 04:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727844484; cv=none; b=NWOTxkE4fJCu6M05J0Lhs/R9/kSDU/RHPNF8rkiFC8Z8ADjt9pI5KYVOMh0bqsYyysC/V4JsWhB9n5fnyFPFrNRoMUvgMWfYlsYlgInSMu/QxJfKXxgrJeQmVpFdCKQoH5MGkaYDU6b5ZZTV/Y5lDgRmDPmqwuM9SdttE8TPpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727844484; c=relaxed/simple;
	bh=XdD+s2RdLLsUwBMuDyC5i8HugsB7+818y3B258LuaLQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pSHzmwo/MASJSpUoLfvnfoFk90eqohL3Ry1CcGBxsz9OUISx31HAJg+LR7yEcaLiE/ZjcR5GtinDdIZCeNBsIZBRICp23hr0mrDu+kIPakyPtRtLbtDLT8f04wrJmL6t7GDGCjWJLVsS7xuXchz8OBJi3F5l4RLsfrdozCknxWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a34eef9ec9so36185135ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 21:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727844482; x=1728449282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fc168hZ2il4XJagXeLnymEHZP5G4vz6v+AEvsjxd2XM=;
        b=eek03D7snlDziFcWFcHuispiyPG1Cz2ZAOwJTVuyVXI/4zKltbG6Puw23joHNngWsT
         ti1e23tW3dhS87lFYtzdFHFZnMcq/FSbDUsQwo3JzQSHA1gmnhvK7+hqiJ68ULSNANIj
         jS45YxZkg+UCK/7w3afUwO76hYuThu+IJDQEQApRviacGe9gf+WvS4xPOlQtTCgVx6Ox
         6QGkqnQcmPFNXLRKg+OrzrdDM1R2O0cF61DXmLl0BpGfT7FAptAtlu4q6f2h42q+GcBg
         IhamRS0LDZ4wvPpSt+gdwSRAs6k0sFhhQIY7Fy0bhwFQmu4BCQAFRKRK7vnJh5vX3l9o
         IU4w==
X-Forwarded-Encrypted: i=1; AJvYcCWBbxsQcL9CcibzGvNgH5gAe69rxFIKxV08TcyihcRu3rvbv4OtEzdzZVmQIhC0f1VR/pVAhMQem8O8sv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHyrGo+DH5I1YeTgtgcbfkWyl9Yoeb+LNAKHpGQc/v91c8bIJd
	Z32Mf+mhYXR8g0e/T48/JHL/qa+kiM6X9cf9SVl6fdZXHBTjnCidnV22XEhTHNjZox1F4qnP6Qc
	BKkL4+8dPDurKbLfau3VYAdLypQqwhOK12ZQtoMlpYy7C51b5KUgQHc8=
X-Google-Smtp-Source: AGHT+IG931L37l/psY99tEAyVg5MhvA8BtPGY62t5Px/Kn/GWzYiBPuQW24AKFLByCrHRwXw5d5m+sd1HBcW9JXpQiuc5N0HgoHU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0d:b0:3a3:49f0:f425 with SMTP id
 e9e14a558f8ab-3a3658b83d8mr21328205ab.0.1727844482521; Tue, 01 Oct 2024
 21:48:02 -0700 (PDT)
Date: Tue, 01 Oct 2024 21:48:02 -0700
In-Reply-To: <66f8846e.050a0220.aab67.000b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fcd082.050a0220.f28ec.04f1.GAE@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in upgrade_mmap_lock_carefully
From: syzbot <syzbot+a6456f6334aa19425886@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, ebpqwerty472123@gmail.com, hughd@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, paul@paul-moore.com, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit ea7e2d5e49c05e5db1922387b09ca74aa40f46e2
Author: Shu Han <ebpqwerty472123@gmail.com>
Date:   Tue Sep 17 09:41:04 2024 +0000

    mm: call the security_mmap_file() LSM hook in remap_file_pages()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1530539f980000
start commit:   e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1730539f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1330539f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5
dashboard link: https://syzkaller.appspot.com/bug?extid=a6456f6334aa19425886
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154e8927980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1244bdd0580000

Reported-by: syzbot+a6456f6334aa19425886@syzkaller.appspotmail.com
Fixes: ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in remap_file_pages()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

