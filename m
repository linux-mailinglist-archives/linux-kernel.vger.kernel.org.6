Return-Path: <linux-kernel+bounces-298318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A2E95C5B0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A45D3B20937
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8AA1311AC;
	Fri, 23 Aug 2024 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lhbUEFP8"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F57640D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395336; cv=none; b=DZLBisOiISUXyY/LQDAvhiNDMTbE2qjFbWYoni4XNQKWt8OLlDBmVFS08QhyNIx34MG7MyutBenL21ay0W4ZxHYRnhPxE76bebktEpiv6iWlyyBP9wVZH0Fozb0xT7vesDRyc27HOZxx3P63d/34uUHMRj3d1J5Ssa8/PR8+zEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395336; c=relaxed/simple;
	bh=aZ+Pc5A6AiinR1ETMNmdwRxwZ/AvAX8duSgVHLOCnoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gfza0/1JVnPRK/hEh3BfoLaPkGqtNhZtXNrpRwiRl18b52P7xukP0Vd9OgLpm/7u9ktEPGL0avRSczrJMutMhWqYYhi2WONCI5WdSoOlnwffYaJ9UbzcRRPMWKdNQ6cHzw4ecxPdhGF+/5dvZD0bXnJkON51CAn3o/DBIeg4FQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lhbUEFP8; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8677ae5a35so197606466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 23:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724395333; x=1725000133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOio/RmcuQG9BgjNc9a/NdU3H7nYqTOjqoml5zYuQE0=;
        b=lhbUEFP8/E3E+BoADjRA0dLNWrjhBikTSp2KDMMPkmBjDMX50UeYs88QClFIA2NnzU
         4n7PyAnBF/lCXmsFvRwROarVS6Y55eHBmX9hInTl297s9qbm3CjadZHHDWR1omDcfd9k
         Qxhee4Xy91oN0ZBEZI4RF+aedBBuWyD1JVaBPtqE2DrCRbPSvK/w8atPNnvmqngQmAUk
         xGCUN5cyLrZF2uZ6iWcxfDecZhfzQPnqTsYYwT/LTYR7vpRQynij2DJdhiqAE+LadiUw
         bJFLkAjXp8enTz0ZAiNjAuqLohnYSDwCK/snSvW1fedj2u42oGxekcGMe0GyH5K2XJVo
         8/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724395333; x=1725000133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOio/RmcuQG9BgjNc9a/NdU3H7nYqTOjqoml5zYuQE0=;
        b=M8Iqdn1Y2YMOCb3Sr0ISVtHArFXc6j6lYBGTsUziwOabgRkwNs6IbuY+BJ/splKxA4
         eYgcbfmVgqCIqY/LG3KwRmul9dslE4JZq9+m5BADGI6o5LW2QwI/bAX1hn5SvHJunwHb
         bFpty0XnBfbK41xLxHU0P/9GmZLfgc7GRSGgxSJH5Mj1ziCMQNQu3G8okAVpc39odWsL
         /PoCAX0Dywce1WPrKusk5gYW4f/CVXeMnwFR6VUcpab0NJs/89M6H721YBougpvz/476
         NTJtWbpazqIQImDQmGKSSNbivx0FC0GcYcEtW9odOAt29VoXwLlGyX6ARUEbfL1UbQXJ
         UV6g==
X-Forwarded-Encrypted: i=1; AJvYcCWItyue26kAp9Bq2fSBhsKfwCVlIw3YSeVqnTFXAjDMGzOBslrUOOq4mGZXQwUyBVe0gM99tyjJkqrsuEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCWaOwVu6UzeC5eJyg1ERMW/awBXqDkcxZp28TttOzogkMoLJM
	sX7lREFQQlXYGJVs6nUJqqk6QYWa5SDJIf9rhpmUdSobBggmPO79aSlV+55zudn8vvttxMC2cU8
	Pm2Pej46SiL4iig/Tow4lWdFvNzRh4TBd9WgzU5s7Yofr2AmXK6LV
X-Google-Smtp-Source: AGHT+IFEbVtJPs2E51riwPmt93bZcmToQs9O8hVC8Tm76SjBQlHezhrzhzuARDJ4o7DvQLPMDTQyh0upShVLUXc2w1U=
X-Received: by 2002:a17:907:36c4:b0:a7a:ba59:3164 with SMTP id
 a640c23a62f3a-a86a54aa5f7mr79596066b.53.1724395332517; Thu, 22 Aug 2024
 23:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823021333.1252272-1-johunt@akamai.com> <20240823021333.1252272-2-johunt@akamai.com>
In-Reply-To: <20240823021333.1252272-2-johunt@akamai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Aug 2024 08:42:01 +0200
Message-ID: <CANn89i+jT0E_N4k=ciw7XvJXLH15rA=8qexRi=7D3YPo5=ZoqA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] tcp: check skb is non-NULL in tcp_rto_delta_us()
To: Josh Hunt <johunt@akamai.com>, Neal Cardwell <ncardwell@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 4:14=E2=80=AFAM Josh Hunt <johunt@akamai.com> wrote=
:
>
> There have been multiple occassions where we have crashed in this path
> because packets_out suggested there were packets on the write or retransm=
it
> queues, but in fact there weren't leading to a NULL skb being dereference=
d.
> While we should fix that root cause we should also just make sure the skb
> is not NULL before dereferencing it. Also add a warn once here to capture
> some information if/when the problem case is hit again.
>
> Signed-off-by: Josh Hunt <johunt@akamai.com>
> ---
>  include/net/tcp.h | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 2aac11e7e1cc..19ea6ed87880 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2433,10 +2433,19 @@ void tcp_plb_update_state_upon_rto(struct sock *s=
k, struct tcp_plb_state *plb);
>  static inline s64 tcp_rto_delta_us(const struct sock *sk)
>  {
>         const struct sk_buff *skb =3D tcp_rtx_queue_head(sk);
> -       u32 rto =3D inet_csk(sk)->icsk_rto;
> -       u64 rto_time_stamp_us =3D tcp_skb_timestamp_us(skb) + jiffies_to_=
usecs(rto);
> +       u32 rto =3D jiffies_to_usecs(inet_csk(sk)->icsk_rto);
> +
> +       if (likely(skb)) {
> +               u64 rto_time_stamp_us =3D tcp_skb_timestamp_us(skb) + rto=
;
> +
> +               return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> +       } else {
> +               WARN_ONCE(1,
> +                       "rtx queue emtpy: inflight %u tlp_high_seq %u sta=
te %u\n",
> +                       tcp_sk(sk)->packets_out, tcp_sk(sk)->tlp_high_seq=
, sk->sk_state);
> +               return rto;
> +       }
>
> -       return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
>  }
>
>  /*
> --
> 2.34.1
>

Are you using a recent linux kernel version ?

I am asking because sometimes patches are submitted while the authors
are using very old kernels,
and they do not state this clearly.

I have never seen such a state.

Please CC Neal on your next submission.

