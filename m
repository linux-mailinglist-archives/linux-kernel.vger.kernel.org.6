Return-Path: <linux-kernel+bounces-387657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 390FE9B5436
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A921F2463E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1A3209F28;
	Tue, 29 Oct 2024 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TftYdxWE"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1849209F23
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234332; cv=none; b=ZMIVLn6ClgFEqbOehYsQf0wTN30SY8p6xK/sSwYfNvFQzPCIn9i9MKvDhJ8DuXQ++jS8nWixXZVlIBn8BmCDBFMJ6ZOabTIYsjh6FwpFf67Ys+MmJZW8D2h5eZLzQzMvt8FCKZICr3D+IQZcMdz/ovors3H5srnEgCR9qwweN3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234332; c=relaxed/simple;
	bh=rxX4tl6h4/IVnKLPvQdszEOE7LTI8m5gBDI4nKRji6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpYYkztWxcz25dEh7fZikjh5HVvW2M25Zz7V/9w22Y0onPyzUfdzrNOGrlA+roE3Oio266sPvEJCQSFqn/vT7PFx8U/CmKw/tcfQSZGcvIhrAZD+vrhKWhYSgm6r0xUMR3z+XFaWReeWRmFhDA+eBbnY07j6gJKzzdO/fvMVcTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TftYdxWE; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea535890e0so716251a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730234329; x=1730839129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxX4tl6h4/IVnKLPvQdszEOE7LTI8m5gBDI4nKRji6M=;
        b=TftYdxWEXrBh1Y+WDvRjT/BzGMGEQPImSYvHbctXruuVA6E8JFE1DyBWRlVcRWZtUL
         kXeqs4q9Sd3IWx4ueJqgEJgPAfncZa8HnJTRwNYE1RH6hjCzZGUNm4H/dhP4bPsFdfRI
         4FhlrUAgFW4kzzcXdGqOQGNXcRnVxq7cc0QTk7BBneqoCeN5zC7WPx/AuIW88rMDxvq7
         vKjlcfYcAJrpMa1UsV58DdOG0IdAh9rB7L7oZCyFJN1yxL8+ODQB18c/z0ClNazdkJRF
         nVIgPpK54bLK7jBAfNce11BpP5up6iaKCs9e88O8pSIyd2Yd9XlO8ja3K63ei9YaTtTP
         WUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234329; x=1730839129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxX4tl6h4/IVnKLPvQdszEOE7LTI8m5gBDI4nKRji6M=;
        b=wrfz4RUxsNVyqa0SZJUdk8RqSR4yeIfmFgTCqBA6sxG6hehXTg+5q2b2BZvNajYVZC
         u7b+iiHVrJ3qJzwtM/n1AImIy79pq1OKe6Sv18/jeHAl6NTZ0H2V0EIw8kW74unx8rzR
         inspRM8/D5pT+chg1i62HfQZAU32/fUxqwvqtbokbUZ7iKfI/m9xnOaAhH30BLVRPmi3
         DGR1viEhvnsuoOnZmIZToyARRr14b73qlVTKw/mn3HWldPq3KHcUB2xkv9in6TGVlQcB
         P3IzHr1Tc+g4rLfLldc4STvz+LZfQ7/UjMXNo576vdjDzc3xxf753f1s1y3ecLAJWF95
         IjKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwk7WHEGzxpFVHp/EKOZmgi1mUptg5erYCuXjlVrIUK9NCreijRHG2gpUsAtU3JfNLggB4HvQgU1e6RBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB7ku6rxLv+j2YoO56wQRvmz3YAkzazGg7QfGYdFix3Sm3Nz4h
	G5VE+szYhct8xP2Wr404+jpUWFn/lvjYTEqJbKQt/sHi+8xwlpG21r6DYyVQIdXdI3uV2rXNzQZ
	D0+J7iaq/DB3Oh1XZ4lLee2cONYQRIT8m/d/V+g==
X-Google-Smtp-Source: AGHT+IET98qsSjNOjsfBxs4fNBfxl9mkBrcuSKEy0ssdSSQ0hphNvrIm7EngLn9PbwFPzWUn3YzOuODt/EHr1kPOdGQ=
X-Received: by 2002:a05:6a20:2444:b0:1d9:ddf:b087 with SMTP id
 adf61e73a8af0-1d9a84d970amr8215310637.8.1730234329089; Tue, 29 Oct 2024
 13:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029182703.2698171-1-csander@purestorage.com> <CANn89iLx-4dTB9fFgfrsXQ8oA0Z+TpBWNk4b91PPS1o=oypuBQ@mail.gmail.com>
In-Reply-To: <CANn89iLx-4dTB9fFgfrsXQ8oA0Z+TpBWNk4b91PPS1o=oypuBQ@mail.gmail.com>
From: Caleb Sander <csander@purestorage.com>
Date: Tue, 29 Oct 2024 13:38:37 -0700
Message-ID: <CADUfDZrSUNu7nym9dC1_yFUqhC8tUPYjv-ZKHofU9Q8Uv4Jvhw@mail.gmail.com>
Subject: Re: [PATCH] net: skip RPS if packet is already on target CPU
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 12:02=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Oct 29, 2024 at 7:27=E2=80=AFPM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > If RPS is enabled, all packets with a CPU flow hint are enqueued to the
> > target CPU's input_pkt_queue and process_backlog() is scheduled on that
> > CPU to dequeue and process the packets. If ARFS has already steered the
> > packets to the correct CPU, this additional queuing is unnecessary and
> > the spinlocks involved incur significant CPU overhead.
> >
> > In netif_receive_skb_internal() and netif_receive_skb_list_internal(),
> > check if the CPU flow hint get_rps_cpu() returns is the current CPU. If
> > so, bypass input_pkt_queue and immediately process the packet(s) on the
> > current CPU.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>
> Current implementation was a conscious choice. This has been discussed
> several times.
>
> By processing packets inline, you are actually increasing latencies of
> packets queued to other cpus.

Sorry, I wasn't aware of these prior discussions. I take it you are
referring to threads like
https://lore.kernel.org/netdev/20230322072142.32751-1-xu.xin16@zte.com.cn/T=
/
? I see what you mean about the latency penalty for packets that do
require cross-CPU steering.

Do you have an alternate suggestion for how to avoid the overhead of
acquiring a spinlock for every packet? The atomic instruction in
rps_lock_irq_disable() called from process_backlog() is consuming 5%
of our CPU time. For our use case, we don't really want software RPS;
we are expecting ARFS to steer all high-bandwidth traffic to the
desired CPUs. We would happily turn off software RPS entirely if we
could, which seems like it would avoid the concerns about higher
latency for packets that need to be steering to a different CPU. But
my understanding is that using ARFS requires RPS to be enabled
(rps_sock_flow_entries set globally and rps_flow_cnt set on each
queue), which enables these rps_needed static branches. Is that
correct? If so, would you be open to adding a sysctl that disables
software RPS and relies upon ARFS to do the packet steering?

Thanks,
Caleb

