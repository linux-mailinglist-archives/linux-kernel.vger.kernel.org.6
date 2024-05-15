Return-Path: <linux-kernel+bounces-179721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DF18C641B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8481C2029F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6C95A0F5;
	Wed, 15 May 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MQJRNZmo"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17AE59B68
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715766494; cv=none; b=ctVqjiC0HmmDe8qZwOJR5IGddG+IOQEIEopXaJ1rjZUgAXG0bYuYgSkC1qC8F2sW6/P8d2kuCThDg4h7looaFqcVYbJ4dUQm/kpIds6YwMjKpe4Qen16BrQUHFJ6DWJ9+zOZhqLhRJOSQztUpIZHAUPEqzsAPtB6RmyMnbgJpqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715766494; c=relaxed/simple;
	bh=H9I5y314uT6KJjlHzr5ZCjJZM5vCbb5k41Bcy2g85JE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mzbFq7ez9KV0Q1ULrtf0Q8xONYiRWMAEpqeehdppw9UI8tVRQU7ZrT+PxyUIm5Y2mje7msjdgI+u3DnIBsTm0b6Jx7njmVmhg4L5KKoS2+FqrIvJwfw+B4eP94t4m1M8ad5CiisOQ8rKFyVqB8IWNh/2RnJpRPNx2IzGHKPCmpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MQJRNZmo; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572e8028e0cso1360832a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1715766491; x=1716371291; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SvdvxKzsIXlbkkCS/c8FlBp7an8yZdRF5H/FBmVMbF0=;
        b=MQJRNZmo4nT0duU8DCTFLPZ/3u3ZjshzYZ5EWUWK2vmHxJTCBLtRxUgaWY5E/A9qLK
         3vZLnWozA5PLUX/2ZmZ+r5h+hHjIQx46NMm/eVhFuo/42/9uo4py+QLz2vS3cMBy7Csl
         Zx/6JHTsoSzR9hFRNyKhsKsHp9zzd52GzTXedgmgnwZll+psNyb8tvw8Pv4wgHde5LIM
         lPWwtJ4SdsTfVgL7nZgd87Y5FKCuuT99uad3zKWDZiZiBPmL8eZlJT8tsRIGZxpPejBG
         vmNQH7ojWz+vOstWWcUn/S/IPtaA0YGWeqHHLCGN0WE19yTcLa5g8YxV5vQxIKCsU557
         jqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715766491; x=1716371291;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvdvxKzsIXlbkkCS/c8FlBp7an8yZdRF5H/FBmVMbF0=;
        b=O1heK3t8Fa5B0E6QkImAc5lbpM8N9Nk7s+CVLjfUauvqfXS45/V+GkvLMt7e5i6FAL
         /XeuYhCy/DhVQcCnrNpNn890lhUsAOJR10Z4B4VQfRZTpVQl3sAovgOAz26AAataRH7i
         Tv272BRaCU1yPk/bEJ6pam2pEq5dTxp1n7lQa70R1OacOrtLIU6IkabZdh4jxx47JRdy
         y6fRsMdMGEZN9U9Pg9vqta/4t7qIx7o3WLYA7zQYgJjq8urKbWXe6CmNmoLeY9Zdy5/E
         VYL2/w9TkqJ3r78jHHf3h9rwVe0ZQtTrvYc2HDet7AtVu1QjwAKga2GvFBL2pk4GfdK+
         SBWw==
X-Forwarded-Encrypted: i=1; AJvYcCW27yfPv0ffZ2rbBhL0F2QURfnGvas9ZErUHPFuMSl0bFP3gmvht3YYuf9TBCVO82TOcitQ5/R1NIdrczRxA74Hq5fSIPEed7ogVIgq
X-Gm-Message-State: AOJu0YwtRRFW8rQ2or4o1mAkWLx7tyYi2GbvJmqmI7/7FXwoK/1YKl9X
	Z+FWILFVxANiwfmkOuQp9nFeuQ5FcbwvUyJbo8v83rZg/YNJaxjNJ4fgXXiBlnQ=
X-Google-Smtp-Source: AGHT+IHyuK8hf39Mrn4kHBbuQOKmVcIaKCNYD4xN1HPPn/SRu5yzRFnMwhRQ8pYbw4tPVT3jc9hndQ==
X-Received: by 2002:a17:906:f296:b0:a58:f13d:d378 with SMTP id a640c23a62f3a-a5a2d54c5d6mr1072040666b.13.1715766491126;
        Wed, 15 May 2024 02:48:11 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:4d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a88a2ba62sm170355966b.91.2024.05.15.02.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 02:48:10 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Feng zhou <zhoufeng.zf@bytedance.com>
Cc: edumazet@google.com,  ast@kernel.org,  daniel@iogearbox.net,
  andrii@kernel.org,  martin.lau@linux.dev,  eddyz87@gmail.com,
  song@kernel.org,  yonghong.song@linux.dev,  john.fastabend@gmail.com,
  kpsingh@kernel.org,  sdf@google.com,  haoluo@google.com,
  jolsa@kernel.org,  davem@davemloft.net,  dsahern@kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  laoar.shao@gmail.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  bpf@vger.kernel.org,  yangzhenze@bytedance.com,
  wangdongdong.6@bytedance.com
