Return-Path: <linux-kernel+bounces-425354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6B29DC0EC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14852824D8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E241714B5;
	Fri, 29 Nov 2024 08:55:31 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD5915CD41
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732870530; cv=none; b=hCJZ8t1tP6eV1AwMsCkzQ148TJvS80KiFizBmkwt1ela6Z47pA9Gca+14qDCPIc69i7n+In4FBQHJ5j+PauFyJjP13x50B6iRAMcEQC+TrRP4CwBrqYV/MaQUt+szMyK5JaP5+OHhfLjshYvnh42UmYzvM/grVX3R25+CbrfzSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732870530; c=relaxed/simple;
	bh=BA7OguDmoSAtm1gbWG7d5eHN1tWSfXjI/uI+MEchFoA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EP4VYqote5UnayKyXZ3x3dcHZffH8V8Q91Ec7n309pz+m/dxiqgU6jm4BeQra39N06NnZLBd1NzaxnRSblqNQKNBSXvzfv8fCTCFI/wQMfC2/vwCkQMxhAUVYtXXYo+dOQvaeTKUzyhD9Ow3m/+2vVLPfcpbdWegRBRzC6kFDWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a79088e7abso14582135ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 00:55:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732870528; x=1733475328;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHJeA6VzEkZ1D1td3L2NHIlmUZhOrE7fAacKmomAWfk=;
        b=bbSdQpiFJrd8Hqno2wkuDAW4YS9czWiB1/8eVxuChxck4NzaS8L/7E1XS5pMYKe4MR
         /FvQ2an20kq473G6TbcaOwmyVKBegPUSiIkkot4yu1u1cOaL5abl6gNghSPyLeZNJTFV
         3PRJxAA4OESdjvHj2i+T9n6UBPmmWJ5Kx9rXqsL9y1HcX9lHgcQUT38ZV9mHJ0dwdl4h
         m00tu0CGn9tyH9yV196D00zcJ0s3eQeEwMV8xskvDBKp+jul+LgxtvvdspDFyVCsbpPb
         l87EkXUTJIbyXLPtWwofEWUAvRpfewwovsmK78dO2fH2Z4cZt9gn2xjPJfIFvmQyTRMF
         VBeg==
X-Gm-Message-State: AOJu0YzOF4GkjAgascpza4TEK9bRGa7SuFxdicRBi4Ra0yUTg8IUlTb+
	rc1eWIGRClkvK+zh4vnG6SjNI19vVqskCJwETSahATTl0CcMALv8xAvWZhp4Ldb3VPHw9Hq1jZQ
	OXn/dTNG6InDAfgUHkV5KxaeR6sRNZvJNjCKQA/85m00yNgcP42DQMBw=
X-Google-Smtp-Source: AGHT+IGJr3LiiWwHhNZd6ZTSZoUENyppYXrKQYWmXD2OA/05uaxf4878i0MAbzNmvg7cL+g0U27HJr5C7bsR2mJthfo5Qr0GRbXr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ac:b0:3a7:1a65:2fbc with SMTP id
 e9e14a558f8ab-3a7c55f261dmr118452265ab.23.1732870528603; Fri, 29 Nov 2024
 00:55:28 -0800 (PST)
Date: Fri, 29 Nov 2024 00:55:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67498180.050a0220.253251.00a9.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Nov 2024)
From: syzbot <syzbot+list61c5ef3632c5b9ec2d7d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 2 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 61 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 350     No    INFO: task hung in disable_device
                  https://syzkaller.appspot.com/bug?extid=4d0c396361b5dc5d610f
<2> 231     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<3> 51      No    WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<4> 46      No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<5> 12      Yes   possible deadlock in sock_set_reuseaddr
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

