Return-Path: <linux-kernel+bounces-449830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496799F56AA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55E0D18939DE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21401F9405;
	Tue, 17 Dec 2024 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Qi1/LXSx"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CC01F76DA
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734462252; cv=none; b=pjKGV2t6BX81WPIKn+JDxzERRzDbqcfs9FzdxhDhWeuyQjK3MKpav2aK1IhuslEPweB8lS6wYRQw1+G8tohOmtvTi3mtBKArUHc8Av4f6b58oCQK+B1iHYj/lDETDsj4IvWHiZs3JYYJfuyk83blDUK3WtZBdXED6mGrP7YHUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734462252; c=relaxed/simple;
	bh=jPr1fiLzQKQshsYCM0HhYICbbGSGu9nt2W3zqbl1eic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucKdvChfl4UNsVc8rNVYL/PBO1q8pWMXsAxKTScB3Iswz7oA8hgkxk4+cBidZdeZN1ai7lw6+/htd2FtuRwQYzxpISMEJTI9kfnP+sAip5L/KkGh/vG0/CgNKhH2fWEgF2F9jTtOkaFE+27S/l5GNhWO53RnnVv6DXoc/ePNazw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Qi1/LXSx; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-725abf74334so4981841b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1734462248; x=1735067048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKJBJiI/cCQJDsqcNpZzhWufhzaH41z5oYV6DpzM/Eo=;
        b=Qi1/LXSxWPo79F5K6WUx2Ss7OFHrPz/PPHnucDSKChfuL/04x2EMlDpK2ty3Q5hfOi
         LRwg/o3BKHsmPU70aHViEotPWYiNy9Dx15+jlZNPrTpW/0YJsY9IG8qQZ81E95fPgmfB
         2iMTk70oBue4mk3pLkuU6ZO5d6+VM2lLULwI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734462248; x=1735067048;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKJBJiI/cCQJDsqcNpZzhWufhzaH41z5oYV6DpzM/Eo=;
        b=cdG3/p8J7PTn8bRx5l+VLGqGbpnFOgroGjp8VtBQapJqt7/U4bmCqT9ikzhDBa/eK4
         JBEmby4Q+qE+8xGUe8tobRqy5LxqY97JVKm0jKBznRY9UMs3oh/3IzB9EfYGQndv7VHB
         9qxxm0Pd71lVPzYsMj5H5IgTHH1mzDCOoIE3R2rC7GRCWQ4206s8soXXY9LTKnfgnOIG
         IFJUTSVm7jKOvyYmTOdd+LUVWG+c6PUOKpepNKjtkDB7++FqXqt6TF2os9vLYB7IQnYt
         7D+KSazeWfxqDtuEMuuJC/X5eXc81NRWeM6O+TeILmEr/bShnMtiCGjhkiUjukG1Ptvl
         5DrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Huy0y4AAP/2DyLMhNIJq2ZHowI/CBpt9OT3whhCslMpThov3mpFwmmsOw8tI18jE/Xs0Y3rCY7wwW9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwOW3MIZ0HZK/zwlXNK6bixXjFzuhBNRCbdhOOTpCO5vuwhBto
	+TR8SW/Wrxg5x2xCoFnMLgxn1uRhJWgHZ5kOH2XvxvRaQfKseDPwWuMXjWiZDok=
X-Gm-Gg: ASbGncsK5h3THSIwA1vtz/zJdEajhMTuTmLrHZFVvIzzFjynBx5s1Uj2PLEAPHeWcJw
	BHsmAGrKDxajMd/yZwDanl8Ub2IZhCZw0TrFQmhNQDmtr/1TblKaqzjB+2Gi+K8zKtqwPUnz23Z
	SThN7qquntUiy+Whzft3mdI4W0C8OwB5TeHKMzyG2nOs4TCHJRv/U7ekfaPhX8PhwT0Dw8k+lmJ
	oSkcDhyKJqVBQE+bi24x2qI4hfQr2qs1Nr6ALebs2aIvRTg8a62vUSMHJXxUFFUp/XTAhdhUovx
	wDDEw1AO8nGQuU2QoH8fel8=
X-Google-Smtp-Source: AGHT+IE+GB/uOPJugYId7Ak0rCgLL5JK0sjF/ExW6l2pU/DIdUf+9Oge4ycpx+fvSa4yS9mkavnIgA==
X-Received: by 2002:a05:6a21:78a7:b0:1dc:37a:8dc0 with SMTP id adf61e73a8af0-1e5b48228b3mr227465637.21.1734462248303;
        Tue, 17 Dec 2024 11:04:08 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b790a6sm7240393b3a.128.2024.12.17.11.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 11:04:07 -0800 (PST)
Date: Tue, 17 Dec 2024 11:04:04 -0800
From: Joe Damato <jdamato@fastly.com>
To: admiyo@os.amperecomputing.com
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v9 1/1] mctp pcc: Implement MCTP over PCC Transport
Message-ID: <Z2HLJD8z3wFNvnlV@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	admiyo@os.amperecomputing.com,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
References: <20241217182528.108062-1-admiyo@os.amperecomputing.com>
 <20241217182528.108062-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217182528.108062-2-admiyo@os.amperecomputing.com>

