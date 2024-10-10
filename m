Return-Path: <linux-kernel+bounces-359120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B25C39987BB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC501C20F30
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E686D1C9ED1;
	Thu, 10 Oct 2024 13:30:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ADD1C3F15
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567008; cv=none; b=FI+zlkJZDGcynYlSBR4KhvS4Y4/jgZ7Tt5Nej/vH8B+PPEAnIC6SOputYky1DkFyrSW8B4tbFv5IwEKgA5/F7Nxye1dcD7RAV07NyCt4thPC6YBET7NUNq5Nm96qHh5TMsD2QKMosj2LZ7J08cGc+sYJGz9usRiRmbSVtPGHAbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567008; c=relaxed/simple;
	bh=Qlt/Xx7PCcs1PuYEt3egH89BWQRD/Vdpe/cxw5giFBA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Qy5S4vDoMbN1izPXcOZh/FAdhShn6y93tuAo7ZfErmWhSr9MLq8AeQ1ODKGYNlVAOdwmbc9oSfSkNJz1tChY7uzFRCv7myUdClVjqMslXGbBtDxNEY4YJo/UG+Zk5A9qVr3p17LBJI0/poCa5X3ixk7zGnhrx/VA/Mz8FG6fMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a34988d6b4so15160205ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728567006; x=1729171806;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtsMREmZd1O99qE4zqQtnxSJ2GhgJVVEV3UyDHBJ7sY=;
        b=KczU9q7pskLv+r0oCNiq+WeD221aHb/H3zsQQLQCdZ2OJF3CMSA8te9zg00EpqSYXx
         ohhCs2KGsEx3fbcNdzGMa0Q/yLzCoOm/OjgzpjKzCF7RxcE2C/a9uy81wSWTXnrJ3FlE
         4HR6T4VhoueWx5xbJrrQyAMWc4wdKog+wwgAtO1DNnKKeBD13/Go3QJDDzEsHuT2z5Ww
         nqYHKexaRqlkaouYDzeojsp6fc7E+QeFvzt7dUVyaFYq8f4S5pw/dHSYvWLuhWc80q/j
         TrE3ainwWhbErQBSd/4yaZB+p7YvHAGUT3M9yZuhRQr0+Ok+XeVddwtClC7eyOWk82Xg
         xx4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvZdYgiOxkZpENwjFC/nrG7ZOntjfBLkYUrk/wlaFmaYObmrAXDEXemnPrrPYsiArw/vd2/UuVt/rOYRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmnJ9vVMNtNV27AlJjIETm/bLHz0zxjmRqxqqo/MQyqd2lsXG4
	+sfV8+Gud/+L6Fapfltlo458AC0yOTgby+N6yDqsqO969Qe4fqdNXdLNJ8PP2SA//dUnQzvQbdv
	WcEQs6cRYfe/WxG3fBS0r2L/TuYtPyB9CS1JnyfJMPFWrExMsF6DBNK8=
X-Google-Smtp-Source: AGHT+IETi0kAfpFVPuGwwmUDrSF3+n80wIKKMndTmCs2xPyrKi7nWDVNl+Z1AmQSgDxdyqNgR9LI3u6l39d/R8CGiJCAjsVuZFVq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:3a0:98b2:8f3b with SMTP id
 e9e14a558f8ab-3a397cfa93cmr66014445ab.7.1728567006226; Thu, 10 Oct 2024
 06:30:06 -0700 (PDT)
Date: Thu, 10 Oct 2024 06:30:06 -0700
In-Reply-To: <45071abc-d5fd-4c24-9e36-e8164eca3867@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707d6de.050a0220.8109b.000b.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: cmeiohas@nvidia.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/infiniband/core/device.c
patch: **** malformed patch at line 6: diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c




Tested on:

commit:         615b9474 RDMA/hns: Disassociate mmap pages for all uct..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b86fd0580000


