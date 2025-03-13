Return-Path: <linux-kernel+bounces-559146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1305A5F00D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCA607AB467
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F360126462C;
	Thu, 13 Mar 2025 09:57:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ED714900B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741859827; cv=none; b=W/qK90MElbHntqHTZcHZQewzNuMBHD7oxqxuqy7Kol7y3m1Wneh2209lsQX8A9wAAkBufxyKXA/ueJwnrR6Riw8YLXaWWsef+mW6gmFRWxcnHJa+n175OcIEQyAhZQqdmarMfNMIGnM0euQnIiheyX/MY3kkhlGYAmV1vw/GB6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741859827; c=relaxed/simple;
	bh=W3cXuHH2J1FCp6rCLC5CKYnLiJ2ER8kWxWTPeasimbU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FR2id6Rli7Iol7Q7FbcvVRulkjIoqmIXDEISVrAELT3I6iE9y3lTi58+4N16RMZZykXvNTglU0F6rCRMq/ye28HIwNLIMVkP5etZHLhaJM8aXP60ui5VDgksRirNH070h6s2r9Iv+8riEWM/aXuQ78//tcaAegQhtXiJLSiCxCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85dac327403so151662839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741859825; x=1742464625;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aivzwx2wdrd4DmowMgIcdnubQSExNIw6XNmJdfdBilk=;
        b=RcL0+SGdy3v/2UOVursLBvKWuweOu216JzW7KrceswtM1yNuXr8eR6TyCVB6rwnk7r
         AiiPiwSaI17hdOXSecagR1hKgrOH05bNwScSnjFBf3GkM8Ne0qiRAZSbSbUd/tjOi6Yb
         sJoS7fddYY1AEAFGkksC+mjw+tKhlWiNhvAL2vQJcl5I6lBJmvManUGDxv8FNinsSbbg
         kIA8VAZKhg4oXJau6YPY5ZsGHOeSl1Ck3/T5WA6u3MrQsEZ8oSU+BpdsoNoduzqUADXE
         f8eo+dYUfmxhmon0Wv1wMQ+Qc9dqDAFxsIH4yLfIUHTcF4Bjvh6SMhH13riki5IqkppU
         ywpg==
X-Gm-Message-State: AOJu0YwyQQjQB+t2ylSLrAHXe6KrqFxMXNWPLP3oEr18luBpFwxUMWzN
	+OmQf1AadLB0KZA7axwOZlBKpSBRidnE0JpSNdNYndNsb1jha/6MWjesHdN39OnDF/IByhb/tYS
	Y3wVUR5DDzAReT/LUOHMWHPt3QMtWSHHI8R93eSyZWFnEyt985u2Lig0=
X-Google-Smtp-Source: AGHT+IFwphAjZizGwPuQfAI78CYLsQYKumfKBydr6vjxMtyY5nvBr4biBRycEDw1OJAp05xu7T6JaRMe7BH3zGLTnTd+snY3T8lG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b09:b0:3d3:dfc6:bc26 with SMTP id
 e9e14a558f8ab-3d441963325mr299502825ab.22.1741859825329; Thu, 13 Mar 2025
 02:57:05 -0700 (PDT)
Date: Thu, 13 Mar 2025 02:57:05 -0700
In-Reply-To: <20250313094104.1739899-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d2abf1.050a0220.14e108.0032.GAE@google.com>
Subject: Re: [syzbot] [kernel?] upstream test error: KASAN:
 slab-use-after-free Write in binderfs_evict_inode
From: syzbot <syzbot+353d7b75658a95aa955a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+353d7b75658a95aa955a@syzkaller.appspotmail.com
Tested-by: syzbot+353d7b75658a95aa955a@syzkaller.appspotmail.com

Tested on:

commit:         b7f94fcf Merge tag 'sched_ext-for-6.14-rc6-fixes' of g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5498c9c3175e1fe
dashboard link: https://syzkaller.appspot.com/bug?extid=353d7b75658a95aa955a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152e5874580000

Note: testing is done by a robot and is best-effort only.

