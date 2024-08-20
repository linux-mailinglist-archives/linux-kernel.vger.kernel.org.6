Return-Path: <linux-kernel+bounces-294104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD40E958930
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53161C213D7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF311917CB;
	Tue, 20 Aug 2024 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JQyh+5//"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555BB4D8C1
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163859; cv=none; b=FKWGUPfqOuNwdFc4VkR5T5Foa1X+x7uAshM7+PIJS4HgjWhZxYms6WjUy/cj8ECsnh1IDcxvNWR6eA7n7w0QaMGmruWkbpGnu7h7omzIVfb3Z4OCceR6BxitspYMWFmWhpQdjiMC/A0xMY3TzqAff8qHv2oGH9pTXHu8kRdNqBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163859; c=relaxed/simple;
	bh=QCZ+RO1FUCsa+gJOU+RlcW8Xr/lVI2nNH4g8BamXv9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b76R5GqGfrxIoykWA+ixngylmvkBo/wgqYZYiEsjcnUbiRSUS+q6rxjEA77FXg9JYW8NFQUJ9CtCsPoYnAyoUEkeKi0/K2Zd6TXKIEmV6caBY76mT9syXlVZ4/zLQl6SHMU1/eWvevSRt8tl+4dn/jECaRkGHavB5fIlIVvxUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JQyh+5//; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7e6caa8b-ae79-4eb0-8ccb-d57471e8a3d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724163855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oIijWWzfx2wkvf+z8Rr+7gk9fjf1EjLJm1Yyu7y8HBk=;
	b=JQyh+5//XtwDM6g1Mmzckx2y0JJ0joJEPy2uXUHOrLq0UISdfFTTlhBHjg/5kCPiAtbF6k
	VTdO8EFbZ+HDZWLuO6zGQ1pcuM4qlm1VF0keJjjZyJ3Md5QQ3j1uO99BYRyG1oqRSdYrjX
	FDFan5rO8bIgUqlPAk866IuFb3Bp+sU=
Date: Tue, 20 Aug 2024 10:24:11 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/5] net: xilinx: axienet: Always disable
 promiscuous mode
To: Jakub Kicinski <kuba@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org,
 Michal Simek <michal.simek@amd.com>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
References: <20240815193614.4120810-1-sean.anderson@linux.dev>
 <20240815193614.4120810-2-sean.anderson@linux.dev>
 <20240819183041.2b985755@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240819183041.2b985755@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/19/24 21:30, Jakub Kicinski wrote:
> On Thu, 15 Aug 2024 15:36:10 -0400 Sean Anderson wrote:
>> If promiscuous mode is disabled when there are fewer than four multicast
>> addresses, then it will to be reflected in the hardware. Fix this by
> 
> it will *not* be reflected?
> Something is off with this commit messages, or at least I can't parse
> 
>> always clearing the promiscuous mode flag even when we program multicast
>> addresses.
>> 
>> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> 
> I think we should ship it as a fix to net?

Yes, probably. I put these patches first so they could be easily cherry-picked.

--Sean

