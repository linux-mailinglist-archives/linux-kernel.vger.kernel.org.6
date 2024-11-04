Return-Path: <linux-kernel+bounces-395395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000049BBD60
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 626A3B2118C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567771CB9ED;
	Mon,  4 Nov 2024 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="D1NyTxD+"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BE61CACD3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745735; cv=none; b=KDmeNDOypivaUoKwcNZFU2nHdRnnRo5JaCZ9WplqSB62u8iWgOvJci5Re5wKRw6E37v9xXTkoB2i9xbxNgegzWe3vSyQf1YuZrP+LaDZPEzlW1qX8WhnRbVj779drdAI7aHvOBDBpDiil64AfbfJpCPMrCUaH6lQeeozvt9oOzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745735; c=relaxed/simple;
	bh=r6ujx4ECoO9nHmJq2WUNuPD/e2iQp28jRgzZMD9FidY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7Rs9VQr04KZ2IP5RtQ1g12MScf2phF3srNeITkKgsOa5Zeg5q3DjzTGgmsIst3rPsOFl9FW1HSvOcZ5lzCn70+qNT5Nz9pIxvdWmV3L59NtIWJ0mveC0M1azad6viA50eYxb4AvaLzlD3uooBouBqMSYyY3o+4DfdoFmjP5Uro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=D1NyTxD+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2b720a0bbso782080a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 10:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730745733; x=1731350533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6ujx4ECoO9nHmJq2WUNuPD/e2iQp28jRgzZMD9FidY=;
        b=D1NyTxD+l3UCgUjLCAAtN88wD/6qkKlmfnvtBk9YirkNC/B4I8rGo5bMbbahTCtXGH
         3pKpKY7LWDHV39i5zoEiWu/Hz3GNnO5Pq686gC9IRmqpvPe9HEb+odVGHkFmpFwNp2AU
         tdTjJFbw/oiWk5AGARS8AsuLqIP5/mmmLZzPpYEmfGSEOYqRt7oGbfMY6zsqhbEcNdaM
         SapGsGKFRNy6R7OcGncdtmWrsgczD8hMMm1eKEdhU2JgwNAm/0BHD/4X4HQTR1G0I7Dj
         Pyb1rkV7+TXhKX9yyk15G401PBme7OtLkLKhioHPS+zrbXD1RhP1eayeIZB11AmFFqzY
         TW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730745733; x=1731350533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6ujx4ECoO9nHmJq2WUNuPD/e2iQp28jRgzZMD9FidY=;
        b=w+B2l2y/t/0JvZG/8ouP/8G/GrzW0/GZhskWp52iJtqgB+pQVm2Tpi8iy/6u16f9mX
         j3+OMjhFa7vwX17OT6P6OS4JF1f+lbgqWe25Kw3Tvb+6K+EjEsbPqp2pQj7oVkKo8PEP
         64Tgbuw0qSp9+VpeA0ubz7SWRdzv/sUDJVP0iPkGpazYiiIaDBx68cZwOK8i4md1TXTH
         sadfPzBsqneSwMSQxY1OD16cqYD/TDaE88t4n9WmxguIws0eJPvr+/xUGczngZszXK3y
         bww8oDmexaG+s9Irz4gwsYe/TPQhSmXc+ELDMZmo38mh71xH7H8Ib2buytKeNzo6vTAb
         tuAA==
X-Forwarded-Encrypted: i=1; AJvYcCVUwWOBcPWvdlr16zu7xJqNBRn5oAeSrmSGucXoPqQ92KiYlTtgzF/Trj73DXJZVlYtpBcFj6k/T9bJVFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ScoKKOdSC/tUTXSchWThLVCNS41ED2Yg8zoM5RLnZCPIflca
	CodIauuQO2c3ybqeShGoMh/Ihn5UQ9OZcVwlX44iF4ySshKgKNtIWm3tEcTNqZehRxOENUXOn12
	2BTOfc6a1Ga4h61JrUobJ+yMQHsGYiUHa3h0zhLz+keY6E+0l2GZYDQ==
X-Google-Smtp-Source: AGHT+IHRyp0fZGEkveVbZD/Ka4YhG44ViKMpXPhdBhrYj8X+Sc3biYODwWZrL603VjG0+1/9CnT9o46uFffC49ziBwI=
X-Received: by 2002:a17:90a:c90b:b0:2e2:e929:e8d2 with SMTP id
 98e67ed59e1d1-2e8f10a42e7mr16137187a91.4.1730745732870; Mon, 04 Nov 2024
 10:42:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029182703.2698171-1-csander@purestorage.com>
 <CANn89iLx-4dTB9fFgfrsXQ8oA0Z+TpBWNk4b91PPS1o=oypuBQ@mail.gmail.com>
 <CADUfDZrSUNu7nym9dC1_yFUqhC8tUPYjv-ZKHofU9Q8Uv4Jvhw@mail.gmail.com>
 <CANn89iKQ3g2+nSWaV3BWarpbneRCSoGSXdGP90PF7ScDu4ULEQ@mail.gmail.com> <CADUfDZpeudTGP5UZt6QqbrYkA+Twei7gGQa6hJ+iYwuZfyp9gw@mail.gmail.com>
