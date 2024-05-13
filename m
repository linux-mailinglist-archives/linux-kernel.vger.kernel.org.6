Return-Path: <linux-kernel+bounces-178097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233C98C48A7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8002861A6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79405839E6;
	Mon, 13 May 2024 21:13:25 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE65B823A6
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715634805; cv=none; b=hmzbmBgQgI5jsa4pSuOmgng0neg2SjPE8rXzkwKSF+p5E4Q0LXqPgwzFS/tDnBs65cX6eoN+jz0+DDGLhgYueDH8s30jMqeSKUr88UxgPcRYYr3bqQLe0cv3V1zg9ueHY1Edq/BeQv7Tj8vcf+wRC7DWVQPxIvU6oYaFTIoLdcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715634805; c=relaxed/simple;
	bh=pFlsgEtkxebVYmtKlEJmcV0IrVkDH0P8Uv4Th3tWUpk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uwwFINwj0BPPKSW7N8nku7KCpnePz/nXOHI886NRWRhCASxUPhwpPpQbyIliOSnIlFChR5Y3j75xaOq9aWeOMSoSufb0QLlPHMVJ1fTkrfU/EUd/4FQTnv1/fu4ux93vRRlq8upzMgQk9ub4XOOgdFtPCIQN5LfpfanGbldxCW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e1bcad7693so438231239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 14:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715634803; x=1716239603;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdtdrmA2G6hjK/rRAiC82SJBeEiZjj4UCnN5IPNI4mU=;
        b=J4vYTzMEaR31waxoXGG/mby0hCS4+KTCuq8VzX4Pr7O/4kaHv+s8qZ1cIPPnX0oUHh
         IORQ8f71+tKpi5oQgiqjD+3fzo4Rq/pcZrSB+9zUaYHCol1eVdrax+bpIhg1MgkE7eiZ
         4Gco7V8Di7WdVKtpc5r6CDbrUftdu3/Am5W1P6DKqk2zh6q9iGAXWLSeq3od/2taB89z
         DbWVtC1b2wQt1JDC/IxL2mP+SRei+J4LKejlD4rUhQH8KEF0cC4VjA1jVj8xtQXdDOqa
         HbOr5tQqsWcMUQkBLeTasKqemvfeeomYc1ZdnY7RPmKM2QdwMF7IeDC9iCmWNYuyC28J
         v4Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWCVk0ZmPR1jEqKg02+YsdfE87La5aIy3+DClxGlZKshB/29MEeZgQJOGQMpT90JpbAP/Cqd3jNYSCdKMm7IDwziN5RGJkUXODkJ8JG
X-Gm-Message-State: AOJu0YxPsagqH+hgpvX+H4UxDdfUsIZ61tkAGY+QUWkmY6IonD8uM+jx
	AxqTAl4KJn/YKavvP0rg7e/VWTgaY3NUCT0XtZsNRv0toj+QdIVP/kc3+USTnIlT3t/+XOXka7e
	n0VUazy/21BvVUQ684/2rOpBPCekJExHHJnd8aKSHb9LQznQXFVRQ3Qg=
X-Google-Smtp-Source: AGHT+IGUO1tlVmHMRGj8XmZ7tfFDNnl5w++6kWNmi5IEW2QehDwfnU3LKf6sAJE+bTz63sIL2SFXqIBT6d/EP7FgarJIHGW6ab4r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1609:b0:7e1:b4b2:3664 with SMTP id
 ca18e2360f4ac-7e1b52014bemr48594739f.2.1715634802896; Mon, 13 May 2024
 14:13:22 -0700 (PDT)
Date: Mon, 13 May 2024 14:13:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fdbce606185c5a83@google.com>
Subject: [syzbot] Monthly hfs report (May 2024)
From: syzbot <syzbot+list1c844d77bd05e3197946@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 16 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  35302   Yes   possible deadlock in hfsplus_file_truncate
                   https://syzkaller.appspot.com/bug?extid=6030b3b1b9bf70e538c4
<2>  23022   Yes   possible deadlock in hfsplus_file_extend
                   https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
<3>  10227   Yes   KASAN: slab-out-of-bounds Read in generic_perform_write
                   https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
<4>  8676    Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<5>  6584    Yes   KMSAN: uninit-value in hfs_revalidate_dentry
                   https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
<6>  4613    Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<7>  2337    Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<8>  1254    Yes   WARNING in drop_nlink (2)
                   https://syzkaller.appspot.com/bug?extid=651ca866e5e2b4b5095b
<9>  1102    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<10> 877     Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

