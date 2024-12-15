Return-Path: <linux-kernel+bounces-444997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084769F0FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D531882FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0071B1E1C1A;
	Fri, 13 Dec 2024 14:53:20 +0000 (UTC)
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF711E1C09;
	Fri, 13 Dec 2024 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101599; cv=none; b=fyPJTFMxtoF8V5S3vCDtnpmiNFBcQVapRD9BKXaljl25VV9Ci2IeIz7lBrbT5A0/q8f2wsJJPiMOH1+ZxDxPL+MKv6WiHVrIKgXSSUALXGNp7gcAmighQ+geTiiY1D+RZOEq+ztvH1djXhSCGu72UXIEVNGYDpWD22h7k2FpRwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101599; c=relaxed/simple;
	bh=tYmDJrrwk5i1W07GnsV2+xUBbqoK/R1xrp/LxextL5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKfneQv9Wpu3ORW2zSDFgy0oLS8P4H/EoL5QyAoh+pMIKUxUJSsftBDMo2TFqZcamQ9LA6meOY9wuEeCnnMLfUhKr+5UOJ7kBJaxUPqt3jevFatyATIBEnw/nTNZEuuIRVz5u9NgMXzBbXp2DGLQDy09ffwsPr1vWnXli4r2ySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se; spf=none smtp.mailfrom=lankhorst.se; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lankhorst.se
Message-ID: <80c49a80-d49c-4ca5-9568-9f7950618275@lankhorst.se>
Date: Fri, 13 Dec 2024 15:53:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
To: Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
References: <20241204134410.1161769-1-dev@lankhorst.se>
 <20241213-proud-kind-uakari-df3a70@houat>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20241213-proud-kind-uakari-df3a70@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Den 2024-12-13 kl. 14:03, skrev Maxime Ripard:
> Hi,
> 
> Thanks for the new update!
> 
> On Wed, Dec 04, 2024 at 02:44:00PM +0100, Maarten Lankhorst wrote:
>> New update. Instead of calling it the 'dev' cgroup, it's now the
>> 'dmem' cgroup.
>>
>> Because it only deals with memory regions, the UAPI has been updated
>> to use dmem.min/low/max/current, and to make the API cleaner, the
>> names are changed too.
> 
> The API is much nicer, and fits much better into other frameworks too.
> 
>> dmem.current could contain a line like:
>> "drm/0000:03:00.0/vram0 1073741824"
>>
>> But I think using "drm/card0/vram0" instead of PCIID would perhaps be
>> good too. I'm open to changing it to that based on feedback.
> 
> Do we have any sort of guarantee over the name card0 being stable across
> reboots?
> 
> I also wonder if we should have a "total" device that limits the amount
> of memory we can allocate from any region?
I don't think it is useful. Say your app can use 1 GB of main memory or 
2 GB of VRAM, it wouldn't make sense to limit the total of those. In a 
lot of cases there is only 1 region, so the total of that would still be 
the same.

On top, we just separated the management of each region, adding a 
'total' would require unseparating it again. :-)

I'm happy with this version I think. I don't think more changes for the
base are needed.

Cheers,
~Maarten

