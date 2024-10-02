Return-Path: <linux-kernel+bounces-347098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB7598CDBF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6C71F25B1E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CE019409E;
	Wed,  2 Oct 2024 07:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Glx0VZ6l"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D61F839EB
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727854094; cv=none; b=AhTfVtP1acd8zEng9KvpKSxzWy3dLOjFlb6RV2jTyLFhXxJnzonGO4liKnWAhqF+lgUf/a9WMAY3dxq6ntLl2tTlYlJOPq6z7O+vA7DlF4lo2bfl0D7qItGTMuZo8w8lZj6TsrSqzZ6sJo/VcumrVwMvZYt+SzPF/E1tjVjXyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727854094; c=relaxed/simple;
	bh=+6rxxewfS7nGJm/k6J4am0oJsZeqIYjkksEUEVpB8xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFU8coVJdO2LyLOEfhqWq2qYUPQKNI2Cx+87hji4KFCjoOXP+jP7I95ZZbKGwpJJWZZbSgawmfSyvjOUI4AxqWYkRV/APYGm3yZND1dnUyll93nwWM0nu3pM6Eyw4lZpMei95BsAAKii4gdaVTnX3yESIjgFIv4astKWYd72lsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Glx0VZ6l; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c89e66012aso3269224a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 00:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727854090; x=1728458890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoY1uVWW0TBlbL1FE0TmNEJGNZWbqNtdD5nNxMYW6CY=;
        b=Glx0VZ6ltpONe1rvR3Vjtkqvnq2NVK5ADpo6NfJHxKuIJUI92kumm+eiHBl0fbYFpA
         I7G5D92++A2cHMvKJIFAtZxF0vNk6Nlktl2xt055qDKnRvnth/fzyDjC6i16C6YN5zZ9
         9/p0i9TmW0bye7YDmJWUHKjUvrFqHkN9mNSjWT3HQBRxekLEdOgWxyCPQeYG1vG28/M1
         hqrVwtIDTc35BuoBCrbhIZZ5r/dKse1KdnBhdfl6BFmLWTuVqNNVhQEfrvRKk74LFq8N
         BrSl3aDswKUWa9bxg0INOuYrSs+vb/TV0Q6FsYBocUQaxl6eOnvvz9BDz55Y89zOG2VT
         r8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727854090; x=1728458890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoY1uVWW0TBlbL1FE0TmNEJGNZWbqNtdD5nNxMYW6CY=;
        b=lEkMS3uYQk6431IGHVGioXO+7DMIwwDKwDHBxQwv+0UUJ2FDcGhDszoHGpPjKVbnxd
         zixv398zU5teBE8yoAB1kadnTDCxqTdGHEYOUzfxLATm59871RIkqKdoOR9UdK1JBVgH
         l7Hfh04ibrgeg+rZbUAyW0UeRaTOr3Gwuh1BlwgWnt4E8wqew3eAgh02KOy7zOWyQZqH
         gYg8T4Y1vYRR2CqSFwPj+sRBDzhPilKkOUZCWrgVrIpVONF7vBmOLbGemknrJ0bfMnif
         L3AyB9jdbLbNsz2c8g6KLIsWwX2L9XV9CjJJGrzQBtlUVNI9XZ2rampVkHbgxT3dyhPX
         8qRg==
X-Forwarded-Encrypted: i=1; AJvYcCXTi3R7OAM+aKnRlscORQxmZJul4TmQKawOysOdhPvnaCXum6jMGF/dByQW3QTmMbu3upCYh+xxL17T4SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvLTgN+aXkqjgr+tziGxBJ8njIswEoS6S32MH7yla/VvUQWTs0
	fFjO3FOGrGhspzvm60rbmudk5ElNkwTAnWSumQkOGaj/yT6u8k19OBwPU1i6oA26YgP85ORlp5G
	CBKQ0G3C8dlmUnGTU7co+IgzkO7G+EOefpmlq
X-Google-Smtp-Source: AGHT+IHw62kflM+poCBldYd3rhBWj/iPUQPhXrrG5B2DbjbsL9SQBpONq+uoJt8zohnrcwpN9Aak4tkU8MOmPDPMcus=
X-Received: by 2002:a05:6402:2550:b0:5c4:1320:e5a3 with SMTP id
 4fb4d7f45d1cf-5c8b1a34bb7mr1807331a12.16.1727854089499; Wed, 02 Oct 2024
 00:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002053844.130553-1-danielyangkang@gmail.com>
In-Reply-To: <20241002053844.130553-1-danielyangkang@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Oct 2024 09:27:55 +0200
Message-ID: <CANn89i+y77-1skcxeq+OAeOVBDXhgZb75yZCq8+NBpHtZGySmw@mail.gmail.com>
Subject: Re: [PATCH] Fix KMSAN infoleak, initialize unused data in pskb_expand_head
To: Daniel Yang <danielyangkang@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 7:39=E2=80=AFAM Daniel Yang <danielyangkang@gmail.co=
m> wrote:
>
> pskb_expand_head doesn't initialize extra nhead bytes in header and
> tail bytes, leading to KMSAN infoleak error. Fix by initializing data to
> 0 with memset.
>
> Reported-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
> Tested-by: Daniel Yang <danielyangkang@gmail.com>
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>

No no no.

Please fix the root cause, instead of making slow all the users that
got this right.

Uninit was stored to memory at:
 eth_header_parse+0xb8/0x110 net/ethernet/eth.c:204
 dev_parse_header include/linux/netdevice.h:3158 [inline]
 packet_rcv+0xefc/0x2050 net/packet/af_packet.c:2253
 dev_queue_xmit_nit+0x114b/0x12a0 net/core/dev.c:2347
 xmit_one net/core/dev.c:3584 [inline]
 dev_hard_start_xmit+0x17d/0xa20 net/core/dev.c:3604
 __dev_queue_xmit+0x3576/0x55e0 net/core/dev.c:4424
 dev_queue_xmit include/linux/netdevice.h:3094 [inline]



Sanity check [1] in __bpf_redirect_common() does not really help, if
skb->len =3D=3D 1 :/

/* Verify that a link layer header is carried */
if (unlikely(skb->mac_header >=3D skb->network_header || skb->len =3D=3D 0)=
) {
     kfree_skb(skb);
     return -ERANGE;
}

These bugs keep showing up.

[1]

commit 114039b342014680911c35bd6b72624180fd669a
Author: Stanislav Fomichev <sdf@fomichev.me>
Date:   Mon Nov 21 10:03:39 2022 -0800

    bpf: Move skb->len =3D=3D 0 checks into __bpf_redirect

    To avoid potentially breaking existing users.

    Both mac/no-mac cases have to be amended; mac_header >=3D network_heade=
r
    is not enough (verified with a new test, see next patch).

    Fixes: fd1894224407 ("bpf: Don't redirect packets with invalid pkt_len"=
)
    Signed-off-by: Stanislav Fomichev <sdf@google.com>
    Link: https://lore.kernel.org/r/20221121180340.1983627-1-sdf@google.com
    Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

I sent an earlier patch, this went nowhere I am afraid.

https://www.spinics.net/lists/netdev/msg982652.html

Daniel, can you take a look and fix this in net/core/filter.c ?

