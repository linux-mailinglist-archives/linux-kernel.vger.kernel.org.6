Return-Path: <linux-kernel+bounces-215965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08B4909966
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9662B1C20E6F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647725A4FD;
	Sat, 15 Jun 2024 17:49:23 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCEE4AECE
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718473763; cv=none; b=VfhJ8zxwWyekQ1kEV8te4XVLuJZseuL9RaJt2bMcgmT5qSRVbaFTqRNPKdf3FbyH/jiWPLDjC8LHUos80fm5pfpM8iP/Sx8Y+QE9vZ7aSgOxrAJCQQALWz/ixIAkllSpOdnfIZznpcbZvj5way6hFRZ0OLNaXaWNQGuUdo0SzjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718473763; c=relaxed/simple;
	bh=F2Y8xYsdrjSOZp3BZrwFQlCfRppI2jLEnYkfqcrbbX0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=U15VzYDM0WrRPJhtJEbSYRICaCFGlgyGCFcD7mKRBCw5kY/dH/UG6dsH7+iax9bM7wyeQKftLmcMJJNrMaiu21NWiWkQ99aymO0I5bAG7U5ADjERkGZfmC2YLhRJMkO1rOY5vRq/XjCgBFsokTf8r8X0Lye0uV5yxT1E5ubusKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e6e4a83282so355104239f.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 10:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718473761; x=1719078561;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3m+yhIqhD41WwtddUIkZr1hXB+VF5dDQxD68iyhy/10=;
        b=TMKNu3MEuQc9QnbxLjquFUdFJbzBPljMTsw/2H+v2QQyjsH8nTOypm6O+ErHmvhiMj
         2JkJCtHrC5+N1RlL7adhp3b5oo/9hAt7lN9uMG1DCyWBhgIh3T60FHUyuf/kwgH4ta4N
         M48njryCIax+LBYvkOuGLH/JLcgKPc0++ymdUXWN2Pt1XTaJLRFIh2J05hOQJYK3VQa+
         mqueIwqF7O1a+qMtUC5mZdcJys5ZY7PB0mHjyhN8whdxZ+XZ2FqCbqaJ3riVK0TDSJc8
         BQ/WkQy7mmTmuzy17LszkULbihimzW+CS3OljvW7m8PSwJMeYfrWKPbpLFY2T7sP0FDK
         BnBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcg3CiNt7IHBLERyEMHZn7Bdc8NLwtotH3OdfS/53mN5lAY0Tm+e4L6sVjShqHfj9oCTuKo3Cbzvb1uRFXEFuXRr69S9Jsl1yg7aNj
X-Gm-Message-State: AOJu0YxY/o8uunHaY0fGxHSd6XcaanG3zQWmeUDvwMzMjS8v0QyCpaYk
	mvzWF1Dlq+hAzbieWtZkYDc+SE4ikfWvnjlVEvAuHg4FlgYAdrtDnNqXPGGjtKyFiwg1Ee3u8h9
	49daf2+HAF9k1Ll/BLBjtw8JGnMNL6zyIpmHCcD/EiqtFb6Yt9fS0b4I=
X-Google-Smtp-Source: AGHT+IEIsnY8M9xnbm0uV/MxzT83wFTQUT1wNFZVbWDNHIyszyimRD0bwBzDQm4WyqpO/0gIAnkrC/OA3g+RXyG+4RHGfPZZ7ay6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:258a:b0:488:e34a:5f76 with SMTP id
 8926c6da1cb9f-4b963f947efmr273756173.1.1718473760819; Sat, 15 Jun 2024
 10:49:20 -0700 (PDT)
Date: Sat, 15 Jun 2024 10:49:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011db0b061af15a3c@google.com>
Subject: [syzbot] Monthly overlayfs report (Jun 2024)
From: syzbot <syzbot+list316c1d421205de40320d@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello overlayfs maintainers/developers,

This is a 31-day syzbot report for the overlayfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/overlayfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 26 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 21      Yes   BUG: unable to handle kernel NULL pointer dereference in __lookup_slow (3)
                  https://syzkaller.appspot.com/bug?extid=94891a5155abdf6821b7
<2> 7       No    possible deadlock in ovl_copy_up_start (4)
                  https://syzkaller.appspot.com/bug?extid=6d34d0b636fea8b593eb
<3> 4       No    KASAN: slab-use-after-free Read in ovl_dentry_update_reval
                  https://syzkaller.appspot.com/bug?extid=316db8a1191938280eb6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

