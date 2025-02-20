Return-Path: <linux-kernel+bounces-524315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9764A3E1D5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9313B2847
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48492135D0;
	Thu, 20 Feb 2025 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pb9PmXpW"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872E1C1F02
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070728; cv=none; b=D+PZZqMezu19VCtqx1yPV0Tw0ngFUQ+kvS7RBAZz8Xq5DyZfT/RgY8UqFxzQDSNkdMaKkCjUeSF/DX9ODYhd1MjFg/2+BGkg4GUhMWcPBIBBcsbgwcIP8Y2w+ucOJyGoxVQ674jWmEw9AuUvgD5tvuL+DW6guZXa+LUuqKhnTok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070728; c=relaxed/simple;
	bh=Q+Jb7AfoCiGdFXi62io4F0vSXl1qRocAJVycKuaL/D0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sMzOwAtIIoBATyQD1R+e2H9aPdW/yVBrXnqbFXt4+l9EVU6uVDlXBlfJDg7yiFhTDYa8VC2c3tcR5NAjIhMNWKba++AAS60vXqlM/UTFLYWL4WvlgJ+yZ8nykILEUxxgJRIAzMcfHMcG4x+4tlVZSzm9fswAjUqixvVMrXzDhtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pb9PmXpW; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3a6e95ea-cdb0-4239-bb47-b29df45f52cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740070714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSAZDU3AQ1VuBM+5kuWntriYIhfJE92ii0LczQ8TURY=;
	b=Pb9PmXpWIMKQJkmpnNqDfCGZgWDI5wwWnFau35gLZoTY+H8QCNvPYANLWGC+16l6mTPgFi
	orT1GIthN1+y33Gzcvs4n5kP7IVnIbKjiZ8FmvnzWUm2hlW9eOmfFIq+GnIF0SHefEN/o8
	5VPUYY5vg56awFcSldq+DXTogIDfAig=
Date: Thu, 20 Feb 2025 11:58:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: xilinx: axienet: Implement BQL
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: "Gupta, Suraj" <Suraj.Gupta2@amd.com>,
 "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
References: <20250214211252.2615573-1-sean.anderson@linux.dev>
 <BL3PR12MB6571A18DA9E284A301FF70FAC9F92@BL3PR12MB6571.namprd12.prod.outlook.com>
 <aa58373c-a4ac-4994-821b-40574e19be3d@linux.dev>
Content-Language: en-US
In-Reply-To: <aa58373c-a4ac-4994-821b-40574e19be3d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/18/25 11:00, Sean Anderson wrote:
> On 2/15/25 06:32, Gupta, Suraj wrote:
>> 
>> 
>>> -----Original Message-----
>>> From: Sean Anderson <sean.anderson@linux.dev>
>>> Sent: Saturday, February 15, 2025 2:43 AM
>>> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>;
>>> netdev@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org; Paolo Abeni <pabeni@redhat.com>; David S .
>>> Miller <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Simek, Michal
>>> <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org; Eric Dumazet
>>> <edumazet@google.com>; Andrew Lunn <andrew+netdev@lunn.ch>; Sean
>>> Anderson <sean.anderson@linux.dev>
>>> Subject: [PATCH net-next] net: xilinx: axienet: Implement BQL
>>> 
>>> Caution: This message originated from an External Source. Use proper caution
>>> when opening attachments, clicking links, or responding.
>>> 
>>> 
>>> Implement byte queue limits to allow queueing disciplines to account for packets
>>> enqueued in the ring buffers but not yet transmitted.
>>> 
>> 
>> Could you please check if BQL can be implemented for DMAengine flow?
> 
> I can have a look, but TBH I do not test the dma engine configuration since it is
> so much slower.

I had a look, and BQL is already implemented for dmaengine.

--Sean

