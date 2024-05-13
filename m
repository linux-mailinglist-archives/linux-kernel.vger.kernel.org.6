Return-Path: <linux-kernel+bounces-177218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEAF8C3B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1401C20F69
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3882145B1D;
	Mon, 13 May 2024 06:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B+7jWjRB"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B150291
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715582602; cv=none; b=pxGn7k0rQmAl5eNXtR4d3tFPu7z59HV4qDefpHnMW/rZ90hUaxxrF/zHi5+p6+DZl03EyoJUog8bdntUEBUgxrfcMuOKXfcqLeEDGME2L019ysesPag8yCtvMYaQ/UWu6wGfzvvhcGQlwiHWB6IvU3pd00jYUd6YWwN1/q/ygQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715582602; c=relaxed/simple;
	bh=uMSLU95WSD2m9hke8Y9SIwl8RyuAbtHcqjiL6WGb7DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bap6c79bc3qTGYNXuk8zkln7ncTaqtwPERGU5gb0XIXSXl/Y7fVyRi1zaVjkP/yNopKiMV7feZjVkuPwUPavsVdpJXJ6LPqErl+t5G2dWh73iOpILu+COgEtKINDQp2bMcpCzsBKUOBULCd3rUZK17ejyTJ1AB/5tII3HAQzYgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B+7jWjRB; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <faf43075-a738-41b6-975c-f8c007929050@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715582592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9wX8NMO96pXgObmwZJgkX492lcaLyuWMCeWzF3eqfpI=;
	b=B+7jWjRB1V3KA/PHj0c1iZZGcssVmdjbTmTzUuAyDwRW4hCQxRQTAxyy1sEKKQypjg4iL0
	ear4ggZR7foRmFNSok6/FxvgKKgkGnrYMNSo6h3jBzymrExxEVt7qbiBqvofMqnZ7Dltok
	nqvqIOT+HkAEOGtGOgv1dVdShOy4Bbg=
Date: Mon, 13 May 2024 14:43:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/bridge: imx: Remove redundant checks on existence of
 bridge->encoder
To: Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 Maxime Ripard <mripard@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240511150816.326846-1-sui.jingfeng@linux.dev>
 <c1a69a18-4db2-4625-80c2-a7536347e15f@nxp.com>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <c1a69a18-4db2-4625-80c2-a7536347e15f@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 5/13/24 13:56, Liu Ying wrote:
> On 5/11/24 23:08, Sui Jingfeng wrote:
>> The check on the existence of bridge->encoder on the implementation layer
>> of drm bridge driver is not necessary, as it has already been done in the
>> drm_bridge_attach() function. It is guaranteed that the .encoder member
>> of the drm_bridge instance is not NULL when various imx_xxx_bridge_attach()
>> function gets called.
> 
> Nit:
> ldb_bridge_attach_helper() doesn't follow the fashion of
> imx_xxx_bridge_attach(), not even the other bridge attach
> functions touched by this patch do. 


Right, my bad.

But personally, I think rename it as ldb_bridge_attach() should
enough to express the meaning. :-)


  Maybe, reword as
> "when various i.MX specific bridge attach functions are
> called."
> 

OK, fine.

I will correct the commit message at the next version,
so happy being reviewed. Thanks.


> Regards,
> Liu Ying
>

