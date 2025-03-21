Return-Path: <linux-kernel+bounces-571065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEB2A6B8AA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA3A3B3027
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37251D9A50;
	Fri, 21 Mar 2025 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC2/hy3+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621831F1512
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552411; cv=none; b=FWCAw465PxF3o2l4HnnG6VYy3/WCHrqrEaPQjh3vGddS5DydobNs2GpFZVrKLPjn0m0fK4Ei4MXRYdVuy5reg59XSvA5KjR6Efz9FAu4o6o9j2JLacV5ZHxSj1T1OFwBfHrQml5Pr/OMlr3eujaDbTDoo3wbCLhzZ+laKMNT5hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552411; c=relaxed/simple;
	bh=Suk0xQQ6qUfn6EWLHmfFDq7yYLJzPObHnBiaNlBJKM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fafO4NKbIebYVjv2kLeW8/XZX/cGppt5ILUNfAzA791nqAMTAqpM9b6q1Mv4AioYjLBbcMW7VAi0XxoGMe15frjd7ABIsuJe8LFy639ipnQg50dRswfP+IDecBxN1XV3cPIQrNSVuqBqzBofKzxYNkVL5WEy1pYEQh2gRWjpHX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DC2/hy3+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742552408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7veLovhLal0NkTM3AjRtUJ/dyI3RmOm6dSAIJoOWgjw=;
	b=DC2/hy3+Cg4SIIKk8icoo5giy+8PH8QY/1pyEgB9kKhvA3SA/kI70uCRBZbJReIX4qvxJA
	ol9w26astOvrfW2BNrtx64lYaWTy7vmaKQr7E384CmEHqTgDWYYOxHEXCq+lUqXxXfQzzg
	ZhTKilkY3aGNIRJzK1psvr1i9VpWPFE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-WMkfRpWaOD-CYhhyCcOIqQ-1; Fri, 21 Mar 2025 06:20:07 -0400
X-MC-Unique: WMkfRpWaOD-CYhhyCcOIqQ-1
X-Mimecast-MFC-AGG-ID: WMkfRpWaOD-CYhhyCcOIqQ_1742552406
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-30c4cbc324bso10562261fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 03:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742552405; x=1743157205;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7veLovhLal0NkTM3AjRtUJ/dyI3RmOm6dSAIJoOWgjw=;
        b=DmCX0r/Yd61KOZ30Bs03t52mNEPTCTsCojebKXkF7hIbYGKypT5FwQAPBVliY+OQx+
         rOocxFmw4cxYXJCE0fr0P4JToMrCX2zE6bDpUG5Bk4Sw5WIVbrzfmrwaL5tK6qoi8fbt
         UFv7bGvFaay76IddjGUESGVIiUjKBadzdvxUiHyK5g4gNI25RcFSdtbu3qAsNCvukHgy
         eSArNv14WgEYU44QdJeO6tnatSyDyGFniTH7L6oCWSKQ3PuEUzYLu9wN5o5srU77OOh2
         86+NcqJtzbJ2hEyJADDwdKQ8lobdF1NZmrYMSyqsOq5dcyXQaCt9lkQ1oi7aJJ7FJZKC
         y+HA==
X-Forwarded-Encrypted: i=1; AJvYcCVYVNYRYt6ClQFTXc8jsOF3RNplnsOw6uOADCfXBPn44/zTwbSeF3OCPEAOGaduY12FSoUpcNNutX2Z7bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YziuqGYfAu3sVZ91N5pTV7wDU7GVqRhNNddk5lyk4UK1zoeCp1f
	72mp1iLE69l7gmowidofGSTMvUr7B6to8z4ZkA/teQNinHVfT7tj/BU6EMfwMkA3Prs5KB1tSzl
	nmmNnBRlySKT0rKi7AGqwJbDFht2YEdsX13EZEqE+TSGZ+s0TtJQrbRhArUErSQ==
X-Gm-Gg: ASbGncvoJ3JZmVEvXmhpbudvXv8w2UfqO/XYB9foF9UnUCHzot2rmFrX5EJwsmrJ35z
	BA/9onCiwh+pBBfhtwsgfBdtoe3ZXTc/T6rR47646y0RkQVP4uoEVv/Xxnh37YGbyhUpzwD7Ssq
	/I5DGqi88VKjMTnwnsF6o26c0YP3vsAHe6Z8/w0SRxuKxqPsI0hOpUOJ0dfRVQ+NdsV+ll7weUa
	eboX7XVSrnN41Wg7lyDOiCic4GYnWcbLxODebd5ORfPuARYjqMKlE0L6UthHoNx0ZW3Ozs94VLJ
	lL1d94XZRDpU
