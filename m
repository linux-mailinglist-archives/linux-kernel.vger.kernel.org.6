Return-Path: <linux-kernel+bounces-253271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD46B931EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3881C21D32
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6B813FF9;
	Tue, 16 Jul 2024 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="20y6mUqq"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB568208A5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721097041; cv=none; b=U4WicNCmCk9EvVpKsIj/HAN49tN/tex+D9dqzEqZuHPw812P/dop7NNH2XWlEVvv1lPHTH72Pr0+1w2SX/68tTXDm4AkeGmnFbJOnMjuv+7aAzpe/4FsjyDXdaSt5ZepHfMLXpIt5rvpD7K8SpBfrRasGf5OpH2zgZ1uZnQdpUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721097041; c=relaxed/simple;
	bh=3iqw1t/CyrkP/qQUgCQYv/zzWd4pYBWDepSahEba1wM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJm73Ey8T5fB9LEJbQO+Qk33StXuqBFZiTezlSNTyicznyyRbKKBZPpS9byFanyEoKpn/N+DPNlXLl4xrBoj8lPVQK972lCMyXsRea/37xSPNJQfaNIvGawcdMWbzDpp/m+n055wIbO8e/0mugbmTjOyurOkURlwRCfr+xcSAFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=20y6mUqq; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso8489a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721097037; x=1721701837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1pYeevvK77sMTv04yGyie+GvLz7zwfPlA255cFn8ls=;
        b=20y6mUqqZ4Hlapopze6MwurCtiQxWesiGSVefW0xb0QimWX+9QkK4ML/ClNpfxBowE
         O98QfJ5YRKhJxj2GeQbzBLSPKVsT/i8GbU89uhnKq5lvW0HnyPlzXlbmZZ5GA+r1OaGa
         HNOvaNrtbw0tb+3N/kl6QIPtyfnhrku7BA3MQIxnfM6FW16aag9jb0hdIxWiIkAgM5yZ
         68JJBSxJhgp01xjd2I0blEc4xSPGJbfiLH/NOEDcDNyd5NVXVYsdeiQ3M0SWZL+sVzdF
         OGkxs4/6Qi9Mshb2OZlweMA+WWKp3EEALVlo2/sWEc5Z5BaVLcXi3PO42XiirsEgz7A8
         4HWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721097037; x=1721701837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1pYeevvK77sMTv04yGyie+GvLz7zwfPlA255cFn8ls=;
        b=fmSGwXHNwQNwBzISebiWwTsLffVI8Zi0NTPu/7tsLAw1HTv6KUdoF7fzIH76Pge4eL
         UjTPuWRvLdERltd/nS6vzWjNL86kydw+AoLeuWoFE2YHA31RJs7H7ODxJqITKiP8aGLv
         SVn9blKzFttZ9zlRP5dkd/eVFVB4q8NxJB4nKfnwScUeuR60Da/IxCtfQmruGiYL/hgE
         hoPQ3SsqQ1Xm1yelwKWCZJgrb2LlcY5x/2Yxi55Yfef/wUr/Z6RghQRxmGAe56WoNxuL
         HC+oxrJwAPA99Mk5LcaW30DlPlZl93wK9w2N0+WC0SIEsUxNEIcdsjBcD07zONuJm6al
         lHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNfHQmzU26tPhN7tP59E3Eet7FaB3ehmkx7Im4uZA+tazUucQW+/xDtQeFcrxDVxW7ugrNZNzqaGFTnY6H6/TXjxoa+b5HUhohRqT3
X-Gm-Message-State: AOJu0YwodD4FoFVSisrHJU1MarUgd4K+nxURX82fZgbRQini7oxIYVhw
	Cv220zjKU29dPdJc1eoa75whp0/GFC6K5l4mQkFHR4J/8lVsxVe9hGHSQCN0f6JJkA5vTwELmeX
	k2eqfi2JfAo3hMapcrwI2A8AC+Scc4B6K/KNi
X-Google-Smtp-Source: AGHT+IHchWRK+QagrkmTdo8Drjk6/O7gp0y4ZtZeA4qUKecjhmMM8xytG2fGoy6xfybpClQwkF1ivmZiDztRHX4l/es=
X-Received: by 2002:a05:6402:5106:b0:58b:90c6:c59e with SMTP id
 4fb4d7f45d1cf-59eed87975dmr81644a12.7.1721097036784; Mon, 15 Jul 2024
 19:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716021548.339364-1-make24@iscas.ac.cn>
In-Reply-To: <20240716021548.339364-1-make24@iscas.ac.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Jul 2024 19:30:24 -0700
Message-ID: <CANn89iKzNXMNjYmf+2uA1kutKcfW_XbYVQ==00meJvC3XpM2nw@mail.gmail.com>
Subject: Re: [PATCH] ipv6: prevent possible NULL dereference in ndisc_recv_na()
To: Ma Ke <make24@iscas.ac.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, johannes.berg@intel.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 7:16=E2=80=AFPM Ma Ke <make24@iscas.ac.cn> wrote:
>
> In ndisc_recv_na(), __in6_dev_get() could return NULL, which is a NULL
> pointer dereference. Add a check to prevent bailing out.
>
> Fixes: 7a02bf892d8f ("ipv6: add option to drop unsolicited neighbor adver=
tisements")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  net/ipv6/ndisc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index d914b23256ce..f7cafff3f6a9 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -1000,6 +1000,8 @@ static enum skb_drop_reason ndisc_recv_na(struct sk=
_buff *skb)
>         struct ndisc_options ndopts;
>         struct net_device *dev =3D skb->dev;
>         struct inet6_dev *idev =3D __in6_dev_get(dev);
> +       if (!idev)
> +               return SKP_DROP_REASON_NOT_SPECIFIED;
>         struct inet6_ifaddr *ifp;
>         struct neighbour *neigh;
>         SKB_DR(reason);

Please do not mix code and variables.

Also, idev is correctly tested in the current code, therefore your
patch is not needed.

Thank you.

