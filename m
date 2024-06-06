Return-Path: <linux-kernel+bounces-205105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 223F68FF71B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D871F22CAD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD113D89F;
	Thu,  6 Jun 2024 21:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="JLRVJQOL"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E884594A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717710888; cv=none; b=Va+BqWEpGmC32HXo2DIqxyA8s092/Q+ylminEU7E3fDI1ILmTid+1UYJ09I05GtpKNGRMN8HVNKwwc/6NbGjLSRxNviQS+Hk7rsRc97am071cK4ifensMVhwzotSaFjkg1vgQlR90M08kfqoGsNhYAxSUiQvv1C9n2Lbiw9lLNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717710888; c=relaxed/simple;
	bh=mDagFXChBVcpHR+wLzC5wM9bMzN7oj68g+1GOs8ojLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qxc1ulRgnIf8yd2wT+7UKCJ0wLSPDqX/cuiL1cCIs0RAKPX5kiHfY+1+2MbYX+hdkQoGqkz8kWG0aen79DLkw2Ye5fYsy1gJ2/gBxalE+FEy2S3FNwhPoPZuJEtdeKdXYeEyj4Lrcawbh8qwTa6pPe1Zt+6y9hTfo33MGd8kyt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=JLRVJQOL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70255d5ddc7so1265329b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 14:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717710884; x=1718315684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVv1Qc4TM0+6AjuDwtHzIaIdzcyFOnd/Bm5wgzbgEN4=;
        b=JLRVJQOL+QLw/c0DNvGatiqu1qMKvzA5jGF8XsMYXviPNbiZvkJxGsR/9lb38UHiCc
         bRvOegp7sAr+L2zRDZbFMGelZvb3pfj/VLDAIyKDiusmIz1C6jSfd1rrf1zcx6VIXbm6
         bcqVpmkObomHRLbG7lfwW82bT6FEEpybOf47U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717710884; x=1718315684;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVv1Qc4TM0+6AjuDwtHzIaIdzcyFOnd/Bm5wgzbgEN4=;
        b=YwKdyMUsYLH0JGtjpdzh+we/di2dKcYmp0jJ/6zu8FTzQrsA5LLV1vxAGSYhNWMJwn
         ehpTm9XZN9MOFS21nBp377zD30BOupi5n8MsBrKJMK2drCx/cqFdN5VuLI8w4lY2j9yL
         PBidEe0ZVeXBIUC5tqQVQPbAQbuUY9QQX5hSne6bASHTGdBRTOuadAeK7FL4xtP346/n
         DcjGfmwE22JGnm9M9DGn63huFY8V1VBAufHyGMa2LeiB5bCdGz8mDR6wGMalqBG5mBPp
         JJDXbgm6ih+xUaMhZiJ4ECE5WGlX1h3u/oJMXM8Nwituc2c9VpayLw3jOtMH34J+b6/N
         jWhw==
X-Forwarded-Encrypted: i=1; AJvYcCVeQVD4CrHoyZHAboVrGfqWQN4UL6YjKsxbHB28zWMmd1wgiKP62sG7FBk3a2X7NThAEWoj4LJa/tCwF15oIhQgkZUQEB/K0ebG46ud
X-Gm-Message-State: AOJu0Yw8zHz94loI/EzgdGLfDfA7bDLGVtyid/soKgtuBAkhJ+KCbctx
	zWXxXI7onLp7tt6S2uIQgyNkpKeZNnyE9+a5dCujG8de7JV+70ZmxHKSp8CQmPA=
X-Google-Smtp-Source: AGHT+IGbQWUbSg8uxdL6sn1f98rKX69lmpOdbNgRL44efMTCIjzInKv97HauHUmJmLf7qXpAEAr0nw==
X-Received: by 2002:a05:6a21:81a7:b0:1b2:b02f:d145 with SMTP id adf61e73a8af0-1b2f9cbe236mr766742637.54.1717710884210;
        Thu, 06 Jun 2024 14:54:44 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd778fc2sm20190725ad.119.2024.06.06.14.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:54:43 -0700 (PDT)
