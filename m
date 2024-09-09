Return-Path: <linux-kernel+bounces-321796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C1A971F7E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61ED8282D7B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFA916DEAA;
	Mon,  9 Sep 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8iUXwqr"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4516D9B8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900380; cv=none; b=oYl/fk41Njc4bjwUuCiDCmY9FRlhCSPj9PDk+5802VhiHxnupCdb0d2bDmbIYlGU2HJwzEY9bxGCz6Fa0uidVRfeTNwJtTnVtDDQyHiu0y4ZGiNHl9PTAAbnOA/AttgdzYM8+ornI05/n6wB/foK0YxATkz7x6awDdCLO609cG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900380; c=relaxed/simple;
	bh=PtXgWEMdhBCfxrMV5M60xLjhB32Phc2QBpQlAcUGfP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NctwNk/j6mwrLi819t1252p3vgRC21kOeD+ZtTZrHHCA4+oXvDVOcJjnG3aiuPcpocP2dw2NxBKXKAzTKjHaFfPV0UDo59HXInsuU+klM4FkQfJvrIEkVk1UExK9Af0JQVaIkubm7PsnefCR6z6TbkPreO+lObE+tIuFwWQbFVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R8iUXwqr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso53875985e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725900377; x=1726505177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9SiO6xUxnqXAw/LgFoH+/dHfvx+t44phKmxj197jCQ=;
        b=R8iUXwqrmEcMFBIqsQR+5p0G2wxdQAFWKMcdSLtimrRdJ2bNCcPgPQ0kPZgH7ZrfaU
         fD8unOGpO5v6HUusGZ3neuVmgO0sf54akERqDDsD58v68y/rD0BaY1VxSldb4ijtF5W5
         rnVyFBg4P68wZZrY04r1JTmxIKDljNi/U09ZJAROuzEbFimBsRsBkqQzdCXiuERjb4b7
         f+f6ykX1IKEJIKus0dUWzGfIGZ2e7Hg5JvBPwYeOR6i64flHHrmBfUw2PsZjUgwRJ8rT
         eWljAschz/auPkx+jHI6RiI27xfO0Roy6ZKNFXsVFWYXj7qOSk2LbTe0AM6YwE50UWXk
         WvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725900377; x=1726505177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9SiO6xUxnqXAw/LgFoH+/dHfvx+t44phKmxj197jCQ=;
        b=WJt1wEzP1jn1Yw/UeNAoyqFz4VSoJlH7zJLeBmy+ykBZ+02QjR25hJa9I0gpEZb2LN
         8+D5slpeWwAXfJKmKVh6TKm2SP5os4b22RUwOEcrT42yYZ8GtMEAUVjyy7EPlkW4kORj
         +Mob7uzKPGe4+sKNHW51uIxI8TRmk2kXdiIMrqEgwz2Az7scRT65UfVx8e6h/J0aTkfQ
         o3Wq7saqcjStJAYAXdUF/xOJyVB1AvG+ZAvETjr8z7nHZ9Qz2iT8LCfnxdQXd+sE3Ui9
         0LT4qVLw4McfuRUCJCiQk5L03IZWXVQ8RkBTN5R8oTHcvn5ACkvLqMOsjS1SDIJc09z9
         TyLA==
X-Forwarded-Encrypted: i=1; AJvYcCXN3IiIRuX/c9n2WxuI7kTcDlA/GbE+QyIyOHmb2fzQTH0yd9PHgdCUxSF0ifyM6BUxRD1FWfvyZefGVwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztxcSP+fTr81BtBfqJWh7SMPFSTRcIMpPM8uP9IX/eRZsY21IS
	zzl2NmCJwdqHiOE9wxMenK7MjaESMiAUOV41px0bzWlP0XQEc0ucTegAEnakUbHdrZT6ZJ+OjW+
	j7gFKcgrkU0kePOrLYD/7++pnGMIbSVpLPMAs
X-Google-Smtp-Source: AGHT+IHxMIgEPETdtRxitPOndtVl9VPFTYCRnwDB3ln3xDf0u1U9D0XTOVls54AhGFDHccAWSysMIxtaaiN4liuEd/U=
X-Received: by 2002:adf:cc91:0:b0:374:c658:706e with SMTP id
 ffacd0b85a97d-3789243fb15mr7369793f8f.39.1725900376219; Mon, 09 Sep 2024
 09:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909160604.1148178-1-sean.anderson@linux.dev>
In-Reply-To: <20240909160604.1148178-1-sean.anderson@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Sep 2024 18:46:01 +0200
Message-ID: <CANn89i+UHJgx5cp6M=6PidC0rdPdr4hnsDaQ=7srijR3ArM1jw@mail.gmail.com>
Subject: Re: [PATCH net] net: dpaa: Pad packets to ETH_ZLEN
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Madalin Bucur <madalin.bucur@nxp.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 6:06=E2=80=AFPM Sean Anderson <sean.anderson@linux.d=
ev> wrote:
>
> When sending packets under 60 bytes, up to three bytes of the buffer foll=
owing
> the data may be leaked. Avoid this by extending all packets to ETH_ZLEN,
> ensuring nothing is leaked in the padding. This bug can be reproduced by
> running
>
>         $ ping -s 11 destination
>
> Fixes: 9ad1a3749333 ("dpaa_eth: add support for DPAA Ethernet")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net=
/ethernet/freescale/dpaa/dpaa_eth.c
> index cfe6b57b1da0..e4e8ee8b7356 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> @@ -2322,6 +2322,12 @@ dpaa_start_xmit(struct sk_buff *skb, struct net_de=
vice *net_dev)
>         }
>  #endif
>
> +       /* Packet data is always read as 32-bit words, so zero out any pa=
rt of
> +        * the skb which might be sent if we have to pad the packet
> +        */
> +       if (__skb_put_padto(skb, ETH_ZLEN, false))
> +               goto enomem;
> +

This call might linearize the packet.

@nonlinear variable might be wrong after this point.

>         if (nonlinear) {
>                 /* Just create a S/G fd based on the skb */
>                 err =3D skb_to_sg_fd(priv, skb, &fd);
> --
> 2.35.1.1320.gc452695387.dirty
>

Perhaps this instead ?

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index cfe6b57b1da0e45613ac1bbf32ddd6ace329f4fd..5763d2f1bf8dd31b80fda068136=
1514dad1dc307
100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2272,12 +2272,12 @@ static netdev_tx_t
 dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 {
        const int queue_mapping =3D skb_get_queue_mapping(skb);
-       bool nonlinear =3D skb_is_nonlinear(skb);
        struct rtnl_link_stats64 *percpu_stats;
        struct dpaa_percpu_priv *percpu_priv;
        struct netdev_queue *txq;
        struct dpaa_priv *priv;
        struct qm_fd fd;
+       bool nonlinear;
        int offset =3D 0;
        int err =3D 0;

@@ -2287,6 +2287,10 @@ dpaa_start_xmit(struct sk_buff *skb, struct
net_device *net_dev)

        qm_fd_clear_fd(&fd);

+       if (__skb_put_padto(skb, ETH_ZLEN, false))
+               goto enomem;
+
+       nonlinear =3D skb_is_nonlinear(skb);
        if (!nonlinear) {
                /* We're going to store the skb backpointer at the beginnin=
g
                 * of the data buffer, so we need a privately owned skb

