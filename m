Return-Path: <linux-kernel+bounces-510990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64645A32494
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4533F3AA3EB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6B920A5EB;
	Wed, 12 Feb 2025 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxnaPZ2H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B8C208995
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358859; cv=none; b=iG/Okd/T7p+8j4wcrBaMB4KFP6PMT05xzu535VdG1ry8ABNAF63/K/Kr/01QypvLLIh2GxiggZivMYWWU5QkS1XmbTtiJB9Tj0TR9xAGhUV81tf9Dxt1D5ZeeGh7FrwLnc53LIEFGkYYp6Ec7MHYacLSD/VyaB4DpY3Xe3qrDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358859; c=relaxed/simple;
	bh=qzJB8QGxWN4b43jguU15ZL4cd/v1HUq4ueI1j9yZorQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qoa2dZQ2Q81OwKolXx+dmxr2BMjhuDYuGFQptXc2vSXGnRq1fHTPAPm5JXMIFgiMjL6FsBh/KwoBX6qCusDDyjERfrP5hMclPmr0hv2BmRmZ7Ig6tG6f1Ff5bvFkqmdyJm3e7eG3gpsrJMy1m/OEdm16WwGuvSL61JevG12ytKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxnaPZ2H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739358856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CdmEC7WTpRZKbkzzTKfU8sOnmJXvCIvbDDplNyC0I14=;
	b=RxnaPZ2H8yCMpBL/EPsu3qVEjEm44p4UjYIcILTVC422QWywHByZhtV+cGZfOBDaD8GghE
	cAh/Jnu2yQSNVh5/d++uvqtcQ9yfJDjwoW8xOnJRBGZfYDn0fjpfvzBCBVzuiIOl9aLbbb
	gcAiMZmD3MSBvgdMujAbwvJLFNCArEc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-OZD8rbltPfSi1Bux-8GYrQ-1; Wed, 12 Feb 2025 06:14:15 -0500
X-MC-Unique: OZD8rbltPfSi1Bux-8GYrQ-1
X-Mimecast-MFC-AGG-ID: OZD8rbltPfSi1Bux-8GYrQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ab77e03f2c0so547309266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739358854; x=1739963654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdmEC7WTpRZKbkzzTKfU8sOnmJXvCIvbDDplNyC0I14=;
        b=hYDgAKpQUh/SlfI+05aD3fLvttm6behkDt58youKMD0gknb+7K4tAmfHVcL22nGywQ
         3zstG6ORaFo+hdqcCSeH82/+JEuvyCtFv1JAI8iq0rpTx059n4R7WwQUo6/1Q3v0RyGG
         hPGGRTfgpnWj0ll0R6wrmZhl1ViOcgRNSI6APHW3apAbZqBZWxBeouia0OfNAfsDSVl2
         h0gpyODh8bbadUkNsH4nCc1ghK9358fzTUk5qxlM3M4ocpHvQQx3wy83poQTAjGHeX09
         ifXcQhtM1CZ1whzyyXMWWAv62EhWwUYK7bU46y4lNGu2dz0nFzHFezp4EKKEK8w2JUkc
         +bDg==
X-Forwarded-Encrypted: i=1; AJvYcCUxnixGd7Jm0e0v8WjmfF8/NQb+yWWOl+v69Z+0WUyA6AH0/Notj916iHUyS54wE9jV7sXLMP2nepnpNUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh3dLIdiDkF2rnby6zlqj/4U8uq+ofVFenFF8fMLDIDkT2c3t1
	VmWAZE4vQRLqnhXiL+aQAkYNbh883OUbuV/ylr09BqTMq6LbOqzx44HT+AcoDrx/tgx+aCoSOKS
	vPE368qNKWHhBLw4rs3zFEPjV0HcS7wBRTBpbiaPdoIBA0WblWG5/wjmH0QKqdA==
X-Gm-Gg: ASbGncvo43UUn4uYKH5MQg90HF49d59aoSrtGJXDgLF7LX4C/tB/rSYA2FSvvT26CFC
	CPexfw+tdGCWBbzDsqmGr77nINWkXTaVCsFzhi4e86Ad8PqezlZQbYDdjL/lEEXUfcci2hXvVy9
	JS6PSrnLM/czrdkwtEo/Dm+ldO3BGMUVWDNCTBJ7zPHNT0CIlVK6I1/Ee7e1/7vNDiBkvL04gHK
	FtvYNMqO+oIY/95PgWqP8okwlqfmtWxVVMmG7vW+S4tApj5BWOnU3pM4lNPADv7ndUV1+Yv0aC3
	jOelGNa53PQEAr3h5sH2YfpqML/QrAWdUk+c3Bgd+zyjZdBZkeGsxfc1ErqrR5Tjs2qRp3Jo4jv
	uId9I2YX/Acbpfl0FqdIzpVCQ4KM11c9udHfPPNkL4E3iJWyfET6RLj0=
