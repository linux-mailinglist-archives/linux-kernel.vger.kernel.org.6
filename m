Return-Path: <linux-kernel+bounces-204472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190AB8FEF8D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA686B2B00B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12D119AA4E;
	Thu,  6 Jun 2024 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ypGtmARm"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70757195F10
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684088; cv=none; b=SIgxMsdm4N8TQ6lYRCH4zDW4bVSQGBjIssJ5qAIYzhbAUxizSiwZIPNZqnle7RGxj9QLRbWxukQWSeJ65+vJ62ah/D6fIaRbdcYcmteGwXlved2lSdpZUM9PG3/RFdqRlFTWCXvtxH60sBaWT4YR2IFuf/49Ja6APnTUF/hEoRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684088; c=relaxed/simple;
	bh=2010hG4iABBo1ahAxQfVMNrsbmnxPlFm5STPyt+3t+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJfZ/2jAKyjcHelDFIBuI+4bQta6fN9QxF/yAVbrDlZ7oWTOS0UFDkR/vqwrqdDrhtuG65YCITJw4nHjVT7/3kMkRxCizIdmJd7zPIZSrDJKTbSqyryAd3islB2tvs1j3RfnG+87wWpcuL6NNF9yNpjCVNINDy8RluYSvYmtxIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ypGtmARm; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so16427a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717684084; x=1718288884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHOeVkduEhimJCash5Ne5E2HPSt4JUJn9g5gWE3wRFw=;
        b=ypGtmARmR/1gxyhyzCC8jbb6CvsKc7Xio2GhdtA7SlYjl+zjbwkkEUa+MPqY3JlDi+
         qMcMMh6yz4ZvpWAIw415FmDvuaouvJgjXkXwRdq5ARqIPt8pPevU2ByCpkbFwmYjxP6X
         Dm4yBVRENdR/P5DWgynL5TO9yG5ycdj9b8w9AgCarb7/hK9L/QVW1NFMaFES9UDuIr5b
         Oy+jKAtVvm+sFY5TX+Oo/HX9BPLFTcfWE228BVvKGgAkFFzEJxQwGFoxitQ255rRsVO7
         jZRGl37/8mPUxFm+sETNf9dItZNdcunjrDKVetOjKcyFGFv8hsEcV0dTB6TobuzRXcax
         PFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684084; x=1718288884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHOeVkduEhimJCash5Ne5E2HPSt4JUJn9g5gWE3wRFw=;
        b=IIWdktFdPAlNSomfbrnuqc/zeLw0wRXk+0yQF6/aQMd0JASSjrxH3Ojk/7ks2UQA0U
         fUJm9zO+Y6w4kseEU4/4QW8wc73WdXjH+GtZIQdzKXMtzMbsIySf6cLqklLDle57vc8T
         en8bIIVi6roFFlyEyWKjfymVVTN8+fX7H+9Yax4UM53wbdyxZmI5TGHWgbpaKQMogFLn
         vBrkJDzCnlWH6XX9uPX+bieVR225SYZF1hpuzMo2C1LUnkahJlH5Lg+Hd9tiXUgoAgbt
         dqDz7NSZkbzJcvkQBbF6FkjCHcqvRAQzAM68GG/RrIoKKG+ZEQYfr0WoTkWFmh6aJNJ7
         H70Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfmo1+VfHu9F9i7rWab84hTl9PoutFX7tP5YDbAQ6DKizhoTqaVkDeYvaLGj0PYa9UM4Fg0UuLeMohxrjy83+2uf7/DZnwMswAmX88
X-Gm-Message-State: AOJu0YzsOm9rXmbl/WptOPOPjk/aRQp0NP5o9gYSLDVW41vv/uVVKd9l
	oUbnqeKFfPH8NvRQOtgeCRIriYHrohSO1AL6GvBY4gTDOrFc0lwy4kOMlNzOewunRxYmvKTtfRW
	1+sOqUO7D/PzK+eiICpR7+nG9IDvxv5ED2U6fRylGQdHTMgaVWUqh
X-Google-Smtp-Source: AGHT+IFOE/+JyMH6/CKDFNZouqC5GGkV8bt8ynYn5TTi25PVwy/8Tu7Fn4wUXOICF5VBGWZUUvjxprFdohSvRE/FgnY=
X-Received: by 2002:a05:6402:2d7:b0:57a:22c8:2d3c with SMTP id
 4fb4d7f45d1cf-57aa680b57bmr235474a12.0.1717684083312; Thu, 06 Jun 2024
 07:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606141450.44709-1-arefev@swemel.ru>
