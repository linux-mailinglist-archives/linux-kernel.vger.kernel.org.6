Return-Path: <linux-kernel+bounces-335640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8B197E873
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52AD11C211D3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69212194A7C;
	Mon, 23 Sep 2024 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kDSjEQYZ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9F950271
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083202; cv=none; b=r794nl3z69a6MeG+kR7fnwDQ50h0Tn5YKTJUMTxrW3OOC1rcO3jbHJrdnro4p/gDlZo7ekXG7u3oceYeuhRi38PyhipAtTwx0k6tjV+61nHxywBaXyMVKR0aZM1Pqc7JUXFCUcckduLIQZCx5vqGvQa1bryVuFBF6Fc9vVwljNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083202; c=relaxed/simple;
	bh=iPtRYB/LqCytKHM32+OQ8AdBPW3ClXy8CMzRFDtzSLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwFGfA5gEwCN/RkpHgM1AMZUN+Z4Yml3+BHXPB8xr3Vc+HlqBxpgC1VKNQSNOeezVCTsDLGrC6tRsSLIoEmUeaSaiGix8pDBwmxX33Mj1wqM6UEJtlZ9yIEeMaK0Fsmw+OkCCvh7CJxUlb2CHyC7qv7VVs21E+i95XKHqLyGCo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kDSjEQYZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c5b954c359so1855099a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727083198; x=1727687998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50QhRYJxF2LLsaiQzLXYgzKPJK6ZVc0edpL3DG4dqpE=;
        b=kDSjEQYZSdjnjoPSfhqYJNQRaowYwd4OwxXvyaKfOqVuf3D20FZft0S3kUb+blZcyr
         v9vr4Fbn4n/Usb5CbeM9Tlb1kgkue6eOiXFd/HK3ywafnYHuAeDBjbNMJTKS7L2vCFwX
         Vrw4cX1SYkacZc0cnfu1vAIf7i2vGmT4CiDfK836+fNV5eFM6ajg62B6iYhqIfuL8imw
         27AXfOncQBRenLMN2NHaNLl43lSTX+prKmvx2PGQ0itOZpHOBBwBkmTCNhY8h75yypFl
         ajprdRx8oh66EinebbPvnLdTxIAaOcWZGJy8v3tavbYhxBdJEINOeKpB90ZD2RHUM0IZ
         3tTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727083198; x=1727687998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50QhRYJxF2LLsaiQzLXYgzKPJK6ZVc0edpL3DG4dqpE=;
        b=oWK4j0Jd+jqZVpgI4eGsJXVxXT7MBfvM+s7ImsFuGqkSzwijD4VceeWpMYXydKY8R/
         34uea8ytwcUujV8M/J6eZNGDOcTJcVfhTw8W79qGN+/xaG5xpZ7F+rk9XwVjsKCjTOS9
         qP/omjfJgMkn5NARiUdmeB/nTmBOspsDllI8onl4pXV/c/Jvo8+qN8b2Qbmc0e1DfZcc
         K4DpM/oNpap+Q8+jCSolTJt+JdfGnV10A14MjMGNOSeHTMco9RwTgpn/sD4TBlJAcXJx
         fkzbja5XjeBzGs0rtfGg9JwdcGIsWAnuUXMbs/u+ZNaR3uhihZPvUJrJ6EBeiTG5Ubu/
         UGhg==
X-Forwarded-Encrypted: i=1; AJvYcCUQD62l1oZLJUTOkepbuSaAgCMKdAgzxf2Ao5Lp7jCuhDqfAcv1MZPeMopaoAZs0dx4MbSCaqUTziXMXPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw27oZX49v3TCBilIEr6ZB4LuGg5Pzc/ymokf6MdTdD3MWAVvG
	9UVG7QWfdsp5PdO8J5MwnjfwEixctob0d6eXgIrzVZ1h1QqCuceFpSOWB/OVUP4d5dNqsrkCBmb
	HeUlDbx0PE3q1x3Dw4nU0bVMuIyOuRfMWm4U+
X-Google-Smtp-Source: AGHT+IG2qjD29Fnuf5e1NFxZLuXvlLw5kg4gzXu/PNBg2FIN5a3SnyzvI9X8SCH4XeH1eVCY6R89nezYQNBmQbfFlxM=
X-Received: by 2002:a50:8d8c:0:b0:5c2:439e:d6cb with SMTP id
 4fb4d7f45d1cf-5c464a3e204mr7702080a12.12.1727083197837; Mon, 23 Sep 2024
 02:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913100941.8565-1-lulie@linux.alibaba.com>
 <CANn89iJuUFaM5whtsqA37vh6vUKUQJhgjV9Uqv6_ARpVGFjB2w@mail.gmail.com> <dd4ff273-2227-4e5a-ba11-2ca79035b811@linux.alibaba.com>