Date: Thu, 6 Jun 2024 14:54:40 -0700
From: Joe Damato <jdamato@fastly.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	nalramli@fastly.com, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [RFC net-next v4 2/2] net/mlx5e: Add per queue netdev-genl stats
Message-ID: <ZmIwIJ9rxllqQT18@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, nalramli@fastly.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
References: <20240604004629.299699-1-jdamato@fastly.com>
 <20240604004629.299699-3-jdamato@fastly.com>
 <11b9c844-a56e-427f-aab3-3e223d41b165@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11b9c844-a56e-427f-aab3-3e223d41b165@gmail.com>

On Thu, Jun 06, 2024 at 11:11:57PM +0300, Tariq Toukan wrote:
> 
> 
> On 04/06/2024 3:46, Joe Damato wrote:
> > ./cli.py --spec netlink/specs/netdev.yaml \
> >           --dump qstats-get --json '{"scope": "queue"}'
> > 
> > ...snip
> > 
> >   {'ifindex': 7,
> >    'queue-id': 62,
> >    'queue-type': 'rx',
> >    'rx-alloc-fail': 0,
> >    'rx-bytes': 105965251,
> >    'rx-packets': 179790},
> >   {'ifindex': 7,
> >    'queue-id': 0,
> >    'queue-type': 'tx',
> >    'tx-bytes': 9402665,
> >    'tx-packets': 17551},
> > 
> > ...snip
> > 
> > Also tested with the script tools/testing/selftests/drivers/net/stats.py
> > in several scenarios to ensure stats tallying was correct:
> > 
> > - on boot (default queue counts)
> > - adjusting queue count up or down (ethtool -L eth0 combined ...)
> > 
> > The tools/testing/selftests/drivers/net/stats.py brings the device up,
> > so to test with the device down, I did the following:
> > 
> > $ ip link show eth4
> > 7: eth4: <BROADCAST,MULTICAST> mtu 9000 qdisc mq state DOWN [..snip..]
> >    [..snip..]
> > 
> > $ cat /proc/net/dev | grep eth4
> > eth4: 235710489  434811 [..snip rx..] 2878744 21227  [..snip tx..]
> > 
> > $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
> >             --dump qstats-get --json '{"ifindex": 7}'
> > [{'ifindex': 7,
> >    'rx-alloc-fail': 0,
> >    'rx-bytes': 235710489,
> >    'rx-packets': 434811,
> >    'tx-bytes': 2878744,
> >    'tx-packets': 21227}]
> > 
> > Compare the values in /proc/net/dev match the output of cli for the same
> > device, even while the device is down.
> > 
> > Note that while the device is down, per queue stats output nothing
> > (because the device is down there are no queues):
> 
> This part is not true anymore.

It is true with this patch applied and running the command below.
Maybe I should have been more explicit that using cli.py outputs []
when scope = queue, which could be an internal cli.py thing, but
this is definitely true with this patch.

Did you test it and get different results?

