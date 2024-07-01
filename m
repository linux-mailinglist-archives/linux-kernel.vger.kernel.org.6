Return-Path: <linux-kernel+bounces-235832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 252C591DA44
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DB41F220CF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6A982C8E;
	Mon,  1 Jul 2024 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2XRG4kQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737178289C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823363; cv=none; b=Olq5Bh1zPk6Gg9wFtZoAW1iHWxWt1Jh+P9+YFI1Ilpz7dpHTbRZmXFnLET6veA/CxpXU45wBZPo7I2Ri5Wq3066g5xrlPTH+F/OjbXR6YFDVrMZG+UnH+ECAPnc1B0dTfgEVhaeWymByDOPFaxSIYZzL9fLtxV8VxiOO4yKyybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823363; c=relaxed/simple;
	bh=NpiXlbSwPu+BTnwxhJbS6daeBA4WC/kTdDXQzs1obrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8+tqdC4KNndYWpSz9X1T7EYzy+f5XDg/2TB5p+iwwlK6bSIv8hRGMI73en+2PZGLdUoDut8QzffVQMTU3J4LidPmLgw0LJFeLfjx4Yx3aTU+uAftMXFkctR5p31rAn9zLVJIdJSeCx3R8tsfsEbmG2N0a3GJeDmm2eYxknsmL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2XRG4kQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719823360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wxBMcfQawTvepZ9isb1t5DiSkHYBb8+hVQTKzwn+1QM=;
	b=a2XRG4kQQcZdRVFDNxEwyq0oHq2V0OGE2ZcLyQWiUPqNlti1dXflLkCS3VKfw9NaNW9dAc
	qAqzCWdBtgn99VTlmQgmwUBYg7ov+vyPuNfVkqbIgD/zkd3QJCVDxYDUO5FHp2MebwCCP5
	XRXNZWDg+9N9c4JN8vadXQhQ49cIYZM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-EPTxZJ_cMZKq8GvjTgPokg-1; Mon, 01 Jul 2024 04:42:34 -0400
X-MC-Unique: EPTxZJ_cMZKq8GvjTgPokg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52e765bc03bso2716188e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823352; x=1720428152;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxBMcfQawTvepZ9isb1t5DiSkHYBb8+hVQTKzwn+1QM=;
        b=TODFtjOgzZLrx5GOuc2QT67kS3/BB9Egy0nMKvz800DBofaa45qb4/RlKbIQtXjqbb
         EvwsAGAkEnn3sRjS66eupda49edMF9Atwdq1vTqREVWOBKyw58UPLygzCm/ARKYtlUui
         QS9OrjyNNIrTM1LslAiD1rynLWH+zvTmoYkcrzTs1jZv3D2w3/IptgWiKYw7NzvXyv2k
         srwdCO1nPtaKySk0OHkVCxQdgkV/eCSm3j8WBpo09aSwcdAk/wV2kAWzS8DzuLvwH0Z7
         DgNSNv4I51YxP41hY6nqQP8P/WBOORx0YUtAn3Mu6R5jCEYzFw31Up4LT0he1fptuwK8
         WmEw==
X-Gm-Message-State: AOJu0YznFMbEjpHZEJDSo6ANmwjsrzWUj/SjxE940TeOmGlUFgHLO1TK
	VctOCYVPyJLOuE2OPVfE33ponzix8+hJtnAd/5wqT/gPMnwRtQutcz9kMQLokJ0NhzbQPvq+a6A
	otra5oWNKuAY2VJU6f90HGkx1zfYWRkeBjow0rr//T9YXovHOukEqZuoAkXpcsThnDigmmw==
X-Received: by 2002:a05:6512:acc:b0:52c:e180:4eac with SMTP id 2adb3069b0e04-52e8264bbd4mr3400272e87.9.1719823352561;
        Mon, 01 Jul 2024 01:42:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ7z12uNVwePurswH5jms5DvCy+bmF02fq4bpiz+pG8MwWiV4jXX3a02TcCzZpGLu9O29TFw==
