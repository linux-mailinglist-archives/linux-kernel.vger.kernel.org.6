Return-Path: <linux-kernel+bounces-315723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E6096C63C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C60285E6F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313F21E2008;
	Wed,  4 Sep 2024 18:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fUL/jMwR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A0D1DC1A2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474106; cv=none; b=nrCym+TcwlodUgypjma3fzq/5AygP5Qi9Hq00QjW+RA8rtyqXb7xOlkn+iwFOVVZu00ihADf+DxrIqfqDbqmw7OooD6siJ9SUIvv6eL4WF+NVyapeK7JONTSY1znTwwYV27/A7EcC2QzouulD++o1DMOtJ+8HYXnb8n5TNwjL3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474106; c=relaxed/simple;
	bh=zdL/LzjlEW0mFJYDtvzs5usFXQ1tNMz5mBn3uONMuds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1XGDfCe0JwFyqiaqGUdtg2hahu/D7OlOwnJEv4uCiRJguKgOe2H/FqLXzcTaLhq2V7b4IDREBUAjEL+HTnZ5sjcYYdeqJqJSpeGADDk0LPrQf8EbWYrb/phBRIh9iiAmpFovosCqYehkfLn/Ii0+4Vaz4gtNiX0gQmkPZsYAqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fUL/jMwR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725474104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NM9oFEc8UiVyv381Cv8nBEcn00Qnvr9uFfx5c4jzXmk=;
	b=fUL/jMwRd5ZmgLDWR5w1TjpzLrvQ9Ubzz/dKjEJEvYnX74pOFKItzz5YiM/zu2KL71jlXw
	O7AKg6OQVSk3uJQwNViup7TdEemxv0d7OJshEh9FUWkEOSLv7DI2NXHRcPpAr9ELOWNDlt
	UhGrLJkfrkYemEKhw0lYrvVa6HlB+XU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-fr2WtASgNbWxfLhjNOQHsA-1; Wed, 04 Sep 2024 14:21:40 -0400
X-MC-Unique: fr2WtASgNbWxfLhjNOQHsA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c260907f5bso2483628a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 11:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725474099; x=1726078899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NM9oFEc8UiVyv381Cv8nBEcn00Qnvr9uFfx5c4jzXmk=;
        b=hCxMxPQAzD9gZF7bhEHPENCYx/IE8dammkY6KrnOEMjOk+4UrS9/tmhQZXSa91/A7v
         iZtBn3uLF5nxjcF1usCD6p+R8YHzCyJ5HAgHakZCWJWkEPr2kfveTJGVMViQvg/uKe7P
         IBrgpIbhpc7FYcL0VmUXMBf28HGbnTz0ZtllF2YXIQqdmtoTlKY557lhxrpgvqZ+nXwf
         kqknVLzoJUhjVZeUwytB5+65rpV+WGvRViucd/u53uL8f9Ycd9KUNTMlvdFvDyEsd3j3
         9c79xRTm2wWX6gOTYYbWnftkXtwu6h8+wX65M4UBQRgkmFA6mq+o9oEIIaX/mxlyshSi
         50tw==
X-Forwarded-Encrypted: i=1; AJvYcCUvX1ollQ9Ov6/dhEyRfeKAviThLBb83L6p6OtROit02VXMMsTqgIzgZcJYfBtmtNDpKIhpFXi0NakSAVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNDJQKm9tY+3PKhK/mCLuG824lNIz9icbDHX3i9v6XPgMoCavZ
	S/Up+NUymL3t8tUiq64219KJhw0lW2knYCRqLHmekiAN9pJqC7AH/fsPVPsdHpyaOicUfJK94FG
	33L3W/W24duP/xIJmUWTfFb1aN8IcMoxYnErnw7AcnRywWPD/4H1DZYpq4wNrAw==
X-Received: by 2002:a17:907:9495:b0:a86:97e5:8d4e with SMTP id a640c23a62f3a-a8a1d2c8600mr668060166b.23.1725474099680;
        Wed, 04 Sep 2024 11:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnkq/Or86Xk1uFga4JK0hoM5tphs0VBsX/+HBCClglLDo/I8UIpOHiN4idr4Nb8kvVk2qCWg==
X-Received: by 2002:a17:907:9495:b0:a86:97e5:8d4e with SMTP id a640c23a62f3a-a8a1d2c8600mr668057666b.23.1725474099226;
        Wed, 04 Sep 2024 11:21:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a62045e44sm21528266b.78.2024.09.04.11.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 11:21:38 -0700 (PDT)
Message-ID: <f14605cb-5bcd-4565-a02f-4b19dc1c8e25@redhat.com>
Date: Wed, 4 Sep 2024 20:21:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/platform/geode: switch GPIO buttons and LEDs to
 software properties
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Mark Gross <mgross@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-geode@lists.infradead.org,
 platform-driver-x86@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <ZsV6MNS_tUPPSffJ@google.com>
 <a2366dcc-908e-41e9-875e-529610682dc1@redhat.com>
 <595fe328-b226-4db5-a424-bf07ad1890b4@redhat.com>
 <20240904132104.GDZthewNjCZ4iLgEoD@fat_crate.local>
 <57bbca66-4d84-46c1-a638-1347ee6a222a@redhat.com>
 <ZtijvdOiA-RF_2RO@google.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZtijvdOiA-RF_2RO@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On 9/4/24 8:15 PM, Dmitry Torokhov wrote:
> On Wed, Sep 04, 2024 at 06:01:30PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 9/4/24 3:21 PM, Borislav Petkov wrote:
>>> On Wed, Sep 04, 2024 at 03:02:17PM +0200, Hans de Goede wrote:
>>>> Or I can merge it through platform-drivers-x86.git/for-next
>>>> with an ack from one of the x86 maintainers.
>>>
>>> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
>>
>>
>> Thank you.
>>
>> I've applied this patch to my review-hans branch now:
>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>>
>> Note it will show up in my review-hans branch once I've pushed my
>> local branch there, which might take a while.
>>
>> Once I've run some tests on this branch the patches there will be
>> added to the platform-drivers-x86/for-next branch and eventually
>> will be included in the pdx86 pull-request to Linus for the next
>> merge-window.
> 
> Hans, could you squash the following bit into the original patch please:

Ah right, I think I remember a lkp report about this, thank you.

I've squashed this in now.

Thanks & Regards,

Hans




> diff --git a/arch/x86/platform/geode/geode-common.c b/arch/x86/platform/geode/geode-common.c
> index 8f365388cfbb..d35aaf3e76a0 100644
> --- a/arch/x86/platform/geode/geode-common.c
> +++ b/arch/x86/platform/geode/geode-common.c
> @@ -14,7 +14,7 @@
>  
>  #include "geode-common.h"
>  
> -const struct software_node geode_gpiochip_node = {
> +static const struct software_node geode_gpiochip_node = {
>  	.name = "cs5535-gpio",
>  };
>  
> 


