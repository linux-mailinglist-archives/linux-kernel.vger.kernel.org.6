Return-Path: <linux-kernel+bounces-196762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0917F8D6194
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B127B24A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A1E15821D;
	Fri, 31 May 2024 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ibMV7ZhP"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DA4158215
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158001; cv=none; b=Ar5dY9MyFiW6+/aX00yKgem+IIog4GbderhRqLC4M+bo98ocHz8xz5EXTTEPCFENTVdDkyu8Tx9N0dOBsyrdiY6IvMj7AoktmuqHEVVbXAKqzveUn0cDz985/yHThESXnM+iRChIK/fp4oVLR2LQNCx3yzpc0g2fN5dE/xN2rEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158001; c=relaxed/simple;
	bh=Qrl8gBlWBojs4bs6Hkd0zqpMO++HCYgwKyzuuzzRa1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dY+qbObg2DGn75e57ciB3wcHYBuANCE9dDK/THIYqYuS6eNzTjvv2uMVIpP5G3FqRs7DpLPI43BTj1g/q5189+B95x9rTc5J+fiX4axmt93xqKKvXjujV+TS2PCJB44za5LrjHDzRs9737aBS++ckVAU/wJF7BDwC3nhYiVN/Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ibMV7ZhP; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a22af919cso9939a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 05:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717157998; x=1717762798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOMKLwenqrk5rHW2S8BctzzIxhLD4LfISuvmBO2LQGw=;
        b=ibMV7ZhP2AZjWsjQQn6bM3JLcldqHdVGP5w2c2IvZ/1lL8GqILWvxZZa3GqRRgn5LZ
         fmbXNjqz9KhAl8wYC8BLSuFd09jtGgTUqH2ARSiyKQq2sNjhBOhswBPDMbBEX8tv1sU1
         eZpQbOKxXR7c+HbLolVMIvASANWySO28gPDQKG/0VF0z0ib/0W4feB1LY0PcJ8exjegc
         fVZLCOvID1qz+/k9NAxZmtfHKSJVyS5iZXVjMFxDYm2U/VjofxNql30ydWnSxXRqOQOS
         j6DHhBkW8Wv9OFTAk9UUEbzYgiz4lH/UWd1LUK7vl5X2y024ZUkQMFF5LUTWWSHhq9pU
         WKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717157998; x=1717762798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOMKLwenqrk5rHW2S8BctzzIxhLD4LfISuvmBO2LQGw=;
        b=LFhZbnaMM0AzE0Txb4i0yySO5zYdwlcGln6/D1L8JSzmDUA7Ls+YZUdPekwDliGcdy
         E/TQHQw8oG4HUsaWetQhyhYO99Ms9cSC1k3ay2klGhSn/rjJBFLTq4a0MC3hga110XpA
         j+4i1AT5WlTMqCtDcRRfUWC7X6b2oQ//tut9RMiAgg0ue3Xq/yGo7TZmGskbWSTLMI9g
         V3T49WJbmrbbqUi8lL55MjqTRIaLfuLDPLndNrYRxwKxj6t64xPsJHZoBmep0Vs8jt+T
         oIikMVrzgfHHISAJMmXu+JImteQwnpSMhGAY5d+cCo5v9sPzbOAQm5dtaBGgTabmlylw
         rJBA==
X-Gm-Message-State: AOJu0YxcwE5+JX0u9aiV4kmntqfNW6M5UkH5fy2KfZTZ1Sl3l1wI3yKE
	iNO4jcjJvL1La7C8xjxtgODtobFigD8uKKTX7R1uOwxihFenxWKxpdZjNu4+r5XkrMBoMMK2k+s
	oeF4EC9N5itdvENrgs9pPiDv5KBixUKUBm3y9
X-Google-Smtp-Source: AGHT+IHWkB7C1ICo7tCMgw38WM+5BRZsljwQEM0wyfiPjI7e1m4UmfbnH2mLqGzVVvLxxsIB8vOUTC8Yx8oK2lqMTrY=
X-Received: by 2002:aa7:d6cf:0:b0:57a:22c8:2d3c with SMTP id
 4fb4d7f45d1cf-57a33693e06mr168102a12.0.1717157998054; Fri, 31 May 2024
 05:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531083840.2644162-1-jiangyunshui@kylinos.cn>
