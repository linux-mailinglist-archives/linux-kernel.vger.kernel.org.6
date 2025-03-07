Return-Path: <linux-kernel+bounces-551229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A42A569DF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246FC18969A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6AF21ABBD;
	Fri,  7 Mar 2025 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="bOTLs64f"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035741A23B8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356158; cv=pass; b=K6ujMLu5D3aBOqKjsfRqHy1rhb3GdWphzC73ZZme0wa/cWjXPZKIqoUNuldFP3rdxNMjZRS1tbu/3/nL+S4suQ6Ivn33ZzMzS4JeA+D/tcfkItJjQqgGwy/orRH+ItcYn4IBUVunYZsoyzHTjAqSdW/DrGClJ7KMQFWUkzPPUNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356158; c=relaxed/simple;
	bh=1d2D+HBQ0RDpITUkc9GYO+Pmw/bWpyKfgtFmEhC+hp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OS2lJHFuJ6lD0KQxcNUovyCCikLSrovNCX7yQ0rJTO61zZvBQJd4gfU4GibLszL1viGLCnznEi1E2daabNWCwF5quPJ+mF/zvDHgcnh0QC9lHVRst6qgAsNHULmniOdRwwxug3bLCAzk1fx6va2sj4K0WrpN2zMhg9Gqx1pb/M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=bOTLs64f; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741356142; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MLurPKlC1elfN1Ga9djK+24eSHs3N/1L0XNgxqacuiZpdaM+LNn8WsQM/xhqYlApJZNqAEAffa4PpmrwKLQpbtI3bsQiVr3m+Iz6+u7xIKhq7xA+4YL5T/AFoivc76K3fjheasR2m/AJI/XVkH/7VFLfVz5fAw+Ofw4d1HDdAXs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741356142; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KTxgJbKE1OR0cJEsl1DelDSQA9kndID/O86cy0Ze3Yk=; 
	b=CNgRBgkhWztM4lcCCq98sq19xeMLA6F4W3pHio4fNQIab0SNFzknsF2o0aGryjYn97F+xaLXotgEkvoSwquxFZs44SxrEMpx6wH4P+9irxHQRrKKWEitIXVjiEznGSb2VjrfMbv0dFns3LOKiV7Mj0lYY2fNW7Yi/Y95gW8xDPo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741356142;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=KTxgJbKE1OR0cJEsl1DelDSQA9kndID/O86cy0Ze3Yk=;
	b=bOTLs64f75Z2dyd5OOMwW1c/9IeTnFIFmOxXquSRnoUPQF6P/tjVDxH8PtoTAV4U
	AkQgWxkgbEWh0ikQ6whEsWDaajLB95GoDmKzDopdRxNzN3ob8/7EE/t7dJhXXeSx/CV
	mq3LaKhLygUm0kGLe8vjtkrNUwCelRmg1lD+hwZw=
Received: by mx.zohomail.com with SMTPS id 1741356140228336.02250564093174;
	Fri, 7 Mar 2025 06:02:20 -0800 (PST)
Message-ID: <6f3b879b-22ea-4d48-ad6e-e75e8b2990f1@collabora.com>
Date: Fri, 7 Mar 2025 11:02:14 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] drm/panfrost: Split LPAE MMU TRANSTAB register
 values
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, steven.price@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
References: <20250226183043.140773-1-ariel.dalessandro@collabora.com>
 <20250226183043.140773-3-ariel.dalessandro@collabora.com>
 <20250227092537.63053596@collabora.com>
Content-Language: en-US
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <20250227092537.63053596@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Boris,

On 2/27/25 5:25 AM, Boris Brezillon wrote:
> On Wed, 26 Feb 2025 15:30:41 -0300
> Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:

[snip]

>> diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
>> index b5f279a19a08..4e6064d5feaa 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_regs.h
>> +++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
>> @@ -317,14 +317,19 @@
>>   #define MMU_AS_STRIDE			(1 << MMU_AS_SHIFT)
>>   
>>   /*
>> - * Begin LPAE MMU TRANSTAB register values
>> + * Begin LPAE MMU TRANSTAB register values (legacy mode)
>>    */
>> -#define AS_TRANSTAB_LPAE_ADDR_SPACE_MASK	0xfffffffffffff000
>> -#define AS_TRANSTAB_LPAE_ADRMODE_IDENTITY	0x2
>> -#define AS_TRANSTAB_LPAE_ADRMODE_TABLE		0x3
>> -#define AS_TRANSTAB_LPAE_ADRMODE_MASK		0x3
>> -#define AS_TRANSTAB_LPAE_READ_INNER		BIT(2)
>> -#define AS_TRANSTAB_LPAE_SHARE_OUTER		BIT(4)
>> +#define AS_TRANSTAB_LEGACY_ADDR_SPACE_MASK	0xfffffffffffff000
>> +#define AS_TRANSTAB_LEGACY_ADRMODE_IDENTITY	0x2
>> +#define AS_TRANSTAB_LEGACY_ADRMODE_TABLE	0x3
>> +#define AS_TRANSTAB_LEGACY_ADRMODE_MASK		0x3
>> +#define AS_TRANSTAB_LEGACY_READ_INNER		BIT(2)
>> +#define AS_TRANSTAB_LEGACY_SHARE_OUTER		BIT(4)
> 
> How about we keep AS_TRANSTAB_LPAE_ here and prefix the new reg values
> with AS_xxx_AARCH64_ when there's a collision between the two formats.

Agreed. Will use AS_TRANSTAB_AARCH64_4K_ prefix for the new ones.

> 
>> +
>> +/*
>> + * Begin LPAE MMU TRANSTAB register values (no-legacy mode)
>> + */
>> +#define AS_TRANSTAB_LPAE_ADDR_SPACE_MASK	0xfffffffffffffff0
> 
> It looks like we're not use AS_TRANSTAB_LPAE_ADDR_SPACE_MASK, so I'm
> not sure it's worth defining the mask for the AARCH64 format.

None of the original AS_TRANSTAB_LPAE_* values are used, but these refer 
to the LPAE (legacy mode) format.

The new mask for the AARCH64 format is required by the follow up patch 
`[RFC PATCH 3/4] drm/panfrost: Support ARM_64_LPAE_S1 page table`. It 
probably makes sense to just squash it now that this patch got 
simplified and the naming will be more clear.

I'll send a new patchset version with these changes.

Thanks!

-- 
Ariel D'Alessandro
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718


