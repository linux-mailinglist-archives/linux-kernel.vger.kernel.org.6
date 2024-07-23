Return-Path: <linux-kernel+bounces-260229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0540D93A4BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D021F23B41
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81061586C5;
	Tue, 23 Jul 2024 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qCTatXom"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECCB14C5A1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754696; cv=none; b=gGmjGudc4BtFYHTG2aXtMZEqS6cy2FU/WcXv+Tb4olNyU9mqTLAkie0dqaxHqvIdUVOmZSGmvIdT+0XlQoxQ3/6HMV9TdJJpEaThtCPwckgWdH8zQ1hd7+N+3M1QxdcpluEUqoMWOe8c1Z+Gnpjc9raOcRCCtft67cM/nNo5WpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754696; c=relaxed/simple;
	bh=isWGflkoO86SgZH3nmLkfFtT7g7nJqjcDjS/VDDroJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXI1G4DNzHTCziDAch9GPX+CD9dXOWAThx5ln+e7UhIUhAH3/qn4/rO0vxgL5aYw6ksCzSAnHk6AE89GgdNXVmo2rT6R/TlQHpA293kfDjRIR4cuRWJgjtxJpd8ItIZ6DZhyJdXH/0VI3kT61k0S2VHXgaXGnOYjFbctlItOMqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qCTatXom; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7a211a272c2so29527a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721754693; x=1722359493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lbPE0UM3Jrs4ydCsNHNwpK7/1H6fvrGuUR3T5aqgjQ=;
        b=qCTatXomcWrhT71d+Ag2BbyduM46bOfs3X/QLugKUL+34Ye9cIKxq3ni5dOtlvf+PD
         pezzWmKLAtJ8Tu6uhuUkAhhckj6d3CDoSMOZS5K3VxOuc9h4vq6t3dI8LKmCUmrmbu5i
         d2W6yCzY6A9NDfcNbmt4qFixwpg47YeL7b4+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721754693; x=1722359493;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lbPE0UM3Jrs4ydCsNHNwpK7/1H6fvrGuUR3T5aqgjQ=;
        b=tJVJmuEy5K2QrIk7jLQJkYrDL6yfQF6WRYsy5Upn6/Ye7pBGfpJBwn1U5ZrhP9LQnb
         dRG5d7Kcl3jQPjdNJma+MWtS57DE1jsjnttS9TB2nUXAp4qaLsxZmjSpjLC81mPqhkGl
         6HOD3stXwqWz2OyPRScMiBVRrHCR1QOnDZooSHgjkWWlWlJLqUA+u7k7BEAQeNB5nIA5
         QCjVeot0gpixSyjLJj08QEZv1vjF44oxmDl3Y6oJPEAuBhnSBIrg972XFsFIxzHPKxJ2
         4vEK+WgOwvW5itQA1goEtIBQ1J2oecPqVP0kVNpEakEHSWW9d9wvLzPPItjncOhL7YMN
         63Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVIVg+YZJib1I5gVCwAjtSHTPSQSux5uUlG3kdCrPSqTSV2MA8c0oC7I2LfZEWgKvjTAnl4J3LwCCtwEUyXeL1sudBKdD2+CZSteR73
X-Gm-Message-State: AOJu0YzhIAsCzNX2EcWgAYtOsgNQjh5UvAQvPW4oEwG7Ytdfdluf7r2K
	Q4vk6JRi6x+vWLSdg7a2HX5MUexDPzzeJr0iQyjQISCCxQVf8Ilcbk/3E3Xhtt4=
X-Google-Smtp-Source: AGHT+IERjQE12AVH/9qhh0rA29w4YYdzDBuRUtXQS1+HbTSvKLuxlXY1F1l06HpgRZuGpGjZgC3M/w==
X-Received: by 2002:a17:90b:4b8e:b0:2c2:d6ca:3960 with SMTP id 98e67ed59e1d1-2cd8d10997dmr4384702a91.17.1721754693040;
        Tue, 23 Jul 2024 10:11:33 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb773045ebsm10516402a91.16.2024.07.23.10.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 10:11:32 -0700 (PDT)
Date: Tue, 23 Jul 2024 10:11:29 -0700
From: Joe Damato <jdamato@fastly.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Julien Panis <jpanis@baylibre.com>, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, srk@ti.com, vigneshr@ti.com,
	danishanwar@ti.com, pekka Varis <p-varis@ti.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/6] net: ethernet: ti: am65-cpsw: Introduce
 multi queue Rx
Message-ID: <Zp_kQX3dj3J1_u6o@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Roger Quadros <rogerq@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Julien Panis <jpanis@baylibre.com>, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>, srk@ti.com, vigneshr@ti.com,
	danishanwar@ti.com, pekka Varis <p-varis@ti.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
