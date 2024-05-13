Return-Path: <linux-kernel+bounces-177733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDD18C43D8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815CA284195
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36905CA1;
	Mon, 13 May 2024 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4edLPhv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5B05240
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613109; cv=none; b=gLficw7zGh6NCDOPQ+M6cVa94WXjVu2Rr6mLApQdkY6jtRSrRoagKdAPIhe7rdRJcDAsMcMUz2MAXZa2WV6TQx81RmyyHS7dTMT3dileDpQlI1bjaleo7r8TprFFLmxvG2Evv2t0tBBcEjgxVF+LK7dep+UvLl1NvrmPBv0k8TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613109; c=relaxed/simple;
	bh=+1ig/k0I1jTFLojudLHZvhDLarU8I4M3yzVi7mj6iCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWodBOobnj93n7cHMG5aCh+G44hagfDQDbc7+GcFlsSrYd8c9XgerLCcbA2lk/jimefSOAI16ko2Fk0fEsI1P0mzZkFjr/IbM+pWP5wJiTmDlqIcRA5Z0dNX3M12QyeRfP1pzgdObttWV4i1MjKfp4mQE2ipS6gLxPO+iRArBWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4edLPhv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715613106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ed/oHEQla/lRJaUv2E6HmfsRq56JQ9CXM/mPlIoRg5A=;
	b=F4edLPhvRRNZgKwRiioMccsoyAONsRj0XlaK8lI1pBs0gmckPrPx2+rldCRnZNTJYCySAS
	u7GB1+fQ9IAGuPcsPO+hsaSWK10mKTNEl0TRcbatbOyH9sR9wu33QDSm5dr41g2Yl7l6Un
	oTp030Kx16gS9If+XS0nqoI8TgUv+Xs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-5SqZ0LzSNOCr5Ngz73V4-A-1; Mon, 13 May 2024 11:06:35 -0400
X-MC-Unique: 5SqZ0LzSNOCr5Ngz73V4-A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6a0b3599f2cso47783356d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612795; x=1716217595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ed/oHEQla/lRJaUv2E6HmfsRq56JQ9CXM/mPlIoRg5A=;
        b=fjaDwFEB5ERzTWN3ZN+86b4b0PSgR4QXl5EZtQGAny7fdiFTA+WFeRMhfBN0/HV5+m
         OBNTQwmYdnfKhJrT34eNhqll2Bj2f5MiQn/R0ajBDL6ax/lmoF9JwLyiaqUbvtBqUUhd
         3V/hqONjE6lUmIKCyOxqwgvoAkce0tcoIXBXHeyackfPdJW4jDEehT39qrun9nWf6Un3
         tpJ2IMzx7b+IA7WKt+yt5Nke8LtOXfSZs8VkY6b9xVLTRXg3bcU/jNnO5+gJSK6IwWrC
         jwnk1aTSHawS04S1oeJNOPvorTvxzXBgkSIzhNsq3vORT8Njr8f9ClrGlwnROf4HkHaW
         H7nw==
X-Forwarded-Encrypted: i=1; AJvYcCVhqPzHDaTfBQ6WUB1Ah4KQXMABlcmuVIBz81RjCsavLz9qSgqkFkgdyuQg59df+xGSUCrnefcvWt2kSOXQzuelF9/uxlTrj804E5EX
X-Gm-Message-State: AOJu0YyrpfqxgFPgDs+dFVVWZn2DSVsmVllbqnSk0H3ZD39OH/joGUar
	5NiSEil/cpd7cacR/qYiaZrNJn5Vd9KHrJlDPTfRQgJFZnar/K6NTxA6xfGz55RUALqiPYl2Jw8
	Edh+tayR8KRaOj+m/lSVEJDu1lGiGFA1TpNHZVgQ1O+vnyOFsqjlFsufCXXwHSQ==
X-Received: by 2002:a05:6214:4902:b0:6a0:6f04:b290 with SMTP id 6a1803df08f44-6a1682078bamr121950286d6.42.1715612794828;
        Mon, 13 May 2024 08:06:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpdQlqVhTqT1LU1cs429BjfumQ9B//lgit0MtkZpUOHjFt1TKsuN0AGns2XX3V3pUZy7hOJQ==
