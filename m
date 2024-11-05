Return-Path: <linux-kernel+bounces-396230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EA59BC9A0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E5D280A03
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D3A1D151F;
	Tue,  5 Nov 2024 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bVInRM6H"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF01CDA3E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800369; cv=none; b=W/s5NDHF9DXuhe85g3HraE27VW2/NidOOrbttvgH6Yppt/djz+0ospB8DOixGH/30qU4Ij1oqOO9bxdz635kTcFLQViyIOqNkx+CoKa0uzLpv4sDW9CKPr7URCa2gWxae3mCthzCiPLzILo9wPr6Pk6Ppyajo9ID5/zjhYbuOPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800369; c=relaxed/simple;
	bh=QNIrwhadNif68dVff17QnahTUQKNU8HNUfA6xYNEZQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTJo6FqJjALvb/StWWfcYHC95OtGwt2AHDSmq3a65ImU8dXv6hYv0dBk6PQPGk/hbzeL0t/UfDhGl4r2h94D3zHkgF4KYek0gc8Iv7As1G/dNGVDg8sOADt5wv6aPzGY/CURVBvw6pLWV4PWov7xniJr6fRx5u56BCk8ZKWRHhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bVInRM6H; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cec8c4e2f6so3559508a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 01:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730800366; x=1731405166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5i34kIJfNNRCtgcy3ZNg46rlRxERG959AeGUzU8geQ=;
        b=bVInRM6Hp2gPsX0Ma/s4y+WMXHyInWHzUjODoIeLvTrVsOgeOtb33f2lANfedjPUx5
         yZgEU/wtqmC7qG4zDT41D4o5hVaNkE4F08ZDeI7FdqVuTVue4jNqJfnN55ljx6iZsRae
         NTk+oYv0e5sIj8lqwGXezBBYI3suDBUUKI7cPRfcejsuYhswuW+3SKkLvN5kWRfMDU5E
         SdkDgbR/nuE6O89lnEnSPb2rc9powlLDQHhObBwkhEmFTQ8YWlL5S3sTeOzEgfCtFSW7
         fMElKBFM8cUNmwu3r69ezS+cwmEd6zncdsANXLQFmL+goWSk22rF4kXDpeCo6rsBc4PQ
         0CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730800366; x=1731405166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5i34kIJfNNRCtgcy3ZNg46rlRxERG959AeGUzU8geQ=;
        b=j66IFKOj7umhwTKJoydRwRY8atwVlLvf5lnUhHDG3ER9GD01MNtJwu0g9TSIQjn/lx
         MqWnULJJUYzZJJufUkLlh+4bpvRF804qK0n4icKQLsGOkRGPAYMwvzb0hy3WsSUGe+2p
         14SAA6VRltZhCH+gnnN+KUDWqPS+l2gHG4C0G3fy6dQb2l2/bQDUBJW8QyR1rulziT3R
         Zk9RAjl+XQBb/xmWh+NZm2J6Y6013Gyhc212cuJ6IycZWJdihdDCsrhnjT0m5AhNxZ9Y
         qKHTsd74yVzL6g5Kduj5wdAZkmw3+1DgPGOjuu6DulgO7KCCUb/UFASB5YTDat/U1yRy
         ihcQ==
X-Forwarded-Encrypted: i=1; AJvYcCViUDUfpn2KRP7GjaCK4napeqVOIg8/2JwBLbjCEprxj5ncmVZSs3qN8d35xEieVYO6D/hxr4JpnSoexvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2+PmCJIgl4+EziKVzrNCUfUaNp+enFxP9AvJDx7UsduMKirfT
	WX/9Mw2bgyXNcxjDXyoGAMDdwSxwZc3xfOmE/MDy1IH8cNdZOapz5EDPlhdqR0O8hTLgeXuupBj
	Wdm8vVMfQU2EXY7jFJikr2oF9vHQWfQ8x266/
X-Google-Smtp-Source: AGHT+IHmfC8lmwEAlAyKzmgyIPP2LQmgV5ugfdamIPylT6XF1ZoR/MZRVtscO9C8VO6NKQ5mQsGScrz4SU2+dz/KS1w=
X-Received: by 2002:a05:6402:50cc:b0:5cb:7877:a633 with SMTP id
 4fb4d7f45d1cf-5ceb9383c7dmr8802354a12.33.1730800365881; Tue, 05 Nov 2024
 01:52:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105080305.717508-1-wangliang74@huawei.com>
In-Reply-To: <20241105080305.717508-1-wangliang74@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Nov 2024 10:52:34 +0100
Message-ID: <CANn89iJ8mOqtOkMvrn6c892XrA_m3uf5FabmDWzA_pk-tTMCzw@mail.gmail.com>
Subject: Re: [RFC PATCH net v2] net: fix data-races around sk->sk_forward_alloc
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@amazon.com, luoxuanqiang@kylinos.cn, 
	kernelxing@tencent.com, kirjanov@gmail.com, yuehaibing@huawei.com, 
	zhangchangzhong@huawei.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 8:46=E2=80=AFAM Wang Liang <wangliang74@huawei.com> =
