Return-Path: <linux-kernel+bounces-352348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 648C2991DE9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 12:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B90282994
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74791741C0;
	Sun,  6 Oct 2024 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjiZCvch"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C2171E55
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728211411; cv=none; b=bp7a7xUn6LBnmIEXYj+mfWsOyV94Po7kE4pUUZzMrG5cY9V3KNFBn8UHcdOnm0+grFpu34noIWdW3z35NOZM1fIMHE6LiGk2SBCijiXARWPssMm7mlygxBgJ7ofj8FSUdbBpvhk6JZfgu7wsnnYw8BtqluVb0qpEeDUFZGZ1aIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728211411; c=relaxed/simple;
	bh=gX3Y8Rp36oW1VSqljUb+LMv7bOzPr+cpxiWUjCx6Ehg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkKnKThAhIZjiSyULEvLYkbVm5FCHvQyCKiDrGu902PDoqHIfSforcGy/koTFoZLlJTfRAclX9xzNKrzIO/oGmrOw2JejhB8YCd1JsJCzGRO68ASRWpnAUdsnowcz0kuGjspHy3nQYbpmwcUnPLzsk6Lfd6cLK3tm7QaY7UNWr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjiZCvch; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728211408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fuNNoZzkII6cESAaRfuN2+DNq7dBdN2dUWdalXENeC8=;
	b=WjiZCvch3sl1XXM/XQaQkTbJZ7nWWHHCm/QGmORPWEvC8Mq0BV4THKaFDYdtxVDTy5Pat0
	YZaDHrxpc/MLR0EkzeMzUuQZHS1WOTUeXBsQc+YQb9NeBg2f2bOilElO/8zzxMoD/ZGSMV
	YjB3f8WQWC7FBPfaQctihT5p6/r9cxA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-3-EBp9PTPZy3uSKv36Ph8Q-1; Sun, 06 Oct 2024 06:43:27 -0400
X-MC-Unique: 3-EBp9PTPZy3uSKv36Ph8Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8ff95023b6so299177766b.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 03:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728211406; x=1728816206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuNNoZzkII6cESAaRfuN2+DNq7dBdN2dUWdalXENeC8=;
        b=TghQu/fT++34s8kGPpTsF+ewilDUze8rXigSNCOryoXHYf35EoDIsRf4EkpqciH54G
         byFH1aa/KDhd/r/iA2iNKqPotcqgEYCTBWElYMku8mbzLM0gGJUf5aD06WAUCCM8XSMU
         pDZtWe/xaW/ugljkEd8U5CLR3iAUDIw4IcQd0npjRqJxzis4hk3fj/8ISv5VA96Z66Rp
         IqAa+UWCdKU4SQ+wae++gmULzbWid0jggYwT287yp608OGcdc++S1t6RHEH+oiRxG4ex
         inquFtdTvBCaCmAS+/mmxtfTIAqY/y1xdTSrUkLzvUCbQLcX3FmISUlU3anGR9s7yyX4
         Ayqw==
X-Forwarded-Encrypted: i=1; AJvYcCXvO6CuGxLGz/gNiKoNdVnz7XLHl2isU3QtFHCAurW5Idi08nkA8thszEP+AM5rRl4ARqxh7hYPCI22+w4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4jXYVYt9QDOrjr9oEhSnBAnCxwULizW7FTqkfrnmn96dzMeHL
	RbFNfVyIjd7FwiTV5l3rEqSkgnmiZ9lPxeYOKvoXu6aHSAPRetJTKn+fcTAFCkTaHnnmSEPyrp8
	5n1jWG6tScCmBOdd7nGGta4GZQhq/IDflbU0+xUFbuC3DKvpUFgDeDMidzMkFt76LYqglrOrK
X-Received: by 2002:a17:906:d555:b0:a8a:1ffe:70f1 with SMTP id a640c23a62f3a-a991bff46f0mr928077766b.50.1728211405594;
        Sun, 06 Oct 2024 03:43:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfQ5bsz8E2+MJn97iSmPc5ku+cuqXvIpGDUQoYD1n2SK4NH5OOO3Xx8ovMvMU4/9Gwz2KdXA==
X-Received: by 2002:a17:906:d555:b0:a8a:1ffe:70f1 with SMTP id a640c23a62f3a-a991bff46f0mr928075766b.50.1728211405172;
        Sun, 06 Oct 2024 03:43:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993f939550sm169050066b.42.2024.10.06.03.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 03:43:24 -0700 (PDT)
Message-ID: <8f45a215-1126-41c4-b4dd-92ad04ea5a8b@redhat.com>
Date: Sun, 6 Oct 2024 12:43:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 1/1] platform/x86: dell-sysman: add support for
 alienware products
To: Crag Wang <crag0715@gmail.com>, mario.limonciello@amd.com,
 Prasanth Ksr <prasanth.ksr@dell.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: crag.wang@dell.com, Crag Wang <crag_wang@dell.com>,
 Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241004152826.93992-1-crag_wang@dell.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241004152826.93992-1-crag_wang@dell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4-Oct-24 5:27 PM, Crag Wang wrote:
> Alienware supports firmware-attributes and has its own OEM string.
> 
> Signed-off-by: Crag Wang <crag_wang@dell.com>

Thank you for your patch/series, I've applied this patch
(series) to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in the pdx86 review-hans branch once I've
pushed my local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
>  drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> index 9def7983d7d6..40ddc6eb7562 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> @@ -521,6 +521,7 @@ static int __init sysman_init(void)
>  	int ret = 0;
>  
>  	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
> +	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL) &&
>  	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
>  		pr_err("Unable to run on non-Dell system\n");
>  		return -ENODEV;


