Return-Path: <linux-kernel+bounces-391273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2189B84A3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2A81C2148B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781B41C8FA8;
	Thu, 31 Oct 2024 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="Li1mnk25"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3590B1411EE
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730407826; cv=none; b=Fb3M0tWDzZzDlxcp8ZomL6meCy5MbRmUh+PBKW/bGDEdAjtjPj5n/4Fk6S38ipLLkiJF694zOtTM3iplGd7K3HxQedTePe1TIifeICEQx/IVQs0/GQujI6D82s6SE+z5smjIuKuHug4r8JVmDIusmgub/U0rZY08IBkI+CMFZm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730407826; c=relaxed/simple;
	bh=vvsQ+eTEIX0rfJrqt0NaAWjnCaUCVsS6+UV5xDxiDTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOcA9Rrt+beR4E1/w3ZP4J7t3HqJmdaxdUkLwjBx8lESAXSOzR8K2nwsHHlELgPy+37vuXEMaco1Qp9CeAOrG9noPx1wt9WIDj6rZD0f+jDs0Iz48pOQmT3bUqALy7JQdkKHfRAoPOnE76oefC/5N8YcmfwZ1A1D/5GGw4A4ER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=Li1mnk25; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so12123425e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1730407817; x=1731012617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bw5E/KRCdHkbAWHdLK4V3a1ff0D3uJNNEH7nWj1aLMU=;
        b=Li1mnk25F9E4c1Cvp63S4zUkCwpJ74u311+/2tkwATQ0OoeCnJ55SNzFCH2usIQ9Er
         Mp55VK1kzpMlbU69xyWt4VulfsXeayyole+iJwFBHNO49THbdlFGTZQ+GAgpm+k/OjXJ
         FL70rKfMc+xqw4s66IvaOblhuVb1YmZK1nNE/LqUheewode6IoYEuO3gqR/5MNGZHsLr
         XkqAb/MBUt2zBFGEZY91GQC4lykgqAlNFfnlcaH+28He8gI5/5p12DyAbgiaJi3uXA0a
         4Oh+CY7tKS8zOK8wCY1JGgkrJ06RCNI/FAOpeQF4XKXc6B2JOZh9/mIcYZT+h2gIeO0I
         vAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730407817; x=1731012617;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bw5E/KRCdHkbAWHdLK4V3a1ff0D3uJNNEH7nWj1aLMU=;
        b=ajSyO1ce72iQhkuYF82s3vNrEKavRoIlJtleI4TgSE6a7HsDOnpQ2J74ST5fOdIfJe
         6p3M9qYkueDnpqyMKfizAXggfU3mXjXrSmgWMPNkhD6ubSLkUAA8F0HwxSu3NYn9JowS
         rwkhpjTm2Ify3Io2rP+8nV8DD+7vYqiEyl3uTGPWrmt5wJQuSkwpu70A+wNiPAuR2fA5
         qB6zG/cg41pFmz5wm9YKoGQyGhWrRxmVBILkbB7iAaArs7bK9UnOsIEXUcXqe+JzN9kE
         YeC9yAqEUAACiX1NWOpOD59hz6a0dr25YpDV2FfVnuuJFFmRAUgtb+pZ2bbUx45XLLD1
         JavQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1Y2BtKn93BRKBpJNJI3zZTXhtFDQX27PUZLDGKM8lFkO0oCP5T86Z97WCwbJHRzLo310R0oZm7jhjyx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw48KFdg5A/2GLKFUYLH8aeKQUnPoLKusZ8Bjr1Lv2zE2LPZi6O
	weE9OiFbk+zEpg6ukvEkTeSvXzmrYRVZ+3Qr9O22u40uegdw1GvqQlgkOfQ5LeMeWIAiWlQPo1j
	g
