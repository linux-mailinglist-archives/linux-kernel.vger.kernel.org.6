Return-Path: <linux-kernel+bounces-524526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11835A3E421
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 838947A6225
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A6C24BCFA;
	Thu, 20 Feb 2025 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XlvXJw9z"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F061224BCFB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076956; cv=none; b=IAuaYEzZ7hUmvpnOoxw//rT+euPhCW8Cfmd0EQ6JOuItHW3g04T3ARVS37u0FOGAjo+SJ8AZUJH3ktbP4wRF8reghsPAQTZpTPPyLwrPCYE9aaELXPgrHwyOb/q1XYwV/+bhpztJnQZXZtweuvVj86/mBXoD24YGqc/XBOxfFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076956; c=relaxed/simple;
	bh=fcu6YN7bbsrKHVm/xLNXz/ZhQ6TV6qlqWZuPfAueep4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nopfmo5BuZr2MFqQpSMLP9rjJSTtIeg5jOhBpohCZOeZ0OJnt+znOQ7lmwc8Q5o40xliy5YQFHYOTAsR2kkUTMMlSQ38U0WyadrBub8fSRw8SNWmMJ6njdG46fAc71zINgx/nToshG6IAe8M5Hf8/mQKVjdTzQuye8A9//0eBjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XlvXJw9z; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f3de1e79-9732-451c-a973-e94e27703a65@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740076952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFI3sZtS19TZcUN2UuyJdB3DsPElU8NTdbS7gCIcLnw=;
	b=XlvXJw9z7FbYfQL5h1eadTWe+1VXyRglI5NEGDsWkK98Tm2TGQ8pTQmAjBLG12WF6Am947
	4znteRRgnrOsfzlDsq4a0Y2HzkNC3YnLHKU9Kkn3R8hp/9ksi9tEmFE46YKpyBh/OiIPON
	dWkA/7hKWEa10VpIjafgS6l2H5FD/N4=
Date: Thu, 20 Feb 2025 13:42:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/2] net: cadence: macb: Modernize statistics
 reporting
To: Jakub Kicinski <kuba@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
References: <20250214212703.2618652-1-sean.anderson@linux.dev>
 <173993104298.103969.17353080742885832903.git-patchwork-notify@kernel.org>
 <12896f89-e99c-4bbc-94c1-fac89883bd92@linux.dev>
 <20250220085945.14961e28@kernel.org>
 <561bc925-d9ad-4fe3-8a4e-18489261e531@linux.dev>
 <20250220101823.20516a77@kernel.org>
 <1510cd3c-b986-4da2-aaa3-0214e4f43fe6@linux.dev>
 <20250220103223.5f2c0c58@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250220103223.5f2c0c58@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/20/25 13:32, Jakub Kicinski wrote:
> On Thu, 20 Feb 2025 13:22:29 -0500 Sean Anderson wrote:
>> > If no - will the code in net still work (just lacking lock protection)?
>> > 
>> > If there is a conflict you can share a resolution with me and I'll slap
>> > it on as part of the merge.  
>> 
>> OK, what's the best way to create that? git rerere?
> 
> rerere image or a three way diff will work

--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3098,16 +3098,9 @@
 {
 	struct gem_stats *hwstat = &bp->hw_stats.gem;
 
-<<<<<<<
-	if (!netif_running(bp->dev))
-		return nstat;
-
 	spin_lock_irq(&bp->stats_lock);
-	gem_update_stats(bp);
-=======
 	if (netif_running(bp->dev))
 		gem_update_stats(bp);
->>>>>>>
 
 	nstat->rx_errors = (hwstat->rx_frame_check_sequence_errors +
 			    hwstat->rx_alignment_errors +
@@ -3136,12 +3129,7 @@
 	nstat->tx_aborted_errors = hwstat->tx_excessive_collisions;
 	nstat->tx_carrier_errors = hwstat->tx_carrier_sense_errors;
 	nstat->tx_fifo_errors = hwstat->tx_underrun;
-<<<<<<<
-=======
 	spin_unlock_irq(&bp->stats_lock);
-
-	return nstat;
->>>>>>>
 }
 
 static void gem_get_ethtool_stats(struct net_device *dev,
@@ -3240,11 +3228,8 @@
 	nstat->tx_carrier_errors = hwstat->tx_carrier_errors;
 	nstat->tx_fifo_errors = hwstat->tx_underruns;
 	/* Don't know about heartbeat or window errors... */
-<<<<<<<
 	spin_unlock_irq(&bp->stats_lock);
-=======
 }
->>>>>>>
 
 static void macb_get_pause_stats(struct net_device *dev,
 				 struct ethtool_pause_stats *pause_stats)


