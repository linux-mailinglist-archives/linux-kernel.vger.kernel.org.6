Return-Path: <linux-kernel+bounces-571635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822DBA6BFF8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE783B0690
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB8422D794;
	Fri, 21 Mar 2025 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmfJMmu5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E685F22B8D0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574685; cv=none; b=DaLW3zettEPYN68JZEC4PBQNEnInFLD4WoP+66cyDeNij5RtqcFFTgG5zBOyELHPLGxhfcculnwI24oDNzqaJtu7U6v88rmJ9N94HCckZjsp8FBm06V3HfJ7vG4nwwSm7y4iiAQtmUBH4+GutYOVKW2fz027fdWiF1BVghU7C/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574685; c=relaxed/simple;
	bh=TTuTJrh7x9Bt4TSiLnCijMGPZZ4HvDdlyCy/gTUUm5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJoFtDkzsPz9PGafjG/0CZFg3rxtwo6V5Sd2vwDs0y8JnecidpEmRFqo0sDWSYCOV59fmcivvnFYqDwZIQrI2FV+19ro7xz1EawfEPonk6ozbfujZkkvYtLw2Bbk+olY+daCp14iHu5zgqOs5LkKG5Av+K56v1AdBQejyDx5Exw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hmfJMmu5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742574683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rs+RwcS9h+V2ikhjyQECAnVV51IDsPepgkZ5ImH1XsI=;
	b=hmfJMmu5GuaaAMHF/zWRKBAzwfc2N7kStz1ENUa/NHNvOpH6iLY54b1h5WvZiRktGnmDZ7
	kOlqOEZCLxLDsHYwTjon4/0JcmedXIa355Ot8QgZDxw9Cr2XU+wTIvfwPTUqlXC1yN7UZx
	ESgokUotfGY26C/Il1mqoII9C8f0XUs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-5SwV6zVWPqO-Dn5SGyYs7w-1; Fri, 21 Mar 2025 12:31:21 -0400
X-MC-Unique: 5SwV6zVWPqO-Dn5SGyYs7w-1
X-Mimecast-MFC-AGG-ID: 5SwV6zVWPqO-Dn5SGyYs7w_1742574680
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3912539665cso1633631f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742574680; x=1743179480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rs+RwcS9h+V2ikhjyQECAnVV51IDsPepgkZ5ImH1XsI=;
        b=R1qmf+END0q/SIRFyE/Uo/WGF7p7otWcOHBT98CTqtODh9ldLAtIvF6+qGc4QDPIXs
         erCU5tScOW4ufjBy0AHAPt+7NQFP/bCPSsiL08n9oUGjIFuGvDSI6FLsVN0yPHaa6760
         /09VjD/9Ej+zpI0Iezlnv9fsocDJohFsPDgFdnqVysg6PPv1ingFMhGd/9TuATq63Omw
         kud2Da1p3jYo2re1Y/2W9FSreQQuIYHikjbIhosMX/E6KcDqkTXNchGeVjvb6oJTKQjU
         BWNzxA6dy/N+URAwtEhA7BZeaxFpkGoCybZ5Entk1RsZXG8GlIn9htt6Dnymj7AEDNuW
         2etw==
X-Forwarded-Encrypted: i=1; AJvYcCWZUjsvb9Sk45fcN0oi9ET3uMSU6c/gweAvR3uh2KeOInh/nVpKaF50ufF3vHiZV6pXpdPHVy7QG/KvJlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ00slvDwK8CCIEbostyvB9DKuqhSXnrPtO8+ugsWIyP91RcN9
	CJ6kXogC/LJmcbpMWOQxmBcHAqy+WQQ9mE9gxvw8ytpk9aXsfsujYSRyzvXhf0+R/rrH322wjXE
	uzNno/CuJsGIYPHW2ktUHm9Z57rrvX1k3rG5kVZ6uysW24emmkP6n+Zb3tBkvHA==
X-Gm-Gg: ASbGncs5zGtOL0naAuzuy1AUjy9mSbGLzX3sW4H+k1n/dYPwawp2MJ2nE72Bjo0EMao
	O3VerKU5AO1uZI9lSdHg5Anm3EDZ92m9iBK52yHQUm5MSSu95rKfdGRpha7n1OkH38QRYaykkPZ
	kGXpruDU68AOx2zcVR+FVul/2b2ysikOe6DxNVsgqNO54g4SrrMp56DypeRLxUoOt+x84fjsgSg
	YJIh6n/ZBK2tesgcAd7JsqVWN4q2neiCs7riXAGGtebfgdDhGgUuIQLd7SnTxcSJWXIrIxBZNer
	1sNzMePPuXcBl/W32BoROay5h1JMDNrhq3OU6Lezfkqa1A==
