Return-Path: <linux-kernel+bounces-197283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F038D68BA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D5128785E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6E417C7D4;
	Fri, 31 May 2024 18:08:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651D1158D9C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717178885; cv=none; b=CRZNXnM65JdqwKFp3DEzkVDUc+bDFzZinq6aQwaHXA0BAqQiXhLUKKONUAuK3RsdviJL1TDrAss9FPdNfbWfFu+FaCjMumnn0oRlL7BBQ9zQWToeBtilIpgPl68QzcooZdG+dEC+q6I2p3ZsRWfuT4mK4L5VaD1rdYH6KZyhZ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717178885; c=relaxed/simple;
	bh=+T0VfwQFHfYCM/V3S0P+4WbB+MFmU39mFu5gTeHNxSw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SENI2La6vNaJYEyYh314Y2J7I+N3PkH4rvezuJGuBs6UKtK7biznaGqELfDnYKofoSHCvu4Ktyj933y3ORufahvyTNrU4KAht30YSNXc2lY7qx6/GmC1DdNkb4SoOuywfpH8Xb2aPH9ueDjYUoTbkHGRZ1zMwwQjtrQDEymUF7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3746147204eso23687485ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717178883; x=1717783683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMqRSYIu/oWbzcngVJSPhKrHM1DausE3mvbG/YEoPU8=;
        b=fQwq+vstmP3Y/TCaILGoL6JTkiaWBQibhM+7deFsG++tsTdIJDM5mSsuervbaIIFZ8
         otCKnrxUrlAEMrjSY3dGDqOxnGjAdj+6S8cW4ACRIO2Oa38xchRZCTMEZ2zNlFTFYnp5
         hSsCiep62zcSdIeUNfsHa4CIBLgJNveVBwZIKT2ETKPeTZkwVt46BIRmWTW0IvvZad4I
         e5yoO//jndznpj9s5AmXNuwybfmlRUaQalyD/WWhCBb+QR+gYHfIJQlO6Swklr+Qc/VT
         chfebOA6bKx5F/InJNHAaINImIzoUQ7xS1rCKs+VsUE/VU68vXT+xSGrZ3CSgSjfoQAG
         Hsog==
X-Forwarded-Encrypted: i=1; AJvYcCWVjZy8C17slCdOlabMLxP3LFe2LZQHds/oJe6Uct+0uj7SOI0/ODiftgpQZvTqd3kRsvbkFcW3CjwuX4q+XWLkbOKO6p1SLRA5mxKq
X-Gm-Message-State: AOJu0YzpBzGNceUFYRYEI6tQ/ktvLQqFnqqMl7fiLxlxhY8armnVOFT+
	3vKUQEidUiGGRTOS1Ea/WfCLA7QLTYHy9NV2+6WGnPX++NUSF+2lilnCpP44fzjwm2iiu0OyFw8
	3XkZdnvUKqTuVyvs0FmiV4Kp/au/m5KiBf2L6e6kPK2kps3zrlcrcTYc=
X-Google-Smtp-Source: AGHT+IHlnUm52+we04NZIIhBMjsEyta4K7OxFy9tjm1Fb3Yv70+rv1RKwr/8/XiTs0tSaSCJjyXT+r8Lq0EtpEuubeq6ZhR5k7ER
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d05:b0:36d:cccb:6842 with SMTP id
 e9e14a558f8ab-3748b8fe486mr1084035ab.0.1717178883653; Fri, 31 May 2024
 11:08:03 -0700 (PDT)
Date: Fri, 31 May 2024 11:08:03 -0700
In-Reply-To: <20240531110250.3333-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006055ba0619c3dd8f@google.com>
Subject: Re: [syzbot] [kasan?] [mm?] INFO: rcu detected stall in __run_timer_base
From: syzbot <syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1320d4ba980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=1acbadd9f48eeeacda29
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16adb026980000

Note: testing is done by a robot and is best-effort only.