X-Received: by 2002:a05:6512:acc:b0:52c:e180:4eac with SMTP id 2adb3069b0e04-52e8264bbd4mr3400249e87.9.1719823352167;
        Mon, 01 Jul 2024 01:42:32 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-177-66.web.vodafone.de. [109.43.177.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257d9c7f18sm55855185e9.40.2024.07.01.01.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 01:42:31 -0700 (PDT)
Message-ID: <2108ac92-e241-4507-a759-c23de90d041e@redhat.com>
Date: Mon, 1 Jul 2024 10:42:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fbdev-generic: Fix framebuffer on big endian devices
To: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org,
 Javier Martinez Canillas <javierm@redhat.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
References: <20240627173530.460615-1-thuth@redhat.com>
 <571556ed-17d2-4bcc-bb1f-fd4f827829c6@suse.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <571556ed-17d2-4bcc-bb1f-fd4f827829c6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/06/2024 08.07, Thomas Zimmermann wrote:
> Hi
> 
> Am 27.06.24 um 19:35 schrieb Thomas Huth:
>> Starting with kernel 6.7, the framebuffer text console is not working
>> anymore with the virtio-gpu device on s390x hosts. Such big endian fb
>> devices are usinga different pixel ordering than little endian devices,
>> e.g. DRM_FORMAT_BGRX8888 instead of DRM_FORMAT_XRGB8888.
>>
>> This used to work fine as long as drm_client_buffer_addfb() was still
>> calling drm_mode_addfb() which called drm_driver_legacy_fb_format()
>> internally to get the right format. But drm_client_buffer_addfb() has
>> recently been reworked to call drm_mode_addfb2() instead with the
>> format value that has been passed to it as a parameter (see commit
>> 6ae2ff23aa43 ("drm/client: Convert drm_client_buffer_addfb() to 
>> drm_mode_addfb2()").
>>
>> That format parameter is determined in drm_fbdev_generic_helper_fb_probe()
>> via the drm_mode_legacy_fb_format() function - which only generates
>> formats suitable for little endian devices. So to fix this issue
>> switch to drm_driver_legacy_fb_format() here instead to take the
>> device endianness into consideration.
>>
>> Fixes: 6ae2ff23aa43 ("drm/client: Convert drm_client_buffer_addfb() to 
>> drm_mode_addfb2()")
>> Closes: https://issues.redhat.com/browse/RHEL-45158
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> 
>> ---
>>   drivers/gpu/drm/drm_fbdev_generic.c | 3 ++-
> 
> This file is now called drm_fbdev_ttm.c in drm-misc-next.

Oh, ok, shall I send a v2 that is adjusted to that change, or can it be 
fixed while applying my patch?

> And a similar patch might be necessary for drm_fbdev_dma.c.

Looks similar, indeed. Shall I send a patch for that one, too? ... I 
currently don't have a setup for testing that, though...

  Thomas


> The code in drm_fbdev_shmem.c 
> apparently has it already.
> 
> Best regards
> Thomas
> 
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_fbdev_generic.c 
>> b/drivers/gpu/drm/drm_fbdev_generic.c
>> index 97e579c33d84..1e200d815e1a 100644
>> --- a/drivers/gpu/drm/drm_fbdev_generic.c
>> +++ b/drivers/gpu/drm/drm_fbdev_generic.c
>> @@ -84,7 +84,8 @@ static int drm_fbdev_generic_helper_fb_probe(struct 
>> drm_fb_helper *fb_helper,
>>               sizes->surface_width, sizes->surface_height,
>>               sizes->surface_bpp);
>> -    format = drm_mode_legacy_fb_format(sizes->surface_bpp, 
>> sizes->surface_depth);
>> +    format = drm_driver_legacy_fb_format(dev, sizes->surface_bpp,
>> +                         sizes->surface_depth);
>>       buffer = drm_client_framebuffer_create(client, sizes->surface_width,
>>                              sizes->surface_height, format);
>>       if (IS_ERR(buffer))
> 


