Return-Path: <linux-kernel+bounces-236042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BB691DCC6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A648CB24D1E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA1013D53D;
	Mon,  1 Jul 2024 10:28:23 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5671584D29
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829702; cv=none; b=stBQAV4znKx4rLTb397rZ4cNj310zmerD+GDbxBKmx7z7/apkB7a+IctmiPq5RtLsrXHqjHp5kE4jFp4cBXbioTCUpsHov6V1uHWgRU1r8DSY3VzOtCqmPG1KZ67jt2e5gKoG1+IS1Ed37jrTvjrVEcZqvyIOtRiCUKNZX/LHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829702; c=relaxed/simple;
	bh=DnEPo/xf9WnHKoH3OJd2mrZuxBu2lNiwSdLbqVJJf5U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qJ3MXPhnlT7h0VE7vJwd4bSXww+/4e4JqAPoNQxJcm09bVz7Z1/xuGNdKnNgDIznNt6JNdCinz9JejV22CJMVvrgH2DzYzeFva6Zg2gr5fgaT9qZz8xMH66/PjA2Tk6H8Ak5PuIYzhfn879yRGzlU3z8WgvXPeeMY7arlWSVl34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f63eb9f141so60229939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719829700; x=1720434500;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ruV2LAJ6KiwAciGzXJ+N8cMYlHrSUSgRjRUOJIF1H/Q=;
        b=N3YsJCByP53aikI2n1F5FuZCNJzvwcOsQHV89DyclZqi7P/SMvR+9aCaUieUQBryu4
         +EkNUMP0vrgRavE0WCi7hWRhWtNugJDszjgKPMHmJI2sRCNt9t/iVrKNbEWpJ0cnf72x
         rxks2Ws8UFKeWr0lZolAgPyzdkHM35cC32aMnIrIWg/fI7R99Bft91iMRWbLYge7tqSE
         +eJbVbmdygQTPvxUsuL7IHVuzkj62yiDNdTt77B5Y8eiSSydawNJ5y9lUSx7IpRxgqCD
         vAJ6Fm2R7xb3OfeXRUKiWSjp8kihqAyQfGbc1yMvol8GtXKb2QiZ7NX6dlehDa3R8k+l
         aS7A==
X-Gm-Message-State: AOJu0YyAemONNv39x7FdyHhgleHmyCGlv2Lk+OQpadn398YYMD0sEVOw
	/wiFjfccs0INVajsG3Kx8McXguAdDIujSuLignMOELxsNVvdFNHCzYQOkW/7ZsfCS4EaTQiEN8B
	vtHoRIKHwsWgWEsQazm8Xk9phsugPd/r9KILEc3cm8k7cISRSJUPJ2e8=
X-Google-Smtp-Source: AGHT+IFW766DtMSLQJQM7RXMSrbrj4aMiL3vegatCLghtEzzD63IsACbfCF18YPDFqaVvWfyYiUvHzyj6jHfH+NJp1aGJjfyw2/2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:372b:b0:4b9:9c0a:6f6c with SMTP id
 8926c6da1cb9f-4bbb59453e7mr362017173.1.1719829700572; Mon, 01 Jul 2024
 03:28:20 -0700 (PDT)
Date: Mon, 01 Jul 2024 03:28:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000608993061c2d0e8a@google.com>
Subject: [syzbot] Monthly mm report (Jul 2024)
From: syzbot <syzbot+list5e8ce18f353ea4d24eba@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mm maintainers/developers,

This is a 31-day syzbot report for the mm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mm

During the period, 5 new issues were detected and 0 were fixed.
In total, 64 issues are still open and 243 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  10260   Yes   KASAN: slab-out-of-bounds Read in generic_perform_write
                   https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
<2>  7378    Yes   WARNING in ext4_dirty_folio
                   https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
<3>  1194    Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<4>  1163    Yes   WARNING in kunmap_local_indexed
                   https://syzkaller.appspot.com/bug?extid=691cb37358791bebebe6
<5>  1020    Yes   INFO: rcu detected stall in worker_thread (9)
                   https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<6>  783     Yes   BUG: Bad rss-counter state (5)
                   https://syzkaller.appspot.com/bug?extid=f2bbbb592debc978d46d
<7>  722     Yes   KCSAN: data-race in generic_fillattr / shmem_mknod (2)
                   https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
<8>  477     Yes   inconsistent lock state in __mmap_lock_do_trace_acquire_returned
                   https://syzkaller.appspot.com/bug?extid=76f802bc1dee8ba28a6e
<9>  229     Yes   possible deadlock in __mmap_lock_do_trace_acquire_returned (2)
                   https://syzkaller.appspot.com/bug?extid=24af80aeb2ae9e47a412
<10> 163     No    INFO: task hung in __lru_add_drain_all (2)
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

