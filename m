Return-Path: <linux-kernel+bounces-312868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F50969CA3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4095B24046
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FDE1C984F;
	Tue,  3 Sep 2024 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTinp3ZV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553EA1B9859
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364762; cv=none; b=h3iY/7fzuuihXC3lckn+oDr3dGnpBR1M8AvxBiAnvYaS+ZZYiU+kD97mSdByZWFMaALodoLq7eG1CJ36NSUGngFXB1kdAPxn/p6NN0hJPRCJ+0YqvRCUrxDDIBOUmNNtAy0uNft9TSbIYNqDkXVgysv4F2DCxGatdSZG0YcIZ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364762; c=relaxed/simple;
	bh=9an5SNRHHUgCW2mocC01A8ucW7OL3399L2FiMAVZGFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGZpDQkw5jduAxD729ME5NGmrvXfSNri0JvLsweC7ioJvY7b/KBVwOC4Rnoclbn/GVGXrV5D2kU6Ac7fzo/+pEIc7kAGeWzw4jXMwd1W+NCna42Q3+uR4kcqGTN4mBDRlG5y3XF9hjW8PtRSkxbiEdG8dLkDKW5xFx0bsG2OPZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTinp3ZV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725364760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eW+oWF8uHdYs0IDc0sGYHwMXdGVR/s8ug84wPArmDAE=;
	b=gTinp3ZVx7hhLDlnAWgWWFOfQxrRhQ4ErB3mU8YC1S0aQwD5XSgdImpKm6ipaTc46Ldh/M
	aoZ8C7g99tYMDib7zBJRGxymd77ZhlYvuXFplge0BWsbNggVcUNLBZERB3UVe88pOLFlvP
	fhDwJylrwBZhIKDKpFfG0kY1tDx+YyA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-pv2-g6xjORSShlM2kxRMEA-1; Tue, 03 Sep 2024 07:59:19 -0400
X-MC-Unique: pv2-g6xjORSShlM2kxRMEA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374c3402d93so1793516f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 04:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725364758; x=1725969558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eW+oWF8uHdYs0IDc0sGYHwMXdGVR/s8ug84wPArmDAE=;
        b=UfW7LJeoBAdwrWRgamC+rsXvTsIH5QwsAquCkq6zeqKo6ZHZk+a3EPxH4psj0unLUA
         ACuBQfHtk1ja002djxnvZIVjebEZqxckaccHnFLtib/mlkcPp7FJg5Ll4ySOhnt6j1c4
         Ro/K+p0BqXS8dG7jNejfWoE8GkZz2uX9OX8C9l3omHJDBwAoT2BSl/TZO+sD4d+X/Hpu
         DdyJ+a1WeXZTF6tS5PuK+cj3rl0VRtWH52aiYGKxZhE6v2W3Lads48VXKnHhESXZHKaQ
         ckz0aRYn7qO/0fXndFen4dFUe5pKBAmYIB78S8hmIzHttrzxL2TklkzfRKBqciJmAO1L
         VtKg==
X-Forwarded-Encrypted: i=1; AJvYcCVWzS1sQrSVr6Gag6MiBiai4/hRwfcAoPlh6vY7lF9CFLG6Zkhf3Fn2n/GSxmDty4VlqErI98IAl1tym0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxot0HPpDob0oiYZg3VIq1zeDmI0e9i/shRKOJKtPJf+T1FoEPr
	coi/EBdFg9AnLqGyHoL6WqHUxAmRaQYBm+7RbXygvaQJV1oQ/hYOAOMW4zRodBfaiDNtHa4Zv88
	JTHTI4Xg+3vAaUgyKQ7WN86FirmRSgRhFmAMVtVtMnRNJuDoa2FsJTNLR+aAaGw==
X-Received: by 2002:adf:eb8d:0:b0:371:8319:4dbd with SMTP id ffacd0b85a97d-374a9565a7bmr8232163f8f.17.1725364757756;
        Tue, 03 Sep 2024 04:59:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErj+70bDHnbAELAam4llo41z/vLKYkI6hm7wHpiadIT4BVcszal3LrlvsIb+49NfmX0fZ6bw==
X-Received: by 2002:adf:eb8d:0:b0:371:8319:4dbd with SMTP id ffacd0b85a97d-374a9565a7bmr8232145f8f.17.1725364757224;
        Tue, 03 Sep 2024 04:59:17 -0700 (PDT)
Received: from [192.168.88.27] (146-241-5-217.dyn.eolo.it. [146.241.5.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df100csm168343265e9.20.2024.09.03.04.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 04:59:16 -0700 (PDT)
Message-ID: <0ff20687-74de-4e63-90f4-57cf06795990@redhat.com>
Date: Tue, 3 Sep 2024 13:59:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 net-next 03/11] net: hibmcge: Add mdio and hardware
 configuration supported in this module
To: Jijie Shao <shaojijie@huawei.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, sudongming1@huawei.com, xujunsheng@huawei.com,
 shiyongbang@huawei.com, libaihan@huawei.com, andrew@lunn.ch,
 jdamato@fastly.com, horms@kernel.org, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240830121604.2250904-1-shaojijie@huawei.com>
 <20240830121604.2250904-4-shaojijie@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240830121604.2250904-4-shaojijie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/24 14:15, Jijie Shao wrote:
[...]
> +static int hbg_mdio_wait_ready(struct hbg_mac *mac)
> +{
> +#define HBG_MDIO_OP_TIMEOUT_US		(1 * 1000 * 1000)
> +#define HBG_MDIO_OP_INTERVAL_US		(5 * 1000)

Minor nit: I find the define inside the function body less readable than 
placing them just before the function itself.

> +
> +	struct hbg_priv *priv = HBG_MAC_GET_PRIV(mac);
> +	u32 cmd;
> +
> +	return readl_poll_timeout(priv->io_base + HBG_REG_MDIO_COMMAND_ADDR, cmd,
> +				  !FIELD_GET(HBG_REG_MDIO_COMMAND_START_B, cmd),
> +				  HBG_MDIO_OP_INTERVAL_US,
> +				  HBG_MDIO_OP_TIMEOUT_US);
> +}

[...]> +static void hbg_phy_adjust_link(struct net_device *netdev)
> +{
> +	struct hbg_priv *priv = netdev_priv(netdev);
> +	struct phy_device *phydev = priv->mac.phydev;

Minor nit: please respect the reverse x-mas tree order

Thanks,

Paolo


