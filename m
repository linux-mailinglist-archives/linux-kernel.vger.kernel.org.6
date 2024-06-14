Return-Path: <linux-kernel+bounces-214407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B919083FA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A1EB2228E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F881474A3;
	Fri, 14 Jun 2024 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SzIzMKCv"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC86142658
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347643; cv=none; b=rJlWkg8mHloHRD5eLh0t4AT/u6giVxPG/+ForA2Th4D6311nBxe6Mpmzz/hz/XocHGgbx6abC8DV4OFBo4IDJ00Sxdr5jOTngUEIF7S0iY1SvW5yI5RBR6MpSDb69znIa1v3aohH+fvh7j0hjDjaWLFIqNi8nytXG+MjA+4JwOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347643; c=relaxed/simple;
	bh=zz8v+vL+REmG+S900X0JuRYT5Cftph+WpyQOWBcEdSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBEA9ttNcCNVCNxLf295ayn4CTazX6b2/3rZY8pkz13JvWxDT6QpUw+wRzzzOkT0na9VP+iyO7ObrFznj/aGzH2Sx85i53XyWqRh0bDdkQC4dg4lnyj7hVqwiWOgJbl7aluvmO4v51J7vFCz8u+p73hbMKj8XYyaEbWC9nCGpXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SzIzMKCv; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso10331a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 23:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718347639; x=1718952439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69cA3Yf8WtruWYIY2J7QK8I4+WOENuklRWzqSqmNyfY=;
        b=SzIzMKCvYTS1ZrON5nv1NxWnqJNnMGluOBOGbOv1ku7PLNAgMKpx/RYaPOJySoi+Th
         AQHydD/qwzJF5UgIPmJCXug2fe8O7opcfZ9SHnWfM9hI2fA37QY9dzA2EcgEMq+mMAQA
         zMuUexd+sMHJbDKLPe7PGusxt8eqSqPM40k7IAdXrV1lGDRU8z4S8Q77JWBW89eeXqcc
         qYVbFagXUZRvn5d3gXaAD0u7VJsY7TOnn5rUYHEfdAK3yHIelXchBTG1x+wnnLWQJ6Md
         w9Y6opN7lkMPrp0IDTXceajh3SppNm1Llmr6UJuBrDVg1BrnMMFgu3vPdTKBRw39BkdS
         lSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718347639; x=1718952439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69cA3Yf8WtruWYIY2J7QK8I4+WOENuklRWzqSqmNyfY=;
        b=YHUE+LIT5nryIKFRnxjb8rfj1y1L2lYOyBKcNZcNyPbtitjTEJu645hf0el4mjUpuZ
         3GgcEolPE6ObGsGt69TWX5UT2hrdMzq+Q0uL0D2AmSxZciUojf7EiJauUqvdHSntfnOe
         RkCJVUVq/J347rRyfMhHyyrmpRUXQkJt03rec+BEZ2OyrwRhjdR1DJit44HKx+VO0/Zo
         W5ucpGBvLTmubE9Wa9ZDhSX5rJFWYzGERnTXJulrcxMPPwwTUc1rHkZBHuWdvo77z9fP
         TdvaN2p4pej5NcpISvN3vwDEbwomih3TAun8qc/YEOjWU6Cw3NIoLo2O86VEVGYPOxda
         qifA==
X-Forwarded-Encrypted: i=1; AJvYcCW/Isk4AS/O5zNxN/XLFPgYmlIY3ovET0C8le+YBQiTz4c/Bi3haIP1kvtaf6PTOecnZ8tZkBwj0Y8jR99pfXOpCjoFEAPrAi+iQSi1
X-Gm-Message-State: AOJu0YxtFN9lhtjqRJKgRX0lDHgTd7XLLQUgqg/cjWtN4h7Ish4DlnUo
	Ioxqf/6WkAl860bk9VFIAhPZP0fViFEL3rXfEl9yTM8N320BCm3c57iyCub+6Ohl2kJEHcrtl9P
	c4db5UlI+9Cuy2Vf12SjD6SvxGPvYvuQZx3qa
