Return-Path: <linux-kernel+bounces-239020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 607229254F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A1B1F25EBD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA898137911;
	Wed,  3 Jul 2024 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTyE90hr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721DE944E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719993455; cv=none; b=b4Gt/dcEgb57+lKggSLylutefi9q8M5uWlWUtv6TL19c7CPxGsftObbW7ImTW7+MuuVWyCyi1QKEp2YzEfBA2tlZuu+JbjfAOicLfB+xr1rFV/sG040YuHBtOgYyisE9avlsWnamC5ml1PoFOtpUSAL/LC2+9Gm5+s0E3YwDM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719993455; c=relaxed/simple;
	bh=U+tuZf+gHrZIew88Zq0HhyZ0+J7x2Mhz/9FZdbvH6Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9vyurBE0roQgx74wnWsx0OYrpNc+491UzfohxoCTH3Qr6HrK3fEbfpuMkgNRHf96mnSyl695lWjiTOHLCVz9K/D9j/5YhHiDDBbqy2RQ2usoKO8H73gxr14tjIybcZUSIRPYegbCE6vCr4fYa/W5PjllFXdNKNmTHobITM/rJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hTyE90hr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719993451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ATgbDzJNw/2oGwBMOiWIjN3Qn1UCklmeTzoV2zYR45Y=;
	b=hTyE90hrZpPA7rCvoJMFBttsO84hdETHQoiOo1/6jzwCukxY6T2bJqoE6G7z6J9+icfcYG
	AV8QBOcXUB6QoJI9IMwhAm8nFAhK13lqnAX9/y5aAnaatKQBzWTyqkW3hob8jBfxMtWMoI
	asOHuqBjUXLAYd31D9SeL1stxR9nv4g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-ZdTBe2BGPsCytkSzIed9OA-1; Wed, 03 Jul 2024 03:57:30 -0400
X-MC-Unique: ZdTBe2BGPsCytkSzIed9OA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36248c176c4so3236211f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 00:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719993449; x=1720598249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ATgbDzJNw/2oGwBMOiWIjN3Qn1UCklmeTzoV2zYR45Y=;
        b=EH91f3Npttb064XbNh0v1jY6SqlIe1dX+kxqrwC099ixigL/ZVAuNVosJUdo+Ojig2
         tGecLzyvhUUDkILeNeCLlleyA4k7EkROheQ0FWSTW3OaqTiZJPkA4MyNKVMtn1UeNZWn
         9yvz1vSvgyQnixJ/AhPdg1i9A/6vUxG0Q/jlK7MzIreF+DQyOje144w8K8Y/LDkZ5SiR
         pq5GHwnKq2wWZ3myVxvbdvgxlKswklbEpsWaP7uD//ZfF2B0XJJtLpBqHx8XZEvJxpUN
         9ZZbVbfdXFPtHJLj7tyAHM6RX0xRCtbks9ebCke+pLI/od3D6A2i1nYsQG5gLHYYEtFR
         /nsA==
X-Forwarded-Encrypted: i=1; AJvYcCVoYZtSxwhEqMWv4YlPkv/P0lB0wzgbFnpy96BBfj2iVzAsy3EfXlFqAa57o04zVFCIw2DzJY6gP/riIR233jnBZm/uewct0mzV0bM2
X-Gm-Message-State: AOJu0Yw6mCQzjXTah4vNnYTwy1Ao7KgUa9noaJkoGq4gKLn66HW79FV+
	F62IGYesL3+pmYTdxXXzMUm4AZupOHclO0pZidVaVoRNqtZvt6oSDcuOXp5zK5ZoiDBjx8ss5Ut
	RkVQqcdfebE4Gjow+IJGH7afQ3NtvGRZ4e4tCkTqdA6KtNoF9mLeunJ0+T5GHig==
X-Received: by 2002:a05:6000:400d:b0:366:e685:d0cb with SMTP id ffacd0b85a97d-3677569762bmr7597289f8f.6.1719993449003;
        Wed, 03 Jul 2024 00:57:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgd9U2eqDjR78JXH16dEWMefFhv6oCfwMwNT/hPSpZD56c2ut2zLCAdpneI7XMTfA346aUUg==
X-Received: by 2002:a05:6000:400d:b0:366:e685:d0cb with SMTP id ffacd0b85a97d-3677569762bmr7597268f8f.6.1719993448595;
        Wed, 03 Jul 2024 00:57:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:d5:a000:680e:9bf4:b6a9:959b? ([2a01:e0a:d5:a000:680e:9bf4:b6a9:959b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd623sm15223623f8f.16.2024.07.03.00.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 00:57:28 -0700 (PDT)
Message-ID: <10ea2ea1-e692-443e-8b48-ce9884e8b942@redhat.com>
Date: Wed, 3 Jul 2024 09:57:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] printk: Add a short description string to kmsg_dump()
To: Kees Cook <kees@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20240702122639.248110-1-jfalempe@redhat.com>
 <202407021326.E75B8EA@keescook>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <202407021326.E75B8EA@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/07/2024 22:29, Kees Cook wrote:
> On Tue, Jul 02, 2024 at 02:26:04PM +0200, Jocelyn Falempe wrote:
>> kmsg_dump doesn't forward the panic reason string to the kmsg_dumper
>> callback.
>> This patch adds a new struct kmsg_dump_detail, that will hold the
>> reason and description, and pass it to the dump() callback.
> 
> Thanks! I like this much better. :)
> 
>>
>> To avoid updating all kmsg_dump() call, it adds a kmsg_dump_desc()
>> function and a macro for backward compatibility.
>>
>> I've written this for drm_panic, but it can be useful for other
>> kmsg_dumper.
>> It allows to see the panic reason, like "sysrq triggered crash"
>> or "VFS: Unable to mount root fs on xxxx" on the drm panic screen.
>>
>> v2:
>>   * Use a struct kmsg_dump_detail to hold the reason and description
>>     pointer, for more flexibility if we want to add other parameters.
>>     (Kees Cook)
>>   * Fix powerpc/nvram_64 build, as I didn't update the forward
>>     declaration of oops_to_nvram()
> 
> The versioning history commonly goes after the "---".

ok, I was not aware of this.
> 
>> [...]
>> diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
>> index 906521c2329c..65f5a47727bc 100644
>> --- a/include/linux/kmsg_dump.h
>> +++ b/include/linux/kmsg_dump.h
>> @@ -39,6 +39,17 @@ struct kmsg_dump_iter {
>>   	u64	next_seq;
>>   };
>>   
>> +/**
>> + *struct kmsg_dump_detail - kernel crash detail
> 
> Is kern-doc happy with this? I think there is supposed to be a space
> between the "*" and the first word:
> 
>   /**
>    * struct kmsg...
> 
> 
Good catch, yes there is a space missing.

I just checked with "make htmldocs", and in fact 
include/linux/kmsg_dump.h is not indexed for kernel documentation.
And you can't find the definition of struct kmsg_dumper in the online doc.
https://www.kernel.org/doc/html/latest/search.html?q=kmsg_dumper

> Otherwise looks good to me!
> 

Thanks.

As this patch touches different subsystems, do you know on which tree it 
should land ?

-- 

Jocelyn


