Return-Path: <linux-kernel+bounces-237267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFBC91EE4E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908281F213B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A06E4CDF9;
	Tue,  2 Jul 2024 05:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cckjuWzS"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEC32A1D7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 05:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719898190; cv=none; b=IimwXy37JndpOWSwAW127d/RLNZ7bWk96MxLHdHFYfMb8xOAYsSc3t3tTl0jGU8WZDzmpOku94ios7Zq9icW+Ne4qALzatunIksEHh8CID1/S7YpaabdhjQUXsl5EnpW/hbmqX02xqCZn/54Aiy+ERmKFOgF+3EA1or6JWUWAls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719898190; c=relaxed/simple;
	bh=VxUmiJf96Nnk75owUbMVNJQRo1e/6DgjlcUcCnu3RaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOQytzODUMR1CWQu7HzP33fvkQxDMv9q6pUBDvRl39JxR397vGeBaPxdN3y03CYuC0TWIv+Mk7uyfVLlWdbYSpGbwY4gjEIaDuZ3L7FqfWz/v7v2U5fIy7XGP/tNbqviQEKPnpdxOMiMmxJyGbMCVfD9WCwsmhZTjCuGFL1uKaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cckjuWzS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42578fe58a6so17840025e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 22:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719898186; x=1720502986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lpqSb527f+PFINHEbqoKS8w2DyBKf5rsE1sD0dCz+Fg=;
        b=cckjuWzSTGdl1CRIf/tX80dTMwDKShR3GopUiwNGwPLpxmJsqjWmjw3KnyBL6fBtKe
         EJQ9hJpRhk96/qIJ2xDvK7m1CSHXdWyPquizRcJ0dy5SVD543PWYZEg00wuun7/fHfUo
         F+QyRnYRPkF7XCutPrPJE5BOPRNYZcidpCldvpWn3tW0dy63tgRtbcgPthnY0Ak2Iepc
         y3VnzvlsEpmdvgDxzLPBjrIWCqWxRDgIwQlgjDMF93UG0Zs00lwDXDuLdRxOaKl/t5lB
         4plZagCY3geM85IOgYYXNOPLaBMXVBb5kf+9qcvmfm9lV9rIr6IbQ9okU1rf5t2MNOu0
         k3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719898186; x=1720502986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpqSb527f+PFINHEbqoKS8w2DyBKf5rsE1sD0dCz+Fg=;
        b=U1Yf0I1rTK9K025ADbf+emhaLG6JN8uadbMjzih8/wJOIErhSDXatuQucFVY3SNMbl
         Rdm5u0SvirK1Eyvl8yV+MWg9UfBTUj4tzkPMzJW79OMD90vZdkWsYcraz+8J+oWLAk2X
         DnizFlw3KUot60BI6S8jut7SICy6CPjbWndRLWPqJkhCG9anS19NFCV59ECo7h+hPfzz
         0RElXGKk26VEyPRxxduRJ7L1xHp8GbGlZwGeDZs9GUlubNdiaQxpgbo5VFmpReIisouW
         vHFnvPk+Noqy5w68c12yIa899OzuRWFB2ILwrKyr96hxrL3yGg+Ik/vt42KgaCbfqwix
         KekA==
X-Forwarded-Encrypted: i=1; AJvYcCU4TDObZHU6zp/Up7fDK9ZA9DIenFyLY59nZpvA2IUvxFcpfOkrOTPka3Ut0z7AuBpE1l5geLtEn1NzGLxlWtqMKT4QosQkeZjAK5K2
X-Gm-Message-State: AOJu0YxCrur0wpG5r+IHlgqk8c5MlaPDFVUrJuLXKI+aeZuzMrhnS8BB
	2EuXodYkB86ipqoKEQYqU868XfrGTk1E687m52DiiiglYgkrGH8IEYctkECy47Y=
X-Google-Smtp-Source: AGHT+IFC79EDVb+wzbCjhg3hi97sgP3c0sT3OIuusdDX97azxyjFmnfMof+llEl5T/+JESH0HkzzCg==
X-Received: by 2002:adf:e703:0:b0:367:3594:39ac with SMTP id ffacd0b85a97d-367756b75fdmr5795910f8f.16.1719898186492;
        Mon, 01 Jul 2024 22:29:46 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fc4c9sm12030213f8f.86.2024.07.01.22.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 22:29:46 -0700 (PDT)
Message-ID: <89aa51c4-20e1-4284-9ab4-bb505f261bea@suse.com>
Date: Tue, 2 Jul 2024 07:29:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: fix lookup_address() to handle physical memory
 holes in direct mapping
To: "Kalra, Ashish" <ashish.kalra@amd.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>
Cc: "x86@kernel.org" <x86@kernel.org>,
 "mhklinux@outlook.com" <mhklinux@outlook.com>, "Rodel, Jorg"
 <jroedel@suse.de>, "hpa@zytor.com" <hpa@zytor.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
References: <20240628205229.193800-1-Ashish.Kalra@amd.com>
 <2982a4f2-ea8f-4fa4-81ea-d73c00fc2ad0@suse.com>
 <5cf60d52-1682-4244-b892-688b22eaf4a1@amd.com>
 <8d970528-0e57-457f-ae00-862b4d320a2a@suse.com>
 <0dfcaae1-9ee7-47c5-b530-2062021155f0@amd.com>
 <25478bbd92a0dacb6d52d7ffd214374e151a9338.camel@intel.com>
 <306a9358-a452-4595-b1d0-8e38a53d9084@amd.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <306a9358-a452-4595-b1d0-8e38a53d9084@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.07.24 21:39, Kalra, Ashish wrote:
> 
> On 7/1/2024 2:13 PM, Edgecombe, Rick P wrote:
>> On Mon, 2024-07-01 at 13:59 -0500, Kalra, Ashish wrote:
>>> Then what is the caller supposed to do in this case ?
>>>
>>> As the return from lookup_address() is non-NULL in this case, accessing it
>>> causes a fatal #PF.
>>>
>>> Is the caller supposed to add the check for a valid PTE using pte_none(*pte) ?
>> I did a quick look at the callers, and some do their own check for pte_none().
>> But some don't. Some also assume the return can't be NULL.
>>
>> Can you elaborate on your goal for this change? Just a cleanup?
> 
> Hit this issue while implementing and testing SNP guest kexec.
> 
> So trying to understand if need a generic fix for this issue or do i need to add my own check for pte_none() ?

Please add a check for pte_none() after calling lookup_address().


Juergen