In-Reply-To: <dd4ff273-2227-4e5a-ba11-2ca79035b811@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Sep 2024 11:19:44 +0200
Message-ID: <CANn89i+vszCZ9CBJJmatuoF+N9mPhQz8YtNTSdKH8bJRtQdKXw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] net/udp: Add 4-tuple hash for connected socket
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	antony.antony@secunet.com, steffen.klassert@secunet.com, 
	linux-kernel@vger.kernel.org, dust.li@linux.alibaba.com, jakub@cloudflare.com, 
	fred.cc@alibaba-inc.com, yubing.qiuyubing@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 10:40=E2=80=AFAM Philo Lu <lulie@linux.alibaba.com>=
 wrote:
>
> Hi Eric, sorry for the late response.
>
> On 2024/9/13 19:49, Eric Dumazet wrote:
> > On Fri, Sep 13, 2024 at 12:09=E2=80=AFPM Philo Lu <lulie@linux.alibaba.=
com> wrote:
> >>
> >> This RFC patch introduces 4-tuple hash for connected udp sockets, to
> >> make udp lookup faster. It is a tentative proposal and any comment is
> >> welcome.
> >>
> >> Currently, the udp_table has two hash table, the port hash and portadd=
r
> >> hash. But for UDP server, all sockets have the same local port and add=
r,
> >> so they are all on the same hash slot within a reuseport group. And th=
e
> >> target sock is selected by scoring.
> >>
> >> In some applications, the UDP server uses connect() for each incoming
> >> client, and then the socket (fd) is used exclusively by the client. In
> >> such scenarios, current scoring method can be ineffcient with a large
> >> number of connections, resulting in high softirq overhead.
> >>
> >> To solve the problem, a 4-tuple hash list is added to udp_table, and i=
s
> >> updated when calling connect(). Then __udp4_lib_lookup() firstly
> >> searches the 4-tuple hash list, and return directly if success. A new
> >> sockopt UDP_HASH4 is added to enable it. So the usage is:
> >> 1. socket()
> >> 2. bind()
> >> 3. setsockopt(UDP_HASH4)
> >> 4. connect()
> >>
> >> AFAICT the patch (if useful) can be further improved by:
> >> (a) Support disable with sockopt UDP_HASH4. Now it cannot be disabled
> >> once turned on until the socket closed.
> >> (b) Better interact with hash2/reuseport. Now hash4 hardly affects oth=
er
> >> mechanisms, but maintaining sockets in both hash4 and hash2 lists seem=
s
> >> unnecessary.
> >> (c) Support early demux and ipv6.
> >>
> >> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
> >
> > Adding a 4-tuple hash for UDP has been discussed in the past.
> >
> > Main issue is that this is adding one cache line miss per incoming pack=
et.
> >
>
> Thanks to Dust's idea, we can create a new field for hslot2 (or create a
> new struct for hslot2), indicating whether there are connected sockets
> in this hslot (i.e., local port and local address), and run hash4 lookup
> only when it's true. Then there would be no cache line miss.
>
> The detailed patch is attached below.
>
> > Most heavy duty UDP servers (DNS, QUIC), use non connected sockets,
> > because having one million UDP sockets has huge kernel memory cost,
> > not counting poor cache locality.
>
> Some of our applications do use connected UDP sockets (~10,000 conns),
> and will get significant benefits from hash4. We use connect() to
> separate receiving sockets and listening ones, and then it's easier to
> manage them (just like TCP), especially during live-upgrading, such as
> nginx reload. Besides, I believe hash4 is harmless to those servers
> without connected sockets.
>
> Suggestions are always welcome, and I'll keep improving this patch.
>
> Thanks.
>
> ---
>   include/net/udp.h |  3 +++
>   net/ipv4/udp.c    | 17 ++++++++++++-----
>   2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/udp.h b/include/net/udp.h
> index a05d79d35fbba..bec04c0e753d0 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -54,11 +54,14 @@ struct udp_skb_cb {
>    *
>    *    @head:  head of list of sockets
>    *    @count: number of sockets in 'head' list
> + *     @hash4_cnt: number of sockets in 'hash4' table of the same (local
> port, local address),
> + *                 Only used by hash2.
>    *    @lock:  spinlock protecting changes to head/count
>    */
>   struct udp_hslot {
>         struct hlist_head       head;
>         int                     count;
> +       u32                     hash4_cnt;
>         spinlock_t              lock;
>   } __attribute__((aligned(2 * sizeof(long))));

This would double the size of this structure (from 16 to 32 bytes)

Perhaps add another 'struct udp_hslot_main' for the relevant hash table,
and keep the smaller 'struct udp_hslot' for the two others.

Current cumulative size of the hash tables is 2 MB.

Alternatively we could move the locks out of the structure, this is
not used in the fast path.

