Return-Path: <linux-kernel+bounces-368334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 371799A0E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F322826E1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68E820E03B;
	Wed, 16 Oct 2024 15:36:30 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3936354720
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092990; cv=none; b=X7XuOdPANgQr4DR8bwIFr8hi5nNU8PglJaBbhHzIs9DlC2j3DA8yvjjFYu9XdkGhxDNBvX4HuefwruvYAnVA4skXDOh7VTlYX4e150ci/Fo4O9lu9BUHM0UK0geRSNlKDAZZHQ7gR67aqN9E+fJcLvmQaNaIT7wFAzEt401daVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092990; c=relaxed/simple;
	bh=CgkR14pDiqmvdlVwR/10tJhB1m+jvhphe5RjoiY2EAw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B7dEH4iurD9830RpgZ3/d1VTz5k1Oj8ZY2Ja/wr5/TV7S8ksDMKntuwBIr3NPQYTPPAW9IUAs4PHe9twj5nq4W2ylCiDOrP3KvWA+FIzqXh5isJejpXMkdwa6RYashwOdeluN8RBZ9A/GS0qKIeLxH6c0bssfCNuzgR3+VqtN/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83a98e5a733so119352039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729092988; x=1729697788;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1m8iALNdyCQ9z7Ll9FSIN7ModedATew2fjWohO2jdo=;
        b=rJrxd925vgFBiw7camN/5JG4PX7/1kl86KgP8xDlaIqm8vCSflpqQxt5E0z4BmrkRl
         MjMYSCj7Ae2tO1oKQIHyXalduOVt3LBmf/mjlaZpERdXyBJ3rBp8uzd/nmFq4k8hvMUf
         kI8cOEsojXP6wkTJDbxsre7uFOlex9Ky9EFUGsgjfnNDNZO6Uq7vUQLiMd/43o+vm7cl
         Wfsgf2NTMHMyFntXDX7eRMOypFQJelQ/bRDIHpy51LjR5fVp4hTgGHEy+poeL05j7YH6
         2IhMFJ85v9EJj42L/P5GnWKRvK/j7yEdPXjDHHk2SepWEYuwVoY0TLvBtM2wDXAD40d1
         n4kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMLkiqRZgroxWecaB1w/pGytgSd5MVsQU9UB0wgc+8cIkpb1VUFtc2xczM08w5qbAl9rcFQNaxs8k1jP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxes9i/vYFljDiDLZ+5H5t3vJf+hI1Eq+1IYOPMst0DUnnqSde
	p75it30U+Qz2gDgbVJkyisxkK9omI5jwZtlCsouFv5aXrB6wG+WclNo8VV8FyWMIM9LItp7K5vd
	p27jppBFnpXGSx/prR0QVsVd2jMNV6SPYfQqbH8A9hrRdQQfvyyl2ED8=
X-Google-Smtp-Source: AGHT+IGao+opzrX99U2GIYHN4x9S9xZrf9xSN6fqQL50WU3QyfGTs29jK5TwZsOTU3lIZUhaloc4/Jm7VdNoEQg030HgUP14F54y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aab:b0:3a3:63c3:352e with SMTP id
 e9e14a558f8ab-3a3b602269emr162928755ab.19.1729092988355; Wed, 16 Oct 2024
 08:36:28 -0700 (PDT)
Date: Wed, 16 Oct 2024 08:36:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670fdd7c.050a0220.d5849.0016.GAE@google.com>
Subject: [syzbot] Monthly xfs report (Oct 2024)
From: syzbot <syzbot+list43c58946ba7cc70971ae@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello xfs maintainers/developers,

This is a 31-day syzbot report for the xfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/xfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 23 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1164    Yes   possible deadlock in xfs_ilock_attr_map_shared
                  https://syzkaller.appspot.com/bug?extid=069cc167ecbee6e3e91a
<2> 858     Yes   KASAN: stack-out-of-bounds Read in xfs_buf_lock
                  https://syzkaller.appspot.com/bug?extid=0bc698a422b5e4ac988c
<3> 214     Yes   possible deadlock in xfs_icwalk_ag (2)
                  https://syzkaller.appspot.com/bug?extid=4248e91deb3db78358a2
<4> 141     Yes   possible deadlock in xfs_can_free_eofblocks (2)
                  https://syzkaller.appspot.com/bug?extid=53d541c7b07d55a392ca
<5> 101     Yes   KASAN: slab-use-after-free Read in xfs_inode_item_push
                  https://syzkaller.appspot.com/bug?extid=1a28995e12fd13faa44e
<6> 83      Yes   INFO: task hung in xfs_buf_item_unpin (2)
                  https://syzkaller.appspot.com/bug?extid=837bcd54843dd6262f2f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

