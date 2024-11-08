Return-Path: <linux-kernel+bounces-401738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F1B9C1E8A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D99428226D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC461EF95D;
	Fri,  8 Nov 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2o0MRoC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43BA1E0B66
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073878; cv=none; b=TVsDKtGVVmQ9YLDAPhRdfCqHiManVmgAjFApirfJTiBz6kifeZSo+bafSQHrpUNB494DTFEuXxceKg7G2kNGOy2xSADv9ACbsANe3Twq4fRunSawWHMJE/ktPPibr+N8fgib9JX7mz+t9thlPYAWu/Pnal0O5eXGuSxkJDUTcN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073878; c=relaxed/simple;
	bh=0+No9TeaVqWZdDEeyLikwXsEFWUICXtnYllaU8JMtuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PM9ZtqDbReHaX/60FPduQB+KYH8Xmp7HCbd4/+GL/M4XjLg7++EyTqoBWNe5xOS9yYVcsJlBpBaAuCeHLURbOeHXlSIqaf503wTMZqUrU8k48+AmPG9VBfrAZUL0uMKhp1FA8HRLlUkMKnEW/fqiTttQDtcgUTW5OupbZbbqPhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2o0MRoC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731073875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yp8SJubjIWH+oVfx1SD15EsWPj+A+X3WXtE5LpvL0uw=;
	b=E2o0MRoCefi8+QsoN01A2wP5HC+X6BLtFHbB/xclIC4xh8jo+l28man/LfURrqIK5pmb8r
	teLtBLqk7rp3MiyFOHSFZ0Bwpg1mmpT66dhQluaU3pteT8Xx93N0jzZ+4i9HJZA5EEEiDq
	/u1mjHiTijH+Sy76TaEdMIKaqiaOCek=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-Ih7499kHOoS_BbWf2su4hQ-1; Fri, 08 Nov 2024 08:51:14 -0500
X-MC-Unique: Ih7499kHOoS_BbWf2su4hQ-1
X-Mimecast-MFC-AGG-ID: Ih7499kHOoS_BbWf2su4hQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5606250aso996800f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 05:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731073873; x=1731678673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yp8SJubjIWH+oVfx1SD15EsWPj+A+X3WXtE5LpvL0uw=;
        b=q1ycielCXDoe0EEtZ+BhlXLKIcZQaH15XOpa91aKpedmpfmWSVWwCNloBWTtJiKFAi
         UWnuBlNXiS29w6ZWJ6YQyLpWBF55H0Y+CRiEgDYgDILY6ixjLR4G8QXjwGNi+OhuK8xh
         +XWCfZYuxw/2Tt3tX6XCn6/9TR6tkwuOXPAeywKkE1IUHNdu0ntZ4sOr0XmimYnGGoHS
         puGM8cSgyO6f4fm8lj04Z5CO9Twk/aR/jdMw7g4k44SKk9JoW4lh+/uVKGwZ+uV+umf/
         b1fed/nZkbsifd6Apsi/1LITf/U7V6Sx1sGQv4S74uJGlfQ+s/8EevdjpOMvaV+koBvV
         cRHA==
X-Forwarded-Encrypted: i=1; AJvYcCX3+vuLTMUN5zU5RUhLV+xn8b9Z4TTQh5BYNBumQZiM8cftBgRN3/Z3+x4abOOVKYmbVCA5wrhXbjpNGqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAZlj6i8zHXIA74iiIsbGCeWBlNXdC9onUK5IQoA8Nis9IGNei
	SqZ6E3r6n07Wov2ih7w6U+RUClW6fP10cF2bD6XES06myQwzHdWE7mXqYoZwxRGvhiryibrS5B+
	VKUNukKIh/Oq5qSSinAYEts0cYecu8ONPAasM9HQvXWgUgxr4oI+6ieA0bA4VHQ==
X-Received: by 2002:a05:6000:2c1:b0:37d:238:983 with SMTP id ffacd0b85a97d-381f186b4b2mr2561694f8f.22.1731073872694;
        Fri, 08 Nov 2024 05:51:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENvW2FgJtPvIKuRbi0KyPUG9rv/vqab1/mYic3C0qWXI0kyF7AfWRiOO2/18ksKytc9TWKvA==
X-Received: by 2002:a05:6000:2c1:b0:37d:238:983 with SMTP id ffacd0b85a97d-381f186b4b2mr2561662f8f.22.1731073872298;
        Fri, 08 Nov 2024 05:51:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda04111sm4903154f8f.92.2024.11.08.05.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 05:51:11 -0800 (PST)
Message-ID: <bb6f5ff1-71c1-4b1b-a618-7f72310598f2@redhat.com>
Date: Fri, 8 Nov 2024 14:51:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] drm/log: Do not draw if drm_master is taken
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, John Ogness <john.ogness@linutronix.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, Caleb Connolly <caleb.connolly@linaro.org>,
 Petr Mladek <pmladek@suse.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241108082025.1004653-1-jfalempe@redhat.com>
 <20241108082025.1004653-5-jfalempe@redhat.com>
 <5e19d9d4-7533-4a59-a665-cfc4a8195293@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <5e19d9d4-7533-4a59-a665-cfc4a8195293@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/11/2024 14:33, Thomas Zimmermann wrote:
> Hi
> 
> Am 08.11.24 um 09:10 schrieb Jocelyn Falempe:
>> When userspace takes drm_master, the drm_client buffer is no more
>> visible, so drm_log shouldn't waste CPU cycle to draw on it.
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>   drivers/gpu/drm/drm_log.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_log.c b/drivers/gpu/drm/drm_log.c
>> index 376ee173d99d9..226e206e8b6a3 100644
>> --- a/drivers/gpu/drm/drm_log.c
>> +++ b/drivers/gpu/drm/drm_log.c
>> @@ -18,6 +18,7 @@
>>   #include <drm/drm_print.h>
>>   #include "drm_draw.h"
>> +#include "drm_internal.h"
>>   #include "drm_log.h"
>>   MODULE_AUTHOR("Jocelyn Falempe");
>> @@ -308,8 +309,13 @@ static void drm_log_write_thread(struct console 
>> *con, struct nbcon_write_context
>>       if (!dlog->probed)
>>           drm_log_init_client(dlog);
>> -    for (i = 0; i < dlog->n_scanout; i++)
>> -        drm_log_draw_kmsg_record(&dlog->scanout[i], wctxt->outbuf, 
>> wctxt->len);
>> +    /* Check that we are still the master before drawing */
>> +    if (drm_master_internal_acquire(dlog->client.dev)) {
> 
> Just a note: it would be better to track this state in the client code 
> and handle these locks automatically. But it's ok for now. It would 
> require an overhaul of the fbdev helpers as well.
> 
>> +        drm_master_internal_release(dlog->client.dev);
> 
> Don't you have to release after drawing?

I'm not sure, the drawing code will only call 
drm_client_buffer_vmap_local() / unmap
and drm_client_framebuffer_flush(), and they don't require the master 
lock to be taken. I think master lock is needed only for modesetting.

Also the dlog->lock is taken by the console thread, so there are no race 
conditions with the drm_client callbacks (hotplug/suspend/resume).

> 
> Best regards
> Thomas
> 
> 
>> +
>> +        for (i = 0; i < dlog->n_scanout; i++)
>> +            drm_log_draw_kmsg_record(&dlog->scanout[i], wctxt- 
>> >outbuf, wctxt->len);
>> +    }
>>   }
>>   static void drm_log_lock(struct console *con, unsigned long *flags)
> 