X-Google-Smtp-Source: AGHT+IFJf4Ul+62BnxQ2eJNGCbrmvPuv0OuD2YyiaLm8VqwUGEtl+XHwm3TI3xThkWHpVZs762iwJw==
X-Received: by 2002:a05:600c:1396:b0:430:582f:3a9d with SMTP id 5b1f17b1804b1-4327b80d1a9mr45198245e9.26.1730407817378;
        Thu, 31 Oct 2024 13:50:17 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:56a2:399b:490:2ad? ([2001:67c:2fbc:1:56a2:399b:490:2ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5ac387sm39945825e9.1.2024.10.31.13.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 13:50:16 -0700 (PDT)
Message-ID: <34c84c6a-9b0d-4d04-9ce3-edf1bb850b2c@mandelbit.com>
Date: Thu, 31 Oct 2024 21:50:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] amdgpu: prevent NULL pointer dereference if ATIF is
 not supported
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Xinhui.Pan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241031152848.4716-1-antonio@mandelbit.com>
 <00e9b1f0-7bc1-418c-8e67-e8f1893be665@amd.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Autocrypt: addr=antonio@mandelbit.com; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSlBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BtYW5kZWxiaXQuY29tPsLBrQQTAQgAVwIbAwULCQgHAwUVCgkI
 CwUWAgMBAAIeAQIXgAUJFZDZMhYhBMq9oSggF8JnIZiFx0jwzLaPWdFMBQJhFSq4GBhoa3Bz
 Oi8va2V5cy5vcGVucGdwLm9yZwAKCRBI8My2j1nRTC6+EACi9cdzbzfIaLxGfn/anoQyiK8r
 FMgjYmWMSMukJMe0OA+v2+/VTX1Zy8fRwhjniFfiypMjtm08spZpLGZpzTQJ2i07jsAZ+0Kv
 ybRYBVovJQJeUmlkusY3H4dgodrK8RJ5XK0ukabQlRCe2gbMja3ec/p1sk26z25O/UclB2ti
 YAKnd/KtD9hoJZsq+sZFvPAhPEeMAxLdhRZRNGib82lU0iiQO+Bbox2+Xnh1+zQypxF6/q7n
 y5KH/Oa3ruCxo57sc+NDkFC2Q+N4IuMbvtJSpL1j6jRc66K9nwZPO4coffgacjwaD4jX2kAp
 saRdxTTr8npc1MkZ4N1Z+vJu6SQWVqKqQ6as03pB/FwLZIiU5Mut5RlDAcqXxFHsium+PKl3
 UDL1CowLL1/2Sl4NVDJAXSVv7BY51j5HiMuSLnI/+99OeLwoD5j4dnxyUXcTu0h3D8VRlYvz
 iqg+XY2sFugOouX5UaM00eR3Iw0xzi8SiWYXl2pfeNOwCsl4fy6RmZsoAc/SoU6/mvk82OgN
 ABHQRWuMOeJabpNyEzA6JISgeIrYWXnn1/KByd+QUIpLJOehSd0o2SSLTHyW4TOq0pJJrz03
 oRIe7kuJi8K2igJrfgWxN45ctdxTaNW1S6X1P5AKTs9DlP81ZiUYV9QkZkSS7gxpwvP7CCKF
 n11s24uF1c7ATQRmaEkXAQgA4BaIiPURiRuKTFdJI/cBrOQj5j8gLN0UOaJdetid/+ZgTM5E
 HQq+o1FA50vKNsso9DBKNgS3W6rApoPUtEtsDsWmS0BKEMrjIiWOTGG8Mjyx6Z9DlYT/UmP8
 j9BT7hVeGR3pS++nJC38uJa/IB+8TE8S+GIyeyDbORBsFD8zg2ztyTTNDgFMBXNb8aqhPbPT
 eaCnUWHGR/Mcwo9DoiYSm5jlxlNDCsFSBaJ/ofMK1AkvsilrZ8WcNogdB6IkbRFeX+D3HdiX
 BYazE4WulZayHoYjQyjZbaeSKcQi2zjz7A0MEIxwyU5oxinIAjt9PnOIO4bYIEDTrRlPuqp2
 XptpdQARAQABwsF8BBgBCAAmFiEEyr2hKCAXwmchmIXHSPDMto9Z0UwFAmZoSRcCGwwFCQHh
 M4AACgkQSPDMto9Z0UxtFQ//S3kWuMXwpjq4JThPHTb01goM33MmvQJXBIaw18LxZaicqzrp
 ATWl3rEFWgHO7kicVFZrZ53p3q8HDYFokcLRoyDeLDAFsSA+fgnHz1B9zMUwm8Wb4w1zYMsO
 uo3NpBKoHNDlK9SPGHyVD6KoCGLQw+/h7ZhtcPRE7I74hNGBBVkFVeg+bggkZhaCZWbE/fih
 RCEEzuKl8JVtw4VTk4+F33+OfUEIfOKv7+LR9jZn9p7ExgfBdQyFr+K2+wEcZwgRgqTs8v0U
 R+zCVur69agK1RNRzQCMOAHvoBxRXHEm3HGnK8RL1oXFYPtBz52cYmd/FUkjTNs3Zvft9fXf
 wF/bs24qmiS/SwGc0S2wPtNjiAHPhCG9E1IGWLQTlsZRuQzfWuHgjPbVCTRwLBH0P+/BBWyA
 +8aKhGqG8Va0uwS3/EqiU6ZRYD+M/SnzCdD7eNjpr8Mn6jkudUXMWpsrd9KiMpt+vdtjfeJl
 NKMNf0DgFyiFHKqGek1jIcvfqBo6c2c5z65cUJ2hCQjnfWFePMixWzY6V9G5+4OtbAC/56ba
 45MGdFf2cXH2Q9I7jZOQUrnkOvkQN4E7e/fet5yxy4HxVU3nG+HQZXntCt772wmsSrsSz1br
 T1r4zTJElYkSMWcxr+OwZn5DIsPlBMvpIa5n2AojdbVJ8Vk7NXuEezE9Nno=
Organization: Mandelbit SRL
In-Reply-To: <00e9b1f0-7bc1-418c-8e67-e8f1893be665@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/10/2024 20:37, Mario Limonciello wrote:
> On 10/31/2024 10:28, Antonio Quartulli wrote:
>> acpi_evaluate_object() may return AE_NOT_FOUND (failure), which
>> would result in dereferencing buffer.pointer (obj) while being NULL.
>>
>> Although this case may be unrealistic for the current code, it is
>> still better to protect against possible bugs.
>>
>> Bail out also when status is AE_NOT_FOUND.
>>
>> This fixes 1 FORWARD_NULL issue reported by Coverity
>> Report: CID 1600951:  Null pointer dereferences  (FORWARD_NULL)
>>
>> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> 
> Can you please dig up the right Fixes: tag?

Fixes: c9b7c809b89f ("drm/amd: Guard against bad data for ATIF ACPI method")

Your commit :)

