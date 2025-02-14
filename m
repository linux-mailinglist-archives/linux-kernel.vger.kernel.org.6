Return-Path: <linux-kernel+bounces-515800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 146D5A36937
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8D3170EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002FF1FCF6B;
	Fri, 14 Feb 2025 23:52:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257D81922DE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577125; cv=none; b=Hjc1mcT8nVa1WN4J4srVipeabF4Nf59I1Z1BbfH0GFUXwCZmvrVPE7UGcKijHCZks6I8tYUhdnylYNMD+rWNxYUm/0KYj4ckbh2Xc2Ti25M1G7bCKxj3hmH/B8zcyxApyGylyuDk7WzQWpn4/v9ejIa2UXfSYSMU5zUqO63aJSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577125; c=relaxed/simple;
	bh=JLu1A9RkvyKso9tMbsx+IzU7iWTlFCyiA9Bsmq5NPdI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=meHBJOlrvwG9azk2rbQ/KIMHs3y34aR+mIOMFDHj4gifAQ9TBqeaPOKI9fS9bHETvo3ScUcRo9tkMI105G28h6mOd9CCt7zWAe9c6kmEJhnAeaJ6cOrd4s6WBii/qNdqsSNWSwsAWOoV1ewMP1B8NexTlt/DaVRfAgr/frzQaro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8521d7980beso197778739f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577123; x=1740181923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L64re1x2kY7RvutqZU0Eeaw1NOUYgPVF87VWkAoKdDQ=;
        b=wrEBHDFLUzTKbIgrYZiXdckqHp4D3V0RZV0fWz36YpvfcO4MwhkFzyjhFvBLUB9Txu
         fmv7CFXPdSTVItlpusvorFA8o2zH6Rx7ELpWOI1Obgbr4I7fPaQkFInBEqkHdH6aOQrw
         sJrY2apJVqqX4fUBrvFaF5PSy7XM6bn/+UCcL2KVqyQhsdhGIaGOuZNFUF0JQqya3Uft
         yth2e+c+g3XYvOG9+vAuCDXGVPqKOtnSeZLF3SQu6Vw6C7ve2T3IqVeKDvYmdXV2PtCO
         l9NV9UkcQOrgW44ehRVjbW4/Pj5O1CltKrYT0leMF8t1XEXgWyKnhO6XHFHAaaKilYAl
         di8g==
X-Forwarded-Encrypted: i=1; AJvYcCWnMwk5tpRRfJ/WlVqsEyyv0kzEWb55mhj7m3LrNUuxyieGY8WLrY8a1IgvSPr82/71N29Hwkm8G5mCgKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZz2P3ZUcAOhY7bKPADbKGX7nKq3kMdJGz6DpWuldQE0Dyv4hQ
	N+iojBIK+ZxSeaPVf5OjgSt1j61BCxOkc42YKJtGhfQTMLWXfNB0TFK50B7Xm9A1R5G2/q7DF4X
	Th6Z04Wd9Zux/h0Gp1IRYY7tSRHohJ2QS+HUGqTHvboHW43SldgWoJ4o=
X-Google-Smtp-Source: AGHT+IF6OTqz+/Nvf0OF8MFeHgLmkk4RBwwvgEqksvFyD14xy021dnBPZnxbn2wSl8yJYxxmsLBHeLzj9DYPGbK0SiORUOtygX2R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8b:b0:3d0:2331:f809 with SMTP id
 e9e14a558f8ab-3d280763e4dmr10332475ab.2.1739577123249; Fri, 14 Feb 2025
 15:52:03 -0800 (PST)
Date: Fri, 14 Feb 2025 15:52:03 -0800
In-Reply-To: <20250214231356.2285-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67afd723.050a0220.21dd3.005b.GAE@google.com>
Subject: Re: [syzbot] [netfs?] WARNING: refcount bug in netfs_put_subrequest
From: syzbot <syzbot+d9890527385ab9767e03@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d9890527385ab9767e03@syzkaller.appspotmail.com
Tested-by: syzbot+d9890527385ab9767e03@syzkaller.appspotmail.com

Tested on:

commit:         cabb162e Merge tag 'v6.14-rc2-smb3-client-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14024f18580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c09dc55ba7f798e3
dashboard link: https://syzkaller.appspot.com/bug?extid=d9890527385ab9767e03
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a867df980000

Note: testing is done by a robot and is best-effort only.

