Return-Path: <linux-kernel+bounces-236975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD97691E946
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77926282F34
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658DE170849;
	Mon,  1 Jul 2024 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZwiD7hJD"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C7F16FF47
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864862; cv=none; b=edvBHpmODyK+kkFEvi0ZqrFPt2WG0X+Z4cGN6Apk2bwyB3ItDPkG8EnIuGeEUtCVa7CL4chqTSoQTm5wCafdLkTzw8Pyaj80xKhFt/ZbvbatGT1Xspj01LKB8vAwxOiIsUILoUSX1tu6qhV8OqSN2PUFMptEC+izhYrFgULQsf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864862; c=relaxed/simple;
	bh=on5WVIclPkUFu3F4jhc3/dJr8reOuiDULJmhQJbCJfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOrKO6QRFfd9jF7gIGOsRPX/JWecxGneVYU6n/R6OllyJp4FlAHkYjilyGSFGZzdsBOS5Q3n2OEF5YV1lPchTdkYQR+BK5J2s2WUOF+nyChdAhpxS+DF8frMHNNAwqknR36dcySof7xt8frzETeCyQFmDF0dK360uLo9KPd/heQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZwiD7hJD; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kotaranov@linux.microsoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719864858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVcX2CswbR9UqeUv5mjFgUSyxPx+TGqXWoaQOVEf264=;
	b=ZwiD7hJDDV5UzHgeRrn00a0K1XK2mTwKIT1fHzo+/wiAzSLfdnW/U6K+Gy+1fHY5Rs+sPo
	To16EGr9/2xhpZu8IQQaMbgfo0zqyYqY6SHvYCumLHP1pVSewM0qy1CmvdoS26iktQe6+t
	t2v+anKsIlQ13kRomxH1cPc9H/xnOJo=
X-Envelope-To: kotaranov@microsoft.com
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: haiyangz@microsoft.com
X-Envelope-To: kys@microsoft.com
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: davem@davemloft.net
X-Envelope-To: decui@microsoft.com
X-Envelope-To: wei.liu@kernel.org
X-Envelope-To: sharmaajay@microsoft.com
X-Envelope-To: longli@microsoft.com
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: leon@kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
Message-ID: <5b418472-4370-4626-9373-064e7aaf9ae5@linux.dev>
Date: Tue, 2 Jul 2024 04:14:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/2] net: mana: introduce helper to get a
 master netdev
To: Konstantin Taranov <kotaranov@linux.microsoft.com>,
 kotaranov@microsoft.com, pabeni@redhat.com, haiyangz@microsoft.com,
 kys@microsoft.com, edumazet@google.com, kuba@kernel.org,
 davem@davemloft.net, decui@microsoft.com, wei.liu@kernel.org,
 sharmaajay@microsoft.com, longli@microsoft.com, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <1719838736-20338-1-git-send-email-kotaranov@linux.microsoft.com>
 <1719838736-20338-2-git-send-email-kotaranov@linux.microsoft.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1719838736-20338-2-git-send-email-kotaranov@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/7/1 20:58, Konstantin Taranov 写道:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Add helper to get a master netdevice for a given port.
> When mana is used with netvsc, the VF netdev is controlled
> by an upper netvsc device. In a baremetal case, the VF
> netdev is the master device.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 18 ++++++++++++++++++
>   include/net/mana/mana.h                       |  2 ++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index d087cf9..b893339 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2948,3 +2948,21 @@ out:
>   	gd->gdma_context = NULL;
>   	kfree(ac);
>   }
> +
> +/* the caller should hold rcu_read_lock */
> +struct net_device *mana_get_master_netdev_rcu(struct mana_context *ac, u32 port_index)
> +{
> +	struct net_device *ndev;

 From the comments, this function requires rcu_read_lock. Can the 
following be added in this function?

RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu read lock held");

If rcu_read_lock is not held, this function will notify the caller.
This can explicitly ensure that rcu_read_lock should be held before this 
fuction is called.

Best Regards,

Zhu Yanjun

> +
> +	if (port_index >= ac->num_ports)
> +		return NULL;
> +
> +	/* When mana is used in netvsc, the upper netdevice should be returned. */
> +	if (ac->ports[port_index]->flags & IFF_SLAVE)
> +		ndev = netdev_master_upper_dev_get_rcu(ac->ports[port_index]);
> +	else
> +		ndev = ac->ports[port_index];
> +
> +	return ndev;
> +}
> +EXPORT_SYMBOL_NS(mana_get_master_netdev_rcu, NET_MANA);
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 46f741e..2d3625c 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -797,4 +797,6 @@ void mana_destroy_wq_obj(struct mana_port_context *apc, u32 wq_type,
>   int mana_cfg_vport(struct mana_port_context *apc, u32 protection_dom_id,
>   		   u32 doorbell_pg_id);
>   void mana_uncfg_vport(struct mana_port_context *apc);
> +
> +struct net_device *mana_get_master_netdev_rcu(struct mana_context *ac, u32 port_index);
>   #endif /* _MANA_H */


