Return-Path: <linux-kernel+bounces-214396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A129083A1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD031B23698
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7D6148300;
	Fri, 14 Jun 2024 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rc1wePbQ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD041A88
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718346607; cv=none; b=B6idag1FXvGMsQhHtBmJerYIUk/vxWAqLoqLZi3KdEvzt97YLj5f2UCocO5RvuHj3yV5k97EZFfjYRpjMOCbvvZ7eUlnigoqjv09sAl+6XJB2wqWeGhiFl/1wLZMoQDvxUQ5PRN7na0zm5JW79LJdZF8DgdOkloqf4t+zVvNxk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718346607; c=relaxed/simple;
	bh=fBvmBDgwSObsqv72C0K4Duc1yNZfmxlmX4WBi2iFFxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtMRYQK+V5Ukd2mhT8zki2EudTwVLDJIfqZCSRUea2g0ExzCu9pJ6o49V+fhgoZGCsq2ZYchiBuTBoLoR3SZFFuv8jbfj6BkkHrz0AfQC0wKAFvi33OkhFxA6Xsy+Eb95kO+iBkyDybILd3/XeIyZueDA2lCxtqFQ7raZ2QAtlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rc1wePbQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57c6cb1a76fso6588a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 23:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718346602; x=1718951402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ty9dHjII2oNTRgYZhMpCHZzzTcFQTiXAiGwB2x+yE8=;
        b=Rc1wePbQPu9YKzmJG6f36TPL60ivDxE0WL81MDELJtJrPtNG5a9TlfQhtpXVnd0oK5
         eKTHg5UGoz0AGkjMMXXX1EkpvhhpvokbWT+3Jkv1Iln30qJE6xTv1vXt8Eshfui+CxvS
         QsyOnjXni4r3dv2rj4zsdFgdQbZW5qgcdJrzTwqzQKF1VJAVC7azA9HSsSsJ3XJW3gj1
         9snQTtW+jm4rOM6Cy9Y1icQo9IYQJuqcvqLcZI3kLjS7GGSXcpCiW3GXczpkC8yrkMfk
         4xX5jQggMjdQPt0/tnoa0FIyiaXvtjC4nKfU0uh1IA8TRSufAo4l3Om2TrSv7Y/AbeMa
         JC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718346602; x=1718951402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ty9dHjII2oNTRgYZhMpCHZzzTcFQTiXAiGwB2x+yE8=;
        b=q/gVqCYotJhYlTQL9RRc5Dofy7cuq5B5uGtu34jaiBZV5eLeW7+AYURF1xgz8OGQE2
         dX+eFAzhK63o/WLtrF6x6VB15+klNymE6T40aWr6/uJsts/IMidmVQ90/vWR/0hgno1V
         4Q5thVfdDZzTbyQ7s0vzCQpQrQasnUJaE2Rt8Sg1+DEwwOpGC/6Ce+eZNuS/GXnt+Q9l
         Iu7/EKVkMOXRxo7w4qRa8grpdmCfjrC7IClD4LCRCF8NlEd5EA7XsFauEWyZEbvLiEzT
         M3LfjOGOzFpXAhVRHxbrQnPekpsvrYCYtOsEqWZPHdHH0K8HF1VYSTr9JUCDokXHAx/u
         S0nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBpLIVuyk4Nak7wgOXUquDPq6n4PCYP4s9OQ2Yki6D3HGma+E07lZKtg6AmnIXMYEFDc2WEgUHigyxhmfhE4mKIUudy28V6t2u2M8T
X-Gm-Message-State: AOJu0YwwSSsBKv4o76u+GxBytF7jMQUmuxHbebnGmhRgkj4fYzZetyyS
	BWolIT2EsTM7k15yhDV4SUEZthq6HcamG3SEx4h7ZSE7KC1/WDakNuVFqQxCUXL1Ajc5K++Nohi
	320IXf7dLR6l9Wou9hg+AducfEvPQoXfxkMP/
X-Google-Smtp-Source: AGHT+IHNoF9/h44qFYBF0d6g0dfW9IXmS9HxYVsW/4kuOwuEEwNFYQqIHxoR8aq9DBGydev4+NnZksdrIl74LJDLm3U=
X-Received: by 2002:a05:6402:34c5:b0:57c:bb0d:5e48 with SMTP id
 4fb4d7f45d1cf-57cbec62916mr119091a12.2.1718346601831; Thu, 13 Jun 2024
 23:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614060349.498414-1-0x1207@gmail.com>
In-Reply-To: <20240614060349.498414-1-0x1207@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Jun 2024 08:29:48 +0200
Message-ID: <CANn89i+11L5=tKsa7V7Aeyxaj6nYGRwy35PAbCRYJ73G+b25sg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: stmmac: Enable TSO on VLANs
To: Furong Xu <0x1207@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Joao Pinto <jpinto@synopsys.com>, 
	Corinna Vinschen <vinschen@redhat.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	xfr@outlook.com, rock.xu@nio.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 8:04=E2=80=AFAM Furong Xu <0x1207@gmail.com> wrote:
