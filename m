Return-Path: <linux-kernel+bounces-424507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF819DB523
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F88167F25
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D189F157493;
	Thu, 28 Nov 2024 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfeQGygN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B639152E0C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787801; cv=none; b=VJq2zEKbB80lsLpBAMKFyXtZYAnvcd8T0uNj+g2mAxBXFmwDTm/+B27RTg1pmTwXMJmg1Cc8nLjVqdyH+EDcI796xk2JHovFK1vQqc76oxdoLe0Yc6VFofdEZKYT6uMr7wXb40emOlfVO9i4h6gGMgNmnFuKPVZBq+0869yjMfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787801; c=relaxed/simple;
	bh=iCCaLqRwply++oypxy91+bALEX2NJlY/u1f/18mt1Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwgXy61ZcFURzBOPiaRnjgK/RrkD0CBYd1f1iZnIT+kM/4qnJojDtWlxXY8xYtthiinvIbi7tPVQcXVq/vpo8XJCQ6oJD27KBk4a61KLY7D7uIgEiPmOr6LTwvhn1ZdDW7rUgja3CFErvfuRnxT+bBWsvt1/Du3/wjkEUKnHgtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfeQGygN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732787798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eHvSNuslLvCirSttMP2rRTBlXF7S2ADtrEIGnjsm5g0=;
	b=NfeQGygN1ykGRAMJ+fcJ0t/Xhz4q085N/DrmScRljEIxudis2MBJUHmQYzOvFBYQqYH4DS
	i9o7bNl4hvZavT1d6BpvTlliX/rEM0jun12bCLwEiHPmSdFZ8t93e0fZf7816YyB9Guym9
	6HwXM9eGf8liDkDmMpyIjwhFwV1AQHU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-d2xwx-USNKKcm9k0-Xetdg-1; Thu, 28 Nov 2024 04:56:36 -0500
X-MC-Unique: d2xwx-USNKKcm9k0-Xetdg-1
X-Mimecast-MFC-AGG-ID: d2xwx-USNKKcm9k0-Xetdg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434996c1aa7so4513945e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:56:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732787795; x=1733392595;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eHvSNuslLvCirSttMP2rRTBlXF7S2ADtrEIGnjsm5g0=;
        b=LIRdxHCfDFVYF/Xf5vslMj2/HK1RhmWvgA5RHNa9GL4MO6jmHXAk5SQ7VoolOeJRvD
         /EyjN2dwXoP0jMEOVlUAJ5Bsy2ly6hD5paFcMJxkDH8fSFwbzdPdsX54CgSn2fSzgjhA
         HFo7VHEK3mA+xUAf/TzR3mQUYsgq8R9XFpxElKe67OOiqzvtBTDgY20ncDq9o1yMu7OF
         4Aky2GeDvx024s4WVO/sFOZloqFmac9OOHNdU0+ISAM+5jZbI3pNPGoqOxtG938bg4yH
         eXaHHuD3JmC05zZNHD1f4Ev5HeNmFmxRcxkilpBfpzCcvMPZDORegfbDHBWK1sSRDnHL
         45lw==
X-Forwarded-Encrypted: i=1; AJvYcCUnmYc1F80xaeYRcrBVyvbrGI/cX3XbyRhGjPPAMaziA63WdtUkpY813z0aEC5a497pAv9q3qkHgtZSa5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxQJkW+lTJDiOqUG9SQUv6GtNpHekMkqbXO9Rt9OnDq2oodMKW
	nLxa32w8+fbLSqs4FKg1KEupy1bvIa+AMII6WwPFRPa/+0WDwhQCSvmQ1UK9d6DT/6k+zfG04Vj
	u1EMrpiy8B1fVNuspwCtoIju5Fb+MkdF4Cr6xKtgZ4l8SoyzljjiRhZJdaHfR2pyXn4YqUg==
