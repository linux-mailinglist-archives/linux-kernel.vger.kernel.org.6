Return-Path: <linux-kernel+bounces-436598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAE49E8828
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 22:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A992811BB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 21:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC37190685;
	Sun,  8 Dec 2024 21:42:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1631DA23
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733694124; cv=none; b=aEugY7EuubWJa/lAr9SSI+ogYiuNxW9x88PgsWdJfApxqe0oDQtsacSnZdytXg3dJUnP1+eufDIeM+mBhR9YbHpJPrjQGwbNavr3icqO+/kpYWmg/gC8DMa1gze1EfStjsqtduXBH/iW6iK8ZyUi6iLnMhzef3zIgpuO60tyOW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733694124; c=relaxed/simple;
	bh=XBWOSBf53+iA748lOp4Y79K6ZcvUEzuF7zfpE65XhV4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A9gGdgpA/kgN0DMsctcUzluqpQt7umHH879S/A5LkaPoN6VHem6XuA/tQ5Zq/MK/a6//ztR+1Bk30m0fJUhe3Afe3UTauBiOF4kz6jI8d/UUT1pqG0juCPKK1gKZabumLlmmultF/WWliGe6/xJZ9TeAPIQoVzrqkXbyyz/h4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a91a13f63fso13606805ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 13:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733694122; x=1734298922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNHqcpZhIDAiN2PJPD4BSlffjPjpIVffvBbxLKtQY0o=;
        b=UhMzMKaxh7dSBWoHv2f/tIiIDs/JuJ3vYM4sEGwM5AFcnYfZH33Twzh9F7WhIu/uJq
         HYT/0IuSmr09Dx+9utbVuXLP+zPpjO48HjYC+cKm5Hfrz+k8oax+M0ak//tgRPVq317S
         rxCCqm4vi3imU1oAYCcMdvC/jcQNOILdoy8MStTGFGhr9GCxFNDQy01kHsdjnxsmj5I+
         BLhB/45KLvuS8FaxBdMoyKp2JzB1iX9A05z2FrsXXeuQzMUeux+3aE6Q6UmuRbmozVSm
         fF0uU/0NF9zx1jMmsq7BAXONjucGAaf25HXV2IuXg1lnMThg2f6OHyTsKKdF7phqnFqA
         H+OQ==
X-Gm-Message-State: AOJu0YwuEHmq58Q6tWO1U6dkUw43YolZAZmEFro7jiJAT/pqKTiUBzwq
	aU4Q+csMlGfkB2ACCnvZis7vnj+wKsjJCHWwnqhcpnxjDXZx+Ahczgn+Qo/ilMsOIk8TOvu4aO1
	5/vgpo5/yd9MExsbKXskhuvt0UyYmLBK2ranI93t6s8CUy3srFxGmC4o=
X-Google-Smtp-Source: AGHT+IHcEDM0oZswHzT/BTC4xA1T4GGxsbQkRYVS+FEFVmn+RdY/PBq8H01axTfVHtDmpwPyRVzqJQTQjrPHPBa0JcvO/qvyf6ii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156e:b0:3a7:e701:bd1b with SMTP id
 e9e14a558f8ab-3a811e38cc8mr128573445ab.20.1733694122309; Sun, 08 Dec 2024
 13:42:02 -0800 (PST)
Date: Sun, 08 Dec 2024 13:42:02 -0800
In-Reply-To: <D66K3G6JFJ4C.1UV5Z5BMPMJDB@getstate.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675612aa.050a0220.2477f.0030.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mgmt_remove_adv_monitor_sync
From: syzbot <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mazin@getstate.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com
Tested-by: syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com

Tested on:

commit:         0b6809a7 Merge tag 'kbuild-fixes-v6.13' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158148f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10814b30580000

Note: testing is done by a robot and is best-effort only.

