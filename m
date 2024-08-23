Return-Path: <linux-kernel+bounces-298951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A8E95CE0C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50684281AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504A918755C;
	Fri, 23 Aug 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MICsk+Pj"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B253B29D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420158; cv=none; b=mIV3yUULlhNur1Pr/jXxa4r9NSDlRv9zzPN5N63RIAnHEGiokM2tsIFaCBdE1HZOKCiGw6Ge7jNsS+DgV+/TWcfRIkNBao3Ij+Rtxu2FJmeVbSBbMrXy21Xyf+tWxaxW0oyJsWJ5hoEC/dpHBot1tifYS0qRpb+Q7B1NzZnY5m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420158; c=relaxed/simple;
	bh=ujM6O5ZK/EqpLhk4Q4uv5TbD+rpWyu4euAlplf7EsFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hu7Eg/g5XJ3OHg2FA1ZKip3na/o98Da45JpTx0DWi5GG7MXU39hCfl3YAiFMiMLhT6lEZ1MQ++KY76zisMFaXZmRzWMg11SJlg6YAR1SuqjREiMvAiqG8BM54lXi5ehBe757meJ/BWnSeREMqmpaIDXeaRngV5QIQQ9TAV5mHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MICsk+Pj; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-824ee14f7bfso74339639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724420156; x=1725024956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEKb45Lg8MPDi362O0d6ofXFvSIdqIRy115kUuxhPZk=;
        b=MICsk+PjgLz2jig6HfpG8NjNKTWbVEWXAz9xczcIUN/9/ypUJt8qn5RmryX5k5OsWg
         KHxRFXwWfnf8VUvJrSwTg/Si/Oo3jmdqgXX/OjTYWk9U27gh8YJ4y8oIcUJDvLtO1OJ1
         YLXEEeVTxb/y+FE/mZQO9/cPlXr9R7RJQjrKsnDQlS++UZcmCn98xZdBb1s4bFO4g3T7
         ffnTV0FkwBmag9zQBHzvRM8pu3Lr76TjC04vs9I1mYvdS++HvTorXunM8BYTeaeRvwoR
         6CroNyTZCJV3NE4NB1jK9GeNdoWeWsl/f/WzzVdOaMj/3YJIp8beI2ocOYTGOeEyIncG
         aNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724420156; x=1725024956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEKb45Lg8MPDi362O0d6ofXFvSIdqIRy115kUuxhPZk=;
        b=IRui0TZiNV5c2nHjMWdLso+QS6vbzw3Dq0M2O5iFyQ4wznak9/aWek1OQCitUQSnO/
         tmMNNB9nIm+xl8uegiWRyNtKtINdle/JE21RJ6mHBWZ50wfzzHdH9W/6+U3zQeTUjFNu
         jF1sOxbsl/3UuelII8fnM7hGA3TUMFD/X4r7tdCDPbtRf+Z5q6zxORs1fDLy9rhoiWWY
         7o3rEGDEJFl9OjcA2++geyaTd9TfkQvLiNWpdcYWczMV3tYzVqCQjeeJvvJnoxjqHQX0
         eKMMrIJ3xAzZ3L5wS2+Ko7n0rfHbkSlkAiIKtD/JUKQrXKJNL9kvbvYY95D6pBLU8NqO
         ve0w==
X-Forwarded-Encrypted: i=1; AJvYcCUCvkZk6e2INcDR121Gvm88l5QAeSm38DO6OeKZCzz95xNtbrbR1mecBKirAlj8MP8nAFwhrUp7mI7Ghgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPAgQN4BeaPMHIHGpDKiOmCIUCOnw4m2np0XDFd6gCICWPLNF9
	PQw6NCKUc4+EwGxnXhm8hRXwg7QVw2FvkK77Agcz8TisSsVEEFEueuRaarg8Pir0KG1O3LZBVXt
	UCgYSkJ6bdFcQQhTHywTVNsFMKyTybqS/hfQC
X-Google-Smtp-Source: AGHT+IF1feSpu1MHABPyVtTarNKgPPjFSAfT+Lum6ZjhP2a6e49DYc4QMytXHG34dALxUk29vig8528QbbKgOzAX8xE=
X-Received: by 2002:a05:6602:3996:b0:81f:9468:7c3c with SMTP id
 ca18e2360f4ac-8278735fc68mr349134739f.12.1724420156033; Fri, 23 Aug 2024
 06:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823085313.75419-1-zhoufeng.zf@bytedance.com>
In-Reply-To: <20240823085313.75419-1-zhoufeng.zf@bytedance.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Aug 2024 15:35:43 +0200
Message-ID: <CANn89i+ZsktuirATK0nhUmJu+TiqB9Kbozh+HhmCiP3qdnW3Ew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Fix bpf_get/setsockopt to tos not take
 effect when TCP over IPv4 via INET6 API
To: Feng zhou <zhoufeng.zf@bytedance.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, dsahern@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 10:53=E2=80=AFAM Feng zhou <zhoufeng.zf@bytedance.c=
om> wrote:
>
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>
> when TCP over IPv4 via INET6 API, bpf_get/setsockopt with ipv4 will
> fail, because sk->sk_family is AF_INET6. With ipv6 will success, not
> take effect, because inet_csk(sk)->icsk_af_ops is ipv6_mapped and
> use ip_queue_xmit, inet_sk(sk)->tos.
>
> So bpf_get/setsockopt needs add the judgment of this case. Just check
> "inet_csk(sk)->icsk_af_ops =3D=3D &ipv6_mapped".
>
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408152034.lw9Ilsj6-lkp=
@intel.com/
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> ---
> Changelog:
> v1->v2: Addressed comments from kernel test robot
> - Fix compilation error
> Details in here:
> https://lore.kernel.org/bpf/202408152058.YXAnhLgZ-lkp@intel.com/T/
>
>  include/net/tcp.h   | 2 ++
>  net/core/filter.c   | 6 +++++-
>  net/ipv6/tcp_ipv6.c | 6 ++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 2aac11e7e1cc..ea673f88c900 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -493,6 +493,8 @@ struct request_sock *cookie_tcp_reqsk_alloc(const str=
uct request_sock_ops *ops,
>                                             struct tcp_options_received *=
tcp_opt,
>                                             int mss, u32 tsoff);
>
> +bool is_tcp_sock_ipv6_mapped(struct sock *sk);
> +
>  #if IS_ENABLED(CONFIG_BPF)
>  struct bpf_tcp_req_attrs {
>         u32 rcv_tsval;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index ecf2ddf633bf..02a825e35c4d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5399,7 +5399,11 @@ static int sol_ip_sockopt(struct sock *sk, int opt=
name,
>                           char *optval, int *optlen,
>                           bool getopt)
>  {
> -       if (sk->sk_family !=3D AF_INET)
> +       if (sk->sk_family !=3D AF_INET
> +#if IS_BUILTIN(CONFIG_IPV6)
> +           && !is_tcp_sock_ipv6_mapped(sk)
> +#endif
> +           )
>                 return -EINVAL;

This does not look right to me.

I would remove the test completely.

SOL_IP socket options are available on AF_INET6 sockets just fine.