X-Received: by 2002:a05:6214:4902:b0:6a0:6f04:b290 with SMTP id 6a1803df08f44-6a1682078bamr121949706d6.42.1715612794191;
        Mon, 13 May 2024 08:06:34 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1857e3sm43990776d6.52.2024.05.13.08.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 08:06:33 -0700 (PDT)
Date: Mon, 13 May 2024 10:06:31 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, richardcochran@gmail.com, bartosz.golaszewski@linaro.org, 
	horms@kernel.org, rohan.g.thomas@intel.com, rmk+kernel@armlinux.org.uk, 
	fancer.lancer@gmail.com, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v6 2/2] net: stmmac: move the EST structure to
 struct stmmac_priv
Message-ID: <n7gk6j6ni4oaxiat2ykap2aglynxqyceuhkmn25ntryahtixra@agh6b3n354jx>
References: <20240513014346.1718740-1-xiaolei.wang@windriver.com>
 <20240513014346.1718740-3-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513014346.1718740-3-xiaolei.wang@windriver.com>

On Mon, May 13, 2024 at 09:43:46AM GMT, Xiaolei Wang wrote:
> Move the EST structure to struct stmmac_priv, because the
> EST configs don't look like platform config, but EST is
> enabled in runtime with the settings retrieved for the TC
> TAPRIO feature also in runtime. So it's better to have the
> EST-data preserved in the driver private data instead of
> the platform data storage.
> 
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  | 15 +++++++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 18 ++++-----
>  .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 22 +++++-----
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 40 +++++++++----------
>  include/linux/stmmac.h                        | 15 -------
>  5 files changed, 54 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 64b21c83e2b8..011683abf97f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -221,6 +221,20 @@ struct stmmac_dma_conf {
>  	unsigned int dma_tx_size;
>  };
>  
> +#define EST_GCL         1024
> +struct stmmac_est {
> +	int enable;
> +	u32 btr_reserve[2];
> +	u32 btr_offset[2];
> +	u32 btr[2];
> +	u32 ctr[2];
> +	u32 ter;
> +	u32 gcl_unaligned[EST_GCL];
> +	u32 gcl[EST_GCL];
> +	u32 gcl_size;
> +	u32 max_sdu[MTL_MAX_TX_QUEUES];
> +};
> +
>  struct stmmac_priv {
>  	/* Frequently used values are kept adjacent for cache effect */
>  	u32 tx_coal_frames[MTL_MAX_TX_QUEUES];
> @@ -263,6 +277,7 @@ struct stmmac_priv {
>  	struct plat_stmmacenet_data *plat;
>  	/* Protect est parameters */
>  	struct mutex est_lock;
> +	struct stmmac_est *est;
>  	struct dma_features dma_cap;
>  	struct stmmac_counters mmc;
>  	int hw_cap_support;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7c6fb14b5555..0eafd609bf53 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2491,9 +2491,9 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>  		if (!xsk_tx_peek_desc(pool, &xdp_desc))
>  			break;
>  
> -		if (priv->plat->est && priv->plat->est->enable &&
> -		    priv->plat->est->max_sdu[queue] &&
> -		    xdp_desc.len > priv->plat->est->max_sdu[queue]) {
> +		if (priv->est && priv->est->enable &&
> +		    priv->est->max_sdu[queue] &&
> +		    xdp_desc.len > priv->est->max_sdu[queue]) {
>  			priv->xstats.max_sdu_txq_drop[queue]++;
>  			continue;
>  		}
> @@ -4528,9 +4528,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  			return stmmac_tso_xmit(skb, dev);
>  	}
>  
> -	if (priv->plat->est && priv->plat->est->enable &&
> -	    priv->plat->est->max_sdu[queue] &&
> -	    skb->len > priv->plat->est->max_sdu[queue]){
> +	if (priv->est && priv->est->enable &&
> +	    priv->est->max_sdu[queue] &&
> +	    skb->len > priv->est->max_sdu[queue]){
>  		priv->xstats.max_sdu_txq_drop[queue]++;
>  		goto max_sdu_err;
>  	}
> @@ -4909,9 +4909,9 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
>  		return STMMAC_XDP_CONSUMED;
>  
> -	if (priv->plat->est && priv->plat->est->enable &&
> -	    priv->plat->est->max_sdu[queue] &&
> -	    xdpf->len > priv->plat->est->max_sdu[queue]) {
> +	if (priv->est && priv->est->enable &&
> +	    priv->est->max_sdu[queue] &&
> +	    xdpf->len > priv->est->max_sdu[queue]) {
>  		priv->xstats.max_sdu_txq_drop[queue]++;
>  		return STMMAC_XDP_CONSUMED;
>  	}
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 0c5aab6dd7a7..a6b1de9a251d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -68,11 +68,11 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  	nsec = reminder;
>  
>  	/* If EST is enabled, disabled it before adjust ptp time. */
> -	if (priv->plat->est && priv->plat->est->enable) {
> +	if (priv->est && priv->est->enable) {
>  		est_rst = true;
>  		mutex_lock(&priv->est_lock);
> -		priv->plat->est->enable = false;
> -		stmmac_est_configure(priv, priv, priv->plat->est,
> +		priv->est->enable = false;
> +		stmmac_est_configure(priv, priv, priv->est,
>  				     priv->plat->clk_ptp_rate);
>  		mutex_unlock(&priv->est_lock);
>  	}
> @@ -90,19 +90,19 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  		mutex_lock(&priv->est_lock);
>  		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
>  		current_time_ns = timespec64_to_ktime(current_time);
> -		time.tv_nsec = priv->plat->est->btr_reserve[0];
> -		time.tv_sec = priv->plat->est->btr_reserve[1];
> +		time.tv_nsec = priv->est->btr_reserve[0];
> +		time.tv_sec = priv->est->btr_reserve[1];
>  		basetime = timespec64_to_ktime(time);
> -		cycle_time = (u64)priv->plat->est->ctr[1] * NSEC_PER_SEC +
> -			     priv->plat->est->ctr[0];
> +		cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC +
> +			     priv->est->ctr[0];
>  		time = stmmac_calc_tas_basetime(basetime,
>  						current_time_ns,
>  						cycle_time);
>  
> -		priv->plat->est->btr[0] = (u32)time.tv_nsec;
> -		priv->plat->est->btr[1] = (u32)time.tv_sec;
> -		priv->plat->est->enable = true;
> -		ret = stmmac_est_configure(priv, priv, priv->plat->est,
> +		priv->est->btr[0] = (u32)time.tv_nsec;
> +		priv->est->btr[1] = (u32)time.tv_sec;
> +		priv->est->enable = true;
> +		ret = stmmac_est_configure(priv, priv, priv->est,
>  					   priv->plat->clk_ptp_rate);
>  		mutex_unlock(&priv->est_lock);
>  		if (ret)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 620c16e9be3a..222540b55480 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -918,7 +918,6 @@ struct timespec64 stmmac_calc_tas_basetime(ktime_t old_base_time,
>  static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
>  				     struct tc_taprio_qopt_offload *qopt)
>  {
> -	struct plat_stmmacenet_data *plat = priv->plat;
>  	u32 num_tc = qopt->mqprio.qopt.num_tc;
>  	u32 offset, count, i, j;
>  
> @@ -933,7 +932,7 @@ static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
>  		count = qopt->mqprio.qopt.count[i];
>  
>  		for (j = offset; j < offset + count; j++)
> -			plat->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
> +			priv->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
>  	}
>  }
>  
> @@ -941,7 +940,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  			       struct tc_taprio_qopt_offload *qopt)
>  {
>  	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
> -	struct plat_stmmacenet_data *plat = priv->plat;
>  	struct timespec64 time, current_time, qopt_time;
>  	ktime_t current_time_ns;
>  	bool fpe = false;
> @@ -998,24 +996,24 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	if (qopt->cycle_time_extension >= BIT(wid + 7))
>  		return -ERANGE;
>  
> -	if (!plat->est) {
> -		plat->est = devm_kzalloc(priv->device, sizeof(*plat->est),
> +	if (!priv->est) {
> +		priv->est = devm_kzalloc(priv->device, sizeof(*priv->est),
>  					 GFP_KERNEL);
> -		if (!plat->est)
> +		if (!priv->est)
>  			return -ENOMEM;
>  
>  		mutex_init(&priv->est_lock);
>  	} else {
>  		mutex_lock(&priv->est_lock);
> -		memset(plat->est, 0, sizeof(*plat->est));
> +		memset(priv->est, 0, sizeof(*priv->est));
>  		mutex_unlock(&priv->est_lock);
>  	}
>  
>  	size = qopt->num_entries;
>  
>  	mutex_lock(&priv->est_lock);
> -	priv->plat->est->gcl_size = size;
> -	priv->plat->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
> +	priv->est->gcl_size = size;
> +	priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
>  	mutex_unlock(&priv->est_lock);
>  
>  	for (i = 0; i < size; i++) {
> @@ -1044,7 +1042,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  			return -EOPNOTSUPP;
>  		}
>  
> -		priv->plat->est->gcl[i] = delta_ns | (gates << wid);
> +		priv->est->gcl[i] = delta_ns | (gates << wid);
>  	}
>  
>  	mutex_lock(&priv->est_lock);
> @@ -1054,18 +1052,18 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	time = stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
>  					qopt->cycle_time);
>  
> -	priv->plat->est->btr[0] = (u32)time.tv_nsec;
> -	priv->plat->est->btr[1] = (u32)time.tv_sec;
> +	priv->est->btr[0] = (u32)time.tv_nsec;
> +	priv->est->btr[1] = (u32)time.tv_sec;
>  
>  	qopt_time = ktime_to_timespec64(qopt->base_time);
> -	priv->plat->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
> -	priv->plat->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
> +	priv->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
> +	priv->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
>  
>  	ctr = qopt->cycle_time;
> -	priv->plat->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
> -	priv->plat->est->ctr[1] = (u32)ctr;
> +	priv->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
> +	priv->est->ctr[1] = (u32)ctr;
>  
> -	priv->plat->est->ter = qopt->cycle_time_extension;
> +	priv->est->ter = qopt->cycle_time_extension;
>  
>  	tc_taprio_map_maxsdu_txq(priv, qopt);
>  
> @@ -1079,7 +1077,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	 */
>  	priv->plat->fpe_cfg->enable = fpe;
>  
> -	ret = stmmac_est_configure(priv, priv, priv->plat->est,
> +	ret = stmmac_est_configure(priv, priv, priv->est,
>  				   priv->plat->clk_ptp_rate);
>  	mutex_unlock(&priv->est_lock);
>  	if (ret) {
> @@ -1097,10 +1095,10 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	return 0;
>  
>  disable:
> -	if (priv->plat->est) {
> +	if (priv->est) {
>  		mutex_lock(&priv->est_lock);
> -		priv->plat->est->enable = false;
> -		stmmac_est_configure(priv, priv, priv->plat->est,
> +		priv->est->enable = false;
> +		stmmac_est_configure(priv, priv, priv->est,
>  				     priv->plat->clk_ptp_rate);
>  		/* Reset taprio status */
>  		for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index c0d74f97fd18..5da45d025601 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -115,20 +115,6 @@ struct stmmac_axi {
>  	bool axi_rb;
>  };
>  
> -#define EST_GCL		1024
> -struct stmmac_est {
> -	int enable;
> -	u32 btr_reserve[2];
> -	u32 btr_offset[2];
> -	u32 btr[2];
> -	u32 ctr[2];
> -	u32 ter;
> -	u32 gcl_unaligned[EST_GCL];
> -	u32 gcl[EST_GCL];
> -	u32 gcl_size;
> -	u32 max_sdu[MTL_MAX_TX_QUEUES];
> -};
> -
>  struct stmmac_rxq_cfg {
>  	u8 mode_to_use;
>  	u32 chan;
> @@ -245,7 +231,6 @@ struct plat_stmmacenet_data {
>  	struct fwnode_handle *port_node;
>  	struct device_node *mdio_node;
>  	struct stmmac_dma_cfg *dma_cfg;
> -	struct stmmac_est *est;
>  	struct stmmac_fpe_cfg *fpe_cfg;
>  	struct stmmac_safety_feature_cfg *safety_feat_cfg;
>  	int clk_csr;
> -- 
> 2.25.1
> 


