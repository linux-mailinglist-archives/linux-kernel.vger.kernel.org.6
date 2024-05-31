Return-Path: <linux-kernel+bounces-196367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2397C8D5ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37F6283474
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B655481AB1;
	Fri, 31 May 2024 06:48:34 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6080633
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138114; cv=none; b=eROe504fhf4EFReaNwLj9g8QHQI8PHC24K4cNPDg2JIbKaTPShDR/guwk8MZlgge9JbNL2G44OL0/L1wrcHPF0XrfYVm3O8Pt5fvBaxtKDxl8gOYxtEIC2CC4vLcNmPerN7r1Hsl5PYm9gELA3Lduz5lrNuyijGqf40MXJOtMDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138114; c=relaxed/simple;
	bh=JQjo0eMRUrtDRYAzFt/rgP2lLlrIbIHkpCinR2YfJYs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QfaB7TXFL2BF/BaPQV/JdLbOsesc//CoWkx6FmP47GqOsbXU++WcYyZouH0Hx2gTe9QhFBxt4B9BdEV0RLWQ1vI6zvnF47cnvdv7iG5+L+4f1Pvb4Okl/lSLtnd6cqxy0X9HkJlFc1FQiqve9jN/0GhUDrv70UE05t3mvwfJjfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e94cac3ee5so213098139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717138112; x=1717742912;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TixudRcneHSDOjcZa3mtszer4Ues1F+sIN8Vl/IV5T8=;
        b=fbV+ckNR5jn5BA68ktLkeWxhOasLoLH6Qb1oCL8QiqneC05z6Ns4Uk9Afafo8uwQF+
         agU7ssYfzS8n8ULAZhOUrxz3Jrb2J7SBeIzYF2ZmYcDsxJtJuTOhX7exJeM/RN8vcXta
         n4sjSmZ2NLwugj6Dtl3avBB2Uz/OLoG3mV+mWvBfsDPjpWWvVv6+c9b5/9kFFMwSXjOO
         oxtFsTiIeNIxbLUlC/jbC97fXDkzzZzsy6mszYvJwWPhY5ESge2Uyl0JrXBuGCBqGVlo
         Fea8kGckFVwxJ4eVvUoYPlC1ejTzNOPKCZCfToZEmSK6CsLDQ911nJqj34LXTLCGBfzM
         WDUA==
X-Forwarded-Encrypted: i=1; AJvYcCUjrdl8oMsvVqgoN3cwEvK6GIkvgeAE5ZCbqNBaXm6Q7UF+QtABHIKWtW78LwW2/kpkKomxpvSsyN0UzOJ1OOsz5P6ZdRt6q9hF0gCP
X-Gm-Message-State: AOJu0YysdwFj78lqNEdG+Z8B4evouKQ/whqRcs0CetFZ8BbWoew1JfE4
	BtRpJ0bjavASj/rkqAHKMiH4uqd2infCEUBA+NuEFXtc+7OpfjUnFhjmfMWgP5Y6LYHksKUVvDS
	lEeNVDzfaicox1Mj1GgB/lj1PcGVqzZfo2P098cN4smxJ9RVSbIRLjN8=
X-Google-Smtp-Source: AGHT+IElYXT7baMvmzvScRp1iy9Kxn/fzrJ4ops/teIm3XW07S63iEhsT38ziMPA3suWqkG4wC260k5VuE5Fa4YkyDwghe+m1miW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ca:b0:36b:2731:4084 with SMTP id
 e9e14a558f8ab-3748b97bafcmr661295ab.2.1717138112035; Thu, 30 May 2024
 23:48:32 -0700 (PDT)
Date: Thu, 30 May 2024 23:48:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032c4940619ba5fa1@google.com>
Subject: [syzbot] Monthly xfs report (May 2024)
From: syzbot <syzbot+list7ecb28f76477d00e16c9@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello xfs maintainers/developers,

This is a 31-day syzbot report for the xfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/xfs

During the period, 7 new issues were detected and 0 were fixed.
In total, 14 issues are still open and 22 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 790     No    possible deadlock in xfs_ilock (2)
                  https://syzkaller.appspot.com/bug?extid=c6d7bff58a2218f14632
<2> 696     Yes   KASAN: stack-out-of-bounds Read in xfs_buf_lock
                  https://syzkaller.appspot.com/bug?extid=0bc698a422b5e4ac988c
<3> 59      No    possible deadlock in xfs_icwalk_ag (2)
                  https://syzkaller.appspot.com/bug?extid=4248e91deb3db78358a2
<4> 25      No    KASAN: slab-use-after-free Read in xfs_inode_item_push
                  https://syzkaller.appspot.com/bug?extid=1a28995e12fd13faa44e
<5> 24      No    general protection fault in xfs_destroy_mount_workqueues
                  https://syzkaller.appspot.com/bug?extid=8905ded1b49ae88b96a6
<6> 1       No    WARNING in mod_delayed_work_on
                  https://syzkaller.appspot.com/bug?extid=d9c37490b32d66c6bc78
<7> 1       No    possible deadlock in xfs_ilock_attr_map_shared
                  https://syzkaller.appspot.com/bug?extid=069cc167ecbee6e3e91a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