In-Reply-To: <20240606141450.44709-1-arefev@swemel.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Jun 2024 16:27:49 +0200
Message-ID: <CANn89iLkcg1bkngfZ-U-5+tyq-uYiHfzdRCH2BwUzd_Nvpt6Qg@mail.gmail.com>
Subject: Re: [PATCH] net: missing check
To: Denis Arefev <arefev@swemel.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 4:14=E2=80=AFPM Denis Arefev <arefev@swemel.ru> wrot=
e:
>
> Two missing check in virtio_net_hdr_to_skb() allowed syzbot
> to crash kernels again
>
> 1. After the skb_segment function the buffer may become non-linear
> (nr_frags !=3D 0), but since the SKBTX_SHARED_FRAG flag is not set anywhe=
re
> the __skb_linearize function will not be executed, then the buffer will
> remain non-linear. Then the condition (offset >=3D skb_headlen(skb))
> becomes true, which causes WARN_ON_ONCE in skb_checksum_help.
>
> 2. The struct sk_buff and struct virtio_net_hdr members must be
> mathematically related.
> (gso_size) must be greater than (needed) otherwise WARN_ON_ONCE.
> (remainder) must be greater than (needed) otherwise WARN_ON_ONCE.
> (remainder) may be 0 if division is without remainder.
>
> offset+2 (4191) > skb_headlen() (1116)
> WARNING: CPU: 1 PID: 5084 at net/core/dev.c:3303 skb_checksum_help+0x5e2/=
0x740 net/core/dev.c:3303
> Modules linked in:
> CPU: 1 PID: 5084 Comm: syz-executor336 Not tainted 6.7.0-rc3-syzkaller-00=
014-gdf60cee26a2e #0
> Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 1=
1/10/2023
> RIP: 0010:skb_checksum_help+0x5e2/0x740 net/core/dev.c:3303
> Code: 89 e8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 52 01 00 00 44 89 e=
2 2b 53 74 4c 89 ee 48 c7 c7 40 57 e9 8b e8 af 8f dd f8 90 <0f> 0b 90 90 e9=
 87 fe ff ff e8 40 0f 6e f9 e9 4b fa ff ff 48 89 ef
> RSP: 0018:ffffc90003a9f338 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff888025125780 RCX: ffffffff814db209
> RDX: ffff888015393b80 RSI: ffffffff814db216 RDI: 0000000000000001
> RBP: ffff8880251257f4 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000001 R12: 000000000000045c
> R13: 000000000000105f R14: ffff8880251257f0 R15: 000000000000105d
> FS:  0000555555c24380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000002000f000 CR3: 0000000023151000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ip_do_fragment+0xa1b/0x18b0 net/ipv4/ip_output.c:777
>  ip_fragment.constprop.0+0x161/0x230 net/ipv4/ip_output.c:584
>  ip_finish_output_gso net/ipv4/ip_output.c:286 [inline]
>  __ip_finish_output net/ipv4/ip_output.c:308 [inline]
>  __ip_finish_output+0x49c/0x650 net/ipv4/ip_output.c:295
>  ip_finish_output+0x31/0x310 net/ipv4/ip_output.c:323
>  NF_HOOK_COND include/linux/netfilter.h:303 [inline]
>  ip_output+0x13b/0x2a0 net/ipv4/ip_output.c:433
>  dst_output include/net/dst.h:451 [inline]
>  ip_local_out+0xaf/0x1a0 net/ipv4/ip_output.c:129
>  iptunnel_xmit+0x5b4/0x9b0 net/ipv4/ip_tunnel_core.c:82
>  ipip6_tunnel_xmit net/ipv6/sit.c:1034 [inline]
>  sit_tunnel_xmit+0xed2/0x28f0 net/ipv6/sit.c:1076
>  __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4954 [inline]
>  xmit_one net/core/dev.c:3545 [inline]
>  dev_hard_start_xmit+0x13d/0x6d0 net/core/dev.c:3561
>  __dev_queue_xmit+0x7c1/0x3d60 net/core/dev.c:4346
>  dev_queue_xmit include/linux/netdevice.h:3134 [inline]
>  packet_xmit+0x257/0x380 net/packet/af_packet.c:276
>  packet_snd net/packet/af_packet.c:3087 [inline]
>  packet_sendmsg+0x24ca/0x5240 net/packet/af_packet.c:3119
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0xd5/0x180 net/socket.c:745
>  __sys_sendto+0x255/0x340 net/socket.c:2190
>  __do_sys_sendto net/socket.c:2202 [inline]
>  __se_sys_sendto net/socket.c:2198 [inline]
>  __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2198
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>  include/linux/virtio_net.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 4dfa9b69ca8d..77ebe908d746 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -56,6 +56,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff =
*skb,
>         unsigned int thlen =3D 0;
>         unsigned int p_off =3D 0;
>         unsigned int ip_proto;
> +       u64 ret, remainder;
>
>         if (hdr->gso_type !=3D VIRTIO_NET_HDR_GSO_NONE) {
>                 switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
> @@ -98,6 +99,15 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff=
 *skb,
>                 u32 off =3D __virtio16_to_cpu(little_endian, hdr->csum_of=
fset);
>                 u32 needed =3D start + max_t(u32, thlen, off + sizeof(__s=
um16));
>
> +               if (hdr->gso_size) {
> +                       ret =3D div64_u64_rem(skb->len, hdr->gso_size, &r=
emainder);
> +                       if (!(ret && (hdr->gso_size > needed) &&
> +                                               ((remainder > needed) || =
(remainder =3D=3D 0)))) {
> +                               return -EINVAL;
> +                       }
> +                       skb_shinfo(skb)->tx_flags |=3D SKBFL_SHARED_FRAG;
> +               }
> +
>                 if (!pskb_may_pull(skb, needed))
>                         return -EINVAL;
>
Hi Denis

Please please please cc netdev@ for this kind of patch.

gso_size has no relation to @needed.

I doubt div64_u64_rem() is needed.

SKBFL_SHARED_FRAG should not be abused like that.

Bug must be elsewhere. Do you have a repro ?

I think syzbot has a similar report.

