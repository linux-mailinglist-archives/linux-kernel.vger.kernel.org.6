Return-Path: <linux-kernel+bounces-523803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0109BA3DB73
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28C207A9595
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCE4288A2;
	Thu, 20 Feb 2025 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIBcqeio"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042561EEE9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058688; cv=none; b=hjFTbrFL5PIIJ7kGyNR5HaFBEcqrgUJCTyJzmzunC+ochi8VZCP6dYwWJ6Ok3HGE/9ZQT+CPvxj9auZOfycWVCq6P7TuO0+4hIg3B4lbb4ZTzrZYaNEr1cGW2DK1quL5mn67PGupertkXvOtaGLs0pdeFFqcYeetTUvIUkVrNSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058688; c=relaxed/simple;
	bh=WNKbmhVzaLRevjnTrEfwgemOd0VZkuLBY85NCuL/Uvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVtUr/aYLqR2wlgQvqket7+u7mhR+ljKSy2AOI0lRDp8odJ1AgwB6XtfX+7XkBCUNysUWvGPHa1gvE9Rb14KYEJka+CBOR/r4jpgumo43NeG+BR9T4JpeSfAtlu/9rM0Q5g76HmLeXrzmsK8toWjq88CwPNXDCe7j9aHXj//mSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RIBcqeio; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740058686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Z6Y+QONZzHviDlS3Fl6zxksjOSMCbAcq5j75r4OI3s=;
	b=RIBcqeioSP4DPrNXRMg9nyv6jGRGgso+6NljerK1gYllacndNQCfJ0wlAXjvxCoqyMMCVc
	X6D8HTpqo5VQ0hKK+7s4jgkLCiUPDIzlZfS+WCrRy0E9HRracJYgBkQqTiQV8TJblZlpCr
	Iw65zJAmzxTUURbqYSqzBgZSEVITwsU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-h7qtG1XaP4aN6m-2GHuvRg-1; Thu, 20 Feb 2025 08:38:04 -0500
X-MC-Unique: h7qtG1XaP4aN6m-2GHuvRg-1
X-Mimecast-MFC-AGG-ID: h7qtG1XaP4aN6m-2GHuvRg_1740058684
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e0573b9f60so1399865a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740058683; x=1740663483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Z6Y+QONZzHviDlS3Fl6zxksjOSMCbAcq5j75r4OI3s=;
        b=EfPpwnA4Vky3wbFKWb/j2/fwGrwdrQlWz6wN7tffVOiJSq3WGZuaZjz/brkNS+DTyn
         EEm+t84aqKSP7/jN60vUUARoC9rUmyYh1ZJSQmOT/+7vp7fg4MExqjtRIqF0jt7pfzG3
         H2JvQGJ3f9kj4oNDmUfB8qvNsnmDSCILQ/Q9so0QS7DZRKCp6S1Cse4Ioud9vzHQj0AF
         zNYyOjgWupXBA/+NkBGNzyqVxRB48+BNDHs/jZwVQqJdORsgaI/VMAMmk1RE4ODxV23A
         UAknzR2vJmUnoUdhOcQ2On8g9cWRfpXfeHfMOdOywdvK7UzJ/qQX4Dl3vvjLz+dSxlDy
         DBRA==
X-Forwarded-Encrypted: i=1; AJvYcCVf+e7UBraztr2zJQDUIPEs9kmx7FlU5uPGbkVbfuCnvQrYoC/WEw6TJWWrkbW01z0t9z7LaaGxn8pRkzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr+yRZzY5m1eeulbYyHv4OGgLmw0teCQFt4Qsg7XpXYQmTR3vD
	EpR6IMM2VpjiQHRU/q9sJ+T+d5PUwb108gVLSYqJFWyrNUW3pDexYU7GdyI8xInEIGGugC0lOKJ
	0bTix+IikyMYv8u6gqO5cHqvqavrsNSb1KTUxveNTnfih9ho+4MIqaW8l0PO8+Q==
