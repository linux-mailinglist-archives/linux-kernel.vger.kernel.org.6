Return-Path: <linux-kernel+bounces-258177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE019384C1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63351F212E8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F591662E9;
	Sun, 21 Jul 2024 13:36:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919A8161901
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721568963; cv=none; b=lF3lEvODAME64+rRCP7espRvl0YnHF3IdtbKBDmRl8dzYwQ/hYKk9PfrOOKCOCrLTQQsXojR1Y1v1eFehaJ/cKMakJgX/HRM3Bheoc88+o2AWLa6Au0EkYoly77JZDJOxxdCw3NNWut41BXiJbmmwEhcqBrkb52E3KXVeQIBNNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721568963; c=relaxed/simple;
	bh=4U0BbAADFywgbtDIyIVL/LjKJ3rmL8ea7vGwwovYG74=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qpPb0ZxOKIW2CtujBAQZJ8WZ43ucf91SLi4ZA4iuGegpTGR43xOvsHiiU7Scsbps66NLaUInn8UtQKxOEJ6qgeRi/OQFCSAWQtzFu5p1tWKAbNThj8mzhxteAEMiF04eX2jKKeqpgyWUoDWrn4uyaYMvbxuQyr6CHwL1B16SDnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3987dace329so30070505ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 06:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721568962; x=1722173762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nz1UnFLAroi3pASI6lDspsZ447bwQwghhsCOEF90SzY=;
        b=gmEqTSzzizBubSDPLQPDlOEu5ePNjUrlleA0ge1SCdkmD97W3QfyZH2qCgkocnIrY8
         1Alk79nA1n7ZmA/G/yKGXU9gOWfO9zsrFMrKogYfrCYwV45OfZAboTYgWLQeCY4G8+gv
         AaXZSSwYKwYpSwzI28s3P54WsMRbl88fnjMD4elNjUq9bVDH5C5pNoQLZca/VXzdJKAz
         SL+NTlqZyrRoav4cM8vsWvVuzqHn8clsXu1Xp1PPPoKkPNLfdB/h0kBTO3knSVIbMfxr
         9ZqbE1CNPm0ueZcfyDeliOMQ0sXkHWZP1zY4OUAc3zn1/ctORLjJ1GLFxreKPIgZKFi5
         Ka9w==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+KwZRGC0jVeGPvI3vcLbGs7u5iKYNhaCLtlDFyEUKHQSzWLT6GomYzB8tEL0VVuTVSNr92HjiOujgPBQBYxwL0B+/DwzBNsQfCS1
X-Gm-Message-State: AOJu0YyC51JYAT2+67HaPlFMgxoDCg9xguQ2qP61LO1fZIoxgqXRz4FB
	tskjTjqdMTFo8jNNI6Knii04hk9HEAFWn3sz+Mci3p7Sn+IfQnGJNNOZQ7AVEVYaM8r0PUBMqwc
	F3jGYIed1S8XnD5C5ddEzSCaoHPo51KEDsEQOy/7jd9Oup6HXPuYZUkQ=
X-Google-Smtp-Source: AGHT+IEPG2xFPa10wFFssYabV8AvacYNIR5eSjxQjBBTIk68tCS6oDKI5bQyWj0iRsonWiE63orhnCn6N1iOOL88IUCRu7hglyl4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c04:b0:381:a6b6:2dbd with SMTP id
 e9e14a558f8ab-398e725d3f0mr4496465ab.4.1721568961906; Sun, 21 Jul 2024
 06:36:01 -0700 (PDT)
Date: Sun, 21 Jul 2024 06:36:01 -0700
In-Reply-To: <000000000000dd5b9f061ab3d7a4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006e5e08061dc2027e@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in uevent_show
From: syzbot <syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com>
To: andriy.shevchenko@linux.intel.com, f.fainelli@gmail.com, 
	fancer.lancer@gmail.com, gregkh@linuxfoundation.org, 
	ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, marcello.bauer@9elements.com, rafael@kernel.org, 
	stern@rowland.harvard.edu, sylv@sylv.io, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a7f3813e589fd8e2834720829a47b5eb914a9afe
Author: Marcello Sylvester Bauer <sylv@sylv.io>
Date:   Thu Apr 11 14:51:28 2024 +0000

    usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d54f2d980000
start commit:   d35b2284e966 Add linux-next specific files for 20240607
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11d54f2d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16d54f2d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d8bf5cd6bcca7343
dashboard link: https://syzkaller.appspot.com/bug?extid=edd9fe0d3a65b14588d5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10905c26980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1122da8c980000

Reported-by: syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com
Fixes: a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

