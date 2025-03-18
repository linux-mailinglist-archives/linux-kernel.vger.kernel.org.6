Return-Path: <linux-kernel+bounces-566107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C9CA6733C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8AA19A2158
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41CB20B1F9;
	Tue, 18 Mar 2025 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JlZ/J2RE"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A12F3FC2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299023; cv=none; b=StkhQ0ibyWd/DX7UFWsxuqmgd2JQ7JVeuNyRYDojQNHR+2tELQ3pYQx1uG9nBh0FllZbKFcrAwsPIv0fZdXXlGvurwXLgnbSwQJHkZtgNKARlgJjANg92NK3f96BYKna9iIB1biOn58Ndw+MN1B4W2xiyc5VUE/KoWTM/k4ASPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299023; c=relaxed/simple;
	bh=v0I0B7d/T1f4zASXzgrDH9mKNo1JnOE8sg0orZVnj4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESbaajQc05fFOjVmGWr7uH+9Mzmqs75Nq9N+SUAv2F8WMEy4zneyeCu9DHx4HomdEIHDjXuQ0Jfj0pa365frUjsNjIzvNnXgFSmGEDDTdT2BmiPCb4Fx6kxMRYJt3OifbB9Wn6Rkbg9jNDyJ4oeZhY0Vd4489KFkdKwjE86jlKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JlZ/J2RE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac345bd8e13so493700366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 04:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742299016; x=1742903816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D6/x9gkT6sgVM/ewcYURbIyaLiojuCegPHSKxVXvwbE=;
        b=JlZ/J2REURo0sHXxxIff8vQq88uSe3r0+BAndfM84NVfMJrZJpYBmWbx5EWldXp/13
         4KujDHaUVlg8NG5DhDcyQBEpA7NL9UpCK5VF875M0d0Lu1rHTa/wao+cA9OoHAKDHE+V
         hfpCtzOQK5gQ3AnSuHPf7RVRtD9brj+CrE176p1Omrf6FGGEJqC208odf+cNMox+9k8R
         TllhrbZ89Uez9zqIHXUcMuP+L+wY4cTkKqOAHD2Kx/Xz2wqcVXA4YMzQvifmnp/tHZaU
         43Ath7TiDw79NMAmY4ljbczC35SwQTITY6dAU7Y5spD8uNyca1B9eZ2kx3M9EOdUZ058
         qBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299016; x=1742903816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6/x9gkT6sgVM/ewcYURbIyaLiojuCegPHSKxVXvwbE=;
        b=QNAHzVWDyfb4pr3hYmPcsgzbA+vS8Ndb8RSLhFW53ablcsm18GpiyP9LeGrGkPiPtw
         Fc7bx6tqUQkUtC+6Sx1h9/UGUnQk5NQ/tZK2TAlW4WBMn3kEJsWF0/DA+rkd8KgMoziW
         r5QhiUN0wRbE9M8Mbemz81Lgqi7KR6wWh43XMaozc0unrkz2dEzf0ja4DpN2FT5SCGM3
         wgciV0ewT09/2OOCx8pkOh0YQSRgeyRWm1YlgEgNgEoa3TdD37wODZGEnnwytfJUlGiT
         QI3YS8w+nJP5PiomT0xakLMOMbv10IXlmPAlohE7prJd9oTLEYBhkNLlo11szn7V27bO
         fkaw==
X-Forwarded-Encrypted: i=1; AJvYcCXG7qNVftd8HKw0Lqa8c18d6IGvS9B98EC5Zf8z9eRRiKP7Wae3WgK7R8MYS6K9A1QfjprPsAOPGJoa9Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUKcSBlhDs8ucCSeopuIR5n3Kvx55kUCA/VZbOUM8t372AhJsg
	GKJUufo7x9t+xvoDcS/zZoxT28wVGOyrLlN2KPOw+KQ7BbEy4++5JjuOYmmHlcY=
