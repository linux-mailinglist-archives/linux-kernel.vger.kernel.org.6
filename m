Return-Path: <linux-kernel+bounces-429314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13189E1A5D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC54162EE1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1961E3DC6;
	Tue,  3 Dec 2024 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="flu+bSU6"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E341E32C3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224041; cv=none; b=RlRJOI+ZlEP9yZFc98byDTKghXHhclWaHyANGa2WJ51BobhjgpQailwSvuHGjOSsiWlpWIfw+xTlWgrooYUukccI7JMr537SGbSId2D15lhvpr16g0JdfVPtX/ECrmTQRaENBWyAqBqdEcd3Vf4ioSTofljX1tOafZ2WIaeiWP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224041; c=relaxed/simple;
	bh=BcLFJqF5R9LBzw/ZSdK7+ys5w76GtCBHQbe2mYPuFWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaQVuOO9UJd1M0/qfSTjvOGeEnTPLJiRQXoutv4GHwAfEbSBkNNEH73TKpy6Ku4//nPaIr8OS7fs9gaEHhjq9oHZo0k3HE3j2FYQeL25X7PzwXVZJbs3wmZmig56oWH9MHrJ/r8XRP1rslrLNu9CuA96OHwRZAGscOGxKSQQL84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=flu+bSU6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa539d2b4b2so964970366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733224036; x=1733828836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxFrxVDfrOwjFXl5KkCLHRbcRXZZT5T9BXx+SADM3Uo=;
        b=flu+bSU6ZEl+AeU3y/jEL+bAY/q9dC1UbYOKCYt7PuiOwtZcFHLRhxslWVWWal9vy7
         vS10kxstb/PoIfZqeikr8AC2a/ASErX7Y/VGnw4uwp5cv2+Sl5LvUc0x1JSVyMvEKKMD
         F1pMK0zobYiLDzRju913j5G6po7uxXX38QKY7CxsEKhiFgREowyzG8Es6qX6fluNkQ3P
         tuGQmLRjr3Z/2875+lJNUBNuW1DbrQX1X7c9IYvbAwpDdGnwNkFk3JZVq/PKBw0GF/HB
         pjl+psix9j1ywyE8aQMXGPJr+uwGhLHVD/ma4NNsIMcVC56mi/adHwJftMZGSHhSlR28
         JHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224036; x=1733828836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxFrxVDfrOwjFXl5KkCLHRbcRXZZT5T9BXx+SADM3Uo=;
        b=DIv/6xvI6/wMsgr/hUiQ+GF5+vXC6dUxImGzWyXcMGceIa6W6eWsVkpVerLM1IQivJ
         nsjPY7/R9dKDN0zjTQMjyncabfap4pK3VRJkSNkIzB0dWo0xJN8grOYRl1X5ck0SUtWO
         xHTp7SiGNsqCTeHhLjZctC4QVgc1KSHPRb0sEyQOfdQxdaCun49pHOL1rDU9YZFHG3ot
         0B93L/c2Di6WcEWeNAGhm5BUumVmMlGi9CQxja6L99EylV+ObISCS3Pd7js0gxhMII5T
         sSRNOyjwlGpJfy+FSPMOIvRL+CIOtBiMBijs1Qp2w/XTTh9YdQnlGnXN+0rbWN5wPUuk
         egAw==
X-Forwarded-Encrypted: i=1; AJvYcCV0V+xZsQlLl189kKumGtE21Sx+3uVZf4dZcFZ0pBVkOZcRQh/S4HhGiV3IkvYA809bgVfr8sajHzKQtgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwNZ+ZOncj6OC6vFcQ1Fs3DFRKTgSq8G3HXEtqt+6o6F8soh/Q
	GY2F+aFFBw9GHsMYxObaIqssc9hjpHe6or2Ez2E9548+Ov1gwjn7KFGavC8rAGNIXF1ZSA6/Zek
	gHiB+p9h+XRjg1X/FtF1rvjbLeQODYBTowS8O
X-Gm-Gg: ASbGncs7P1Y/HkgmLwapeLZWYhLtY1nuQ/p9Y5gERnqQt0u6EwmneUJENdyGkyWLOZX
	jyNi+HZtnL1QhfQThzYHBScHFIjo1PPk=
X-Google-Smtp-Source: AGHT+IFNBPCDBSWJ2rlSUeXx0fiZoz6zwSFf96PshdUcfQi7cbCtRJboavISixKJf7zAhgvyP4zRsca5clzUuPnPnFg=
X-Received: by 2002:a17:907:3e95:b0:aa5:ef1c:9dfc with SMTP id
 a640c23a62f3a-aa5ef1c9ee3mr464606566b.8.1733224036444; Tue, 03 Dec 2024
 03:07:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
 <20241203081247.1533534-1-youngmin.nam@samsung.com>
