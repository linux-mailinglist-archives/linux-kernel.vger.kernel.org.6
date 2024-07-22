Return-Path: <linux-kernel+bounces-259207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B857B939299
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DC71281F72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FCF16E891;
	Mon, 22 Jul 2024 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEIKnSxa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA45926ACD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721666036; cv=none; b=vGGQtqrzOeYNHozAur6UqilbtmPo2WNoNuknHNhD8E5W5nyIJKA0Vi/PpR2X0afHQR9cO9kD5QMuoxg3mQPzuermjk3CQ6RnqUx+s50GwLSH6Hch164I3kcQbS2Qig86tfEfum5/WT+OTJkfQzOd6N8+m9grab12uUoUC/PpzIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721666036; c=relaxed/simple;
	bh=yscbY+rfuN9wztogv742zbbtnTV49CIZT14zFytCKLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUCD+Ft5PmrqSd6jmGH/gUBJ/J35FpeFwud4YreM274CXN6soExvapjZjHFemRhqC8xQ/4Uqxztt6e2uE33mrqlZvsDlRhTEBqdaiQ9oZD3EeS3Zr5Hk7vKyKz7dbqYYxP/jDH1qoeE2ZPzDukls5DXzdXRJdoCKHEbPwLLAwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IEIKnSxa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721666034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FsMiBIkevMqXBW2DcNPEnH7DY2ezXcbrlK8J00Zf6Qo=;
	b=IEIKnSxa+GX8QkfKN1WZIXeCTAYdS/VgADZrJSyqr08OAF93X1RjfUmHy5AQo1c/D1qRyB
	Fcx6fAhLxVQOVCtjNe2pe2+xREwabKGXhRIWm9Ov4gjgRQbPftLnejx+H0ia3O9gn9lh5f
	hbOJGc2NAxiBiXqkGPHV7I3mDTF/ovc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-2CjFuN6UPy-HZxB7-gh5og-1; Mon, 22 Jul 2024 12:33:52 -0400
X-MC-Unique: 2CjFuN6UPy-HZxB7-gh5og-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4272718b9b0so34041895e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721666031; x=1722270831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsMiBIkevMqXBW2DcNPEnH7DY2ezXcbrlK8J00Zf6Qo=;
        b=fWIj6RXqkTaOiuwUpFoF0IjWABYcgPQrFRCg4e2DzvJgVgksOnzoSnW2PiZAy3Htwq
         oU1xb/bzyYkJ0HnMAblkduAD20wI+lP2KNdrDXZip7qTdayp7Fi/7MLoYaoRj1oQRLWF
         2bxckpbfLS1bRd69RTjncYdzhBwaOR85x/q4RL7m393ey4tmrRQf35vkWzIVeohDCoFi
         JOMnAo2AzVgmt+HJO6hlY31spkYKtOUV8Du0Mc0AABcCYcjBQbhCXA9r+tpQAceNRhPM
         u0cjLcAi3vHUDqTKZHaoq2Me0f3/BI/BUsGGeMd2DE0xbb/IktLrI0OKOTghYWIIK/Io
         GO4w==
X-Forwarded-Encrypted: i=1; AJvYcCXb5XFg/Owz/PLWrhzS5/U4YwIGfETUCkzvgEq8ey5dQtw8WLh7Wy0NJJZQUem7PNwOJjhhOCwyLFNzVwoMI6WxhcHrjp50L+H6DRaK
X-Gm-Message-State: AOJu0YwyMSEfK2JPbzZEy5/DbQUMPIonQ5JeT0asRZTnQi0MjnLGpvk/
	5Y1Qi0bv2L4WYPz0bDrOU5s5ogdx8CmmNs9m+vhVFpCZ9pJFDj8U0fvbiAeOcs7qdnD8cwdKxkr
	olql38qHjY6SpSf8Wb/yHddI5juwhZLbh9qNMwJJ1ry+FdMx8pnivIg1kB5tTrA==
X-Received: by 2002:a05:600c:5249:b0:426:6710:223c with SMTP id 5b1f17b1804b1-427ecfdfbfdmr3456045e9.9.1721666031477;
        Mon, 22 Jul 2024 09:33:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhKPZMMgKyz4fSPYvf9iTPhG7gauOPL0vg5XbFth0P+eIWasAnvRYSb0MhB0GEllFAUXFdAQ==
X-Received: by 2002:a05:600c:5249:b0:426:6710:223c with SMTP id 5b1f17b1804b1-427ecfdfbfdmr3455885e9.9.1721666031086;
        Mon, 22 Jul 2024 09:33:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:d5:a000:d3ea:62cf:3052:fac6? ([2a01:e0a:d5:a000:d3ea:62cf:3052:fac6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e42bsm164383095e9.30.2024.07.22.09.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 09:33:50 -0700 (PDT)
Message-ID: <d7b13cc3-d7b7-4cf2-b08a-4228efe04f53@redhat.com>
Date: Mon, 22 Jul 2024 18:33:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: mtdoops: Fix kmsgdump parameter renaming.
To: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 DRI mailing list <dri-devel@lists.freedesktop.org>,
 Knop Ryszard <ryszard.knop@intel.com>
References: <20240719152542.1554440-1-jfalempe@redhat.com>
 <1868573045.102281.1721661681881.JavaMail.zimbra@nod.at>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <1868573045.102281.1721661681881.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22/07/2024 17:21, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Betreff: [PATCH] mtd: mtdoops: Fix kmsgdump parameter renaming.
> 
>> When the kmsg_dumper callback parameter changed, the reason variable
>> in mtdoops_do_dump() was not updated accordingly.
>> This breaks the build with mtdoops.
>>
>> Fixes: e1a261ba599e ("printk: Add a short description string to kmsg_dump()")
>> Reported-by: Knop Ryszard <ryszard.knop@intel.com>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>
>> The offended commit is in the drm-misc tree, because it was needed
>> by drm_panic. So I will push the fix there too.
>>
>> drivers/mtd/mtdoops.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
>> index 86d49db9196d..7bf3777e1f13 100644
>> --- a/drivers/mtd/mtdoops.c
>> +++ b/drivers/mtd/mtdoops.c
>> @@ -305,7 +305,7 @@ static void mtdoops_do_dump(struct kmsg_dumper *dumper,
>> 	struct kmsg_dump_iter iter;
>>
>> 	/* Only dump oopses if dump_oops is set */
>> -	if (reason == KMSG_DUMP_OOPS && !dump_oops)
>> +	if (detail->reason == KMSG_DUMP_OOPS && !dump_oops)
>> 		return;
>>
>> 	kmsg_dump_rewind(&iter);
>> @@ -317,7 +317,7 @@ static void mtdoops_do_dump(struct kmsg_dumper *dumper,
>> 			     record_size - sizeof(struct mtdoops_hdr), NULL);
>> 	clear_bit(0, &cxt->oops_buf_busy);
>>
>> -	if (reason != KMSG_DUMP_OOPS) {
>> +	if (detail->reason != KMSG_DUMP_OOPS) {
> 
> Acked-by: Richard Weinberger <richard@nod.at>

I pushed it to drm-misc-next.

Thanks a lot.

> 
> Thanks,
> //richard
> 


