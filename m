Return-Path: <linux-kernel+bounces-548493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5643A54598
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CEC11891966
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6F4209F30;
	Thu,  6 Mar 2025 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T//bwE0u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB362080EB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251405; cv=none; b=cY3NTHb8EzUC9JRz2z08iQlvCy4+GQYD0J0CZA6rq2Z2b3+Sv4Gq5xxcfsjivCgrKLPuFAtuWUpHjfFhH0sPYA4j2E7Q5wYYS6g5969a6AFNTrvlDPJkR+cd/KZ4Q1VaeyNt52AsWqw5+6qRn9RW2xDegeEbIvTLKH2blErQ7KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251405; c=relaxed/simple;
	bh=l1bk7fve6dMJQv6KaXGDjnZ1grq9bOuxKpexKdP2z9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpV1Q/+WVwT3eOVhCcZWJ2+yiKnPcgH622y1sV7gbpUda8yCKJ7QSYDxUfX06z12GEsX3Y68Qu3SnA/ogXe65hGRIWFCKcH+wcvGF9Zez0Fbl3sb/HfgrvwYGcTr2K/PP4RDf04V9/93oSJ4oGxVWnbP1NyGOVSsb0qIAUPKrDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T//bwE0u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741251402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cHVzKBF1Q9KJq9LGRjL7gm9YWMcdaoIAOjd6Lj0rKZE=;
	b=T//bwE0ufLOzCXZucaZ0YBc09rX2BfmJaD8pZU5E995oFs6zDAP1vrnCL0HcZcy52qTNNW
	QZZW8UOzq6QWBhjuiMNk/HwM4dVHyfacESKe9ZT1aKydAwRqoW+0bS9tMyMb2E29GlObPf
	N22+HC/W6BbHyOcU8jayBePz0GAbeqY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-W_gt6DRCOAuBQg0kw-_paw-1; Thu, 06 Mar 2025 03:56:36 -0500
X-MC-Unique: W_gt6DRCOAuBQg0kw-_paw-1
X-Mimecast-MFC-AGG-ID: W_gt6DRCOAuBQg0kw-_paw_1741251395
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43bcb061704so1464805e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 00:56:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251395; x=1741856195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHVzKBF1Q9KJq9LGRjL7gm9YWMcdaoIAOjd6Lj0rKZE=;
        b=jPukPpYbbU8LVn2pbyeueL2ZDwpuLojxXj37HzKMZptzEv8IW8R5vmcnEiBcBtK7o/
         qvmZ+FFcIJx6QGtfdshRXBlYmwhP/mTI3e2fV0/BWx8aoROmtAmGM3cQ41PCKchxyCHH
         nntAMZr4+rw4yehYrmljNplh/7dH0GEEkSlK7vUdAboWlepm0k9SXJL1F/w96A7Ih89k
         LKbd5gtl9Un64kZJPED/gPl75CLNmSV7XrLcVX8K2CI4YZ/x+ZRnOBT0pL6ufIO1uzZ6
         HJ1+be7vkb9eXBiLPSI2M4w4Mek9wI8kwuyxDfG9JAHu92irhAGqRTl0uiIdzqcKNt+h
         hOcg==
X-Forwarded-Encrypted: i=1; AJvYcCVCJMz5HcvmONDdTIIEy0zeAIC0Ro0ohicgU2tv9EmCRy+cak88QAHUP/nybSNNdyPEQlKgiAuc8plUgFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsk3LxONwKaQU8D70vMIgELg4EZ6S6pWEGAC9byI1544bwZXbm
	HdlYW4HO2HcDjiPU0P34JUnAi7DqBNuBLLd9Trdf2iuZiZo554hptoODoTuzBNv/cwupl1y/znY
	v2kmmF+aEptY/5xicjU7veOHnafJDiEsbHlxm5sYSCkDaYaQ+yMXqUh34VWE4/g==
X-Gm-Gg: ASbGncunidFyy7q/9RMzt8DM8LQHRi8qIlsf2SgVPdrwO5o3KplE3XdEjZ+NL/JKx92
	4FCCCQEOmlIQnodAmpV9EETZcPFMhQRBXsXOz5TFH53yl7J3OWl2rXxAcL2rO1vhq6P0B03LX5l
	26tpCT0v4IvmaJUjlIkp8CKX3iq5oA8fNrhheJ8OywAwJyF3DCJhwt9zWobVAODSH2R/N/c0mDs
	cfACcdVsEujuJ+6T+zPEOf30W1y2DoHQiKJMDEgFTujx5A2Hz3/GzUuOYfHBSPS2ZZg+OqniJIS
	STmhq7HiEY+UgWXZn2oBww3Vvr6AFebeseu10mRoOy5dAg==
X-Received: by 2002:a05:600c:d4:b0:43b:c857:e9c8 with SMTP id 5b1f17b1804b1-43be0661ffcmr7598365e9.31.1741251394945;
        Thu, 06 Mar 2025 00:56:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfwGEtj9NaQs8CRvPvXsv8CwsyiViPjo3ntC+rkCUxEKfACGLB5V95GvmcnS2yafdbLJvCcA==
X-Received: by 2002:a05:600c:d4:b0:43b:c857:e9c8 with SMTP id 5b1f17b1804b1-43be0661ffcmr7598115e9.31.1741251394643;
        Thu, 06 Mar 2025 00:56:34 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bcc135676sm57848145e9.1.2025.03.06.00.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 00:56:34 -0800 (PST)
Message-ID: <350bb4f6-f4b5-44c3-a821-ac53c8641705@redhat.com>
Date: Thu, 6 Mar 2025 09:56:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>,
 Romain Gantois <romain.gantois@bootlin.com>
References: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
 <20250303090321.805785-10-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250303090321.805785-10-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/25 10:03 AM, Maxime Chevallier wrote:
> @@ -879,8 +880,10 @@ static int phylink_parse_fixedlink(struct phylink *pl,
>  	linkmode_copy(pl->link_config.advertising, pl->supported);
>  	phylink_validate(pl, pl->supported, &pl->link_config);
>  
> -	s = phy_lookup_setting(pl->link_config.speed, pl->link_config.duplex,
> -			       pl->supported, true);
> +	c = phy_caps_lookup(pl->link_config.speed, pl->link_config.duplex,
> +			    pl->supported, true);
> +	if (c)
> +		linkmode_and(match, pl->supported, c->linkmodes);

How about using only the first bit from `c->linkmodes`, to avoid
behavior changes?

Thanks!

Paolo


