Return-Path: <linux-kernel+bounces-376105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCFC9AA019
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8080F1C2197E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D42C19AD97;
	Tue, 22 Oct 2024 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G8Dr3vNn"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D92D198A25
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592978; cv=none; b=GFsL1Mvk9OklPgWHUCdd3O+PIjIE5YNCeUKvnrwpPDxdOfcEnTkgroj87PT58bpw0ErnDvjvva/hrm08gBq0Ehnha502aYYESyXhlUYSlz+61BPHhbtrtL71ZsojjPDjSafe3ZFmUYIwom9LOkfPJf/Pwrm3klek1cJYdPUbakA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592978; c=relaxed/simple;
	bh=6C7NgU3MUhl3Hi2Nc5pua0VwmoKshs0V30agMvqeRcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXG1vCUqY5X8uswibWIEbX8APKMX8IB3Xnz49EODnu4xAJykDcabr3k0K/pV5W6MyQ5yQaun/AFHIC30B9dz/s6z1ucC/622LPAx/giU6a99nxuneDRo668VGFdhL7R8KwhT/7b3Zxa73LcYNmfPY5j4Z+3Yj5VTrrSc37W3Fx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G8Dr3vNn; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb3110b964so47972881fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729592975; x=1730197775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfQ5R5W4pAP72bBv+ZRad0B8K8sGOGYh/mrciyj4lTs=;
        b=G8Dr3vNn+oU4NLpM/No4zyI0jB3rTolxsBhHWttfDE/4zP2O2V3BwxdL1OA0SUHL5Q
         rnH6WnNVsyqxMzKcbbjgfqgbGCt2oH7XJ10ZPR8QWk/z08qbbGvd1FT6KJbfpxaxhs1Y
         yGR3DMbKGhaYiyq7D8IeSgLZYUsxCiuv0Xypk0mqx17xz/dwlFARxuGzmxG9TcFj1AeI
         LgGfp/kF35hMKkEGZr+i1FYWA7XTOQvzywxLbYl9VUskWJ3RR+Fr5m9vri+5oCNYypZn
         ARfsk1l5zvIebPV66QJQhOVlIpSbGtGRMM6EiLiNY3a/Ioj1UYiVz1vtFVYS+eiGhwvO
         KwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729592975; x=1730197775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfQ5R5W4pAP72bBv+ZRad0B8K8sGOGYh/mrciyj4lTs=;
        b=m1+upwNKasyFf8Se+2JH0/w7nm6+y4LY3ho5qNXgU8NCd8lEHCMvVSr18z1F5+gEKC
         n9BQv9bCXBspY6RBcFMCZmeQUe5jfhpfmzQbhm9a0qaWETpCLqWE3IG8gpXWSa0vAXA9
         kfxigpx9EyXZBA4+ONFOmVyIYpiem5R4GwOzNCFO/obrP5eTLzZsn9ukKoHLeLNGkaS6
         l2C5oT/42aESOS9X6ht4stCCMY56GwWSaJpU1dovw2G1bN3f2QMxcK3wGLY1T8dOy+gR
         Vp9HWQiUB9Ltx1DAWhBkbbg992sVuUC3ZXI0DzfDwDfxmnw/5+7s7BDUJXeAFy5FyLNV
         KZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcTNzH5p3QODAFKqk3FP6z+t0ngt1v9A/pARciWwVk5ksQk/kGbIsGkmltSFImagXwlJ9MbmRZ8qYFtFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEv+CI8e857IGqzqyqopg8vnYrsh4m8OyMB/rhEBcnokcnmMfd
	LrxX1S4QNBkXtCRDbWj1NTbaxy45J6U5Tdf2Wudhbiuu6fHn+9PVfk71N2EEilU3UaH1M83CWsS
	upWaAZwMlzCz+/yKZinvAxaNAhG5W22d8J/+p
X-Google-Smtp-Source: AGHT+IGKAlOEl7E9oTff9kvgfX+LWcozQrfXlOfU+OSgTq5j864f3oHwCQZ6UD+oFhycuC6vhTNHl9ohjhFSF3njz6w=
X-Received: by 2002:a05:651c:551:b0:2fa:d4ef:f222 with SMTP id
 38308e7fff4ca-2fb8320b662mr59323601fa.38.1729592974448; Tue, 22 Oct 2024
 03:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022085759.1328477-1-wangliang74@huawei.com>
In-Reply-To: <20241022085759.1328477-1-wangliang74@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Oct 2024 12:29:21 +0200
Message-ID: <CANn89iLJGbm0Jr9CVFo6K8jetF2jX0EqVBUR3a1L=PPSSLCygA@mail.gmail.com>
Subject: Re: [PATCH net] net: fix crash when config small gso_max_size/gso_ipv4_max_size
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com, 
	kuniyu@amazon.com, stephen@networkplumber.org, dsahern@kernel.org, 
	lucien.xin@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:40=E2=80=AFAM Wang Liang <wangliang74@huawei.com=
