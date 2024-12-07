Return-Path: <linux-kernel+bounces-435867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8297F9E7E17
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 04:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A09F2867E4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 03:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C457525632;
	Sat,  7 Dec 2024 03:22:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAE917E0
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 03:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733541725; cv=none; b=D/chtCDjZJnf2NMSZFyyIvIYpia5OanDvTdsjw01Jo7lyp2kxdDULJeQMS8+BUR0SESd820CCOIMgnL/RrWUefwIdRZuSFOml4oLoKsLoL3vArtvcLY3C9J1+iDRnBidRtxF3sTZpuhAzdg0MwN6Y71M841BwmMrr6qbsCCHIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733541725; c=relaxed/simple;
	bh=BnljTXdlYN50DMGeFWCDp31QnQ8aXghUO+Z59lgfU0c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lsQEmXuDlbOySZHTK3oEF57FahyooeIYutpbEXRSWVOYS34Jet/ulhjtXUrPQ73AHsHU/qmnkURV+sgspzrx9oQC2KCmUDTcIMElu/cS8aWpRfwOKLT46kI2/CrEfDie8K+Cm1pgT2650FETbihicDMwxXJbuo+Jg1sTXf/j6Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a76690f813so31454015ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 19:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733541723; x=1734146523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5Qj040SRI7Wx3xaA3KWy1TL1FfzK+JXHmIPLO2Q6XA=;
        b=a5RRgCP33uPPCDWxVRUMxg5tnrb4l+JBERQhArrePSzGDTbD44oC95pxhhdsfvTsJp
         A9qKH/auBBgsV5mjZ+94r+R8Fr6wptD/iPOoUDu76jdGmP0+pbVXYqwqRlIoqCaRbvWp
         oeWjxBZKc7PVKZLzjnVHPW6SignpbOftEV4WA1omADjCL3TwL46GkqCTRtP5oW+f8g9z
         Yqm64x47iiH2OHUrGQaHKXgCCrkdklXb+2BtelofByvsrIEiNRfKLThGzRAtF7O1EEPS
         A2WyKEdskg7HIl+ubponghld40lcbf3dSDbwvUHgn8NrBlwKcEEX9U9pO2mEfXWC0iXf
         OGDw==
X-Forwarded-Encrypted: i=1; AJvYcCU9Wdm2VBt2aPOyUDgdYQOaUO6y/wMTAcgUxlF5LZ0S5tEIvNe2hTqJoPzcATiQkzYDrx4wc26VRuqRXVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmI/46h8w4xM5oIXeBoqyxdtfF3Dh63x05mK0XkVDq+blDuEdv
	/MZ2Jzh/r4w/Lvns273hH6BoRSWpGHnOoJJFkOiawWl5QZgPB7p6VvJ0Yb8WZWsef5bDAG3W5KW
	/M4QrMknWmGN9QaVzzaeaoG8lxE54dbbNEcS05Ot5fpCMfRxftGLo4wo=
X-Google-Smtp-Source: AGHT+IGSW6pnpNS27k8Ktth/km8BI0TDhzRP4J036lD8lC49nucx34NQF+zukEE5J5kzJRlSzERds7FOKTxm3x3+iJoim9HR954q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b23:b0:3a7:44d9:c7dd with SMTP id
 e9e14a558f8ab-3a811d915d3mr70085925ab.6.1733541723202; Fri, 06 Dec 2024
 19:22:03 -0800 (PST)
Date: Fri, 06 Dec 2024 19:22:03 -0800
In-Reply-To: <20241207025731.839-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6753bf5b.050a0220.a30f1.0150.GAE@google.com>
Subject: Re: [syzbot] [net?] [s390?] KASAN: slab-use-after-free Read in netdev_walk_all_lower_dev
From: syzbot <syzbot+2eab87cf3100f45423ec@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2eab87cf3100f45423ec@syzkaller.appspotmail.com
Tested-by: syzbot+2eab87cf3100f45423ec@syzkaller.appspotmail.com

Tested on:

commit:         0f6ede9f net: defer final 'struct net' free in netns d..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1273a020580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=2eab87cf3100f45423ec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c3a020580000

Note: testing is done by a robot and is best-effort only.

