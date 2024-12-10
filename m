Return-Path: <linux-kernel+bounces-439100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4169EAACE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF38188AAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176A22309AA;
	Tue, 10 Dec 2024 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5tNPJxr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A8D19D897
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819821; cv=none; b=kp35uTUJCemdoaP/ZahZeGeepzfgYExl78e4dXdA1OxnJ16f+1QZJz/mIUuVH5NEFLze87HePsN+UxSIDlN1unHTgRTBBsY27TcljYKBUzrT+wsuOYQ3W7llb/miND6H0sUyAIVLJ3nUU0KZIJjgFymdZvizyLG7NublrR1FDlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819821; c=relaxed/simple;
	bh=d97GTUZGLw6k3hjnd5U72/XSa/1M3BMFL0etNUqjcZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UyrkuzVM7nw0UpldArZlN17fI4/EhI3tAgp3AUMKENSQGafgtymT7EjTRxYd8DP3oHIuEB/+VaIud3giu5mRnEKPbVlds50EUS6F/g8ucrSA9MMyLXoncqQLex5MVvaw0hhfYuR0W3E1GURUbDUZ6fR7kCtU3b3n8/bMfcu4ZIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5tNPJxr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733819818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXx1aulz1QdplSJwRsSBebpo3uH7S/P6vC1NV17HVwg=;
	b=O5tNPJxr+ZdJWmNFcbTXLc0SlOGahp6XRW/741sSX/bDomJ+Ef4sxVYVipRm1z8jN551lS
	jbil9dIDSZOKIayRCFTCqX1hwI9dGFhjI/PKetVZ+K/47eMmrCrhsi2PGoegbEfBBIzmBP
	jE2W0HS1dyY09BRAVRriYusRXEhHQL4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-0mbIi7XWMTSEwkBbeDY52Q-1; Tue, 10 Dec 2024 03:36:57 -0500
X-MC-Unique: 0mbIi7XWMTSEwkBbeDY52Q-1
X-Mimecast-MFC-AGG-ID: 0mbIi7XWMTSEwkBbeDY52Q
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4667e12c945so79263571cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733819817; x=1734424617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXx1aulz1QdplSJwRsSBebpo3uH7S/P6vC1NV17HVwg=;
        b=vKPueGSqSBluzYYROAxT3O5uBc4n522xyfwAZobPucxOAmk22luPpsPKFqxrF1MWWe
         cJOeXU6QMdUNN9uPm6kT/WcpOT71zRX/QCK4ge5fDhh7sfnshjpHedSqu1LlYPA8o3wi
         5RTkepLr091MF7pqloHOCeLnZ+Kc2R0dRKjPupb8EGQ2uz0N6SdEv7IvGl5VZjqEdpxS
         imXabsQwfyxDXTYQ5Nh3o7m702LnB2WbRZoYWxxMASq2oBJ6mB9HhkE4UVBHP6itoQbg
         NmcRaGwCWXzCJkGBKkWRmRoi49DL48xk+AjksXjxIs0TGkIZjdU3g+1eNhhv7MlKHzKj
         DYVw==
X-Forwarded-Encrypted: i=1; AJvYcCV+OX/mZnHLDN19qjdhrPQI4Y5zWd6ZaaAGjo251JbMic6KU/SEGnRsoTuWxikEjlN5Gcj57xzVrvCdarw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn9xPG5kvzBC9oBAm6ZguFAPU/q7SQTmCu9/RLxi0RCSm/D/pB
	ep6zcpAzHuKCh7HWjBMyFNQrM3e00I66ZQP9l09CatJBFBw0Y4Dswsp+LJPtFyc5G+EcG3/mquO
	8NQ3NelDv5ELEKdUwQkf2J/I9woBvPvjiVP4eDvdaT0O2MqUf26r0/CrjnliOKg==
X-Gm-Gg: ASbGncs+aSqUiHLrHBIgVIeqySQZ6WVIlCSmYJ1MC2SliWJSSZH0LE1K/e8eLvcSBO7
	NYgxwQbOS2T3UDmOOloiBOxPx2F93tguYkck5ONgmzH6M2SErVxvHvfwHPkCpWsrH7hauARkrfX
	twLj8ocQx74m5wtKanp4Nv3crXkmAeuWRVOns+sm0WeVzx2HY95pqMz6kpjckVbrkZVClywd6wd
	T1Idt06/GJIgvdlA1GphencJXKrkOlsZ6DoFf2X9S3gHiqXBMj9ORUc9w6WzbMKg8c6DY5vSAnh
	/bcD/AK79GCzdjy5pvR20NOZlA==
X-Received: by 2002:a05:622a:900a:b0:467:79eb:4a16 with SMTP id d75a77b69052e-46779eb4dfamr28229141cf.4.1733819816878;
        Tue, 10 Dec 2024 00:36:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEazZl2nb7+W1PyktYZ1vwK3OYpgBWcIWjH7XStMhK6S8yrD2oF8TqcReAmDTmO8s5JsMLxw==
X-Received: by 2002:a05:622a:900a:b0:467:79eb:4a16 with SMTP id d75a77b69052e-46779eb4dfamr28228911cf.4.1733819816560;
        Tue, 10 Dec 2024 00:36:56 -0800 (PST)
