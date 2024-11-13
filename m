Return-Path: <linux-kernel+bounces-408109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28229C7A88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679CA2820E5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4EC204014;
	Wed, 13 Nov 2024 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mI6TKBDw"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A17F1FF7C7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520792; cv=none; b=hp+Rb7MwOd8yP8Re3msVgp83V0aSk2bHnENJYee5DxtdVADgI+baPqscHLMERIjiAlv5/Q5MS9SaWg0HKAkYeZYWArM/32T063cGdJNzrtsZA2fybALPrMFMKpAg7/AJ3JL+ZUsgUPFWbSotH5yHNAvx/Jgbr/A590w612+LrMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520792; c=relaxed/simple;
	bh=+250bRNDlld8S7rsq44UUhCgM2fdzYbVqUp4Y8cI7jQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTuOuzDMm6Hs8RmFVZVlB9Xsl9C319sD61qKMcdukwVc0iJ/3bqDBhm64jZ7C/Lqa2EeBEhk7sh9sxP1kvceM3xslQBlfa8NJOOO0ypLxs/4MJD9l2YlzZzL04P6kJtYfif6NDVh7Wmy2mF7eB0W78epb8Jct9gOsgqvM3IPmgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mI6TKBDw; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a51c1a58-2ebf-4e1d-a1eb-46c23b953a36@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731520788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BrB0ZjmNU676+Oj7exilRh1EOZSwKds+rDuh0m8Ii8o=;
	b=mI6TKBDwmcY+cAsToeMzU6hd0eUCSZrZyEnrlbj6WTzZ7qKDiQqkp6BzERg491a5Xzzw5i
	aMeDsUdg7R0a5M3uttOWF9+iS/8iKIQ7PXnvflSekyKTg1SE5y1RQqfH01InlaEWGh8WFe
	2JsyeyheTCuKqiCsjvNWFRraWNJ/ilg=
Date: Wed, 13 Nov 2024 17:59:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4 3/7] octeon_ep: add protective null checks in napi
 callbacks for cn9k cards
To: Shinas Rasheed <srasheed@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: hgani@marvell.com, sedara@marvell.com, vimleshk@marvell.com,
 thaller@redhat.com, wizhao@redhat.com, kheib@redhat.com, egallen@redhat.com,
 konguyen@redhat.com, horms@kernel.org,
 Veerasenareddy Burru <vburru@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Satananda Burla <sburla@marvell.com>,
 Abhijit Ayarekar <aayarekar@marvell.com>
References: <20241113111319.1156507-1-srasheed@marvell.com>
 <20241113111319.1156507-4-srasheed@marvell.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241113111319.1156507-4-srasheed@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2024 11:13, Shinas Rasheed wrote:
> During unload, at times the OQ parsed in the napi callbacks
> have been observed to be null, causing system crash.
> Add protective checks to avoid the same, for cn9k cards.
> 
> Fixes: 1f2c2d0cee02 ("octeon_ep: add hardware configuration APIs")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V4:
>    - No changes
> 
> V3: https://lore.kernel.org/all/20241108074543.1123036-4-srasheed@marvell.com/
>    - Added back "Fixes" to the changelist
> 
> V2: https://lore.kernel.org/all/20241107132846.1118835-4-srasheed@marvell.com/
>    - Split into a separate patch
>    - Added more context
> 
> V1: https://lore.kernel.org/all/20241101103416.1064930-3-srasheed@marvell.com/
> 
>   drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
> index b5805969404f..b87336b2e4b9 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
> @@ -617,7 +617,14 @@ static irqreturn_t octep_rsvd_intr_handler_cn93_pf(void *dev)
>   static irqreturn_t octep_ioq_intr_handler_cn93_pf(void *data)
>   {
>   	struct octep_ioq_vector *vector = (struct octep_ioq_vector *)data;
> -	struct octep_oq *oq = vector->oq;
> +	struct octep_oq *oq;
> +
> +	if (!vector)
> +		return IRQ_HANDLED;

Sorry for not flagging in previous review, but the question is again the
same - how that can happen? This function is irq handler, which is
called from octep_ioq_intr_handler() only if ioq_vector was properly
resolved. This check makes no sense here.

> +	oq = vector->oq;
> +
> +	if (!oq || !(oq->napi))
> +		return IRQ_HANDLED;
>   
>   	napi_schedule_irqoff(oq->napi);
>   	return IRQ_HANDLED;


