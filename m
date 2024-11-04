Return-Path: <linux-kernel+bounces-394402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6D29BAE85
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFE6EB21B7D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E163A1AB6CB;
	Mon,  4 Nov 2024 08:49:30 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003C41AAE1D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710170; cv=none; b=nTnlQS6K1i7JI9ACAh2bl759f1y55CPspkd5Q236s6p+cB4EBWL3CjmV6pSk4RcCNBUAHmoKBre0EDxQTGTQU0HSNu9uLpL7xLdT8qUY1P1N/gDHpj8Ya6QQXNyg9Klj3X7n8pgBXSy4cL8Oei5FJKEe7RbfhORzmnROTMouPNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710170; c=relaxed/simple;
	bh=2CtKw4N7K5hckcr5JPajFpZr1aSFoQyrFdPoYcSWOQ4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SJCToHjrJ98+dFx1YZ3d5KEpqIHIydKHzQpxPW8yITYg6fNvHExxEocjZfg53Riy8TnTaT9OQjxfguBrzHRtpa9Chx4uwdmpU2CSpsbpp48/7PR48eP0k3B0Ll42giQDciPqfTvjLam0diHS5CtYh8whqD+6W9adyvyUXsStkVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83b567c78c3so358483639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 00:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730710168; x=1731314968;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=947uRC0q402UiUvSswI3BE0lGbPT4GjfN2hTdWXxB1g=;
        b=oRS+0162EVux0B9zOhsjoPSBbwv+v5mSoguqmfbvhaQ6XRwM+52aHg1ccP1O0fwrsN
         JJy17omqliWPtmC24q6Rfw3GxN+JyFZFJbEctcONU9oGeXP+oWWWPxeHZEyybNUwxG8R
         F+/vXPumY6WMfzwCx30m5INgpa3ceQNTH7TkQhuGRUmWyTuVv3Agxv/bOXoTS0A+gK0g
         3/zzZMGY0k0yZLnUANtxKAYcKCsx9vHplf21lo/do43c4a30N7L62hrlWY5s1onitwXM
         J8uNSwmP2iGX9jmRfcWikgIHoELUoBig1RBsgvfpxXJAqxtKvfEidZ7VO7w6Bcknawzc
         Ot/A==
X-Forwarded-Encrypted: i=1; AJvYcCVeg2wFZnjIMsWwhDgUMZLAVXZ4obbO8koqkTCavbth1rSRqjnV1PHKXmhA2zyX8x+MyQh8d2QM38GQPNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZv2QXIjDfHll86Fj5ItIAp04HtFQcvscLZ38IWKX5Ng0DOxOb
	WjrfzYvOH/SPqCjOLUUydaYvlB7AIERtlYYV2cwRINW4srg32Z5T9duQxgxUCMy1GhJnIf5kuWt
	PyskNFl6PDUWSdipyXYlZYH9cwwSBjQrt+34V9L0mukHXgJdvfrnL8GU=
X-Google-Smtp-Source: AGHT+IEraG8UYTtPnu608+FJ+QAnn13yFAeB99aFB+ak6LqIkI+897kGnsZ07OQ1O3rdIeRzGAAnQM/PmJfPK6tR/0xqKeF/+K53
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8d:0:b0:3a6:b26f:a5c4 with SMTP id
 e9e14a558f8ab-3a6b26fa5efmr85140975ab.8.1730710168042; Mon, 04 Nov 2024
 00:49:28 -0800 (PST)
Date: Mon, 04 Nov 2024 00:49:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67288a98.050a0220.35b515.01b5.GAE@google.com>
Subject: [syzbot] Monthly arm report (Nov 2024)
From: syzbot <syzbot+list51e520114d625491a66d@syzkaller.appspotmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello arm maintainers/developers,

This is a 31-day syzbot report for the arm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/arm

During the period, 0 new issues were detected and 1 were fixed.
In total, 5 issues are still open and 5 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3052    Yes   BUG: bad usercopy in fpa_set
                  https://syzkaller.appspot.com/bug?extid=cb76c2983557a07cdb14
<2> 661     Yes   BUG: unable to handle kernel paging request in trans_pgd_create_copy
                  https://syzkaller.appspot.com/bug?extid=2d1f5a94167d430a3bd7
<3> 94      No    WARNING in delayed_work_timer_fn
                  https://syzkaller.appspot.com/bug?extid=e13e654d315d4da1277c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

