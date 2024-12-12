Return-Path: <linux-kernel+bounces-442977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F83D9EE4E6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6EC2828A0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7D5211704;
	Thu, 12 Dec 2024 11:21:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435972116EE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734002465; cv=none; b=CP1L0vPErL7K+kvtB+DGkwABmt5cya42F+xwAM/e4/l/qNZxDCrHPWiaN1jXOcXPf0R5nvLrAL/0kYEDxz270Qdwy56f2+rjfWjykg+2RXRCHqpHsT0XtipMAZB/jUuAV1NAkUdlAFgUc8xQ9/4q9rLB+NX9y2zxp5NRzwEYTQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734002465; c=relaxed/simple;
	bh=Y4XI4Ells3mnYGRwVSRKFnxFRULix5bUEreIKmF5zqE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EK5adTV7ye7iyLYjUWdqZMXGltMvPWs2AMtlnmozOsHNnOUeeNb61HFMGyYwDeAD0k7/A/NsFmpxTDwrpoo7Ca3+buEXVnDwnNUcjhHMnmx6bcVO/gY7pbVHW8klZSq5FRxGn0sE3uasHrV18u3PNZ1ugCcDbh45Rg3W7sthsbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a9d4ea9e0cso4588455ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 03:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734002463; x=1734607263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efoVXz7q0jZIiG+6cenIdyRJUBuEPqT6nO/eaTRVO+A=;
        b=fQu3SP2fK5Y8oIoX3R6rIiIY5tUCYLQuNy+4M3j/gQctZkXWRZP54zg5l1eukYnuWc
         R+5tyyFhM8rwWlFrfFt3m06ADc+RKe6wOtkDyjQfuEdeadww+mzfEtYmL0DaVujhasEf
         rbzup67MiOWwgjAjpt5seQTShS4pEoNRM4qfM9g7ZRx+HAKMApTAGl/vxoRC0PQY9UFv
         9yCBBMp4rROtSUIifV5VDSjVxiWiYku6MdFS+DSK+3fxG+4PO73IpWqK5Ah5ay/QdJdG
         sun9wxjWLY7/JJbkdhDoh87OfVdwuDF5L2OuZ+zFIpKT2pt38cxVaXGtD4Np3UUdeAXQ
         +Jgg==
X-Forwarded-Encrypted: i=1; AJvYcCXCtJZbeOFTkMJNzwGXqKVD4UeAPU4rJEEpAwUUn6G+jYuWa/7o37iUihteRVr9zBYfiK1T/T3sM8E1aKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuN3XQzJOHqqvhaFNuHuL6JEvVHKD4M4/LWULfmEwE/qRK0kUd
	BTdrq83TE10a4QxG5BKBSpV/WGXW/I/UBOF5l3vTOicBdVceepnUqWfKylQKMwM3xm95UF3GIjl
	Oc7zXswvej1geA+cFzTRYcRx/0jU+Cu1sbgi/ryS7JVkPAM/Qdx3ta20=
X-Google-Smtp-Source: AGHT+IGaaDO3YVXqZI6iELV8/LOtGxjLYb6+FlxKhT4QZJSL0KbR4UQseJ8xjs+4CBrXQw0L7MIhbZIugmVDrByK6corfJLZHVNH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8f:b0:3a7:a553:72f with SMTP id
 e9e14a558f8ab-3ac4b436698mr22783755ab.18.1734002463268; Thu, 12 Dec 2024
 03:21:03 -0800 (PST)
Date: Thu, 12 Dec 2024 03:21:03 -0800
In-Reply-To: <PUZPR04MB631619A22F03DDBDC97905DD813F2@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675ac71f.050a0220.20c8bc.0002.GAE@google.com>
Subject: Re: [syzbot] [lsm?] [integrity?] KMSAN: uninit-value in
 ima_add_template_entry (2)
From: syzbot <syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com>
To: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, roberto.sassu@huaweicloud.com, serge@hallyn.com, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org, yuezhang.mo@sony.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com
Tested-by: syzbot+91ae49e1c1a2634d20c0@syzkaller.appspotmail.com

Tested on:

commit:         231825b2 Revert "unicode: Don't special case ignorable..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b56cdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d5bd2f63a4859d
dashboard link: https://syzkaller.appspot.com/bug?extid=91ae49e1c1a2634d20c0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133e6cdf980000

Note: testing is done by a robot and is best-effort only.

