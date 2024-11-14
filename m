Return-Path: <linux-kernel+bounces-409958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABB49C9491
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349912857CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AA51ACDED;
	Thu, 14 Nov 2024 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Z+jMj4Fh"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE50487BF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731620146; cv=none; b=lH6z+aPNzhUnCQq36IBCE8ra9IbBcY4//iXLzkmtaHjQPTEo9grH6cEhnSetCn6v+kRTnhOAzJZ1PAz1WMglcrQzbGhEMKDgYfiR5XmVHNYhD90dfZF0gn3YewoJGDaR47uNg90ateeNx2tR6/LQsO71fq9Rsm5+boXmBMlwDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731620146; c=relaxed/simple;
	bh=v3HK4gjqtfEqSmvvY5seDYiy0YByPXQztPCyrO5QnZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmKSnAAvObTXHrT4Owm4KAjTi3M/ykYzXrS/uh6ZbaQoFA16BJXuG82T0CJDZzRq29NOztSPdU3kSc1P4TIBv0zG6zYiU0Q6HlTSCHk350l5j78Su+jF3VyCRG/f73bWWQylMnBKakvTTg997SlajPCAt1py6KQ6Yf90LxWnJXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Z+jMj4Fh; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ede26dc527so200232a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1731620144; x=1732224944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BDQkPXCXl3Qz9Ff47gk6begMR45pafFh0XIUGkRXuU=;
        b=Z+jMj4FhO5a9ELgrThp8fW3u+rNWX6IJ5omg5EYPbAzj3jQ0EKQNeUhq9MSt6e1ogb
         PkYfyyuCZ/s16gxmDfyHl6Y/M297TApRB5ZY6nI6ZLW/QgkWfl1hXgSDxJfbyRz+l1uE
         52QgZU9kw0uONYkGfYedS1sjWts3ydMFsCY4znz2NyOPdKekWLyfU03me1ZPvL8CNhMt
         69nPV928DyvrviMEQrH7GbcyVhzy8W7nLBfuhUiSlasSeceuF/jlzdQMYcxHtxosyRRj
         /BAWOXVGI0oBphI5mfYjRF97qrlw+TnK8/mwFw21G2ATYQ8ndE/oOXB/6aTlPmBmK6wC
         nqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731620144; x=1732224944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BDQkPXCXl3Qz9Ff47gk6begMR45pafFh0XIUGkRXuU=;
        b=BNi/CO2zZbw778Dgt45PsnRR1/KLeARTX3TCDr0HdBTAXkA09fMYmAbUMIg3wDAY51
         nPXs/EnXl/7WyAjOngT6X+WVi3wsYHik7MhD3tsC3y5DIrdcl65ZNPtgVqWqHGLwChoJ
         kJSXtSsPd9H8uLsN5/1iDHkLgRWt67IAZgDXOfOxbOfRl0MX/1T8HQ6sDoeffLbdoIU/
         LFSmK2xFHv5bKFZTuOzuiEE7hGvwUqPtFO5WhOqzSRHVYCiFsQ7cIuzHdn3EkHBwT4oA
         rIATs2JTBEHEZIHGhTqew3EU+NeW6HqQWHDh8596xR0B8KrdMyk+DlgpdiRjy1CmklBi
         qc6w==
X-Forwarded-Encrypted: i=1; AJvYcCWIoSuT+D+qVMepI563MFsLnfsK+DP/nDAwcfiyXjm+b2980hUZZ+lE10yHaYXSqhDuYTRlz4ufCkfHJBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8fvoPV9NfSTfS4EXE7BH4du+Cjn52MsX7x1WNVfUmbySqdCn9
	rhazVJYHh3j+0j8C0OjB3o6jy+FsygM/cav10SIIs+TKNgz2/+BO1bet7rdRA277Ms57jscpFDN
	tA69HVFOIqCahgr/KQqlaTfEZm2sMPM9pnCgrZQ==
X-Google-Smtp-Source: AGHT+IEbUPtTRqLmM/RwnibXnd8sPObJSt1RNL3w40r5RGaXQ+de1pqNjI0X/dLe5cCAaW6vg16z42Z/ecN0RBrAIJI=
X-Received: by 2002:a05:6a00:2293:b0:71e:70fd:dac3 with SMTP id
 d2e1a72fcca58-72476d082a6mr212875b3a.3.1731620143914; Thu, 14 Nov 2024
 13:35:43 -0800 (PST)
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
Date: Thu, 14 Nov 2024 13:35:32 -0800
Message-ID: <CADUfDZqEe--KodhfJLK065biSE__TQ-FZNRtyanfXTA+iPjn4Q@mail.gmail.com>
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
> Why not instead address the past feedback ?
> Can you test the following ?
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c682173a76424d7dadcc8374aa5b11dff44a4b46..7a5a7f1a4b7c3cbd105ecfc07=
6377f25929729eb
> 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5842,6 +5842,21 @@ static int generic_xdp_install(struct
> net_device *dev, struct netdev_bpf *xdp)
>         return ret;
>  }
>
> +#ifdef CONFIG_RPS
> +static bool net_must_use_backlog(int tcpu)
> +{
> +       if (tcpu < 0)
> +               return false;
> +       if (tcpu !=3D smp_processor_id())
> +               return true;
> +       /* target cpu is ourself. We must use our backlog
> +        * if we have deferred IPI or packets.
> +        */
> +       return this_cpu_read(softnet_data.rps_ipi_list) !=3D NULL ||
> +              this_cpu_read(softnet_data.input_pkt_queue.qlen) !=3D 0;
> +}
> +#endif

Hi Eric,
Look at this patch again, I am wondering why the tcpu < 0 case is
treated differently from the tcpu =3D=3D smp_processor_id() case. If I
understand correctly, packets without a CPU flow hint are allowed to
be processed immediately on the current CPU. They will leapfrog
packets that other CPUs have queued onto this CPU via RPS and any RPS
IPIs waiting to be issued to other CPUs. I see this is the behavior in
the current code too, but why don't the same concerns about higher
latency for packets steered cross-CPU apply?

Thanks,
Caleb