wrote:
>
> Syzkaller reported this warning:
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 16 at net/ipv4/af_inet.c:156 inet_sock_destruct+0x1=
c5/0x1e0
>  Modules linked in:
>  CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc5 #26
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/=
01/2014
>  RIP: 0010:inet_sock_destruct+0x1c5/0x1e0
>  Code: 24 12 4c 89 e2 5b 48 c7 c7 98 ec bb 82 41 5c e9 d1 18 17 ff 4c 89 =
e6 5b 48 c7 c7 d0 ec bb 82 41 5c e9 bf 18 17 ff 0f 0b eb 83 <0f> 0b eb 97 0=
f 0b eb 87 0f 0b e9 68 ff ff ff 66 66 2e 0f 1f 84 00
>  RSP: 0018:ffffc9000008bd90 EFLAGS: 00010206
>  RAX: 0000000000000300 RBX: ffff88810b172a90 RCX: 0000000000000007
>  RDX: 0000000000000002 RSI: 0000000000000300 RDI: ffff88810b172a00
>  RBP: ffff88810b172a00 R08: ffff888104273c00 R09: 0000000000100007
>  R10: 0000000000020000 R11: 0000000000000006 R12: ffff88810b172a00
>  R13: 0000000000000004 R14: 0000000000000000 R15: ffff888237c31f78
>  FS:  0000000000000000(0000) GS:ffff888237c00000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007ffc63fecac8 CR3: 000000000342e000 CR4: 00000000000006f0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   ? __warn+0x88/0x130
>   ? inet_sock_destruct+0x1c5/0x1e0
>   ? report_bug+0x18e/0x1a0
>   ? handle_bug+0x53/0x90
>   ? exc_invalid_op+0x18/0x70
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? inet_sock_destruct+0x1c5/0x1e0
>   __sk_destruct+0x2a/0x200
>   rcu_do_batch+0x1aa/0x530
>   ? rcu_do_batch+0x13b/0x530
>   rcu_core+0x159/0x2f0
>   handle_softirqs+0xd3/0x2b0
>   ? __pfx_smpboot_thread_fn+0x10/0x10
>   run_ksoftirqd+0x25/0x30
>   smpboot_thread_fn+0xdd/0x1d0
>   kthread+0xd3/0x100
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x34/0x50
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  ---[ end trace 0000000000000000 ]---
>
> Its possible that two threads call tcp_v6_do_rcv()/sk_forward_alloc_add()
> concurrently when sk->sk_state =3D=3D TCP_LISTEN with sk->sk_lock unlocke=
d,
> which triggers a data-race around sk->sk_forward_alloc:
> tcp_v6_rcv
>     tcp_v6_do_rcv
>         skb_clone_and_charge_r
>             sk_rmem_schedule
>                 __sk_mem_schedule
>                     sk_forward_alloc_add()
>             skb_set_owner_r
>                 sk_mem_charge
>                     sk_forward_alloc_add()
>         __kfree_skb
>             skb_release_all
>                 skb_release_head_state
>                     sock_rfree
>                         sk_mem_uncharge
>                             sk_forward_alloc_add()
>                             sk_mem_reclaim
>                                 // set local var reclaimable
>                                 __sk_mem_reclaim
>                                     sk_forward_alloc_add()
>
> In this syzkaller testcase, two threads call
> tcp_v6_do_rcv() with skb->truesize=3D768, the sk_forward_alloc changes li=
ke
> this:
>  (cpu 1)             | (cpu 2)             | sk_forward_alloc
>  ...                 | ...                 | 0
>  __sk_mem_schedule() |                     | +4096 =3D 4096
>                      | __sk_mem_schedule() | +4096 =3D 8192
>  sk_mem_charge()     |                     | -768  =3D 7424
>                      | sk_mem_charge()     | -768  =3D 6656
>  ...                 |    ...              |
>  sk_mem_uncharge()   |                     | +768  =3D 7424
>  reclaimable=3D7424    |                     |
>                      | sk_mem_uncharge()   | +768  =3D 8192
>                      | reclaimable=3D8192    |
>  __sk_mem_reclaim()  |                     | -4096 =3D 4096
>                      | __sk_mem_reclaim()  | -8192 =3D -4096 !=3D 0
>
> The skb_clone_and_charge_r() should not be called in tcp_v6_do_rcv() when
> sk->sk_state is TCP_LISTEN, it happens later in tcp_v6_syn_recv_sock().
> Fix the same issue in dccp_v6_do_rcv().
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

