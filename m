Return-Path: <linux-kernel+bounces-512562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5556FA33AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392403AB3AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A839E20D4FC;
	Thu, 13 Feb 2025 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F2euJgpp"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A232116E9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437789; cv=none; b=lR0WHjuhjJtMyijrb/Of1CQDL/QHt0J3XSeuBuXLdcj9s5OnoYM9YdTB1hkcQfxHq7DdtSN8CFFEb47phitXTkmlVdPr1EDP9qa17l6eEOpg0vY/vimATW21tppxPcgrI4Yd6jB9z5clEZGdkIi6OPyb3NaDaCjUHnlKlR3k39U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437789; c=relaxed/simple;
	bh=yIofNp3DOnt44hzmtEVn7QWYrlSOhhx9bqOniqpFPVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=tmJrZynZhMczIbKkbi8DWqJooFMiHzUVAAM7cx2fHIw9cg4fs8KAjFZSR3eifrJ99xMKm7OYf+wR5sLjG2LftD68YBSpRneyQ3bTAnIqADNiAW3Qh0atuvlGaPkMiaYABvNQoxEdCyXtzTpY32EULR2rpXqkKHUe1ifihfdATo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F2euJgpp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7d451f7c4so96260766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739437785; x=1740042585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xs0dMv8Lg47llTTsTqc4aG+TvIPsuFrqAsJa4mSZy7s=;
        b=F2euJgpp4YTqZUodflHiB4s/i48Vmhmi2JlmW9jAOX30OqqD6CsjV0DMBbnUVwHnkk
         qnNp+7G8HPy8m32zM/bEnL2lc4WyWI6VvTMQPq9YQh04F/MqhK4PW5O/BNb4EMbjzpTc
         moyJJZntr9VQ4Cfl9cDDXQzIzg7yZSCgzeGus74Ivq0j3gZ4Fpd1T4T+++QwtJ6ox+yU
         qZjEEI6w+mfzK/qI4Mw+k9KVATGi761jCQmogCdJAb+ZUMvaxOQda4HM7vdS4DvtXawu
         V/d5vj9NrJdvj9IwPMDQQErFPUR4DpSTEZhaS2eSpTjBmBkFAK7+KOjUHxTN6lBwdFyd
         m6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437785; x=1740042585;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xs0dMv8Lg47llTTsTqc4aG+TvIPsuFrqAsJa4mSZy7s=;
        b=m9infchjemeEZb1IYnaOJCLzBscIdakbOrEfwtHKQBLrCcm/Gu52LPsfhZf3zMj7yR
         FFyy5tPsKiuJfUM/NB/2bjWzG+94gndgy351K34m3iDwDeWyS6lm8b+xQLkqRZmK2Z0C
         SivnSQPpujWkFuV5T+CHWrI1MWKLkYDrS5CUZYeNVq09FWVO+vyxu2BX+KpwjKm9IV4V
         FeTO4TBJwY2bz+3T7PnR+X/oY5g9sUK8Wwar2Wmq5j+zV5wnAMjbi83fqejukYbSh8EN
         TNusmSE14Yyqh6w2eLoXelD3NpOIOR6uNg3+JtqjdriOCmI1dCcRlFQgiY9Naa5adxxC
         axtA==
X-Forwarded-Encrypted: i=1; AJvYcCXCg4jzEQ179+D7pwUU4PSWNMae7ZmcBUuwGw5Fn3lBMS/DCJbHN3TgH7c/OeA2NSRQSE5XhGyPn8MZw/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ6+DDenVP9Vh1fvCz7TDwXKqL6ELossvlO6ol+0gkJx2u2YMp
	bgHRo2MNj2uzXUDt6R2xtiO6zxe5/2zHSFTru3XYoHtJOibj+dilRC8VSvirC3EnCnZxY/+bssc
	B
X-Gm-Gg: ASbGncvAnQe3fuTP1Gag0kuDxhP0tiHz0SH/O+GfQFNF54G0zC2ENLcbvrCBRcsB4r7
	I78w5TsxdPCy89BidiBnztTOsk0UJtbI6ewXPq4VeeZy/L5CMePXKV6LUl8PKmaiQ7L99A5m3U3
	IS19YnNRHYgaSe6hyfqKyWaERoICc6f0IqC2CYGHcNG1+75dBTzDH8D+kdjoIdmN4uPIxNNk9qp
	Q8Ue0Vze48emCTFdCn25/Z0nGBk+1vJpn0lik6UT2wSScIDIYQ2FIIEMcbQg+qKtVm+Bp7ikBSB
	FiSKnzfRkH+sHRM1aFA=
