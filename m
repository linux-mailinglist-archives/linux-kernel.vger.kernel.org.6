Return-Path: <linux-kernel+bounces-397331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BB79BDA8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217781C21076
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6A313774D;
	Wed,  6 Nov 2024 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="VZxZk1fh"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DCF1E531
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 00:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730854167; cv=none; b=Aj1P1l7D39qG+LxTKUbYzmDYQvjjZXCRUi9EVFpgamYkgA6qvm0Ba3H2p02bTNUDbPzJd2Ohl0dZKW7BvnOyuOc+tyZuXHLk3W+mOimUZGg2AXea+5AkzJ+Bi+ItpFSmukdAOG2nongynCtYF95izB6BnL3JaFaveY/xOyP0yXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730854167; c=relaxed/simple;
	bh=8alYkSC0d4GDEAmAJNmIFwALZvqsUkrszN/g7X8E+JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLih76kv3LdxSwVPiC+Xm4ReEdXqp649YR+gqSpCJsRWPRcxcyWcTp3zYUS42k6yHuY/bb/j5i+R9aq3Uj8uYXYQJM020KoJ6h1+zmdIU2yfCu3p3GoKR1tjcTxK0h227BCcxltk9DRrnSB0cSoIE9Dypgw/CsIcP0sf6f35VUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=VZxZk1fh; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720be27db27so4965363b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 16:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730854164; x=1731458964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGRubnZWYrBUFGyU3xJJ0G3R2jRuKcB/j3KXOYeGS78=;
        b=VZxZk1fhpsHS5jO69cyLdil3Lsx3GIPVSWq4TwrHLZbGLmHt8bCzvNYBZgDV2kCKDF
         p5qP7WnK8FDMlGWWH6ltaX9z4RKHsppN1nxoJF2tRFPwDtzRore6/RMv0CTL5IhvTzdY
         3Wf9xo14gdjxDjrPzE2pMvTd0pEXhBMWjwBzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730854164; x=1731458964;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGRubnZWYrBUFGyU3xJJ0G3R2jRuKcB/j3KXOYeGS78=;
        b=BllXe+zo2GUZfP2sixuiUncAlw+DQTOET07orY3ss7SrvIE4aE0+kf77ej/hwkn3vc
         vaH8gcyP/lof7HUGq2YlkVA9ajQM32xMM9aVJfj5Mih/ehn4PcHlQ5/ssgR2iW7QhovX
         72+ucj/9f7/6nWBUaLVRZCqsShenDD4Y05sIguRoksZ3149fh7K8nB3SNFqN8wYK2bV6
         Iluprf1he1R9J3TcVp5QFz3Wj94X37H9qRPAbTuQDvtNK0UjBC7ChZXJBOzViKfv1PGD
         ozhSNjsXrkszaawNajfxhzpNcIav+yd7kRlJF++dXS/SZDUNt3vUfF9DRn3tUUtI/wLa
         cTWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk7pHuVfEvMCMbuJbGPYrK+C2eCSmJgnhrY26yFYNEEbK9XSi1PvoFit4g9F1QM+cFm95aF/4RQZBZh7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYGhC0U11wXtCT5AA99cj8yIKGSlrY/hof1I8iLM+gfrneyKN6
	Z3Uq8Wt1nuBVaASifBH30AJtNDbgsWpQGpVM9hHqdaKwdFWB5ARRlql9RocLjng=
X-Google-Smtp-Source: AGHT+IENhlWDEOcWBHMp6biKldszv4g/mbnz2x1xwY0kfgpP4IIHjZB7ymA6YSj2YpiwaHiaQjR2+A==
X-Received: by 2002:a05:6a00:331b:b0:721:19bc:4bf4 with SMTP id d2e1a72fcca58-72119bc986cmr15810887b3a.23.1730854163991;
        Tue, 05 Nov 2024 16:49:23 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1e582esm10280160b3a.52.2024.11.05.16.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 16:49:23 -0800 (PST)
Date: Tue, 5 Nov 2024 16:49:19 -0800
From: Joe Damato <jdamato@fastly.com>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	kernel-team@meta.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	mohsin.bashr@gmail.com, sanmanpradhan@meta.com,
	andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev, sdf@fomichev.me,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: Add PCIe hardware statistics
