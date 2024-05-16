Return-Path: <linux-kernel+bounces-180970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ECE8C759A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A0FB21D32
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40492145B3F;
	Thu, 16 May 2024 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jz9KZL3J"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA04145A08
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861111; cv=none; b=oNeY25Ovwh2jjNmqYNuxs089Kh8yzAvvWi6ZBQNVFla0mV57bQ0FPbYgOOYvWE9rAifWGaPfT1BQ4ngijJ37BEXgS/mQUxhavcnX3McAy8Z9iUpttO6SlDeTHRe4luy5Lf4KgKEcrbABClX03ZirBw8NciwCGEbSm9t8AxU1qWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861111; c=relaxed/simple;
	bh=pzrxh7gKPVBVV/i+pPG2uaPgcX02ABdgwtW+e4BAV4o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OGFDGoWFzpXySPlb8ePlt/5TkZLncDUuj6GYIXuUIphVnQ9tzEkPXdUuFFoUqwO00NaoON/0GoY7c501LRUqJ3DbYGZd/uPEf5p2VqJsKmwEj8/clH+3w5u3phnTWvvm5H3k+R+NuopnGncQ6tMTOe7jQX50/jOGej7CGB1xuFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jz9KZL3J; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mripard@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715861107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nP/VHvPc3dOf0DXV1qkgdupWxw+oXTk4mGe1+/VX3u8=;
	b=Jz9KZL3JoC1wxLxUDF0DniOrSN6Oa9QtCy8RPs5S5soJpsPCmqRdDOvVw0gPZyU3tmxlJX
	9RzPCDxidH1qUL6VBA23b6Pyc64uAZzyvAiookDGWlxz/O/kUoNr/D9lVLbaB6+nysBb7U
	NMA0E9gKcB/+hvfVff+X+Vt9LMktlKk=
X-Envelope-To: neil.armstrong@linaro.org
X-Envelope-To: dmitry.baryshkov@linaro.org
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-kernel@vger.kernel.org
Message-ID: <07b931d9-b11f-4829-a6c4-d5025fc071b5@linux.dev>
Date: Thu, 16 May 2024 20:04:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] drm/bridge: Add 'struct device *' field to the
 drm_bridge structure
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240514154045.309925-1-sui.jingfeng@linux.dev>
 <20240514-scarlet-corgi-of-efficiency-faf2bb@penduick>
 <c44480ab-8d6b-4334-8eba-83db9b30ff1a@linux.dev>
 <20240515-fair-satisfied-myna-480dea@penduick>
 <d394ee32-4fa4-41a8-a5ca-c1c7f77f44d2@linux.dev>
 <20240515-copper-chimpanzee-of-fortitude-ff3dab@penduick>
 <2c15c859-6b2b-4979-8317-698bf6cc430c@linux.dev>
 <20240516-intrepid-uptight-tench-0df95e@penduick>
 <e955b706-04dd-479f-8327-32771d94f70f@linux.dev>
Content-Language: en-US, en-AU
In-Reply-To: <e955b706-04dd-479f-8327-32771d94f70f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/16/24 18:40, Sui Jingfeng wrote:
> use 'to_i2c_client(bridge->dev)' to retrieve the pointer

to_i2c_client(bridge->kdev).

Besides, this also means that we don't need to add the fwnode
pointer into struct drm_bridge as member. Relief the conflicts
with other reviewers if the work of switching to fwnode is still
needed. As for majorities cases (1 to 1), of_node and fwnode can
be retrieved with 'struct device *' easily. The aux-bridge.c and
aux-hdp-bridge.c can also be converted too easily.

of_node, fwnode, swnode and device properties are all belong to
the backing device structure itself. It can be more natural to use 
device_proterty_read_xxx() APIs after init time, Which in turn
avoid the need to acquire and duplicate all properties another
time in the driver private structure.

We could do the programming around the 'struct device *.', remove
a batch of boilerplate.