X-Received: by 2002:a05:6512:3ca8:b0:549:4ac4:a453 with SMTP id 2adb3069b0e04-54ad649aa74mr889719e87.21.1742552405446;
        Fri, 21 Mar 2025 03:20:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvHhPccNe0c6J/mZFH5uVmTCME8gO38sU17cMCB7lJEF+xy0NAMXBJEw/T9kJQe9rCVUj9+A==
X-Received: by 2002:a05:6512:3ca8:b0:549:4ac4:a453 with SMTP id 2adb3069b0e04-54ad649aa74mr889702e87.21.1742552404976;
        Fri, 21 Mar 2025 03:20:04 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64fbe5esm146601e87.157.2025.03.21.03.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 03:20:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4AEFC18FC4FA; Fri, 21 Mar 2025 11:20:01 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Wang Liang <wangliang74@huawei.com>, jv@jvosburgh.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joamaki@gmail.com
Cc: yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 wangliang74@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v2] bonding: check xdp prog when set bond mode
In-Reply-To: <20250321044852.1086551-1-wangliang74@huawei.com>
References: <20250321044852.1086551-1-wangliang74@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 21 Mar 2025 11:20:01 +0100
Message-ID: <87iko2it2m.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Wang Liang <wangliang74@huawei.com> writes:

> Following operations can trigger a warning[1]:
>
>     ip netns add ns1
>     ip netns exec ns1 ip link add bond0 type bond mode balance-rr
>     ip netns exec ns1 ip link set dev bond0 xdp obj af_xdp_kern.o sec xdp
>     ip netns exec ns1 ip link set bond0 type bond mode broadcast
>     ip netns del ns1
>
> When delete the namespace, dev_xdp_uninstall() is called to remove xdp
> program on bond dev, and bond_xdp_set() will check the bond mode. If bond
> mode is changed after attaching xdp program, the warning may occur.
>
> Some bond modes (broadcast, etc.) do not support native xdp. Set bond mode
> with xdp program attached is not good. Add check for xdp program when set
> bond mode.
>
>     [1]
>     ------------[ cut here ]------------
>     WARNING: CPU: 0 PID: 11 at net/core/dev.c:9912 unregister_netdevice_m=
any_notify+0x8d9/0x930
>     Modules linked in:
>     CPU: 0 UID: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.14.0-rc4 #107
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.=
0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
>     Workqueue: netns cleanup_net
>     RIP: 0010:unregister_netdevice_many_notify+0x8d9/0x930
>     Code: 00 00 48 c7 c6 6f e3 a2 82 48 c7 c7 d0 b3 96 82 e8 9c 10 3e ...
>     RSP: 0018:ffffc90000063d80 EFLAGS: 00000282
>     RAX: 00000000ffffffa1 RBX: ffff888004959000 RCX: 00000000ffffdfff
>     RDX: 0000000000000000 RSI: 00000000ffffffea RDI: ffffc90000063b48
>     RBP: ffffc90000063e28 R08: ffffffff82d39b28 R09: 0000000000009ffb
>     R10: 0000000000000175 R11: ffffffff82d09b40 R12: ffff8880049598e8
>     R13: 0000000000000001 R14: dead000000000100 R15: ffffc90000045000
>     FS:  0000000000000000(0000) GS:ffff888007a00000(0000) knlGS:000000000=
0000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 000000000d406b60 CR3: 000000000483e000 CR4: 00000000000006f0
>     Call Trace:
>      <TASK>
>      ? __warn+0x83/0x130
>      ? unregister_netdevice_many_notify+0x8d9/0x930
>      ? report_bug+0x18e/0x1a0
>      ? handle_bug+0x54/0x90
>      ? exc_invalid_op+0x18/0x70
>      ? asm_exc_invalid_op+0x1a/0x20
>      ? unregister_netdevice_many_notify+0x8d9/0x930
>      ? bond_net_exit_batch_rtnl+0x5c/0x90
>      cleanup_net+0x237/0x3d0
>      process_one_work+0x163/0x390
>      worker_thread+0x293/0x3b0
>      ? __pfx_worker_thread+0x10/0x10
>      kthread+0xec/0x1e0
>      ? __pfx_kthread+0x10/0x10
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x2f/0x50
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1a/0x30
>      </TASK>
>     ---[ end trace 0000000000000000 ]---
>
> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver=
")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


