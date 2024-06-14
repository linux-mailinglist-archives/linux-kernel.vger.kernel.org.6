Return-Path: <linux-kernel+bounces-214653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E03BD9087B9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2929FB20F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E296C192B76;
	Fri, 14 Jun 2024 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l9/VVQmb"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EC01922F7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358111; cv=none; b=aF9N3cUgKAgrHOGYV87cXNyC9ojMMoUFJaUNC4dU5McqKWzob3YvVNg/raGO5/N4FPAv8Q6c51w4kp8fW202yM8YUwT4k7pqeJpkQ6RD1nqt6hsI8HaBi863V0H9nJiTu1VyXBfXCJTE1lk7lKHEwVykwEOCJxTJVQVO5KFWhYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358111; c=relaxed/simple;
	bh=27m9KbrM6RX2z4bV1hqcRdxKLkTdsNhAupmWLyDR5XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YR+DGcbxaTaJUnc1AJdLpMbsVYgSsNyivMv2ODgKMJ3d8IPp3dT9wfslFsUa3wnUZXmE0WjB38URAqzx2wW3ILDq3XKe/+H8Gxwhgv+WFEAyRHMoi102BfQN1asx7CTwgqcjGMtkLyirtH+FK1m2ixzAYcReLs7BtM5R9xNV+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l9/VVQmb; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57c8bd6b655so11935a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 02:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718358106; x=1718962906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ysi8fyuuAaKbNGhiz+HyTQTjjMLyr9HOsE9G9mM9GAA=;
        b=l9/VVQmbdB2bqdJgu0yO7XkvjP1MMk08j9ZigYG1i2kNAUcGDlf6M2AyIuMNjBITTU
         dRUWpjVk2l+zkQcbRPHUJXcJl6CzMT4D0Sv2aQn++ZAAU9Dv7jr/gGDrEW0Ac4p5SBEc
         W3ds2QBbbdIZLvYIcD9wkvmN8Kw9jZu/lpPTZ7TsrJrjByK5MIcapmce3xuVOM5/okGR
         rLqwsHqGd6Vox74kqEJwN8Rb/WXvsKfnNjBovcrfqTpxk7j1u0I/YH2vSBeJyy5STNXz
         KrD0LhxO81whezgTAp3PGpoQAup4CVI0085GeOSDAvJnjvih3YJ9X/tottyHKEZKXRX6
         tcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358106; x=1718962906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ysi8fyuuAaKbNGhiz+HyTQTjjMLyr9HOsE9G9mM9GAA=;
        b=HWGleLinM7H4ZLX+jnY4M+sKTLmSAF/3uBDgVFL3YCdfXGAWfjpM8OF1gF8xN5R2Jb
         xA0Vwouj+bjZg7zoMGl4a0s7uJZ0elw8oH4tr1rOaDtfakLIx/Fn/rRI72juP2AGNgIl
         ej5+8/qLL2pB8ROkEfy8+2nuWd7AE1+NknrebFdVRirXdGlJP6gr5na4wfopboHxTFna
         8fRvLqLuGFk7+BRKPKc5S+vf6ZNZYiBfaphYtIgDJRkNo00bf1lRnfvsrhydO3wFHljd
         K5Ksdo6wLJWMFjYOuJQqWmOd7AcA2zxnQTQcbC8z+dnWOwRTNRDiZtc+L7sVe3b/qrM9
         5tYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2QTtovXOuxvAxpwjSt1vAVJ1vZNJyzbc+BmSUPaA+nNBSkwsRfvpR6n4yjXnkncu2nIQi3gtDHgpKbgW0B2xNCQ1YdDE36vrcN4/d
X-Gm-Message-State: AOJu0YxBhsXskbTxoSiz1QSzeh6wVfcIVFCCKyLYe8m2z3236J8xzGEc
	q1lXyqtBys1Q7aP1AZUkO6/66iVv213tNTk5EsAvzEP88U8gOKb+AuX/caI7HkZ21JaJHcZWiYp
	M88Uo85w6xLXA3kXNPu/Ng8pgsTjSCzj6T7iW
