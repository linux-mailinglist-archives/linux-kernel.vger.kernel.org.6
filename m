Return-Path: <linux-kernel+bounces-281892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2630E94DCAA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 14:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AB81C20FA3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 12:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C889B158552;
	Sat, 10 Aug 2024 12:07:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B9414F130
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723291625; cv=none; b=QyXVOLLwYGMADNULBcik7/V3JokQfgIwB2p0OJuadWnkWNY0Ik6jxVO74m3fEn52e2jeeVumY1Hp1yWOHTc+5EXHWztIOf8g0Ywna9RaXiZPqycyjaLT1LZGP0Jggj0xwt517j8/XN6vmiN1GE6u+NcQd+NEmzwQFSCjbQpL5+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723291625; c=relaxed/simple;
	bh=JMi4VqlR6VLRsS45yK6xehSfzEWKZlPxzkPo4WsyD6E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=daCJXJ1SFmBSLLhGCjl88p+b8s02VqW9KCw6qN8061pfxH7pIx9dXCO1wOCum9uhFqgJfFiPgCt4qVvV5qklh0CcN+qTrOvcOJarYHid0pCrls4n/gOxCaKrVbD79KyLwY3pzmfYpW737n1t++1p9z7vRsqWisuCMPvPzQRYAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b2938b171so35518945ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 05:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723291623; x=1723896423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=brS7xkekpvIr1jOYZCd0Wlyr5RS+/5cL13gt+qEWR4I=;
        b=LC9ql0jCYH/iQ3/Q5IWC//pYVbVf6Kb+n9z9h4QhM7P+2GABhPKWQuNBRJck7N4asn
         VaaLhT7/AM0qRF4ZdgrWXycz6u+Ssq4pvpg5aWHRHGaND/nQ+r8/ScveLk2JtpAUwbC4
         LMOlgMY1StXEsyocK0Xgqt2b0IDxQSjhqwvXz6t5mvmvRsGWVisP0ewUjQjDx1Mvk+H6
         vNcOEBgZxJy/zCazWyJc9n3HBjYHv//n8eW5tX3K9kdvmR9IBnVwPSJPuto/10GWnRcu
         R82oTKGR6Vn5dZP/Edy1ofseHpoWMSToCd0Qt3frPnsdFaBal26xE0iW/YYYsBZZDPbK
         W+iA==
X-Forwarded-Encrypted: i=1; AJvYcCU0BgUCWbD4eJOTAl1no/yJcbs010B75d/bssBoMGbpYvg0CZvgeHVtR8A8+7zP+1ZKJ+n3HLSKgdr5HWTS0jBsvkJ3+6U676RjE/LV
X-Gm-Message-State: AOJu0YymZtH4jzR+y+29Ido9ibQmXhAJEI/L2zDNdeBiHwHYu7tEbzzl
	HmxvOQsdO+j10+v+ewbnzT/WaQoTgCI7VNg2JEDeQ/ve5+vBQ2YAM7LU5U2OzG+QxC+nSWaZdHJ
	esPJCqWRlI8Mk5anGa9aXGZNbOC/++7RixE/uoDxLfTyrNiIlXstB/eM=
X-Google-Smtp-Source: AGHT+IFy+VeqXqzz/19A1XE5ksRo66lpGRBRIcR5gsemJWKDHHV8VcCm7/3BuhZRoKjTALyu3JVCmRt4uDYiNtIkUWqL8gt9FFWm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9a:b0:382:feb2:2117 with SMTP id
 e9e14a558f8ab-39b8134a48amr3691455ab.6.1723291623131; Sat, 10 Aug 2024
 05:07:03 -0700 (PDT)
Date: Sat, 10 Aug 2024 05:07:03 -0700
In-Reply-To: <0000000000005f5a6d061f43aabe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a9b85061f5319be@google.com>
Subject: Re: [syzbot] [net?] [virt?] BUG: stack guard page was hit in vsock_bpf_recvmsg
From: syzbot <syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com>
To: bobby.eshleman@bytedance.com, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux-foundation.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 634f1a7110b439c65fd8a809171c1d2d28bcea6f
Author: Bobby Eshleman <bobby.eshleman@bytedance.com>
Date:   Mon Mar 27 19:11:51 2023 +0000

    vsock: support sockmap

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d3c97d980000
start commit:   eb3ab13d997a net: ti: icssg_prueth: populate netdev of_node
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1033c97d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17d3c97d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=bdb4bd87b5e22058e2a4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a1b97d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e7b2f3980000

Reported-by: syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com
Fixes: 634f1a7110b4 ("vsock: support sockmap")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

