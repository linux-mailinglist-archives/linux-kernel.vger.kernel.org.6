Return-Path: <linux-kernel+bounces-419345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ACE9D6CC4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 07:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE812281623
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 06:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A74188714;
	Sun, 24 Nov 2024 06:15:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A672F44
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732428905; cv=none; b=oXMDsGPN2MG5o1zMvwTG35zPJs+nDEhz640D3+H5Zmux+KdGqJLkWHKoZPUZS7XOYHVgFPEo8VMjYngqJ+ZuyNbBSoU2zbLWFJHmmVNV8o7NyZ/tHBFCqxqI9YFJzwCKfcrLq+ce2HmJ2/X+rOXdSNT8Yu12GV6tbKGQxpZ9BAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732428905; c=relaxed/simple;
	bh=yeNCFnf7JLEG+Txx7kfYTh9rCxVCgbbE10o8+WBLx8w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WmbjUCfX0ViURDg74FG937eJ4YsI3xoqG6p8aLylrjvw8cwBNh+OplufAgVv35a4oTNlla2ytCKcVZYvhlRrTxkDkvm2tJ6WhdwCpZMppLjD+iDweKIEB08ks2EhKZeOwUX46q+Y7T9gxFXObMkijvgzCyC2GnBVQnOctv1f/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83abf9b6bfaso361160239f.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 22:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732428902; x=1733033702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37DcHQSnQqigjF3B9FsTGkJi7xMOT+nc2TbxsA+afeU=;
        b=h5cSDUS2FfciNHKtl77K6l+egbDPw6hwaSoeyDt1mEcuZLRZdsPBhbo9TsHn1Q1r1H
         +kTh616Qq+8WN5QvvgxX/oTffYEt/uuBkOQvDSX9ikoKEmoEuslAhYhgo7S0TWZv3LIL
         +2akbS1+u+6Qwh/NsSmGxd4g6U6ao+0z8Sz/hCBkv/fNTE0lp2qVZjw5yxps5OpgbaIl
         H7hIfJRW8yggX16fMZ/4MAs8saxxFX6YL4JVIu+XEyq1sigxe5x1XDGtFJhF35e1Ockj
         dJkDmYYYrj2MUxOGmrb6lMrMLYarPhHvywiYYxPMWFN8iQrYlt05r9BEk7wL8zz6QWjW
         Zk6g==
X-Forwarded-Encrypted: i=1; AJvYcCUd9LqcfbScwKrLJhyk8/t5G1tRavQ1/TlJ5s+rDVVsk0PpE/Ttiymgs5wGBPZCaZIMgjKm62CGO6QSh+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw22dIGh3GSq+2MojErBjGDIJlt0Hrn2bEing4yYhFDpHl8BVZv
	RgJdNWaxmtj8og4NyECU2iLbIbaAIqmPN8Pi8H2BRYb1A/7xbxfoVgzTFvLLS2TmCDe+WiB0svN
	k752bFAhTMDGxap286nB1YraZchX6eIQyOENCfVA0hng9UZNOpRX2fP4=
X-Google-Smtp-Source: AGHT+IHDP9UJh3rqI8nZi1MSqLFUDpvVT0wVt5S1MLnMyJKsK9GRuY2H5qd8nRzXlcfdutVRyKeYTPxJifHIQ5RI3PvhoWGNt+4g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cc:b0:3a7:7f30:18e1 with SMTP id
 e9e14a558f8ab-3a79aeacd61mr71302945ab.17.1732428902704; Sat, 23 Nov 2024
 22:15:02 -0800 (PST)
Date: Sat, 23 Nov 2024 22:15:02 -0800
In-Reply-To: <66f5cc9a.050a0220.46d20.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6742c466.050a0220.1cc393.0035.GAE@google.com>
Subject: Re: [syzbot] [media?] WARNING in iguanair_probe/usb_submit_urb (2)
From: syzbot <syzbot+ffba8e636870dac0e0c0@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-usb@vger.kernel.org, mchehab@kernel.org, 
	oneukum@suse.com, sean@mess.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b3e40fc85735b787ce65909619fcd173107113c2
Author: Oliver Neukum <oneukum@suse.com>
Date:   Thu May 2 11:51:40 2024 +0000

    USB: usb_parse_endpoint: ignore reserved bits

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=135d0530580000
start commit:   43fb83c17ba2 Merge tag 'soc-arm-6.13' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10dd0530580000
console output: https://syzkaller.appspot.com/x/log.txt?x=175d0530580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58b000b917043826
dashboard link: https://syzkaller.appspot.com/bug?extid=ffba8e636870dac0e0c0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12515930580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ca8ec0580000

Reported-by: syzbot+ffba8e636870dac0e0c0@syzkaller.appspotmail.com
Fixes: b3e40fc85735 ("USB: usb_parse_endpoint: ignore reserved bits")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

