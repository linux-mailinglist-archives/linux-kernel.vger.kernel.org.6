Return-Path: <linux-kernel+bounces-342227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA2B988C10
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 23:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AA9A283D08
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61C0194138;
	Fri, 27 Sep 2024 21:57:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1659F189F36
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727474227; cv=none; b=TkTR6dO5ubShcew3aFt4569/2E9BU9y585U1DQjZa6DCt2xAwKT7SMy9rR0kz9Q+SC8f3xIpB4eWvdi4lXoSehZMqdwC+W4m7aE6pWDfxj3a67akl2+mzAGVcCKBZJQl7M7Awn+oM1rjXXSKfX0nwbrWGcoN1RIhnjb6Is5q7XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727474227; c=relaxed/simple;
	bh=1snOC1DCM7IDX4/8LFGQMSY2eW6r+DWVvaD+4l9K37M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KEHTsm4hfB0C3RrO97UClEceo/nwUZZYh6Mvr9TEjk9OGnguFKvdB1QLpe7NSdiFYCKv3Z2QyDJYuinNwKqJIAvwEQm+r581CSVSrUtxzexm3LHu+WAAK7ELaTwBw/J0kBavBBln3uM8W5+zyX/7sKd2XPOO7wQMPVwu+TgIdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a342e872a7so22725685ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727474225; x=1728079025;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SblmZHdHvEDZouSWe3JMik4XP5JMjEG3nD3rv09/7BY=;
        b=lALUmX3CiQFR2i/uu2j6E55jcyh76+SShr0FPVHyp82xiAOj0egt/LgvJk5Ngo+UER
         VKCw/iZVDjj7ZZ0JI5R2FVRTPufH4XC/zQtHITRRb5tW5o7fZwhSxiGBRgGUJiwAsd7Z
         JquveJDmEyjkBY/w23qaS6HJnZ5zFfj3uCIUXE4aSKJWNLg8CqUHPxQzvwnFfOydaMyT
         bGc8OYnBVZh/JE6YEO547LYA8T9hzDmAA/BMsTogsmLcZsbr7++b6CfZXhnVLWsuCnqg
         K0xiiQwBg/HL+uI611G2BB/LlwX4K8mzrbdmVWU4E03nGWZmgPhPxyUgvzD7be6BVEMj
         8v9g==
X-Gm-Message-State: AOJu0YyRxVpIUm1Xdz3uHRQZO8qDGGlVreDtE7E6MqP5PUShpK6CoPLt
	Nj/ImHqBliQT2hmU8tx10YU/tvjSQSLJtWk07z7aaCSiQIupVMDVR2l51RFM0MDbn1yrOuVBGrJ
	R5FrrQtOSkGtBGbKkGj4opPBvGn0i0zOVMVxiusCKPqcaekKrae0kELI=
X-Google-Smtp-Source: AGHT+IHr20NgppLZDu9WVVheDXqqiInoDc4W1c9hExW6l/n73bJ9HOKksmRqpXt30Yn38GRIzvCBZTMQriMhV2d7z3AVyaNOdgnN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b70d:0:b0:3a3:49f0:f425 with SMTP id
 e9e14a558f8ab-3a349f0f90amr17988505ab.0.1727474225277; Fri, 27 Sep 2024
 14:57:05 -0700 (PDT)
Date: Fri, 27 Sep 2024 14:57:05 -0700
In-Reply-To: <6zTxrcjMccS8qnqdOfReGJXovRQL7OnpqATkXA7tlixHh8vAtpxiXhGmf_fvvKcXHMv9NcB7Y4CXl3XeR5ZS_3U5ghth7JmuiD43AdUa7DM=@proton.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f72a31.050a0220.38ace9.0033.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_btree_pos_to_text
From: syzbot <syzbot+cf7b2215b5d70600ec00@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pz010001011111@proton.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+cf7b2215b5d70600ec00@syzkaller.appspotmail.com
Tested-by: syzbot+cf7b2215b5d70600ec00@syzkaller.appspotmail.com

Tested on:

commit:         ad46e8f9 Merge tag 'pm-6.12-rc1-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c0fa80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62086b2fd100a029
dashboard link: https://syzkaller.appspot.com/bug?extid=cf7b2215b5d70600ec00
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=103586a9980000

Note: testing is done by a robot and is best-effort only.

