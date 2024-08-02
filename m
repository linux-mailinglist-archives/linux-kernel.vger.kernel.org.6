Return-Path: <linux-kernel+bounces-272828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4918D9461A9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094E228222C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C427136343;
	Fri,  2 Aug 2024 16:15:27 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9441A83C5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615326; cv=none; b=VPIlXnIKbgEEasBqufIbYYn6X7HmklmGHBX3K8vnVwQTHjDxtlu9Qfd5zzkGIvjIXHiSbufujyaiy39eIAYjXWYQYSqL+hq3gz+OLq19T1uJ/Jpf4In7tOjwrqR/+bOY8zkYgIVDCS16+tRRIM3wroOno4Sc2PnCjYtcRUR0txg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615326; c=relaxed/simple;
	bh=6qgRDy6kp8tDWlv5y2FQA9RpWDBoE5z7jnch7/Xpf8I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=J2NOS+mcVMy2rdvIpKMeNsgfgfqNi8Tex1JXzC5I/5xtXOtWZqeRDZfi0mQt4LNhGzmRvVAbCGcVb1yMK48vCZvVcMEF3XRD+dBCwN2175GBZq2mIarIJF69zl5kLxcfuQbSuj1ueqpkDvKkt1XEUv+YDJKSc8Jv3WmxDB3Zw/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f8edd731cso1164907839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 09:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722615323; x=1723220123;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eTsyaqluAEErNMdx/z+obk3JmPuGSgl4hnGYJb9EYqw=;
        b=l5i6hznxZm+NZov4OJVfGJ1qt4zXU6CaZY3BKNBGkpZp0454u2ZLbu0nCipc6B5yv1
         fJ7om4IKS17KekQO4EPSTUz84YcdJb5vrneXLOxuRpi/aYzNNaSkVFU6R50OclQ7LBeG
         swopyb8qJjTYLH5JtKg+iU+c2OP8v9SvCtPOTS6UKMk5LWGhrTGRu7MBh2Lq+ZFIui68
         u/QfPD/IohMuYcIlzrIpyzw5L6DNRoicGIoWzy4KqGbxMiF1SOP9aLJT/BUHLqLuF8dh
         xDUGgDRmIz/yTN2OA10tdOsltnCq4Vsjtj+dkiuoamYqjrcZ1BQkD55ZFDIgPBVdHDD2
         oQww==
X-Gm-Message-State: AOJu0Yx5OEifNSTxtju28pYYXPB+RrRVCJ/OU3JadblziVBqsgxhN5Q6
	bPUnJIEprAyeiHJ5fcKn9hceLy4AyncWjw/GmLZFs9rw+mYKrPyl4b1o4Kj/aiVxXHO2IvV/5Gy
	s6jDDg3N9hcSAjzj8JFhABj8vVEMaYpCQz+o+UZo9VEUCQcEmlZHHObI=
X-Google-Smtp-Source: AGHT+IEdJRGL4kMcOVbpOUF/w7snJ6BLShXspQsue69t4rYRoZ1acV8ECo329K+EjP6BKhHbfDcO/A0UVhV47aIs681LhijfRWXC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3418:b0:807:c095:9d39 with SMTP id
 ca18e2360f4ac-81fd42ab307mr9599239f.0.1722615323369; Fri, 02 Aug 2024
 09:15:23 -0700 (PDT)
Date: Fri, 02 Aug 2024 09:15:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f3581061eb5a2a8@google.com>
Subject: [syzbot] Monthly mm report (Aug 2024)
From: syzbot <syzbot+liste29493ed6d2aae300714@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mm maintainers/developers,

This is a 31-day syzbot report for the mm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mm

During the period, 5 new issues were detected and 3 were fixed.
In total, 59 issues are still open and 254 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  10264   Yes   KASAN: slab-out-of-bounds Read in generic_perform_write
                   https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
<2>  7379    Yes   WARNING in ext4_dirty_folio
                   https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
<3>  1612    Yes   INFO: rcu detected stall in worker_thread (9)
                   https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<4>  1380    Yes   WARNING in kunmap_local_indexed
                   https://syzkaller.appspot.com/bug?extid=691cb37358791bebebe6
<5>  1258    Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<6>  789     Yes   BUG: Bad rss-counter state (5)
                   https://syzkaller.appspot.com/bug?extid=f2bbbb592debc978d46d
<7>  733     Yes   KCSAN: data-race in generic_fillattr / shmem_mknod (2)
                   https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
<8>  621     Yes   possible deadlock in __mmap_lock_do_trace_acquire_returned (2)
                   https://syzkaller.appspot.com/bug?extid=24af80aeb2ae9e47a412
<9>  498     Yes   inconsistent lock state in __mmap_lock_do_trace_acquire_returned
                   https://syzkaller.appspot.com/bug?extid=76f802bc1dee8ba28a6e
<10> 234     No    INFO: task hung in __lru_add_drain_all (2)
                   https://syzkaller.appspot.com/bug?extid=5294aa7d73bb0fa85bd0

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

