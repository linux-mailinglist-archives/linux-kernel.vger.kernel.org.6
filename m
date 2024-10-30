Return-Path: <linux-kernel+bounces-389484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E68F9B6DA6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A231F1C21CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053961D1509;
	Wed, 30 Oct 2024 20:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fi+0Pafw"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE33019CC24
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320024; cv=none; b=USHdAB9LgWwkV4OHBBpNQOJ82/pCtLb0KQriZ+kqT1/3OpO5OBnzBxMa/l/RGkKv8rXNeQE71vyxe+p6IcDbATYsmGDO1MDgeOTvIGqzzcOg9Smas2lxk36f7fwG8QkzEuFYtjKsWHCTO6//MkE8VRQnf409M7/lYfGEgR/vvFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320024; c=relaxed/simple;
	bh=ZI0+eUgQo8I7fIoKYVHtKj4C5JVTIyU+QkrCMycWR/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApeIkepae5OWmwHz2hZVIo04o6q+WWLIY4s3/mRpRIYhwYyhtNiZh1cUG9B+AWohpm1amiPojjsG6x3E2o7/6wr33KPwHatRC6FwXuxsbXgrb66ddodqUzxdQfwnkascGKpSyHVAXdC5XPrRRB02jY1SSDpU+xpuhPpTMoqyAtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fi+0Pafw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e52582d28so12503b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730320021; x=1730924821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZI0+eUgQo8I7fIoKYVHtKj4C5JVTIyU+QkrCMycWR/g=;
        b=fi+0PafwaEbcNfjqfdnGui/BBOgXIJwDITiyPv27dUJflbIjbCu0gM2tF5D1v47iF0
         ViCxbUyhE2N7FBe3XC2CKVak92Pv495uu5Xvy7GFekel+9qwYqjwlLtWw721PuhtbpCB
         2Lh/UvjQFHIgU0Twa/ZUCQLO6sXBTPWV95YdPIQnbAP0TcyRkoVODyp3LtNnsdnpjX4R
         EKBtrMnuwuAiN+vUdSv1n65L2T5NYW5Xk3VdWlLhH15lloJ1IBkLHkhunw/Q1zGEq2vu
         9/LKWNBO2krQ0a6TQcNgnWUMQC9lwqP94M1HH7WLRr7F413ObU+Jy35O8GtzFB0//lTh
         hN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320021; x=1730924821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZI0+eUgQo8I7fIoKYVHtKj4C5JVTIyU+QkrCMycWR/g=;
        b=jQ2R3YKbc0lgkd8YQd1J5rhiW+3v22o2IV0lCz3LNSp+L4uNOwD1PnKGPNdB/H+bZh
         6WAR5TgtS93hzVGwxuLNbwXCDURPZBn7zuxhg3GFEzGD5u3Tgg0RrWb8ph97jhciHDOR
         IDtW156r/ECXh0QBwBB5gTXtS/8dkibKO5yyH7B0a94p5tXbuPewmTx5BJ/jhaScC9Pj
         oCLvRIY0ygSwkpzvv+qYoUKYNZ67gPOBcFW5adVsH5bZ4GMvr6LNZRb8CYxFe9+OS6M4
         SOZMzR0uiKTkA/35qpktvVd8Vq9CZtdwASgbeQ5lfUV6zNqXCI9TjpIArT+pL6ReXT0K
         7rOA==
X-Forwarded-Encrypted: i=1; AJvYcCXL5R7wP1CJVFGNgRBssISEklphxq85PauNTPTPzwCNdPNbciTseRKQk8cXdHFvrIjo7EERDigNnNyMYm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy6bBEr7b7pby2BNenGBIrxp1oL8TOP0ByZsWp28D8Ib8eaaaj
	FAnXjJYJgFcGXitlb4dxr/kuy6lnUci3AMuE8E1tOOunj5uPjWBfH9bnhcsEK/nqjKrTj+dXbuk
	4lPCJ/oHoqyQSH1be1cOuLFlwWcHxo+OmhMbGWw==
X-Google-Smtp-Source: AGHT+IEe+sezOi9NNRi6GXOD3OiFBZ+kpW0Y4kdcKdpjOHsfhqUpdmq3zafEz4HsRK20iKb3e4Vv3OjIWkRGwjnoHOE=
X-Received: by 2002:a05:6a00:998:b0:71e:5033:c6 with SMTP id
 d2e1a72fcca58-7206303212amr10293507b3a.5.1730320020821; Wed, 30 Oct 2024
 13:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029182703.2698171-1-csander@purestorage.com>
 <CANn89iLx-4dTB9fFgfrsXQ8oA0Z+TpBWNk4b91PPS1o=oypuBQ@mail.gmail.com>
 <CADUfDZrSUNu7nym9dC1_yFUqhC8tUPYjv-ZKHofU9Q8Uv4Jvhw@mail.gmail.com> <CANn89iKQ3g2+nSWaV3BWarpbneRCSoGSXdGP90PF7ScDu4ULEQ@mail.gmail.com>
