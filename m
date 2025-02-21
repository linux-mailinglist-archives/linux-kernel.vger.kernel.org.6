Return-Path: <linux-kernel+bounces-526617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4557BA40105
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F047019F7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC49F253358;
	Fri, 21 Feb 2025 20:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="N5MfwPaM"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908E4207F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 20:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169994; cv=none; b=dtt40YuAaLxR0gslxMzXRQ3hf2oe9y7jmNfX+TBtOH2o3SBJ/f7JvWi0uo8Fi7UTnHv5i52Y+TMjSIzyTm3zCYptwGRN9bMeGE3nxHFGfMqoIyyhuhw1L5R2AXi4B+vMq2I1szfsp30GjQbgLlYEFie2jOxJo+FkRGR4uCepiAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169994; c=relaxed/simple;
	bh=HV1/qvjRpqlQskal+20g+fl4AKeeNVnKzMW/aAF5sYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xxf6Ea7olMEAb7MUCr3gw4denyGCs9iONV1096Hjz/Kz9vqfw9Lp9A6meVbdTBSUpOFfL94EJKopRjvDQ/uTFZBArr2IMtfLRVfv1bfYFqf6eo6g2P7skVPbe9mSHPHXtBdvCU7o7gWnnnN5b8OkVnxABOFrERWU4CWOk9ZYQSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=N5MfwPaM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f406e9f80so2268705f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1740169991; x=1740774791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dmGA1hr+frMZBLC4GUTcWtS/D8D1WkVOYrGRa76QtDk=;
        b=N5MfwPaMsu5+UPjdplLQU+UVgpx23sQxBVogdMT5V+GERoSJPmPWjqpoVDNVPftfgI
         psDALjzMNXryoDA1wjWZ4GU4hALEyOhTYWpT+HgiWzc7YR/n0j7CP9o5wfL4mgUIMoR8
         TxL7FY8SWjayyYitcNzqlE/N04b7qQTtPyq3QgEdPilSnee3MZXVMzKce7b0+Li/ldDq
         Y2W8PVKqWrs+7Fntb7KCZGwnZIaXhjxVNtb9cUt0SLtAF9xMcB2hxQhxQ8bK3l0CaytW
         /C4JyP2Jv0SRpxE/DQqc+yUFHn1tKhBDmDikJq7FSWRk090sCedjua3prWOx+fpHOdUR
         ajyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740169991; x=1740774791;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmGA1hr+frMZBLC4GUTcWtS/D8D1WkVOYrGRa76QtDk=;
        b=KqGN95d/dYUqIPYOTxHDtFov3Uma4+km79XDjGFLRpTZN8Bf2VcZ+MyNHeflD+2dzc
         IsfIu92beHEiQ2kIFbw358bnC1ee+6+nBYVNffVrn57dP3jIWRz6N8/rNiXUsnOgQA3J
         oOZotVJfzLHfJvMMlwHZxqxHCFurh+ZI/2aF+IVZqlPg1+LxcO00oyE6pum3oyJOHDhK
         3O93odzIKf0E0rjK60CB8sTrEK0QAjKYQK4rG8AKELXaDJ7p0LygZYRBsyf7iNbpoljt
         0CWYWi2xcdRHNv/Br/70YOHWLQ3bZS08VU3v4etkvdYXMtTSkOJf+JvQWHiUUS6Iac7M
         L/FA==
X-Gm-Message-State: AOJu0YxWY/i3nS3dJSOfpJzYGxT6qgwbIGT2s8cIzHFO31zYSj7SWzw8
	AltBxYOZ0pZ/H4yDEphT4ZWwssrFzYDbYOchOAs7bssyT+mnrPvWG20UN0IiQhw=
X-Gm-Gg: ASbGnctdFD2r695YzjuBDe+P3CTsfTybCtJWkLWDe0CnyCp8RP1PKs2n8h2haqvub2e
	raKsjIZTt/R1obNBFh5Dl6eOmI1ohb3FZQ/yzEVR2aFfAIdFOpG0OZGa0n/76oPy/83TO9oZTWv
	bU9JMYzgTmwmwIsfbz7GNJfVE+UEFRlosPekWQ7irDTGnv+As4LLCzOHTKHAwLURJIE5xYcZ23F
	I1TQ08/m1OgszSs6q5M5ZzCHzGLk59ZZOoGk873LLjUwVgib3OOCO79NX46F/IegaJ9Nncsh5CL
	JYI1SQgV0+ib3O2qXdQzKuVVFyg8xf2A67t/LATGA4FkJBjxc7cLYPExKL5+l9Y+eUk=