X-Received: by 2002:a5d:64ce:0:b0:38d:dc03:a3d6 with SMTP id ffacd0b85a97d-399795567f7mr7617668f8f.4.1742574680070;
        Fri, 21 Mar 2025 09:31:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd4IZz5KXdcrX0+aF/TgGlXF2jzu4TiS7+n1daZwv+t8eYjf13W84OlRjl+h4tIxUwcH3iXA==
X-Received: by 2002:a5d:64ce:0:b0:38d:dc03:a3d6 with SMTP id ffacd0b85a97d-399795567f7mr7617598f8f.4.1742574679564;
        Fri, 21 Mar 2025 09:31:19 -0700 (PDT)
Received: from [192.168.88.253] (146-241-77-210.dyn.eolo.it. [146.241.77.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f6bsm2830317f8f.39.2025.03.21.09.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 09:31:19 -0700 (PDT)
Message-ID: <c4e5bd2f-6216-4f74-b677-46c79343eb21@redhat.com>
Date: Fri, 21 Mar 2025 17:31:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/7] net: ethtool: netlink: Allow
 per-netdevice DUMP operations
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
References: <20250313182647.250007-1-maxime.chevallier@bootlin.com>
 <20250313182647.250007-2-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250313182647.250007-2-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/25 7:26 PM, Maxime Chevallier wrote:
> We have a number of netlink commands in the ethnl family that may have
> multiple objects to dump even for a single net_device, including :
> 
>  - PLCA, PSE-PD, phy: one message per PHY device
>  - tsinfo: one message per timestamp source (netdev + phys)
>  - rss: One per RSS context
> 
> To get this behaviour, these netlink commands need to roll a custom
> ->dumpit().
> 
> To prepare making per-netdev DUMP more generic in ethnl, introduce a
> member in the ethnl ops to indicate if a given command may allow
> pernetdev DUMPs (also referred to as filtered DUMPs).
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  net/ethtool/netlink.c | 45 +++++++++++++++++++++++++++++--------------
>  net/ethtool/netlink.h |  2 ++
>  2 files changed, 33 insertions(+), 14 deletions(-)
> 
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index a163d40c6431..7adede5e4ff1 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -587,21 +587,38 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
>  	int ret = 0;
>  
>  	rcu_read_lock();

Maintain the RCU read lock here is IMHO confusing...

> -	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
> -		dev_hold(dev);
> +	if (ctx->req_info->dev) {
> +		dev = ctx->req_info->dev;

.. as this is refcounted.

I suggest to move the rcu_read_lock inside the if.


>  		rcu_read_unlock();
> +		/* Filtered DUMP request targeted to a single netdev. We already
> +		 * hold a ref to the netdev from ->start()
> +		 */
> +		ret = ethnl_default_dump_one(skb, dev, ctx,
> +					     genl_info_dump(cb));
> +		rcu_read_lock();
> +		netdev_put(ctx->req_info->dev, &ctx->req_info->dev_tracker);
>  
> -		ret = ethnl_default_dump_one(skb, dev, ctx, genl_info_dump(cb));
> +		if (ret < 0 && ret != -EOPNOTSUPP && likely(skb->len))
> +			ret = skb->len;
>  
> -		rcu_read_lock();
> -		dev_put(dev);
> +	} else {
> +		for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
> +			dev_hold(dev);
> +			rcu_read_unlock();
> +
> +			ret = ethnl_default_dump_one(skb, dev, ctx,
> +						     genl_info_dump(cb));
> +
> +			rcu_read_lock();
> +			dev_put(dev);
>  
> -		if (ret < 0 && ret != -EOPNOTSUPP) {
> -			if (likely(skb->len))
> -				ret = skb->len;
> -			break;
> +			if (ret < 0 && ret != -EOPNOTSUPP) {
> +				if (likely(skb->len))
> +					ret = skb->len;

IMHO a bit too many levels of indentation. It's possibly better to move
this code in a separate helper.

Thanks,

Paolo


