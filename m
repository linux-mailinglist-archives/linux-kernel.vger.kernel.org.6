Return-Path: <linux-kernel+bounces-542158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34307A4C658
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC8A18870DF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AF122425A;
	Mon,  3 Mar 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5tI4LD1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A16D222594
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017889; cv=none; b=rZZg+Nu5bh5PeuiU56RMw4CGR6ZBXxfzEPLyC2xKL5IyliWmn88YoDBcKOiJgBF/gJ3iccPIccWH8b++RNKFW73JTCZOulg1oPnRkPYiRzSCNlW08VVSz0h2i051YIw9RYHLCFM6jai/WjSXtcPQ1NYu6TdcWMcb4hGZw75fAVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017889; c=relaxed/simple;
	bh=+ArXfA3NFKVE7mstrHbZp1HNhefBB5BLsYrGFUrCpe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8o9w4fmxJqWuqcoul9CQMdRgestmmIymdxylJ3kXWbFiFWzUg/7OX59QMa7e0n5kXxQ5GsWa6skKKhOci4mHVtr0+c8Kri+hVxQxkzIc7YoYLRhHPIswxh34nHXd7m+zceCswNoUKjfLPGgmb722XOLuAYzE4zGJtZrWh2efW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5tI4LD1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741017886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S24Z2XLjBQceszHvMMBdgNgoldRk+egxEowxBSVQJx0=;
	b=S5tI4LD1Yui38YDRPKhcLR1PZMLaYYD+tBfqw9yi6oAs3Q0TBEzZXXHscpLLzDVMvGJ0eb
	1yPkbzdkmzf8/Ocqec9hobaOsTFP4ONVd5VtWJGzGuhm9fJ4k/3wr2D1hbEJmZVHCtv9/3
	V6OxXSA3jlt8I/JJ1U3Ee9JgEJEkMfs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-ljPI1jiFM7Kx9xhsnLSmqA-1; Mon, 03 Mar 2025 11:04:43 -0500
X-MC-Unique: ljPI1jiFM7Kx9xhsnLSmqA-1
X-Mimecast-MFC-AGG-ID: ljPI1jiFM7Kx9xhsnLSmqA_1741017882
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so2000375e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:04:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017882; x=1741622682;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S24Z2XLjBQceszHvMMBdgNgoldRk+egxEowxBSVQJx0=;
        b=l4rDBPYQ4wECNykxXiM0V0+157F0HvzzW1yXerkq3AzV8HgkAF7s75wwybH0kAZ8Dp
         fhwG0L+rrwPpasJxdZxR7DXF+4c/T2rXphbM8sPXqR10qBhISKYnDUCNg9FMUFDMRuOr
         /QE0UbzmQ0VyQE9zg4tvaTV7lXABe0+4iTSVssH8ZjsUziyLr0HzPJwJy/yF+O32pu3G
         tyvOVdKiGBvmqb0+li89vJlxwc9Yw5+g94+P1dWirC/5ismgD8/W/a4iLPVJN+59L0TT
         ztBuUwk4GXwAvv8bzlPkXJ/Ajb85sYxHNQ9TAgzA/0PCE80n1nmYgZg6UkHBV1EGOBLk
         5POw==
X-Gm-Message-State: AOJu0YxIsT4Huh2ySSU4+RjvzIg3BlZPq1Pcbg8dMFvn5ry9aUjy1/bz
	YncNf6638XrdC4CH1cllnnYv/XJdVuGWB4g6WgWASlHlbDZkZUr/S80lKz0EKPA//aydbDuP3Pj
	E7glM3+edZMzTE7V4uaeZjHou2GowJEoBC5WYTRAR2JPnY9AdhehEqXLHLQFXNw==
X-Gm-Gg: ASbGnctF5R+NHRn1autejkGnY3ThUMxndzaYdAp9ELE2AiYgzfcXdThKG/xIqSEpPlg
	qvsLqMdpErfrsGoS0rvxxKumaEk6F4WigHHkcwPzDn5JCfhA58r1kpavxGYyOGxbWd4OyDLEa99
	e0oz0i+Dp6x/wPt/CEnP84BEwvL01J5ci9ChrCSk9Lih9Vz7AD4vYPo0qsg9Kq0wl5d9XChkL/R
	aApLoYNbhYZbMs46ptgEr0IcUUuBQRJCIMM8FauM6H6BvQ2FGwF11NqYKPcxQNwJ2gCi3htg5lU
	F1SnJsmsbDSgBgRIcOc=