X-Google-Smtp-Source: AGHT+IGmFi3s4C2mC73QSE+yE2YSXzjIRpnwQqIFqBILGvgS+nMftoxKjHKl1nOZX0majMiA6W92bATd+KDatew9kVU=
X-Received: by 2002:a05:6402:26cf:b0:57c:b3c3:32bb with SMTP id
 4fb4d7f45d1cf-57cc0a5b1afmr119006a12.1.1718358105925; Fri, 14 Jun 2024
 02:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJBOAg+KCZBvkUxdAfTS1jacBBcrW6M5AZQvr=UPFJ0dA@mail.gmail.com>
 <20240614060012.158026-1-luoxuanqiang@kylinos.cn> <666c066e.630a0220.98be4.aba1SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <666c066e.630a0220.98be4.aba1SMTPIN_ADDED_BROKEN@mx.google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Jun 2024 11:41:32 +0200
Message-ID: <CANn89iJDcJmT6GfrPRvkt-BBfwHDhssDDMF=5JZMOCRrhxm5bQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Fix race for duplicate reqsk on identical SYN
To: luoxuanqiang <luoxuanqiang@kylinos.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, fw@strlen.de, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 10:59=E2=80=AFAM luoxuanqiang <luoxuanqiang@kylinos=
.cn> wrote:
>
> On Fri, Jun 14, 2024 at 8:01=E2=80=AFAM luoxuanqiang <luoxuanqiang@kylino=
s.cn> wrote:
> >>
> >> When bonding is configured in BOND_MODE_BROADCAST mode, if two identic=
al SYN packets
> >> are received at the same time and processed on different CPUs, it can =
potentially
> >> create the same sk (sock) but two different reqsk (request_sock) in tc=
p_conn_request().
> >>
> >> These two different reqsk will respond with two SYNACK packets, and si=
nce the generation
> >> of the seq (ISN) incorporates a timestamp, the final two SYNACK packet=
s will have
> >> different seq values.
> >>
> >> The consequence is that when the Client receives and replies with an A=
CK to the earlier
> >> SYNACK packet, we will reset(RST) it.
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> This behavior is consistently reproducible in my local setup, which co=
mprises:
> >>
> >>                   | NETA1 ------ NETB1 |
> >> PC_A --- bond --- |                    | --- bond --- PC_B
> >>                   | NETA2 ------ NETB2 |
> >>
> >> - PC_A is the Server and has two network cards, NETA1 and NETA2. I hav=
e bonded these two
> >>   cards using BOND_MODE_BROADCAST mode and configured them to be handl=
ed by different CPU.
> >>
> >> - PC_B is the Client, also equipped with two network cards, NETB1 and =
NETB2, which are
> >>   also bonded and configured in BOND_MODE_BROADCAST mode.
> >>
> >> If the client attempts a TCP connection to the server, it might encoun=
ter a failure.
> >> Capturing packets from the server side reveals:
> >>
> >> 10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [S], seq=
 320236027,
> >> 10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [S], seq=
 320236027,
> >> localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [S.], se=
q 2967855116,
> >> localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [S.], se=
q 2967855123, <=3D=3D
> >> 10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [.], ack=
 4294967290,
> >> 10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [.], ack=
 4294967290,
> >> localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [R], seq=
 2967855117, <=3D=3D
> >> localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [R], seq=
 2967855117,
> >>
> >> Two SYNACKs with different seq numbers are sent by localhost, resultin=
g in an anomaly.
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> The attempted solution is as follows:
> >> In the tcp_conn_request(), while inserting reqsk into the ehash table,=
 it also checks
