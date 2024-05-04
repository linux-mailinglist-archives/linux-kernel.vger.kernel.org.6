Return-Path: <linux-kernel+bounces-168596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B0B8BBA9D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 13:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AD6282DD4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4771CAA6;
	Sat,  4 May 2024 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdSEcuHB"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795A61AACA
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714820675; cv=none; b=KIcUyfZ5IeOZfXm92xT7xK9ZdjVL5GJIN23FA35HQEqTv3PL1U2J+g+vLV28//j1mpDZ3HqRrNJlfoIWU3KKTx6Hs6ZDHZU9B2kWcAtvZ1kwD8l9P9JGHfgz0xVYkzWrPvoZ1hr742YnPkv44f6ng/neH1uJU6lrcyD1oRpgahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714820675; c=relaxed/simple;
	bh=oESbJrzd3NodVfpRoKiTo6HVR3uCwGr/hSqHg54pang=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nT6WxPYyLJAt+spwECG84gQJmHPLYIC5DDgYxAbne4Eb/GqlEslV0rXbMNiQm4ZilodSYPmIVDi9XQi91tfhZcxFzkznbVvDzHzo2D4q2INm0ZCOkvnQiRDIYS2RpCJj6bSRtNatK3hUURF/enxLvqPNEngU256gXcVVSswsqtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NdSEcuHB; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e22a1bed91so5613761fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 04:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714820672; x=1715425472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QqIw4+jSQ5b87qweNz9VaPv59kaDSpMsRWOBQ8BsgAg=;
        b=NdSEcuHBHsnxVuuIuxZq58ivVP8dULucAlMREwUXNdeXdLpQsRMAUtmCwqdbGWNH9y
         ik+LYWye3m09isZWNiRtP1/RWGsqOruQK6PAkBhmGusQL7Ak+ZeChkF/3TmSszp4ieoj
         3D7yQwQdGjL26cpGHqaMs2KyHM0UvSGZ9G0IYSOG4u4P7RDaRgOgzxbcbvnD4Wm3opVB
         P/PerrDOn8PRdzpATmxrB6uNU9PmjVTT+mlR4bQMtRYPYlQH/NZOBOcisOftf9xGvK89
         AgOpcQ8tvVVZS5xn2fEmzWyAw5iDERf2DFl8QXgr+R1bxW0VGEvl3g0xPFOfsiWnwChc
         uvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714820672; x=1715425472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqIw4+jSQ5b87qweNz9VaPv59kaDSpMsRWOBQ8BsgAg=;
        b=WGHjLn42m/nTlUVGol5lYfKQZ3rhwYBeQYrF3N7qSRD5H2RmxnLZT7bZd9PKc6GOu7
         O9CiPYQdoHmPi6BO/1vAAYhZ2yrZIcfYAfAUT7LWyoCUvC1Gz76qkz/t/Q0a4W2ymjMq
         xbu9jxsaIZk++5HtenWd2R0EEG99bhlsp57QGxG2uM3REJrAH+3MOmyXskBMIEpd3XC3
         4eLOgG+Z6tH71Wmjm41TjDVd20fdQUo+kZza+toV6GNk751+uQ5ROzzL577nl1Q2c5K9
         MhvTsU5S9D1WrmystSNQ+UE7lmJDgP8KnRETlNCGz0Guc0ZxRzGkTgBc1bAZvTBRyVL2
         R2og==
X-Forwarded-Encrypted: i=1; AJvYcCUExSF+ad8fe2MWQeKBbuWsGuCzKAPVktDz1a0Ph2+DRznTZSveweGRycLRdBlKf9REGdyNafFprtT5B4i2oFINH5cRtmCvGivvA1mY
X-Gm-Message-State: AOJu0YyPQqdVb5TX/b73gWD0xKefk7zK1wco7bMLwrHNzHx4eybLd2IP
	d9udae+mRbpOuOwCDh4c/yrvF/pg7g0cN/QmrYFRGj9j4hs5yNVikb8OhzQXmhE=
