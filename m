Return-Path: <linux-kernel+bounces-341788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E97F7988644
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E901C218FB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D0218C014;
	Fri, 27 Sep 2024 13:28:30 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143471DFD8
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727443710; cv=none; b=sRNKfwkkdMM03dUUwDU6rm06V0Y0TbXVe68jf3fBxnZDC0J7IwMseDpEZm4gYyZtdLp3pWVkeO4Lv/v1kqtc1sCXetVR+fg8uYv16LBIqCigcJ6PukAdIIevbPMRQ6AFY6QucSLIzfvlDukbWo3x6G1EpmNdX8qwu0EKg2C1ymY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727443710; c=relaxed/simple;
	bh=0E3niAAD+G6Dw2wZipJtWeSFOTc8oYKzVvOCAU88kD0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=csYZWOPSih1nOAskpRZzKQRJv15qYrUMvfvHryXpenXIpv5vH/SECoT49Q+oiqKjWRCxD5I3hnAveYqyB1eLUp1TKBBR24TIbuW4j7PKdK7eQlRl33venU2mBPG81nw3B6NmKjhUf45j8pT0fuNAEI38mHVMp7rBm/gY7BRDrbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a2762bfcbbso26496585ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 06:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727443708; x=1728048508;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=et3EJGS/ZhbG/lI88ALbK4RuafRSN9jb2K6pRh2BmS8=;
        b=b2Dahe5tEmAxYYJWYaNJ4DMBDDEc7i+iJ4Lp2eFmaw24g5thVwJV2OKpYVf/tBs054
         HEWSK3eZdZvI+22wyqV+cNJQv1a7XS3evW9fzDRxrqe453FHhluy5qHZBfiPEynvId9a
         0Ae8bG9jNoYetIkmeuEfpSicsgEJSQhUDMN94JWAS/1VGIx26H/k23gZfwaOoZx4F1fa
         QdqrMprw+t8ZsQqQNloZzpnt5Iq5Zz6htZXgRbRn/SyIzOQFSx2B4hI+9jwWof0PLwa4
         lt/qRXlKpxOZYovksgENss/MIoF6AcH2urj2V8I1kZe3cyvDPOsKxiTsDYcRRRNUKPlz
         V5TA==
X-Gm-Message-State: AOJu0Yy1c9vuYY5zI+S7x+dhD5Gh34cgOzrbi+GbMIBwraxj+cUGpOdd
	5mXxCNLM0YqdndAVQ+5T6UJAfHX+Pr4sV9sKq7jP4WJ6+QaFf7xChrPIoW2kAIzpMH4cn/uz4e8
	nzLDpe6mxdxEXLeXEaXFIR6YcEIkmTKvAbRbj57rKXYPFF5Rod3tKoVQ=
X-Google-Smtp-Source: AGHT+IGbAy1zQGCXJ8P9FxZGs/Bk5j8b4JyoiAHF4y/M7LM/1pm90J9RVbpSJypvRrLgcIFQE61mi6q1oqHqwWy35OxkvgbNl7YX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1686:b0:3a0:b471:9651 with SMTP id
 e9e14a558f8ab-3a3451c3a08mr32873305ab.24.1727443708274; Fri, 27 Sep 2024
 06:28:28 -0700 (PDT)
Date: Fri, 27 Sep 2024 06:28:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6b2fc.050a0220.38ace9.0013.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Sep 2024)
From: syzbot <syzbot+listae4a64541abfe3a7a043@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 1 new issues were detected and 1 were fixed.
In total, 6 issues are still open and 61 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 135     No    INFO: task hung in disable_device
                  https://syzkaller.appspot.com/bug?extid=4d0c396361b5dc5d610f
<2> 111     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<3> 26      No    WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

