Return-Path: <linux-kernel+bounces-442827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6D59EE280
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5B4284635
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC90420E6E2;
	Thu, 12 Dec 2024 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="eQJU7Rev"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74C5204C36
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995180; cv=none; b=BLTdqUse2Xne/z3zXLqAk6k0Jst48rtEHed9ZwXRX9eJlXBryvPE0DCSzfWZEgiVyICe4SpxAMHv5ZI0CbX4BNPlNjXGjuXIaRHf4lNCMvLuqOS2ZShKkyjhrndh62vSSa7wfaGOm0zxYJppRbQiXy670n0f5F9jDkvzbB089c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995180; c=relaxed/simple;
	bh=+XYxslf9807ANkkmItLTVtW58UAN7h4Ov1PT5JQxV70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGpW/g+osmi/JuO157/9Q5zJU8d0cvqYSrbLrL1EUBbINbEJEgMr1yV40AFY7j3L6pFdM4pp53iw7OdhjcwLFqQeHw6wnPSYDXZ48GApVK7Qg89PJndR7azzkOfIV4/hSp29PQKu1q+lnXff2Z9P2ltxOSybGdUGiR6N0XMourI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=eQJU7Rev; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9ec267b879so69568266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 01:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733995175; x=1734599975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOT7SbPJ2rQiYOFe9U/+XO94gsWo7iytdYj0QsI0vmU=;
        b=eQJU7RevsYAVcLLIoCNFBv3ISO7JlYYN5+OMTpYNix7MJu9lFgAuVE5JEGLH8XXRSN
         Fk4Vms6DVsLepRkjnoliht7pgkH1AC7uF26j0noIHvcrueH4LsrVQcqSF1seo8f5UM60
         lSqEYF9VL3jdk5DC0N0eY0RCzPRY1ZFTskkmGZka8qXp1uDLD2CgG5flSS+pgeu4ViU4
         LtQmlSSKu6AvgSpWUc4um6mYCGSrReKABR2pnh22c2WoYQnYdvmKYS4t8VuGIBpFH76u
         nwjDw98Hf0disync16tRgohk01Nr28h33V6EApR/GogAJfVUqJP89mOpiILiIvHwI2G9
         BnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733995175; x=1734599975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOT7SbPJ2rQiYOFe9U/+XO94gsWo7iytdYj0QsI0vmU=;
        b=Sm5buctDUTWXiVU2eQSquwFRqSayUjuqCKJY6Bm4dHtJWJGyzT+uhm+kwpxEP03fBC
         TjchU1WBpNNFYkfxHlTCtrbkT0ZdubEBlOkQG8D2MbcqcpQHsxzJKBsvrD5CCDqfIACd
         BcPToBBPzJOBte0kDk2heHwRBVtt5ElTF9nLz5jjf6HMUjSdeGKbhpB9UAGpRvsxqxyn
         SGOJzDQxQlrGZjCspWexPURygWQiMHCwFEFUYIwOD4auoWDtKx02B/gSGDrtggBjpQt9
         IL3Q7N7mujy/Xyz6Ii0IbRtgP7Ow+p0R/b9SWG8IV5e00TGAO6IMrF8hAUlUzRHYm1Wf
         Ma1w==
X-Forwarded-Encrypted: i=1; AJvYcCX44pKeLddPSah4HJ9GA67OPzrA2gBEFHrEK8veea3wJdpizkoAS5SfjB349yUkffk57LKReCwuWA4OvA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+zHL33oXT2DBX8AAULxX8+YglheomLHTQPD2xsd3UWllFagaL
	KPZ2MIGE5IfJ6MPz+ih0oKrEMI5RelEP9tskNXi+K+Mj9/bc+aTQjZp6in/Tygc=
X-Gm-Gg: ASbGncvHi/2v7ni5HiNl/ofOzyLy9r4Rr73Ppy9Wq8Pm/A2YWaSQyg+jsb3kW3iR7c1
	EEpbWusjVlsxLuk/8vN1mlrh+0Gj9SLjlAyrxtPV9rzTXovyip5Ni9F6plTnRneIi9vDV47icHZ
	ZUOtk42yJ3+DGcuds/+JG5D+4RCLqcmeauQuvgkFYXRAbf5MohZJvdZbAntgb2lTxzLAtd9+uJO
	VOJWqYDYA9Y+S2XY+v0jn0QtorhKZPd12YE+E2D0YKdvE5HVOLLr/Bic+U=
