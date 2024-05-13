Return-Path: <linux-kernel+bounces-177730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE088C43D1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27D81F2249E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFC5538A;
	Mon, 13 May 2024 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFeGhGGn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F955E4F
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612967; cv=none; b=VxXeVsc3PytpLTc++Bp7crBbMmJ8M7lkXJHo3nxy/lGQ9ra56rW4WGkJ1vmhR8rPASSRLc0NU/SA283VJHFuV7rRGDkvtlOFiOt5P3/vlEinmLEX3dtQ5Nr5k07Qe0rndYVvru5QNVcNVZbpa+N9RmYjlvkTcRQKV1JYFGN4/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612967; c=relaxed/simple;
	bh=Y4cgtybKrVbogclcdn+EC8EjlXPJSlKIuVgB78gSBH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vg9ZxrbzmAHiqZhtTh56y58NV1RV3q6isSoHPTaDymKMRxvKjhHVisGbRwaVrSUgpqFSfVI8cyJNI01ci6t2PH2W/ofP6hKCEd5KIrpmTBeYB+fW+M3Yf3DcCXSJc+NFQMJohxX5qvec7hg2eT6xCEPvz66KRfaoQUT9CIctBqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFeGhGGn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715612965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RTW29I4CyELTNosgb5eLNanHw8DFrZrqRr6uqkajeWw=;
	b=XFeGhGGn61Y3DwlUV9SAliXLJOvEYnnEE3ML/TkvBoE/5RkKYy7uXsotkNi4YwVdx4m2yT
	Sx2AdbFaMmlxUiro82dL6H1jBggZ6j9j0gJ9dd9Q2Dc3W0kSDhE+qRHTpR/Xjs1ApsLfzM
	y7r08gq/NyCo69VAzJ/EK/NwtOWFSMQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-IOD0bevPO1uSX9h9WTDu9w-1; Mon, 13 May 2024 11:04:23 -0400
X-MC-Unique: IOD0bevPO1uSX9h9WTDu9w-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-792c707ca4aso342190585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612663; x=1716217463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTW29I4CyELTNosgb5eLNanHw8DFrZrqRr6uqkajeWw=;
        b=QbaDuSVeadtUQcb76hYRQ2ULYkAdYKw5tmhcc6WV5l85t/ERO6mCk2ydVxOHKvRbJk
         2hUpYWltKVr0uvxrTQoCvAB9s/CpfE6qrlKpkE5D8+FgyZ2tQSAS4RmJhCIBh4/e7r0/
         vXkftfDm8rWo5hqx5aFMMuzu/IAcGvgm/2/mTEuviMoBL/1aRAI12jPEq87zkF5a1xww
         i2E5ptmqDBiUgrLQSAT5PxCFoU620ZUb8S0GYV4JFLOCTn9Xqfeb5RTY6mG/+VZ8yr4P
         R6QObk/rm2hAMHWzEXgZsasdhiX4Kxj9p+jz/VDReory2qfPOs2gNDc3VvPeujhhZpkh
         yy1g==
X-Forwarded-Encrypted: i=1; AJvYcCVa7L6IMXRszUSUEcadHNF5Uh63G4QdHhtBbibKMl3n9R/8WAB7gPYMaygQL9mD1n+4xxh7pQc4TZQ6UKlXhy+B6L2XdJ0oNCVhA+f0
X-Gm-Message-State: AOJu0Ywddp45cjJsmqqqW/ZQ9Bfty3I2SAw7X/lRhDnkkbwtCVl9R41Z
	w/TNPoLYkb8QMqtH9k8Z/zv2NF+Qcr03srzRCVMvGjzmnlUq26mgKxyxc0VFlBEUE7Y0uX8QyuB
	nd1vfz2nbjJihwehU1h9iM1JZ0NCa99CIsb3v4+2amCY8m5iRt0vQXYAV0nD8Zw==
X-Received: by 2002:a05:620a:5dda:b0:792:c02c:a979 with SMTP id af79cd13be357-792c7597db8mr1114505885a.23.1715612662972;
        Mon, 13 May 2024 08:04:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwCNTOyFP8kkdVD3hcINZqHo9Fx3MQUnlhQroroknttLiIYTJKYfRCO1rmF9ivXSg9sdMWZg==
