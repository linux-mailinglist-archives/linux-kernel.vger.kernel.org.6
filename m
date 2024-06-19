Return-Path: <linux-kernel+bounces-220510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE89F90E2C4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15EE7B22E09
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 05:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399ED57C9C;
	Wed, 19 Jun 2024 05:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="BvZr05ef"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F74755893
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 05:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718775608; cv=none; b=HmSg2Ue4B/KTBJxbhAy1VsJ6rcMjb+mbRm1xivLucLF+e3bsyBHbF+lSATkwo8ds1B8j+LlbxWZuuH+QVaWR1I15PCpL7makq31Qx5kePTaonRJBqSqVHxvnKcT062ZfOxoL8XiO7+BzVcB0nkImzPLfi84bOca6EaKe1jFHRyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718775608; c=relaxed/simple;
	bh=cuwyYPJdEccRR7FgxrcvzFghDtDBpdxth6U8JwPL6IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQH9rCGmzxCpmX5eLGy1x5LB2eP5ferAtmzYMYjAZE3Lfr3ZSLvTtZtgXknbvrH8z4buPf1hkTUHricHmjytRFt9W3jGFdWdPk5Ene325oEAcTtJ56Ma+Z8HR4ohyGOoCuqyfkNTd1sjkpJtVj8VZ41fB2jUcVM1J8WvWhVvhSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=BvZr05ef; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c7bf925764so291103a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 22:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718775606; x=1719380406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/h22X+1AcxVdzXNdguW2P6bgopaMNUUiWIJKLPjngk=;
        b=BvZr05efR85kARKVqmvRpnGHxj/cSJk1JPyp1DefCXAkaacM+9tFvyrJJ2Qwulxxfw
         jn7BXvS0wiBcutk0wt00hbSQZTkCk9Nfr2eeNRdC30dXQgCi1q7F0Ogv6GPu5HD4eeTH
         LB2wSHxCVZoUuDTVk8WI+4JtIJfif6sDAZ6tU1lhWoxHd5Vg73H0PfKmf9rQVe+ReAwu
         UeuohPH/qBgSgQNZsQpM4k4F4soc7rTmLwfOKa0AzKW3FXGjIhLBp9TODyshykm+QB7y
         dwItX6L96sB/IfJvHzEI9fqLOBudI0B/Ex7ujujIIpBn99Uxu5QQblWYbTSnjY/4IEdx
         Ka1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718775606; x=1719380406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/h22X+1AcxVdzXNdguW2P6bgopaMNUUiWIJKLPjngk=;
        b=RF3NDm3kuOzkdH2H7n9O55baj4kxfvs8iMQtrXBZ/CbQXfZm/DgE5Ta5frdczNba8e
         lVERlXCBGGBnbZbCUoL2+zE1a9IKkRL1JMOwI73vxQVsGxudYDJcHhBiEzU6ekr3c9eT
         o6fN1OWHNynJWUKgDZY2CPIL7Wp/kxBp3wKIySByWkbhQfsZMKNU5pPShI4grHGHMkaW
         2VOqmscmTZgfQ2RRxoTSAXNg4fB35+OtI4lvheriYyVwfqeMOhnTBwr6uMDz+oUH8svT
         i7DgsEkWcdWc7oh0FKWUuffQJD7u+OR/QxzbeCk0yE9gU4ls82Tw/hYGyT+GlZyo7f8i
         BJwg==
X-Forwarded-Encrypted: i=1; AJvYcCWlSCmWIHA9ZR1C5PWkhbCRSWoUdAer4tfEkiPNXU+KpvOuaMg+oYN05yWfnmN3nUtWK5Mvpx7tbYvl9stDMX7J7SoFCE0qLuBh0jFM
X-Gm-Message-State: AOJu0YxMjHmy4iZwMz7WFZnCILCYMJ7aL9k+odSLhn5C0yN5kenHeq2m
	uaSM6ScDm6abUq8WxBFFFeKVLcZpG3uqCdUY6FcFsx9vOZYYWPyvxzC1rj9u3FY=
X-Google-Smtp-Source: AGHT+IHm0rWTUhUqUgm8kqzy7HT0siE4iAilkLUygbACX0ci3GjA7X0QFHG/egEtGdIJsTi1WsWTfg==
X-Received: by 2002:a17:90a:ec12:b0:2c7:b606:a3be with SMTP id 98e67ed59e1d1-2c7b606a645mr1658901a91.28.1718775605780;
        Tue, 18 Jun 2024 22:40:05 -0700 (PDT)
Received: from [192.168.1.8] (174-21-189-109.tukw.qwest.net. [174.21.189.109])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a75d1d40sm14238282a91.9.2024.06.18.22.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 22:40:05 -0700 (PDT)
Message-ID: <187e4082-c297-472d-9185-58f08572d68c@davidwei.uk>
Date: Tue, 18 Jun 2024 22:40:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Lag, Remove NULL check before dev_{put, hold}
Content-Language: en-GB
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, saeedm@nvidia.com
Cc: leon@kernel.org, tariqt@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20240619035357.45567-1-jiapeng.chong@linux.alibaba.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240619035357.45567-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-18 20:53, Jiapeng Chong wrote:
> The call netdev_{put, hold} of dev_{put, hold} will check NULL, so there
> is no need to check before using dev_{put, hold}, remove it to silence
> the warning:
> 
> ./drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c:1518:2-10: WARNING: NULL check before dev_{put, hold} functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9361
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index d0871c46b8c5..a2fd9a84f877 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -1514,8 +1514,7 @@ struct net_device *mlx5_lag_get_roce_netdev(struct mlx5_core_dev *dev)
>  	} else {
>  		ndev = ldev->pf[MLX5_LAG_P1].netdev;
>  	}
> -	if (ndev)
> -		dev_hold(ndev);
> +	dev_hold(ndev);

Looks safe, dev_hold() -> netdev_hold() which checks for ndev.

Reviewed-by: David Wei <dw@davidwei.uk>

>  
>  unlock:
>  	spin_unlock_irqrestore(&lag_lock, flags);