In-Reply-To: <CADUfDZpeudTGP5UZt6QqbrYkA+Twei7gGQa6hJ+iYwuZfyp9gw@mail.gmail.com>
From: Caleb Sander <csander@purestorage.com>
Date: Mon, 4 Nov 2024 10:42:01 -0800
Message-ID: <CADUfDZqcd_2+409_4GGhbRwW8gYHtZSU1vE1eNuE=jycoNMMJA@mail.gmail.com>
Subject: Re: [PATCH] net: skip RPS if packet is already on target CPU
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 1:26=E2=80=AFPM Caleb Sander <csander@purestorage.c=
om> wrote:
>
> On Wed, Oct 30, 2024 at 5:55=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, Oct 29, 2024 at 9:38=E2=80=AFPM Caleb Sander <csander@purestora=
ge.com> wrote:
> > >
> > > On Tue, Oct 29, 2024 at 12:02=E2=80=AFPM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > >
> > > > On Tue, Oct 29, 2024 at 7:27=E2=80=AFPM Caleb Sander Mateos
> > > > <csander@purestorage.com> wrote:
> > > > >
> > > > > If RPS is enabled, all packets with a CPU flow hint are enqueued =
to the
> > > > > target CPU's input_pkt_queue and process_backlog() is scheduled o=
n that
> > > > > CPU to dequeue and process the packets. If ARFS has already steer=
ed the
> > > > > packets to the correct CPU, this additional queuing is unnecessar=
y and
> > > > > the spinlocks involved incur significant CPU overhead.
> > > > >
> > > > > In netif_receive_skb_internal() and netif_receive_skb_list_intern=
al(),
> > > > > check if the CPU flow hint get_rps_cpu() returns is the current C=
PU. If
> > > > > so, bypass input_pkt_queue and immediately process the packet(s) =
on the
> > > > > current CPU.
> > > > >
> > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > >
> > > > Current implementation was a conscious choice. This has been discus=
sed
> > > > several times.
> > > >
> > > > By processing packets inline, you are actually increasing latencies=
 of
> > > > packets queued to other cpus.
> > >
> > > Sorry, I wasn't aware of these prior discussions. I take it you are
> > > referring to threads like
> > > https://lore.kernel.org/netdev/20230322072142.32751-1-xu.xin16@zte.co=
m.cn/T/
> > > ? I see what you mean about the latency penalty for packets that do
> > > require cross-CPU steering.
> > >
> > > Do you have an alternate suggestion for how to avoid the overhead of
> > > acquiring a spinlock for every packet? The atomic instruction in
> > > rps_lock_irq_disable() called from process_backlog() is consuming 5%
> > > of our CPU time. For our use case, we don't really want software RPS;
> > > we are expecting ARFS to steer all high-bandwidth traffic to the
> > > desired CPUs. We would happily turn off software RPS entirely if we
> > > could, which seems like it would avoid the concerns about higher
> > > latency for packets that need to be steering to a different CPU. But
> > > my understanding is that using ARFS requires RPS to be enabled
> > > (rps_sock_flow_entries set globally and rps_flow_cnt set on each
> > > queue), which enables these rps_needed static branches. Is that
> > > correct? If so, would you be open to adding a sysctl that disables
> > > software RPS and relies upon ARFS to do the packet steering?
> >
> > A sysctl will not avoid the fundamental issue.
>
> Sorry if my suggestion was unclear. I mean that we would ideally like
> to use only hardware ARFS for packet steering, and disable software
> RPS.
> In our testing, ARFS reliably steers packets to the desired CPUs. (Our
> application has long-lived TCP sockets, each processed on a single
> thread affinitized to one of the interrupt CPUs for the Ethernet
> device.) In the off chance that ARFS doesn't steer the packet to the
> correct CPU, we would rather just process it on the CPU that receives
> it instead of going through the RPS queues. If software RPS is never
> used, then there wouldn't be any concerns about higher latency for
> RPS-steered vs. non-RPS-steered packets, right? The get_rps_cpu()
> computation is also not cheap, so it would be nice to skip it too.
> Basically, we want to program ARFS but skip these
> static_branch_unlikely(&rps_needed) branches. But I'm not aware of a
> way to do that currently. (Please let me know if it's already possible
> to do that.)

I see now that get_rps_cpu() still needs to be called even if software
RPS isn't going to be used, because it's also responsible for calling
set_rps_cpu() to program ARFS. So looks like avoiding the calls to
get_rps_cpu() entirely is not possible.

> > Why not instead address the past feedback ?
> > Can you test the following ?
>
> Sure, I will test the performance on our setup with this patch. Still,
> we would prefer to skip the get_rps_cpu() computation and these extra
> checks, and just process the packets on the CPUs they arrive on.

Hi Eric,
I tried out your patch and it seems to work equally well at
eliminating the process_backlog() -> _raw_spin_lock_irq() hotspot. The
added checks contribute a bit of overhead in
netif_receive_skb_list_internal(): it has increased from 0.15% to
0.28% of CPU time. But that's definitely worth it to remove the 5%
hotspot acquiring the RPS spinlock.

Feel free to add:
Tested-by: Caleb Sander Mateos <csander@purestorage.com>

Some minor comments on the patch:
- Probably should be using either skb_queue_len_lockless() or
skb_queue_empty_lockless() to check input_pkt_queue.qlen !=3D 0 because
the RPS lock is not held at this point
- Could consolidate the 2 this_cpu_read(softnet_data...) lookups into
a single this_cpu_ptr(&softnet_data) call

Thanks,
Caleb

