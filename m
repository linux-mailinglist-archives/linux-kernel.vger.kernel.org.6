Return-Path: <linux-kernel+bounces-362866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C8F99BA4E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 18:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF271C20C58
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 16:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5AD1482E7;
	Sun, 13 Oct 2024 16:14:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24C514601C
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728836047; cv=none; b=ft7WFEk5pgvz9X93IKKz2nRr6HxPD7tnXuewu0rpizBSEtt+zUZGxsARpkyor+w7jTualTbtyjkdlN7WjWcS4nODQNOc6EwueoxHs3q81l7NQ5njHYQ5M2fghvUcJ6USRPOjZtCa8W4WiWrU6qGrZRvsftstXjovmMoH5SJb7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728836047; c=relaxed/simple;
	bh=cxyDziBMrcbpClpT7sQKHSXjaYosTfXj8LBRDPk17AU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iLmIj7eQOjyrF4ezP8mwCY3qCDhs7idf1H700mbsHoRhhZmeDx33+HCzrqxwF6rvCV7B6UZaj251tDgnaklaYjeNhzmuaPXtsxSOPLIi8cwsCQSGyGYzHAuOLokmsOLbVYdEfTurOxop3PBel0FQJWrJ0AvtY+SwhEh8PP6UAWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83542e22fd7so275863439f.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 09:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728836045; x=1729440845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsOc3y9Oz5HGogm4560/p/dh8cnJBNPbUcw760E4xTY=;
        b=jlPSwB8EL7FumYxampHOoQW7ohC3bBM2+QU8OfjfzSq6tH23OjqciIOkmzji96BQqc
         I9HHFaoaQwSAxPaTsOQVfXmDq+IPQ9CS86txgjStMSzw63x8emBRcyEZeFKjxS+w5iHV
         N/w4vIasm8BCN9OglEdPv0gkas6ULZAbYy7EhIyyhWEfDjsayI/4OU6dezwyOGCPTPJJ
         aobj6R7WPQ839ku9f110iyQ7j32MogxaRPj7FG1PTZTgWjwdkemv26AYhmF/YF6FPWEL
         vgb6CeNsA/XBXPbJ/K+vq85Xa4AIXa076rNqk5berbLbGEzmBgtgF7WtoJGUOtiwMmfp
         qCoA==
X-Forwarded-Encrypted: i=1; AJvYcCUM8kj94kKYqMBNF2HWTbhiasrKih/TZ1AEmsNalHU5ugVhZUPhQXf0nqhjBY2zay9ldcpylDH6Cjfd/mk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfxb2ln9OIIAGRRZEGRytSMhmy42AXUW3jhEdMWfb+FnY6q2Z0
	j37mo57kw8HYZ6wILrq56FiTew3Zg/sOCDq5+1OaN1rbz9RjA8WMaGbq5m5qKmLPcwQkTv0pABm
	jhKX2n2PpGA2DDRX/Cd9fWPPS1ZHnmSzpaJHk9WVjX7GTJihB9T+VrOI=
X-Google-Smtp-Source: AGHT+IGaBLNObaP8lW/vvvhGno9pbGMmUbe+3hsP3j5e4q8spuiUpuMd/GXq+5/yOO4w7gxbUAs/bdq9Y54qYG0W2dnF6A26atqR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a08:b0:3a3:9792:e9e8 with SMTP id
 e9e14a558f8ab-3a3bcd9c979mr32522925ab.5.1728836045133; Sun, 13 Oct 2024
 09:14:05 -0700 (PDT)
Date: Sun, 13 Oct 2024 09:14:05 -0700
In-Reply-To: <11dd2a9d-2f1d-4cac-976c-90a1b0ee667e@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670bf1cd.050a0220.4cbc0.0034.GAE@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
From: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, stern@rowland.harvard.edu, sylv@sylv.io, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com
Tested-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com

Tested on:

commit:         d73dc7b1 USB: chaoskey: Fix possible deadlock chaoskey..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14c45087980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=f342ea16c9d06d80b585
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16768727980000

Note: testing is done by a robot and is best-effort only.