X-Google-Smtp-Source: AGHT+IEVLFaJ2xohkXrGS/+Gw9GuM+CyPwMFte2/sMkc5UfIYuU5HWmYlOdvr36TRiKJGIRWgrjzcQ==
X-Received: by 2002:a2e:3612:0:b0:2d9:f00c:d2d5 with SMTP id d18-20020a2e3612000000b002d9f00cd2d5mr3018955lja.46.1714820671226;
        Sat, 04 May 2024 04:04:31 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c478600b004185be4baefsm9006237wmo.0.2024.05.04.04.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 04:04:30 -0700 (PDT)
Date: Sat, 4 May 2024 14:04:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, jreuter@yaina.de,
	lars@oddbit.com
Subject: Re: [PATCH net] ax25: Fix refcount leak issues of ax25_dev
Message-ID: <808ad381-179c-4975-a3f5-1d7cad00320b@moroto.mountain>
References: <20240501060218.32898-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501060218.32898-1-duoming@zju.edu.cn>

On Wed, May 01, 2024 at 02:02:18PM +0800, Duoming Zhou wrote:
> @@ -58,7 +59,6 @@ void ax25_dev_device_up(struct net_device *dev)
>  		return;
>  	}
>  
> -	refcount_set(&ax25_dev->refcount, 1);

Let's keep this here, and just delete the ax25_dev_hold().  It makes
the diff smaller and I like setting the refcount earlier anyway.

>  	dev->ax25_ptr     = ax25_dev;

Let's move this assignment under the spinlock where ax25_dev_hold() was.

>  	ax25_dev->dev     = dev;
>  	netdev_hold(dev, &ax25_dev->dev_tracker, GFP_KERNEL);
> @@ -88,7 +88,7 @@ void ax25_dev_device_up(struct net_device *dev)
>  	ax25_dev->next = ax25_dev_list;
>  	ax25_dev_list  = ax25_dev;
>  	spin_unlock_bh(&ax25_dev_lock);
> -	ax25_dev_hold(ax25_dev);
> +	refcount_set(&ax25_dev->refcount, 1);
>  
>  	ax25_register_dev_sysctl(ax25_dev);
>  }
> @@ -135,7 +135,6 @@ void ax25_dev_device_down(struct net_device *dev)
>  
>  unlock_put:
>  	spin_unlock_bh(&ax25_dev_lock);
> -	ax25_dev_put(ax25_dev);
>  	dev->ax25_ptr = NULL;
>  	netdev_put(dev, &ax25_dev->dev_tracker);
>  	ax25_dev_put(ax25_dev);

So far as I can see, the ax25_dev should be on the list.  Also, I think
the dev->ax25_ptr = NULL; assignment should be under the lock.  So this
code should just look like:

        list_for_each_entry(s, &ax25_dev_list, list) {
                if (s->forward == dev)
                        s->forward = NULL;
        }

        list_for_each_entry(s, &ax25_dev_list, list) {
                if (s == ax25_dev) {
                        list_del(&s->list);
                        break;
                }
        }
        dev->ax25_ptr = NULL;
        spin_unlock_bh(&ax25_dev_lock);
        netdev_put(dev, &ax25_dev->dev_tracker);
        ax25_dev_put(ax25_dev);
}

Also it should just be on the list once...  In fact, it's impossible for
one pointer to be on a list twice.  So it would be nice to add a break;
in ax25_addr_ax25dev().  It doesn't change the code, it just makes it
more obvious.

ax25_dev *ax25_addr_ax25dev(ax25_address *addr)
{
        ax25_dev *ax25_dev, *res = NULL;

        spin_lock_bh(&ax25_dev_lock);
        list_for_each_entry(ax25_dev, &ax25_dev_list, list) {
                if (ax25cmp(addr, (const ax25_address *)ax25_dev->dev->dev_addr) == 0) {
                        res = ax25_dev;
			ax25_dev_hold(res);
                        break;
                }
        }
        spin_unlock_bh(&ax25_dev_lock);

        return res;
}

regards,
dan carpenter


