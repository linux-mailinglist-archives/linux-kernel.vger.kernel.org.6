Return-Path: <linux-kernel+bounces-194058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7248D35FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EC428844E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1364B180A97;
	Wed, 29 May 2024 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="deZTP64p"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59DD7317C
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716984389; cv=none; b=uWz0gRxsTh3+xiBCLTTP+5r8+NzMSOSP3qDEtL+x/cWatPX3rPvUqNQMqNOquSKXwSbAjoD0GwqJHR/PqEe8JRz7KkhTcHEBFnTHO13iZ7O2qYGJeh4NtjVqxRgoROfld0GSkVXYCNTNko6RwqQxm5bv00UXusDtcKXdwSLp8J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716984389; c=relaxed/simple;
	bh=HVRgV+LZHE9X1sc52MQrzhSbTAgg+EociwiNNOL0TFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNtg08Ugc2SlQbzaa/S9/011+nklnCiZIXOTX/qRoZA9NjDm/j7YuRrkvbdlMLt7kRW0gPe758WIHdRhHMm/6MwHYA/UVcM/yzLqV0oeH+QOyhrDPAtUwY8sGJvabkwQAfSwYfMrNV1S4SCPn9HFETZEupHq2Hor0xrxjfX8BeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=deZTP64p; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so14570a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 05:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716984386; x=1717589186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flfC85H1otrtKleLSIReDKcLMqBWb1luLofXQwNP6OM=;
        b=deZTP64pRfA2l3Xemm7CtVMqp45JZhaj0u1EVF0xJwudlQqNL3x9qvhkUgB2Gm9BFK
         64hQwhIextD5YRnSU1g7I2aj4zD3eZMivZ2PazC0mJ3ZMix02SPXvwXpq5QP5/WYeVkw
         6srQf5zTVIzzdWRwHSNx25WLbc8z5MjAkVep/eC0tvRDon/4LAb2S8edE+XrQD5XR+ny
         FfuhPLQ45zU+t3e9FooSToBHVUy1Oz6xU5Fxm7kEjHSjuYoekgc0/Y6uc6ki84CuCwek
         cdR+coDx0cqBYKVoTS3lwqbTdgk9VZ0dDRWUAWaxZjiIVQ3xh8YGCNIHrCnJF8YVI4Zv
         j2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716984386; x=1717589186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flfC85H1otrtKleLSIReDKcLMqBWb1luLofXQwNP6OM=;
        b=CMPoEecYgkLP41rAjtb3YBe63V69wWzjx2toK9h8M0qeoUNVw4lfravBEAZgaTprpw
         mpNwZK8b7INfx+qjQ9Dk/e1nHS/mHbnLc3tHZU+L0XONRwZz0upVw80Ja/R6DIJvd5Wp
         niDdNv2jLKkxcq+nqu21xJPfog3G5KlV6YHfYPb8mJXVG581EN9mZtJpY4cNdbCdt7TL
         mBs5LkF09a8qzy75mT9wD4h+2xhkfQREiXamwbSnPW+8+9hgME2l4fJ1puUHDWl+rYxI
         jcc2s/9+rLgrFwM8boW7IgUVOswlSblcuu6N7r1zU8HWXCj+IV/SRONDQhpOjE00rMHX
         iOQw==
X-Forwarded-Encrypted: i=1; AJvYcCUh5xSRsand4Txza83Y06rTAkZNSBVNJ/xASEI5rszFVfhpnBbT/jTSVlP/C3Ta3YqYkOUTD661NjyZpcSaqyz+FZpu9CrnSsr66Z1Z
X-Gm-Message-State: AOJu0YzPAxebYOOK41sduWQHhNtVAlvI78YusH05V39Cw67GKQQifcdc
	eoU2A2ajG75XpRrigqkMBqUb1b4WwlZUYN4ZT7b3nt1D9VuDBYJJLwO349adgqLEC2B/9/Ki1Cq
	/AvN9tcuLmn5cBj1zRqfyRNuTZ+dU45uYjvF2
X-Google-Smtp-Source: AGHT+IHQJxisSmwewpdLYHn9bYIrrVLVth/4iH1FzycyNVJv2EIWb9vTHg3pLQm025jpZjjFnarObtRvNRurCuWq5ro=
X-Received: by 2002:aa7:de18:0:b0:578:647d:a27e with SMTP id
 4fb4d7f45d1cf-57a05d1e5admr116279a12.1.1716984385821; Wed, 29 May 2024
 05:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529095633.613103-1-yuehaibing@huawei.com>