X-Received: by 2002:a05:600c:35c6:b0:439:a88f:852a with SMTP id 5b1f17b1804b1-43ba6766afamr107678005e9.23.1741017882396;
        Mon, 03 Mar 2025 08:04:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESAc+wX0rvxOcIZfq234qfuHB0j658DFjIRUqcr9+kyBhaJQ1jhl3on4TmLYdoOsn3wxZikA==
X-Received: by 2002:a05:600c:35c6:b0:439:a88f:852a with SMTP id 5b1f17b1804b1-43ba6766afamr107677525e9.23.1741017881940;
        Mon, 03 Mar 2025 08:04:41 -0800 (PST)
Received: from [192.168.10.27] ([151.95.119.44])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43bc993abc5sm9812355e9.2.2025.03.03.08.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:04:40 -0800 (PST)
Message-ID: <ad542d2a-f4f3-449f-a2b9-3c0dc1d4905f@redhat.com>
Date: Mon, 3 Mar 2025 17:04:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] KVM: x86: Allow vendor code to disable quirks
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com
References: <20250301073428.2435768-1-pbonzini@redhat.com>
 <20250301073428.2435768-2-pbonzini@redhat.com>
 <Z8UCosKAJIUZ5yq/@yzhao56-desk.sh.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z8UCosKAJIUZ5yq/@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/25 02:15, Yan Zhao wrote:
> On Sat, Mar 01, 2025 at 02:34:25AM -0500, Paolo Bonzini wrote:
>> In some cases, the handling of quirks is split between platform-specific
>> code and generic code, or it is done entirely in generic code, but the
>> relevant bug does not trigger on some platforms; for example,
>> KVM_X86_QUIRK_CD_NW_CLEARED is only applicable to AMD systems.  In that
>> case, allow unaffected vendor modules to disable handling of the quirk.
>>
>> The quirk remains available in KVM_CAP_DISABLE_QUIRKS2, because that API
>> tells userspace that KVM *knows* that some of its past behavior was bogus
>> or just undesirable.  In other words, it's plausible for userspace to
>> refuse to run if a quirk is not listed by KVM_CAP_DISABLE_QUIRKS2.
>>
>> In kvm_check_has_quirk(), in addition to checking if a quirk is not
>> explicitly disabled by the user, also verify if the quirk applies to
>> the hardware.
>>
>> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
>> Message-ID: <20250224070832.31394-1-yan.y.zhao@intel.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   arch/x86/kvm/vmx/vmx.c |  1 +
>>   arch/x86/kvm/x86.c     |  1 +
>>   arch/x86/kvm/x86.h     | 12 +++++++-----
>>   3 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index 486fbdb4365c..75df4caea2f7 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -8506,6 +8506,7 @@ __init int vmx_hardware_setup(void)
>>   
>>   	kvm_set_posted_intr_wakeup_handler(pi_wakeup_handler);
>>   
>> +	kvm_caps.inapplicable_quirks = KVM_X86_QUIRK_CD_NW_CLEARED;
> 
> As you mentioned, KVM_X86_QUIRK_CD_NW_CLEARED has no effect on Intel's
> platforms, no matter kvm_check_has_quirk() returns true or false.
> So, what's the purpose to introduce kvm_caps.inapplicable_quirks?

The purpose is to later mark IGNORE_GUEST_PAT as inapplicable, so that 
the relevant code does not run on AMD.  However you have a point here:

> One concern is that since KVM_X86_QUIRK_CD_NW_CLEARED is not for Intel
> platforms, it's unnatural for Intel's code to add it into the
> kvm_caps.inapplicable_quirks.

So let's instead have kvm-amd.ko clear it from inapplicable_quirks.  And 
likewise kvm-intel.ko can clear IGNORE_GUEST_PAT.

Paolo


