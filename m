Return-Path: <linux-kernel+bounces-442773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6FE9EE16B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E0C1883D93
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB59B20B80A;
	Thu, 12 Dec 2024 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtZyqFCn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0874E1FF1AA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733992612; cv=none; b=fYQVVFXEp31KdRp4OBTxBn5MFy/K9mgMxrsk46TTqK2wYfb5Fjl2fr8QWJ0OrPnW2cgQivh5wJOxDsT/VLGVMb36Wup4GaO/eI50cNpd3dMjtHWzhBi9SZz5QbRBlR/3pGqzv7yac8AXrRIZ1OFUyi+BmrVE1GYwDZsuyyRu+XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733992612; c=relaxed/simple;
	bh=+kgV+0ngERB7eKAc5xLbv6IyzQHxzAQBiZnuFvVzOdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Stvc85NYMllRCp7yaweq0e3aqEO/R0cDm1qcY/gKOxqm72U/TxkxiElt2Ic6D6s6ptioFPhOFStVPkR1/BIl2OXO0F0tWjuzOxNpF3InVQd7dMdWVjj9O2r8CdRKLjMmJuvR/1atVYCW7uUG2xS+aDviU8ECYgV2yTvGFv5ECQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtZyqFCn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733992608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b2OdCCLE8DIZKmdBcmfkMR6vuKRmVHnvlSP4k0Du3Rk=;
	b=TtZyqFCnCg+GL+0ejWPnWHIBKn1f5bhA46s/mMRyei6shqEmJS8t/xIhaA+d2sNe/gIMKL
	PaFu9CemYJcnKzXCA+jrvN4gB52AA67+masIDQizZsAFmn3Vu33VbrmikNGawCdhAyeXiN
	hWVjgRX9DZHdB9CwD5/KG2QCQ3A3fRo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-uCS1Xm9MMaSYH5VSwV7Pmg-1; Thu, 12 Dec 2024 03:36:47 -0500
X-MC-Unique: uCS1Xm9MMaSYH5VSwV7Pmg-1
X-Mimecast-MFC-AGG-ID: uCS1Xm9MMaSYH5VSwV7Pmg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-386321c8f4bso216875f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733992606; x=1734597406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2OdCCLE8DIZKmdBcmfkMR6vuKRmVHnvlSP4k0Du3Rk=;
        b=plhmU21XGzgl8VNy7NTptakva3pOMGJ3LkQiPKKTeikqdZlAzL0nmFJIiFkiSG3p/w
         HlSXLGatP21HodtShOSDKBaXHK+xeJedc8x2C2xBo8BY32JSl0c+fiNyqamKpAQY/l33
         DWB44pXpHym8C1Q0S/7rYsCefbNl6sE9vEc0+2qDzqNSOOVjiSU2slTtsJ8rY02lfJVe
         Z6KdSu79FOJp2TgIKWz4umizR4bqcjtXG9WbwmxC1U7zPTL02SDqH5cdZ/UZz8BowpiR
         NV0MOPsG2i03SO7TCkTT/x5BIzREQU9BfDriA0nL63TC5XUTeTmTr7niHpRBL/9IpBK8
         n11A==
X-Forwarded-Encrypted: i=1; AJvYcCWI0LvFdMlNqgAJes1z368PuChxCNWWfXhdsI3CPAZhPDnhf6ImmeEUzwxHp4QhBIEYuGeykHvkmr56Vf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhYftN3ZKDkpVE8gFr0MzdhYP2KXJaSRlIGVf3Ciyg50C1wdMd
	DkRYyq5dqWZWcXoZOT6rF7wlyTMrM29OO4M3GhNT+Bk+Jad87L6Oek/OL0NaE8hkXYmFbjpL4QK
	6sStzqxXHupVktKPQawPD3j7cPPoGqkolhQf+NEAx/sLTtNf3UAyQ6PjDZcAT4w==
X-Gm-Gg: ASbGncs+mUrSFJHrn39ZPKeCwlI/WGqjBq50iRF1ht/u9ynjvMZQy7Dadf89tBImKie
	6xr325LT3+OWG09QFBVM1KZT6ms2pEYgSxd1+eH6e0a52Qtjgwq0Iewo1MWNIonIr/aI51Le1eb
	qGDHX0RV7JTVTEUj24tHr3B5hTZNIqrDwFER/S8+ELLF+hBp0YJnQCJv4iwK3Z0qCdu/qxqXR79
	Jw8nH2Oynj0ePaeo3mTuAs5cW8aEpTWz01RVcKsH2XVsEl9Yx3dF9XMYsvKkOAYU+R9GmbMeaiH
	6RFIQ1V2B+pPMicFOF+r
