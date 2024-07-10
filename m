Return-Path: <linux-kernel+bounces-247588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D1C92D18D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44761F2228A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E93191499;
	Wed, 10 Jul 2024 12:28:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968F7848E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614485; cv=none; b=XUuLO6jiVG5QomzvUU8AiuojBCCiAVJfie+js3wz18HkomjXWQQezk7BTTuVrfLpZZbpiLoZAJL6pOzRgLNWFROm1f0zsI0W4H8sEwaHS7G95xSnkMI1+fsw8SBs+/ynAhwMz6t1TXX2dj24LaH26bSDqUt1Mq79QllVR0vZAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614485; c=relaxed/simple;
	bh=FIo74+MaoiWUC8xkYDfiyRB22TPZV2YzgZdkt46aVcc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jSENVcoYKNi5S0oHXy08W7+3vkLKlpncsy9PHh8NzlkgnPrlUMil94V7IZdWXVk/g9vv12CbNRpejA7vZET8JoWO4JcMI9ePRsf81rehgshcByGbqnznBcj1m4OmpylQRQtZYLx+CofofmgO9l1uNj0i1qbufdD6WkS9Hi02kas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7fc9fc043eeso348759139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720614483; x=1721219283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MQSwPjcLvlTywvMFoKitsBZYGS8ON2IjJ+7g9izWs0=;
        b=VwGoYlYx8CMKdT8vvvax7RaH/QVt17ELrD41rX0ZOuvaDGhrFpDU8N1uT8FKDJdvBr
         rCcKu2VT+cg51CtCcvWGRkqg9ST0bck6i8t/t96AgQvRfg2sHKZiYDJuCDdsYY+nengn
         OdyZqSbl1U3y9eCyWK7ypu9A5oaspvR4CqHgpHdk4XAmO0O6qaWd5ebu/eAq10qYNddW
         pJiZCdUVSTPCGvOpUvq3rpO21eQOF7zz1BMiLZp9P2n0yKLU2Y36b07nnxAv+XWzQ11o
         d3/m0RJNPHUxeHoq+RCbFwuFBTWdUOdxzL9gMf48eCTFlucU14yWXq+d6llV+FEstRhy
         5THg==
X-Forwarded-Encrypted: i=1; AJvYcCW7MKB3ySNXbpDossrh8/tpxgeFxmjxLh/yzQmCqNHhusBoQroV1X175kY/NSHkkhY2I17vH7M+L6sfsZd1Ggk/spOM/3AZs7oN5LHo
X-Gm-Message-State: AOJu0Yzd74JmKAmrPCi225PGwhoaCavOj0fVOF8brhOoYbpawuit2a0+
	se/4ZT+QvGeb8UoKX4r1ZB15afHklpzJR6vRant3KuaE2UP2arcvrNc0NF2aaFBt5DMC8CGBXAc
	5T4eOVUmdVhqUm9V2ZkOsKcj7zVLwQzb0W4vjVROgFxcOF1gv019jdcQ=
X-Google-Smtp-Source: AGHT+IFtjdhqLTv2at9zhmW31utc+VFnp2hu8ZbuZmbbqhepW34m4u4NJR60Vg2wOp10SuATuf7ZGJqYJXVJ4lPeSGQ42FXKsyYa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8608:b0:4c0:9380:a260 with SMTP id
 8926c6da1cb9f-4c0b2af25c4mr356574173.3.1720614482774; Wed, 10 Jul 2024
 05:28:02 -0700 (PDT)
Date: Wed, 10 Jul 2024 05:28:02 -0700
In-Reply-To: <20240710104650.1032-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000aa151061ce3c788@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
From: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com

Tested on:

commit:         185d7211 net: xilinx: axienet: Enable multicast by def..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1505d6e1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=c041b4ce3a6dfd1e63e2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d4869e980000

Note: testing is done by a robot and is best-effort only.