X-Google-Smtp-Source: AGHT+IFnhD8o8sIGFdkO2QiD417DxPmDrN9Var3tev5g1oGRP6REzBqh/h4DhA7i5i1TgJzTspx32tVG0EshnT9Q5Zo=
X-Received: by 2002:a05:6402:34c5:b0:57c:bb0d:5e48 with SMTP id
 4fb4d7f45d1cf-57cbec62916mr119941a12.2.1718347638405; Thu, 13 Jun 2024
 23:47:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614060012.158026-1-luoxuanqiang@kylinos.cn>
In-Reply-To: <20240614060012.158026-1-luoxuanqiang@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Jun 2024 08:47:07 +0200
Message-ID: <CANn89iJBOAg+KCZBvkUxdAfTS1jacBBcrW6M5AZQvr=UPFJ0dA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Fix race for duplicate reqsk on identical SYN
To: luoxuanqiang <luoxuanqiang@kylinos.cn>, Florian Westphal <fw@strlen.de>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 8:01=E2=80=AFAM luoxuanqiang <luoxuanqiang@kylinos.=
cn> wrote:
>
> When bonding is configured in BOND_MODE_BROADCAST mode, if two identical =
SYN packets
> are received at the same time and processed on different CPUs, it can pot=
entially
> create the same sk (sock) but two different reqsk (request_sock) in tcp_c=
onn_request().
>
> These two different reqsk will respond with two SYNACK packets, and since=
 the generation
> of the seq (ISN) incorporates a timestamp, the final two SYNACK packets w=
ill have
> different seq values.
>
> The consequence is that when the Client receives and replies with an ACK =
to the earlier
> SYNACK packet, we will reset(RST) it.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This behavior is consistently reproducible in my local setup, which compr=
ises:
>
>                   | NETA1 ------ NETB1 |
> PC_A --- bond --- |                    | --- bond --- PC_B
>                   | NETA2 ------ NETB2 |
>
> - PC_A is the Server and has two network cards, NETA1 and NETA2. I have b=
onded these two
>   cards using BOND_MODE_BROADCAST mode and configured them to be handled =
by different CPU.
>
> - PC_B is the Client, also equipped with two network cards, NETB1 and NET=
B2, which are
>   also bonded and configured in BOND_MODE_BROADCAST mode.
>
> If the client attempts a TCP connection to the server, it might encounter=
 a failure.
> Capturing packets from the server side reveals:
>
> 10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [S], seq 32=
0236027,
> 10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [S], seq 32=
0236027,
> localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [S.], seq 2=
967855116,
> localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [S.], seq 2=
967855123, <=3D=3D
> 10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [.], ack 42=
94967290,
> 10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [.], ack 42=
94967290,
> localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [R], seq 29=
67855117, <=3D=3D
> localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [R], seq 29=
67855117,
>
> Two SYNACKs with different seq numbers are sent by localhost, resulting i=
n an anomaly.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The attempted solution is as follows:
> In the tcp_conn_request(), while inserting reqsk into the ehash table, it=
 also checks
