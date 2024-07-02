Return-Path: <linux-kernel+bounces-237798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C19D923E46
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412071F22C19
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCEA16D4CE;
	Tue,  2 Jul 2024 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozESms7C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D91158871;
	Tue,  2 Jul 2024 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925230; cv=none; b=duJejHNvKA9b8y0YlTPWk2aAgnPGvJDB4dbLFwoKF9bi1NgpA59eufp8C+cOlhk0sxECCqAygQ1DHvmAQaA+RNkiiTz9sB6U+JRJ2t7IGheF4rKUwegJlVjvpWbqG13WHD8t0O/XXLP34ADbl3xcV5QkxBdRrfR5jeyYcgYcK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925230; c=relaxed/simple;
	bh=3IcKndPgJRKyDI4uLAvL9dcl2uguX3FJbSHktips0FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7rFW3Bysoo44OQOJnbQywJEkIRW0iewL3eaMBbhA2q3iMhXqmWsglA8ppwIeN2XBkhV6fuNJR48T2VeG7ueeR5afRmdM063unpsFbt7ce/GPq31UOtakCdIrAbGhW9oDBIme7aqdUEKHXXs20gjMfZ4RZbugJC3QBkP7L2RcJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozESms7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957EAC2BD10;
	Tue,  2 Jul 2024 13:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719925230;
	bh=3IcKndPgJRKyDI4uLAvL9dcl2uguX3FJbSHktips0FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozESms7CPjBSF7HnyGgtc5BOIx/GdqR1fdGFtQDO8e2pWqvWA3H92MeHHz0lsqsm+
	 KWf7GUFwobINaivWa2jXhe/rVmBOT8AoUfVKjp7KAsBbwEZcZv56xGsYPbSHNMRmyt
	 kxKgoKLsPKVU0JxTB54QYBeYbmo/xV0GmDcgfKaH03i+BnoGQFONeBS1wdTsUopZph
	 J1+kBPg8oq1Zbv7Hr3xKr7+9Jq5Z3M7bZmuZJRyFL9yBE6wW/k7KJVDxpQspfJeUMl
	 sNBOWdVlTKweq+g/p17iXmK98PgtTP+C4eqLrFg+R7K4663SzUIFoidm4LPPFwd6Em
	 BzBGnQ9P8pvOw==
Date: Tue, 2 Jul 2024 14:00:24 +0100
From: Simon Horman <horms@kernel.org>
To: Peter Yin <peteryin.openbmc@gmail.com>
Cc: patrick@stwcx.xyz, amithash@meta.com,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Cosmo Chou <cosmo.chou@quantatw.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v1 1/1] net/ncsi: specify maximum package to probe
Message-ID: <20240702130024.GJ598357@kernel.org>
References: <20240701154336.3536924-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701154336.3536924-1-peteryin.openbmc@gmail.com>

[ As this seems to relate to: DT, ASPEED and ARM, CC:
  Rob Herring, Krzysztof Kozlowski, Conor Dooley, Joel Stanley, Andrew Jeffery,
  devicetree, linux-arm-kernel, linux-aspeed. ]

On Mon, Jul 01, 2024 at 11:43:36PM +0800, Peter Yin wrote:
> Most NICs have a single package. For OCP3.0 NICs, the package ID is
> determined by the slot ID. Probing all 8 package IDs is usually
> unnecessary. To reduce probe time, add properties to specify the
> maximum number of packages.
> 
> Signed-off-by: Cosmo Chou <cosmo.chou@quantatw.com>
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  net/ncsi/internal.h    |  1 +
>  net/ncsi/ncsi-manage.c | 16 ++++++++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
> index ef0f8f73826f..bd7ad0bf803f 100644
> --- a/net/ncsi/internal.h
> +++ b/net/ncsi/internal.h
> @@ -341,6 +341,7 @@ struct ncsi_dev_priv {
>  #define NCSI_MAX_VLAN_VIDS	15
>  	struct list_head    vlan_vids;       /* List of active VLAN IDs */
>  
> +	unsigned int        max_package;     /* Num of packages to probe   */
>  	bool                multi_package;   /* Enable multiple packages   */
>  	bool                mlx_multi_host;  /* Enable multi host Mellanox */
>  	u32                 package_whitelist; /* Packages to configure    */
> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 5ecf611c8820..159943ee1317 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -1358,12 +1358,12 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
>  		nd->state = ncsi_dev_state_probe_deselect;
>  		fallthrough;
>  	case ncsi_dev_state_probe_deselect:
> -		ndp->pending_req_num = 8;
> +		ndp->pending_req_num = ndp->max_package;
>  
>  		/* Deselect all possible packages */
>  		nca.type = NCSI_PKT_CMD_DP;
>  		nca.channel = NCSI_RESERVED_CHANNEL;
> -		for (index = 0; index < 8; index++) {
> +		for (index = 0; index < ndp->max_package; index++) {
>  			nca.package = index;
>  			ret = ncsi_xmit_cmd(&nca);
>  			if (ret)
> @@ -1491,7 +1491,7 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
>  
>  		/* Probe next package */
>  		ndp->package_probe_id++;
> -		if (ndp->package_probe_id >= 8) {
> +		if (ndp->package_probe_id >= ndp->max_package) {
>  			/* Probe finished */
>  			ndp->flags |= NCSI_DEV_PROBED;
>  			break;
> @@ -1746,7 +1746,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
>  	struct platform_device *pdev;
>  	struct device_node *np;
>  	unsigned long flags;
> -	int i;
> +	int i, ret;
>  
>  	/* Check if the device has been registered or not */
>  	nd = ncsi_find_dev(dev);
> @@ -1795,6 +1795,14 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
>  		if (np && (of_property_read_bool(np, "mellanox,multi-host") ||
>  			   of_property_read_bool(np, "mlx,multi-host")))
>  			ndp->mlx_multi_host = true;
> +

Should the "ncsi-package" (and above multi-host properties) be
documented in DT bindings somewhere? I was unable to locate such
documentation.

> +		if (np) {
> +			ret = of_property_read_u32(np, "ncsi-package",
> +						   &ndp->max_package);
> +			if (ret || !ndp->max_package ||
> +			    ndp->max_package > NCSI_MAX_PACKAGE)
> +				ndp->max_package = NCSI_MAX_PACKAGE;
> +		}
>  	}

It seems that ndp->max_package will be 0 unless pdev != NULL and np != NULL.
Would it be better set to NCSI_MAX_PACKAGE in such cases?

>  
>  	return nd;
> -- 
> 2.25.1
> 
> 