References: <20240703-am65-cpsw-multi-rx-v3-0-f11cd860fd72@kernel.org>
 <20240703-am65-cpsw-multi-rx-v3-1-f11cd860fd72@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703-am65-cpsw-multi-rx-v3-1-f11cd860fd72@kernel.org>

On Wed, Jul 03, 2024 at 04:51:32PM +0300, Roger Quadros wrote:

[...]

> @@ -699,6 +727,14 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
>  		goto fail_rx;
>  	}
>  
> +	for (i = 0; i < common->rx_ch_num_flows ; i++) {
> +		napi_enable(&common->rx_chns.flows[i].napi_rx);
> +		if (common->rx_chns.flows[i].irq_disabled) {
> +			common->rx_chns.flows[i].irq_disabled = false;

Just a minor nit (not a reason to hold this back): I've been
encouraging folks to use the new netdev-genl APIs in their drivers
to map NAPIs to queues and IRQs if possible because it allows for
more expressive and interesting userland applications.

You may consider in the future using something vaguely like (this is
untested psuedo-code I just typed out):

   netif_napi_set_irq(&common->rx_chns.flows[i].napi_rx,
                      common->rx_chns.flows[i].irq);

and 

   netif_queue_set_napi(common->dev, i, NETDEV_QUEUE_TYPE_RX,
                        &common->rx_chns.flows[i].napi_rx);

To link everything together (note that RTNL must be held while doing
this -- I haven't checked your code path to see if that is true here).

For an example, see 64b62146ba9e ("net/mlx4: link NAPI instances to
queues and IRQs). 

Doing this would allow userland to get data via netlink, which you
can examine yourself by using cli.py like this:

python3 tools/net/ynl/cli.py \
  --spec Documentation/netlink/specs/netdev.yaml \
  --dump queue-get

python3 tools/net/ynl/cli.py \
  --spec Documentation/netlink/specs/netdev.yaml \
  --dump napi-get

> +			enable_irq(common->rx_chns.flows[i].irq);
> +		}
> +	}
> +
>  	for (tx = 0; tx < common->tx_ch_num; tx++) {
>  		ret = k3_udma_glue_enable_tx_chn(tx_chn[tx].tx_chn);
>  		if (ret) {
> @@ -710,12 +746,6 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
>  		napi_enable(&tx_chn[tx].napi_tx);
>  	}
>  
> -	napi_enable(&common->napi_rx);
> -	if (common->rx_irq_disabled) {
> -		common->rx_irq_disabled = false;
> -		enable_irq(rx_chn->irq);
> -	}
> -
>  	dev_dbg(common->dev, "cpsw_nuss started\n");
>  	return 0;
>  
> @@ -726,11 +756,24 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
>  		tx--;
>  	}
>  
> +	for (flow_idx = 0; i < common->rx_ch_num_flows; flow_idx++) {
> +		flow = &rx_chn->flows[flow_idx];
> +		if (!flow->irq_disabled) {
> +			disable_irq(flow->irq);
> +			flow->irq_disabled = true;
> +		}
> +		napi_disable(&flow->napi_rx);
> +	}
> +
>  	k3_udma_glue_disable_rx_chn(rx_chn->rx_chn);
>  
>  fail_rx:
> -	k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, 0, rx_chn,
> -				  am65_cpsw_nuss_rx_cleanup, 0);
> +	for (i = 0; i < common->rx_ch_num_flows; i--)
> +		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, &rx_chn->flows[i],
> +					  am65_cpsw_nuss_rx_cleanup, !!i);
> +
> +	am65_cpsw_destroy_xdp_rxqs(common);
> +
>  	return ret;
>  }
>  
> @@ -779,12 +822,12 @@ static int am65_cpsw_nuss_common_stop(struct am65_cpsw_common *common)
>  			dev_err(common->dev, "rx teardown timeout\n");
>  	}
>  
> -	napi_disable(&common->napi_rx);
> -	hrtimer_cancel(&common->rx_hrtimer);
> -
> -	for (i = 0; i < AM65_CPSW_MAX_RX_FLOWS; i++)
> -		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, rx_chn,
> +	for (i = 0; i < common->rx_ch_num_flows; i++) {
> +		napi_disable(&common->rx_chns.flows[i].napi_rx);

The inverse of the above is probably true somewhere around here;
again a small piece of psuedo code for illustrative purposes:

   netif_queue_set_napi(common->dev, i, NETDEV_QUEUE_TYPE_RX, NULL);

> +		hrtimer_cancel(&common->rx_chns.flows[i].rx_hrtimer);
> +		k3_udma_glue_reset_rx_chn(rx_chn->rx_chn, i, &rx_chn->flows[i],
>  					  am65_cpsw_nuss_rx_cleanup, !!i);
> +	}
>  
>  	k3_udma_glue_disable_rx_chn(rx_chn->rx_chn);
>  

