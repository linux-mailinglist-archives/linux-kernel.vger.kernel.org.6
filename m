Return-Path: <linux-kernel+bounces-515761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888D7A368A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C4F3B48C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED331FCF63;
	Fri, 14 Feb 2025 22:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2zenFJUY"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994021FC7ED
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 22:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573005; cv=none; b=KD/uY/zyTJkkTEO6v1tjIkzEdpZ1rmaUuSDAzrVegznaJ4DqLpBc0p9SEqyT5XptUYTu/Z0p6XjaNu6Tbb22C3aTX1keZbyfiCFuS8ineJTG9xrhPXFhCMJhfIXmVPjUw7KRVW1fMLRncVp9vXF7/X15BiwBuWoCUSb7/TRf92w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573005; c=relaxed/simple;
	bh=fG4VEG9vUa1eYYGrVKUHwc8QSjhKAXFfO4zv39sxpVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HS9XoL+bWLwQ254LZsX3z0sPHtiW0TLlg/s6+hMam3ABnE4AHC3adQBloOLHtt99tAgZiNYL+TSN4okai+xgJLgj+sDT0UG1bj+w8elyFmhvOVlaiA+/3tE4HB/36ikT6I6M2B4NFdDFJRY2nGRZQEnLOZ4aV2G27ogYmTqRYgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2zenFJUY; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so23831786d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739573001; x=1740177801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0S7kDMXAD8gZoPUu13HV3B7jZz26znSFfxWBW/aLQ4=;
        b=2zenFJUYgPMbz8pI7ioAxSUXZyiDSkelXq8W2jZmPasG8vfCzP+OkA1Az3kkg7/3qu
         Zso2kj1PgUrDWJJWshxPuvhgS90rk8BueTTC0FyaI/mSRGIVbdnFHLUXrZSDBRLQjKXy
         I6tvx6LwzgmaDperMswSkmYGzOmlvqmicLvpqAJGh9yc4vOevJ2CQDxmXOp5HnDQJ4eg
         eC9D+pPz/SKzKADbrwSDhL3pjyjFBGvz2l5PqQtgEM0Unla1SutIx8Yhr2ORP4O7Cxw9
         UXK8kdGx/zyxwakAH5dHxgWNIT51eSr7HgrGwP7GIFzmvGCLla0Hj6gLMbhwq+Gx2kys
         1VZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739573001; x=1740177801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0S7kDMXAD8gZoPUu13HV3B7jZz26znSFfxWBW/aLQ4=;
        b=TFleeO9GuDS0jz0awla5AAX/I9Sr0TTV/8lqnc6E7PJxGsgnUyYPjqs63aW4nHL1VB
         vIFw8knRGCBQDBiiQSqJDCoeIwzLTAVeWJOPD9JUKmUeXuiwUvGbFDOwULzFRgIUZ/Qm
         v8t4t2UjPbbQYE3rrKTgPP4nGe5VMmZ5oCMMwwzzVjoHHnnIQYyZDOH70cOrsdXf9wSr
         eJ1Tm2MssQ2YCqkMnqKx7s/tlH2PvqIvveC/v6PceQDdJYSwTLcDerzfBBUO6u6xkewX
         NDL6dNAHVjt0/xolZW0xkO4QM/nZNjBOdh0vKD+Ndfn7Yqjq9rN1JdG2N4B+ckgdOw1k
         eFzg==
X-Forwarded-Encrypted: i=1; AJvYcCVj9x0G9DuWcOFukhziK3pUIWEle/QVDPs0jQ9TaWxBhFBJd8WbhrLUixRcvRSCmM8LDk6uwHvgldGNDZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8nyJcGkLyPVQK6JHviQ8bvm0IHbw8maxoGDUGCpZrSHz3Rg5E
	NJA1Q/PG6X5iYnsg2KGxNLnKaC0xH//OXuPhwvDnJkWHPgp/Lxq5NKPxkmA8q+AC+8nDHTrc8dA
	BYfkgz/qq4dd+0oTfj7IAchUE6RWm9KW/tAzN
X-Gm-Gg: ASbGnctYt6Df1DUi2T84Km7caNfiosy/FcXdPxTpNHGooq4q2hLyuMV93FXHyiyyRAX
	cTHZi/VbKv1GWgmPSQx65qKwe4jlNX2AY+5bE6vdi7wc5ApVSotp0jPMvoDfGMmkW+MuEYuB+IS
	8bNjXzT47rNHsOGmA3gJiK8vnJodw=
