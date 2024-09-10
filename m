Return-Path: <linux-kernel+bounces-323238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E8B9739E2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78C2289EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9BC195FF0;
	Tue, 10 Sep 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jNoQDvtA"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD978C8D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978644; cv=none; b=kAj5wLIXrf6JVpF5V/92l6RSjSzUYu3PWX4u7Oe9U/I9DgGfUWRQhCwNZN6bc02UUxzjadMzEK+rE2yi4Qf/cPP8qy3VmKOHvf30X+6j0ohXPBsrorrOQETTyKfQywuNIXFtd7GN66oLFAEn9IjgkDqdM/UyEpSt7xKZtKJEeB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978644; c=relaxed/simple;
	bh=e9ExoWwqjNSPX1h/uO5L1h9vgCw4rHs96wE7S2Hv8nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxcuH9NU6i369Sw9yp5PFmnXj9SpK3J/oj4dphMSGMD0uvgTCgCg3jD3+JgsZ8LMAb8dCjlkKGF0wHBmMI11KySdKuTxLnQo3ZwqgTBU+pOGJ1MO6JOPycnB5KQCxAXuYhFZJqa1/7tsCCpzP2HbMWkocMNx9ADEascLjE1hhoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jNoQDvtA; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7bd2dbef-643a-4258-af1c-b68bff980b22@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725978639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNAcMMQvErS3/HJiJVrNMz8DQTCwPMR3vMspJu0zDsA=;
	b=jNoQDvtAANjmAIDum+RAkv0SB54IPDOkc/nJ8hwH4eK8dPbhC/pwpb4WBVwHriCkdv3mSe
	nhkQ4SI/ehrgc21C/GOv8tnOc5jT1fswJpSEuQrqH57QDNXRjP/qV7CqTgxWJTjPb2j6lf
	czAFEsj3tjyQRzx5Fj/2ayGBWZShE94=
Date: Tue, 10 Sep 2024 10:30:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next v2 0/6] net: xilinx: axienet: Enable adaptive
 IRQ coalescing with DIM
To: "Nelson, Shannon" <shannon.nelson@amd.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Michal Simek
 <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 Heng Qi <hengqi@linux.alibaba.com>
References: <20240909235208.1331065-1-sean.anderson@linux.dev>
 <d56ff939-cbcb-4455-b589-3a87b0ec57a4@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <d56ff939-cbcb-4455-b589-3a87b0ec57a4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/9/24 21:34, Nelson, Shannon wrote:
> On 9/9/2024 4:52 PM, Sean Anderson wrote:
>>
>> To improve performance without sacrificing latency under low load,
>> enable DIM. While I appreciate not having to write the library myself, I
>> do think there are many unusual aspects to DIM, as detailed in the last
>> patch.
>>
>> This series depends on [1-2] and is therefore marked RFC. This series is
>> otherwise ready to merge.
>>
>> [1] https://lore.kernel.org/netdev/20240909230908.1319982-1-sean.anderson@linux.dev/
>> [2] https://lore.kernel.org/netdev/20240909231904.1322387-1-sean.anderson@linux.dev/
>>
>> Changes in v2:
>> - Add some symbolic constants for IRQ delay timer
>> - Report an error for bad coalesce settings
>> - Don't use spin_lock_irqsave when we know the context
>> - Split the CR calculation refactor from runtime coalesce settings
>>    adjustment support for easier review.
>> - Have axienet_update_coalesce_rx/tx take the cr value/mask instead of
>>    calculating it with axienet_calc_cr. This will make it easier to add
>>    partial updates in the next few commits.
>> - Get coalesce parameters from driver state
>> - Don't take the RTNL in axienet_rx_dim_work to avoid deadlock. Instead,
>>    calculate a partial cr update that axienet_update_coalesce_rx can
>>    perform under a spin lock.
>> - Use READ/WRITE_ONCE when accessing/modifying rx_irqs
>>
>> Sean Anderson (6):
>>    net: xilinx: axienet: Add some symbolic constants for IRQ delay timer
>>    net: xilinx: axienet: Report an error for bad coalesce settings
>>    net: xilinx: axienet: Combine CR calculation
>>    net: xilinx: axienet: Support adjusting coalesce settings while
>>      running
>>    net: xilinx: axienet: Get coalesce parameters from driver state
>>    net: xilinx: axienet: Enable adaptive IRQ coalescing with DIM
>>
>>   drivers/net/ethernet/xilinx/Kconfig           |   1 +
>>   drivers/net/ethernet/xilinx/xilinx_axienet.h  |  31 +-
>>   .../net/ethernet/xilinx/xilinx_axienet_main.c | 320 ++++++++++++++----
>>   3 files changed, 273 insertions(+), 79 deletions(-)
>>
>> -- 
>> 2.35.1.1320.gc452695387.dirty
>>
>>
> 
> Except for a couple of comment nits pointed out in 3/6 and 6/6, this set seems reasonable.
> 
> Reviewed by: Shannon Nelson <shannon.nelson@amd.com>
> 
> 

Thanks. I'll address these for v3.

--Sean

