Return-Path: <linux-kernel+bounces-267976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E04941EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4E71F23164
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8903518991A;
	Tue, 30 Jul 2024 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RMXU3LSl"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DB31A76AE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722361188; cv=none; b=H7uI3WuIRf7Q4AFOw4vEjy4aYIkXH/RY/Ykd0Jos6u0dap3a3NpbT1f2yixHkybxAPsvMBavu0VnWgYDnif/BJfGLAWKcKRO/+UUzQpRWFG2oG6v/Xjb/iI2mDOJPNwFjLljKlo7D10k/5cf63SfvPG80KUrGaHbC8NuQy0LeNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722361188; c=relaxed/simple;
	bh=O5JwXO9zLO9/wIZsyhUuFbNz6J5s2wr+PqubBwvfeSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TU5tTMmuVapzfZzSM1GG+3/tKvtPT+4CUQ1PTC1BkWlxqkkoicCSR1Vv+Wg/5P0Lh/meq03oTrpJ2Nzm92oBmiJI/lc5Xs8RvVFIteySsvz6pn52OxfzPhTOaloqbuSbRxuvAuhL8kf5IaIHlDv3Z/JTAebJEskuSJsLfFDjIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RMXU3LSl; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <11ba9284-db77-405d-80ad-7fbe5cb5c338@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722361183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RgfltJTn3UKSXJ9jbEJ+7l1SNMwFGrtqOjoLkm7DHjQ=;
	b=RMXU3LSlXhCVuLBpMs/lJsAWVQo3FQ89M1U7GCiKezlbra9znEG4ZagBzgCjiICgAtoRgi
	ZDdlNUZJvKZiFkC0V0OkLgKJTPlNv8Kughh2pxFq2jZwnCu6nO1mlwKtEGqutDUrDcNqAt
	nofWBIZlahP4VdNEoc6X2wtFuh5doII=
Date: Wed, 31 Jul 2024 01:39:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/2] drm/loongson: Introduce component framework
 support
To: Markus Elfring <Markus.Elfring@web.de>, dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <20240728152858.346211-1-sui.jingfeng@linux.dev>
 <20240728152858.346211-2-sui.jingfeng@linux.dev>
 <ce9b1d27-75a6-4505-b17c-773b51c173d0@web.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <ce9b1d27-75a6-4505-b17c-773b51c173d0@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/7/29 15:37, Markus Elfring wrote:
> …
>> +++ b/drivers/gpu/drm/loongson/loongson_drv.c
>> @@ -0,0 +1,298 @@
> …
>> +static int loongson_drm_driver_probe(struct platform_device *pdev)
>> +{
> …
>> +	dev_info(&pdev->dev, "probed\n");
> …
>> +}
> …
>
> Do you find such information really relevant?


This helps to see the probe order of all drivers,

this also help us to know the name of the fake master device.


> Regards,
> Markus

-- 
Best regards,
Sui


