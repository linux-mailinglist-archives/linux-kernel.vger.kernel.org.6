Return-Path: <linux-kernel+bounces-289419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA4E95460A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2804B1F2130F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B7816F29C;
	Fri, 16 Aug 2024 09:46:27 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D2E12C54D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801587; cv=none; b=V8OqSw3hiN5LSMVAsNhFJJLFPLHDvDw4dMyqYqtDD3y/lWLFxMdDwn+h1i+qE9v3kE1aSn5u7XlXeP+pEi+2ZLFCcvf4m/yM15ok9ZMvGYx2deaNnBMpJc/wbJK4Tnspw5YTs7gjqGBsSg5PKmBJsITNyd36Jz/76S6oBde46Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801587; c=relaxed/simple;
	bh=Tb0h4ck6cfiihuLwqoLnMdMsolPdYYKMx3c/TZUiA9E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jCqMC2Xn9uD1WYunJ2EjxP754l6JCM1HGs3OC8f5hFY9Sq4lB4/Fk7FfkVf+a5TI1om75eM1vi8m4YjRWnJtLUMgyfMN9jh+3FbJ778D/CRLvk+qHSSB5SO3c/OONaxPsP5ThNLeQwpx68keZHlGZefFrxXsbM8+sLoMBfoNZN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f7fa42463so151295939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723801585; x=1724406385;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Lop1zYGMzYsqu86D2s0Uq9vQfJMOb/arCg4VxmPAgE=;
        b=iUvhBoLd+bWruQ6QYLbN8HDt1CLQwF7Qzq86PJFuFYJakS5epNDdooBCmDlQMx+Wsb
         8KgOTPTIPiZvWa20Vmn2aYgj1kSLMFiscAYMCUdlmDO1hHxacU7rUVi94yuUeFD4dfIA
         kT+6ai3sZj+ksqC8fe40V92HNmRVrfDPK7cAUc8HCSoDlAjC+v/isoGCMRsznkmNHIRP
         7Mm3Ht0yChGiIcOYlPlHTGgGzH7SQt3gYD+ov4evjVLASOnrfFZ+ckafFXDM4Svi96k8
         tjQfqQ46GQH9mtnKBnPipB5a9cCHrOR26JdVVBcOJRDQl11kMcxbGa7wpsIS27OJLdrE
         9y/w==
X-Forwarded-Encrypted: i=1; AJvYcCWjZ8ya2vyxrjah7JSp0vKwtegp8FNAH6G7QrIEjT2sTTWGCSowDL4RRxsGZKvsWicU/TKMZAhYdrvhJl83J8mscCncu3fDDzK7xn40
X-Gm-Message-State: AOJu0Yy5i//U6wfJsK9TrA60exh+T5fUzU/3Ed4ULHKywoPbiKm9m2/Y
	yCfU+wnOmvrFEEQvmTjX3btiQfnbmUguGWqKQmkyE5YivhNgPy+UBRuFpJ163/ChHP/JoTwlizy
	51MPmvBrxC2v2mQtfAWImP8DgstVAqrqs0IaVoXzkwqvzZgsZKywcABs=
X-Google-Smtp-Source: AGHT+IE80XNTjfDnFBIq2+f7vLTg2cxjmDzbCift/9CjRrLuMrKV6+z7KamZUSnLDq+cUck4tIXBQ0HdfSuRX5KNVclrKB1qIVZZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8709:b0:4c2:31f5:3137 with SMTP id
 8926c6da1cb9f-4cce0d85575mr75648173.0.1723801585017; Fri, 16 Aug 2024
 02:46:25 -0700 (PDT)
Date: Fri, 16 Aug 2024 02:46:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000236dd4061fc9d5ff@google.com>
Subject: [syzbot] Monthly ext4 report (Aug 2024)
From: syzbot <syzbot+list069a4bf4a271f0c4158e@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 4 new issues were detected and 0 were fixed.
In total, 40 issues are still open and 138 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1284    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<2>  1159    Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<3>  801     Yes   WARNING: locking bug in __ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a537ff48a9cb940d314c
<4>  690     Yes   WARNING: locking bug in ext4_ioctl
                   https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd
<5>  321     Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<6>  276     No    INFO: task hung in ext4_stop_mmpd
                   https://syzkaller.appspot.com/bug?extid=0dd5b81275fa083055d7
<7>  204     No    INFO: task hung in sb_start_write
                   https://syzkaller.appspot.com/bug?extid=fb3ada58a6c0a3208821
<8>  128     Yes   possible deadlock in ext4_xattr_inode_iget (3)
                   https://syzkaller.appspot.com/bug?extid=ee72b9a7aad1e5a77c5c
<9>  58      Yes   kernel BUG in ext4_write_inline_data_end (2)
                   https://syzkaller.appspot.com/bug?extid=0c89d865531d053abb2d
<10> 34      Yes   KMSAN: uninit-value in aes_encrypt (5)
                   https://syzkaller.appspot.com/bug?extid=aeb14e2539ffb6d21130

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

