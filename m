Return-Path: <linux-kernel+bounces-349119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7C198F145
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64403B22274
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8F919E981;
	Thu,  3 Oct 2024 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="te70F8hp"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDEF197A65
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965193; cv=none; b=qAY+Vr2DoIEekvvwxl0AcVRlZl7jPExALE7KklQ7lOMYlsllManA3S0tve1Mng0NaNy6KfsgC/1/WzY12FkCre/pB1m5nZMSWAwl6qvtGbP9Mwbkcib3zSNxKaeu73GUitz/kCiwrJcdTG1WB/vQP5oJ3Mr33GLJwqOECBqHbYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965193; c=relaxed/simple;
	bh=jEDOM8QuSwOb48e3mmxxN6IwrGTguRS37gMDkZcCTe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5pAcwujXSbOLtVkTN56wv3O1yS0uQKmX4BKypaJq+3caOE4I0YRtWE85G6rpRUOx80qy5s8/hWoz3esoi5pBqXmlIpUcIAV4hy2K4F1EnxCx8ZbpunTr9GpEto9Awh3E8C7lW/9Y0l0PXAZBU6JvQoZZJCQ3nnPpV9F12ekoyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=te70F8hp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8a837cec81so77908566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727965189; x=1728569989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6D9BBTOWVhS9oQET6D/1JucUNqsarIL+ZnUjshw+eZs=;
        b=te70F8hpXEj7ursc8ifn40IC31PmqnpqnuEfNg/+6NrOiw6/RdBnPKMp3A097/5f/1
         Dukr/JRPG4MLE3OaPH4/LSFQNp9lsolRj2edc/qU7uTLeLReAuN/bqJws9l1nkM/FXfs
         p0ePzG7lsZqsf+CXjSkhSrhPp90hoYKGa1tL99xW8nGZqCPNgHrsB3VqiteZBviCPRod
         yVT5VCMwQ5fsG6a3MA9HvLloT6dR8YdfOQIR4AeD0rZRyUta8wcN91tNZcPTpktkWAap
         7AhbQVRdZC6K0YF29zLAdv0TLFy6vi9+pJJ5yM7RKl0tkxa0G9P149VvmkGeTl3dktya
         48AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727965189; x=1728569989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6D9BBTOWVhS9oQET6D/1JucUNqsarIL+ZnUjshw+eZs=;
        b=Khlc5DpAdy3c+UEfKo8r2MVFwzUGvKHmtKKxh7WWb2UOrSVtgjXZYJb/a3YF7rSBT5
         2wSCAJ1UN3X1s/U76Csmeby/T4mf/lhduFOmllJBCjDZIcC+Jb/tQ6jIEXcfFd4vbgQE
         mwyUnJWCy6wu7t+45fL5R2yzZQ5za97euh9VO1dIO1zYxGsPkLHOvsXK0kJT5lxbxIih
         YNoPtu880J0Fx+5f4s43E4XCeMnEyQ4dWkfrOBF51GtCqXRTlGgihhum0V8s3uyWfLVh
         SPgMvKYGn1W+XqLTzvIpNqWxrrRIC3kNl+KDyjblL2sNO9YwVwaG3YwU1khhbX+MXdlE
         pkTg==
X-Forwarded-Encrypted: i=1; AJvYcCWKvV5pSMdXu0tCHwTcZJA7yT9i8OTb75GeTnkZ5irQ/ZAyzHT5dboBxcihHrXhUnn9kRTW8R0Tk93iO68=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn7JN3PQTgscuM7amuNk50poY/OQqCEgkrDfcI1705EU0cdgam
	FHomMBUCIxRsuEOJq0jHH12x7K8nQfDS6XOgkRPrSAQPQow8GffCs+nJoOmy90ooGVFXyaaNNcy
	kH6SUapdSRRXwZxKQy9K/9VPBDv+ngY+/sC58
