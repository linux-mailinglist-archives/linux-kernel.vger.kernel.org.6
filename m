Return-Path: <linux-kernel+bounces-373161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B16EE9A5327
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 10:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B26A2832C8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 08:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC4C745F4;
	Sun, 20 Oct 2024 08:33:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F4C29CF4
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729413186; cv=none; b=h133a15CHs37xZXVUo6Acr6Rj9obK7go1yNuZwNty55QYNCbfs7+Podj/yTNuNF96bQjMQ3UVr+Zj/etf8Yr/v7nOh5ePSfIncm9KCRJYsdLZEsIvAJyZJQiSYacRFler4YnwTTWIGjo57Fjyyk5fSHfVSXQEQPeBiI+4H98QGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729413186; c=relaxed/simple;
	bh=T2p5HbN20bIhW6uDXYznp/AOie/8oGLXHMtgZspAlGc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u45Z6t84izu2GJ6olGZcZb52RtNWCP6DzTc6Hj5OaZRPcn8WhCBSHMGkI3ucnRtRCbqJRqXKSpGrQVn+tiQeYDgd04JrAcsvKgz0DOHSQdM/npsfG+XOl0ZeSlbzAElNW/dL0cbpeyHHXkM3f3i4NaXoi6KsSlVwrCBuJy8elCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3b4395dedso32087825ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 01:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729413183; x=1730017983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVrP/thCqYtSWY92L3Wkb2xNaQ/CtB2RHmoU142L8C8=;
        b=hNCfEHaI1azyIVsokpzNzvXhLMgRtM0gP4lc1lriRQa+vNtvsIBIT+PnUyYFu4ws7c
         eTDV0h+ul8UoaZlyjRNAneEenNmPcX4LBhiNJ7zaGh06rFTbYhABNge3XxGiWaUG9/6C
         Dyki/TliWf9WfIgorGswAGCqviBcbDtxB6F0tjmU7GDBLQN/ly41yt8ijta3POngG8sY
         rPceNTWuEQlIyXIlhRUw/0zm0OG6r1TZC663m/+wdyAUpGohkqdpTYjazNgYgX80RnBu
         b6/11hKQyEGRBibUk7UloEv1lw0PGRxFy/DCLsWWlQLRFJ+qG9FwMMXFvpThfxLKU3II
         UH0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUv7LVMTFLiWZMqEXSb7MEcjcH4FWi+7Tha+zvvo5eXZAOa4WCk3KI6uj+R8hzU7GC+TayQlgwniyDfEzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWrrrVKmWn7rTJ4I7dgNfWVQBiYEijbrSy25/a4e2yMTUA699J
	PDcONSt6gTvwGc1he6+q+QfZnjs13RKqsq5BZkL2bq6+8eK1cVd+IBZeaKdxMpg1sOggJR/xCOH
	9JfyqXrpTd7kwGwM2yA9E4YcThqVPfIvCVDakmg7m7JUZsn+cJbm5Xls=
X-Google-Smtp-Source: AGHT+IGMTNfuD+Ygo6qjR6eqphuUVC+BjinKpwiT/JNG9BhWu60f/NmTg+aTzK5DMOZaaFH4pNaauYSHasWYMg23YCd0mwLvMZck
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1906:b0:3a2:91f:497b with SMTP id
 e9e14a558f8ab-3a3f4073d2cmr72653855ab.13.1729413183272; Sun, 20 Oct 2024
 01:33:03 -0700 (PDT)
Date: Sun, 20 Oct 2024 01:33:03 -0700
In-Reply-To: <605a7a92-5e06-42b6-a44c-6529cfa86d47@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6714c03f.050a0220.1e4b4d.003a.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: cmeiohas@nvidia.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Tested-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com

Tested on:

commit:         89e9ae55 IB/hfi1: make clear_all_interrupts static
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=128c7240580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177520a7980000

Note: testing is done by a robot and is best-effort only.