X-Gm-Gg: ASbGncvWfeN1ScVNYzSpPVFGTTFqzUDJPhiin/CH5H/qcmMJ1IWuAE26r8VzzLP2ybJ
	YmxDfqOO9irVpYlnTCSx0PEtels/f8jPYFPUIEct373P61qbcBGEO1ASe4Np8Ll7OA8F2d6AkYM
	gj8PMl7O8lW8GMHalex8m1gVtopAEGt8kuP0ZyC3A7gF/E89FN17uXM9WSj8LhNeSViDg/UMabI
	pfM2pAVWcPl+FLb5bFY/7vNxBtgFZH/2FQzrk2ll17BG4yp08ZPS3TSp9Qlh/Wvcyb2M2KA4Xh/
	ZLtfOAZ+ASXUJj6w02zWH5ZcRKMf1mLU2AVW8vnUpxDg/f30pLbVAQ/2XM/8lE0zihQlMIohMjV
	FZYcPhis=
X-Google-Smtp-Source: AGHT+IFAZyvgcXWZ/+SVidWj+0roliQMal0vwYcucW/pBQISCZLZ0OR4AwYuQzHLIm/kOpugXfd3dQ==
X-Received: by 2002:a17:907:a4e:b0:ac2:344:a15e with SMTP id a640c23a62f3a-ac38d410d00mr337157266b.22.1742299015703;
        Tue, 18 Mar 2025 04:56:55 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.143.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3863146bbsm197809266b.146.2025.03.18.04.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 04:56:55 -0700 (PDT)
Message-ID: <0e6691bd-b390-48fe-a132-21db4ac5ff27@suse.com>
Date: Tue, 18 Mar 2025 13:56:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] /dev/mem: Disable /dev/mem under TDX guest
To: Juergen Gross <jgross@suse.com>, dave.hansen@linux.intel.com
Cc: kirill.shutemov@linux.intel.com, linux-coco@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org, vannapurve@google.com
References: <20250318113604.297726-1-nik.borisov@suse.com>
 <24826c2b-f1d2-408a-b8d1-63e1882b0fd0@suse.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <24826c2b-f1d2-408a-b8d1-63e1882b0fd0@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18.03.25 г. 13:53 ч., Juergen Gross wrote:
> On 18.03.25 12:36, Nikolay Borisov wrote:
>> If a piece of memory is read from /dev/mem that falls outside of the
>> System Ram region i.e bios data region the kernel creates a shared
>> mapping via xlate_dev_mem_ptr() (this behavior was introduced by
>> 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()"). This results
>> in a region having both a shared and a private mapping.
>>
>> Subsequent accesses to this region via the private mapping induce a
>> SEPT violation and a crash of the VMM. In this particular case the
>> scenario was a userspace process reading something from the bios data
>> area at address 0x497 which creates a shared mapping, and a followup
>> reboot accessing __va(0x472) which access pfn 0 via the private mapping
>> causing mayhem.
>>
>> Fix this by simply forbidding access to /dev/mem when running as an TDX
>> guest.
>>
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
>> ---
>>
>> Sending this now to hopefully spur up discussion as to how to handle 
>> the described
>> scenario. This was hit on the GCP cloud and was causing their 
>> hypervisor to crash.
>>
>> I guess the most pressing question is what will be the most sensible 
>> approach to
>> eliminate such situations happening in the future:
>>
>> 1. Should we forbid getting a descriptor to /dev/mem (this patch)
>> 2. Skip creating /dev/mem altogether3
>> 3. Possibly tinker with internals of ioremap to ensure that no memory 
>> which is
>> backed by kvm memslots is remapped as shared.
>> 4. Eliminate the access to 0x472 from the x86 reboot path, after all 
>> we don't
>> really have a proper bios at that address.
>> 5. Something else ?
> 
> I think a crash of the VMM must be avoided, otherwise we have a security
> issue due to one TDX guest being able to DoS the complete host.

I agree with this, however this particular crash I haven't been able to 
reproduce locally but was something that came up in the GCP environment. 
So I'd like for someone from google to chime in.

> 
> I'd rather crash the guest for which the SEPT violation was detected (is
> this possible? If not, don't allow it to run any longer maybe?)
 > >
> Juergen


