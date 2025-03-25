Return-Path: <linux-kernel+bounces-575202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35701A6F383
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5039D16B5A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 11:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E877A254866;
	Tue, 25 Mar 2025 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pSrmThIi"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7BFEC4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902163; cv=none; b=EGBRV1z7ogyRg0W6utYrdohWJsHFMMv1lJsSLN8/mXROuOYYa+TQmP77Zu4ngj7n9w3g59FQWygyyUN4bNoHaAhAQIopdSf08hEkfF6sHmCnhLWiOSQDDIvalYQU6DCkG+eq9HfhGLti6IS076IlINbEcP0udH1d+2fQfc8H8n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902163; c=relaxed/simple;
	bh=6WZVWPjf58KWWazw9E62QrC9MrOdRIm1fEsQl3nSINQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsRZlyfGBulTfW3p7NOEayCSrAAHBaIZfX3yEwbktswQgcXtDGB4t6Sw1wtEHlzUH52X8LCYZMa1uNTJAlk9JzmlnuupUaCYYXyADam4fU1zbTPEmM9pJoFd3nBB8JfkyluzFryIC4pAec279S1RzFkjdRCXBwgtkWN3IPEl8VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pSrmThIi; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47690a4ec97so56394191cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742902160; x=1743506960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbyhxA3XTFaxP685N+ePDqAN7mdWmcuPkaS6mWbntL0=;
        b=pSrmThIiKaQ5Sk66W16iHw8T1LeXqE6K2OTZYiTq5RCw1YfqQdfN5UoIIvc3vgRYX0
         SUWVXJiddywztH71UA48ZKguPMg5uP5f0DOvH0TkrdTQ9Svg+mVM26ynIWVo2SvDyOf3
         Bf6aAfqHuBsQO7vtTey2A5478rUir3cfQbBHVTpVStcF/q8HzuLzQCIvhY2pNRMawsqA
         zOaSwwUZao8o2KWE8+2zdDOSRWLt/Nt8OlxU7YljtfkRUkW4xcGVUVD+fzoDdeuy+8UO
         rSJAWcGUbLvW6NPfAOmhMEqAFVH24NBYUpiJzgkMwevvCuk7Y7zgTBAl/FbiN/5jUUWl
         7uqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742902160; x=1743506960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbyhxA3XTFaxP685N+ePDqAN7mdWmcuPkaS6mWbntL0=;
        b=rFj/+2mCo8DrSx2VyA/MCcVPmjh3RmnJiJfSnseP5yZI9FZ/zrKF/DT3S9V35ReHaD
         sDSvYQNN4SRoplY2aIDbaOAeizLFl/RZ6597pmDJFEw7KldYgZCigjUUHfqYJshBw8O3
         cJoepKhb07D6dU0bTbN05VozSu9ljQNiQsyTiueMqRv7h/5jRpuNDUZZEccUlKiW6fCE
         Zgi3cs8zBuXlNIB3DTLSySfoa0KnBO+gRe9QMylfrMw9cpSiF9vzyp8EwX+ePUtD1sLS
         ozbnCU+5CzevU7ZxWkxyn2xF4s6dmROAROcvklRENHTqqAe8SmNmF4AioYVXF3rOGzAd
         UNNg==
X-Forwarded-Encrypted: i=1; AJvYcCU+twW574NIpMfVSuBx6pI72B1Yf9mny7ac8egUUX0/2CbqLtMAe35Wl5cCp3YKZQaACk7TOj2DZif+oLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIwCD41IDiXT8TZrxnUaK1K9+dgZ5X8DldfUD3rv7QiWb2hGRl
	k/K1NFz73IO8CsvcwWxOU2bmf4jBdslDcORuy0GZTN/l7kw68p3Ar94G3xQDKTlWQCcI5D04aKU
	yA3Vu4HKkC2RyQRNmQW7k5Coex1U2tHCZVbbJ
X-Gm-Gg: ASbGncs/q9KKur25KA2iqXnNqXnAFNfSnhqEobqmlTf1agCQSh56EZXl2xvAaMXRXqr
	S7GFscCZhtlWJUistbC+jV8JM+hPmJWuUaIwbdk+amnuvURCWwv1QZd2jv/KUp/NtJ8Y0erCtKe
	uCUx1xgnkrmAfbmz+K/XLrAGXqfiUB9ctIJpC7
X-Google-Smtp-Source: AGHT+IEDyQnLZ94AlNJpegQhgnUlz3sfVF1wukfvET4LdX4mBRW6DE6Jz986Kr/9vfULtKqKh3kQInbThoHgNzCmMrU=
X-Received: by 2002:a05:622a:4cc8:b0:477:ca3:4b66 with SMTP id
 d75a77b69052e-4771dd8037amr258935491cf.12.1742902160157; Tue, 25 Mar 2025
 04:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325110325.51958-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250325110325.51958-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Mar 2025 12:29:09 +0100
