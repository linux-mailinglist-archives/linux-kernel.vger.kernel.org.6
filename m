Return-Path: <linux-kernel+bounces-432069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E28659E454A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23288B43F65
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418A31C3BF3;
	Wed,  4 Dec 2024 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arUw7HcK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED1A2391AA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733340523; cv=none; b=k6auZ9HAWq9FjwapGK4M9K0m5XQlKyiYzSjoRaNdpwSzfABnu3xX8eKqSow0s9K5PwRtRc5qRMgoA2QjAkYlBx3ZodOTr6iD8laolaHuSGKjDV8m83FWJxdzrha+hTPJPIqgU94/AyU/fOPpB2WL0jyWjC0Qof5NEAiB9ddwESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733340523; c=relaxed/simple;
	bh=GlXHkq8uAMhoPqEqUjFkdVl0fLuJW8L3IH5dVV5FTM4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ahtLo6mPheib4eTemujueGyQLRtPUq3O0PW2Na9HTlfelhurSnCCzYgw3V03o/AJIkp/pLhgIURgszMzzAH2oSnWjrpZjG5kAsiGWfRofO4Qd/nXlSirEDdIwV1Srp/0mHIve/R7h2v3jtsC8PW7GY8P9FfO4+d3TwHhzaGoavI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=arUw7HcK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733340520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RK6WOAz1lZS9QPBVM+mwxRPXAmaKARx1aKYmA/XRfV0=;
	b=arUw7HcKo8NWXFO3RgaviIytb3QTCHemQfMLXwd6ERA0qAcLNihZxwPDGcP6gTSocSYksI
	ePRkZzUFFKvvPg2sBil8lzkkMWX6hjMnr4RXq07avdWxvzsQ+KvRWzfeZJ21yTspp1h2EN
	pfqjp9NC3bj8q4eaD0SkxG9bkca1XMo=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-PNL8qmf4MFWAU98E9-pOGA-1; Wed, 04 Dec 2024 14:28:39 -0500
X-MC-Unique: PNL8qmf4MFWAU98E9-pOGA-1
X-Mimecast-MFC-AGG-ID: PNL8qmf4MFWAU98E9-pOGA
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-84181aad98aso8044539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 11:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733340518; x=1733945318;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RK6WOAz1lZS9QPBVM+mwxRPXAmaKARx1aKYmA/XRfV0=;
        b=dzt6hSGMNrNsPuHU4cbEQ7cguM6cOdIKw6LkUKO175QXJVfOwUk7lxJQqtqco4scSm
         jWddjPH1/w4ebIW+hb44i3g/RK2o8dXvQn5jkp5hH7YG0LVfyqZcFJlzX1ICcZtG/HUH
         wEsfs7wGfbGQyTuPo+ucpBaCTm+8w2XAI8ELt4Z0PZ19RE2m1+llbmOgJd5oSksoSdXj
         wVDYC2qB28OqnubAQImJpZKEHcKsC7cIlK5+uptXOtkCszf17sEkG9J95xlcZWR5eZc4
         D1/rekloPWT9bmr1JSzKEqUnbp0iFA2UmAFyQyRgVM5aMUIZNW8MFwp8l6gRPRMCLgPM
         dklQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSp7au3kP17Z9IyZAkxO5kIvReOV/d+4KwaFpK/rh1HlYt0h8bMp7zb0JHVlK0afOoFjdmzIEZdoNzZ2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2zrZBZgHX4+fJ4Z5PNYd7Bd0lrME7/768Kc3vhKkFkckzqy//
	CezeE38py6a85uie8Our3ktp+dJtIFvQKnOWvHfcpgAsE2Ti820p7ltVVDytb1dlAWQJHBBQUWv
	OJ2HV2POaC1d870ayd4nRRAHU60kR957qMRTWWpeNy909XW1w1uVLd3ynG51UlQ==
X-Gm-Gg: ASbGnct5FGOVZoa0+oAUElrUw+SJ6ExqCC3AaHMeSKjq3MPJTdo2W3MQjMW4p9Ge3dl
	c7eYI4RZfNz8EO8j9XYbdQ2LZd78oXUtAylaJnDFnMGzETWiQrgEUGSq2qf4PSRUfx4/XRlf6gv
	l0Ja6PxG1un465ZMiqlbS+kof+C28MdhGRv0JoTkXhnGMhM6snT6e0WVsrROjbozAbRB9KfDgVz
	IDTFjNyhHMIN5D/lWbtMRgdF26r29JdGMAbtDqVuIGTU11ju9bJQbPyeYzTCxoMnF5FRWWKI4ov
	hv0NnYjJqEWuYEwfuQ==
X-Received: by 2002:a05:6602:160b:b0:83a:7a19:1de0 with SMTP id ca18e2360f4ac-8445b5e5949mr1171148139f.14.1733340518572;
        Wed, 04 Dec 2024 11:28:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeRYlqhtL1/xGydfmb5gnwZnBeNVosIDAQKlPSYZmhpzgWnvZI0kkN9wiVtWCY/6e0stc8Lg==
X-Received: by 2002:a05:6602:160b:b0:83a:7a19:1de0 with SMTP id ca18e2360f4ac-8445b5e5949mr1171146539f.14.1733340518282;
        Wed, 04 Dec 2024 11:28:38 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e230dded27sm3180285173.73.2024.12.04.11.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 11:28:37 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <59b254dc-acf6-4114-b6b4-a7ae517bfa06@redhat.com>
Date: Wed, 4 Dec 2024 14:28:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/nmi: Add an emergency handler in nmi_desc & use it
 in nmi_shootdown_cpus()
To: Thomas Gleixner <tglx@linutronix.de>, Waiman Long <llong@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20241203150732.182065-1-longman@redhat.com> <87h67jsif0.ffs@tglx>
 <7aa93137-4b5e-474f-a99c-47acffdf71a3@redhat.com> <87zflbqqar.ffs@tglx>
Content-Language: en-US
In-Reply-To: <87zflbqqar.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/4/24 1:03 PM, Thomas Gleixner wrote:
> On Wed, Dec 04 2024 at 12:23, Waiman Long wrote:
>> On 12/4/24 8:10 AM, Thomas Gleixner wrote:
>>> On Tue, Dec 03 2024 at 10:07, Waiman Long wrote:
>>>> +	/*
>>>> +	 * Call the emergency handler first, if set
>>>> +	 * Emergency handler is not traced or checked by nmi_check_duration().
>>>> +	 */
>>>> +	ehandler = READ_ONCE(desc->emerg_handler);
>>>> +	if (ehandler)
>>>> +		handled = ehandler(type, regs);
>>> Shouldn't this just stop processing right here?
>> Yes in the case of crash_nmi_callback(). I suppose it is a no-return
>> call. As the emergency handler is supposed to be a general mechanism in
>> design, I don't want to make too many assumptions of what will happen
>> when the handler is invoked.
> I'm not convinced that this should be used as a general mechanism. It's
> for emergency situations and that's where it stops. If the thing
> returns, it's a bug IMO.

OK, I am fine with that. I will put a BUG_ON() after that in the next 
version.

Thanks,
Longman


