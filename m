Return-Path: <linux-kernel+bounces-328575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 669229785F7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116521F24C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497B278C76;
	Fri, 13 Sep 2024 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UF02V0tb"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCF7482DB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245663; cv=none; b=Sih4XczHokVh8v4H8hsI6dSP+zbg+lJlNipgbqvYGkSFEwIfhIAK1QuMVrm4Ll8bz8o2rl65jmicPtai5LE1eNtM0vh+yeb1eVph9pzBgeoBwNNm5+cW0b09Fzt9KnNeC7vT+SWf8tEZ2ECw+KgyjXUF1I4KVXONzNVyRZQqhp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245663; c=relaxed/simple;
	bh=HhYMYnEDCfAu/czHEFoDMqeqegceDcImzlGxTPN4FyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5NFI8tMTez3L2GsMBasLjFsutdJEOZVwzUpW0wfFPKBfVCXdOuTNNw0Hq3f6b+nDwRFuKHpdGy4OTJT+y9U9iUhH7RUUx3iYxcnQo7dqKc90VsEepBKgYBVsw0WYyuHKZS/us/vq4R3UtRzY4vStzEeMbBwh2+Xv9hefZe4FFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UF02V0tb; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <14e6f307-1aaa-4862-a22f-4833fc18920a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726245658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wG4ZcFkaU9wM1fuGnOPOZ06ynoZgWADJYJlzgy7RAcM=;
	b=UF02V0tbxau1xdYEebDycBjEwN7gqdm1KS9I+SduH4IbyKxFCL+ASKhsM1b54NFQBURG3z
	Uw2fj9quCfJjJcBlpDtB6SciWQh6xm+fU/Jo+ujz0huJ78UO90YOz5f2HrOE/ehfFbw/lP
	O6UII46xxunMiGzSDCs6n91R4rVbAV0=
Date: Fri, 13 Sep 2024 17:40:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: ethtool: phy: Don't set the context dev
 pointer for unfiltered DUMP
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Nathan Chancellor <nathan@kernel.org>, Antoine Tenart <atenart@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com, davem@davemloft.net
References: <20240913100515.167341-1-maxime.chevallier@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240913100515.167341-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/09/2024 11:05, Maxime Chevallier wrote:
> The context info allows continuing DUMP requests, shall they fill the
> netlink buffer.
> 
> In the case of filtered DUMP requests, a reference on the netdev is
> grabbed in the .start() callback and release in .done().
> 
> Unfiltered DUMP request don't need the dev pointer to be set in the context
> info, doing so will trigger an unwanted netdev_put() in .done().
> 
> Reported-by: syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/000000000000d3bf150621d361a7@google.com/
> Fixes: 17194be4c8e1 ("net: ethtool: Introduce a command to list PHYs on an interface")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> This patch fixes a commit that still lives in net-next.
> 
>   net/ethtool/phy.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
> index 4ef7c6e32d10..ed8f690f6bac 100644
> --- a/net/ethtool/phy.c
> +++ b/net/ethtool/phy.c
> @@ -251,8 +251,6 @@ static int ethnl_phy_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
>   	int ret = 0;
>   	void *ehdr;
>   
> -	pri->base.dev = dev;
> -
>   	if (!dev->link_topo)
>   		return 0;
>   

I've checked that this is leftover from the previous series.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