> wrote:
>
> Config a small gso_max_size/gso_ipv4_max_size can lead to large skb len,
> which may trigger a BUG_ON crash.
>
> If the gso_max_size/gso_ipv4_max_size is smaller than MAX_TCP_HEADER + 1,
> the sk->sk_gso_max_size is overflowed:
> sk_setup_caps
>     // dst->dev->gso_ipv4_max_size =3D 252, MAX_TCP_HEADER =3D 320
>     // GSO_LEGACY_MAX_SIZE =3D 65536, sk_is_tcp(sk) =3D 1
>     sk->sk_gso_max_size =3D sk_dst_gso_max_size(sk, dst);
>         max_size =3D dst->dev->gso_ipv4_max_size;
>             sk->sk_gso_max_size =3D max_size - (MAX_TCP_HEADER + 1);
>             sk->sk_gso_max_size =3D 252-(320+1) =3D -69
>
> When send tcp msg, the wrong sk_gso_max_size can lead to a very large
> size_goal, which cause large skb length:
> tcp_sendmsg_locked
>     tcp_send_mss(sk, &size_goal, flags);
>         tcp_xmit_size_goal(sk, mss_now, !(flags & MSG_OOB));
>
>             // tp->max_window =3D 65536, TCP_MSS_DEFAULT =3D 536
>             new_size_goal =3D tcp_bound_to_half_wnd(tp, sk->sk_gso_max_si=
ze);
>                 new_size_goal =3D sk->sk_gso_max_size =3D -69
>
>             // tp->gso_segs =3D 0, mss_now =3D 32768
>             size_goal =3D tp->gso_segs * mss_now;
>                 size_goal =3D 0*32768 =3D 0
>
>             // sk->sk_gso_max_segs =3D 65535, new_size_goal =3D -69
>             new_size_goal < size_goal:
>                 tp->gso_segs =3D min_t(u16, new_size_goal / mss_now,
>                      sk->sk_gso_max_segs);
>                 // new_size_goal / mss_now =3D 0x1FFFF -> 65535
>                 // tp->gso_segs =3D 65535
>                 size_goal =3D tp->gso_segs * mss_now;
>                 size_goal =3D 65535*32768 =3D 2147450880
>
>     if new_segment:
>         skb =3D tcp_stream_alloc_skb()
>         copy =3D size_goal; // copy =3D 2147450880
>     if (copy > msg_data_left(msg)) // msg_data_left(msg) =3D 2147479552
>         copy =3D msg_data_left(msg); // copy =3D 2147450880
>     copy =3D min_t(int, copy, pfrag->size - pfrag->offset); // copy =3D 2=
1360
>     skb_copy_to_page_nocache
>         skb_len_add
>             skb->len +=3D copy; // skb->len add to 524288
>

I find this explanation way too long. No one will bother to double
check your claims.

I would simply point out that an underflow in sk_dst_gso_max_size()
leads to a crash,
because sk->sk_gso_max_size would be much bigger than device limits.


> The large skb length may load to a overflowed tso_segs, which can trigger
> a BUG_ON crash:
> tcp_write_xmit
>     tso_segs =3D tcp_init_tso_segs(skb, mss_now);
>         tcp_set_skb_tso_segs
>             tcp_skb_pcount_set
>                 // skb->len =3D 524288, mss_now =3D 8
>                 // u16 tso_segs =3D 524288/8 =3D 65535 -> 0
>                 tso_segs =3D DIV_ROUND_UP(skb->len, mss_now)
>     BUG_ON(!tso_segs)
>
> To solve this issue, the minimum value of gso_max_size/gso_ipv4_max_size
> should be checked.
>
> Fixes: 46e6b992c250 ("rtnetlink: allow GSO maximums to be set on device c=
reation")
> Fixes: 9eefedd58ae1 ("net: add gso_ipv4_max_size and gro_ipv4_max_size pe=
r device")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  net/core/rtnetlink.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index e30e7ea0207d..a0df1da5a0a6 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -2466,6 +2466,12 @@ static int validate_linkmsg(struct net_device *dev=
, struct nlattr *tb[],
>                 return -EINVAL;
>         }
>
> +       if (tb[IFLA_GSO_MAX_SIZE] &&
> +           (nla_get_u32(tb[IFLA_GSO_MAX_SIZE]) < MAX_TCP_HEADER + 1)) {
> +               NL_SET_ERR_MSG(extack, "too small gso_max_size");
> +               return -EINVAL;
> +       }

Modern way would be to change ifla_policy[] : This is where we put such lim=
its.

Look for NLA_POLICY_MIN() uses in the tree.

> +
>         if (tb[IFLA_GSO_MAX_SEGS] &&
>             (nla_get_u32(tb[IFLA_GSO_MAX_SEGS]) > GSO_MAX_SEGS ||
>              nla_get_u32(tb[IFLA_GSO_MAX_SEGS]) > dev->tso_max_segs)) {
> @@ -2485,6 +2491,12 @@ static int validate_linkmsg(struct net_device *dev=
, struct nlattr *tb[],
>                 return -EINVAL;
>         }
>
> +       if (tb[IFLA_GSO_IPV4_MAX_SIZE] &&
> +           (nla_get_u32(tb[IFLA_GSO_IPV4_MAX_SIZE]) < MAX_TCP_HEADER + 1=
)) {
> +               NL_SET_ERR_MSG(extack, "too small gso_ipv4_max_size");
> +               return -EINVAL;
> +       }

Same here.

> +
>         if (tb[IFLA_GRO_IPV4_MAX_SIZE] &&
>             nla_get_u32(tb[IFLA_GRO_IPV4_MAX_SIZE]) > GRO_MAX_SIZE) {
>                 NL_SET_ERR_MSG(extack, "too big gro_ipv4_max_size");
> --
> 2.34.1
>