Subject: Re: [PATCH bpf-next] bpf: tcp: Improve bpf write tcp opt performance
In-Reply-To: <20240515081901.91058-1-zhoufeng.zf@bytedance.com> (Feng zhou's
	message of "Wed, 15 May 2024 16:19:01 +0800")
References: <20240515081901.91058-1-zhoufeng.zf@bytedance.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Wed, 15 May 2024 11:48:09 +0200
Message-ID: <87seyjwgme.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 15, 2024 at 04:19 PM +08, Feng zhou wrote:
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>
> Set the full package write tcp option, the test found that the loss
> will be 20%. If a package wants to write tcp option, it will trigger
> bpf prog three times, and call "tcp_send_mss" calculate mss_cache,
> call "tcp_established_options" to reserve tcp opt len, call
> "bpf_skops_write_hdr_opt" to write tcp opt, but "tcp_send_mss" before
> TSO. Through bpftrace tracking, it was found that during the pressure
> test, "tcp_send_mss" call frequency was 90w/s. Considering that opt
> len does not change often, consider caching opt len for optimization.

You could also make your BPF sock_ops program cache the value and return
the cached value when called for BPF_SOCK_OPS_HDR_OPT_LEN_CB.

If that is in your opinion prohibitevely expensive then it would be good
to see a sample program and CPU cycle measurements (bpftool prog profile).

>
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> ---
>  include/linux/tcp.h            |  3 +++
>  include/uapi/linux/bpf.h       |  8 +++++++-
>  net/ipv4/tcp_output.c          | 12 +++++++++++-
>  tools/include/uapi/linux/bpf.h |  8 +++++++-
>  4 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 6a5e08b937b3..74437fcf94a2 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -455,6 +455,9 @@ struct tcp_sock {
>  					  * to recur itself by calling
>  					  * bpf_setsockopt(TCP_CONGESTION, "itself").
>  					  */
> +	u8	bpf_opt_len;		/* save tcp opt len implementation
> +					 * BPF_SOCK_OPS_HDR_OPT_LEN_CB fast path
> +					 */
>  #define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) (TP->bpf_sock_ops_cb_flags & ARG)
>  #else
>  #define BPF_SOCK_OPS_TEST_FLAG(TP, ARG) 0
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 90706a47f6ff..f2092de1f432 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6892,8 +6892,14 @@ enum {
>  	 * options first before the BPF program does.
>  	 */
>  	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
> +	/* Fast path to reserve space in a skb under
> +	 * sock_ops->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB.
> +	 * opt length doesn't change often, so it can save in the tcp_sock. And
> +	 * set BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG to no bpf call.
> +	 */
> +	BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG = (1<<7),
>  /* Mask of all currently supported cb flags */
> -	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
> +	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
>  };
>  
>  /* List of known BPF sock_ops operators.
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index ea7ad7d99245..0e7480a58012 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -488,12 +488,21 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
>  {
>  	struct bpf_sock_ops_kern sock_ops;
>  	int err;
> +	struct tcp_sock *th = (struct tcp_sock *)sk;
>  
> -	if (likely(!BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
> +	if (likely(!BPF_SOCK_OPS_TEST_FLAG(th,
>  					   BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG)) ||
>  	    !*remaining)
>  		return;
>  
> +	if (likely(BPF_SOCK_OPS_TEST_FLAG(th,
> +					  BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG)) &&
> +	    th->bpf_opt_len) {
> +		*remaining -= th->bpf_opt_len;

What if *remaining value shrinks from one call to the next?

BPF sock_ops program can't react to change. Feels like there should be a
safety check to prevent an underflow.

> +		opts->bpf_opt_len = th->bpf_opt_len;
> +		return;
> +	}
> +
>  	/* *remaining has already been aligned to 4 bytes, so *remaining >= 4 */
>  
>  	/* init sock_ops */
> @@ -538,6 +547,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
>  	opts->bpf_opt_len = *remaining - sock_ops.remaining_opt_len;
>  	/* round up to 4 bytes */
>  	opts->bpf_opt_len = (opts->bpf_opt_len + 3) & ~3;
> +	th->bpf_opt_len = opts->bpf_opt_len;
>  
>  	*remaining -= opts->bpf_opt_len;
>  }
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 90706a47f6ff..f2092de1f432 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6892,8 +6892,14 @@ enum {
>  	 * options first before the BPF program does.
>  	 */
>  	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
> +	/* Fast path to reserve space in a skb under
> +	 * sock_ops->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB.
> +	 * opt length doesn't change often, so it can save in the tcp_sock. And
> +	 * set BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG to no bpf call.
> +	 */
> +	BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG = (1<<7),

Have you considered a bpf_reserve_hdr_opt() flag instead?

An example or test coverage would to show this API extension in action
would help.

>  /* Mask of all currently supported cb flags */
> -	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
> +	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
>  };
>  
>  /* List of known BPF sock_ops operators.

