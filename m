Return-Path: <linux-kernel+bounces-207997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D37901F01
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1871C21EED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E4C7711E;
	Mon, 10 Jun 2024 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pk0DguIi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDA575813
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014320; cv=none; b=T+qePcejS34+uTGKTcOuwQ2kXOLBFjBjZJj2WdsJz5ey9PNaa6aNp+uBz/prCR+Sat+4NIaCeoev87NM7Ji0PLu4pFziN84rxxgsu+YXvfR3yN0oCpDtBS8rLH6970zLddH8ITos//yT/G4I1Xmf6WTXsIL3W88PLD6h6IYaxz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014320; c=relaxed/simple;
	bh=+3Ih8ZCrJxJUEGH7OtUb1hJnKJMhrf1kinREkdEDb28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8jfKnoPPRVT1+9Gj+Zvj7Kh/loXB3NOiVVr2dJQybC3+Fw7OuJbqAnqWgJsMwkrwcYM9+vqyGHJf1RgeNDl44Mxv7rDv+xCbTB4HWRRiHJVyiI8lgGb+MuUNfGAqL6uYIGp8rvGdpbGJj8vZ0ElxbVhjvdCC7qa0x1PmwsOTYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pk0DguIi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718014317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HAGfg58Q9+5VbZsXPAiErocuXPUKP6IBatfDvKZopjM=;
	b=Pk0DguIisfzPahpbOfIuplX3nB+GhOJgzgBNJvol9VE34SUzLRfGAThnrZ2cyDdyUjaPoR
	bxJJR0bjosBaHoSo6J6d2ajkXSncAbIwxaXWKikfk7U4B09edQ/AgNh1xQVEPryk8UQmdq
	iRSaOB/GWn2LB2vfkbVA9vW6fLJtbUg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-aH5crhnAPmGJu2PPmwdJFQ-1; Mon, 10 Jun 2024 06:11:56 -0400
X-MC-Unique: aH5crhnAPmGJu2PPmwdJFQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a6ef7afd90aso113797566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 03:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014315; x=1718619115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAGfg58Q9+5VbZsXPAiErocuXPUKP6IBatfDvKZopjM=;
        b=qqCzmUtOHFT/z5l4wNrSYOM3NgFoN1CzCyELwS5lGgZi/Vxj+g8KsE3VAzzKNtVe/H
         y5rowidReVGx8RNUlI74r3gLaRWBk46u6MHD5KBuCkIbN0k10o/kePBrxWIm4Ag9raLc
         a/vJvOKhVkuJp214COYnYOUufeGiYTZ1/9rNBL/Qi8ouj4y4dhHONarvr8fD/1WIUh+J
         U1mFq1ifv1Z0sBm1BIDUkZl1U5kY2nsyzKFJ++owcVsjHfGy6v6Lq6YBApJk7Y0chnPz
         RdfMcp0FqWaxNql0Te1jIsW1LNav346VGfrHwvhw0oUA5OFKhQataCIlIg2SEDbtV58K
         le/w==
X-Forwarded-Encrypted: i=1; AJvYcCUraEZDom790qEaipKX+4Pa2GIFEEnpG8BUIIJwU47l5FGCEg1KPJc3XzHeIUOrx6K0Q7U+8+wt5bv7//h7TbTCI4VqNttak2ieJVIp
X-Gm-Message-State: AOJu0Ywh1yKXwETpSYxD1ijpyZVsCVbRbAk+L4ulPmcYXgD7GK6gbxqx
	kGKJ7nA5iIoZPR7PItxN2NiLeAVp6AM6FV27PwYt7Bo1mS5eqGcxYgZKNi1wLtOJ6AHGXDaABvO
	q72WUJIkfmMB8mooUld6XL9RGRo5T9CMXm3sJGnQ5Q77f/A6B63OD6zowSwQSEA==
X-Received: by 2002:a50:cd8a:0:b0:57c:5996:cfc7 with SMTP id 4fb4d7f45d1cf-57c5996d14fmr5167532a12.30.1718014315091;
        Mon, 10 Jun 2024 03:11:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqF9FyN44n+ZfeTQ80xQpEd5VG379Y/6+PGq7u5HQg3UFxxA2nbTtUQGPuhUsZ6CmsJ5PNNg==
X-Received: by 2002:a50:cd8a:0:b0:57c:5996:cfc7 with SMTP id 4fb4d7f45d1cf-57c5996d14fmr5167524a12.30.1718014314700;
        Mon, 10 Jun 2024 03:11:54 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae0cc1a2sm7155270a12.23.2024.06.10.03.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 03:11:54 -0700 (PDT)
Message-ID: <0b21129a-3cde-4b0f-a588-9069da4c14c6@redhat.com>
Date: Mon, 10 Jun 2024 12:11:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm: panel-orientation-quirks: Add quirk for Aya
 Neo KUN
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240310220401.895591-1-tjakobi@math.uni-bielefeld.de>
 <a4069a85-b990-42b4-8cde-8906a740ec27@math.uni-bielefeld.de>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <a4069a85-b990-42b4-8cde-8906a740ec27@math.uni-bielefeld.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Tobias,

On 5/31/24 9:04 PM, Tobias Jakobi wrote:
> On 3/10/24 23:04, tjakobi@math.uni-bielefeld.de wrote:
> 
>> From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>>
>> Similar to the other Aya Neo devices this one features
>> again a portrait screen, here with a native resolution
>> of 1600x2560.
>>
>> Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> ---
>>   drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
>> index 3d92f66e550c..5d3fb11fd45f 100644
>> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
>> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
>> @@ -196,6 +196,12 @@ static const struct dmi_system_id orientation_data[] = {
>>             DMI_MATCH(DMI_BOARD_NAME, "NEXT"),
>>           },
>>           .driver_data = (void *)&lcd800x1280_rightside_up,
>> +    }, {    /* AYA NEO KUN */
>> +        .matches = {
>> +          DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
>> +          DMI_MATCH(DMI_BOARD_NAME, "KUN"),
>> +        },
>> +        .driver_data = (void *)&lcd1600x2560_rightside_up,
>>       }, {    /* Chuwi HiBook (CWI514) */
>>           .matches = {
>>               DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
> 
> Trying yet another ping! Also adding Hans to the list of recipients, as he committed the last quirk for an Ayaneo device. Someone pick this up, pretty please! :-)

Thank you for Cc-ing me and thank you for your patch.

This looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I'll go and merge this into drm-misc-fixes now. Note I've not done a build
for drm-misc-fixes in a while and I'm on a laptop atm, so it will be a while
before this shows up as I'll do a (slow) test-build before pusing out the changes.

Regards,

Hans