X-Google-Smtp-Source: AGHT+IEKI/5zS9vWGN9eXOxESHjlFTiIZEbIFKRqEdQqr0OgULxqNw6JhrVAXnZETa68BaAklShll7D1Z4Q0r5jt7AY=
X-Received: by 2002:a05:6402:3514:b0:5c8:84a8:5170 with SMTP id
 4fb4d7f45d1cf-5c8b1b7a86fmr6504345a12.34.1727965188797; Thu, 03 Oct 2024
 07:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001193352.151102-1-yyyynoom@gmail.com> <CAAjsZQx1NFdx8HyBmDqDxQbUvcxbaag5y-ft+feWLgQeb1Qfdw@mail.gmail.com>
 <CANn89i+aHZWGqWjCQXacRV4SBGXJvyEVeNcZb7LA0rCwifQH2w@mail.gmail.com> <CAAjsZQxEKLZd-fQdRiu68uX6Kg4opW4wsQRaLcKyfnQ+UyO+vw@mail.gmail.com>
In-Reply-To: <CAAjsZQxEKLZd-fQdRiu68uX6Kg4opW4wsQRaLcKyfnQ+UyO+vw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 3 Oct 2024 16:19:35 +0200
Message-ID: <CANn89i+hNfRjhvpRR+WXqD72ko4_-N+Tj3CqmJTBGyi3SpQ+Og@mail.gmail.com>
Subject: Re: [PATCH net] net: add inline annotation to fix the build warning
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux@weissschuh.net, j.granados@samsung.com, judyhsiao@chromium.org, 
	James.Z.Li@dell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 3:57=E2=80=AFPM Moon Yeounsu <yyyynoom@gmail.com> wr=
ote:
>
> On Wed, Oct 2, 2024 at 11:41=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Oct 2, 2024 at 3:47=E2=80=AFPM Moon Yeounsu <yyyynoom@gmail.com=
> wrote:
> > >
> > > Moon is stupid. He doesn't understand what's going on. It makes me up=
set.
> > >
> > > https://lore.kernel.org/netdev/20240919145609.GF1571683@kernel.org/
> > >
> > > Simon did the best effort for him, but he didn't remember that.
> > >
> > > Please don't reply to this careless patch.
> > >
> > > Replies to me to remember all the maintainer's dedication and thought=
fulness and to take this to heart.
> > >
> > > Before I send the patch, I'll check it again and again. And fix the s=
ubject `net` to `net-next`.
> > >
> > > I'm very very disappointed to myself :(
> >
> > LOCKDEP is more powerful than sparse, I would not bother with this at a=
ll.
>
> Totally agree with that. `Sparse` has a lot of problems derived from its =
nature.
> And It is too annoying to silence the warning message. I know that
> this patch just fixes for a fix. (What a trivial?)
> But, even though `LOCKDEP` is more powerful than `Sparse`, that can't
> be the reason to ignore the warning message.
>
> It is only my opinion and this topic may be outside of the net
> subsystem. Please don't be offended by my words and ignorance. I don't
> want to make a problem, rather want to fix a problem.
> If there's no reason to use `Sparse`, then, how about just removing it
> from the kernel? If It can't, we have to make Sparse more useful at
> least make to have to care about this warning message.

sparse is not in the kernel. Feel free to remove it from your hosts.

Anyway, the __acquires(XXX) annotations means nothing, XXX is
completely ignored.

$ diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 09e31757e96c7472af2a9dfff7a731d4d076aa11..50fc48c6d0c99d91f5a8eb15c4e=
3dd0304a83e0b
100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2888,7 +2888,7 @@ static struct key_vector
*fib_route_get_idx(struct fib_route_iter *iter,
 }

 static void *fib_route_seq_start(struct seq_file *seq, loff_t *pos)
-       __acquires(RCU)
+       __acquires(some_random_stuff)
 {
        struct fib_route_iter *iter =3D seq->private;
        struct fib_table *tb;


$ make C=3D1 net/ipv4/fib_trie.o
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  DESCEND bpf/resolve_btfids
  INSTALL libsubcmd_headers
  CC      net/ipv4/fib_trie.o
  CHECK   net/ipv4/fib_trie.c

No error at all.

It also does not know about conditional locking, it is quite useless.

