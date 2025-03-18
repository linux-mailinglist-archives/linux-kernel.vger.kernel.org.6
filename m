Return-Path: <linux-kernel+bounces-566679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECC0A67B23
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348F119C6229
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C5E211A19;
	Tue, 18 Mar 2025 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4JQja96"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8241B3957
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319596; cv=none; b=GqpXJ6rf85I+41g8FL1BqapV/tDlv71jVL6Y2ceJQvYCKc4WZ6I4eBotVYrAh5I/ofjvx6uc97iIsf4vy8yzL+5iplp66qz3UmMXeHi4ZQ0FQ3+RlWHZnWbYYV89gKL8yudiOz6BNyUrBfYqG2KqtdB35oz/sIrQ/75zUiScqHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319596; c=relaxed/simple;
	bh=LFU/NttlSNCPPnWnlFR2zQJpTCiWKXsFEck46ERKMIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SEbQn/JtkFu9BkoRdO8f1TS4g+GM9ItJlGO16IUWMsOjXrPhHGVdvw11Spx4ZIZKyjtZAZfD1zt5NmpMQ5UNn0YzlfAjtXw6jeA0ViZs71gB6HHBzIbnDymocId0XnI2ekUqcLW4axp+cXQpVNed9Eahj435KCq7zqqWDnWY8iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4JQja96; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742319593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3cY/S3V1OiJeeTHfh/+qu+B682kGW/beC29yAeSAm8o=;
	b=E4JQja96CIbWm6sUU4UFI2yz3kvgFSsB3vGz5UnYN8iPEDg1N5lxlmp4HnP4V0d6UmiQox
	ZfG3jVjLWrfyreV9ypZFsK3TF1W1LkNH3I1RHOhe7wtEMwoGo5NBAh4j7InyF5+IsDjD/T
	OfeRyOrBBHu0+Mbpxg8NL26A1DS3cno=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-cHBgf2idOOaOdaGMzZn7Tg-1; Tue, 18 Mar 2025 13:39:51 -0400
X-MC-Unique: cHBgf2idOOaOdaGMzZn7Tg-1
X-Mimecast-MFC-AGG-ID: cHBgf2idOOaOdaGMzZn7Tg_1742319591
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-391425471d6so2444058f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742319590; x=1742924390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3cY/S3V1OiJeeTHfh/+qu+B682kGW/beC29yAeSAm8o=;
        b=lDEq0oh3LkyAP00/QlFSe7F1VlCarX72ABJ5uxUgB9RWE8qZbkbf5EfezB43ZYJ78r
         oIjsNjhFb2bsIAAl4yZcVOuQ5rTFKG30Ew7giFHLhp8l5XOnNO4ligxqrHL0lQj2IHZP
         IliIHoyRgPgIZPJWB2v1MJ9T+BLDUvQs6RYrYmY3EMyO27L8tCPra2pC1cAvOeIyZfjd
         miat/G4FQda24WzZMcNfaLj8Sfb9Xj7Ke1DbU0SP/LSC7RSprMODaOrGHFyrv0kVKVSg
         wu2WmcpmIZR2fEDyBFA/VCeQro1EcGV1W11+LotGATpD2/pf2PYdpdkF+h+GYb0/C9Ad
         qjhA==
X-Forwarded-Encrypted: i=1; AJvYcCUJYW6nhW9+QPr8wZRGZPSQLK9yDRugal5d30kVyc8e8fb7fQD9kV/Qlf/T8AE+6cSHYlNiSJwZUqQxTqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqFLS8bJZi/CJkUGcj2QMOXOZLB4QA9/LpsRlQwG5iVYq085aG
	5U70+nHduXEJNYhNQYHTK1Utf74AvqmDpqjb/shWjzpCcqD0XjPoE3qMQ6/NbSDFH4p0MlHCIry
	CuBMRO+d69VvWB1XLbCQfpMnWyz6Xu+oDzmXYOA3pD3Gu+gc97vK9sUJgjHSYpg==
X-Gm-Gg: ASbGncujG+YLn6YaDpiWGymfqAJSIuprPp7/I0r9hPhvGD4/EtIJQIu4J7osJCt906B
	Q7He9vAJHJvPYHbWJpc+zdqEXbTMsUgKFX/VUYwztbe5ElPiu8ffEmvDgN40ttTr4DDU2lQ+YtS
	NZKAmoGF4fBhgI8f/nd4FWTxnaqBnF4oVCG9vozllAiAJLfhRxVmtHcsBlMvxk+dDyZ9zU4Y4Cz
	IO6w5gHTl8yIS8GRHDnCf66kCLB6codDs0aGbbkbqg2bxE1cP4uzD9fKgU+PCF39oei0vjErBQ+
	jRvqHv0QtPEr4enSrhYj3fDLrS/lN+rjKLg5t8KsGemsIw==