In-Reply-To: <CANn89iKQ3g2+nSWaV3BWarpbneRCSoGSXdGP90PF7ScDu4ULEQ@mail.gmail.com>
From: Caleb Sander <csander@purestorage.com>
Date: Wed, 30 Oct 2024 13:26:49 -0700
Message-ID: <CADUfDZpeudTGP5UZt6QqbrYkA+Twei7gGQa6hJ+iYwuZfyp9gw@mail.gmail.com>
Subject: Re: [PATCH] net: skip RPS if packet is already on target CPU
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 5:55=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Oct 29, 2024 at 9:38=E2=80=AFPM Caleb Sander <csander@purestorage=
.com> wrote:
> >
> > On Tue, Oct 29, 2024 at 12:02=E2=80=AFPM Eric Dumazet <edumazet@google.=
com> wrote:
> > >
> > > On Tue, Oct 29, 2024 at 7:27=E2=80=AFPM Caleb Sander Mateos
> > > <csander@purestorage.com> wrote:
> > > >
> > > > If RPS is enabled, all packets with a CPU flow hint are enqueued to=
 the
> > > > target CPU's input_pkt_queue and process_backlog() is scheduled on =
that
> > > > CPU to dequeue and process the packets. If ARFS has already steered=
 the
> > > > packets to the correct CPU, this additional queuing is unnecessary =
and
> > > > the spinlocks involved incur significant CPU overhead.
> > > >
> > > > In netif_receive_skb_internal() and netif_receive_skb_list_internal=
(),
> > > > check if the CPU flow hint get_rps_cpu() returns is the current CPU=
. If
> > > > so, bypass input_pkt_queue and immediately process the packet(s) on=
 the
> > > > current CPU.
> > > >
> > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > >
> > > Current implementation was a conscious choice. This has been discusse=
d
> > > several times.
> > >
> > > By processing packets inline, you are actually increasing latencies o=
f
> > > packets queued to other cpus.
> >
> > Sorry, I wasn't aware of these prior discussions. I take it you are
> > referring to threads like
> > https://lore.kernel.org/netdev/20230322072142.32751-1-xu.xin16@zte.com.=
cn/T/
> > ? I see what you mean about the latency penalty for packets that do
> > require cross-CPU steering.
> >
> > Do you have an alternate suggestion for how to avoid the overhead of
> > acquiring a spinlock for every packet? The atomic instruction in
> > rps_lock_irq_disable() called from process_backlog() is consuming 5%
> > of our CPU time. For our use case, we don't really want software RPS;
> > we are expecting ARFS to steer all high-bandwidth traffic to the
> > desired CPUs. We would happily turn off software RPS entirely if we
> > could, which seems like it would avoid the concerns about higher
> > latency for packets that need to be steering to a different CPU. But
> > my understanding is that using ARFS requires RPS to be enabled
> > (rps_sock_flow_entries set globally and rps_flow_cnt set on each
> > queue), which enables these rps_needed static branches. Is that
> > correct? If so, would you be open to adding a sysctl that disables
> > software RPS and relies upon ARFS to do the packet steering?
>
> A sysctl will not avoid the fundamental issue.

Sorry if my suggestion was unclear. I mean that we would ideally like
to use only hardware ARFS for packet steering, and disable software
RPS.
In our testing, ARFS reliably steers packets to the desired CPUs. (Our
application has long-lived TCP sockets, each processed on a single
thread affinitized to one of the interrupt CPUs for the Ethernet
device.) In the off chance that ARFS doesn't steer the packet to the
correct CPU, we would rather just process it on the CPU that receives
it instead of going through the RPS queues. If software RPS is never
used, then there wouldn't be any concerns about higher latency for
RPS-steered vs. non-RPS-steered packets, right? The get_rps_cpu()
computation is also not cheap, so it would be nice to skip it too.
Basically, we want to program ARFS but skip these
static_branch_unlikely(&rps_needed) branches. But I'm not aware of a
way to do that currently. (Please let me know if it's already possible
to do that.)

> Why not instead address the past feedback ?
> Can you test the following ?

Sure, I will test the performance on our setup with this patch. Still,
we would prefer to skip the get_rps_cpu() computation and these extra
checks, and just process the packets on the CPUs they arrive on.

Thanks for your help,
Caleb

