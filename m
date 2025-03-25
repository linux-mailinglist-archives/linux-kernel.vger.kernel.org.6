Return-Path: <linux-kernel+bounces-576021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ED4A709FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62517176A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823B01D9A50;
	Tue, 25 Mar 2025 19:07:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1252E337F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742929625; cv=none; b=StbOMTnzir29fUuIN6ioRJBwxeq2VofUL7RPj5M57zemfh6xtLuPFTmGWFfQNfqIMGF964ZKd+8WuB8WfKRIbzgNGhajd/CQL+leQljALFaa8yXBuUcmGDcz1MJ/5JrIbw7QqxaWJrayQz1X3T2S28QuBg7bY6MmlTLS2xSJXsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742929625; c=relaxed/simple;
	bh=WOM/LLp0RgmVJoWJDMoK3chj3lsZU2VAedMMvNUKJrk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hj8/pOnTmgVfbdhmRBggBlvklrcSh+FsUOfbIVlA5d7BhGkXlcnqTFRTsPg/bxF7f5peD+YaHpR8TDITeor9Oql0jHgSRHQnhGwBcneXprgPN0dNj5ACMpFsP1t91L8S9lc5zKlXh/Y8nLE/TFuXxMh0KV6l0pvzPYya3GLVMds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d4578fbaf4so115365285ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742929621; x=1743534421;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsIsSKwvnvgu9UvmVVPieDuoJRM8nMXrJ64iZfB2uCc=;
        b=pp1uVgP5Iw3y01zXKABnC6len2WOzLbb9YToD2h75Vl11RiINJmqY9cuoXsuBdI16L
         52y1/76dpsqAVorrK4t8q85AiXBCWGhtjKkwRXhAtTtLXGuxtmWGqKYfkJvikL65QpE2
         XletJadlYkSEawH/NFjIW2RHRe0TbEk5hZuK6cknGezw9LVtX+NPkO9OI14VYnGWzykG
         EoXjyI6YUY5QpaiVGtH4dYuQ3be3zg/sJeSvbB/TVCbmoNBwSO6eSxhQZl/lC+gqHjWV
         Q5e0TWFo3UHm3+qaCq43r4dmeie33l+ngsb+x8o8cLUtUYWCLe6jt9U20GkPQjaCN9qt
         5j+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXH4d3ndkADoMFWqNmVePj5M1fLxB3BgDINk8xuQvqSmttC+Y5sY+JsIH8iVzssRoCVOAdXnGRV7RlR/Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxve4hIjTK5aFf7m3f7mG3bAFOF438f30jNB6kyh23jKOCDYVjr
	C1TyAFklkryR0YOSsOPlqaEvZcx7tlq3v2QVdjZ8cfGvNIvFapugAMBYqF8ixziWmgYfEYZO0JH
	4xcNPnW01n7lTCaNf7Li7ncZmT31dxZlaRte+OFAoLM0TQxP6uzbAvjo=
X-Google-Smtp-Source: AGHT+IGPKv4GLrmy6f48OwPKgG50sMNIwGNkNf1MrfozlyeG1piUknHPlp7DUKLvYSUoScAO8IdC/7+fA/Lmxz1Tf1C42fuLvLTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2683:b0:3d3:f7ed:c903 with SMTP id
 e9e14a558f8ab-3d59605a645mr207012955ab.0.1742929621482; Tue, 25 Mar 2025
 12:07:01 -0700 (PDT)
Date: Tue, 25 Mar 2025 12:07:01 -0700
In-Reply-To: <6bb3b80b-a808-4992-8666-535ed9a5c980@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e2fed5.050a0220.a7ebc.0053.GAE@google.com>
Subject: Re: [syzbot] [usb?] WARNING in dib0700_i2c_xfer/usb_submit_urb
From: syzbot <syzbot+c38e5e60d0041a99dbf5@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com, 
	wsa@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c38e5e60d0041a99dbf5@syzkaller.appspotmail.com
Tested-by: syzbot+c38e5e60d0041a99dbf5@syzkaller.appspotmail.com

Tested on:

commit:         5fc31936 Merge tag 'net-6.14-rc8' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17c1324c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27515cfdbafbb90d
dashboard link: https://syzkaller.appspot.com/bug?extid=c38e5e60d0041a99dbf5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1459643f980000

Note: testing is done by a robot and is best-effort only.

