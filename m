Return-Path: <linux-kernel+bounces-552393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEF3A57983
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F681724DC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023681AC458;
	Sat,  8 Mar 2025 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Aj1c93O7"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DE218C32C
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741426438; cv=none; b=VdZAF7fmfDWUx+DFqr9GDexcY3ThF/ZRcWMPIyi/Fwd1ScRCeKn0E/0tC/wdJUa7YqyX7esQ6m87O6SZljDSkkHZR30o0AP/yz6Vu6WoGKgLgcV36Qe6VAmeST1nLpVTrClTGtnuWOBgOfzxsaOzXj5KJsc5JmoqEwNPeA+6kdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741426438; c=relaxed/simple;
	bh=8JRWEPkcbZU8KQBQuODDmLBLljt+c0ZfuR22i+u1KbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9QpSbB1XICqT2DK5TuW4bu+RwzsRLKhaYIYqp91uhRvpXhXEPN4FnGJ0d7cNvjAXZ/hXpA6ZGWrp2jBT8RAkrJuQllzJAmvalZn+cMN3uCSKVAD8QKQq8m8or2egxB8c0ZjfMuEIKB08D+htbfiHKSgM8RjQ8x/B2JZu2l9uJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Aj1c93O7; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <051c66d5-2751-4dfb-88df-3a4a1f86bb71@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741426424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcLw7shfI50Q27EtBRTL5tYuszmcD8BPa3jzuj4PVWg=;
	b=Aj1c93O7sRk8dZswKp03dAiwaVDyWRxUNH46JEXG7l+hSjozmiJRw5zpy4ygt29cezv+ul
	STWQ6Hv9r93RqBSByly80mST8NWfh02kVvRubeWM2uu9RhCJPgo7HYrdtIaEYb34NBlrnX
	4Wbm1UmZIQ7CDJxRI+m8RKrryB8FRyQ=
Date: Sat, 8 Mar 2025 09:33:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net: ethtool: tsinfo: Fix dump command
To: Kory Maincent <kory.maincent@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20250307091255.463559-1-kory.maincent@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250307091255.463559-1-kory.maincent@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 07/03/2025 09:12, Kory Maincent wrote:
> Fix missing initialization of ts_info->phc_index in the dump command,
> which could cause a netdev interface to incorrectly display a PTP provider
> at index 0 instead of "none".
> Fix it by initializing the phc_index to -1.
> 
> In the same time, restore missing initialization of ts_info.cmd for the
> IOCTL case, as it was before the transition from ethnl_default_dumpit to
> custom ethnl_tsinfo_dumpit.
> 
> Also, remove unnecessary zeroing of ts_info, as it is embedded within
> reply_data, which is fully zeroed two lines earlier.
> 
> Fixes: b9e3f7dc9ed95 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Change in v2:
> - Remove useless zeroed of ts_info.
> ---
>   net/ethtool/tsinfo.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
> index 691be6c445b38..ad3866c5a902b 100644
> --- a/net/ethtool/tsinfo.c
> +++ b/net/ethtool/tsinfo.c
> @@ -290,7 +290,8 @@ static void *ethnl_tsinfo_prepare_dump(struct sk_buff *skb,
>   	reply_data = ctx->reply_data;
>   	memset(reply_data, 0, sizeof(*reply_data));
>   	reply_data->base.dev = dev;
> -	memset(&reply_data->ts_info, 0, sizeof(reply_data->ts_info));
> +	reply_data->ts_info.cmd = ETHTOOL_GET_TS_INFO;
> +	reply_data->ts_info.phc_index = -1;
>   
>   	return ehdr;
>   }

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

