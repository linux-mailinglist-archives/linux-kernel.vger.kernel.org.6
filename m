Return-Path: <linux-kernel+bounces-412339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CE69D07CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7506B2814E4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72F6C8CE;
	Mon, 18 Nov 2024 02:11:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23398E55B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731895865; cv=none; b=HqyN03ui+ktXihl8X2PDhvYBU33DnZwf9PlvUji+akGSAWcaMycaUbg4SUjwshb7J5gjCg7UOdJ4jS1Ol7S7CB7GqOFfypM8D+tkhZudks8Zs7gsb/9Yl4JaNU5rRL0BaJeaXhAgqFGK65dkP8c212xYw+8QUg2/5b/QSmzEB0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731895865; c=relaxed/simple;
	bh=QK7sIY8M+IrW+RZvWRlrIl2NsnTi+YW+tfhTh0csUes=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L3HncJMBbxHGbGEWFvrN7Uzk+BqDLqZiAhYhs5pifKKkzODiHhYH5lp81d7x4o96o9GWsUgD5so4Bscx3EzHdO2rYAwuo+IQKqnJoSsc4CsgRcVDDQutV1m31NnLxRoLmEMBuqYWdzmSz42Q2bJtZM+QVEUh707u1T7qcLPpBKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a5b2ec15a9so14553745ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 18:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731895863; x=1732500663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hJIx6WfDmpxQ/UBdnh4/0BL3aYTumuuJumPpL2ygUk=;
        b=J4qLJBCZRijfaVGytdA4U6SFZG5r56b9zrCYprMtkacCflK1s7Q6AP42461mfpu6pu
         Ja5EALE9Npr4waNe0M0Ffn3PfU5wW3DtC5QYwXPY2hk8Xg0Z+stmVbxCV+ydx2oasv4Q
         uQR12uYVIO7yBXkCrU+2HtV26oVinkizLEZlidlCn7oOKw+FrMIQKFxe1R9Z3tMZnmNG
         tbG/6WRGYVbtBjUwQKtUo0d81yPSCBQJ1sBpzXT+tSCSeCw1vliNlXe6r/YebYhb0ral
         EJ3IVX6gN5eUSHa+6Ck8OrySF1HRH/ogjsdF8QML5m9tZTatspi/qlpvtZPYyPQd1X4w
         xVoQ==
X-Gm-Message-State: AOJu0YyJxlf0CTDMoJCuDTxofNRVFkoYuj3fxkYNPiAjc1XXs7QBoNHP
	VXwVKmgfojmbM5li0hX/JhI4lMUlRNh+Lq7Amk8JKmej/cyl40h6msnpkQC5wcm6JcZfV/6YueS
	H8/j4vFHjPoAb1txE3j5egiebRek3Kt6MH6qJ86Sd7vpC1wKFnWIsZ5g=
X-Google-Smtp-Source: AGHT+IEjp5C8xmbQeGhesA4I5ppfhkMssRjnIfI9WGZK8LiKEBJb2fZlLZRwRskyzvtqk9GJ7HrJglIGTdt7nE6nQdACr/3oHsyh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a89:b0:3a5:e532:799d with SMTP id
 e9e14a558f8ab-3a74800f3efmr120124935ab.3.1731895863266; Sun, 17 Nov 2024
 18:11:03 -0800 (PST)
Date: Sun, 17 Nov 2024 18:11:03 -0800
In-Reply-To: <20241118015156.3320638-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673aa237.050a0220.87769.001b.GAE@google.com>
Subject: Re: [syzbot] [mm?] [v9fs?] BUG: stack guard page was hit in sys_open
From: syzbot <syzbot+885c03ad650731743489@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+885c03ad650731743489@syzkaller.appspotmail.com
Tested-by: syzbot+885c03ad650731743489@syzkaller.appspotmail.com

Tested on:

commit:         adc21867 Linux 6.12
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15cf32e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=55f8591b98dd132
dashboard link: https://syzkaller.appspot.com/bug?extid=885c03ad650731743489
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ae3b5f980000

Note: testing is done by a robot and is best-effort only.