X-Received: by 2002:a17:906:c109:b0:ab7:5a5f:113 with SMTP id a640c23a62f3a-ab7f33bdba1mr213789866b.23.1739358853993;
        Wed, 12 Feb 2025 03:14:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMykeARXPTVdNGJOlHWMvQ5H96eJcBP9W/uhbsF+jMaq3D1UX4G2MfdgOaNU4it0Ck0kMAdQ==
X-Received: by 2002:a17:906:c109:b0:ab7:5a5f:113 with SMTP id a640c23a62f3a-ab7f33bdba1mr213787066b.23.1739358853506;
        Wed, 12 Feb 2025 03:14:13 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7f6064185sm106724966b.175.2025.02.12.03.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 03:14:12 -0800 (PST)
Message-ID: <e64c6778-9698-4970-a3c3-af3aabc232be@redhat.com>
Date: Wed, 12 Feb 2025 12:14:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Handheld gaming PC panel orientation quirks
To: Thomas Zimmermann <tzimmermann@suse.de>, John Edwards <uejji@uejji.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Andrew Wyatt <fewtarius@steamfork.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250124204648.56989-2-uejji@uejji.net>
 <b3caa748-2dbd-4911-968f-878fcd118a9b@suse.de>
 <6abc98bd-5ef9-491e-985b-7ed8a848c96e@redhat.com>
 <f0185bb4-4f43-4ae1-8f81-ec4185160a5b@suse.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <f0185bb4-4f43-4ae1-8f81-ec4185160a5b@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 12-Feb-25 12:11 PM, Thomas Zimmermann wrote:
> Hi
> 
> Am 12.02.25 um 11:51 schrieb Hans de Goede:
>> Hi Thomas,
>>
>> On 11-Feb-25 2:55 PM, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 24.01.25 um 21:46 schrieb John Edwards:
>>>> Hello.
>>>>
>>>> I am submitting a small number of patches to add panel rotation quirks for
>>>> a few handheld gaming PCs.  These patches were created by the SteamFork
>>>> team and are in daily use by us and/or members of our community.
>>>>
>>>> The following devices are covered by these patches:
>>>> 1: AYANEO 2S
>>>> 2: AYANEO Flip DS, AYANEO Flip KB
>>>> 3: AYANEO Slide, Antec Core HS
>>>> 4: GPD Win 2 (with correct DMI strings)
>>>> 5: OneXPlayer Mini (Intel)
>>>>
>>>> Thank you for your consideration and for taking the time to review these
>>>> patches.
>>> Did you ever receive any response to this series? If not, then
>>>
>>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> I had the following remark for 3 new entries added in patches 2/5 + 3/5:
>>
>> "Since this '}' is closing the .matches initializer it should be indented 2 tabs"
>>
>> With that fixed, you can add my:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> to the entire series.
>>
>>> for the series. Let me know if you need assistance for getting the patch files merged.
>> Normally I pickup/merge these panel orientation quirks, but I've been swamped
>> which is why these have just been sitting on the list.
>>
>> Thomas, I would appreciate it if you can merge the set into drm-misc-fixes, with
>> the 3 minor indentation issues fixed.
> 
> Sure, no problem. I'll wait for John to provide an update. Otherwise, I'll fix it myself while merging the series.

Great thank you.

Note in the review comments I said that we could likely fixup the indentation
issues while merging. If you prefer a new version from John that is fine too,
but we need to make clear to John what we want :)

Regards,

Hans




>>>> v2:
>>>> - Minor rewording of commit messages
>>>> - Include Tested-by tag for Paco Avelar in AYANEO Flip DS/KB patch
>>>> - Add OneXPlayer Mini (Intel) patch
>>>>
>>>> v1:
>>>> https://lore.kernel.org/dri-devel/20250116155049.39647-2-uejji@uejji.net/
>>>>
>>>> Andrew Wyatt (5):
>>>>     drm: panel-orientation-quirks: Add support for AYANEO 2S
>>>>     drm: panel-orientation-quirks: Add quirks for AYA NEO Flip DS and KB
>>>>     drm: panel-orientation-quirks: Add quirk for AYA NEO Slide
>>>>     drm: panel-orientation-quirks: Add new quirk for GPD Win 2
>>>>     drm: panel-orientation-quirks: Add quirk for OneXPlayer Mini (Intel)
>>>>
>>>>    .../gpu/drm/drm_panel_orientation_quirks.c    | 40 ++++++++++++++++++-
>>>>    1 file changed, 38 insertions(+), 2 deletions(-)
>>>>
> 


