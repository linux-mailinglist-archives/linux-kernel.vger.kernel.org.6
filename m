Return-Path: <linux-kernel+bounces-431436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3969E3D56
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF80D2810A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F72C20ADDD;
	Wed,  4 Dec 2024 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Az9YpqvA"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7A820A5E7
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323977; cv=none; b=IAm35VEJbVhcWqmdXGIZ9rnQz7LRcilAMMCSup+TV2qSj48wmgq7ydSzB4aAH1fn8y6HNfNUW97JiihlpvbPpcQysgcQkSzvHd57dfoAqrsupZ32bdRa0Ob4pjmoxWo5oNY25au7XB3Tc4I3Y4jP52LgY+jxLWtyAj+B9igvDuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323977; c=relaxed/simple;
	bh=3LiKv+eNX93oUQLQwuzkd/zma0J++yy3VUyud3rib0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=REObDwDxSGRWnaIRj7VtyA63jZOd/ozasEct3qSb1zP99+Xg6ZL6sc1bIwx4islcFd7RUQUsd3GmMmkahJzUzNnwwk57PAG5A0TCiemKTQMhcPEfOYaUh5BvzuAGmnWZJ0vVOG86tT9DY48FFpAgpCcU2iLGD86x/hy2D8n+JfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Az9YpqvA; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B4EqnT1007250;
	Wed, 4 Dec 2024 08:52:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733323969;
	bh=7mm3A9mPvX81tl0Z0rM/8vD/v6yQ+H+FZCZOiBE3+RU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Az9YpqvAnvGLsRuTMAwVIeLbcvCyfNKwsV5RGsVxELPKFzcYSI5KWH+SUBJ2fSTuj
	 I8e6y1A6tVyqapMjHJEB+5XZy/BlHyK1uUDLtzv9HVi8sgE8WrIx7PrWyIB4bNWA29
	 XozZ+8NsTZzf9qbw8zQctB19JPMPwX5n//ZMvxho=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B4EqnWQ068057;
	Wed, 4 Dec 2024 08:52:49 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Dec 2024 08:52:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Dec 2024 08:52:48 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B4EqmsW074167;
	Wed, 4 Dec 2024 08:52:48 -0600
Message-ID: <5d0a298f-559a-466b-b13a-7c6520406bb6@ti.com>
Date: Wed, 4 Dec 2024 08:52:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mux: mmio: Add suspend and resume support
To: Thomas Richard <thomas.richard@bootlin.com>, Peter Rosin <peda@axentia.se>
CC: <linux-kernel@vger.kernel.org>, <gregory.clement@bootlin.com>,
        <theo.lebrun@bootlin.com>, <thomas.petazzoni@bootlin.com>,
        <u-kumar1@ti.com>
References: <20240613-mux-mmio-resume-support-v2-1-e8496099b034@bootlin.com>
 <d7e9d9f8-ac81-4cbb-897c-585741ca00c9@ti.com>
 <30397c99-936e-4abb-b214-fca6ce95c2bb@bootlin.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <30397c99-936e-4abb-b214-fca6ce95c2bb@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 12/4/24 8:14 AM, Thomas Richard wrote:
> On 12/4/24 14:53, Andrew Davis wrote:
>> On 9/11/24 3:53 AM, Thomas Richard wrote:
>>> The status of each mux is read during suspend and stored in the private
>>> memory of the mux_chip.
>>> Then the state is restored during the resume.
>>>
>>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>>> ---
>>> In this second version, as discussed with Peter, everything is done in
>>> the
>>> mmio-mux driver.
>>> A mux_mmio_set() function was added, and used during suspend stage to get
>>> the status of the of the muxes.
>>> This status is stored in the private memory of the mux_chip.
>>> ---
>>> Changes in v2:
>>> - Remove all modifications done in the mux subsystem
>>> - Add a mux_mmio_set()
>>> - Read the status of muxes during suspend and store in the private memory
>>>     of the mux_chip.
>>
>> Do you need this private memory? Since this is already using regmap, why
>> not use the regmap cache, then you can restore all the values on resume
>> with a simple call to regcache_sync().
> The regmap can be set without cache.
> As you inherit the regmap, you cannot assume that the cache is enabled.
> 

Fair point, we don't really know much about the underlying registers.
One thing we don't know is if they are retained during suspend, so
saving and restoring might be unneeded in some cases. Maybe that isn't
something we can solve at this point, could be something that should
be done in the regmap framework instead..

For now, the rest of this patch seems good to me,

Reviewed-by: Andrew Davis <afd@ti.com>

