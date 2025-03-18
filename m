Return-Path: <linux-kernel+bounces-565842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5012DA66FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B9E7A2D43
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D285B207A26;
	Tue, 18 Mar 2025 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iG0iEvUL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D788A79E1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290604; cv=none; b=WZZNES6mYycXfsRTI9FwIZbMkSJpJZYoTbVEGPi3/J0oCb738u14sBzlog+0xCSDrb4DEdARQZfZJOhgnYHwPoO2LnPgyudlzvsG7epNf10OgjVuXZp6LxURKkWQTmLbuyQkrGb0s0Dg/TCzZbs4sCou6gjO8AQuQlw0Pc8y+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290604; c=relaxed/simple;
	bh=mzBMBkkZzeq6MOHImrnUvgj4qWJoLUYsd5OZKQZmC1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=peplcq6L0Q6wZLSiGbJ6VRpJYLHzgu1tAJnkXf8f+wWgU7glIVuXtdPiWt6PfXS2StiFuW4h7lFqqm5fVEKn2kYVlsB4dBIH7ChSrQdnL04oyLdHUEwW7maWu0roGCKwTT40hQrClmrXvJUUGNbk8uAqjIbTy2iRaha+chEBAz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iG0iEvUL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742290597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CvKDg3JDHn9jOPRmkfFXXZUafsnEo6j8hP0TAoVHOek=;
	b=iG0iEvUL8+VtbE6zdFVucDa037degQVqv658HHC5kf1BECEbMRf048UYfDFyIHQPLs+Qb/
	lW290sToxyACbUk0oObJSSR8cIgv6fyJXrL/TkcpzPIx+mLtBVMQ2h6zo/miiQ4UdII0tm
	GFNfG/FRE/4KVJuHZ5w5SogkNKF7nMs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-e1X8DayaOF2Um_tRKCKMPw-1; Tue, 18 Mar 2025 05:36:36 -0400
X-MC-Unique: e1X8DayaOF2Um_tRKCKMPw-1
X-Mimecast-MFC-AGG-ID: e1X8DayaOF2Um_tRKCKMPw_1742290595
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d3b211d0eso2563925e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742290595; x=1742895395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvKDg3JDHn9jOPRmkfFXXZUafsnEo6j8hP0TAoVHOek=;
        b=pC0cn0XdR/7SCxLdqrz8LrIJXKHyMYh3HQNhB+XJJIWRsxR+rQUyKc38XkWLxpBzxl
         swm1+SR6US6Gp7tkcg8wXHQuH5h+l3Vde4G4Qly/Es6kmW1l4hS2BxaaOCWQTWw5ffCR
         l55TYpnaTQyrV/2vhqQ14W0UNetS61x8TB2DZM7YBsR19BnFdyjEnhO+ZUIDrHk6Di3i
         B3WXIWnBQgjQbqHOCpLSryczGc2WacFR+5nleve3enXB0wuSapUOFvLufJPKcK6XH54S
         ADu+I7lX3/pGJJ2FTcUInz6d0jZXYS9WOXOOolMnv6ewCq3wcWbzt9knZRUrxOZnM3oP
         NuYg==
X-Forwarded-Encrypted: i=1; AJvYcCWuGlATdraVnGfQAWMfXH9hYlM9Q8+J9RmhKc5sZXDxBMjdhs/w4KNwI42IglEFOEMvLGdGGOjVYnP6egY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNOnMdfWNBGlgJ0DwYzpkc+E9qeIIls9rS2UsRPsM88xKYcPzz
	g+Qee5XrLYrv7YKN44RiyYaDnDYRpnDjp1flKMnxLMR27wgG/XZGDAVEp81BMsrjkf4i69UiYkr
	KJ+117i1Lry+ymfXYGrsL3V/Ykqc7+WZ50pSyDYeJI1KqrFCXIKfCZrrLHYTM+w==
X-Gm-Gg: ASbGnctkMAOVtfeUKA75931ECmDhnEV/rBzIqQzgPe5R85XqEYif7QVfvNi9cYZEH4Y
	V4E9yOhQ4C/oRg6yP7inlUVZpFk0l1Q4clPih4AQAeVui8n4YzPXjvGeWN9enYDySBCSgIiaDG7
	sUm4d33WA+TcRzks3yGXDeAty4gSlE8Yka5PJ4ZdP6yXLxyzq4gs51MuMjnsjnmcZyLEUNWLeoc
	gGMsT5yUwz6lKRe3YogZUaPYr56+Qbn1boOJE4IcdWBUKLS9S7fYn/5RVCvIzZS2EjXE9zGP9V4
	Zp67xvJj6dL2mYL4nRe1HBiUqLFiUz8qrFNh7qsgXBTM1A==
X-Received: by 2002:a05:600c:4f4a:b0:439:8490:d1e5 with SMTP id 5b1f17b1804b1-43d3b981324mr14252825e9.4.1742290595254;
        Tue, 18 Mar 2025 02:36:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3vTKKmwKw0Z8Ob8YbB5NUPivxHGNKx120DzCxn23HNlzcDtLNTUy32hinrYTNPH+w/sR52A==
X-Received: by 2002:a05:600c:4f4a:b0:439:8490:d1e5 with SMTP id 5b1f17b1804b1-43d3b981324mr14252415e9.4.1742290594821;
        Tue, 18 Mar 2025 02:36:34 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d28565b17sm94485335e9.37.2025.03.18.02.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:36:34 -0700 (PDT)
Message-ID: <65bfbea3-8007-43ec-af58-2d61f5488a88@redhat.com>
Date: Tue, 18 Mar 2025 10:36:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] net/mlx5: Add support for setting parent of
 nodes
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <1741642016-44918-1-git-send-email-tariqt@nvidia.com>
 <1741642016-44918-5-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1741642016-44918-5-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 10:26 PM, Tariq Toukan wrote:
> @@ -1018,3 +1018,105 @@ int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
>  	node = parent_priv;
>  	return mlx5_esw_qos_vport_update_parent(vport, node, extack);
>  }
> +
> +static int
> +mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
> +				      struct mlx5_esw_sched_node *parent,
> +				      struct netlink_ext_ack *extack)
> +{
> +	u8 new_level, max_level;
> +
> +	if (parent && parent->esw != node->esw) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Cannot assign node to another E-Switch");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!list_empty(&node->children)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Cannot reassign a node that contains rate objects");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	new_level = parent ? parent->level + 1 : 2;
> +	max_level = 1 << MLX5_CAP_QOS(node->esw->dev, log_esw_max_sched_depth);
> +	if (new_level > max_level) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Node hierarchy depth exceeds the maximum supported level");

Minor nit for a possible small follow-up: it could be possibly useful to
add to the extact the current and max level.

/P


