Return-Path: <linux-kernel+bounces-517327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD77A37F50
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8B13A1953
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8F3217641;
	Mon, 17 Feb 2025 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BzctW2vf"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF06217648
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786517; cv=none; b=RpVVlYbVnbGQNHAbPeNG24edCwyg7Ij+jPgLXv2FeBxeqThtWs8j+H5uNeDdvFD2S4lVPcSb+M1XiXGcM7GpRnDdXvy4AfyM5wUc5NTKtuEOTdJJjKmintG7NArtXEHdixvFwhoi1+mBoAZpj8ryVGrkdoK3h50qCob4ubhvgfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786517; c=relaxed/simple;
	bh=0ik/x5gdQpwFxGRve4EoCIoEDYncm6E5QaBZIZs4S6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYvKakZ23Js/bZV31LIRmHJ8ftO3//6IFNV6RcdPgVE2mH5wJyHT6pvKh6T/61KulwW68XWYlQk147MbcHs91zfHwdcz8n/O1xv87p15JyQ4R30IQTdQLb0RX1Oqh5SEZ1s3KSPDtm2BJMJDU/IXKTENaF7k5YVogxyp53KtkM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BzctW2vf; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb7aecd39fso280057766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739786514; x=1740391314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JMV/tUWTTBpA4vW8CyRHWlBAGTTrRPmL8N3P3dHOplQ=;
        b=BzctW2vfgtn45ApKHXnWpJSM7Igcq76rrn+DHxiudaphAZCSp7ttjquyj8PPBZlQyx
         M9qYOfcumE2zVI7mEPVege2xKSeYbbqO/BOeMpZ6pgIh/yBTy/wQAf2LTREg8jBjiWoC
         4H1Mo0nrCIZoOTVVekYG2tKWH3JXBscDwCywKvuitjfDWbL+aM4oGqL+eyuAa/O7Py/s
         AUsvJVHCBYP8YsSv8HMAXk0XKqxjWhkkCDpw0baerQKEGByswhAiEiHq63129uD5Jzkd
         UdGGXIAALHZ/TbX0V3lh8W7+R9hBix4ipRmtq1wC7lkRcQ0afkJvgLRd8ZZaK+rBJPdH
         hq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786514; x=1740391314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JMV/tUWTTBpA4vW8CyRHWlBAGTTrRPmL8N3P3dHOplQ=;
        b=OOCNP6WAADZtBvoRETTsu9z6Pc7L9W185oGU+1Rr+km5lVnfjKlvERowQYLP+/5Q+y
         6sXjNZErN659l+6xP08gQ2JE40GtaxZETmrWhVAycccD6+U14xUZbSaxcQNxBIVNoQeQ
         vaeM4dlZxqNu/wwAW1Pn939b+GQv1d3cb5YFpCd4L47mkQVJvjEENsVMC+HrErNtjq/R
         73KeiMLzFa6/DeZDsK0PH3XmmZnbMdfmQe2PlU1jThHLVUXGjJI6LPDu5OoqwEqIkE7Y
         ah2QEh0/8fsTgkIxnRY/BHhbdwoX8D/7GLQEvSSlqeVhaqsxTntv+WBEY/MoUWhaRs21
         0raw==
X-Forwarded-Encrypted: i=1; AJvYcCUKSYppKMJtDtJ+ZTkAZC1vsUnRwYA6Pij7tZj03i3eeOR++fq9utnKGDbPrFKbVHNocxyHuRxQa91ZN2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJV3SWbPMD5Wxyw9/bAlwll/QHliBtrUOWvVm7uROHBVpBcpk6
	Q4OWOsCxul6rfXlA01fY1QbkUChWPC/4cehh2P7mfKAa0u+/cw50F5adZ347GS7SbQw0wDyHBBB
	q
X-Gm-Gg: ASbGncs7tBTEUtBUkIulMnLHMxRq75sKuPTgZSP8uld1z3QlOA2KNiRMCFkCbnO9KKg
	gT64cdnPkNkaGZsk7+4AtClNzFkohldM17jIV6TibZvKlFdKVokg2pBP4L7F2FlTDLWxXfCnx6g
	nSoMfOKL7ZzymFXbaxWf7JT5y7/8pcR6hz0/gAxillffLn3TczAQYBYd9gZ7uAhrkhlz7XR0vSy
	QnQQM7F2Fa9HsqamtDPtv51NAE++S1lOQUjqfJk+RCvvKmz+1Su5xTZw674R7s1ByJGL1Hh+yE/
	7P/DCIYcJWBXS5H0CuA6WZcZ8ewirUhy/iZhWhQG7Lk=
X-Google-Smtp-Source: AGHT+IFVSN5gkXJhtCi/O+DcvMndotLeH1zglHLdeZ85L2r1nGGgQtQnfumGzJ0IxDgCKsF8Du92fQ==
X-Received: by 2002:a17:907:8e8c:b0:aba:e585:42fa with SMTP id a640c23a62f3a-abae5854477mr976618666b.5.1739786513881;
        Mon, 17 Feb 2025 02:01:53 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.142.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9b187203sm175736766b.61.2025.02.17.02.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 02:01:53 -0800 (PST)
Message-ID: <8cce2725-9efe-44e8-b071-f921874d7649@suse.com>
Date: Mon, 17 Feb 2025 12:01:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] x86/mce/inject: Remove call to mce_notify_irq()
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 tony.luck@intel.com
References: <20250210154707.114219-1-nik.borisov@suse.com>
 <20250210154707.114219-2-nik.borisov@suse.com>
 <20250216161050.GBZ7IOCofLUUelomR4@fat_crate.local>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20250216161050.GBZ7IOCofLUUelomR4@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16.02.25 г. 18:10 ч., Borislav Petkov wrote:
> On Mon, Feb 10, 2025 at 05:47:04PM +0200, Nikolay Borisov wrote:
>> The call is actually a noop because when the MCE is raised the early
>> notifier is the only call site that correctly calls mce_notify_irq()
>> because it also sets mce_need_notify. Remove this call and as a result
>> make mce_notify_irq() static
>>
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
>> ---
>>   arch/x86/include/asm/mce.h       |  2 --
>>   arch/x86/kernel/cpu/mce/core.c   | 44 ++++++++++++++++----------------
>>   arch/x86/kernel/cpu/mce/inject.c |  1 -
>>   3 files changed, 22 insertions(+), 25 deletions(-)
> 
> So what you're looking at are the remnants of the old soft-inject of MCE
> errors. And it seems that we lost some of that functionality along the way and
> no one has noticed because, well, it seems no one uses it anymore.
> 
> In order to understand how this thing was supposed to work, checkout
> 
> ea149b36c7f5 ("x86, mce: add basic error injection infrastructure")


The original code in  ea149b36c7f5 was setting the notify_user bit via

raise_mce()->machine_check_poll()->mce_log(),
  mce_notify_user() - consumes notify_user set in mce_log above.


  subsequently in 011d82611172 ("RAS: Add a Corrected Errors Collector") 
you factored out the code from mce_log() mce_first_notifier, where the 
bit setting remains to this day, but since it's been removed from 
mce_log() it made the call in raise_local() defunct.


Considering that no one complained about this after all these years and 
that the dev-mcelog is deprecated I think it still makes sense to make 
mce_notify_irq() private

> 
> and follow what raise_mce() does and pay attention to notify_user which is
> what mce_need_notify was called back then.
> 
> Remember to have fun :-P
> 