Should I send v3 with the Fixes tag in it?

Interestingly, this pattern of checking for AE_NOT_FOUND is shared by 
other functions, however, they don't try to dereference the pointer to 
the buffer before the return statement (which caused the Coverity report).
It's the caller that checks if the return value is NULL or not.

For this function it was the same, until you added this extra check on 
obj->type, without checking if obj was NULL or not.

If we want to keep the original pattern and continue checking for 
AE_NOT_FOUND, we could rather do:

-       if (obj->type != ACPI_TYPE_BUFFER) {
+       if (obj && obj->type != ACPI_TYPE_BUFFER) {

But this feel more like "bike shed color picking" than anything else :)
Anyway, up to you Mario, I am open to change the patch again if the 
latter pattern is more preferable.

Regards,

> 
> Besides that, LGTM.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/ 
>> drm/amd/amdgpu/amdgpu_acpi.c
>> index cce85389427f..b8d4e07d2043 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> @@ -172,8 +172,8 @@ static union acpi_object *amdgpu_atif_call(struct 
>> amdgpu_atif *atif,
>>                         &buffer);
>>       obj = (union acpi_object *)buffer.pointer;
>> -    /* Fail if calling the method fails and ATIF is supported */
>> -    if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
>> +    /* Fail if calling the method fails */
>> +    if (ACPI_FAILURE(status)) {
>>           DRM_DEBUG_DRIVER("failed to evaluate ATIF got %s\n",
>>                    acpi_format_exception(status));
>>           kfree(obj);
> 

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com