X-Google-Smtp-Source: AGHT+IH1til71TqzpTAVwmRAgwAL54yooaxzeUzZ97FhI40WlFkHR2qJBaFdJHFiR4OgflPRhkitrA==
X-Received: by 2002:a17:906:4d2:b0:aa6:b4b3:5925 with SMTP id a640c23a62f3a-aa6b4b36060mr462442666b.14.1733995175079;
        Thu, 12 Dec 2024 01:19:35 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa689a0a6fcsm549704566b.30.2024.12.12.01.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 01:19:34 -0800 (PST)
Message-ID: <032ea83b-0df0-4c88-b0d1-153d9c1bf865@blackwall.org>
Date: Thu, 12 Dec 2024 11:19:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] bonding: fix xfrm offload feature setup on
 active-backup mode
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241211071127.38452-1-liuhangbin@gmail.com>
 <20241211071127.38452-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241211071127.38452-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/24 09:11, Hangbin Liu wrote:
> The active-backup bonding mode supports XFRM ESP offload. However, when
> a bond is added using command like `ip link add bond0 type bond mode 1
> miimon 100`, the `ethtool -k` command shows that the XFRM ESP offload is
> disabled. This occurs because, in bond_newlink(), we change bond link
> first and register bond device later. So the XFRM feature update in
> bond_option_mode_set() is not called as the bond device is not yet
> registered, leading to the offload feature not being set successfully.
> 
> To resolve this issue, we can modify the code order in bond_newlink() to
> ensure that the bond device is registered first before changing the bond
> link parameters. This change will allow the XFRM ESP offload feature to be
> correctly enabled.
> 
> Fixes: 007ab5345545 ("bonding: fix feature flag setting at init time")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c    |  2 +-
>  drivers/net/bonding/bond_netlink.c | 17 ++++++++++-------
>  include/net/bonding.h              |  1 +
>  3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 49dd4fe195e5..7daeab67e7b5 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -4389,7 +4389,7 @@ void bond_work_init_all(struct bonding *bond)
>  	INIT_DELAYED_WORK(&bond->slave_arr_work, bond_slave_arr_handler);
>  }
>  
> -static void bond_work_cancel_all(struct bonding *bond)
> +void bond_work_cancel_all(struct bonding *bond)
>  {
>  	cancel_delayed_work_sync(&bond->mii_work);
>  	cancel_delayed_work_sync(&bond->arp_work);
> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index 2a6a424806aa..7fe8c62366eb 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c
> @@ -568,18 +568,21 @@ static int bond_newlink(struct net *src_net, struct net_device *bond_dev,
>  			struct nlattr *tb[], struct nlattr *data[],
>  			struct netlink_ext_ack *extack)
>  {
> +	struct bonding *bond = netdev_priv(bond_dev);
>  	int err;
>  
> -	err = bond_changelink(bond_dev, tb, data, extack);
> -	if (err < 0)
> +	err = register_netdevice(bond_dev);
> +	if (err)
>  		return err;
>  
> -	err = register_netdevice(bond_dev);
> -	if (!err) {
> -		struct bonding *bond = netdev_priv(bond_dev);
> +	netif_carrier_off(bond_dev);
> +	bond_work_init_all(bond);
>  
> -		netif_carrier_off(bond_dev);
> -		bond_work_init_all(bond);
> +	err = bond_changelink(bond_dev, tb, data, extack);
> +	if (err) {
> +		bond_work_cancel_all(bond);
> +		netif_carrier_on(bond_dev);

The patch looks good, but I'm curious why the carrier on here?

> +		unregister_netdevice(bond_dev);
>  	}
>  
>  	return err;
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 8bb5f016969f..e5e005cd2e17 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -707,6 +707,7 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
>  int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave);
>  void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long delay);
>  void bond_work_init_all(struct bonding *bond);
> +void bond_work_cancel_all(struct bonding *bond);
>  
>  #ifdef CONFIG_PROC_FS
>  void bond_create_proc_entry(struct bonding *bond);