> > 
> > $ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
> >             --dump qstats-get --json '{"scope": "queue", "ifindex": 7}'
> > []
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >   .../net/ethernet/mellanox/mlx5/core/en_main.c | 138 ++++++++++++++++++
> >   1 file changed, 138 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > index d03fd1c98eb6..76d64bbcf250 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > @@ -39,6 +39,7 @@
> >   #include <linux/debugfs.h>
> >   #include <linux/if_bridge.h>
> >   #include <linux/filter.h>
> > +#include <net/netdev_queues.h>
> >   #include <net/page_pool/types.h>
> >   #include <net/pkt_sched.h>
> >   #include <net/xdp_sock_drv.h>
> > @@ -5279,6 +5280,142 @@ static bool mlx5e_tunnel_any_tx_proto_supported(struct mlx5_core_dev *mdev)
> >   	return (mlx5_vxlan_allowed(mdev->vxlan) || mlx5_geneve_tx_allowed(mdev));
> >   }
> > +static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
> > +				     struct netdev_queue_stats_rx *stats)
> > +{
> > +	struct mlx5e_priv *priv = netdev_priv(dev);
> > +	struct mlx5e_channel_stats *channel_stats;
> > +	struct mlx5e_rq_stats *xskrq_stats;
> > +	struct mlx5e_rq_stats *rq_stats;
> > +
> > +	ASSERT_RTNL();
> > +	if (mlx5e_is_uplink_rep(priv))
> > +		return;
> > +
> > +	/* ptp was ever opened, is currently open, and channel index matches i
> > +	 * then export stats
> > +	 */
> > +	if (priv->rx_ptp_opened && priv->channels.ptp) {
> > +		if (test_bit(MLX5E_PTP_STATE_RX, priv->channels.ptp->state) &&
> > +		    priv->channels.ptp->rq.ix == i) {
> 
> PTP RQ index is naively assigned to zero:
> rq->ix           = MLX5E_PTP_CHANNEL_IX;
> 
> but this isn't to be used as the stats index.
> Today, the PTP-RQ has no matcing rxq in the kernel level.
> i.e. turning PTP-RQ on won't add a kernel-level RXQ to the
> real_num_rx_queues.
> Maybe we better do.
> If not, and the current state is kept, the best we can do is let the PTP-RQ
> naively contribute its queue-stat to channel 0.

OK, it sounds like the easiest thing to do is just count PTP as
channel 0, so if i == 0, I'll in the PTP stats.

But please see below regarding testing whether or not PTP is
actually enabled or not.

> > +			rq_stats = &priv->ptp_stats.rq;
> > +			stats->packets = rq_stats->packets;
> > +			stats->bytes = rq_stats->bytes;
> > +			stats->alloc_fail = rq_stats->buff_alloc_err;
> > +			return;
> > +		}
> > +	}
> > +
> > +	channel_stats = priv->channel_stats[i];
> > +	xskrq_stats = &channel_stats->xskrq;
> > +	rq_stats = &channel_stats->rq;
> > +
> > +	stats->packets = rq_stats->packets + xskrq_stats->packets;
> > +	stats->bytes = rq_stats->bytes + xskrq_stats->bytes;
> > +	stats->alloc_fail = rq_stats->buff_alloc_err +
> > +			    xskrq_stats->buff_alloc_err;
> > +}
> > +
> > +static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
> > +				     struct netdev_queue_stats_tx *stats)
> > +{
> > +	struct mlx5e_priv *priv = netdev_priv(dev);
> > +	struct mlx5e_sq_stats *sq_stats;
> > +
> > +	ASSERT_RTNL();
> > +	/* no special case needed for ptp htb etc since txq2sq_stats is kept up
> > +	 * to date for active sq_stats, otherwise get_base_stats takes care of
> > +	 * inactive sqs.
> > +	 */
> > +	sq_stats = priv->txq2sq_stats[i];
> > +	stats->packets = sq_stats->packets;
> > +	stats->bytes = sq_stats->bytes;
> > +}
> > +
> > +static void mlx5e_get_base_stats(struct net_device *dev,
> > +				 struct netdev_queue_stats_rx *rx,
> > +				 struct netdev_queue_stats_tx *tx)
> > +{
> > +	struct mlx5e_priv *priv = netdev_priv(dev);
> > +	int i, tc;
> > +
> > +	ASSERT_RTNL();
> > +	if (!mlx5e_is_uplink_rep(priv)) {
> > +		rx->packets = 0;
> > +		rx->bytes = 0;
> > +		rx->alloc_fail = 0;
> > +
> > +		for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++) {
> > +			struct netdev_queue_stats_rx rx_i = {0};
> > +
> > +			mlx5e_get_queue_stats_rx(dev, i, &rx_i);
> > +
> > +			rx->packets += rx_i.packets;
> > +			rx->bytes += rx_i.bytes;
> > +			rx->alloc_fail += rx_i.alloc_fail;
> > +		}
> > +
> > +		if (priv->rx_ptp_opened) {
> > +			/* if PTP was opened, but is not currently open, then
> > +			 * report the stats here. otherwise,
> > +			 * mlx5e_get_queue_stats_rx will get it
> > +			 */
> 
> We shouldn't care if the RQ is currently open. The stats are always there.
> This applies to all RQs and SQs.

The idea was that if PTP was opened before but the bit was set to
signal that it is closed now, it would reported in base because it's
inactive -- like other inactive RQs.

If it was opened before --AND-- the open bit was set, it'll be
reported with channel 0 stats in mlx5e_get_queue_stats_rx.

That makes sense to me, but it sounds like you are saying something
different?

Are you saying to always report it with channel 0 in
mlx5e_get_queue_stats_rx even if:

  - !priv->rx_ptp_opened  (meaning it was never opened, and thus
    would be zero)

        and

  - (priv->rx_ptp_opened && !test_bit(MLX5E_PTP_STATE_RX,
    priv->channels.ptp->state)) meaning it was opened before, but is
    currently closed 

If so, that means we never report PTP in base. Is that what you want
me to do?

I honestly don't care either way but this seems slightly
inconsistent, doesn't it?

If base is reporting inactive RQs, shouldn't PTP be reported here if
its inactive ?

Please let me know.

> > +			if (priv->channels.ptp &&
> > +			    !test_bit(MLX5E_PTP_STATE_RX, priv->channels.ptp->state)) {
> > +				struct mlx5e_rq_stats *rq_stats = &priv->ptp_stats.rq;
> > +
> > +				rx->packets += rq_stats->packets;
> > +				rx->bytes += rq_stats->bytes;
> > +			}
> > +		}
> > +	}
> > +
> > +	tx->packets = 0;
> > +	tx->bytes = 0;
> > +
> > +	for (i = 0; i < priv->stats_nch; i++) {
> > +		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
> > +
> > +		/* while iterating through all channels [0, stats_nch], there
> > +		 * are two cases to handle:
> > +		 *
> > +		 *  1. the channel is available, so sum only the unavailable TCs
> > +		 *     [mlx5e_get_dcb_num_tc, max_opened_tc).
> > +		 *
> > +		 *  2. the channel is unavailable, so sum all TCs [0, max_opened_tc).
> > +		 */
> 
> Even if the channel is not available, mlx5e_get_queue_stats_tx() accesses
> and returns its stats.

Ah, yes. My mistake.

> Here you need to only cover SQs that have no mapping in range
> [0..real_num_tx_queues - 1].

So, that means the loops should be:

outer loop: [0, priv->stats_nch)
    inner loop: [ mlx5e_get_dcb_num_tc, max_opened_tc )

Right? That would be only the SQs which have no mapping, I think.

> > +		if (i < priv->channels.params.num_channels)
> > +			tc = mlx5e_get_dcb_num_tc(&priv->channels.params);
> > +		else
> > +			tc = 0;
> > +
> > +		for (; tc < priv->max_opened_tc; tc++) {
> > +			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[tc];
> > +
> > +			tx->packets += sq_stats->packets;
> > +			tx->bytes += sq_stats->bytes;
> > +		}
> > +	}
> > +
> > +	if (priv->tx_ptp_opened) {
> > +		/* only report PTP TCs if it was opened but is now closed */
> > +		if (priv->channels.ptp && !test_bit(MLX5E_PTP_STATE_TX, priv->channels.ptp->state)) {
> > +			for (tc = 0; tc < priv->channels.ptp->num_tc; tc++) {
> > +				struct mlx5e_sq_stats *sq_stats = &priv->ptp_stats.sq[tc];
> > +
> > +				tx->packets += sq_stats->packets;
> > +				tx->bytes   += sq_stats->bytes;
> > +			}
> > +		}
> > +	}
> > +}
> > +
> > +static const struct netdev_stat_ops mlx5e_stat_ops = {
> > +	.get_queue_stats_rx  = mlx5e_get_queue_stats_rx,
> > +	.get_queue_stats_tx  = mlx5e_get_queue_stats_tx,
> > +	.get_base_stats      = mlx5e_get_base_stats,
> > +};
> > +
> >   static void mlx5e_build_nic_netdev(struct net_device *netdev)
> >   {
> >   	struct mlx5e_priv *priv = netdev_priv(netdev);
> > @@ -5296,6 +5433,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
> >   	netdev->watchdog_timeo    = 15 * HZ;
> > +	netdev->stat_ops	  = &mlx5e_stat_ops;
> >   	netdev->ethtool_ops	  = &mlx5e_ethtool_ops;
> >   	netdev->vlan_features    |= NETIF_F_SG;

