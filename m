Return-Path: <linux-kernel+bounces-250663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D138992FAC8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866CE1F23217
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAAA16F82B;
	Fri, 12 Jul 2024 12:56:26 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C28F58
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720788985; cv=none; b=ABKZP8Cs5fIO4xKdIv2kw6xo9XQQh13d6FrMPR6qic8uOhK1X4SngaB0Sq+N7iNUpUILFTyaGtS7GbfnIawy07tkLbCMrpGbW2Xsb0fB0CJoAYhFasL9R0qhSu7OWS1ZCmN0EGGamiZw3Gy5WVxSZ9ymv3nW8HNxLnIwDFwsdRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720788985; c=relaxed/simple;
	bh=D909vMYTrN61I/xhjgwmCsShtJXd1ivRuWavZDBCyWc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DFFllhwOMAgJO+CXY4bqRaDGNb+KRjDAEA3J5V6B6dTNNI7v2XFfaVAK/cbgrPjirJ/MZo+2uv2JJfuUvxFiHiVAlCKIQv5IOruDDvJx9SGvLdRxtz/IsZBjnnHEtdrJd9JoUH/Rer21sh1Zkh+Z/0OlwuOd9VA+SnnOi0uQI5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-807b123d985so208016539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720788983; x=1721393783;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TzEYZ9/KGZnyjIckX+IjZ1E5E0w/LVv8h31KnsqmR3E=;
        b=wejSKxy0Npa9fC5H3rKtYKvxm8ddrS8rBlPUKqFAtnVpmofp7skn3tcuzABFVYygaD
         dr/9rgXxtlIPgyYslSRrmm9DcjGDImaVYJA1AsUsZRizcJB/j4P+rNzFK20Yw2R58YfR
         8502MSDErU1j+UbISVtGfzk3f+QuUT2S7ChH23788Sw8a0sSacjZAqDwbYMYnWDJShYA
         1O5IH1D3KYbZNi//0ss/BtAJTk3uUybHVtk+7eVuBeWZaVPI7WxBUUI3qSUz2MfZYfA2
         Ae285pj99EzRZuMa7M5KqYIfgSChG7RqnkcisN9UaWFh6VvhrdDC9DFeY/MqeHt08txD
         M1jw==
X-Forwarded-Encrypted: i=1; AJvYcCV2e/hbUaMEt0bwoEZD7/+cQrur411V/lwIqy5mCqCCj+yttrx/XhE1PE1t4UDXJjMPIQF+jkInMaIwn+LtfAGhN8ACQ3ykWjXLyIQ8
X-Gm-Message-State: AOJu0Yw0cfygXIPVD/hzYyj5eqHw3r5zxiXgmCeX6U9w3jpMbdrmtgEZ
	OnLt/esxe1pYpbuMWiMzF0Nv98tcLhGAKN50Gik8RsfMonyheIAwcyGjnRhbkN0pHIRLCbWCnGX
	5aXgrOuQEifYDZF4uXc0WEDpQegZJhRkFEz4iP9+TpjXA5HnvTWrtTMY=
X-Google-Smtp-Source: AGHT+IFjx/daJIABMZzZiahUEJaMJNv96x24S6lL82RAo5ZGK0UofhpHnB3kxGUIHFpIkMQpXzclHAAZ2q4UUuvcQH9/rGeyxruq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6281:b0:4c0:a8a5:81cc with SMTP id
 8926c6da1cb9f-4c0b2af54damr779703173.3.1720788983660; Fri, 12 Jul 2024
 05:56:23 -0700 (PDT)
Date: Fri, 12 Jul 2024 05:56:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ad247061d0c68b9@google.com>
Subject: [syzbot] Monthly jfs report (Jul 2024)
From: syzbot <syzbot+listbce8d688f46fc6adf428@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 7 new issues were detected and 0 were fixed.
In total, 49 issues are still open and 40 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11460   Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<2>  5742    Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<3>  3176    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<4>  2375    Yes   WARNING in dbAdjTree
                   https://syzkaller.appspot.com/bug?extid=ab18fa9c959320611727
<5>  2145    Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<6>  1361    Yes   INFO: task hung in lock_metapage
                   https://syzkaller.appspot.com/bug?extid=1d84a1682e4673d5c4fb
<7>  1216    Yes   KASAN: user-memory-access Write in __destroy_inode
                   https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3
<8>  1205    Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
<9>  713     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<10> 577     Yes   INFO: trying to register non-static key in txEnd (2)
                   https://syzkaller.appspot.com/bug?extid=5b27962d84feb4acb5c1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