X-Google-Smtp-Source: AGHT+IFSbsh9CqdtQC5L41mFgB1ivLevuDk5yaMx/kNzzefpfHL64v0pMJwZ3DucrDs2P5mPNUFhwA==
X-Received: by 2002:a05:6000:156b:b0:38f:2a82:4427 with SMTP id ffacd0b85a97d-38f6e95fe69mr3971928f8f.20.1740169990488;
        Fri, 21 Feb 2025 12:33:10 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:13a9:f3c7:539a:f1c8? ([2001:67c:2fbc:1:13a9:f3c7:539a:f1c8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce404sm27769045e9.7.2025.02.21.12.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 12:33:09 -0800 (PST)
Message-ID: <0849b8a0-e1b7-4486-a376-43403e52dd1f@mandelbit.com>
Date: Fri, 21 Feb 2025 21:33:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/gdb/linux/symbols.py: address changes to
 module_sect_attrs
To: Jan Kiszka <jan.kiszka@siemens.com>, kbingham@kernel.org
Cc: linux-kernel@vger.kernel.org, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
References: <8e16609a-7e19-4d4a-951f-58c8bd012086@siemens.com>
 <20250221130304.5882-1-antonio@mandelbit.com>
 <7d00d9cb-6860-446c-9eb2-a908c9f7b15c@siemens.com>
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
In-Reply-To: <7d00d9cb-6860-446c-9eb2-a908c9f7b15c@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/02/2025 17:52, Jan Kiszka wrote:
> On 21.02.25 14:03, Antonio Quartulli wrote:
>> When loading symbols from kernel modules we used to iterate
>> from 0 to module_sect_attrs::nsections, in order to
>> retrieve their name and address.
>>
>> However module_sect_attrs::nsections has been removed from
>> the struct by a previous commit.
>>
>> Re-arrange the iteration by accessing all items in
>> module_sect_attrs::grp::bin_attrs[] until NULL is found
>> (it's a NULL terminated array).
>>
>> At the same time the symbol address cannot be extracted
>> from module_sect_attrs::attrs[]::address anymore because
>> it has also been deleted. Fetch it from
>> module_sect_attrs::grp::bin_attrs[]::private as described
>> in 4b2c11e4aaf7.
>>
>> Fixes: d8959b947a8d ("module: sysfs: Drop member 'module_sect_attrs::nsections'")
>> Fixes: 4b2c11e4aaf7 ("module: sysfs: Drop member 'module_sect_attr::address'")
>> Cc: Thomas Weißschuh <linux@weissschuh.net>
>> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
>> ---
>>   scripts/gdb/linux/symbols.py | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
>> index f6c1b063775a..610a3dd3c7b4 100644
>> --- a/scripts/gdb/linux/symbols.py
>> +++ b/scripts/gdb/linux/symbols.py
>> @@ -15,6 +15,7 @@ import gdb
>>   import os
>>   import re
>>   
>> +from itertools import count
>>   from linux import modules, utils, constants
>>   
>>   
>> @@ -95,10 +96,14 @@ lx-symbols command."""
>>           except gdb.error:
>>               return str(module_addr)
>>   
>> -        attrs = sect_attrs['attrs']
>> -        section_name_to_address = {
>> -            attrs[n]['battr']['attr']['name'].string(): attrs[n]['address']
>> -            for n in range(int(sect_attrs['nsections']))}
>> +        section_name_to_address = {}
>> +        for i in count():
>> +            # this is a NULL terminated array
>> +            if sect_attrs['grp']['bin_attrs'][i] == 0x0:
>> +                break
>> +
>> +            attr = sect_attrs['grp']['bin_attrs'][i].dereference()
>> +            section_name_to_address[attr['attr']['name']] = attr['private']
> 
> You dropped that .string() from the name - I don't remember the details
> anymore but we have it all around when picking up strings from C
> structures. Was there a particular reason to do that?

Ouch. That was not intentional and my test did not explode, therefore I 
assumed the code was correct.

I presume it may explode if 'name' is changed into something not a 
string. In this case .string() would throw an exception and block the 
execution.

I will send v2 shortly with .string().

> 
>>   
>>           textaddr = section_name_to_address.get(".text", module_addr)
>>           args = []
> 
> Thanks for picking up this task so quickly!

Well, I needed gdb to break into ovpn.ko :-)

Cheers,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com