X-Google-Smtp-Source: AGHT+IFfQRdWjBtuKVsNwvUqDft33DU0Ymv+Yih3Ck/9OfZla4U74TcMTKYM4uEfh0wH5+ykvybEyA==
X-Received: by 2002:a17:907:6d29:b0:ab7:e91c:77e5 with SMTP id a640c23a62f3a-ab7f334447emr670362566b.11.1739437785520;
        Thu, 13 Feb 2025 01:09:45 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5339d96dsm89457866b.153.2025.02.13.01.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 01:09:45 -0800 (PST)
Message-ID: <ba4e7509-cab5-4987-ba2e-4a00eebcc348@suse.com>
Date: Thu, 13 Feb 2025 10:09:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [modules?] KMSAN: uninit-value in __request_module (6)
To: da.gomez@samsung.com, linux-modules@vger.kernel.org, mcgrof@kernel.org,
 samitolvanen@google.com
References: <67aca50a.050a0220.110943.004e.GAE@google.com>
Content-Language: en-US
Cc: syzbot <syzbot+1fcd957a82e3a1baa94d@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <67aca50a.050a0220.110943.004e.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 14:41, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    febbc555cf0f Merge tag 'nfsd-6.14-1' of git://git.kernel.o..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=137a78e4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=48f90cac5eea091a
> dashboard link: https://syzkaller.appspot.com/bug?extid=1fcd957a82e3a1baa94d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177a78e4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16adc3f8580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f90f94285615/disk-febbc555.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b8a8bb66806c/vmlinux-febbc555.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c8af6c511559/bzImage-febbc555.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1fcd957a82e3a1baa94d@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:633 [inline]
> BUG: KMSAN: uninit-value in string+0x3ec/0x5f0 lib/vsprintf.c:714
>  string_nocheck lib/vsprintf.c:633 [inline]
>  string+0x3ec/0x5f0 lib/vsprintf.c:714
>  vsnprintf+0xa5d/0x1960 lib/vsprintf.c:2843
>  __request_module+0x252/0x9f0 kernel/module/kmod.c:149
>  team_mode_get drivers/net/team/team_core.c:480 [inline]
>  team_change_mode drivers/net/team/team_core.c:607 [inline]
>  team_mode_option_set+0x437/0x970 drivers/net/team/team_core.c:1401
>  team_option_set drivers/net/team/team_core.c:375 [inline]
>  team_nl_options_set_doit+0x1339/0x1f90 drivers/net/team/team_core.c:2661
>  genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
>  genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>  genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
>  netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2543
>  genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
>  netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
>  netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1348
>  netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1892
>  sock_sendmsg_nosec net/socket.c:718 [inline]
>  __sock_sendmsg+0x30f/0x380 net/socket.c:733
>  ____sys_sendmsg+0x877/0xb60 net/socket.c:2573
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2627
>  __sys_sendmsg net/socket.c:2659 [inline]
>  __do_sys_sendmsg net/socket.c:2664 [inline]
>  __se_sys_sendmsg net/socket.c:2662 [inline]
>  __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2662
>  x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:4121 [inline]
>  slab_alloc_node mm/slub.c:4164 [inline]
>  kmem_cache_alloc_node_noprof+0x907/0xe00 mm/slub.c:4216
>  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
>  __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
>  alloc_skb include/linux/skbuff.h:1331 [inline]
>  netlink_alloc_large_skb+0x1b4/0x280 net/netlink/af_netlink.c:1196
>  netlink_sendmsg+0xa96/0x11e0 net/netlink/af_netlink.c:1867
>  sock_sendmsg_nosec net/socket.c:718 [inline]
>  __sock_sendmsg+0x30f/0x380 net/socket.c:733
>  ____sys_sendmsg+0x877/0xb60 net/socket.c:2573
>  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2627
>  __sys_sendmsg net/socket.c:2659 [inline]
>  __do_sys_sendmsg net/socket.c:2664 [inline]
>  __se_sys_sendmsg net/socket.c:2662 [inline]
>  __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2662
>  x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> CPU: 0 UID: 0 PID: 5814 Comm: syz-executor989 Not tainted 6.14.0-rc2-syzkaller-00034-gfebbc555cf0f #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
> =====================================================

For the record in linux-modules, Eric Dumazet posted a fix for this
issue at:
https://lore.kernel.org/netdev/20250212134928.1541609-1-edumazet@google.com/

-- Petr

