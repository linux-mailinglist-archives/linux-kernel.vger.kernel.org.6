Return-Path: <linux-kernel+bounces-529526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF6EA4277F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C593AEAF6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB82627E1;
	Mon, 24 Feb 2025 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lQG+gacF"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3210825A645
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413151; cv=none; b=epEEG3fmlNoRWiwtfAU0goFT1acJm427VXFK294UMt853Irv9pZKkfBo7eEFCWlpxNlfJSckcpcj5PDGvqRpLxW9VbARlHXS/WN60T94EMrOGRkggTLHBFQbI4KJAdHl3hdn3MofX1EksD+hpyJtn1Z/DZTnahe6NDnC2s7kzNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413151; c=relaxed/simple;
	bh=qld9vDpB6QDXxnS+8fXAONoUc5F9WAZoTYNAokUyWH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRlfT58rYKifXTkpWm5dTOEf7wJpEgmpNIKX3HodpfnZQ5vyBERr69kd8xGslO7Ivqr1G+ZPb0ImN7VenAEoGb/Ap4YBjAA2h9PdAZIhjscH8X76Ll8JYxTmZI1KbH52CR34PWu3SdWBCFJHV7OtcaLCMsiQaSl26wzLtvWLPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lQG+gacF; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <451d4cfe-b22f-4ac5-9074-05a2155f7d6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740413146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D1Rbf9tEpuTcSX5Ha3F0jZOYLk78dDb108drquGs+dE=;
	b=lQG+gacFqb/aKv2uO2khuC+L2k+vkY9QlpGyXc62KwxI2OSsFuUymwrKqnb/I9zXitLs/+
	fUBjZLpNErr4kj9pxxcb8J9DOCaGDHYvRplfSXaffdSe+BSeR03M3qth3/mk4355HMqy5j
	dsJRLwP2e4dzE0SzpWG4K+m2VT3bQGs=
Date: Mon, 24 Feb 2025 16:05:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: wangxun: fix LIBWX dependencies
To: Arnd Bergmann <arnd@kernel.org>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Andi Shyti <andi.shyti@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250224140516.1168214-1-arnd@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250224140516.1168214-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/02/2025 14:05, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Selecting LIBWX requires that its dependencies are met first:
> 
> WARNING: unmet direct dependencies detected for LIBWX
>    Depends on [m]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PTP_1588_CLOCK_OPTIONAL [=m]
>    Selected by [y]:
>    - TXGBE [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PCI [=y] && COMMON_CLK [=y] && I2C_DESIGNWARE_PLATFORM [=y]
> ld.lld-21: error: undefined symbol: ptp_schedule_worker
>>>> referenced by wx_ptp.c:747 (/home/arnd/arm-soc/drivers/net/ethernet/wangxun/libwx/wx_ptp.c:747)
>>>>                drivers/net/ethernet/wangxun/libwx/wx_ptp.o:(wx_ptp_reset) in archive vmlinux.a
> 
> Add the smae dependency on PTP_1588_CLOCK_OPTIONAL to the two driver
> using this library module.
> 
> Fixes: 06e75161b9d4 ("net: wangxun: Add support for PTP clock")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/net/ethernet/wangxun/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/Kconfig b/drivers/net/ethernet/wangxun/Kconfig
> index 6b60173fe1f5..47e3e8434b9e 100644
> --- a/drivers/net/ethernet/wangxun/Kconfig
> +++ b/drivers/net/ethernet/wangxun/Kconfig
> @@ -26,6 +26,7 @@ config LIBWX
>   config NGBE
>   	tristate "Wangxun(R) GbE PCI Express adapters support"
>   	depends on PCI
> +	depends on PTP_1588_CLOCK_OPTIONAL
>   	select LIBWX
>   	select PHYLINK
>   	help
> @@ -43,6 +44,7 @@ config TXGBE
>   	depends on PCI
>   	depends on COMMON_CLK
>   	depends on I2C_DESIGNWARE_PLATFORM
> +	depends on PTP_1588_CLOCK_OPTIONAL
>   	select MARVELL_10G_PHY
>   	select REGMAP
>   	select PHYLINK

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

