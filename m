Return-Path: <linux-kernel+bounces-436255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671309E834C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 04:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E98281C63
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 03:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A38722318;
	Sun,  8 Dec 2024 03:19:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446BD46B8
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 03:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733627945; cv=none; b=InE8nfNFEiy4+7moLu+CfJImwsSLrbj+0zIPVa+TokQnMbOYoRoPrPjlBLJVRXbbsvD2BCHxbZjRCINmGJ7qLDAyC2vclOlu/R8sks0/FdFcpv9Kd4FL/0zcHFH6BGzQd0qpkT4QpzfZTP/Ko4gSTeNohBkNeB+OGcCoD2KmTYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733627945; c=relaxed/simple;
	bh=QBlyTjlRl0mgiQ2S2jM5DrX1WhWzZKh871LnvU+JPCg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O8XZt6GFOdJ0YkpoSJSp+xHdQb24aMiGVvKefNYk0MVXYrmqCmE+tbIj3BcfGY9XWlQSof/JfAXDu/NFCbQcyasReC6mQ3croTODcNo5hpoBphysK7SyFdGLi5OsDzLx9BQIsr66bBli23uukR6dQw+fJoOrOwh5TSj3u1b2gH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so71138985ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 19:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733627943; x=1734232743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XEc2nWgwCf3sADFVA94a4r6VC/WuyFpkW5JbqDumjI=;
        b=q73SfgksVBYc8c2NLxWG/CUJHSz7qeHeJViVQoUjs7MI9XmY2Cu8sjx3tWkb9SJM+z
         vb52gK64Fk+1PG7CsdeOceZ3OhZm4yUuIATpHViYK5lYRwCgE4GjI2sXL6KyyoNMMv+n
         mbea8nmTR0eDK7dJkWJEp+SBQlH0AKq5Gzq/Z4I5Oa3mEykb/y8Gn/1UngPG8xKUVZkJ
         TQOIAqF3MR6AJypcxkX6GjNBPE9wWk/efHTDeGNn5EkyzlUEwbv9e9UQgmV7f9fQmJj8
         AkTD1tzIgOBh2Dfqc/mNnXBs5dFFINoeFJ4gu30mRBCFgSAEvQmj6lt//m+uZZdypoEE
         QWnw==
X-Forwarded-Encrypted: i=1; AJvYcCV9aR+17yeJQZ0Y5G8bbR8/Oyt5wK6wNgDDSBXIg3LIdhoUd9ujwyQkXYwF8VDwUITFi8MY8qiNWh+2ysY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqVwN14fe278g07HsGF3c5BYMvc+Dm1iq2FC1J3/er/J3TkotY
	7bQXSPq4Ebd7qkCqYKRjMEcvEeaPckgoSl/HgciWWCCWA9haVJKPyGfVuvQlk0BCLBZyT8cxl/W
	CezivoxC1CdRXS9for9ofTDGCeAJaaaOJUVwariCoea+WmC7vEVDG6Xg=
X-Google-Smtp-Source: AGHT+IEd7KsYSULGkG3xaqWHvF2Zp27BxqVin+gh42nr/VoMPgqaQDT9vs2l22h+62gex7eJxJ1bjFM7HaJCMmNsHbvxRrWWYJoL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:330b:b0:3a7:dd45:bca1 with SMTP id
 e9e14a558f8ab-3a811deee81mr79910575ab.17.1733627943524; Sat, 07 Dec 2024
 19:19:03 -0800 (PST)
Date: Sat, 07 Dec 2024 19:19:03 -0800
In-Reply-To: <tencent_33BB8D919274DD80DDA299114FC60DD02507@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67551027.050a0220.a30f1.016e.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] WARNING in nilfs_rmdir
From: syzbot <syzbot+9260555647a5132edd48@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9260555647a5132edd48@syzkaller.appspotmail.com
Tested-by: syzbot+9260555647a5132edd48@syzkaller.appspotmail.com

Tested on:

commit:         9731d37c nilfs2: prevent use of deleted inode
git tree:       https://github.com/ea1davis/linux nilfs/syz_0163_v4
console output: https://syzkaller.appspot.com/x/log.txt?x=10b0f330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35f1fa828fe386c2
dashboard link: https://syzkaller.appspot.com/bug?extid=9260555647a5132edd48
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