X-Google-Smtp-Source: AGHT+IHYqfptmmKo8lT6PBWLeXoXId9NyT+ZtdLFcjFAi7Rl22vhTrLDj37vJjqU8TkMj7zaYOm83pLPCt+oQryKieM=
X-Received: by 2002:a05:6214:5019:b0:6e4:3de6:e67a with SMTP id
 6a1803df08f44-6e66cd1a6a1mr15910146d6.30.1739573001346; Fri, 14 Feb 2025
 14:43:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214223829.1195855-1-joshwash@google.com>
In-Reply-To: <20250214223829.1195855-1-joshwash@google.com>
From: Joshua Washington <joshwash@google.com>
Date: Fri, 14 Feb 2025 14:43:10 -0800
X-Gm-Features: AWEUYZki233-dvPVdAXEocTl6XJ7iKCHeu9CVkeYzMPq5AFv9Ux386N4VE9mzTg
Message-ID: <CALuQH+XN5VBc3kMyWCRg8-=01gXWWkYbYEJLvCX==nhqSXxsCA@mail.gmail.com>
Subject: Re: [PATCH] gve: set xdp redirect target only when it is available
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, stable@kernel.org, 
	stable@vger.kernel.org, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, Shailend Chand <shailend@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

This patch is meant to be destined to the net tree, I forgot to add
the prefix when generating the patch. Please disregard this patch; I
will post a new version soon.

My apologies,
Josh Washington

On Fri, Feb 14, 2025 at 2:38=E2=80=AFPM <joshwash@google.com> wrote:
>
> From: Joshua Washington <joshwash@google.com>
>
> Before this patch the NETDEV_XDP_ACT_NDO_XMIT XDP feature flag is set by
> default as part of driver initialization, and is never cleared. However,
> this flag differs from others in that it is used as an indicator for
> whether the driver is ready to perform the ndo_xdp_xmit operation as
> part of an XDP_REDIRECT. Kernel helpers
> xdp_features_(set|clear)_redirect_target exist to convey this meaning.
>
> This patch ensures that the netdev is only reported as a redirect target
> when XDP queues exist to forward traffic.
>
> Fixes: 39a7f4aa3e4a ("gve: Add XDP REDIRECT support for GQI-QPL format")
> Cc: stable@vger.kernel.org
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Jeroen de Borst <jeroendb@google.com>
> Signed-off-by: Joshua Washington <joshwash@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h      | 10 ++++++++++
>  drivers/net/ethernet/google/gve/gve_main.c |  6 +++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet=
/google/gve/gve.h
> index 8167cc5fb0df..78d2a19593d1 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -1116,6 +1116,16 @@ static inline u32 gve_xdp_tx_start_queue_id(struct=
 gve_priv *priv)
>         return gve_xdp_tx_queue_id(priv, 0);
>  }
>
> +static inline bool gve_supports_xdp_xmit(struct gve_priv *priv)
> +{
> +       switch (priv->queue_format) {
> +       case GVE_GQI_QPL_FORMAT:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
>  /* gqi napi handler defined in gve_main.c */
>  int gve_napi_poll(struct napi_struct *napi, int budget);
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 533e659b15b3..92237fb0b60c 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1903,6 +1903,8 @@ static void gve_turndown(struct gve_priv *priv)
>         /* Stop tx queues */
>         netif_tx_disable(priv->dev);
>
> +       xdp_features_clear_redirect_target(priv->dev);
> +
>         gve_clear_napi_enabled(priv);
>         gve_clear_report_stats(priv);
>
> @@ -1972,6 +1974,9 @@ static void gve_turnup(struct gve_priv *priv)
>                 napi_schedule(&block->napi);
>         }
>
> +       if (priv->num_xdp_queues && gve_supports_xdp_xmit(priv))
> +               xdp_features_set_redirect_target(priv->dev, false);
> +
>         gve_set_napi_enabled(priv);
>  }
>
> @@ -2246,7 +2251,6 @@ static void gve_set_netdev_xdp_features(struct gve_=
priv *priv)
>         if (priv->queue_format =3D=3D GVE_GQI_QPL_FORMAT) {
>                 xdp_features =3D NETDEV_XDP_ACT_BASIC;
>                 xdp_features |=3D NETDEV_XDP_ACT_REDIRECT;
> -               xdp_features |=3D NETDEV_XDP_ACT_NDO_XMIT;
>                 xdp_features |=3D NETDEV_XDP_ACT_XSK_ZEROCOPY;
>         } else {
>                 xdp_features =3D 0;
> --
> 2.48.1.601.g30ceb7b040-goog
>


--=20

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3

