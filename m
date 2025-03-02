Return-Path: <linux-kernel+bounces-540814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C68A4B551
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 23:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B50216C7D4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 22:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613311E7C32;
	Sun,  2 Mar 2025 22:37:24 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6D61EB9E1
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 22:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740955044; cv=none; b=hgf2rM/ZHNpQgw01G1fk4ho6bU5TImZcFTHPAp/vk7XTbvL0P+mPAOzwhqf52jEx3jClBj5xw60tsmD3K6fm/Z9hEaHqkmGgT/8gnTh4DqaXx8oxAZiV6SSSwa+FBakR1xpxDb4dTCnlb1m/KYQnCLDcylSaioKh+pzZy5WE7U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740955044; c=relaxed/simple;
	bh=0DwsUAsSJO5UQn4bmGPqqVWlWH5R2lmMZ64UhyrEuAE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c9VHViG/cSQoMYUtH/LzMeNf0BnvECdRHX1WbAO90j69ONgXFxL8lJTCQHHrp/ZT5H412ggL01pA1+JrrewyE67y5sTKuoU6/Tlq+aDHUM1SOzvOJuSLtbT0rNreYU2qlChBtq7ZM7I75WYa+8b7U0Vx3lxqCOFac2nRu/1OWBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d18fbafa4dso37376355ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 14:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740955041; x=1741559841;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=utamXc6I+xnosmBsdnrUmah40k48pr1hjvzaM3mHGis=;
        b=kxQv8QKdfuzhmqqLmvBvNYxLgn8HUnGHcMsdMcu2m+XAEgFgY7LOPBSdYWy9bqWpuK
         hk+V5SoxMens7XrnsIMr9TgW6aJ+TW0UIASULhFEzMm4K0bow+VFLNTGl8aYL2cBayYK
         LmlIw5eMyMhkRKjVN54F6rEqCHjGdsYnLEaZX1JEISEmfCuRCPIyTwStO1uo+xlY7eQb
         vIKKXqoXoHs5LeeaUg6VDQyblp5/KlxESEmRObqRBrjsZr199ms8xB3/aQty51ksORv6
         v6w/Xy7YN1+v2JbwScVUSN0kmKx4QQYcbmtf9Io29fr7No/wSkNO1481sHcNCTWmTdIl
         y/Fw==
X-Gm-Message-State: AOJu0YyiPlzxQahLFdX4UcO8XRdfa8AyujgjKHqPkWvhKfMfWXqbBsA/
	NUBIHSgk/g3NzDsBxDGIooGwwZFtdmBNe9z6B/sa4QTn9Pe53M8EorXIEpi9E4rcTiqxyxg8ogP
	Iq+Ik4L0ksyAik29mJg2rbp82IjOO4FrZOdbM/PfClm5kWyFvhDLPjsQ=
X-Google-Smtp-Source: AGHT+IGg5TxX+8ogMdxKRe/mR0oKCCW7kVQPBosty+8SM4ulIsEmTFJiDcgxtPaN1YTH2wFl/E8vYvuxOyzrsGbXTQRfUSpa5b0U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24c:0:b0:3d3:d067:7409 with SMTP id
 e9e14a558f8ab-3d3e6e940ddmr103456735ab.11.1740955041629; Sun, 02 Mar 2025
 14:37:21 -0800 (PST)
Date: Sun, 02 Mar 2025 14:37:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c4dda1.050a0220.1dee4d.009e.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Mar 2025)
From: syzbot <syzbot+listc59baa9b4f1dc791b29d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 1 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 62 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 309     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<2> 155     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 78      Yes   possible deadlock in sock_set_reuseaddr
                  https://syzkaller.appspot.com/bug?extid=af5682e4f50cd6bce838
<4> 66      No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<5> 45      No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