X-Received: by 2002:a05:620a:5dda:b0:792:c02c:a979 with SMTP id af79cd13be357-792c7597db8mr1114500985a.23.1715612662435;
        Mon, 13 May 2024 08:04:22 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf27779fsm462541085a.21.2024.05.13.08.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 08:04:21 -0700 (PDT)
Date: Mon, 13 May 2024 10:04:19 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, richardcochran@gmail.com, bartosz.golaszewski@linaro.org, 
	horms@kernel.org, rohan.g.thomas@intel.com, rmk+kernel@armlinux.org.uk, 
	fancer.lancer@gmail.com, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net PATCH v6 1/2] net: stmmac: move the EST lock to struct
 stmmac_priv
Message-ID: <7qiunwxhvxpembddu6lfg32pec67rhlph3uuqxezey4zd64ig4@wocacehc5lws>
References: <20240513014346.1718740-1-xiaolei.wang@windriver.com>
 <20240513014346.1718740-2-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513014346.1718740-2-xiaolei.wang@windriver.com>

On Mon, May 13, 2024 at 09:43:45AM GMT, Xiaolei Wang wrote:
> Reinitialize the whole EST structure would also reset the mutex
> lock which is embedded in the EST structure, and then trigger
> the following warning. To address this, move the lock to struct
> stmmac_priv. We also need to reacquire the mutex lock when doing
> this initialization.
> 
> DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> WARNING: CPU: 3 PID: 505 at kernel/locking/mutex.c:587 __mutex_lock+0xd84/0x1068
>  Modules linked in:
>  CPU: 3 PID: 505 Comm: tc Not tainted 6.9.0-rc6-00053-g0106679839f7-dirty #29
>  Hardware name: NXP i.MX8MPlus EVK board (DT)
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : __mutex_lock+0xd84/0x1068
>  lr : __mutex_lock+0xd84/0x1068
>  sp : ffffffc0864e3570
>  x29: ffffffc0864e3570 x28: ffffffc0817bdc78 x27: 0000000000000003
>  x26: ffffff80c54f1808 x25: ffffff80c9164080 x24: ffffffc080d723ac
>  x23: 0000000000000000 x22: 0000000000000002 x21: 0000000000000000
>  x20: 0000000000000000 x19: ffffffc083bc3000 x18: ffffffffffffffff
>  x17: ffffffc08117b080 x16: 0000000000000002 x15: ffffff80d2d40000
>  x14: 00000000000002da x13: ffffff80d2d404b8 x12: ffffffc082b5a5c8
>  x11: ffffffc082bca680 x10: ffffffc082bb2640 x9 : ffffffc082bb2698
>  x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000000001
>  x5 : ffffff8178fe0d48 x4 : 0000000000000000 x3 : 0000000000000027
>  x2 : ffffff8178fe0d50 x1 : 0000000000000000 x0 : 0000000000000000
>  Call trace:
>   __mutex_lock+0xd84/0x1068
>   mutex_lock_nested+0x28/0x34
>   tc_setup_taprio+0x118/0x68c
>   stmmac_setup_tc+0x50/0xf0
>   taprio_change+0x868/0xc9c
> 
> Fixes: b2aae654a479 ("net: stmmac: add mutex lock to protect est parameters")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  2 ++
>  .../net/ethernet/stmicro/stmmac/stmmac_ptp.c   |  8 ++++----
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c    | 18 ++++++++++--------
>  include/linux/stmmac.h                         |  1 -
>  4 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index dddcaa9220cc..64b21c83e2b8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -261,6 +261,8 @@ struct stmmac_priv {
>  	struct stmmac_extra_stats xstats ____cacheline_aligned_in_smp;
>  	struct stmmac_safety_stats sstats;
>  	struct plat_stmmacenet_data *plat;
> +	/* Protect est parameters */
> +	struct mutex est_lock;
>  	struct dma_features dma_cap;
>  	struct stmmac_counters mmc;
>  	int hw_cap_support;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index e04830a3a1fb..0c5aab6dd7a7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -70,11 +70,11 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  	/* If EST is enabled, disabled it before adjust ptp time. */
>  	if (priv->plat->est && priv->plat->est->enable) {
>  		est_rst = true;
> -		mutex_lock(&priv->plat->est->lock);
> +		mutex_lock(&priv->est_lock);
>  		priv->plat->est->enable = false;
>  		stmmac_est_configure(priv, priv, priv->plat->est,
>  				     priv->plat->clk_ptp_rate);
> -		mutex_unlock(&priv->plat->est->lock);
> +		mutex_unlock(&priv->est_lock);
>  	}
>  
>  	write_lock_irqsave(&priv->ptp_lock, flags);
> @@ -87,7 +87,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  		ktime_t current_time_ns, basetime;
>  		u64 cycle_time;
>  
> -		mutex_lock(&priv->plat->est->lock);
> +		mutex_lock(&priv->est_lock);
>  		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
>  		current_time_ns = timespec64_to_ktime(current_time);
>  		time.tv_nsec = priv->plat->est->btr_reserve[0];
> @@ -104,7 +104,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  		priv->plat->est->enable = true;
>  		ret = stmmac_est_configure(priv, priv, priv->plat->est,
>  					   priv->plat->clk_ptp_rate);
> -		mutex_unlock(&priv->plat->est->lock);
> +		mutex_unlock(&priv->est_lock);
>  		if (ret)
>  			netdev_err(priv->dev, "failed to configure EST\n");
>  	}
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index cce00719937d..620c16e9be3a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -1004,17 +1004,19 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  		if (!plat->est)
>  			return -ENOMEM;
>  
> -		mutex_init(&priv->plat->est->lock);
> +		mutex_init(&priv->est_lock);
>  	} else {
> +		mutex_lock(&priv->est_lock);
>  		memset(plat->est, 0, sizeof(*plat->est));
> +		mutex_unlock(&priv->est_lock);
>  	}
>  
>  	size = qopt->num_entries;
>  
> -	mutex_lock(&priv->plat->est->lock);
> +	mutex_lock(&priv->est_lock);
>  	priv->plat->est->gcl_size = size;
>  	priv->plat->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
> -	mutex_unlock(&priv->plat->est->lock);
> +	mutex_unlock(&priv->est_lock);
>  
>  	for (i = 0; i < size; i++) {
>  		s64 delta_ns = qopt->entries[i].interval;
> @@ -1045,7 +1047,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  		priv->plat->est->gcl[i] = delta_ns | (gates << wid);
>  	}
>  
> -	mutex_lock(&priv->plat->est->lock);
> +	mutex_lock(&priv->est_lock);
>  	/* Adjust for real system time */
>  	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
>  	current_time_ns = timespec64_to_ktime(current_time);
> @@ -1068,7 +1070,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	tc_taprio_map_maxsdu_txq(priv, qopt);
>  
>  	if (fpe && !priv->dma_cap.fpesel) {
> -		mutex_unlock(&priv->plat->est->lock);
> +		mutex_unlock(&priv->est_lock);
>  		return -EOPNOTSUPP;
>  	}
>  
> @@ -1079,7 +1081,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  
>  	ret = stmmac_est_configure(priv, priv, priv->plat->est,
>  				   priv->plat->clk_ptp_rate);
> -	mutex_unlock(&priv->plat->est->lock);
> +	mutex_unlock(&priv->est_lock);
>  	if (ret) {
>  		netdev_err(priv->dev, "failed to configure EST\n");
>  		goto disable;
> @@ -1096,7 +1098,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  
>  disable:
>  	if (priv->plat->est) {
> -		mutex_lock(&priv->plat->est->lock);
> +		mutex_lock(&priv->est_lock);
>  		priv->plat->est->enable = false;
>  		stmmac_est_configure(priv, priv, priv->plat->est,
>  				     priv->plat->clk_ptp_rate);
> @@ -1105,7 +1107,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  			priv->xstats.max_sdu_txq_drop[i] = 0;
>  			priv->xstats.mtl_est_txq_hlbf[i] = 0;
>  		}
> -		mutex_unlock(&priv->plat->est->lock);
> +		mutex_unlock(&priv->est_lock);
>  	}
>  
>  	priv->plat->fpe_cfg->enable = false;
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index dfa1828cd756..c0d74f97fd18 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -117,7 +117,6 @@ struct stmmac_axi {
>  
>  #define EST_GCL		1024
>  struct stmmac_est {
> -	struct mutex lock;
>  	int enable;
>  	u32 btr_reserve[2];
>  	u32 btr_offset[2];
> -- 
> 2.25.1
> 


