Return-Path: <linux-kernel+bounces-338284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8319855E6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BBA1F25266
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B0B15A864;
	Wed, 25 Sep 2024 08:55:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4446158A18
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254506; cv=none; b=Y8aKTkGGEWY8w3xAn5xb2OMiLF2XgZNMDrMj93nEg0+kkBJvnSryNGxmcjSMjmUtWMc4SGXkS45paZ287h44b1wh2jcz0KT03V9Uwjwl9YaPVjUDi4v/te6Wy/3RFMe8k0fk71uILpwZykluaRcfaBfLcuumPrmdSWo9bhTNlTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254506; c=relaxed/simple;
	bh=73MPY6aoutLl/EA0dk0w49JFjhcA2BSDLXc0ZfHC7So=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gNtHA+T19eVv+FL6w3QU4BbK3/DBqXsxQ43ngtPi7hJE24hoLvFjTeP4SzJFP20jJh6Ht/iqtz1cFK78E9uX4hmOCSlC0J0YETXNxqcnnEzOKm3LRvLRGgPBLgiW8Axb+6cI5+JPtM897GZbtDFyCTdP9BiJ89tBd51Ax4eVR+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0629ed658so63125845ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727254503; x=1727859303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEMTbiahrepVGJTD40IQdXijMvf08ZrzOrFqeHstblg=;
        b=on10rn+4y04ytHxbNCp7Nma9NxuqzpQ4Ai21FOOK45UzxtGz65xoni/W0AYVq87PXU
         qnQsL919YkwMeQbuyhj0QtShzGkZapKKkz2pm4u4slPJkup/fTsuD1doTlbLp6kc2SEK
         L2ckaU53p4nClo3XHe3tSKha/ombEDz+RMwnSV8edHxd98Doe99gdDDHf7qwRDwa7pVd
         iKNKr9iSlRFskgCfWoUa3x9la21rO8XfHrNG6mEqI6PxU4TbVu3Ji1oaKwEIjtn37qI5
         ArezF4cZ6Polrf4oI91n6o2SOZbmZpInfPbBoQKCXUNO6Qj/HSxA1VPZRU/KzgUiFxbC
         LOLw==
X-Forwarded-Encrypted: i=1; AJvYcCVbFlvKCytWYCkimcSDIfZqWl5DBdyFdwQekqLQvW4hdsLhrKTLqhIthzd2W9gitVz6ymO/xucs9PP1vj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxun2BaJ9euRvPu4dzGab8i6E91AaK66JJPsX+IEvHbPQJLXdUY
	Y3Y1Zl0G8ztVT9FI7kx+shMNuiyzXq4BkB/q4d7ZJ8o8d5MeI1Rs/w+ZtGhbNrPqYE4FdmgLDK8
	hItfGS/2JXVdBNwcLPc/6nmamO++Jne3M6hd899PUn8nXcpeIRYoX8eg=
X-Google-Smtp-Source: AGHT+IE84KSyKVyp+PYMEpncD5pqsII/zmei/APPWrJ5Wpu+N4xC4m5S0PZQ86rGdx31GmB0k6UBGW3MAXGDglCMoEI3gLOTMXLL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1446:b0:3a0:ac5a:2015 with SMTP id
 e9e14a558f8ab-3a26d7095bamr22899465ab.6.1727254502870; Wed, 25 Sep 2024
 01:55:02 -0700 (PDT)
Date: Wed, 25 Sep 2024 01:55:02 -0700
In-Reply-To: <6e7d21ec-f4c0-4c94-85b1-afa308fdcdba@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f3cfe6.050a0220.30ac7d.0012.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in ocfs2_get_block
From: syzbot <syzbot+9709e73bae885b05314b@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9709e73bae885b05314b@syzkaller.appspotmail.com
Tested-by: syzbot+9709e73bae885b05314b@syzkaller.appspotmail.com

Tested on:

commit:         684a64bf Merge tag 'nfs-for-6.12-1' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fa32a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fa513ce0305877d
dashboard link: https://syzkaller.appspot.com/bug?extid=9709e73bae885b05314b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13398a80580000

Note: testing is done by a robot and is best-effort only.

