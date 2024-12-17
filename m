Return-Path: <linux-kernel+bounces-449061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5A69F4934
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A79916C1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D191E260A;
	Tue, 17 Dec 2024 10:48:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EC11DE4E0
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432486; cv=none; b=ACzw2Wrsjvh2Fgu4QixWeMBl8vXRuB9TQltskaVMvERnWvlnfFJt3SMpULoo/IeZrByxvuckK1go8j0HZOeFxrOYZcV75FdHDuMAwvLjevQpHYgxs4UN76jL+E0Ae8Ha80VrSKIT/CEDt9KDxmQ0IHGdHV7MTEtvpwMuYF3+FkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432486; c=relaxed/simple;
	bh=dnVJ5bjsIiyoFarcMSfXkq1h0ZVI8No88ktlC58fagQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RjbiCsBLqrL+axFYe+O2NOaVlAiR71nsDw5qQ7eJovCraJG8fL/UwVvjjZEoqpw9+n5djKDnXZA61c5now0KHFVDAfVQgzQtvIl5HURPySbK8BuipR77FlJBXYRLm+mQEr95ERoYZIK/vwa8HKOK0t1awtrnNTY8ume4SLdQqjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a81357cdc7so60803305ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734432484; x=1735037284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSKLWVdIklW4E/y+Drls4xRb+G0etWH5x+OHW1mBX8M=;
        b=b2i4ZLXcQVMM45V/0b7CrzhmHxuX++r2O4KNx+gX2k5VafkioHle+4QqyXIm8DSZ2P
         RcRKamI1CQZ+IdshgILa2CmQEL0Y4n/3eWMaMzn97zI7TWn5aN4A5iP+ILnw/0czXIuE
         g1F0W0z2f2yJgvpPM5s4oaQM6775vwoC1ShEnFmPg18eGmwWuWzI9/RlimitNC/MN6nc
         f+gvpjf9msHnSPr7oWXt2kSA3MIJQhoX54hRYObkIUT2hgytcGlxSuYFj4D+QftIRTrK
         k0+RXYdsaBqaM3x58s3LTzbSRogh+580wFpC9rwAC1K8Ysr1igorXROHS3Ihiz7g/+8B
         Nz2w==
X-Forwarded-Encrypted: i=1; AJvYcCXl+G2OwjZMWbjm3Riju1W5gKmlA/ELACQl1BA+jHFXgGTuoAWWo1m0PiAH6McthHvDaSQvkKzzSLQdZEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEMfyI/n1wN/Fzeb7isiWHiUush1me7Uz1YGXlvj9VIcPPT0XM
	CQgFMHfBmRaCic6DhJL8YbSB213OZzmHqHBmvp693hrdVqZSVLQgDto0M4xkUbM65z0xVGEW6Iz
	GKdOiDGILwX+JOrWdN9oWGuWPpzSKROS+NgLLGI4HgLt4DSpPQiWp2UE=
X-Google-Smtp-Source: AGHT+IEfAbxixMcB0YO39q51tz8GSAkZ3y8rL4GlBb786/vjekqHf9NdcjQSzBin3Tf2S1CTituiW515U+L4H5NfUYlktl18D3WY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f88:b0:3a7:e786:afb4 with SMTP id
 e9e14a558f8ab-3bb079e4360mr26405805ab.2.1734432484347; Tue, 17 Dec 2024
 02:48:04 -0800 (PST)
Date: Tue, 17 Dec 2024 02:48:04 -0800
In-Reply-To: <20241217103105.151-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676156e4.050a0220.37aaf.0165.GAE@google.com>
Subject: Re: [syzbot] [mm?] general protection fault in find_lock_task_mm
From: syzbot <syzbot+c2e074db555379260750@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: shift-out-of-bounds in ip_finish_output2

------------[ cut here ]------------
UBSAN: shift-out-of-bounds in ./include/net/neighbour.h:306:44
shift exponent 32 is too large for 32-bit type 'unsigned int'
CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.13.0-rc3-syzkaller-gf44d154d6e3d-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Workqueue: wg-kex-wg0 wg_packet_handshake_send_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x2a5/0x480 lib/ubsan.c:468
 ___neigh_lookup_noref include/net/neighbour.h:306 [inline]
 __ipv4_neigh_lookup_noref include/net/arp.h:27 [inline]
 ip_neigh_gw4 include/net/route.h:383 [inline]
 ip_neigh_for_gw include/net/route.h:403 [inline]
 ip_finish_output2.cold+0x56/0x5b net/ipv4/ip_output.c:230
 __ip_finish_output net/ipv4/ip_output.c:314 [inline]
 __ip_finish_output+0x49e/0x950 net/ipv4/ip_output.c:296
 ip_finish_output+0x35/0x380 net/ipv4/ip_output.c:324
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip_output+0x13b/0x2a0 net/ipv4/ip_output.c:434
 dst_output include/net/dst.h:450 [inline]
 ip_local_out+0x33e/0x4a0 net/ipv4/ip_output.c:130
 iptunnel_xmit+0x5d9/0xa00 net/ipv4/ip_tunnel_core.c:82
 send4+0x48e/0xe30 drivers/net/wireguard/socket.c:85
 wg_socket_send_skb_to_peer+0x196/0x220 drivers/net/wireguard/socket.c:175
 wg_socket_send_buffer_to_peer+0x148/0x1a0 drivers/net/wireguard/socket.c:200
 wg_packet_send_handshake_initiation+0x227/0x360 drivers/net/wireguard/send.c:40
 wg_packet_handshake_send_worker+0x1c/0x30 drivers/net/wireguard/send.c:51
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
---[ end trace ]---


Tested on:

commit:         f44d154d Merge tag 'soc-fixes-6.13' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c9560f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c22efbd20f8da769
dashboard link: https://syzkaller.appspot.com/bug?extid=c2e074db555379260750
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=175f27e8580000


