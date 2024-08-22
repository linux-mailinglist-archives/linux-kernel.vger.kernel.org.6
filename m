Return-Path: <linux-kernel+bounces-297442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C4495B857
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19863B28688
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CE71CC896;
	Thu, 22 Aug 2024 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u5CE2yN5"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09A91CC17B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336717; cv=none; b=NHcdc9dXvfmHXlnLKAPa77aRlWMahZqqcx9ctCOTneqat1DrzJAjd+cG6PJT7FmURE4QWlQN86CllW7th3HCT+fqZVIPMzHfUzzaFkk7nTiKhc/I7UgX+l+ceRo/cnzMk5KOxxvsw46L+3C15zYPbqFNaqPcPD8+rmNHe88XsfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336717; c=relaxed/simple;
	bh=XIwJYyLZAEQvZs1LqqSkaLJPuX6sDMS09+9teyUe6NA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lrF9/GOwduTTIYNurPomfP8VKLHvCuUbZrMdx1dno9pbiDgxk0+PgCgZ2BgtKCoBvlV+AHALCclJZwUX65qSXaUQEF66Botoxobmq7cEN4zfKLWaLAZGbkAhVnU9BC99Md+voaoXOjblWEypdGv18ihxytBEwyILc/1QHsmtsn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u5CE2yN5; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aeb2b005-8205-4060-8f72-e7b2f0c1d744@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724336712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LpB+Ifhf2bxD9pHYqJFvxBYsnuv1V6nOurdtT7+oTQk=;
	b=u5CE2yN5E9OXLRBlQQ4eFSBK6QbUyfhFgyfsW5bVqYwmne4C5BrrRnm2DTU9zQKHREIdOP
	N/XF7xb22UaoSpFvuW19xGr91vCxbp3b3HDVEpnBsQAtrXlMFh9dBZSPLeGYMTF6pT+pJn
	D50GGmDvvutI3ABzqwsqKnZHz08NS8k=
Date: Thu, 22 Aug 2024 10:25:06 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/5] net: xilinx: axienet: Always disable
 promiscuous mode
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
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
 <7e6caa8b-ae79-4eb0-8ccb-d57471e8a3d5@linux.dev>
Content-Language: en-US
In-Reply-To: <7e6caa8b-ae79-4eb0-8ccb-d57471e8a3d5@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/20/24 10:24, Sean Anderson wrote:
> On 8/19/24 21:30, Jakub Kicinski wrote:
>> On Thu, 15 Aug 2024 15:36:10 -0400 Sean Anderson wrote:
>>> If promiscuous mode is disabled when there are fewer than four multicast
>>> addresses, then it will to be reflected in the hardware. Fix this by
>> 
>> it will *not* be reflected?
>> Something is off with this commit messages, or at least I can't parse
>> 
>>> always clearing the promiscuous mode flag even when we program multicast
>>> addresses.
>>> 
>>> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
>> 
>> I think we should ship it as a fix to net?
> 
> Yes, probably. I put these patches first so they could be easily cherry-picked.

OK, so to be clear: how should I send these patches?

--Sean


