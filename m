Return-Path: <linux-kernel+bounces-260896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C383C93AFE9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515501F22F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C181152180;
	Wed, 24 Jul 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fR4eHzED"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F861509A4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721817365; cv=none; b=eDmfZ6Jvwem/MIKkUohS5Z7hsYXM9y2aoH9Y+HbhnGCyFjS/LcbNrOzPjEXGIFP9Hr2KZMpiqBQeEC1ZHP6IpdKSVJFOTlUBDbQzqIZy2ceLIECasY4NUKrym82ry0hdDo2onQJnMHEpPa+B7E6zJ5U5NjCJb3WybN8WmQtiFt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721817365; c=relaxed/simple;
	bh=O6vjbx2GDH4VAYilRfk8maQQqQwuV7meGtlS81k1ok8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzu9gmcF0dhRHKcRIBoB3EBLFoNfjwF39FCOeFARjxppRd4M8USnojRzswYfOre6V5sxSxnd5h+iYiWzBeJTIr7pdlLD5vSHZYCl58SwTgBz1m0QjWOIKIF+qCkoM09fq3uhCgEY0cFB7PDpmb60Ek11eCRzsXGhVtwNLEywEiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fR4eHzED; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so11752a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 03:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721817362; x=1722422162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ousfKxhx+XutxhMDlN6drqCq9yWFYE8n1t3G/0pQAY4=;
        b=fR4eHzEDKJKhRDUa76GWAkg1p2s1EpOsaLkvH0TQHWEBVYYIxh8k9P8FyQKujvsuQD
         YrAocfYS4ov5Wfb+FT2cGDfamKiICNo5qNX2xVia/hl8eDohQRJ4xYfuM/hvt+RbA4S2
         pahQX54UR5hA2XlFrxVIq5dnKZKA3TzJGGd3C3VJzWASwJEzcwLiL5T2a8IPEazj6XMY
         yBqZH4IQm7eWcjQj+Pek78W1HSUX0WSjOSz82g9ol57up6HqwXyB6qcgd3+XgSmU2zy2
         9Sazst5Iyx5iL9Oi705V2gM215u8QLwCe8qCQ7axj9zyOVLCPaUGHd0f/eEpEjD6zsf7
         1Pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721817362; x=1722422162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ousfKxhx+XutxhMDlN6drqCq9yWFYE8n1t3G/0pQAY4=;
        b=qWFKplt65k+ENcJJB0Z5qBtvOLvzvqIhlaMHx3eWLQJCwHu25w9WWu/k69k0wPoVMf
         QN9bExKuos3B+/lUFBep9INAZCNcFXB1unSzMprLF+c4qckU3hKqPVdCosiJYnl+cCoj
         M284ROzkmspShhKEodaZl9amhXcu7ZghQL3eql4T6+d4MG5D+8oyJVin8XfkORiuqLz9
         GpyF3t6956kLxr/uhyjvPmeGgu5cheyIoNvyJ/4f2gwn5bhi9hlRksC4ubUnm7x1zGZA
         ENPkk8TA6opSqauj5sdsr8hIdAuF3RvoWCUgQYcOSWpPRX3eHhfnuHIGhQ0WjFrGp4Nc
         8hYw==
X-Forwarded-Encrypted: i=1; AJvYcCVGkzNh0IQ+sZ8Y9XJza+QOoLVkJX1SlgJyxfijAAbpuHJ4NpBxf6YbY7QfvdrBpofKRAcpwHUUAsl+SRLf60K1KFQH3DA8CdOCnB4I
X-Gm-Message-State: AOJu0YxN90thodi4Jcd15s221I212aIMuUv1TqbHFZoTuZpbtIxBBbQ+
	ELZbxc/H2aKZstsm8esrgsl4Upuvub8HKqAvSD59+i1PF6mNmoIezgyAnxTKIS0ojFO0bszvlmd
	bRZtK02LQWhE64/mmxdWmyFMv2SIiT+FK1dpY
X-Google-Smtp-Source: AGHT+IE2UVOVTpAlrBj6qDLRJHI/efrh0NOisoQWTce2uyvbySR2MiI9a/47VDNXNTBkv9lMRW7GxrzOqZButaluidQ=
X-Received: by 2002:a05:6402:2554:b0:58b:93:b623 with SMTP id
 4fb4d7f45d1cf-5aacc18da2dmr198040a12.5.1721817361344; Wed, 24 Jul 2024
 03:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v3-1-d48339764ce9@kernel.org>
