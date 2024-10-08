Return-Path: <linux-kernel+bounces-354353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D523C993C6E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF6928143A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B461DA5F;
	Tue,  8 Oct 2024 01:44:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD91171D2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 01:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728351845; cv=none; b=n3mT8kENWnM+hAAFGKK3x1Er/sWnErUPyK6qazWcHKQDAGMTP7+p82A6zxoK6U5K87geqSWcpdlv27utC91Jsji2xYIHQCKTbyFylGpCCPdCY+vBVMmEHTX5M+fN0qMsKxQ14IMYnxWi5N8cGHvI4ol7CKj4b9x2Mpaie888KCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728351845; c=relaxed/simple;
	bh=zEiGXPNNi+qV0aR54ss4qOfQqs8mEO+IEjrR6uv8Tx8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O/bM8Z2Jbb2nu2IDcbk7gqESbLfwiuagBelBUsbTZRsGw9c3Oreb5JmLhx2HCWrl+TpmVXujMxdohLyPb5tWuPiQhr45XEI+3F7fVUzCwqIf7TDRi20rtgQ19kqQmpbgyKbqoebUA4KAKP8BQ4CCV6+uKGA9eUoacQxd4EEaszE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3466d220dso53098815ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 18:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728351842; x=1728956642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1J06SoFiK32YSSK7pd1LagUMG6E/yMnS5Pg/4wxUAM=;
        b=SsQ8c+OJe24FvnAZhR57cURHYIVW/PlR2axd1OytWXbSlRfVCAPWGJUna6wQorA9hl
         Aex71QtDXHjwVwhS4AoQT4LOWjlq9YJb6Vh1qwqg21SeSOpKOb+LM1+CILTgb8qaZRm5
         ngHNzEnIyfu1ZcyPCWaUbuqdo7vmRMnZZvXMgsqjVxrJbQ2d+GdMhP3QYYwl+FWLOQ7t
         efYcrUW8WiMMulqWE5mMIeInoJ89Muyd9c5urXCdL2AQVJNSeHq/2O42adxjClPaMMEp
         60ckiK1peGm6xEvvpbHPS2qv9VnoMK5TrEYYI1qbNAtYk2mQ9pQ3GcKjdzKGmGtrmQMe
         vT0A==
X-Forwarded-Encrypted: i=1; AJvYcCVLcj5cKLQznVnqN5lZTnPEx4CpNahvnvIYZy4HzlnkJ2rc86k9DBLByF3tde6oICRskwMnHkkudIEoNAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHL/xuw6w3V+K4SeOcopX+luJcAZu4R9NM908KD9JFxNlgYwfP
	bRBuFDF8AOT1x2VvX35k3nahXOoHjGk7zwEh6zY9Owr0wMsnH9yIdC4mvTmnvB0I8CSj8GJP5Q6
	VfMT2z6n/gDFCsr0VG/TV0kyqqIoXLIiDZK3paDq5v9BSh5rAVHY3UxA=
X-Google-Smtp-Source: AGHT+IEtrMwclXwLk1T+D4m61HcZKuVnKmJ+oYAzW76+X+uCSIGFo56jfuhfh3UacTn3YPpAjTVxw5WCYw2XQx4rootXFgdHencz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1541:b0:3a2:f7b1:2f89 with SMTP id
 e9e14a558f8ab-3a375bb2c30mr134150875ab.18.1728351842553; Mon, 07 Oct 2024
 18:44:02 -0700 (PDT)
Date: Mon, 07 Oct 2024 18:44:02 -0700
In-Reply-To: <000000000000657ecd0614456af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67048e62.050a0220.49194.051e.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: ahmed.zaki@intel.com, andrew@lunn.ch, boqun.feng@gmail.com, 
	cmeiohas@nvidia.com, davem@davemloft.net, dkirjanov@suse.de, 
	ecree.xilinx@gmail.com, edumazet@google.com, hdanton@sina.com, jgg@ziepe.ca, 
	kalesh-anakkur.purayil@broadcom.com, kirjanov@gmail.com, kuba@kernel.org, 
	leon@kernel.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	michaelgur@nvidia.com, msanalla@nvidia.com, naveenm@marvell.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, penguin-kernel@i-love.sakura.ne.jp, 
	przemyslaw.kitszel@intel.com, rkannoth@marvell.com, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5f8ca04fdd3c66a322ea318b5f1cb684dd56e5b2
Author: Chiara Meiohas <cmeiohas@nvidia.com>
Date:   Mon Sep 9 17:30:22 2024 +0000

    RDMA/device: Remove optimization in ib_device_get_netdev()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16db2327980000
start commit:   c4a14f6d9d17 ipv4: ip_gre: Fix drops of small packets in i..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15db2327980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11db2327980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11eca3d0580000

Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Fixes: 5f8ca04fdd3c ("RDMA/device: Remove optimization in ib_device_get_netdev()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

