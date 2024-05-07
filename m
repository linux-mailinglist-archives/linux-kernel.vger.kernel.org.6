Return-Path: <linux-kernel+bounces-171881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CFC8BE9DE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C888A1C21178
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F8351010;
	Tue,  7 May 2024 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXkqqzwg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82CA747F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100958; cv=none; b=nNsQQZieuoi/TYtrTZUouGrRdCTZ7D5urRQF7pXxInGvkwIWHGquwQBxr0dDaRqZSxK0V1gu4f+fJ2wxpf2n7YN4FLmpVwYsAZT4CWoF6kBUtdSVuDJWSbEu2rBkIvjS3GOLhAEl2SWlQYfGASr1BKA+dq/leAEaCUQwpKyji9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100958; c=relaxed/simple;
	bh=ayAcoGMjeZEtCoLYulFBAV3rhD/YRujQKiVQBkAH5eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7pJUlZ7kkwaRcNuLiHOAmYrLNPq3wsFV1eiKiX9YE86j0oP846o3Y5h1gMvPL7jsZbrhfSh9+9UOsZRPlyWcTWWuWdzb+wBDyF9p2QLOPqn14i0EFYDCfVX1ALu05CHtEp0nF57kHXkCTj933BRplZuX5c1ZZ0gv+w/B5im23k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DXkqqzwg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715100955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DlCDm3cAnsY2L8H68AJPaPtU3T+hmcvfCLV+r6947v0=;
	b=DXkqqzwg76eSlIGtkJ732xSlbmwB9OX2tKHWWwrSHUty0mZv552AcuhkywjsKtJiXUmfd4
	M7cwVFo2HY3b6hw4QjmA+uqC45IGDx1fcCMyX4RrSPUW8YPb5ymtoAfE2VowsxX+1sW5b6
	t+Av8QQv55+mRm2q0lSTQYlDJAz0zVs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-x-07W1UKOCuT8hQrlbXNPQ-1; Tue, 07 May 2024 12:55:54 -0400
X-MC-Unique: x-07W1UKOCuT8hQrlbXNPQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-51fd3568b04so2754335e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715100953; x=1715705753;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DlCDm3cAnsY2L8H68AJPaPtU3T+hmcvfCLV+r6947v0=;
        b=L3GmeFHbCiVjBaYfaFT3dTwWTsRaf9dnROH0YI/EtXulGit5pLVugHjH2H5KgbnZtv
         9uUkc0BAL/KZD6aaPqJtfCj75O4QWDg7XyD1HynAb1A+XbCzYi3bUe/0NnNSiPce+lYd
         In8iNSSiei9F2G8qlYQb8HBiDg3lVK3jHTmX3cHKIK7plAB5NSCrE0qWHc7GLcPwbvl/
         vKZrdIn5sKhR2wPC9p8mj5w3cDCBBjvrZd3+XydVBce+Z7otIal5enVuWCi/1tBEyy8D
         jSVnMlOoSNKFcMR6591CwA2kiYZ29z47GkGqIuE5LNXPso69E5EEFMi1wLt5TyQiQgzx
         jbhw==
X-Forwarded-Encrypted: i=1; AJvYcCURehkHa/1WvrDekiighvhxmDnMgypX0wjEkMdy5t6maCGQsFIiIEYdeZROfvoUZxgl9pu15CamVnH2QXDYE2DcDo+qBzi0NWOD8wCM
X-Gm-Message-State: AOJu0YxO++8HwzAMfxiVT6+BCM9pnyrgJSgVlTSmK3FcdBK/hRUl3VqT
	/yN34v0M/Ogp0yuES0Wtb+P3Q2iXgwtyDEMEJiSYx3TRnyYW/6RqcaWP414elmtfFUH4Rzh5ZGX
	90Tu0GeMO6dt7Xo/AX8OcliRc7umCna1mhFZKQ2+KzwaykaApSKWNed+JIEVIKw==
X-Received: by 2002:ac2:4dad:0:b0:51c:6c59:627e with SMTP id 2adb3069b0e04-5217cd49606mr61653e87.42.1715100952588;
        Tue, 07 May 2024 09:55:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/hrGdfZV+az9YscFnEoIqi8kKKgBXQyIsyla/Tt3dDMJ19H6muZFZnAeXsSR1oVFBSyo/uQ==
X-Received: by 2002:ac2:4dad:0:b0:51c:6c59:627e with SMTP id 2adb3069b0e04-5217cd49606mr61627e87.42.1715100952012;
        Tue, 07 May 2024 09:55:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:b500:3f9d:130d:ea00:afc7? (p200300cbc744b5003f9d130dea00afc7.dip0.t-ipconnect.de. [2003:cb:c744:b500:3f9d:130d:ea00:afc7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f4307ded2sm11264245e9.0.2024.05.07.09.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 09:55:51 -0700 (PDT)
Message-ID: <99358cd9-3f3f-4ba1-bd8b-898cdf819e2d@redhat.com>
Date: Tue, 7 May 2024 18:55:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fault: speed up uffd-unit-test by 10x: rate-limit
 "MCE: Killing" logs
To: John Hubbard <jhubbard@nvidia.com>, Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>
References: <20240507022939.236896-1-jhubbard@nvidia.com>
 <016d8cff-efc3-4ef1-9aff-7c21c48f2d69@redhat.com>
 <302d50ac-45ff-470e-90a0-b349821706a6@nvidia.com>
 <21d88422-7378-4a63-8fbf-f70889f309c1@redhat.com>
 <16ab2040-9d99-41b8-8b9d-39b0753533c6@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <16ab2040-9d99-41b8-8b9d-39b0753533c6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.05.24 18:53, John Hubbard wrote:
> On 5/7/24 9:43 AM, David Hildenbrand wrote:
>> On 07.05.24 18:28, John Hubbard wrote:
>>> On 5/7/24 1:13 AM, David Hildenbrand wrote:
> ...
>>> I'd like to just do this patch almost as-is, just with a fixed up
>>> subject,
>>> perhaps:
>>>
>>>        x86/fault: rate-limit to avoid flooding dmesg with "MCE: Killing"
>>> reports
>>>
>>> Yes?
>>
>>
>> Makes sense to me (and thanks for confirming that we don't need
>> complexity elsewhere).
>>
>> I think we at least need "Fixes:" (not sure if stable is warranted as
>> well, 1b0a151c10a6d823f033023b9fdd9af72a89591b didn't CC stable).
>>
>> Consider adding a link to the report in that thread.
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>>
> 
> OK, there's enough changes to the commit description that I'll go ahead
> and send a v2, with a new subject line, a Fixes:, your Ack, a link to
> the other conversation, and maybe reword a bit based on your feedback
> too.

Sounds good. We might want to CC stable: I just read 
1b0a151c10a6d823f033023b9fdd9af72a89591b and I think the problem there 
cannot really be triggered by unprivileged users.

Hm... thanks!

-- 
Cheers,

David / dhildenb


