Return-Path: <linux-kernel+bounces-328503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E88F97850C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54371F235C6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB6250A80;
	Fri, 13 Sep 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bh4isZHG"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D791E2EB02
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242000; cv=none; b=W1TKSBx15BVz85X1UMWAEoarcE+GUd6RwMFb7n+qK/8q0LTe917ND4xx3x+YIvw2BTd9pxmRUHHUwzjsPztlK/sqv9v9yyabSkxBGLGhRGg52usGK/J72f8nLB5gs4mskxyZ1FADz7LLvYyZHKGsOB6psf968dUed5/CkBNgO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242000; c=relaxed/simple;
	bh=vJzTQroHUo6fH3tz9KeS90mgTSfC0eOVWdyUtSQdEwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQtHD0aTFwlnjyyrz0MiinVUTqkWIV5HLpV0NHA2ucSSqcWr6rF7Excv0gJ4N1ZBReEdWKCxr68wW9jJkR/jvnHQgSEDLFGWYqXEjprfoh685sSSmAIu3iFSihp2fuyF7M0GvVXbgYEAUc+ZR4YnexMpAQ1CoY63TkmaQSzuEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bh4isZHG; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a90349aa7e5so236198966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726241997; x=1726846797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJzTQroHUo6fH3tz9KeS90mgTSfC0eOVWdyUtSQdEwY=;
        b=Bh4isZHGd58FvnlgjW4O0IMtYBbOOVEX1WXgC5ZkGPxtjwzH++S3O4zzGgDUK4R2m1
         0Q1x3fU5Enp/Z7lOUUKpT5gjwCytY04Wrm7l0Ag6JyNA+RKOVuyLN62ufFoV3UrjvMU+
         mXlPP/KYZtkM1TKg+1RQpwMluYoIjnVBfPcwZgMR90J6tnXOvb69DqLGTRvpLy2C/+e6
         p3XBunDdtnJBD2K2XAL++EWcNLIHLO/xpXwGY+EQnpETLE/5/Kf/khjJA7+C0n33knMm
         LloQv27FKicVToojeskaLp2txtzrepMB13RBn8poyXO/u+uaoKKAurU+d9lWk/XS9ucQ
         AyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726241997; x=1726846797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJzTQroHUo6fH3tz9KeS90mgTSfC0eOVWdyUtSQdEwY=;
        b=oH5mtSQlV9nysSj1QDK8JBkJLm79hx02bICyQzWQGS/zxxPy3b86gKfxitbx9Qh5Z9
         aS8wtYOC1ueauE6x/DZ+9nU6JiN6R+5/jkmECgsh8MUs7BQYSftJ5uI5C0jARpk8/0/l
         cZ3jGGBkRrp/O/LNqS/qf+023ALv/Kq5FJ1PwK4X+Rh14Nbv2xfjnhnlX84n+jGlnv6D
         NpvGiZTr3KVqkeTszAmMAZkc9LvFbqp5Y/mxO086ZtikK5dyMZe0WGomiNA2h+Nor7Hg
         iq+TKkQfT2P+XDvDGVtOBU1zjGp30ky+4HQK5sl/2hd3pk1wyBueZOSRyL6sJxqI2jfN
         IsGg==
X-Forwarded-Encrypted: i=1; AJvYcCVQI+W8pOTgk/mjowWmQGTLspEGiIl/G/jAqpTpJBz/MXWrHMAL+w/Gi/ECJdsaCcO1j7mk8QjYaXuxvzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJcLSmLUh4TUXkGsPb7UOBwYzHk9syS9MbGKNO+f7AMiX/NYUF
	WB069PXkoSfOs3eawuONKeo/rUmnNXX8n5d13gLf8WCbXGf+Bgkvhva3nZ3rdIWLhpb+4f41E6C
	PRmohILlQ/d31pwNqFIVvY7EaXRR5fzAK2i9d
X-Google-Smtp-Source: AGHT+IFNeCJJHp+jP8jPlCbcwArfRcQWZK97ZRZkvZ97GsIeaKLJcgIl7VM1fSNXGaUxvRlprTtclIj8cglIhRH3aW0=
X-Received: by 2002:a17:907:868e:b0:a7d:a00a:aa02 with SMTP id
 a640c23a62f3a-a90293f9003mr568351966b.1.1726241996235; Fri, 13 Sep 2024
 08:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913100941.8565-1-lulie@linux.alibaba.com>
 <CANn89iJuUFaM5whtsqA37vh6vUKUQJhgjV9Uqv6_ARpVGFjB2w@mail.gmail.com>
 <20240913142155.GA14069@linux.alibaba.com> <CANn89iL9EYX1EYLcrsXxz6dZX6eYyAi+u4uCZuYjg=y3tbgh6A@mail.gmail.com>
 <20240913150649.GB14069@linux.alibaba.com>
