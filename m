Return-Path: <linux-kernel+bounces-436055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACA79E8088
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56E32822D7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD5D14C5AA;
	Sat,  7 Dec 2024 16:12:29 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BB91448E4
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733587948; cv=none; b=qWrAIj5hqegqPH+aAsHRjpdGtJPusXHqFCMuQL6PYqhZ9CnU9K7YDPttwEFDVkMBxYFbHseJ0ooNtzBLTvMoOlrboSxyTYTAk887ezqa+hoqjckxL8CJ4tL1y/ge1Tqmtdd5W3ar9UdQvhP/GHDsU0Rd+K3UaeguhfLWjg16pAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733587948; c=relaxed/simple;
	bh=BM0qNEKyoqiw5u8Eq/oGv7Qwv3jU51gvmnBUjHvD21M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MX3TLUEa/MBUwBB8xnhvKQIeDNHGvlt1xZaMTtuGkLHkuFCcQqpNnDfXoyG9MTKwIIJFR/W/bDg5xDPiSxAsT1gowKPICzHI/KUDjWwD5Jh9h9S+dHUYE2FEeU581iJanH3YhGZiTeuPruuUseZX+rGxhQWy3e5mazBUwBgFsr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a812f562bbso25003705ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 08:12:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733587946; x=1734192746;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NrkbXyO1gWQb08Qbhw9tuE++tiqxf0uwJSolasA1Xvo=;
        b=FC62tocVY/sYwyknhCvnIGTEggtxZQZJ2U1miBEGk/jhwyJtYQ9hTZndiTWrQKb959
         5i4YlZW2a1Ony+T2ffw+Nw1V9tIDm3/uLkSPI0DcJWcTSFucAhAv5vl2tTAhC2To9wMp
         PwdXe2aJsWTLBlGXeqk0MjeV8CjYPh+t+a4wdJSOEhDsHT9lsV4zOcOW+Bfx5n+juXXV
         nUwCCaklPuiWb84p3u5rj7XgJz8D9X5GmJsoxq2OltKeGGlqKzxKfcj0vkZ7LAMe+BJa
         NBmCZimVes6/UFToyV0p0FVr1sSrByAIIh3YyAwkYOO86n/QAhqUgwiN5817zJrTnc/V
         BPrA==
X-Forwarded-Encrypted: i=1; AJvYcCWPA6z68QV387giaMvoVuVu/kX4isP5Sprd0m/yJ2e3O5h4GbnSRJixiUNq/CcqC+RNZCjf0pItFp/xjBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza41Cm79UBNm6cdrv1qNdnvdvBZHt9KT2HeWC5Im7EkjfFuqmO
	Q/UeplPAlW0r6Gy7OMrFk4SUGTzs0IbvJpxcRmHdmXOaQBUrkE2Dg30UlbMizMJnUUcc8hxdTXR
	Ie+s6ANWKamEOliKwSapuesUCwX8g1wi+/iF5c2rJ/xojCEuTYifixjQ=
X-Google-Smtp-Source: AGHT+IEZvxHxO79IMt43jnaEdxnKpXMfM/Z9I2CvNRBeP7EJ7AX8ZUHeQbrJi/5uV4buEbpFDP73/EVVEsOs/FkrIU3QxTpW4/wp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c249:0:b0:3a7:bc2a:2522 with SMTP id
 e9e14a558f8ab-3a811d915demr65071415ab.7.1733587946625; Sat, 07 Dec 2024
 08:12:26 -0800 (PST)
Date: Sat, 07 Dec 2024 08:12:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675473ea.050a0220.a30f1.015a.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Dec 2024)
From: syzbot <syzbot+list298a2131cad081a6c900@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 2 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 25 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 120     Yes   KMSAN: uninit-value in ieee802154_hdr_push (2)
                  https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
<2> 4       No    KASAN: global-out-of-bounds Read in mac802154_header_create (2)
                  https://syzkaller.appspot.com/bug?extid=844d670c418e0353c6a8
<3> 4       No    WARNING in __dev_change_net_namespace (3)
                  https://syzkaller.appspot.com/bug?extid=3344d668bbbc12996d46

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