X-Gm-Gg: ASbGncv2EVoNXtnbhmDyB4/3mGhvpIfSchcbx1Y1nQHkTHLvVVH/AW7tebgJU7N4OT2
	CNbIm9/aXCJVea3oIcAhzF38PxORCCAI/lP0IbPAjfy8TpV85mBMZqLxAw5OSivcnZCui82qcDL
	C99Ch9cmE2Hmc/I06fjwLWrekTDZRwf6wg+itL6Hikxvc7F85B/+0+S7H+DsuWlL5XuZN2WwlB8
	BJTS/QQ1CxyegjA1+5nitM0SOxJQjLduXM9uw2dOW9MFDl+B4nQU7jep0/hR4JhrmIKE02XGM2t
	O6umIV0Lvc0xLbrXoCxGPE00hp1WOykpR+APkuM9xKeuRhTVa5+USu0jHf/apwT5s79rjXjpXX0
	=
X-Received: by 2002:a05:600c:314a:b0:434:9f0d:3839 with SMTP id 5b1f17b1804b1-434a9dc3d2emr57803655e9.8.1732787794766;
        Thu, 28 Nov 2024 01:56:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiMcfKWkTqfNVnrQ+ET5ExtEv9HsAt7HBCk1uFn156kHSulgQVcobXk07GkLfGJXqhMqnTYw==
X-Received: by 2002:a05:600c:314a:b0:434:9f0d:3839 with SMTP id 5b1f17b1804b1-434a9dc3d2emr57803465e9.8.1732787794399;
        Thu, 28 Nov 2024 01:56:34 -0800 (PST)
Received: from ?IPV6:2003:cb:c714:1600:f3b:67cc:3b88:620e? (p200300cbc71416000f3b67cc3b88620e.dip0.t-ipconnect.de. [2003:cb:c714:1600:f3b:67cc:3b88:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70cbfsm16852685e9.36.2024.11.28.01.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 01:56:33 -0800 (PST)
Message-ID: <e6b3e6c7-193d-43c4-a8c6-6023458723dd@redhat.com>
Date: Thu, 28 Nov 2024 10:56:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] arm64 updates for 6.13-rc1
To: Yang Shi <yang@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Sasha Levin <sashal@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon
 <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241118100623.2674026-1-catalin.marinas@arm.com>
 <Z0STR6VLt2MCalnY@sashalap> <Z0TLhc3uxa5RnK64@arm.com>
 <0c09425b-c8ba-4ed6-b429-0bce4e7d00e9@os.amperecomputing.com>
 <Z0dhc-DtVsvufv-E@arm.com>
 <dc5e8809-825f-4c38-b487-b16c7d516311@os.amperecomputing.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <dc5e8809-825f-4c38-b487-b16c7d516311@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.11.24 02:21, Yang Shi wrote:
>>> diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
>>> index 87b3f1a25535..ef303a2262c5 100644
>>> --- a/arch/arm64/mm/copypage.c
>>> +++ b/arch/arm64/mm/copypage.c
>>> @@ -30,9 +30,9 @@ void copy_highpage(struct page *to, struct page *from)
>>>     	if (!system_supports_mte())
>>>     		return;
>>> -	if (folio_test_hugetlb(src) &&
>>> -	    folio_test_hugetlb_mte_tagged(src)) {
>>> -		if (!folio_try_hugetlb_mte_tagging(dst))
>>> +	if (folio_test_hugetlb(src)) {
>>> +		if (!folio_test_hugetlb_mte_tagged(src) ||
>>> +		    !folio_try_hugetlb_mte_tagging(dst))
>>>     			return;
>>>     		/*
>> I wonder why we had a 'return' here originally rather than a
>> WARN_ON_ONCE() as we do further down for the page case. Do you seen any
>> issue with the hunk below? Destination should be a new folio and not
>> tagged yet:
> 
> Yes, I did see problem. Because we copy tags for all sub pages then set
> folio mte tagged when copying the data for the first subpage. The
> warning will be triggered when we copy the second subpage.

It's rather weird, though. We're instructed to copy a single page, yet 
copy tags for all pages.

This really only makes sense when called from folio_copy(), where we are 
guaranteed to copy all pages.

I'm starting to wonder if we should be able to hook into / overload 
folio_copy() instead, to just handle the complete hugetlb copy ourselves 
in one shot, and assume that copy_highpage() will never be called for 
hugetlb pages (WARN and don't copy tags).

-- 
Cheers,

David / dhildenb


