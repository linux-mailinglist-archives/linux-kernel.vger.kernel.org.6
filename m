Return-Path: <linux-kernel+bounces-210610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB2D90463C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35AAF282A55
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D63153505;
	Tue, 11 Jun 2024 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ed1cFV8V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13FABA34
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718141075; cv=none; b=Bzf1bOnEVNnKSvDpSDQXsxmRHBE9Lg5pGJhhNZacMwpB2qlrA4f9xXtFnF3g51VjsJelCxq5Ve3bjKoOtA2be80qM5lOiSel1IttTBCmhqDyTeERjl4HaEeBbckt3cpWOXTopABbgM2QoBjX95jv8Bblv177don3OuUrfbK6amA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718141075; c=relaxed/simple;
	bh=t8ha1Ix597he6gsoFoWlFRBk6jIyCdsIGXRbcqyWEys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XL/r73d3skINIV+os8ECrtvWklijp5zrEawkRdOslpf7l8bLHmE1Hvzik+h01xfNj3lswMMrPSzChBLzMGos29Ul7kKXNEI2jSu0nJCKywEnYiz+RINYXDpASHPT+WWda7B8qR0s/9bo2X39Y5+Vcv/0Ecy0tACumk5buOOpxw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ed1cFV8V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718141072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kwi6qR7i5j222N4J5ge6XLRF/OTcTMPoCLriE5Gui2Q=;
	b=ed1cFV8V+7tPpcspR5ARKiLxDXt9JR8OYiG9IjQgQ+PdyjNR+whBTenq+2ik/BthuxwSr8
	DPfdXUTmus6wbKBCffql4ddzs0DcSSCjknWYMVhajw0brCpZ47otNNXvblZw2xmYW3Cv8X
	dlHfUnB5qb+H+ic4S831p5b9lnk8D0A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-NyyIqchjP72YI9iXCV3REQ-1; Tue, 11 Jun 2024 17:24:31 -0400
X-MC-Unique: NyyIqchjP72YI9iXCV3REQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35f1fcd3bbcso1704209f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718141070; x=1718745870;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kwi6qR7i5j222N4J5ge6XLRF/OTcTMPoCLriE5Gui2Q=;
        b=RknKPj18Z95p/HCtC15XbMBd/2GsU3YwlPUTujz6PQXsdFQ/Qd7s/P4VSzrKtdX5wo
         /kpPV54/FSGQGOD8RdcGlvWz7EHzjBQfBuc/9g5atzGRynETPc5E3cZ9JRIeYsn/oLbz
         +uWhtuZTs6JXWzA+Bw+cJlyy9n2nwKAQmoefY4zsTIrSuit6zvWAnRhgbHwEU5kvFvJ1
         iWjeF/zBMJXIzMbtSw/kJ4/UYFqkcNRvqr7R0106fX9ShoL86DlDIZAdRD2av0lwOB+u
         ziXZpz5FCHGXqydFKCBBRLhELA6tsTJu2KN5U9VLwyJkt5lG2yAPmjuL9wgi7crkRUGd
         mDEw==
X-Forwarded-Encrypted: i=1; AJvYcCWOa+0JMt0SI6QrO72r40QSd2EUSpOzS21ZI+3E9GoFTpiFgdx/Lh9dywne4za5NaZo+V4Cmq/9cHjG4EUIQxh6YY7ROsJ5y1bfcGnH
X-Gm-Message-State: AOJu0YxIfTxCjyJocZH1fSTNvpvomtea/5gE/5NeFranE7VRPeCqywSR
	bz2mgHm+e/bUSDauE9RzGhX0lPBIAs/O2wa5F5AK0VfRNXcdA7PU6As3bv4Aiylxa67/yJJYTrw
	6AMQDql4c/gOXFJQ/vuECXdecCHbuKTYNQPqjO288kCoZCu/h1m+cCo7nVPfUZg==
X-Received: by 2002:adf:ee0d:0:b0:35f:1f80:1fa8 with SMTP id ffacd0b85a97d-35f1f802197mr5672712f8f.34.1718141069918;
        Tue, 11 Jun 2024 14:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHBBTWZibR1MV4vH2a0NLkyidmwyfZ12S/ifHe7Sk/bckt//fu9s+WNF25Hd6AqZ58+o6TGA==
X-Received: by 2002:adf:ee0d:0:b0:35f:1f80:1fa8 with SMTP id ffacd0b85a97d-35f1f802197mr5672705f8f.34.1718141069543;
        Tue, 11 Jun 2024 14:24:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f2c3fd63fsm3019565f8f.51.2024.06.11.14.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 14:24:28 -0700 (PDT)
Message-ID: <37402257-fbcb-449a-82a7-4acf878bb09d@redhat.com>
Date: Tue, 11 Jun 2024 23:24:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm/nouveau: remove unused struct 'init_exec'
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: daniel@ffwll.ch, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kherbst@redhat.com, lyude@redhat.com
References: <20240517232617.230767-1-linux@treblig.org>
 <de79f41d-3a9b-4f15-b270-246af8b4c5b0@redhat.com>
 <Zmgo8leSWpsjVVBS@gallifrey>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <Zmgo8leSWpsjVVBS@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/24 12:37, Dr. David Alan Gilbert wrote:
> * Danilo Krummrich (dakr@redhat.com) wrote:
>> On 5/18/24 01:26, linux@treblig.org wrote:
>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>
>>> 'init_exec' is unused since
>>> commit cb75d97e9c77 ("drm/nouveau: implement devinit subdev, and new
>>> init table parser")
>>> Remove it.
>>>
>>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>>
>> Acked-by: Danilo Krummrich <dakr@redhat.com>
>>
>> To which series does this patch belong?
> 
> Actually all of them were independent patches on drm
> some of which are all in, so it can be taken by itself.
> 
>> Need me to apply it?
> 
> Yes please!

Applied to drm-misc-fixes, thanks!

> 
> Thanks,
> 
> Dave
> 
>> - Danilo
>>
>>> ---
>>>    drivers/gpu/drm/nouveau/nouveau_bios.c | 5 -----
>>>    1 file changed, 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c b/drivers/gpu/drm/nouveau/nouveau_bios.c
>>> index 79cfab53f80e..8c3c1f1e01c5 100644
>>> --- a/drivers/gpu/drm/nouveau/nouveau_bios.c
>>> +++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
>>> @@ -43,11 +43,6 @@
>>>    #define BIOSLOG(sip, fmt, arg...) NV_DEBUG(sip->dev, fmt, ##arg)
>>>    #define LOG_OLD_VALUE(x)
>>> -struct init_exec {
>>> -	bool execute;
>>> -	bool repeat;
>>> -};
>>> -
>>>    static bool nv_cksum(const uint8_t *data, unsigned int length)
>>>    {
>>>    	/*
>>


