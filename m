Return-Path: <linux-kernel+bounces-235006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C01D91CE36
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 18:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5651C20FB3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 16:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91B212FB0A;
	Sat, 29 Jun 2024 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J/S6YhWe"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2571839E3
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719679814; cv=none; b=PKdDEZtXtue7HhGIZFiID+jOQoWMuc3B0HnEcgLvU5tX40YiAaOZtDnzCDCrKeun+EmFbUfZ9Fp5Efj5tjLnEMmjzgAJU981UrnizSO3lc6fG8nlhfMp+uhYqHURHXKA2z4YqxUQitH0dfyx12EC7cEy1ivRNZ+R5N6Nc97KfYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719679814; c=relaxed/simple;
	bh=10oL9AMvuLwwVtCMC7BHvX1JE4xKZn3dswe8y+fUP6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JuZxGoJuHG60CZr7C5yVDXwNgcIadmnWuXzjFNi0i0YttE+pgwj72CABCeqrPXLUutcHly763ezyMUuEtEhIjP4R+OMKpakdXjxGJhPMrUaR8PHuPCj+FnkU4GQV8lxpqFrZ6S+RvvwdRxkR35hZn6NtFV7rC8u+DrHzWBNCP80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J/S6YhWe; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso149205266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719679810; x=1720284610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBMDt+8jA08q/p80DdkymHwXPRFldtei4zyGks2eOfY=;
        b=J/S6YhWeZ1gcJSjT+D+33UoEqbDjRScWcGCQlM+lyjUUrOMiAGaJIPamH/+agXhc/u
         ttnf64MIgW/BH+KF6U2vSFyG4tRHC72jHzXNp9QTb3KjYPHC0q7W8w+ZYnNoGYeQLG7X
         xD6RCxKd/IfTkIbiXFGacNO/z6XXIwy4LydG+Ex2BZ8KXbFmh/ZIcKpX+FcBJr46Szz3
         zj8lmc5tejSqKDuplTLvOmsCHlc18ByIcYzBLoD1ChSuuwhlA6LR2el9OUGJycXMoWaq
         5hcbi6abgSl+bZpeoQs50p5G8zUBjjSdKKh+9KF0qieuu0oSYznDFNqFwzoLkT4U4Jjl
         e7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719679810; x=1720284610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBMDt+8jA08q/p80DdkymHwXPRFldtei4zyGks2eOfY=;
        b=R6ZvcYVzrzvhvXQ/6AOsFUd1SHSQvX+Gey0A4zs4tn5Us+wnzcsN6/zCwHWZYK0cYj
         Fnr7uE6mhjRhAjkYjijI9YBMhYR360Z1koG/lqU9ur9OP4YjjZ+01p3TN49DzG91w8JB
         JAdCcOzVML4tSAXL63L2W8/rgIWedHVYHwDDrwcTpxM0zgXdCziNod12mABy09B0P2Hq
         2YqpfoYTEo9MR4ZhvJBCCIG4GIXdVCqRzZimwlY+H2jzbrUdCPMxaDOfXMW6lMfQPCF6
         5TEAKass5NPPnFmFupl4vjxqXhiEPPhHwxF41hbwR0Juv5q/jO0Nua0A7CdAAL5jzFAq
         KRzA==
X-Forwarded-Encrypted: i=1; AJvYcCX48nTb3nO5+fIZMepBU4IjbO+ptTkiN4fCx7z45XKhfYYOAlRSJn5GTznT31tQnZyElUzKvih/ba4GaZZIdgFWzacx7JIowOQUUkAY
X-Gm-Message-State: AOJu0YzfHStu63Ak+hV9NkG9Zc3BUVGZgDb0cp31klTkiI9FdKXjC3b4
	xnVkhWTgl6I8U7WNtUHPbzOYq8MonX9Yx4B9BvqLojS4aW/BrgPnJAzOQ8pZZvk=
X-Google-Smtp-Source: AGHT+IHvwR+S0H8B75vhf9qeQ+kHGKTeTw4A/GkQ/c76b/iFHFfjBt3yzq6qn6cYazPMr6u5gUJHbA==
X-Received: by 2002:a17:906:5619:b0:a6f:4fc8:265f with SMTP id a640c23a62f3a-a751442416cmr83177266b.42.1719679810081;
        Sat, 29 Jun 2024 09:50:10 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab065667sm176551266b.114.2024.06.29.09.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 09:50:09 -0700 (PDT)
Message-ID: <5e6f2c81-f33b-4a66-b12e-91c88ae2307d@suse.com>
Date: Sat, 29 Jun 2024 18:50:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: fix lookup_address() to handle physical memory
 holes in direct mapping
To: Tom Lendacky <thomas.lendacky@amd.com>,
 Ashish Kalra <Ashish.Kalra@amd.com>, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de
Cc: x86@kernel.org, hpa@zytor.com, kirill.shutemov@linux.intel.com,
 rick.p.edgecombe@intel.com, mhklinux@outlook.com, peterx@redhat.com,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, jroedel@suse.de
References: <20240628205229.193800-1-Ashish.Kalra@amd.com>
 <2982a4f2-ea8f-4fa4-81ea-d73c00fc2ad0@suse.com>
 <76d96581-202c-80ce-eb26-8f906660c8e0@amd.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <76d96581-202c-80ce-eb26-8f906660c8e0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29.06.24 17:16, Tom Lendacky wrote:
> On 6/29/24 05:20, Jürgen Groß wrote:
>> On 28.06.24 22:52, Ashish Kalra wrote:
>>> From: Ashish Kalra <ashish.kalra@amd.com>
>>>
>>> lookup_address_in_pgd_attr() at pte level it is simply returning
>>> pte_offset_kernel() and there does not seem to be a check for
>>> returning NULL if pte_none().
>>>
>>> Fix lookup_address_in_pgd_attr() to add check for pte_none()
>>> after pte_offset_kernel() and return NULL if it is true.
>>
>> Please have a look at the comment above lookup_address(). You should not
>> break the documented behavior without verifying that no caller is relying
>> on the current behavior. If this is fine, please update the comment.
> 
> This brings up a point from my other reply. The comment says that it
> returns "the effective NX and RW bits of all page table levels", but in
> fact NX and RW are not updated for the PTE. Since the comment says all
> page table levels, shouldn't they be updated with the PTE values, too?

Hmm, the comment could need some clarifications.

It returns the effective NX and RW bits of the levels above the PTE. Reason is
that the function is used in case the NX/RW bits of a PTE are updated, so the
PTE settings are not always really important.


Juergen