In-Reply-To: <20240724-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v3-1-d48339764ce9@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jul 2024 12:35:47 +0200
Message-ID: <CANn89i+N578sZBjGtKs1CCU5WGudF-z+g0C4T-MHg751ykYZBQ@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: process the 3rd ACK with sk_socket for TFO/MPTCP
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 12:25=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> The 'Fixes' commit recently changed the behaviour of TCP by skipping the
> processing of the 3rd ACK when a sk->sk_socket is set. The goal was to
> skip tcp_ack_snd_check() in tcp_rcv_state_process() not to send an
> unnecessary ACK in case of simultaneous connect(). Unfortunately, that
> had an impact on TFO and MPTCP.
>
> I started to look at the impact on MPTCP, because the MPTCP CI found
> some issues with the MPTCP Packetdrill tests [1]. Then Paolo Abeni
> suggested me to look at the impact on TFO with "plain" TCP.
>
> For MPTCP, when receiving the 3rd ACK of a request adding a new path
> (MP_JOIN), sk->sk_socket will be set, and point to the MPTCP sock that
> has been created when the MPTCP connection got established before with
> the first path. The newly added 'goto' will then skip the processing of
> the segment text (step 7) and not go through tcp_data_queue() where the
> MPTCP options are validated, and some actions are triggered, e.g.
> sending the MPJ 4th ACK [2] as demonstrated by the new errors when
> running a packetdrill test [3] establishing a second subflow.
>
> This doesn't fully break MPTCP, mainly the 4th MPJ ACK that will be
> delayed. Still, we don't want to have this behaviour as it delays the
> switch to the fully established mode, and invalid MPTCP options in this
> 3rd ACK will not be caught any more. This modification also affects the
> MPTCP + TFO feature as well, and being the reason why the selftests
> started to be unstable the last few days [4].
>
> For TFO, the existing 'basic-cookie-not-reqd' test [5] was no longer
> passing: if the 3rd ACK contains data, and the connection is accept()ed
> before receiving them, these data would no longer be processed, and thus
> not ACKed.
>
> One last thing about MPTCP, in case of simultaneous connect(), a
> fallback to TCP will be done, which seems fine:
>
>   `../common/defaults.sh`
>
>    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_MPTCP) =3D 3
>   +0 connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in progress)
>
>   +0 > S  0:0(0)                 <mss 1460, sackOK, TS val 100 ecr 0,   n=
op, wscale 8, mpcapable v1 flags[flag_h] nokey>
>   +0 < S  0:0(0) win 1000        <mss 1460, sackOK, TS val 407 ecr 0,   n=
op, wscale 8, mpcapable v1 flags[flag_h] nokey>
>   +0 > S. 0:0(0) ack 1           <mss 1460, sackOK, TS val 330 ecr 0,   n=
op, wscale 8, mpcapable v1 flags[flag_h] nokey>
>   +0 < S. 0:0(0) ack 1 win 65535 <mss 1460, sackOK, TS val 700 ecr 100, n=
op, wscale 8, mpcapable v1 flags[flag_h] key[skey=3D2]>
>   +0 >  . 1:1(0) ack 1           <nop, nop, TS val 845707014 ecr 700, nop=
, nop, sack 0:1>
>
> Simultaneous SYN-data crossing is also not supported by TFO, see [6].
>
> Kuniyuki Iwashima suggested to restrict the processing to SYN+ACK only:
> that's a more generic solution than the one initially proposed, and
> also enough to fix the issues described above.
>
> Later on, Eric Dumazet mentioned that an ACK should still be sent in
> reaction to the second SYN+ACK that is received: not sending a DUPACK
> here seems wrong and could hurt:
>
>    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) =3D 3
>   +0 connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in progress)
>
>   +0 > S  0:0(0)                <mss 1460, sackOK, TS val 1000 ecr 0,nop,=
wscale 8>
>   +0 < S  0:0(0)       win 1000 <mss 1000, sackOK, nop, nop>
>   +0 > S. 0:0(0) ack 1          <mss 1460, sackOK, TS val 3308134035 ecr =
0,nop,wscale 8>
>   +0 < S. 0:0(0) ack 1 win 1000 <mss 1000, sackOK, nop, nop>
>   +0 >  . 1:1(0) ack 1          <nop, nop, sack 0:1>  // <=3D=3D Here
>
> So in this version, the 'goto consume' is dropped, to always send an ACK
> when switching from TCP_SYN_RECV to TCP_ESTABLISHED. This ACK will be
> seen as a DUPACK -- with DSACK if SACK has been negotiated -- in case of
> simultaneous SYN crossing: that's what is expected here.
>
> Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/993622=
7696 [1]
> Link: https://datatracker.ietf.org/doc/html/rfc8684#fig_tokens [2]
> Link: https://github.com/multipath-tcp/packetdrill/blob/mptcp-net-next/gt=
ests/net/mptcp/syscalls/accept.pkt#L28 [3]
> Link: https://netdev.bots.linux.dev/contest.html?executor=3Dvmksft-mptcp-=
dbg&test=3Dmptcp-connect-sh [4]
> Link: https://github.com/google/packetdrill/blob/master/gtests/net/tcp/fa=
stopen/server/basic-cookie-not-reqd.pkt#L21 [5]
> Link: https://github.com/google/packetdrill/blob/master/gtests/net/tcp/fa=
stopen/client/simultaneous-fast-open.pkt [6]
> Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous connect().=
")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thanks a lot !

Reviewed-by: Eric Dumazet <edumazet@google.com>