X-Received: by 2002:a05:6000:1a86:b0:385:e4a7:df07 with SMTP id ffacd0b85a97d-3864cec38ddmr5207778f8f.42.1733992605823;
        Thu, 12 Dec 2024 00:36:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiOspl7lVtaRS3a8U1e3Ugidr/FeZNKHreAuxMq4nGy3oYE3I03+xyodQNvU8hH6BX6zGkHA==
X-Received: by 2002:a05:6000:1a86:b0:385:e4a7:df07 with SMTP id ffacd0b85a97d-3864cec38ddmr5207669f8f.42.1733992603982;
        Thu, 12 Dec 2024 00:36:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625553208sm9569375e9.9.2024.12.12.00.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 00:36:43 -0800 (PST)
Message-ID: <6e0f1727-6712-4c5e-8ca2-68ecf002deb0@redhat.com>
Date: Thu, 12 Dec 2024 09:36:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v9,1/6] drm/panic: Move drawing functions to drm_draw
To: Kees Bakker <kees@ijzerbout.nl>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 John Ogness <john.ogness@linutronix.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, Caleb Connolly <caleb.connolly@linaro.org>,
 Petr Mladek <pmladek@suse.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241204160014.1171469-2-jfalempe@redhat.com>
 <90c892fe-e56c-49b0-b8a3-8a7d6d18fb41@ijzerbout.nl>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <90c892fe-e56c-49b0-b8a3-8a7d6d18fb41@ijzerbout.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/12/2024 22:34, Kees Bakker wrote:
> Op 04-12-2024 om 16:45 schreef Jocelyn Falempe:
>> Move the color conversions, blit and fill functions to drm_draw.c,
>> so that they can be re-used by drm_log.
>> drm_draw is internal to the drm subsystem, and shouldn't be used by
>> gpu drivers.
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>
>> v5:
>>   * Export drm_draw symbols, so they can be used if drm_client_lib is 
>> built as module.
>>
>> v6:
>>   * rebase and solve conflict with "drm/panic: Add ABGR2101010 support"
>>
>> v9:
>>   * Rename drm_draw.h to drm_draw_internal.h (Jani Nikula)
>>
>>   drivers/gpu/drm/Kconfig             |   5 +
>>   drivers/gpu/drm/Makefile            |   1 +
>>   drivers/gpu/drm/drm_draw.c          | 233 +++++++++++++++++++++++++
>>   drivers/gpu/drm/drm_draw_internal.h |  56 ++++++
>>   drivers/gpu/drm/drm_panic.c         | 257 +++-------------------------
>>   5 files changed, 318 insertions(+), 234 deletions(-)
>>   create mode 100644 drivers/gpu/drm/drm_draw.c
>>   create mode 100644 drivers/gpu/drm/drm_draw_internal.h
>>
>> [...]
>> diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw.c
>> new file mode 100644
>> index 000000000000..cb2ad12bce57
>> --- /dev/null
>> +++ b/drivers/gpu/drm/drm_draw.c
>> @@ -0,0 +1,233 @@
>> +[...]
>> +void drm_draw_fill24(struct iosys_map *dmap, unsigned int dpitch,
>> +             unsigned int height, unsigned int width,
>> +             u16 color)
>> +{
>> +    unsigned int y, x;
>> +
>> +    for (y = 0; y < height; y++) {
>> +        for (x = 0; x < width; x++) {
>> +            unsigned int off = y * dpitch + x * 3;
>> +
>> +            /* write blue-green-red to output in little endianness */
>> +            iosys_map_wr(dmap, off, u8, (color & 0x000000FF) >> 0);
>> +            iosys_map_wr(dmap, off + 1, u8, (color & 0x0000FF00) >> 8);
>> +            iosys_map_wr(dmap, off + 2, u8, (color & 0x00FF0000) >> 16);
>> +        }
>> +    }
>> +}
>>
> u16 is not wide enough for a 24bit color

Good catch, I will send a fix when I get some time.

Best regards,

-- 

Jocelyn


