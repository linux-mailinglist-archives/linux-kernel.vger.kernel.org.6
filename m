Return-Path: <linux-kernel+bounces-385819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC5F9B3C23
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B731F22C33
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB84C1E0DE8;
	Mon, 28 Oct 2024 20:45:36 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A1E1E0DB2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148336; cv=none; b=ZJIxDC+vzPNg84tTbzMWPNejq0nOPGcbMy57cA8Up7C1n5rESGD5QYb1ALOMebLc72EHWx+lmQYa+6ONsw+YeYSh5GfwOObVBGCJwmKYfaVhls0o9mq5vZHS/s5eFsxgL776Y5ppLsD9WTBnkSOyZg8Aya3vDd8c0QAioLzC+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148336; c=relaxed/simple;
	bh=JlSTUzkhOJrT5VFcvOPsjv667t7ku0zyTga+DMVjXaM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=S+/A/NjytkY+cWCtsuFKDWeF/gM+tdlUo87Om2nAs2u9t4CpBx6UKg7e0DgmYnSOvmQR/c00BSjnYGOQW7SpcPECeIdqZNP6xiKfXq5VnsYIgXd1gsp8ut3EPIjjzcTZ8aDUR4tztyCIeHOAuQy2SYbcgOtvIxHJvB5t49ELfuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3fa97f09cso49603515ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730148333; x=1730753133;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gm9HIUjtIgm+D7gqVN7uBVlVAbtiOD76ZVg8RQFmbeg=;
        b=qCmM1As1tXtYfWSairZ/DNotjg6u5pMJU+ujpvAxdqAUcvedRBLfdmbyKUUuvsvutI
         KIVCvumifi/e2xX2bDiHg7hMsd5Z672Zqa8mMC1Gz62sV+SR4reacqb271yr+ce7tYq/
         Aw+b33g27HqHaOn7WSQIDltfREOoPcPvyqyigs5YFIPqPF9+a+9t/J0oozWW7QB+I3LX
         y3AY+w+2DMsiOd6t3Q3mn+1BJmZM+xBRrqlvcy5hzDzjV0qEcIiYzoMvPT9JW8gXifOe
         X6rdR/szidEL4cqy8y9SgxPHzc8a+g48nxzA98X3GLhLraKG9adGDFKJkIRRed831Q9X
         Xgkg==
X-Gm-Message-State: AOJu0YzFzgixNjBMY6W18Rge4qA4C7wBupeh6ONy6aLBThpyPxIsB7jO
	XB6Jf603x9RBP3qikJqaneVjcFYEFXlI7Tdm2ImuYrW49aKhcJdMPYGXZbGogC/DDThmnRnmLAW
	CxxxwaDn3xnDiuLeC+o1jqp5IUVtKWxQwM8U3ptl8D15JltopewDz7/8=
X-Google-Smtp-Source: AGHT+IGZzVyntIeyX/gZ5yaDPioEdLlL7du5r6uZZi31yylONzfTAyJa0yATwAh/BOFzUE7mZXZlsTnS5exUluxtxolLDOBU84EI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:3a0:9cd5:931c with SMTP id
 e9e14a558f8ab-3a4ed33225bmr96405405ab.20.1730148333472; Mon, 28 Oct 2024
 13:45:33 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:45:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671ff7ed.050a0220.4735a.0251.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Oct 2024)
From: syzbot <syzbot+list1a9e20eb3cc9c246ba85@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 0 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 61 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 295     No    INFO: task hung in disable_device
                  https://syzkaller.appspot.com/bug?extid=4d0c396361b5dc5d610f
<2> 186     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<3> 33      No    WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<4> 5       No    possible deadlock in sock_set_reuseaddr
                  https://syzkaller.appspot.com/bug?extid=af5682e4f50cd6bce838

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

