Return-Path: <linux-kernel+bounces-310816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D172968190
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFC57B2078D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E980A185B5E;
	Mon,  2 Sep 2024 08:21:28 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C46417C22E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265288; cv=none; b=CVN7kpqziDRECAIj5DZerT1r3kPLk1HK+tzn9i0qI7FJvZdCAM5HLe/5VUW/660rUH/FWYF/oHx76FnBgHvIM/LIUHmrL7WMvGXHpTKmpGuxwV1DsUp5FVoaAdTHNQjIZaKyxGSNIcI8VMpWXCBrZPYc8JmIVljqVoReSZwwA5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265288; c=relaxed/simple;
	bh=NMMlde7s9PwCNTKDfZbOUe5h5N21PYF6CwCBS4h2CFw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MdZaRLae/9jCPSKKsFbyQR+xwwEcTw87I9Z4cwmb6oB85iyYf5qJsNPl7vUtLFT/QYzpTumT2REJd9KEK3+k431rmTwR/jKL7YU6AqN8rJzu9OlKedoXpcyhS9Nfx1xHNzFn7YzHOTuwc7eQOkVc0dhIOwBRpbhNb9e9G+VUdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d293e492aso45518295ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725265286; x=1725870086;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NfMYOuKiBKRKr40dWaBX3b1yVoB+uTs+MRWyV32FoA0=;
        b=eOGz0MHb006TkdMqP2lmBZBatRvJGrcY9nKBuNx4WCNsA8MjcI+OPVzYwqD+fDNHZy
         NighH9U3BWEgf8Q2boq98Mfr6014327GFK3X0JJQV6M4D4h/X4wYu17FwqKDQG74ncyG
         X+T2YQBCzy0vbMZqhP0GUymnCpI5mIkC9gdVYFF5eh3kSVaf5p+f/PMPHTnJuoQwhN4X
         FJxtN23KvkBEbo4vYvA6SccAM+Dn73Ta1qx7FhkauMMnYDy9w+gPNdIYOuNNEV6mkHLz
         xELwl2a++yCqfOu2N5RYe1CICoFyQl/VDS0OMDVBfsCt5FaKxLSfQJPJvHRpLxa5Q//P
         yQAw==
X-Gm-Message-State: AOJu0Yz9VAcEGfgsXbGkN76M9y63caNnvKsYHoxPPIwiAit0OixZVH4b
	TuKzkMbq+gg6bTCSk98dMs1qFQQllcWFZIaA0Co2lTuCe+qOD0urSOMh7lEPW0qYJ0YdTzYWi/R
	cGq8YrM6/Aex6v8hbTZrEAKlcpVJTzJsQGUAj7YwXU9qvQbCr72xdNOk=
X-Google-Smtp-Source: AGHT+IFjH8dluNcXlmvRcye8cEfH8t+nh46Jz1ZkP0KhsK76g933W3dHlgrHD1v9G6Ig2DOkgB6LQuLwhfec79WQIKWbdZ9JOpsx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a81:b0:39f:584a:e91d with SMTP id
 e9e14a558f8ab-39f584af541mr1801455ab.0.1725265286241; Mon, 02 Sep 2024
 01:21:26 -0700 (PDT)
Date: Mon, 02 Sep 2024 01:21:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087b10006211ea039@google.com>
Subject: [syzbot] Monthly net report (Sep 2024)
From: syzbot <syzbot+listc3fdd16cf49de206b6b1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 13 new issues were detected and 7 were fixed.
In total, 115 issues are still open and 1504 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  144422  Yes   possible deadlock in team_del_slave (3)
                   https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
<2>  17747   Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<3>  5321    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<4>  2312    Yes   possible deadlock in smc_switch_to_fallback (2)
                   https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
<5>  1659    Yes   WARNING in inet_sock_destruct (4)
                   https://syzkaller.appspot.com/bug?extid=de6565462ab540f50e47
<6>  1530    Yes   WARNING in rcu_check_gp_start_stall
                   https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
<7>  1266    Yes   WARNING: suspicious RCU usage in dev_deactivate_queue
                   https://syzkaller.appspot.com/bug?extid=ca9ad1d31885c81155b6
<8>  910     Yes   possible deadlock in team_port_change_check (2)
                   https://syzkaller.appspot.com/bug?extid=3c47b5843403a45aef57
<9>  830     Yes   possible deadlock in do_ip_setsockopt (4)
                   https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
<10> 681     Yes   KMSAN: uninit-value in bpf_prog_run_generic_xdp
                   https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