In-Reply-To: <20240529095633.613103-1-yuehaibing@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 May 2024 14:06:11 +0200
Message-ID: <CANn89i+AxEsmj_9=WYPJ-JP18q9faE1hhQtEdJktAdun7bHzyQ@mail.gmail.com>
Subject: Re: [PATCH net v2] ipvlan: Dont Use skb->sk in ipvlan_process_v{4,6}_outbound
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	maheshb@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 11:52=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com=
> wrote:
>
> Raw packet from PF_PACKET socket ontop of an IPv6-backed ipvlan device wi=
ll
> hit WARN_ON_ONCE() in sk_mc_loop() through sch_direct_xmit() path.
>
> WARNING: CPU: 2 PID: 0 at net/core/sock.c:775 sk_mc_loop+0x2d/0x70
> Modules linked in: sch_netem ipvlan rfkill cirrus drm_shmem_helper sg drm=
_kms_helper
> CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Not tainted 6.9.0+ #279
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:sk_mc_loop+0x2d/0x70
> Code: fa 0f 1f 44 00 00 65 0f b7 15 f7 96 a3 4f 31 c0 66 85 d2 75 26 48 8=
5 ff 74 1c
> RSP: 0018:ffffa9584015cd78 EFLAGS: 00010212
> RAX: 0000000000000011 RBX: ffff91e585793e00 RCX: 0000000002c6a001
> RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffff91e589c0f000
> RBP: ffff91e5855bd100 R08: 0000000000000000 R09: 3d00545216f43d00
> R10: ffff91e584fdcc50 R11: 00000060dd8616f4 R12: ffff91e58132d000
> R13: ffff91e584fdcc68 R14: ffff91e5869ce800 R15: ffff91e589c0f000
> FS:  0000000000000000(0000) GS:ffff91e898100000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f788f7c44c0 CR3: 0000000008e1a000 CR4: 00000000000006f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <IRQ>
>  ? __warn (kernel/panic.c:693)
>  ? sk_mc_loop (net/core/sock.c:760)
>  ? report_bug (lib/bug.c:201 lib/bug.c:219)
>  ? handle_bug (arch/x86/kernel/traps.c:239)
>  ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
>  ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
>  ? sk_mc_loop (net/core/sock.c:760)
>  ip6_finish_output2 (net/ipv6/ip6_output.c:83 (discriminator 1))
>  ? nf_hook_slow (net/netfilter/core.c:626)
>  ip6_finish_output (net/ipv6/ip6_output.c:222)
>  ? __pfx_ip6_finish_output (net/ipv6/ip6_output.c:215)
>  ipvlan_xmit_mode_l3 (drivers/net/ipvlan/ipvlan_core.c:602) ipvlan
>  ipvlan_start_xmit (drivers/net/ipvlan/ipvlan_main.c:226) ipvlan
>  dev_hard_start_xmit (net/core/dev.c:3594)
>  sch_direct_xmit (net/sched/sch_generic.c:343)
>  __qdisc_run (net/sched/sch_generic.c:416)
>  net_tx_action (net/core/dev.c:5286)
>  handle_softirqs (kernel/softirq.c:555)
>  __irq_exit_rcu (kernel/softirq.c:589)
>  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043)
>
> The warning triggers as this:
> packet_sendmsg
>    packet_snd //skb->sk is packet sk
>       __dev_queue_xmit
>          __dev_xmit_skb //q->enqueue is not NULL
>              __qdisc_run
>                sch_direct_xmit
>                  dev_hard_start_xmit
>                    ipvlan_start_xmit
>                       ipvlan_xmit_mode_l3 //l3 mode
>                         ipvlan_process_outbound //vepa flag
>                           ipvlan_process_v6_outbound
>                             ip6_local_out
>                                 __ip6_finish_output
>                                   ip6_finish_output2 //multicast packet
>                                     sk_mc_loop //sk->sk_family is AF_PACK=
ET
>
> Call ip{6}_local_out() with NULL sk in ipvlan as other tunnels to fix thi=
s.
>
> Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

