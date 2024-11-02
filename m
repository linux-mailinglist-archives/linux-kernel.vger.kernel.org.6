Return-Path: <linux-kernel+bounces-393117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4A19B9C0B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 02:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42AB61F21CF6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DFA2E630;
	Sat,  2 Nov 2024 01:46:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853F43D76
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 01:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730511965; cv=none; b=ddqxmMAGUCsMrvh21+iu1l866L0IYjgQqZwICSdRebjOl373iWeR/zdUUWPlkY8WHsE5ZOXttTodPqkTcfoUFwxDEUoDLw7K0R13fodXkXHZVqSmxOEAsdu94l2or+MZdwUpQ9bu627QjW2DVatKOjvKCf0JukMbCBeiTXdcfkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730511965; c=relaxed/simple;
	bh=ipN9OTmG/JFK6/BgWypsqsrrcg7bDLeePf2GOlV1Jcg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MybVOeLMuOV95u9K722RqtYZOXq9TBpDlwyT3FYV4KPVgpDxgJhWV+RHqICmpEinHoPQk0GgUB0tYsFnbnE1ILIZ9JBrXDxFhQxbmubn7kQ6z6jBcytlg0LV0Eg3oy6vs3mXYxQ9KHq2ypa5IDMQ4U8RS1UfpNDLsNdW9mRv+XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b9c5bcd8so23504905ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 18:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730511962; x=1731116762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXdrwRBBf2WC9VPX+N3EL36LnHhvBJ0BvRYI9wpkH7o=;
        b=tkS+khqkFJjgeHxy1DYl26kcum084vosamV6wA2hDP75098WnyUR8BUlnvmIBoFzEm
         jx+i2C+Npli1LUXXRCVEK3Yhn6T4htz/x1pTyaRf344ZyNlk79g6uZi1Msbztqj53JF1
         i7bwcEecbQmUX03iq6UtY7M2qmucwbAMVjRvuH6CK/Ih0AeTteTXopybfP1FH7JUJ2j7
         JGGsDFqzKXMZ3YCCNpQIF5XamfAJ52zKCtYSv3KIvZN1pOOw5NBLvfUTedKcZhmqxgsA
         tefUZszsT7nhOJOd361BwMI5z4WArkKl6lFl9mIFJXbpg9tEenCFUJW5Kg3xHyBSUxcQ
         wFIw==
X-Forwarded-Encrypted: i=1; AJvYcCVcXYO5SRA2UIEeEETpFt59rIjlNdhAjb6MC1qprSI/YDygXqW0S0m/PCOECr87/p5Ktzdp0rkls4c7QUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YylJICll1kIquplcA6+hWdeITqKbw7NPNfjnLHoOf+NDpVUbx3Y
	Q4SeydMGorqA3RV5Ux87Hho48+aVqEGrgfwDhb0cO1kmtMtr7Nh7PnyG7T2lMWl0+SJVgxj4LD7
	lcRemtlfVZMdG23pix0cAn/qaOODhWkV0NSsToZJYu2mAp/VT4kAknN0=
X-Google-Smtp-Source: AGHT+IFEzY5/VXUdwtoCsweKnph+ngjOcREYM+DCmLab99tJqdcWf4zl3dGz40r0ruuorEuDjnZy0uqB88leceLQipXTpwUOHL0a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b86:b0:3a6:ad61:800f with SMTP id
 e9e14a558f8ab-3a6ad618154mr77123755ab.1.1730511962703; Fri, 01 Nov 2024
 18:46:02 -0700 (PDT)
Date: Fri, 01 Nov 2024 18:46:02 -0700
In-Reply-To: <20241102012710.2865-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6725845a.050a0220.3c8d68.091a.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_unregister_user
From: syzbot <syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
Tested-by: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com

Tested on:

commit:         c4264568 Merge tag 'acpi-6.12-rc6' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101af2a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4340261e4e9f37fc
dashboard link: https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142ce187980000

Note: testing is done by a robot and is best-effort only.