In-Reply-To: <20240913150649.GB14069@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Sep 2024 17:39:45 +0200
Message-ID: <CANn89iJdy1RK4UHxAtjT5MA0oyaPPw3wPoeYMEhBFPemQD4YwA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net/udp: Add 4-tuple hash for connected socket
To: dust.li@linux.alibaba.com
Cc: Philo Lu <lulie@linux.alibaba.com>, netdev@vger.kernel.org, 
	willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, antony.antony@secunet.com, 
	steffen.klassert@secunet.com, linux-kernel@vger.kernel.org, 
	jakub@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 5:07=E2=80=AFPM Dust Li <dust.li@linux.alibaba.com>=
 wrote:
>
> On 2024-09-13 16:39:33, Eric Dumazet wrote:
> >On Fri, Sep 13, 2024 at 4:22=E2=80=AFPM Dust Li <dust.li@linux.alibaba.c=
om> wrote:
> >>
> >> On 2024-09-13 13:49:03, Eric Dumazet wrote:
> >> >On Fri, Sep 13, 2024 at 12:09=E2=80=AFPM Philo Lu <lulie@linux.alibab=
a.com> wrote:
> >> >>
> >> >> This RFC patch introduces 4-tuple hash for connected udp sockets, t=
o
> >> >> make udp lookup faster. It is a tentative proposal and any comment =
is
> >> >> welcome.
> >> >>
> >> >> Currently, the udp_table has two hash table, the port hash and port=
addr
> >> >> hash. But for UDP server, all sockets have the same local port and =
addr,
> >> >> so they are all on the same hash slot within a reuseport group. And=
 the
> >> >> target sock is selected by scoring.
> >> >>
> >> >> In some applications, the UDP server uses connect() for each incomi=
ng
> >> >> client, and then the socket (fd) is used exclusively by the client.=
 In
> >> >> such scenarios, current scoring method can be ineffcient with a lar=
ge
> >> >> number of connections, resulting in high softirq overhead.
> >> >>
> >> >> To solve the problem, a 4-tuple hash list is added to udp_table, an=
d is
> >> >> updated when calling connect(). Then __udp4_lib_lookup() firstly
> >> >> searches the 4-tuple hash list, and return directly if success. A n=
ew
> >> >> sockopt UDP_HASH4 is added to enable it. So the usage is:
> >> >> 1. socket()
> >> >> 2. bind()
> >> >> 3. setsockopt(UDP_HASH4)
> >> >> 4. connect()
> >> >>
> >> >> AFAICT the patch (if useful) can be further improved by:
> >> >> (a) Support disable with sockopt UDP_HASH4. Now it cannot be disabl=
ed
> >> >> once turned on until the socket closed.
> >> >> (b) Better interact with hash2/reuseport. Now hash4 hardly affects =
other
> >> >> mechanisms, but maintaining sockets in both hash4 and hash2 lists s=
eems
> >> >> unnecessary.
> >> >> (c) Support early demux and ipv6.
> >> >>
> >> >> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> >> >
> >> >Adding a 4-tuple hash for UDP has been discussed in the past.
> >>
> >> Thanks for the information! we don't know the history.
> >>
> >> >
> >> >Main issue is that this is adding one cache line miss per incoming pa=
cket.
> >>
> >> What about adding something like refcnt in 'struct udp_hslot' ?
> >> if someone enabled uhash4 on the port, we increase the refcnt.
> >> Then we can check if that port have uhash4 enabled. If it's zero,
> >> we can just bypass the uhash4 lookup process and goto the current
> >> udp4_lib_lookup2().
> >>
> >
> >Reading anything (thus a refcnt) in 'struct udp_hslot' will need the
> >same cache line miss.
>
> hslot2->head in 'struct udp_hslot' will be read right away in
> udp4_lib_lookup2() in any case, it's just a few instructions
> later(about 20). So I think cache miss should not be a problem
> in this case.

I guess this could work.