> if an entry already exists. If found, it avoids reinsertion and releases =
it.
>
> Simultaneously, In the reqsk_queue_hash_req(), the start of the req->rsk_=
timer is
> adjusted to be after successful insertion.
>
> Signed-off-by: luoxuanqiang <luoxuanqiang@kylinos.cn>
> ---
>  include/net/inet_connection_sock.h |  2 +-
>  net/dccp/ipv4.c                    |  2 +-
>  net/dccp/ipv6.c                    |  2 +-
>  net/ipv4/inet_connection_sock.c    | 16 ++++++++++++----
>  net/ipv4/tcp_input.c               | 11 ++++++++++-
>  5 files changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connec=
tion_sock.h
> index 7d6b1254c92d..8773d161d184 100644
> --- a/include/net/inet_connection_sock.h
> +++ b/include/net/inet_connection_sock.h
> @@ -264,7 +264,7 @@ struct sock *inet_csk_reqsk_queue_add(struct sock *sk=
,
>                                       struct request_sock *req,
>                                       struct sock *child);
>  void inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_sock =
*req,
> -                                  unsigned long timeout);
> +                                  unsigned long timeout, bool *found_dup=
_sk);
>  struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *c=
hild,
>                                          struct request_sock *req,
>                                          bool own_req);
> diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
> index ff41bd6f99c3..13aafdeb9205 100644
> --- a/net/dccp/ipv4.c
> +++ b/net/dccp/ipv4.c
> @@ -657,7 +657,7 @@ int dccp_v4_conn_request(struct sock *sk, struct sk_b=
uff *skb)
>         if (dccp_v4_send_response(sk, req))
>                 goto drop_and_free;
>
> -       inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT);
> +       inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT, NULL);
>         reqsk_put(req);
>         return 0;
>
> diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
> index 85f4b8fdbe5e..493cdb12ce2b 100644
> --- a/net/dccp/ipv6.c
> +++ b/net/dccp/ipv6.c
> @@ -400,7 +400,7 @@ static int dccp_v6_conn_request(struct sock *sk, stru=
ct sk_buff *skb)
>         if (dccp_v6_send_response(sk, req))
>                 goto drop_and_free;
>
> -       inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT);
> +       inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT, NULL);
>         reqsk_put(req);
>         return 0;
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index d81f74ce0f02..d9394db98a5a 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1123,12 +1123,17 @@ static void reqsk_timer_handler(struct timer_list=
 *t)
>  }
>
>  static void reqsk_queue_hash_req(struct request_sock *req,
> -                                unsigned long timeout)
> +                                unsigned long timeout, bool *found_dup_s=
k)
>  {
> +
> +       inet_ehash_insert(req_to_sk(req), NULL, found_dup_sk);
> +       if(found_dup_sk && *found_dup_sk)
> +               return;
> +
> +       /* The timer needs to be setup after a successful insertion. */

I am pretty sure we had a prior attempt to fix this issue, and the fix
was problematic.

You are moving the inet_ehash_insert() before the mod_timer(), this
will add races.

Hint here is the use of TIMER_PINNED.

CCing Florian, because he just removed TIMER_PINNED for TW, he might
have the context
to properly fix this issue.

>         timer_setup(&req->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
>         mod_timer(&req->rsk_timer, jiffies + timeout);
>
> -       inet_ehash_insert(req_to_sk(req), NULL, NULL);
>         /* before letting lookups find us, make sure all req fields
>          * are committed to memory and refcnt initialized.
>          */
> @@ -1137,9 +1142,12 @@ static void reqsk_queue_hash_req(struct request_so=
ck *req,
>  }
>
>  void inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_sock =
*req,
> -                                  unsigned long timeout)
> +                                  unsigned long timeout, bool *found_dup=
_sk)
>  {
> -       reqsk_queue_hash_req(req, timeout);
> +       reqsk_queue_hash_req(req, timeout, found_dup_sk);
> +       if(found_dup_sk && *found_dup_sk)
> +               return;
> +
>         inet_csk_reqsk_queue_added(sk);
>  }
>  EXPORT_SYMBOL_GPL(inet_csk_reqsk_queue_hash_add);
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 9c04a9c8be9d..467f1b7bbd5a 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -7255,8 +7255,17 @@ int tcp_conn_request(struct request_sock_ops *rsk_=
ops,
>         } else {
>                 tcp_rsk(req)->tfo_listener =3D false;
>                 if (!want_cookie) {
> +                       bool found_dup_sk =3D false;
> +
>                         req->timeout =3D tcp_timeout_init((struct sock *)=
req);
> -                       inet_csk_reqsk_queue_hash_add(sk, req, req->timeo=
ut);
> +                       inet_csk_reqsk_queue_hash_add(sk, req, req->timeo=
ut,
> +                                                       &found_dup_sk);
> +
> +                       if(unlikely(found_dup_sk)){
> +                               reqsk_free(req);
> +                               return 0;
> +                       }
> +
>                 }
>                 af_ops->send_synack(sk, dst, &fl, req, &foc,
>                                     !want_cookie ? TCP_SYNACK_NORMAL :
> --
> 2.25.1
>

