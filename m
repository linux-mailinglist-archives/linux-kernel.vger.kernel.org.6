Return-Path: <linux-kernel+bounces-335101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7C797E109
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 13:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6882812E4
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 11:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECD9156F2B;
	Sun, 22 Sep 2024 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGj59EG/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B6C7DA7D
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727003520; cv=none; b=J/m+HqaUfM3czjcvg0EXw7z0EHN99DzXJqTeUfu4IH5hfuKwl0KOc46A9kJLBAcuh+0fBloyiEgxqg/WCsUyPHfuujXAELS/tMSuuxcb2DdCOlwTGm8X2/J8iYSw2or9aTFZmsyr8dXi1v51x3Jg2liz7rhqlkNdx0xDrZCP0SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727003520; c=relaxed/simple;
	bh=Zm62jqP31LLEV8eAvtyRXUOqY22kE1R2CJ8Uc28Ijd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERyKq3yLkNXfuvTeXWg8WyXrt+ZPXehtJzFobGAPEHvdKBNALA6B+zJn5swnlRxN3MZ6xxt31SBABLSfmQSlUQRvZ3u1lVMEXFBDo9fd7aqGXB+fUiJuKbpd4Ce0gS6bt4sjeP4e89kbfs5Ue8RsjunKZFerlP+rppzCIcQMj14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGj59EG/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727003516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g3ZBnZpol239OQHpIN/pJOeGZb3vp6k4LhbA2BN3D44=;
	b=UGj59EG/SKY7wcJTMrX3Brgqq1+4Sq8XN1UZL2B92FntNoB9M9r2mloiwQHp1agGwnotOi
	Nt9KegIwJ4vfrEHt4C/kuTJrJ/IytZ+IgGJm1tYgeBW5vFsKDciu6uwMMMgd4qNI87vP6L
	eZJbiMsHgtVZhFHh+JDB93Gti6FUxf0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-J2eoDMmVMamzfhRoWRnLIA-1; Sun, 22 Sep 2024 07:11:53 -0400
X-MC-Unique: J2eoDMmVMamzfhRoWRnLIA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c25e0a50bfso2295361a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 04:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727003512; x=1727608312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3ZBnZpol239OQHpIN/pJOeGZb3vp6k4LhbA2BN3D44=;
        b=eHcegW7MyT6COIaicO8n2LesZDJ5rF8avBtEMSyg0WQ0/4dYFacfzJGPo12m2RVFjR
         XpdxZ4Xcoi8qkMRdmsaYU2F5uiH+iJ9WFdNxGC4oAzJ0zIb1yOunswrqCGtTsnoRCnis
         sXcdyDnkDIQTWlkIvT7j8Sv+dDde4RxFoyFojoNEYYa4+ZQN73cp4Y3od/U65WMdTsGD
         DOJu3BH/z2Top8nhU0LTA9hI0HvW10U7zvAIBKC92zAZyGONeXDZg/0A7hqWx09AQFyZ
         fqopqcOqATTZw1+Z3Gj8SC4fWDA8OlLcxOT7W71qvysewT9TbVmSQqv7yuwv8GW/cLrC
         yH1w==
X-Forwarded-Encrypted: i=1; AJvYcCUk/eeQKCvLLaExOUt1afdnQ3z5JAPEDxQi9PRgXL3o8w7CDq10TwX7U/1rNVy2GIV36gYGOx+q/iL6m0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFq80RutA8ZOq6YHqhqiiioHAS2J+rZrCjmIs97zviWRiBrfLI
	0yEMG2+VOVX9XeOvWdsimqYVw/H/zPGuDYj1MtUjZMaUU0cc6O7rtMebgWMbTVIlFTm9Y5rGh9w
	NiK7tq/PsDrBglR6b0AxBVCGMb2KdfbECPpZsnnjEWnOD4r9gvgZGaqx05Box4w==
X-Received: by 2002:a05:6402:3483:b0:5b9:df62:15cd with SMTP id 4fb4d7f45d1cf-5c464a7cb46mr6531226a12.32.1727003511751;
        Sun, 22 Sep 2024 04:11:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5M48FaOWEpZJt4RV/5sAmb77W7F27nxy3AkRbG2aRvqpsuzvbNrDF+cJStQAyjxOd/XY6uA==
X-Received: by 2002:a05:6402:3483:b0:5b9:df62:15cd with SMTP id 4fb4d7f45d1cf-5c464a7cb46mr6531202a12.32.1727003511353;
        Sun, 22 Sep 2024 04:11:51 -0700 (PDT)
Received: from [10.101.3.85] (ip-185-104-138-99.ptr.icomera.net. [185.104.138.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb94a01sm9020655a12.91.2024.09.22.04.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 04:11:50 -0700 (PDT)
Message-ID: <a90d08d5-265a-4ba2-99f9-68fa18960b27@redhat.com>
Date: Sun, 22 Sep 2024 13:11:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm: panel-orientation-quirks: Add quirk for AYA NEO
 2 model
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 tjakobi@math.uni-bielefeld.de
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 Denis Benato <benato.denis96@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <cover.1726492131.git.tjakobi@math.uni-bielefeld.de>
 <2b35545b77a9fd8c9699b751ca282226dcecb1dd.1726492131.git.tjakobi@math.uni-bielefeld.de>
 <gnllphvuffajfbh3aczda5z7t3ytjexf5a6wuuzsz6pla6e2kz@m564uc2ogn4q>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <gnllphvuffajfbh3aczda5z7t3ytjexf5a6wuuzsz6pla6e2kz@m564uc2ogn4q>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 21-Sep-24 10:02 PM, Dmitry Baryshkov wrote:
> On Mon, Sep 16, 2024 at 03:18:51PM GMT, tjakobi@math.uni-bielefeld.de wrote:
>> From: Joaquín Ignacio Aramendía <samsagax@gmail.com>
>>
>> Add quirk orientation for AYA NEO 2. The name appears without spaces in
>> DMI strings. That made it difficult to reuse the 2021 match. Also the
>> display is larger in resolution.
>>
>> Tested by the JELOS team that has been patching their own kernel for a
>> while now and confirmed by users in the AYA NEO and ChimeraOS discord
>> servers.
>>
>> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
>> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> ---
>>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
>> index 2166208a961d..3044927c0c5c 100644
>> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
>> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
>> @@ -184,6 +184,12 @@ static const struct dmi_system_id orientation_data[] = {
>>  		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T103HAF"),
>>  		},
>>  		.driver_data = (void *)&lcd800x1280_rightside_up,
>> +	}, {	/* AYA NEO AYANEO 2 */
>> +		.matches = {
>> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
>> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
>> +		},
>> +		.driver_data = (void *)&lcd1200x1920_rightside_up,
> 
> I thought that AYANEO should come after AYADEVICE, but the array doesn't
> seem really sorted

It is sorted but it is sorted by the Vendor - Model in the comments,
not by the DMI strings since sometimes those are e.g. "SYS_VENDOR",
"Default String" and stuff like that.

The entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

> Thus:
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> If I hear no objections and if noone beats me, I'll apply the series
> within few days.

I'm currently travelling so if you can apply this series
to drm-misc-fixes that would be great.

Regards,

Hans


> 
> 
>>  	}, {	/* AYA NEO 2021 */
>>  		.matches = {
>>  		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYADEVICE"),
>> -- 
>> 2.44.2
>>
> 