On Tue, Dec 17, 2024 at 01:25:28PM -0500, admiyo@os.amperecomputing.com wrote:
> From: Adam Young <admiyo@os.amperecomputing.com>
> 
> Implementation of network driver for
> Management Control Transport Protocol(MCTP) over
> Platform Communication Channel(PCC)
> 
> DMTF DSP:0292
> https://www.dmtf.org/sites/default/files/standards/documents/DSP0292_1.0.0WIP50.pdf
> 
> MCTP devices are specified by entries in DSDT/SDST and
> reference channels specified in the PCCT.
> 
> Communication with other devices use the PCC based
> doorbell mechanism.
> 
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
> ---
>  drivers/net/mctp/Kconfig    |  13 ++
>  drivers/net/mctp/Makefile   |   1 +
>  drivers/net/mctp/mctp-pcc.c | 320 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 334 insertions(+)
>  create mode 100644 drivers/net/mctp/mctp-pcc.c

[...]
 
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-pcc.c
> @@ -0,0 +1,320 @@

[...]

> +static void mctp_pcc_client_rx_callback(struct mbox_client *c, void *buffer)
> +{
> +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> +	struct mctp_pcc_hdr mctp_pcc_hdr;
> +	struct pcpu_dstats *dstats;
> +	struct mctp_skb_cb *cb;
> +	struct sk_buff *skb;
> +	void *skb_buf;
> +	u32 data_len;
> +
> +	mctp_pcc_ndev = container_of(c, struct mctp_pcc_ndev, inbox.client);
> +	memcpy_fromio(&mctp_pcc_hdr, mctp_pcc_ndev->inbox.chan->shmem,
> +		      sizeof(struct mctp_pcc_hdr));
> +	data_len = mctp_pcc_hdr.length + MCTP_HEADER_LENGTH;
> +	skb = netdev_alloc_skb(mctp_pcc_ndev->mdev.dev, data_len);
> +
> +	dstats = this_cpu_ptr(mctp_pcc_ndev->mdev.dev->dstats);
> +	u64_stats_update_begin(&dstats->syncp);
> +	if (data_len > mctp_pcc_ndev->mdev.dev->mtu) {
> +		u64_stats_inc(&dstats->rx_drops);
> +		u64_stats_inc(&dstats->rx_drops);

Double counting rx_drops ?

> +		u64_stats_update_end(&dstats->syncp);
> +		return;
> +	}
> +	if (!skb) {
> +		u64_stats_inc(&dstats->rx_drops);
> +		u64_stats_update_end(&dstats->syncp);
> +		return;
> +	}
> +	u64_stats_inc(&dstats->rx_packets);
> +	u64_stats_add(&dstats->rx_bytes, data_len);
> +	u64_stats_update_end(&dstats->syncp);

I suspect what Jeremy meant (but please feel free to correct me if
I'm mistaken, Jeremy) was that you may want to use the helpers in:

include/linux/netdevice.h

e.g. 

  dev_dstats_rx_add(mctp_pcc_ndev->mdev.dev, data_len);
  dev_dstats_rx_dropped(mctp_pcc_ndev->mdev.dev);

etc.

[...]

> +
> +static netdev_tx_t mctp_pcc_tx(struct sk_buff *skb, struct net_device *ndev)
> +{
> +	struct mctp_pcc_ndev *mpnd = netdev_priv(ndev);
> +	struct mctp_pcc_hdr  *mctp_pcc_header;
> +	struct pcpu_dstats *dstats;
> +	void __iomem *buffer;
> +	unsigned long flags;
> +	int len = skb->len;
> +
> +	dstats = this_cpu_ptr(ndev->dstats);
> +	u64_stats_update_begin(&dstats->syncp);
> +	u64_stats_inc(&dstats->tx_packets);
> +	u64_stats_add(&dstats->tx_bytes, skb->len);
> +	u64_stats_update_end(&dstats->syncp);

Likewise, as above with the helpers from include/linux/netdevice.h:

  dev_dstats_tx_add( ... );
  dev_dstats_tx_dropped( ... );

But, I'll let Jeremy weigh-in to make sure I've not misspoken.

[...]

> +
> +static void  mctp_pcc_setup(struct net_device *ndev)
              ^^  nit: double space ?

[...]

> +static acpi_status lookup_pcct_indices(struct acpi_resource *ares,
> +				       void *context)
> +{
> +	struct  mctp_pcc_lookup_context *luc = context;
              ^^ nit: double space?

[...]

> +static int mctp_pcc_driver_add(struct acpi_device *acpi_dev)
> +{

[...]

> +
> +	rc =  devm_add_action_or_reset(dev, mctp_cleanup_netdev, ndev);
            ^^ nit: double space

