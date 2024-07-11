Return-Path: <linux-kernel+bounces-248878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A2292E310
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2BDAB27019
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510C61552E7;
	Thu, 11 Jul 2024 09:05:26 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E55E15531B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688725; cv=none; b=ZducGyCVZtbcR4EoQTnl9FCaivU1I3uTA+cIHXWEY2nuFJ4/Zze1fGQwxRFJUzirlDfOvIaxTa7TljIK6y+Fq1Z55ll55EHfPtsGcMCU6uYr2CTfE3jkZoD/unDYD/bjahDiijIWfqNZloTs+Q/b9q2HzWy6m28NNWmXbpR89K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688725; c=relaxed/simple;
	bh=XYxlmIIxPz02XwPaWacMEo7iOd1/ezQpDI9Rfq2LOeY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZkvEpw6wo4QDaj0++sdyj8TDAgWABvv4zZ5c6WrkNvmSKu/G/vPOBDw2wv4YGmZdENtCc9F3WddRcQaiQHwHJQxQE1pWvbEq786i/1+qzNzMg0CNsPXffC6dgwL6g/thehdEFJhSXLB5a3aO0eWqd2NxzPqtMUewy6pWCwNqpmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-806199616d0so72641539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720688723; x=1721293523;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q7aYs+p+RfqCU0uhnQSbRHQOaf5R4fG7X9jEJfO0KnE=;
        b=VWQeIBP2kQkgpve71z4W/iM7O4kam/1N897IzQ+re30r3gxMXBzOeU3sC6bnebA2E2
         SDSfkWxmwJqnJ7UMglMS6ygFE68kD4+R5XZU9HHIYL0iPyGDN9ESbkjBbacnluL9ZY2w
         QmaRHfi8z0R0eWyrIsTl8Is/vDzG+wb5Dumqp5QHq1J9ZGiJqSObeiDKKDnnLLMn1oZd
         FAaHEs+bLRLimNpDfB62UR+2L/T9NCldjSkzlldasqv5FGr8dMQi19OGRanCiQQgufu8
         59mdFp3DkpR6BoSyz0rVfM/wDJ3RyDwLfYajeX2XgbDwYtrCbZk/1tGIa5aNkYiRoD86
         O+9A==
X-Forwarded-Encrypted: i=1; AJvYcCWf0briF35ozAbSXuM1cTayF41PG2pIVhAmQ2bz8aNrIUR+wu6oqD+3NaHEif/ktOnhnq08XfTxoTYj8eUsVIzXa0b026VvPh5XXOiU
X-Gm-Message-State: AOJu0YwaSWUh4hi7VtSP/otsmwjrn6cZsxwhBt8yCABgEnds9OAFhMzG
	T02vGnw98QdfoLQ/9uv6Hl8E00PDnSCDhbGRwIT6ilfrHCX5mJGRLobUpOWGipuio1Sgypcf0Oz
	Y9gZh0B02KmBHMBn/3aZ+K5csvDTEAuqYFs1exyWkgNstQAJQBbuW+LY=
X-Google-Smtp-Source: AGHT+IGYtCi/ADkFom8VByt8aL2zMv7xDwr+t6sNcKBkUPajUBIpF2U/zImfTaCTNjapCrHef8rySWSDepf9miD8zk9mcuTGKkOQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16c1:b0:4c0:9a3e:c26e with SMTP id
 8926c6da1cb9f-4c0b2505225mr478967173.0.1720688723580; Thu, 11 Jul 2024
 02:05:23 -0700 (PDT)
Date: Thu, 11 Jul 2024 02:05:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000236b8d061cf510dc@google.com>
Subject: [syzbot] linux-next build error (17)
From: syzbot <syzbot+96c36598b73a9d3f3e25@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f477dd6eede3 Add linux-next specific files for 20240711
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1634d47e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=96c36598b73a9d3f3e25
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+96c36598b73a9d3f3e25@syzkaller.appspotmail.com

drivers/bluetooth/hci_qca.c:2501:10: error: label at end of compound statement: expected statement

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

