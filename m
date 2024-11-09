Return-Path: <linux-kernel+bounces-403007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0DD9C2F7D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 21:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 688D4B21592
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 20:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C27319F47E;
	Sat,  9 Nov 2024 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HoZKz6HF"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1E4145B1D
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731184087; cv=none; b=I3ZqGwNXd9rHpd6eC4kq3spbaF3SAkbBw5nNF08S36PX4D7BHr/bPHyQkjYn7BoZw/4dvSy0O4oLVH1PUTl7XpJ0agPScpxZ6f9rxKG4ic/6RuY1WtCjOdXcHjYtGWxiB/rKANCxgGjRVUcsWB4/RQnQQ3pmPjFwwcizavyVZFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731184087; c=relaxed/simple;
	bh=JuY/InxFvEaJlzZv0ADg7GA0t4Yog0SfgSJVk3EL4Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHTmmKZ1MmIrPDLqNT6JfLfvdTHd5Zvm2nKxmD1F9cuAG+EkLRt2aZTPlCOJ8u84m55ZiYzit4uGx8+uLnOJVGYVLq/fUVKJ2jujEIGa36kEVQeyTgEbqC8X0QtMvpJpcMFuIdI5ZtEn9Vx8pMup1ip0md/fffRpK52Lrn7fw5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HoZKz6HF; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <10fdd0d6-cd63-40a4-b663-1f2755003e85@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731184080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3YIxXApI/LoeYhFt9yKG6aG9QyGiJN4zGj1NjNlv7o=;
	b=HoZKz6HF281F9XFhmk/RdOMz3Vo0UWG0xMqNTFpOPIuLkBBE92oYPjugb5NEmo/uKQ1drf
	NARowkikM/mp4BXHxjCoYNfzlva9gzKY6EHpvhC+adETz99TGAYfCFdKpnTakb2fKbpu7w
	aqANGrARG37ZjOqZy4yEMwwS1zSBS1s=
Date: Sat, 9 Nov 2024 20:27:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 1/7] enic: Create enic_wq/rq structures to
 bundle per wq/rq data
To: Nelson Escobar <neescoba@cisco.com>, John Daley <johndale@cisco.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Christian Benvenuti <benve@cisco.com>,
 Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
 <20241108-remove_vic_resource_limits-v3-1-3ba8123bcffc@cisco.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241108-remove_vic_resource_limits-v3-1-3ba8123bcffc@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/11/2024 21:47, Nelson Escobar wrote:
> Bundling the wq/rq specific data into dedicated enic_wq/rq structures
> cleans up the enic structure and simplifies future changes related to
> wq/rq.
> 
> Co-developed-by: John Daley <johndale@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>   drivers/net/ethernet/cisco/enic/enic.h         |  18 ++--
>   drivers/net/ethernet/cisco/enic/enic_ethtool.c |   4 +-
>   drivers/net/ethernet/cisco/enic/enic_main.c    | 120 ++++++++++++-------------
>   drivers/net/ethernet/cisco/enic/enic_res.c     |  12 +--
>   4 files changed, 81 insertions(+), 73 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
> index 0cc3644ee8554f52401a0be7f44a1475ab2ea2b9..e6edb43515b97feeb21a9b55a1eeaa9b9381183f 100644
> --- a/drivers/net/ethernet/cisco/enic/enic.h
> +++ b/drivers/net/ethernet/cisco/enic/enic.h
> @@ -162,6 +162,17 @@ struct enic_rq_stats {
>   	u64 desc_skip;			/* Rx pkt went into later buffer */
>   };
>   
> +struct enic_wq {
> +	struct vnic_wq vwq;
> +	struct enic_wq_stats stats;
> +	spinlock_t lock;		/* spinlock for wq */
> +};
> +

This change will make vnic_wq spinlock share the latest cache line of
queue statitics while protecting struct vnic_wq.

struct enic_wq {
         struct vnic_wq             vwq;                  /*     0   632 */

         /* XXX last struct has 4 bytes of padding, 1 hole */

         /* --- cacheline 9 boundary (576 bytes) was 56 bytes ago --- */
         struct enic_wq_stats       stats;                /*   632   120 */
         /* --- cacheline 11 boundary (704 bytes) was 48 bytes ago --- */
         spinlock_t                 lock;                 /*   752     4 */

         /* size: 760, cachelines: 12, members: 3 */
         /* padding: 4 */
         /* member types with holes: 1, total: 1 */
         /* paddings: 1, sum paddings: 4 */
         /* last cacheline: 56 bytes */
};


That is not good for performance. Simple re-arrange of the struct makes
lock and vnic_wq structure properly aligned:

struct enic_wq {
         spinlock_t                 lock;                 /*     0     4 */

         /* XXX 4 bytes hole, try to pack */

         struct vnic_wq             vwq;                  /*     8   632 */

         /* XXX last struct has 4 bytes of padding, 1 hole */

         /* --- cacheline 10 boundary (640 bytes) --- */
         struct enic_wq_stats       stats;                /*   640   120 */

         /* size: 760, cachelines: 12, members: 3 */
         /* sum members: 756, holes: 1, sum holes: 4 */
         /* member types with holes: 1, total: 1 */
         /* paddings: 1, sum paddings: 4 */
         /* last cacheline: 56 bytes */
};

Adding one u64 pad field to enic_wq_stats makes whole enic_wq properly
aligned to 12 cache lines on x86.

It might be worth adding ____cacheline_aligned to struct enic_wq to keep
the same performance expectations after converting to dynamic allocation
later in the patchset.

> +struct enic_rq {
> +	struct vnic_rq vrq;
> +	struct enic_rq_stats stats;
> +};
> +
>   /* Per-instance private data structure */
>   struct enic {
>   	struct net_device *netdev;

