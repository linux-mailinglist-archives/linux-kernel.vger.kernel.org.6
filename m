Return-Path: <linux-kernel+bounces-231012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F249184EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24BE1C22CBC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3702185E7D;
	Wed, 26 Jun 2024 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGR1WVfZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7941755A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413650; cv=none; b=Ulw0G7AlzZ85OJPOcFG34djYTI5GcfEduWnoRRxYDI2qRUH7SRie03zQiMUV25t2k7XW5+WrQR/UKtrlt7Bc0X9p2j7cnRQgjCgdPDUgu3SxesXEFMw163+qLWzV9Th52o3S3lP9P6EeRIykyFqph+hjWsUbNLCOzawzv3DcQyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413650; c=relaxed/simple;
	bh=4aJN6TWfIin+mUtOQXex7Sy04LH7If9MomofXC88ADQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VyvN4y1uDN6VaSOw858Hl48N26veMtfwRl0gY47qGY8teBk9LxLBcTjSk0oguE9eKfLvXlgPf8vuTKKTWjfwgR8WXvwrPaC+OOFKaIFIdJsLT5lTUxTrwP7aeQLdhEwrVoAt8FQv7bmJWWYNeVEQj3ikwer4UgUUju6chkKGZ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MGR1WVfZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719413647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/ZNn5yWtbUQ7xxPt2ILvYmVBMyK/NlRkJHOBkDnNyA=;
	b=MGR1WVfZtVQw9bxnjgrY9qJsY3DrHo2MQlZNPUhNlUzaQXFo3ENyb5YkAsSk7YRxoZB4xC
	ePu93dKovbWFlttr0EkWwhbAnqfMP5nb3ql7TRfdZ3rnYCu8L1l8ajM7yylt3twd5yIPup
	EjEpm2/zgGmFtAfD6V0P2O9fEncjHwc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-CySZG4HVNnmctAq9uEywHQ-1; Wed, 26 Jun 2024 10:54:03 -0400
X-MC-Unique: CySZG4HVNnmctAq9uEywHQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ec5057538aso41992361fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719413641; x=1720018441;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/ZNn5yWtbUQ7xxPt2ILvYmVBMyK/NlRkJHOBkDnNyA=;
        b=ekzG8rOsN+PkWWSBqzzIw87F8IhoaJXb4e93rQbOxwoDJFJkKP58bPE0hoOUlKEkf9
         jYNBiXN0MRtBS8A2xl8wI4axaewTyvBZ5Qg9ZjTw8R4pNtjpz4QV/tdUOiKnvDvKtjAC
         ak4LFDdE/NPNmqbJ2pINeG8RwBsGh0MXOO5QQlO5pjRiHcY65Cq8xjlUyXLTDEm/EFcb
         wT/LVug7DqRYxl2+lonocfxqJad0JTmTIn24oaSPWRvd8Xy2qXXiARtP7tKA2YuJ9PwO
         zK+TQvCX0z2RaQN0ZOwa/ONyaeuJdpzAf2i9Z6UPwCA9V2Aic0iX9nCYh6X6yv4G8oxW
         LMMw==
X-Forwarded-Encrypted: i=1; AJvYcCVgH9vtgKbF4JvdvqSw3Svtg6Mxp260Pd7c2WOWAatJ3Ox2kmZDvPsVRa1iPsHUUA4FoMsksvFTywGKfBDcwjk5SCNYCinjYV9vC+qv
X-Gm-Message-State: AOJu0YyXxDOX7KthBDtZi7IfzGxYmoae7UJpIIS2JAbzc6BritwkYOQb
	z74OJ91SzrQKi0A84fQT2ueONVFGXxuM97VCw2yA+UVqy5GMFiFwDSZPFnwWcTQBij3bA9VdEiM
	sP4hub4sgjrG+F2zaMuOX40G7F48eeeGrlvr9cXHUPaTRovbkshvRpupnH0Bl+A==
X-Received: by 2002:a05:651c:2119:b0:2ec:681b:5b50 with SMTP id 38308e7fff4ca-2ec681b5f72mr56159521fa.11.1719413641704;
        Wed, 26 Jun 2024 07:54:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwj4p2whlwOd1A2Ym7AthhJqROwdpeA7StJlDLOTOhCEfD6pTFqmDk3RIfx3XbeFg0xm84ow==
X-Received: by 2002:a05:651c:2119:b0:2ec:681b:5b50 with SMTP id 38308e7fff4ca-2ec681b5f72mr56159341fa.11.1719413641324;
        Wed, 26 Jun 2024 07:54:01 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c82519bdsm29460335e9.13.2024.06.26.07.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 07:54:00 -0700 (PDT)
Message-ID: <0119ce0b-d0e1-48fb-a2e2-2643472bf434@redhat.com>
Date: Wed, 26 Jun 2024 16:53:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: fix null pointer dereference in
 nouveau_connector_get_modes
To: Ma Ke <make24@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 lyude@redhat.com, linux-kernel@vger.kernel.org, daniel@ffwll.ch,
 airlied@gmail.com, kherbst@redhat.com,
 Jani Nikula <jani.nikula@linux.intel.com>
References: <20240626013013.2765395-1-make24@iscas.ac.cn>
 <875xtwdone.fsf@intel.com>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <875xtwdone.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/24 11:44, Jani Nikula wrote:
> On Wed, 26 Jun 2024, Ma Ke <make24@iscas.ac.cn> wrote:
>> In nouveau_connector_get_modes(), the return value of drm_mode_duplicate()
>> is assigned to mode, which will lead to a possible NULL pointer
>> dereference on failure of drm_mode_duplicate(). Add a check to avoid npd.
>>

Please add a "Fixes" tag (also for your previous commits) and CC stable.

>> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
>> ---
>>   drivers/gpu/drm/nouveau/nouveau_connector.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
>> index 856b3ef5edb8..010eed56b14d 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
>> @@ -1001,6 +1001,8 @@ nouveau_connector_get_modes(struct drm_connector *connector)
>>   		struct drm_display_mode *mode;
>>   
>>   		mode = drm_mode_duplicate(dev, nv_connector->native_mode);
>> +		if (!mode)
>> +			return -ENOMEM;
> 
> Do not return negative values from .get_modes().

+1

https://elixir.bootlin.com/linux/latest/source/include/drm/drm_modeset_helper_vtables.h#L899

> 
> BR,
> Jani.
> 
>>   		drm_mode_probed_add(connector, mode);
>>   		ret = 1;
>>   	}
> 


