Return-Path: <linux-kernel+bounces-304223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD26E961C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618D31F24B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D83876034;
	Wed, 28 Aug 2024 02:28:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C377E59B71
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724812085; cv=none; b=cHPqnNXmsMPUe4d5gvsLakdNh+UYVL/6sw+2dQ+YvJPd/KIkwBYHdlczC5WxX8xEd8ZLjjhcfHdHCXEWrBsL0v74X+NaKiBFZpNDqBPdSNQatlLR6y4eoyo+x/1oXy8ZdRuzGxRQwQLxfbTo5PPDcyDAILnbU07aG9cL+PB3YJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724812085; c=relaxed/simple;
	bh=OZcCy0CFfR+EBDWMFWP4WwYgfyxE1iSXYoxF+EYREs0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eR72qPMGzZ9PAv4Rl5gLIOoa3wlQ7/L+lTMGxzd8yY4uz5NyEbF1TZcQz9bWa6EU/KT5vdFH1Z3wDNzHeprVlcl6vcZCEMQhrp2KEKQFavVZHTlTeFiADR4WGew3w3LBxd8aoA0ygX67gS6EopchqItbJSYEAZXQZjTDlgXCyvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f8489097eso632114639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 19:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724812083; x=1725416883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHLlNucjdgZnGSaFHpd+oJkiqfX+hI0XI8mC1dvPpns=;
        b=P1NkVzyyPLlC2xi7i2HQaCN7wB+xT2WSfZpfe0jz33jmy1Y5JTgf9d3vNHePBVVzTu
         WR4FvBV/QEd/FQia3kmxZfimhbxuivyPnVkeXNBwC0o/KzkuYh6AJGqLTwNfJw4TbjUa
         LMoP8VrhcmUK9LykKRpuOTBj+D9PTvCaX2XQEqletgSP9VwUptr0tpyyZGXQ2Ncncc4Y
         Gy+1YgJhLQn+t7ewFVv0iZR+fev95bWw+BRgUTWv+w2hFduxkPhmnFhxjJVQza9v9Bkc
         zC7CQOg7GjyFFCREFPlBoi/6I176Z7ceVUc8HyQ+tjMPv+tnmre8ijjPkTBd4PjyUcwe
         r1fA==
X-Forwarded-Encrypted: i=1; AJvYcCXX7Uw65NfVZ4kBxsSFH1/ZMzqDegiVNk07BCktusDtFKPbEso5+Fa8Ax75WibUht3AdBSdNWf58X9DEC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykHhsRujDwJT3kX4CBmHE+tPfll6HQ5ri/uPiRrBI41mqjo1w2
	HrwzcoJ9YC/s1piLwI7oBkqpgPtXWe/cXj5nAOaJXilesiIW1we2P55bn/0h8pAW619W1vfG2Gn
	lgqcT/EHXtHSdFfsBJ2HUuZBs4dH+GVIQM5emMWNCeE2IlaQdfjhZaPc=
X-Google-Smtp-Source: AGHT+IEy61XSXDgW/hkwWeknifZ0qOzgPV+1DGhNM3cpkZpExMGnejM4gHF/sub1YKdDca0t6gJk13Xd1rJiZUukV87WLKbKbqMX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2652:b0:4c0:ac4e:3295 with SMTP id
 8926c6da1cb9f-4cec4fe6960mr21308173.6.1724812082807; Tue, 27 Aug 2024
 19:28:02 -0700 (PDT)
Date: Tue, 27 Aug 2024 19:28:02 -0700
In-Reply-To: <20240828013519.7810-1-djahchankoike@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000801bab0620b51be7@google.com>
Subject: Re: [syzbot] [net?] general protection fault in phy_start_cable_test_tdr
From: syzbot <syzbot+5cf270e2069645b6bd2c@syzkaller.appspotmail.com>
To: djahchankoike@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: lock held when returning to user space in ethnl_act_cable_test_tdr

================================================
WARNING: lock held when returning to user space!
6.11.0-rc4-syzkaller-00681-ge5899b60f52a-dirty #0 Not tainted
------------------------------------------------
syz.0.15/6086 is leaving the kernel with locks still held!
1 lock held by syz.0.15/6086:
 #0: ffffffff8fc84c08 (rtnl_mutex){+.+.}-{3:3}, at: ethnl_act_cable_test_tdr+0x3d2/0x10c0 net/ethtool/cabletest.c:341


Tested on:

commit:         e5899b60 Merge branch '100GbE' of git://git.kernel.org..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16a5267b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=5cf270e2069645b6bd2c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c1c57b980000


