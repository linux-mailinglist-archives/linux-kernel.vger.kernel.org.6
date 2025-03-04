Return-Path: <linux-kernel+bounces-543172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C853A4D269
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651291725E7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 04:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF801EF0BC;
	Tue,  4 Mar 2025 04:14:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FF839FD9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 04:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741061645; cv=none; b=spnLRYygZaKjNsKeIH65ovkYXltCyO9UtGq+RR2c/fqM6Fuv3gKt9LhAriLPs9zL5eI+uNFXRAp1Ky+TsolJrnABkeO1I69R1E7YMyfll39DCOQCQ1ik+L1EdYF9/KBRse4Jgd+oiyTo0iG2hzFF8bsLWnUs3HPnUYu8H/z8CP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741061645; c=relaxed/simple;
	bh=/OyAcaUgXkAa33JxxiTMruO851hae8nN6gQK+TsMHq0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BptAHQ6xRI0S8Z7HnYR03ho2B9JUPs7c3IclbUgI5fjFF9tDK/p2DPlIsyKN9RWZ3AxqnNurkY6gCJR33tRG5tN8h5ZJCYKcjAMnwFKQD78U/xCtuxceSx47b6HwuPcORS44surtBIG+q+roARiot0nnN0IKlzIiZ6mmmToaKbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce8dadfb67so57388445ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 20:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741061643; x=1741666443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+ZkxLZUFrIEjRVq71i0gUo6BHggdCDMBnIFkGUm5TQ=;
        b=RXRkOAR1v3nan8+9vCWUndrEq8sLP6dIGZ+S9lthShBzCScbo7CizxSws3IInX73YG
         K/WuJ6KpCRCjwACXVEtEI+yTo8a8HF7r5J+ThBUiJBFuXH0s8SN6j5Z6M+MYzvLbwdwu
         HuO8Q1cIH01tjrFbf+LQlaZ6ORIryi8IeXcd9ggrDi0oP4fxF4a+NmQfJo3Yl2acbOqi
         Po/l83xLO87gU7fV5gB3PNgh+OICC0zwoZEBNQA1sJT65nZEVoJmlhdgQlb6b/3Y9ztv
         CegxcLf9mx8s5xofJDVHvh8o7Yf+fb1l/ghwaQtS9keg41Lphdn/hU74ZN7M7g9d3oX5
         kx8A==
X-Forwarded-Encrypted: i=1; AJvYcCU4IoOYfvNHTtMf3XKNLOjxL+UO8QbmNsZmHrQA6nPAyUM1eFtqkT+fB3wisFJnfTdBfKHoUyCgLM/LxU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmqgiKqLmgJjZfp8bKsUyCIKUyY1dSpCShf3YpXAuOH8OLKQNj
	czv9E2Ey47CLrXx1uqmC6KrdvCsDGJfO7sYNfsxFnThZ+LuQAAQs/3vN8YpcauE0hi+XhdiOfVA
	uT50e/msPgSpRpznBFNGkomYEB7rUTTq9FOgdvI/2Mq90BZmGQqoBIaM=
X-Google-Smtp-Source: AGHT+IGezPazWqn3wgrgheRWxBCDDcbo/FKWsd/MoYawZqJI2mVu7bWEEgmwOrNhtIwmD02TpttvKAFNQWInQ56kIAuMQAubI6YC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6b:b0:3d3:d9f3:6314 with SMTP id
 e9e14a558f8ab-3d3e6f565a1mr175190455ab.18.1741061643570; Mon, 03 Mar 2025
 20:14:03 -0800 (PST)
Date: Mon, 03 Mar 2025 20:14:03 -0800
In-Reply-To: <Z8Z5T76R9Y0HhOZ7@strlen.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c67e0b.050a0220.15b4b9.0001.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in
 nf_tables_trans_destroy_work (2)
From: syzbot <syzbot+5d8c5789c8cb076b2c25@syzkaller.appspotmail.com>
To: fw@strlen.de, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5d8c5789c8cb076b2c25@syzkaller.appspotmail.com
Tested-by: syzbot+5d8c5789c8cb076b2c25@syzkaller.appspotmail.com

Tested on:

commit:         99fa936e Merge tag 'affs-6.14-rc5-tag' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10386fb8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da4b04ae798b7ef6
dashboard link: https://syzkaller.appspot.com/bug?extid=5d8c5789c8cb076b2c25
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177398b7980000

Note: testing is done by a robot and is best-effort only.

