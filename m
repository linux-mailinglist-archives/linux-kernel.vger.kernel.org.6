Return-Path: <linux-kernel+bounces-416255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8719D428F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648791F23886
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AD61C1F36;
	Wed, 20 Nov 2024 19:29:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48F91E515
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732130945; cv=none; b=GPisw8dp9/loO4qNC0f35lzOP50x98pnqsu8v1tVUszN3J8VFCHxR4Y1cTaKdm8Ixe1YjKnr6Vx9qGdNlU04D85Sv/ToU1s2vyt6uHpImOHVFs5Vg28ljZOQ9ZiRXdzA7cAa+0bzd4GUGgcdcthwOAgNYEIEHx/MgR/Eb1IHKRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732130945; c=relaxed/simple;
	bh=VaTuucVZK23kszHWol+dNGYYCxpmveHX5GHPyezs2No=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BjRYDAdg6P6gUQizLU44R7UJ1t531LUKpnE6KhdxX+dC6WnYZD9ZaG7CAmXGaypMWlFfbypXdA0B0Zm4esURkwXaH7dL68WVOK5FoIoa3210bP1QBNr4fAQ6NudyxPlmpwjsq9j7Jx2VDdTAkt6SXX8BJFcGf9I2o36r8gkapDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a76ee0008cso660635ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732130943; x=1732735743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kigcNKsHNhNUC0rVQr+18Y3HBmTWUotyJEiGg2sGl/U=;
        b=T5qSzOiD1SOFuTe/l5dNGezJAmf8PYnL+R/WRXmC1RlbsN41Ct9Te14YNOLxCZhc6P
         DwQJPP+5PQpB/EKiyyrmjmXPUDOxsGR+jmm0VAhRigdk6whr1njN10zsgQgz/K3eo+Ox
         LebReIs6TezxNvnmcUSKT/zojO+wkmFfLNeAWQ6sqkwUtfIsmHZUQEhAOfsKzQoNQ+Wh
         Z+tBlQudyMVDjwGspoPwc/j62IZ/DcPV9TyX3Oxq9B3jFIcd9AFBY0NdknY1R7SW7KsH
         TQ/ns5giUdh033YRM9iZOUoc9CCFJqqX2pb1lVqILPanAuoSZOE3LCFF57Q3ZBl6w7w+
         yiEw==
X-Forwarded-Encrypted: i=1; AJvYcCUDlw55EM3HmNgeWSWfwUWPIdEiDMTePqkiYQEp1XeYkBgJ0lEJFOfn16rObtcJcR2+JW77LnwoLH3vWS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUP9bQ3VYkj/UIZUoTkUOsa4+Fd7HKTOt/BFomeAksB7nOQrHa
	/1/DD0aYcSVO4rSe3ruvhcFzV3TMVr7xCZAXOsuKQKSH2Z5ppOX9ZrIIyvwKOuEYQ99IxMZ6Oii
	nEEbJyGtpWohH5hiGmwVzRALT2WElvABKVO+3ZYynPXQz3bUeRRSTXoc=
X-Google-Smtp-Source: AGHT+IGSOYrnUqZg0j74J1sk/JL8EgeeyNqQDPUhj57KRUVBE9hgW8c9sBJYadSTYN0bivIfD9v5XDoJtZSof4hhfpsIh1zRBIn8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd86:0:b0:3a3:4175:79da with SMTP id
 e9e14a558f8ab-3a7865019fcmr38433375ab.13.1732130943008; Wed, 20 Nov 2024
 11:29:03 -0800 (PST)
Date: Wed, 20 Nov 2024 11:29:02 -0800
In-Reply-To: <b8002d24-9817-4913-8da6-c652e58a971c@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673e387e.050a0220.363a1b.002c.GAE@google.com>
Subject: Re: [syzbot] [mm?] general protection fault in do_migrate_pages
From: syzbot <syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com
Tested-by: syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com

Tested on:

commit:         ece1262a mm/mempolicy: fix migrate_to_node() assuming ..
git tree:       https://github.com/davidhildenbrand/linux.git mempolicy_vma
console output: https://syzkaller.appspot.com/x/log.txt?x=1702bae8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f401cb14a38a8175
dashboard link: https://syzkaller.appspot.com/bug?extid=3511625422f7aa637f0d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