Message-ID: <Zyq9D1WCvuykHsUv@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Sanman Pradhan <sanman.p211993@gmail.com>, netdev@vger.kernel.org,
	alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, mohsin.bashr@gmail.com,
	sanmanpradhan@meta.com, andrew+netdev@lunn.ch,
	vadim.fedorenko@linux.dev, sdf@fomichev.me,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241106002625.1857904-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106002625.1857904-1-sanman.p211993@gmail.com>

On Tue, Nov 05, 2024 at 04:26:25PM -0800, Sanman Pradhan wrote:
> Add PCIe hardware statistics support to the fbnic driver. These stats
> provide insight into PCIe transaction performance and error conditions,
> including, read/write and completion TLP counts and DWORD counts and
> debug counters for tag, completion credit and NP credit exhaustion

The second sentence is long and doesn't have a period at the end of
it. Maybe break it up a bit into a set of shorter sentences or a
list or something like that?

> The stats are exposed via ethtool and can be used to monitor PCIe
> performance and debug PCIe issues.
> 
> Signed-off-by: Sanman Pradhan <sanman.p211993@gmail.com>
> ---
>  .../device_drivers/ethernet/meta/fbnic.rst    |  27 +++++
>  drivers/net/ethernet/meta/fbnic/fbnic.h       |   1 +
>  drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  39 ++++++
>  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  77 +++++++++++-
>  .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 114 ++++++++++++++++++
>  .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  17 +++
>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   3 +
>  drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   2 +
>  8 files changed, 278 insertions(+), 2 deletions(-)

[...]

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> index 1117d5a32867..9f590a42a9df 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -6,6 +6,39 @@

[...]

> +
> +#define FBNIC_HW_FIXED_STATS_LEN ARRAY_SIZE(fbnic_gstrings_hw_stats)
> +#define FBNIC_HW_STATS_LEN \
> +	(FBNIC_HW_FIXED_STATS_LEN)

Does the above need to be on a separate line? Might be able to fit
in under 80 chars?

>  static int
>  fbnic_get_ts_info(struct net_device *netdev,
>  		  struct kernel_ethtool_ts_info *tsinfo)
> @@ -51,6 +84,43 @@ static void fbnic_set_counter(u64 *stat, struct fbnic_stat_counter *counter)
>  		*stat = counter->value;
>  }
> 
> +static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
> +{
> +	int i;
> +
> +	switch (sset) {
> +	case ETH_SS_STATS:
> +		for (i = 0; i < FBNIC_HW_STATS_LEN; i++)
> +			ethtool_puts(&data, fbnic_gstrings_hw_stats[i].string);
> +		break;
> +	}
> +}
> +
> +static int fbnic_get_sset_count(struct net_device *dev, int sset)
> +{
> +	switch (sset) {
> +	case ETH_SS_STATS:
> +		return FBNIC_HW_STATS_LEN;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static void fbnic_get_ethtool_stats(struct net_device *dev,
> +				    struct ethtool_stats *stats, u64 *data)
> +{
> +	struct fbnic_net *fbn = netdev_priv(dev);
> +	const struct fbnic_stat *stat;
> +	int i;
> +
> +	fbnic_get_hw_stats(fbn->fbd);
> +
> +	for (i = 0; i < FBNIC_HW_STATS_LEN; i++) {
> +		stat = &fbnic_gstrings_hw_stats[i];
> +		data[i] = *(u64 *)((u8 *)&fbn->fbd->hw_stats + stat->offset);
> +	}
> +}
> +
>  static void
>  fbnic_get_eth_mac_stats(struct net_device *netdev,
>  			struct ethtool_eth_mac_stats *eth_mac_stats)
> @@ -117,10 +187,13 @@ static void fbnic_get_ts_stats(struct net_device *netdev,
>  }
> 
>  static const struct ethtool_ops fbnic_ethtool_ops = {
> -	.get_drvinfo		= fbnic_get_drvinfo,
>  	.get_ts_info		= fbnic_get_ts_info,
> -	.get_ts_stats		= fbnic_get_ts_stats,
> +	.get_drvinfo		= fbnic_get_drvinfo,
> +	.get_strings		= fbnic_get_strings,
> +	.get_sset_count		= fbnic_get_sset_count,
> +	.get_ethtool_stats	= fbnic_get_ethtool_stats,
>  	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,
> +	.get_ts_stats		= fbnic_get_ts_stats,
>  };

Seems like the two deleted lines were just re-ordered but otherwise
unchanged?

I don't think it's any reason to hold this back, but limiting
changes like that in the future is probably a good idea because it
makes the diff smaller and easier to review.

