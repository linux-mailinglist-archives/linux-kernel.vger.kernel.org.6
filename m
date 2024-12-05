Return-Path: <linux-kernel+bounces-433564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C6E9E59D9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4271287858
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABA921D585;
	Thu,  5 Dec 2024 15:35:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952EA218E99
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412906; cv=none; b=kGIOiJ3Lru/vm6lYnkbNp48GWcpYjuaZuWJmv49Yo1EAmdQ0S4TdOw3Uz/1CZMk9IRx5hRjMI+qq1LhnJxBgHP5duNjzcCSiNL+vuZYwHE+58SUdoJYa0IF2poGJRIb9N+377PXYvU2IQNhw260eNTxVef9IDXEJ5AXW9My5KaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412906; c=relaxed/simple;
	bh=8Zy1xJENSRu/fqSg7gokqtE05l/AJYqZwKbRMqmwaNY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=npnBfn8vvfmvFAIYAHoenT1N9v9mKZI91aOqqO9oLkxgnrFfebwupycyquMIIZoJlRcK2Ai0uhk4ISTG/ORzp9XMjlnSOBa9mc7IAR2LBRrGQXRYukFv/Nq9HTK/QKpbZTh5cWMU3B9K91yIh9RoYFt2EIDZPFyki8k3V7PstK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7a5031e75so9341165ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733412904; x=1734017704;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tMLHk0vogVjsRJO4YICZOAWW/ayMFssyV1IsDTp+fM=;
        b=EurOu+z6lsnlFemqA+2zQZFzNBkC/4UZCLurhp9Y6n1ikDQqWE671eTflNmec6LMKZ
         ScaadsBAEQ7R9uqsYSzQrR3jbI6Guk8GxnADnz7CanW9D+b/NtpaYC67aSRi7IOsUyKp
         L3vKWUIxzBdK1Y++7rZ4k3sSHO0gJ1TkKAa0o7mnOHLVitDVzWIH8ulwO2fs8buDIm/m
         Fc/9K1fEph+nB/XsCJdIRZypGVByuGwndvIURs4wWIrEGDNMeVIuufewYAsYT8cVaqnE
         qndj+BKwvyEtmR4BvOtympHhHeACLQvalRfriOPAWcIFfe7d9/TU8AkG/NltSxDfkrCc
         bIeg==
X-Forwarded-Encrypted: i=1; AJvYcCXw7N1HLu2VkWfNHH7EDFNqd6eFvj7ts1zbhGIJ5NHEziAoZEZE4g2hAFAdXOp/u/udjkIOshggNPgRtLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrcZc8Zi06QNLRbKJBZln1e3juLpcj3mvZe1jM2I4PQFIfZ68h
	42S6j1VT7Q7dZ2M1q/lQyDS9wEyV7b9OWUrTCq757GeIPY/xwdkkeSyyGjx9AWKd72UlvB1r4HO
	Ix1Ynb35OzJnPTTeLtZt1c2rH5AqsaAT4TWvC2dLWYKsT4YSjxmqOOwI=
X-Google-Smtp-Source: AGHT+IErmAHBlWlXUmxa08W4Aht9gWLfTi4WP7iATiLET26xxGfxuukTlDDdYmE/t74tupmEmMtaylFktf9ZbEloAKLWi8AP4Y9a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c89:b0:3a7:e800:7d26 with SMTP id
 e9e14a558f8ab-3a7f9a45a64mr126695165ab.8.1733412903811; Thu, 05 Dec 2024
 07:35:03 -0800 (PST)
Date: Thu, 05 Dec 2024 07:35:03 -0800
In-Reply-To: <CABBYNZKEK9QXBbtopROD=94h7suNA_UbXUJp=H+7q_2n3OhO4g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6751c827.050a0220.b4160.01d9.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in hci_le_create_big_complete_evt
From: syzbot <syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com
Tested-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com

Tested on:

commit:         feffde68 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144e1330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=773e6b07384b3087
dashboard link: https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=178490f8580000

Note: testing is done by a robot and is best-effort only.