Received: from [192.168.1.14] (host-82-49-164-239.retail.telecomitalia.it. [82.49.164.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46782e5c662sm1135561cf.80.2024.12.10.00.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 00:36:56 -0800 (PST)
Message-ID: <2d713deb-180a-422f-b7bd-15832944d1e4@redhat.com>
Date: Tue, 10 Dec 2024 09:36:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] WARNING in NUM
To: syzbot <syzbot+3f059ffbdd539a3f6bc9@syzkaller.appspotmail.com>,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6753d8c1.050a0220.a30f1.0151.GAE@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <6753d8c1.050a0220.a30f1.0151.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/24 06:10, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    cdd30ebb1b9f module: Convert symbol namespace to string li..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=146c8330580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6851fe4f61792030
> dashboard link: https://syzkaller.appspot.com/bug?extid=3f059ffbdd539a3f6bc9
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-cdd30ebb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/35bb9b3cd157/vmlinux-cdd30ebb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9c6bbf481907/bzImage-cdd30ebb.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3f059ffbdd539a3f6bc9@syzkaller.appspotmail.com
> 
> Dec  3 05:04:02 syzkaller daemon.info dhcpcd[5653]: eth3: IAID d8:df:c9:55
> Dec  3 05:04:02 syzkaller daemon.info dhcpcd[5653]: eth3: adding address fe80::7[   49.690919][ T6466] ------------[ cut here ]------------
> f27:c3e8:bb45:52[   49.693207][ T6466] WARNING: CPU: 3 PID: 6466 at net/ipv6/ip6mr.c:419 ip6mr_free_table+0xbd/0x120 net/ipv6/ip6mr.c:419
> df
> Dec  3 05:04:02 [   49.710042][ T6466] Code: 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 58 49 83 bc 24 c0 0e 00 00 00 74 09 e8 c4 c5 af f7 90 <0f> 0b 90 e8 bb c5 af f7 48 8d 7b 38 e8 22 86 9c f7 48 89 df be 0f
> syzkaller kern.w[   49.717312][ T6466] RSP: 0018:ffffc90003487bd8 EFLAGS: 00010293
> arn kernel: [   [   49.719598][ T6466] RAX: 0000000000000000 RBX: ffff888108508000 RCX: ffffffff89ea4014
> 49.690919][ T646[   49.725534][ T6466] RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
> 6] ------------[[   49.725548][ T6466] R10: 0000000000000001 R11: 0000000000000001 R12: ffff88804e965ac0
>  cut here ]-----[   49.725561][ T6466] R13: ffff888108508000 R14: ffff888108508008 R15: dead000000000100
> -------
> Dec  3 05:04:02 [   49.739536][ T6466] CR2: 00007f4fd5157580 CR3: 0000000035ea8000 CR4: 0000000000352ef0
> syzkaller kern.w[   49.742428][ T6466] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> arn kernel: [   [   49.746956][ T6466] Call Trace:
> 49.693207][ T646[   49.748809][ T6466]  ? __warn+0xea/0x3c0 kernel/panic.c:746
> 6] WARNING: CPU:[   49.750217][ T6466]  ? ip6mr_free_table+0xbd/0x120 net/ipv6/ip6mr.c:419
>  3 PID: 6466 at [   49.751877][ T6466]  ? __report_bug lib/bug.c:199 [inline]
>  3 PID: 6466 at [   49.751877][ T6466]  ? report_bug+0x3c0/0x580 lib/bug.c:219
> net/ipv6/ip6mr.c[   49.751908][ T6466]  ? exc_invalid_op+0x17/0x50 arch/x86/kernel/traps.c:309
> :419 ip6mr_free_[   49.751922][ T6466]  ? asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
> table+0xbd/0x120[   49.759463][ T6466]  ? ip6mr_free_table+0xbc/0x120 net/ipv6/ip6mr.c:419
> 
> Dec  3 05:04:02 syzkaller kern[   49.762545][ T6466]  ? ip6mr_free_table+0xbc/0x120 net/ipv6/ip6mr.c:419
> .warn kernel: [ [   49.765091][ T6466]  ip6mr_rules_exit+0x176/0x2d0 net/ipv6/ip6mr.c:283
>   49.696818][ T6[   49.767196][ T6466]  ip6mr_net_exit_batch+0x53/0xa0 net/ipv6/ip6mr.c:1388
> 466] Modules lin[   49.768971][ T6466]  ? __pfx_ip6mr_net_exit_batch+0x10/0x10 net/ipv6/ip6mr.c:285
> ked in:
> Dec  3 05:04:02 [   49.769038][ T6466]  setup_net+0x4fe/0x860 net/core/net_namespace.c:394
> syzkaller kern.w[   49.769059][ T6466]  ? __pfx_setup_net+0x10/0x10 net/core/net_namespace.c:185
> arn kernel: [   [   49.778049][ T6466]  ? __down_read_common kernel/locking/rwsem.c:1255 [inline]
> arn kernel: [   [   49.778049][ T6466]  ? __down_read_killable kernel/locking/rwsem.c:1271 [inline]
> arn kernel: [   [   49.778049][ T6466]  ? down_read_killable+0xcc/0x380 kernel/locking/rwsem.c:1549
> 49.699801][ T646[   49.781754][ T6466]  ? lockdep_init_map_waits include/linux/lockdep.h:135 [inline]
> 49.699801][ T646[   49.781754][ T6466]  ? lockdep_init_map_wait include/linux/lockdep.h:142 [inline]
> 49.699801][ T646[   49.781754][ T6466]  ? __raw_spin_lock_init+0x3a/0x110 kernel/locking/spinlock_debug.c:25
> 6] CPU: 3 UID: 0 PID: 6466 Comm: syz.2.106 Not tainted 6.13.0-rc1-syzkaller-00002-gcdd30ebb1b9f #0

#syz fix: ipmr: tune the ipmr_can_free_table() checks.


