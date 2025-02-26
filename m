Return-Path: <linux-kernel+bounces-534215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D009A46439
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E181A189CB87
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730DB223716;
	Wed, 26 Feb 2025 15:11:21 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988BB22332C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582681; cv=none; b=KZqVt+rHBSZAP0FXpCytnksjW+9iOFJyrJ07ncklin5IMvvhCkIokMTuryH4vnpzE4Y7U3+uHlpXVWqKUejVUCJx9ud/nXaKBYmo8vcfXs3zekl/Px/PsNoz7t6E5JY4Xr76lzA25q1oJlMEellPhbIeeS7zitEMj69cWiIBDYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582681; c=relaxed/simple;
	bh=F5MHjnxjp60UbX7C7VXPZhdokYMbjfeRTKKE56j9AOw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ABfTVakVTc5MNKl18Qpb5QmNtn3CYC4WoXH8O8bXL7CiqEabIHZkwOk0I6ictnks1N/c8S7o5vMilCKsLaXNbpKDstSx/9WH5cOkxX7TZ5p1W97UfN9eZz0rS0jBwdjEEAQOIeOh9w/Wcabdej3KUgrjyH9yZQ16scMu6hwtbpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d18a1a0f0eso136576775ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:11:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740582679; x=1741187479;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dLauZLjtD1/TVsQ0moWTJx5/4WHIVlZCeig0SlGWPs=;
        b=QLtbFlwjtlExWJ98Wt/OsNBdyeNW57gK7EVfnCRTAt24uXuk2Tq+gSXFnHXzel++Ih
         yCQwhbqVaRXC4yBZKEeInn035uOz9TbnzszQtQIaIqPiBhUzVe8sVFJx34iTzbI28ssL
         Fg2pcSei6HQr7aUCxR9dsoYE43ZnvCFI+om4+QIgy4t51WTPDrN5M5QxkYPA6X8tQiT+
         l0pqfec1gZ3BiiDJUzrPLHWsVQ6h4rSDE6pEHt4QD3t1JnnC8Rcaf1QnlKZ8LEF/DZzB
         Imc9JIo9tBhp+2bvcIQfrL9N8C3ptwu2umZYJi1GWZwLcxNVjENRivB54xuM8XoAXZZA
         1LRw==
X-Forwarded-Encrypted: i=1; AJvYcCV+4WjmQA72YJkMpWuQexKgs5AvBSooyW7vIoa3HCMmO4Pd4Ju1h3rwJ60wGBUKTN/oeh4fZMYgbp6YULA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPoILET4kscGJTFpOeUhrjyze/I1hj5MLbAg5Pc9FK7rXfEyhi
	xTwCgflZa8fXa7pJwn4BymUXCIx8Z0jdyrATJk2G21D4tEsjbTo7f6BvWdeBlmbqoKEkUcRB4Rw
	GXwr2dolIQ88GZ6HUXxvrzcAPmqlxZlAXVN+UlTrEvNukCYOOAqRhctU=
X-Google-Smtp-Source: AGHT+IFWNkOZPpbWaIscX0T93fyWvSpD2MSpDIArX7UaxaX13x6kE4c5nSkLpJPQdJ+/g0COYhrtnDi65vQXePfzfrS1M6ldb2DK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a64:b0:3d1:9cee:3d1d with SMTP id
 e9e14a558f8ab-3d3d1fa94camr44865315ab.19.1740582678784; Wed, 26 Feb 2025
 07:11:18 -0800 (PST)
Date: Wed, 26 Feb 2025 07:11:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bf2f16.050a0220.1ebef.0020.GAE@google.com>
Subject: [syzbot] Monthly wireguard report (Feb 2025)
From: syzbot <syzbot+list4d08105289e0b54474d4@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello wireguard maintainers/developers,

This is a 31-day syzbot report for the wireguard subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireguard

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 19 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 356     No    INFO: task hung in wg_netns_pre_exit (5)
                  https://syzkaller.appspot.com/bug?extid=f2fbf7478a35a94c8b7c
<2> 125     No    INFO: task hung in netdev_run_todo (4)
                  https://syzkaller.appspot.com/bug?extid=894cca71fa925aabfdb2
<3> 121     Yes   INFO: task hung in wg_destruct (2)
                  https://syzkaller.appspot.com/bug?extid=7da6c19dc528c2ebc612

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

