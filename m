Return-Path: <linux-kernel+bounces-424416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACBF9DB41B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D510D280F6D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848DB15359A;
	Thu, 28 Nov 2024 08:47:25 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2E614BF92
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783645; cv=none; b=UKBW21WdN+MK+PM4ixpj7zJ2c6gjZ0/aiOdwajtaYKT4niifAAuJ8+T9lcYb1oat9VwMXNtUSstO3UVH/csE1KRVz6zE8Oucbrm0qD/ZIuL+L2TzD4A6bNdcIb7bO6YWK36xc9FGxX1RYWwNp4pb/B5a+8vEdu5F6Qn/R+1hsD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783645; c=relaxed/simple;
	bh=Pca183OBl8FGMspJO7SMBxHQPtal3qDjSfjePNjko2I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VrlTFa83Iqzg9H7qDAxupq64Vo5rTq6GBh5BYSNQIVEFjUW8hp5n2eWPVGWcYxql+HcWPM9F7GryZjFeK1ElTnamtaZkQkR4PNV53EOUfFZ0XlDZWoY7B8bPEop/ULHl1Z+YV4KghSIkRwQoZSGcHOXdIdIlRF7iHsmxsmY21hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-84182041b05so57069439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732783643; x=1733388443;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVjcYXdzLEjJ1m8Iin2QdgSd2iibSrWMeaPwAgjOnCA=;
        b=CpX98Rek2CynfdS/0N68OGfZqt/OBKWZkYWmAZqrTn1D+E88N2MFhfjPVv55PKPYF3
         qIBqTqQON+gpD5DMTmxZ5WikQEVx385OpRMivhWTOs29qvdkYG1wrR2ya90ZOno6E8e8
         jlZ6lOBLaAymn//w60HismDBJH8dguBVZ0GHguq3SZpXE3mlA95TKy40Q66kRIkmPGZ/
         1lG3F0NK5mMm38fnl6oersce7G1MweYxJ4DpKdcEgANFJcrWZJXuqpAZ//XIIOS2/hws
         ZQDvSqJ6EiUQnWxho8XqLrwhTVKK+XeDSjP9tQfh4U3SDq9ikMQTJu9px8OXxuN5HADT
         ORvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnXBnGqmB+8Nxqsh7mCL91aL8wAwT9+dowsON71QZHNYR6Kifkdh+828k8V9m+R5rdUwnEaKm9Rm3Xneg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8GN46CynAlF3CsjLbjpXqicTeUPxyIiPyWFPcV4shQL/qArho
	7qcWNWiYxyLJ3vAjchb4bOgVyal/rWyXG2FyGhNar9c+p4JVFbPTAmWHOasZx6pkI8VdwhRcFBl
	ymOhU7VuQMG/ZU6k1i6neQJQ3PHQNl05dPhSXOLCRmppNntA4H50Mlbk=
X-Google-Smtp-Source: AGHT+IH9xQ8maDYHcsFRdkYH6RK1SoW9NhEUmzUOkRXlhmFN+1WwtgOscNaosnBb9ZbFujAhXnfFjkh7EHDwtdVeOKkySJc6xf5M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdaa:0:b0:3a7:764c:42fc with SMTP id
 e9e14a558f8ab-3a7c55ea494mr60286825ab.21.1732783642929; Thu, 28 Nov 2024
 00:47:22 -0800 (PST)
Date: Thu, 28 Nov 2024 00:47:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67482e1a.050a0220.253251.0077.GAE@google.com>
Subject: [syzbot] Monthly nilfs report (Nov 2024)
From: syzbot <syzbot+list9b171c1cfab8f0c64d5f@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 2 new issues were detected and 1 were fixed.
In total, 7 issues are still open and 55 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 9748    Yes   WARNING in mark_buffer_dirty (6)
                  https://syzkaller.appspot.com/bug?extid=d98fd19acd08b36ff422
<2> 7       Yes   WARNING in nilfs_rmdir
                  https://syzkaller.appspot.com/bug?extid=9260555647a5132edd48
<3> 2       Yes   WARNING in nilfs_btree_propagate (2)
                  https://syzkaller.appspot.com/bug?extid=b2b14916b77acf8626d7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

