Return-Path: <linux-kernel+bounces-317271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4F996DBBE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E951C20BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5802F870;
	Thu,  5 Sep 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RUUKKGQn"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B141DDF5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546430; cv=none; b=GkbpflR2DapGWEqiT5x40H4+YpOjICs11oDqY9MT8SdVWtj6yHy5uDJFyWp4oG+7pfXmp8jwAodf8hvP9iImhnoKmfVq12jWsJnZf+UqJRg+8tGHh5qrvAlIDVv6OYEeH3amJvwb+Wucs9+LfaEkFfgGmqUB8XLt2Onjmj5iTRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546430; c=relaxed/simple;
	bh=3k+74O6+/02mugm3J4gvCVu7ZvKYOuy9N/M3e+OyQvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rW4Q6B7phEO0nHY4ujlOniulNzfv/HXPxWhNOQR4IQBFfMiokLkclSFaPXsNbeKHWkKq4AApdBWDFFY5hzcDhbFupu1pTjl5ROra/cJ4hWI07AGz+8ZUxTaI14+xN4HgmuEbh5ItiMbWzRnWeKPnPYN8Uqd9/W1oJEWGjx6T4kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RUUKKGQn; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d2470924-78a2-4905-a24f-afb127644d70@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725546427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FsQk6z3HEBxGfR6MpE4YothAxzaD5ug0Mh6OH+yVUjs=;
	b=RUUKKGQnv8uB849iNLPKm92xmx+iHZQGUdonlJPhlHsrZGhB88iEGJxyTUgD4ep038lnYY
	GpCnrHfPYjGvgA3LyGULP0yZHo7emvAjajdrgD7emlR8G9RorkEE+XgXcIiEa5vLwRQ+fd
	z8ml8I3DYTkosQCLArX5FmQmft9p4oQ=
Date: Thu, 5 Sep 2024 10:27:00 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/2] net: xilinx: axienet: Enable adaptive IRQ
 coalescing with DIM
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Michal Simek <michal.simek@amd.com>, Heng Qi <hengqi@linux.alibaba.com>
References: <20240903192524.4158713-1-sean.anderson@linux.dev>
 <20240904163503.GA1722938@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240904163503.GA1722938@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/4/24 12:35, Simon Horman wrote:
> On Tue, Sep 03, 2024 at 03:25:22PM -0400, Sean Anderson wrote:
>> To improve performance without sacrificing latency under low load,
>> enable DIM. While I appreciate not having to write the library myself, I
>> do think there are many unusual aspects to DIM, as detailed in the last
>> patch.
>> 
>> This series depends on [1].
>> 
>> [1] https://lore.kernel.org/netdev/20240903180059.4134461-1-sean.anderson@linux.dev/
> 
> Hi Sean,
> 
> Unfortunately the CI doesn't understand dependencies,
> and so it is unable to apply this patchset :(
> 
> I would suggest bundling patches for the same driver for net-next
> in a single patchset. And in any case, only having one active
> at any given time.
> 

Well, I would normally do so, but that patch is a fix and this series is
an improvement. So that one goes into net and this one goes into net-next.

I've been advised in the past to split up independent patches so they can be
reviewed/applied individually.

--Sean