In-Reply-To: <20240531083840.2644162-1-jiangyunshui@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 May 2024 14:19:44 +0200
Message-ID: <CANn89iLPYoOjMxNjBVHY7GwPFBGuxwRoM9gZZ-fWUUYFYjM1Uw@mail.gmail.com>
Subject: Re: [PATCH] net: caif: use DEV_STATS_INC() and DEV_STATS_ADD()
To: Yunshui Jiang <jiangyunshui@kylinos.cn>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 1:40=E2=80=AFPM Yunshui Jiang <jiangyunshui@kylinos=
cn> wrote:
>
> CAIF devices update their dev->stats fields locklessly.

I disagree.
chnl_net_start_xmit() seems to be called while the txq spinlock is held,
so your patch is not needed in TX path.
Look for spin_lock(&txq->_xmit_lock), called from HARD_TX_LOCK()

I can not yet comment for the receiving side, can you add evidence to
your claim ?

> Therefore
> these counters should be updated atomically. Adopt SMP safe DEV_STATS_INC=
()
> and DEV_STATS_ADD() to achieve this.
>
> Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>
> ---
>  net/caif/chnl_net.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
> index 47901bd4def1..376f5abba88d 100644
> --- a/net/caif/chnl_net.c
> +++ b/net/caif/chnl_net.c
> @@ -90,7 +90,7 @@ static int chnl_recv_cb(struct cflayer *layr, struct cf=
pkt *pkt)
>                 break;
>         default:
>                 kfree_skb(skb);
> -               priv->netdev->stats.rx_errors++;
> +               DEV_STATS_INC(priv->netdev, rx_errors);
>                 return -EINVAL;
>         }
>
> @@ -103,8 +103,8 @@ static int chnl_recv_cb(struct cflayer *layr, struct =
cfpkt *pkt)
>         netif_rx(skb);
>
>         /* Update statistics. */
> -       priv->netdev->stats.rx_packets++;
> -       priv->netdev->stats.rx_bytes +=3D pktlen;
> +       DEV_STATS_INC(priv->netdev, rx_packets);
> +       DEV_STATS_ADD(priv->netdev, rx_bytes, pktlen);
>
>         return 0;
>  }
> @@ -206,14 +206,14 @@ static netdev_tx_t chnl_net_start_xmit(struct sk_bu=
ff *skb,
>         if (skb->len > priv->netdev->mtu) {
>                 pr_warn("Size of skb exceeded MTU\n");
>                 kfree_skb(skb);
> -               dev->stats.tx_errors++;
> +               DEV_STATS_INC(dev, tx_errors);
>                 return NETDEV_TX_OK;
>         }
>
>         if (!priv->flowenabled) {
>                 pr_debug("dropping packets flow off\n");
>                 kfree_skb(skb);
> -               dev->stats.tx_dropped++;
> +               DEV_STATS_INC(dev, tx_dropped);
>                 return NETDEV_TX_OK;
>         }
>
> @@ -228,13 +228,13 @@ static netdev_tx_t chnl_net_start_xmit(struct sk_bu=
ff *skb,
>         /* Send the packet down the stack. */
>         result =3D priv->chnl.dn->transmit(priv->chnl.dn, pkt);
>         if (result) {
> -               dev->stats.tx_dropped++;
> +               DEV_STATS_INC(dev, tx_dropped);
>                 return NETDEV_TX_OK;
>         }
>
>         /* Update statistics. */
> -       dev->stats.tx_packets++;
> -       dev->stats.tx_bytes +=3D len;
> +       DEV_STATS_INC(dev, tx_packets);
> +       DEV_STATS_ADD(dev, tx_bytes, len);
>
>         return NETDEV_TX_OK;
>  }
> --
> 2.34.1
>