In-Reply-To: <20241203081247.1533534-1-youngmin.nam@samsung.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Dec 2024 12:07:05 +0100
Message-ID: <CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
To: Youngmin Nam <youngmin.nam@samsung.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, dujeong.lee@samsung.com, 
	guo88.liu@samsung.com, yiwang.cai@samsung.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, joonki.min@samsung.com, hajun.sung@samsung.com, 
	d7271.choe@samsung.com, sw.ju@samsung.com, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 9:10=E2=80=AFAM Youngmin Nam <youngmin.nam@samsung.c=
om> wrote:
>
> We encountered the following WARNINGs
> in tcp_sacktag_write_queue()/tcp_fastretrans_alert()
> which triggered a kernel panic due to panic_on_warn.
>
> case 1.
> ------------[ cut here ]------------
> WARNING: CPU: 4 PID: 453 at net/ipv4/tcp_input.c:2026
> Call trace:
>  tcp_sacktag_write_queue+0xae8/0xb60
>  tcp_ack+0x4ec/0x12b8
>  tcp_rcv_state_process+0x22c/0xd38
>  tcp_v4_do_rcv+0x220/0x300
>  tcp_v4_rcv+0xa5c/0xbb4
>  ip_protocol_deliver_rcu+0x198/0x34c
>  ip_local_deliver_finish+0x94/0xc4
>  ip_local_deliver+0x74/0x10c
>  ip_rcv+0xa0/0x13c
> Kernel panic - not syncing: kernel: panic_on_warn set ...
>
> case 2.
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 648 at net/ipv4/tcp_input.c:3004
> Call trace:
>  tcp_fastretrans_alert+0x8ac/0xa74
>  tcp_ack+0x904/0x12b8
>  tcp_rcv_state_process+0x22c/0xd38
>  tcp_v4_do_rcv+0x220/0x300
>  tcp_v4_rcv+0xa5c/0xbb4
>  ip_protocol_deliver_rcu+0x198/0x34c
>  ip_local_deliver_finish+0x94/0xc4
>  ip_local_deliver+0x74/0x10c
>  ip_rcv+0xa0/0x13c
> Kernel panic - not syncing: kernel: panic_on_warn set ...
>

I have not seen these warnings firing. Neal, have you seen this in the past=
 ?

Please provide the kernel version (this must be a pristine LTS one).
and symbolized stack traces using scripts/decode_stacktrace.sh

If this warning was easy to trigger, please provide a packetdrill test ?



> When we check the socket state value at the time of the issue,
> it was 0x4.
>
> skc_state =3D 0x4,
>
> This is "TCP_FIN_WAIT1" and which means the device closed its socket.
>
> enum {
>         TCP_ESTABLISHED =3D 1,
>         TCP_SYN_SENT,
>         TCP_SYN_RECV,
>         TCP_FIN_WAIT1,
>
> And also this means tp->packets_out was initialized as 0
> by tcp_write_queue_purge().

What stack trace leads to this tcp_write_queue_purge() exactly ?

>
> In a congested network situation, a TCP ACK for
> an already closed session may be received with a delay from the peer.
> This can trigger the WARN_ON macro to help debug the situation.
>
> To make this situation more meaningful, we would like to call
> WARN_ON only when the state of the socket is "TCP_ESTABLISHED".
> This will prevent the kernel from triggering a panic
> due to panic_on_warn.
>
> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> ---
>  net/ipv4/tcp_input.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 5bdf13ac26ef..62f4c285ab80 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -2037,7 +2037,8 @@ tcp_sacktag_write_queue(struct sock *sk, const stru=
ct sk_buff *ack_skb,
>         WARN_ON((int)tp->sacked_out < 0);
>         WARN_ON((int)tp->lost_out < 0);
>         WARN_ON((int)tp->retrans_out < 0);
> -       WARN_ON((int)tcp_packets_in_flight(tp) < 0);
> +       if (sk->sk_state =3D=3D TCP_ESTABLISHED)

In any case this test on sk_state is too specific.

> +               WARN_ON((int)tcp_packets_in_flight(tp) < 0);
>  #endif
>         return state->flag;
>  }
> @@ -3080,7 +3081,8 @@ static void tcp_fastretrans_alert(struct sock *sk, =
const u32 prior_snd_una,
>                 return;
>
>         /* C. Check consistency of the current state. */
> -       tcp_verify_left_out(tp);
> +       if (sk->sk_state =3D=3D TCP_ESTABLISHED)
> +               tcp_verify_left_out(tp);
>
>         /* D. Check state exit conditions. State can be terminated
>          *    when high_seq is ACKed. */
> --
> 2.39.2
>