X-Gm-Features: AQ5f1JquJgSHOt9w5svVDz0NoCBP_3ax7P-tfG8AXF1s_URMWpgRwYI3O4MdasA
Message-ID: <CANn89iKxTHZ1JoQ9g9ekWq9=29LjRmhbxsnwkQ2RgPT-yCYMig@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: Support skb PAWS drop reason when TIME-WAIT
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuniyu@amazon.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dsahern@kernel.org, ncardwell@google.com, mrpre@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 12:03=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
> PAWS is a long-standing issue, especially when there are upstream network
> devices, making it more prone to occur.
>
> Currently, packet loss statistics for PAWS can only be viewed through MIB=
,
> which is a global metric and cannot be precisely obtained through tracing
> to get the specific 4-tuple of the dropped packet. In the past, we had to
> use kprobe ret to retrieve relevant skb information from
> tcp_timewait_state_process().
>
> We add a drop_reason pointer, similar to what previous commit does:
> commit e34100c2ecbb ("tcp: add a drop_reason pointer to tcp_check_req()")
>
> This commit addresses the PAWSESTABREJECTED case and also sets the
> corresponding drop reason.
>
> We use 'pwru' to test.
>
> Before this commit:
> ''''
> ./pwru 'port 9999'
> 2025/03/24 13:46:03 Listening for events..
> TUPLE                                        FUNC
> 172.31.75.115:12345->172.31.75.114:9999(tcp) sk_skb_reason_drop(SKB_DROP_=
REASON_NOT_SPECIFIED)
> '''
>
> After this commit:
> '''
> ./pwru 'port 9999'
> 2025/03/24 16:06:59 Listening for events..
> TUPLE                                        FUNC
> 172.31.75.115:12345->172.31.75.114:9999(tcp) sk_skb_reason_drop(SKB_DROP_=
REASON_TCP_RFC7323_PAWS)
> '''
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> My apologize.
> I struggled for a long time to get packetdrill to fix the client port, bu=
t
> ultimately failed to do so, which is why I couldn't provide a packetdrill
> script.
> Instead, I wrote my own program to trigger PAWS, which can be found at
> https://github.com/mrpre/nettrigger/tree/main
> ---
>  include/net/tcp.h        | 3 ++-
>  net/ipv4/tcp_ipv4.c      | 2 +-
>  net/ipv4/tcp_minisocks.c | 7 +++++--
>  net/ipv6/tcp_ipv6.c      | 2 +-
>  4 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index f8efe56bbccb..e1574e804530 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -427,7 +427,8 @@ enum tcp_tw_status {
>  enum tcp_tw_status tcp_timewait_state_process(struct inet_timewait_sock =
*tw,
>                                               struct sk_buff *skb,
>                                               const struct tcphdr *th,
> -                                             u32 *tw_isn);
> +                                             u32 *tw_isn,
> +                                             enum skb_drop_reason *drop_=
reason);
>  struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
>                            struct request_sock *req, bool fastopen,
>                            bool *lost_race, enum skb_drop_reason *drop_re=
ason);
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 1cd0938d47e0..a9dde473a23f 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -2417,7 +2417,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
>                 goto csum_error;
>         }
>
> -       tw_status =3D tcp_timewait_state_process(inet_twsk(sk), skb, th, =
&isn);
> +       tw_status =3D tcp_timewait_state_process(inet_twsk(sk), skb, th, =
&isn, &drop_reason);
>         switch (tw_status) {
>         case TCP_TW_SYN: {
>                 struct sock *sk2 =3D inet_lookup_listener(net,
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index fb9349be36b8..d16dfd41397e 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -97,7 +97,8 @@ static void twsk_rcv_nxt_update(struct tcp_timewait_soc=
k *tcptw, u32 seq,
>   */
>  enum tcp_tw_status
>  tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff=
 *skb,
> -                          const struct tcphdr *th, u32 *tw_isn)
> +                          const struct tcphdr *th, u32 *tw_isn,
> +                          enum skb_drop_reason *drop_reason)
>  {
>         struct tcp_timewait_sock *tcptw =3D tcp_twsk((struct sock *)tw);
>         u32 rcv_nxt =3D READ_ONCE(tcptw->tw_rcv_nxt);
> @@ -245,8 +246,10 @@ tcp_timewait_state_process(struct inet_timewait_sock=
 *tw, struct sk_buff *skb,
>                 return TCP_TW_SYN;
>         }
>
> -       if (paws_reject)
> +       if (paws_reject) {
> +               *drop_reason =3D SKB_DROP_REASON_TCP_RFC7323_PAWS;
>                 __NET_INC_STATS(twsk_net(tw), LINUX_MIB_PAWSESTABREJECTED=
);

I think we should add a new SNMP value and drop reason for TW sockets.

SNMP_MIB_ITEM("PAWSTimewait", LINUX_MIB_PAWSTIMEWAIT),

and SKB_DROP_REASON_TCP_RFC7323_TW_PAWS ?