>
> The TSO engine works well when the frames are not VLAN Tagged.
> But it will produce broken segments when frames are VLAN Tagged.
>
> The first segment is all good, while the second segment to the
> last segment are broken, they lack of required VLAN tag.
>
> An example here:
> =3D=3D=3D=3D=3D=3D=3D=3D
> // 1st segment of a VLAN Tagged TSO frame, nothing wrong.
> MacSrc > MacDst, ethertype 802.1Q (0x8100), length 1518: vlan 100, p 1, e=
thertype IPv4 (0x0800), HostA:42643 > HostB:5201: Flags [.], seq 1:1449
>
> // 2nd to last segments of a VLAN Tagged TSO frame, VLAN tag is missing.
> MacSrc > MacDst, ethertype IPv4 (0x0800), length 1514: HostA:42643 > Host=
B:5201: Flags [.], seq 1449:2897
> MacSrc > MacDst, ethertype IPv4 (0x0800), length 1514: HostA:42643 > Host=
B:5201: Flags [.], seq 2897:4345
> MacSrc > MacDst, ethertype IPv4 (0x0800), length 1514: HostA:42643 > Host=
B:5201: Flags [.], seq 4345:5793
> MacSrc > MacDst, ethertype IPv4 (0x0800), length 1514: HostA:42643 > Host=
B:5201: Flags [P.], seq 5793:7241
>
> // normal VLAN Tagged non-TSO frame, nothing wrong.
> MacSrc > MacDst, ethertype 802.1Q (0x8100), length 1022: vlan 100, p 1, e=
thertype IPv4 (0x0800), HostA:42643 > HostB:5201: Flags [P.], seq 7241:8193
> MacSrc > MacDst, ethertype 802.1Q (0x8100), length 70: vlan 100, p 1, eth=
ertype IPv4 (0x0800), HostA:42643 > HostB:5201: Flags [F.], seq 8193
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> When transmitting VLAN Tagged TSO frames, never insert VLAN tag by HW,
> always insert VLAN tag to SKB payload, then TSO works well on VLANs for
> all MAC cores.
>
> Tested on DWMAC CORE 5.10a, DWMAC CORE 5.20a and DWXGMAC CORE 3.20a
>
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>   Changes in v2:
>     - Use __vlan_hwaccel_push_inside() to insert vlan tag to the payload.
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 27 ++++++++++---------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index bbedf2a8c60f..e8cbfada63ca 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4233,18 +4233,27 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff=
 *skb, struct net_device *dev)
>  {
>         struct dma_desc *desc, *first, *mss_desc =3D NULL;
>         struct stmmac_priv *priv =3D netdev_priv(dev);
> -       int nfrags =3D skb_shinfo(skb)->nr_frags;
> -       u32 queue =3D skb_get_queue_mapping(skb);
>         unsigned int first_entry, tx_packets;
>         struct stmmac_txq_stats *txq_stats;
> -       int tmp_pay_len =3D 0, first_tx;
> +       int tmp_pay_len =3D 0, first_tx, nfrags;
>         struct stmmac_tx_queue *tx_q;
> -       bool has_vlan, set_ic;
> +       bool set_ic;
>         u8 proto_hdr_len, hdr;
> -       u32 pay_len, mss;
> +       u32 pay_len, mss, queue;
>         dma_addr_t des;
>         int i;
>
> +       /* Always insert VLAN tag to SKB payload for TSO frames.
> +        *
> +        * Never insert VLAN tag by HW, since segments splited by
> +        * TSO engine will be un-tagged by mistake.
> +        */
> +       if (skb_vlan_tag_present(skb))
> +               skb =3D __vlan_hwaccel_push_inside(skb);

skb can be NULL after this point.

> +
> +       nfrags =3D skb_shinfo(skb)->nr_frags;
> +       queue =3D skb_get_queue_mapping(skb);
> +
>         tx_q =3D &priv->dma_conf.tx_queue[queue];
>         txq_stats =3D &priv->xstats.txq_stats[queue];
>         first_tx =3D tx_q->cur_tx;
> @@ -4297,9 +4306,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *=
skb, struct net_device *dev)
>                         skb->data_len);
>         }
>
> -       /* Check if VLAN can be inserted by HW */
> -       has_vlan =3D stmmac_vlan_insert(priv, skb, tx_q);
> -
>         first_entry =3D tx_q->cur_tx;
>         WARN_ON(tx_q->tx_skbuff[first_entry]);
>
> @@ -4309,9 +4315,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *=
skb, struct net_device *dev)
>                 desc =3D &tx_q->dma_tx[first_entry];
>         first =3D desc;
>
> -       if (has_vlan)
> -               stmmac_set_desc_vlan(priv, first, STMMAC_VLAN_INSERT);
> -
>         /* first descriptor: fill Headers on Buf1 */
>         des =3D dma_map_single(priv->device, skb->data, skb_headlen(skb),
>                              DMA_TO_DEVICE);
> @@ -7678,8 +7681,6 @@ int stmmac_dvr_probe(struct device *device,
>                 ndev->features |=3D NETIF_F_RXHASH;
>
>         ndev->vlan_features |=3D ndev->features;
> -       /* TSO doesn't work on VLANs yet */
> -       ndev->vlan_features &=3D ~NETIF_F_TSO;
>
>         /* MTU range: 46 - hw-specific max */
>         ndev->min_mtu =3D ETH_ZLEN - ETH_HLEN;
> --
> 2.34.1
>