X-Received: by 2002:a5d:588e:0:b0:391:49f6:dad4 with SMTP id ffacd0b85a97d-397209627bfmr20789990f8f.41.1742319590527;
        Tue, 18 Mar 2025 10:39:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyc6CZRpuuK+7eLs9KSdExXn0k5d7MalGV8+LtDdTRH71m5JxeFr1Sd/jbDnhdqlKns+4Ttw==
X-Received: by 2002:a5d:588e:0:b0:391:49f6:dad4 with SMTP id ffacd0b85a97d-397209627bfmr20789967f8f.41.1742319590118;
        Tue, 18 Mar 2025 10:39:50 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df35bdsm18253185f8f.5.2025.03.18.10.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 10:39:49 -0700 (PDT)
Message-ID: <f2d7e0d6-8dc1-4c1d-bf1a-ea9db7ec554b@redhat.com>
Date: Tue, 18 Mar 2025 18:39:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] WARNING in udp_tunnel_update_gro_rcv
To: syzbot <syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com>,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <67d99951.050a0220.3d01d1.013e.GAE@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67d99951.050a0220.3d01d1.013e.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 5:03 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    aedfbe251e1c Merge branch 'udp_tunnel-gro-optimizations'
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=177f45e4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=aeeec842a6bdc8b9
> dashboard link: https://syzkaller.appspot.com/bug?extid=8c469a2260132cd095c1
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/18e6408e4123/disk-aedfbe25.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1cdafe4afee8/vmlinux-aedfbe25.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/eda00f4a96d9/bzImage-aedfbe25.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 24136 at net/ipv4/udp_offload.c:118 udp_tunnel_update_gro_rcv+0x31d/0x670 net/ipv4/udp_offload.c:118
> Modules linked in:
> CPU: 1 UID: 0 PID: 24136 Comm: syz.0.4789 Not tainted 6.14.0-rc6-syzkaller-01279-gaedfbe251e1c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> RIP: 0010:udp_tunnel_update_gro_rcv+0x31d/0x670 net/ipv4/udp_offload.c:118
> Code: 23 48 89 eb e8 14 47 4f f7 c7 05 ca a9 32 10 01 00 00 00 31 ed 45 31 ed e9 80 01 00 00 e8 fb 46 4f f7 eb 40 e8 f4 46 4f f7 90 <0f> 0b 90 e9 5a 02 00 00 e8 e6 46 4f f7 eb 2b e8 df 46 4f f7 eb 24
> RSP: 0018:ffffc9000ad7fc50 EFLAGS: 00010293
> RAX: ffffffff8a72ab0e RBX: 1ffff1100502bb6f RCX: ffff888020f55a00
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
> RBP: ffffffff86c2d1a0 R08: ffffffff8a72a6eb R09: 1ffffffff207a2ee
> R10: dffffc0000000000 R11: fffffbfff207a2ef R12: dffffc0000000000
> R13: 0000000000000004 R14: ffff88802815db78 R15: 0000000000000000
> FS:  0000555582b32500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000040000001e030 CR3: 0000000034eca000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  udp_tunnel_cleanup_gro include/net/udp_tunnel.h:220 [inline]
>  udpv6_destroy_sock+0x230/0x2a0 net/ipv6/udp.c:1829
>  sk_common_release+0x71/0x2e0 net/core/sock.c:3892
>  inet_release+0x17d/0x200 net/ipv4/af_inet.c:435
>  __sock_release net/socket.c:647 [inline]
>  sock_close+0xbc/0x240 net/socket.c:1389
>  __fput+0x3e9/0x9f0 fs/file_table.c:464
>  task_work_run+0x24f/0x310 kernel/task_work.c:227
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
>  do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f3518f8d169
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffdfbd8d008 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
> RAX: 0000000000000000 RBX: 00007f35191a7ba0 RCX: 00007f3518f8d169
> RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
> RBP: 00007f35191a7ba0 R08: 00000000000000e8 R09: 0000000cfbd8d2ff
> R10: 00000000003ffcf4 R11: 0000000000000246 R12: 00000000000d64d1
> R13: 00007f35191a6160 R14: ffffffffffffffff R15: 00007ffdfbd8d120
>  </TASK>

Whoops, I did not notice that xfrm sets up->gro_receive, too, using a
different code path WRT setup_udp_tunnel_sock().

I think it's better to relax this WARN.

/P


