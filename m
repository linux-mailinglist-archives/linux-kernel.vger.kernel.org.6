Return-Path: <linux-kernel+bounces-317344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B908E96DCC8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4F31C2294B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1623719B595;
	Thu,  5 Sep 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hhob49zz"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EDD6E614
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548163; cv=none; b=oXPxSIWEZ0iL71r5S/+83Ec8RNK24AXCJKtgNL1iGWRdiqlyTmSZltFd4MgUHMy2YrAtBfq68p371ebNToSyH72ozRDHQ1JTP4yKBAH0TCbB7X7UuDQyK9isHImYzezwB2JEWEYENZEM+M/pnaxSKPZ2/qbvUnvlRKZQn4ws0uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548163; c=relaxed/simple;
	bh=AxoN+6Yjx4OU8PweIJUOo/4XQeC3HbfL4mu1VnP0/4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVa6bykuuD0Znz/tCX9X+dQqgdKdUlsGNwq1+3S5y6ZDUQ6uOzwir/FK0Cu/kZpzsdG6kHUQVHmYTZgPrl+fdHSwpKTNw4Hh/ZBRUTCa69nZ8YGcZVQKj0se59aB25G9SFpSLr99Tts78w3k6z4k0ocIS9bV5XPzHE+SSZTOqyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hhob49zz; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4e0963f5-5c27-4d65-92d2-86249f4f0870@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725548158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pIBl7Qh1UXcXHt8Gzul7Xxl23nlEokYvIvZaJ72IVg=;
	b=hhob49zzw49K62qwriP9JhyJhciRMNT+BY9EJ7L7v3H1SBgtetSi+5Eh9FJXO+a3ySzM3G
	625NuLNtfbvyRYUuA20wv5Y6Vcx3TW+U1fNwzXKJZhJ/a7/h13Bnb8RVuR/HC7y3QxyUKo
	fHhMeIiBBFyporQd9Dp9/Vfb9iKPz4c=
Date: Thu, 5 Sep 2024 10:55:49 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: xilinx: axienet: Fix IRQ coalescing packet count
 overflow
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Ariane Keller <ariane.keller@tik.ee.ethz.ch>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andy Chiu <andy.chiu@sifive.com>
References: <20240903180059.4134461-1-sean.anderson@linux.dev>
 <MN0PR12MB595374F39CB6F68958004A9DB79C2@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <MN0PR12MB595374F39CB6F68958004A9DB79C2@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/4/24 13:19, Pandey, Radhey Shyam wrote:
>> -----Original Message-----
>> From: Sean Anderson <sean.anderson@linux.dev>
>> Sent: Tuesday, September 3, 2024 11:31 PM
>> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; David S .
>> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
>> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
>> netdev@vger.kernel.org
>> Cc: Simek, Michal <michal.simek@amd.com>; linux-arm-
>> kernel@lists.infradead.org; Ariane Keller <ariane.keller@tik.ee.ethz.ch>;
>> linux-kernel@vger.kernel.org; Daniel Borkmann <daniel@iogearbox.net>;
>> Andy Chiu <andy.chiu@sifive.com>; Sean Anderson
>> <sean.anderson@linux.dev>
>> Subject: [PATCH net] net: xilinx: axienet: Fix IRQ coalescing packet count
>> overflow
>> 
>> If coalesce_count is greater than 255 it will not fit in the register and
>> will overflow. Clamp it to 255 for more-predictable results.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet
>> driver")
>> ---
>> 
>>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> index 9aeb7b9f3ae4..5f27fc1c4375 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> @@ -252,7 +252,8 @@ static u32 axienet_usec_to_timer(struct axienet_local
>> *lp, u32 coalesce_usec)
>>  static void axienet_dma_start(struct axienet_local *lp)
>>  {
>>  	/* Start updating the Rx channel control register */
>> -	lp->rx_dma_cr = (lp->coalesce_count_rx <<
>> XAXIDMA_COALESCE_SHIFT) |
>> +	lp->rx_dma_cr = (min(lp->coalesce_count_rx, 255) <<
>> +			 XAXIDMA_COALESCE_SHIFT) |
>>  			XAXIDMA_IRQ_IOC_MASK |
> 
> Instead of every time clamping coalesce_count_rx on read I think better 
> to do it place where it set in axienet_ethtools_set_coalesce()? It would
> also represent the coalesce count state that is reported by get_coalesce()
> and same is being used in programming.

The parameter which will be trickier is the timer, which is also clamped
but depends on the (DMA) clock speed. So theoretically it may be
different if the clock gets changed at runtime between when we set
coalesce and when we apply it. But do we even support dynamic rate
changes for that clock?

In either case, I think this will be easier to do as part of [1], since I
am already rearranging the calculation in that patch.

--Sean

[1] https://lore.kernel.org/netdev/20240903192524.4158713-2-sean.anderson@linux.dev/

>> XAXIDMA_IRQ_ERROR_MASK;
>>  	/* Only set interrupt delay timer if not generating an interrupt on
>>  	 * the first RX packet. Otherwise leave at 0 to disable delay interrupt.
>> @@ -264,7 +265,8 @@ static void axienet_dma_start(struct axienet_local
>> *lp)
>>  	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
>> 
>>  	/* Start updating the Tx channel control register */
>> -	lp->tx_dma_cr = (lp->coalesce_count_tx <<
>> XAXIDMA_COALESCE_SHIFT) |
>> +	lp->tx_dma_cr = (min(lp->coalesce_count_tx, 255) <<
>> +			 XAXIDMA_COALESCE_SHIFT) |
>>  			XAXIDMA_IRQ_IOC_MASK |
>> XAXIDMA_IRQ_ERROR_MASK;
>>  	/* Only set interrupt delay timer if not generating an interrupt on
>>  	 * the first TX packet. Otherwise leave at 0 to disable delay interrupt.
>> --
>> 2.35.1.1320.gc452695387.dirty
> 

