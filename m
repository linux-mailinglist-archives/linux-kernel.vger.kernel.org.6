Return-Path: <linux-kernel+bounces-320015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0431970516
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 06:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D54B21A48
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 04:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079482B9B9;
	Sun,  8 Sep 2024 04:37:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFB14C98
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 04:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725770224; cv=none; b=okdSUavPPbt9UoXSLcPkPyncFWAcLD9A4xjhgM7PHU9BLvATRJx7RbwErT5uoomVwd0ngUMvuTWNhZil4tZiJs8kEu/uG4JPryqBPUttj7OQm7BlBcCco6ZtyNFv3/PuQggvziOpFMNui3dVCGTUMS1HOmCArHZQkwqGcQ/R+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725770224; c=relaxed/simple;
	bh=bbPwXl7mcVMe08TIPS+iIqFSQWWuAZhXJy7r9dlS2Ew=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ux6bdDVD68vTRue9qqiSF5CeWUZsewltl7Q33LE0cpgRo+hFKjy8LBBqZFB0tjCLKZwaOfiPzVC0UQYEa4Im5P6AagQG2tfe2BMJIrx+g/FVLG0Lq48K/+yh9nhReXbz5vj48iBeL1jjka73Ujpt4S1dCLu06Swe4LoVugDC3Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cdc7b7debso52174339f.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 21:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725770222; x=1726375022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7BvyJ+2UBDZmC8DQ/cPyT9aC8GkhA+CksbUFq++n+0=;
        b=Qb0/qOF06gWdWxhifIdaAQWyTq+MmD0aE6Aybx24BFOhJwaaxMj8jN3GUqu6BbSmmd
         cFX3p8OImMvzxj7YkUs76Te8WeJzIodMbbgjyPX5J++04NH0e4KmuedJLk1UWYrlWwTG
         QAhFgVL3YgdwE1RcjiSttEQJjqUXCVD9VtdXbwFtM5yGHd4imGOQnEG2PhsAlQBIYkAk
         R1X9UZcN2AgTU1JT2WHlk/rbvkHj0ehrcWcQfeOUawXKruevp4vVdsxLvL01GmjfohTE
         oEvQv5bUr8GVewU1fMd1eTT6qQuKaGSpj+8P6B27/nALT/vGkndJuKc8TnH/GFtlNlk8
         zINg==
X-Forwarded-Encrypted: i=1; AJvYcCWc3cPCJjSHmlplX/xhQO5NkH4qzfmVP9nikIU+w2NSrJx0JDFXS0CyOcL1qEIfd/zyKxKXL4CnVcbNqJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsRF6B/CGCVUdCA4x/he4uOf338m6W3qyPf5zVBMQ10L37WzUy
	qcF2l1sOERSkt/EHy3Cf470AByQrY7h6X1zf40Jlcm04BgnLWHXIWDw9lsFJ+4KyREwsW75VNKm
	T9MQeuqeKUacqn+ILYaOPEDbcMiiVc9Wo/pNDt9Sz+JC0CNphTUjoGus=
X-Google-Smtp-Source: AGHT+IHPxM5VqR17yfYZtkoLNdM1KRswj6aHXXxnQRZN3t+t6btAMLO8DI5mjA8Z9uiqpWQ1N5/8MJW0M2VPe7Kn6MuZQdEwxeZx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160d:b0:3a0:4e74:8af with SMTP id
 e9e14a558f8ab-3a0576b618dmr41919055ab.24.1725770222469; Sat, 07 Sep 2024
 21:37:02 -0700 (PDT)
Date: Sat, 07 Sep 2024 21:37:02 -0700
In-Reply-To: <tencent_6352E6C65F89856EFC6EC18C92E7CCC6FF06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013154b062194313f@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Tested-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com

Tested on:

commit:         d1f2d51b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1187ef29980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ad989f980000

Note: testing is done by a robot and is best-effort only.