> >> if an entry already exists. If found, it avoids reinsertion and releas=
es it.
> >>
> >> Simultaneously, In the reqsk_queue_hash_req(), the start of the req->r=
sk_timer is
> >> adjusted to be after successful insertion.
> >>
> >> Signed-off-by: luoxuanqiang <luoxuanqiang@kylinos.cn>
> >> ---
> >>  include/net/inet_connection_sock.h |  2 +-
> >>  net/dccp/ipv4.c                    |  2 +-
> >>  net/dccp/ipv6.c                    |  2 +-
> >>  net/ipv4/inet_connection_sock.c    | 16 ++++++++++++----
> >>  net/ipv4/tcp_input.c               | 11 ++++++++++-
> >>  5 files changed, 25 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_con=
nection_sock.h
> >> index 7d6b1254c92d..8773d161d184 100644
> >> --- a/include/net/inet_connection_sock.h
> >> +++ b/include/net/inet_connection_sock.h
> >> @@ -264,7 +264,7 @@ struct sock *inet_csk_reqsk_queue_add(struct sock =
*sk,
> >>                                       struct request_sock *req,
> >>                                       struct sock *child);
> >>  void inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_so=
ck *req,
> >> -                                  unsigned long timeout);
> >> +                                  unsigned long timeout, bool *found_=
dup_sk);
> >>  struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock=
 *child,
> >>                                          struct request_sock *req,
> >>                                          bool own_req);
> >> diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
> >> index ff41bd6f99c3..13aafdeb9205 100644
> >> --- a/net/dccp/ipv4.c
> >> +++ b/net/dccp/ipv4.c
> >> @@ -657,7 +657,7 @@ int dccp_v4_conn_request(struct sock *sk, struct s=
k_buff *skb)
> >>         if (dccp_v4_send_response(sk, req))
> >>                 goto drop_and_free;
> >>
> >> -       inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT);
> >> +       inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT, NULL=
);
> >>         reqsk_put(req);
> >>         return 0;
> >>
> >> diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
> >> index 85f4b8fdbe5e..493cdb12ce2b 100644
> >> --- a/net/dccp/ipv6.c
> >> +++ b/net/dccp/ipv6.c
> >> @@ -400,7 +400,7 @@ static int dccp_v6_conn_request(struct sock *sk, s=
truct sk_buff *skb)
> >>         if (dccp_v6_send_response(sk, req))
> >>                 goto drop_and_free;
> >>
> >> -       inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT);
> >> +       inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT, NULL=
);
> >>         reqsk_put(req);
> >>         return 0;
> >>
> >> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connectio=
n_sock.c
> >> index d81f74ce0f02..d9394db98a5a 100644
> >> --- a/net/ipv4/inet_connection_sock.c
> >> +++ b/net/ipv4/inet_connection_sock.c
> >> @@ -1123,12 +1123,17 @@ static void reqsk_timer_handler(struct timer_l=
ist *t)
> >>  }
> >>
> >>  static void reqsk_queue_hash_req(struct request_sock *req,
> >> -                                unsigned long timeout)
> >> +                                unsigned long timeout, bool *found_du=
p_sk)
> >>  {
> >> +
> >> +       inet_ehash_insert(req_to_sk(req), NULL, found_dup_sk);
> >> +       if(found_dup_sk && *found_dup_sk)
> >> +               return;
> >> +
> >> +       /* The timer needs to be setup after a successful insertion. *=
/
> >
> >I am pretty sure we had a prior attempt to fix this issue, and the fix
> >was problematic.
> >
> >You are moving the inet_ehash_insert() before the mod_timer(), this
> >will add races.
> Could you kindly explain what "races" refer to here? Thank you!


Hmmm... maybe this is ok. Please respin your patch after fixing
checkpatch issues, and add a 'net' tag

( See https://patchwork.kernel.org/project/netdevbpf/patch/20240614060012.1=
58026-1-luoxuanqiang@kylinos.cn/
for all warnings / fails)

Please CC Kuniyuki Iwashima <kuniyu@amazon.com> because I will be OOO
for about 4 days.