X-Gm-Gg: ASbGncuItSu7hal86zgBEkge9sIAnutTutM86C9Io5pxyU3wk9Og5kzk/JUCpK5RfW4
	7sP0lwFbxiTfT3h20UwKEOs1jxCoIrzJ4eGcI4C9VrWS7tNVXkMkB7gHbimNkyCNFgYGHnLTMbc
	jfdY0w6xzqqzyLUhbMEYWGNQQbeEAwWgdep+4jt5UkPcCDVj716aEdLIE3L/Zj9Y4G9PNyjOVuu
	AqUnkVI0kQZrsGnJALgrKhQnyXbRsCcsA85SRU+GWejm5tJwV1RELLCrnHC5uQpC1l66XpYdtSg
	ZLaPQ5NNrbkWQuyRLdFOMi/7BtSzyajYB8FqfCp0UIHtRzCDeqszhBzJ4juqq9u29WrfQFFY/JM
	r6MzH7KJXlqGg3jXXqFcfuuaQk2VUGDJN/nWeteTmmwZyeJVIN3Dz21I=
X-Received: by 2002:a05:6402:13c8:b0:5e0:82a0:50e6 with SMTP id 4fb4d7f45d1cf-5e0a4bae5bfmr2165523a12.20.1740058683566;
        Thu, 20 Feb 2025 05:38:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKE4U1hhxsYM4lR+FS5y2jvGSFIPFR+2C4tFcThGLFAJbNRyPYrf/RJxsYafAikDdN33UGPw==
X-Received: by 2002:a05:6402:13c8:b0:5e0:82a0:50e6 with SMTP id 4fb4d7f45d1cf-5e0a4bae5bfmr2165505a12.20.1740058683176;
        Thu, 20 Feb 2025 05:38:03 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d3624sm12316054a12.40.2025.02.20.05.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 05:38:01 -0800 (PST)
Message-ID: <2d4924d6-1ae3-4993-a6b0-aae6f00bab88@redhat.com>
Date: Thu, 20 Feb 2025 14:38:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] x86/efi/mixed: Decouple from legacy decompressor
To: Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org
References: <20250210174941.3251435-9-ardb+git@google.com>
 <CAMj1kXHOqMM5uGxLTYuEf9KrxY5WzYvwo847JzoB-Qa2SN67Sg@mail.gmail.com>
 <20250220124831.GFZ7cknypjWiZoZzK5@fat_crate.local>
 <CAMj1kXEkkShwDfbwJ5abc9Q+LaqbvTNh1O5rVXy3EW85DdYTuQ@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAMj1kXEkkShwDfbwJ5abc9Q+LaqbvTNh1O5rVXy3EW85DdYTuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ard,

On 20-Feb-25 1:54 PM, Ard Biesheuvel wrote:
> On Thu, 20 Feb 2025 at 13:48, Borislav Petkov <bp@alien8.de> wrote:
>>
>> On Thu, Feb 20, 2025 at 12:29:30PM +0100, Ard Biesheuvel wrote:
>>> Unless anyone minds, I'd like to queue this up in the EFI tree.
>>>
>>> Boris, Ingo?
>>
>> FWIW, it looks like a nice cleanup to me and it boots in my 64-bit OVMF guest
>> but that doesn't mean a whole lot.
>>
> 
> Thanks. For the record, I tested this both on 32-bit OVMF and on a
> mixed mode tablet (with 32-bit AMI firmware) that I keep for testing
> purposes. Notably, 32-bit OVMF boots with paging (and PAE) enabled
> whereas the AMI firmware doesn't.

Ah good to know that you're still using the mixed-mode tablet
for testing.

I've just added this series to my personal kernel testing-tree which
I regularly boot on various models of these kinda tablets. I'll let
you know if I hit any problems.

> Not sure how many users of mixed mode remain

I think the 32 bit mixed-mode Intel Bay Trail tablets are still
somewhat popular I still get occasional inquiries about when we will
finally have the cameras working on them :)

Regards,

Hans



