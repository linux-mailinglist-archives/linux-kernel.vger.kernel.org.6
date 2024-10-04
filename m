Return-Path: <linux-kernel+bounces-350413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 706C49904D5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F4E2833A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151E72101BC;
	Fri,  4 Oct 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+Hdfapc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BBE156678
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049873; cv=none; b=K3/5oy+W4Sx1E5RgGbUK4CksvglcEP3xTPKBIAB2ayFkOaSt04RG1L7UWjf9ULMbEHl7IjS3tNvZ5bbYaYoJS3Cjrg8SE12DqI/SNCHv3NSsL3SqUUw5ljkCAQPo7ul7ilqcVlt+e66aKql5jJCVkq/ZeSd8VJZonHgLmOQlL0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049873; c=relaxed/simple;
	bh=1jRjg44o7RXdALhuqJ5q7kq6CphpxD21Kq5nEid3kLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGvoLklwjYLL/fEALoMOmtJ4TNHcGXqIkuZut3nbfvfHhM7tvArDXFrDQQK+0Q+D40fhmp5rZWNQsVpxJT76j6XhEO5hTFT0PAgv6x9vol9vJe4pKtj5j+h0UADCMUp5ljrRNnz1dNIXeNQJA4sKW/tcuzltsJb+3xRlLTrikxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+Hdfapc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728049870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJMgjrZKZj76hHRF8+pe8MD/Cm7KPfIyy9S/W6reD88=;
	b=P+HdfapcCRCXZkXK8LYmICu/3dJheK6zKruKn7WwBYRfrMvkNHdHSVGBLFjyse45PE/8Be
	Rt/Nmg0yV7FpkCDncH7BwHSKRTmrf4oLL3OjwoRJ33KBWuT9Qp89cxOxewukAqyZ+hl2sB
	2jlx1Hy5Tw5vjarkkymDY0P9rGqRkj8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-w5WuRZfKMMCM_9pUYYWSSg-1; Fri, 04 Oct 2024 09:50:59 -0400
X-MC-Unique: w5WuRZfKMMCM_9pUYYWSSg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8d10954458so155596866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 06:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728049858; x=1728654658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJMgjrZKZj76hHRF8+pe8MD/Cm7KPfIyy9S/W6reD88=;
        b=nlQXg1nd3nfQ28zpi9scFU6Q7QtBDBL7k/WvTn2CkyszpESjSf464m9hvZBSslbwej
         gj9OOFigKBVUkAL3XhvWJsDQuNiNQi7Yq7EL9nFXx9FwYDzyCasJ5J162+lqFKfTG9iV
         QeEcdCeNnm360pl9QjmSYfnLbcbPGG5iW0rmo2aESZlduGiyvTXOu3GjaQSdV8G3Gvoa
         A+XZPoh+dVQQdnkFCf3nl/kpAjR8gH68IX1x3sZxG/XUwUCtgHSBq1N6nt4UfNfDMkMS
         hkWMhIhoL1WzLpg8h8rpJL9jgW7iiFL0FG0tuJf4qUsmlCewxbeoWUjkrzdg/SRgNfD9
         WkaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAR0GxNfhXPm4wu9+8cuGQkuvVaoZkFjqc2i5oTQexQu3FUFgp4NLSkMNID9hV4mKIoCA55vxL3ot0Vo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRlWkyJW2z6KduEl7rCFZb913eCDSu1FxoO0xs/KAWfR3c057f
	Z4AwSzC4U1TTsaQG4YVWK+LS3lNuDr6X5eMFvsPsTJ8twJsUUogNDiTqJoh2cM1epu8xP/YZ/kb
	HLR7FchhtmrgXex4IBuh8fEG/+UlIPerq4mx7bY9yDLMGTJ8dyu0QdkABDpWa+w==
X-Received: by 2002:a17:907:c7c8:b0:a7a:ba59:3164 with SMTP id a640c23a62f3a-a991c00d249mr248019166b.53.1728049858118;
        Fri, 04 Oct 2024 06:50:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhxdEgOPGLp4YXm8hrNbfjQPjIj+VXDT3q88IioHMhf/m1Cr/c5RpDYwGGoM48jU1SucIS4g==
X-Received: by 2002:a17:907:c7c8:b0:a7a:ba59:3164 with SMTP id a640c23a62f3a-a991c00d249mr248016666b.53.1728049857700;
        Fri, 04 Oct 2024 06:50:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99102a580bsm230001666b.72.2024.10.04.06.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 06:50:57 -0700 (PDT)
Message-ID: <545fd443-eab0-4585-8286-ddc2c7dcadbe@redhat.com>
Date: Fri, 4 Oct 2024 15:50:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/2] platform/x86: dell-sysman: remove match on
 www.dell.com
To: Crag Wang <crag0715@gmail.com>, mario.limonciello@amd.com,
 Prasanth Ksr <prasanth.ksr@dell.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: crag.wang@dell.com, Crag Wang <crag_wang@dell.com>,
 Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241004024209.201244-1-crag_wang@dell.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241004024209.201244-1-crag_wang@dell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4-Oct-24 4:41 AM, Crag Wang wrote:
> The URL is dynamic and may change according to the OEM. It was mainly used
> for old systems that do not have "Dell System" in the OEM String.

But those old systems presumably still exist somewhere out there, right ?

And if they still exist then we do still want to support them, so I'm
not sure why you think it is a good idea to drop this test ?

Adding the alienware match seems fine, dropping the URL match seems
like a bad idea unless you are 100% sure that there are no systems
out there which rely in this match to load dell-wmi-sysman.

Regards,

Hans



> 
> Signed-off-by: Crag Wang <crag_wang@dell.com>
> ---
>  drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> index 9def7983d7d6..c05474f1ed70 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> @@ -520,8 +520,7 @@ static int __init sysman_init(void)
>  {
>  	int ret = 0;
>  
> -	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
> -	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
> +	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL)) {
>  		pr_err("Unable to run on non-Dell system\n");
>  		return -ENODEV;
>  	}


