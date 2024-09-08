Return-Path: <linux-kernel+bounces-320320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5279708CC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 18:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D97B1C20DB2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D277175D5D;
	Sun,  8 Sep 2024 16:43:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C6171652
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725813785; cv=none; b=ppqNbCrTa87/PR33gfN0GPd4WGNY2ZdWlPcPoPfB1rk6Bbne0tlEaQfH5Han6EaeaWQILGTYSZlG7q29mzwVBQmuxh5wnC+X9MEoIK716JA5KKUPJ3v5fpHAOkAiD4c7T0sgcB4D415d1Z0H7nqTZRRTeMaa49G3KnFDidxeWzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725813785; c=relaxed/simple;
	bh=+hpRt2dV5nPaL/nXyAs/uGkUnfPrWQbCVMJPn5e929Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JZWinUL58moMUXZNdHjf/etpH0JBX+iJmN5EGPNBuLhR8LwhvpO+MpEMwjeXvHmclY1yHkmnvldOPyNFk6tl50BL254hOmsK/cCZuCUBD1rGpjnKVMIT5wtrQBHYBW5YI3YNW6fAMSX3LsmWqzbsEk/AJOjdcYKlCGmPDo1Qjaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f5328fd5eso57630955ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 09:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725813783; x=1726418583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+wp0usBhcD98D12aDAt+WbEjn/+6VIsoMm0S/3mqMI=;
        b=QiyLN7qXSKgVHgnp7GfzZq2Pi/Eje2dL4UXi6BoTjltmEcDVOH+29awbfb5iKA1+fG
         xCHBytKRSOQGg3UAEV9eF05G1NWRccsCGNdOQyvZ1nk5q5D2iVOtK58xjM4o/IiUiMaV
         DYV1uR5wvSInqdUCjTYEnzg2k5QrN+m4GrhNm/e9XZnaMfE7DnQs5aASu7BLGg26EQo9
         jpJTIymPja6D2gVWPfLR02jmWxLvbMsrEXZ5w/yqKtZ0A6MPzFbaWXW5hcrZF2aLy5nU
         dgJ7gY8hZwrrfnBLu0djlN4XaAgJTWRycXBapDEmZ4NefyYYPQ4Bole9UWqraJxLzTln
         ITTw==
X-Forwarded-Encrypted: i=1; AJvYcCWhoBOvT2MHUBoqhm4tbGheeL/K0owNSDKWOt46HbRJbD1is+F4H09sFnJZ8EM1j1JviVKIefL0X+Fs5bY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGodpg7o0NWSHRUlTrCR6ckklky0O51tSBAV5uz6HKzQZgDM1K
	KqTBchmS7mJ/7c+fk4FxGhtpMqgsFzIkvWyiC2nlIkmyTRtJyM+gz3jKHtB/pG/lCV4h4etuZS4
	O0qlwrRoU99Qc/quqBlt6L/L4EAgupMJNKqR8x9RlHBTsDIcWSe2VGKg=
X-Google-Smtp-Source: AGHT+IErW406J68fk8lzI9LE+Br5vIRWQbo3xGD7mtxZhp3G/swle8CJ+fMHpBuJiwZP8Jv49IExS2en+n4PALMBN85sEoQb4UpM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c27:b0:3a0:4dcb:de0b with SMTP id
 e9e14a558f8ab-3a057461e7dmr42929675ab.10.1725813782959; Sun, 08 Sep 2024
 09:43:02 -0700 (PDT)
Date: Sun, 08 Sep 2024 09:43:02 -0700
In-Reply-To: <000000000000932e45061d45f6e8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b685f06219e55c5@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: brian.gix@intel.com, davem@davemloft.net, johan.hedberg@gmail.com, 
	kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com, 
	marcel@holtmann.org, mlevitsk@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 275f3f64870245b06188f24bdf917e55a813d294
Author: Brian Gix <brian.gix@intel.com>
Date:   Tue Mar 1 22:34:57 2022 +0000

    Bluetooth: Fix not checking MGMT cmd pending queue

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138c743b980000
start commit:   f723224742fc Merge tag 'nf-next-24-09-06' of git://git.ker..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=104c743b980000
console output: https://syzkaller.appspot.com/x/log.txt?x=178c743b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37742f4fda0d1b09
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110c589f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139b0e00580000

Reported-by: syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com
Fixes: 275f3f648702 ("Bluetooth: Fix not checking MGMT cmd pending queue")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

