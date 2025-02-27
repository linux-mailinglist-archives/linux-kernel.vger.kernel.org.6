Return-Path: <linux-kernel+bounces-537409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED8CA48B75
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D072188F676
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AEC274247;
	Thu, 27 Feb 2025 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="cYTjlhSI"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DB3272924
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695018; cv=none; b=qiWRw9XddVPo3sEkwuHl+3cYMBt6jQCQeKS6QaGj4OuttcCdcPBiy/TYRC1VHsa7fK3qHzHFrrFMXia7/49lDseionW51zw9chQFE9z6h8145pQdRLQF7F9CQpmmZgiIWPkfCAQaVMZhZ4AkWLGdBsNfulhxGyh8Pmn0pQqw5+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695018; c=relaxed/simple;
	bh=yBf2GiH2DndOHmd3dleyNxE1M6IZg0mpqPK0LDto4BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r84WvWfsWMn7VrKXuNhcOkHVMJ9QaeSUtbBIhTdJqOgxBQGSiWqrFBTbCflJxypOGLke8ulENfSxhJuljW00hNomyocRyJGd6z1zNtOgTl5I5YWBTl7waH7Qu5uiIEXnbXRRItELxG8+IjVAi2LlwgFZV4EC5KVeR1qXSadiYms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=cYTjlhSI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43998deed24so14367455e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1740695014; x=1741299814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nc0wnSKaiyBx0XEghObW7p9UeWF4XwuvJlERpK88ezU=;
        b=cYTjlhSI/aUTveKAXPaiCkg6Guyas68Uhs7CWpJMKZRJfY6bz/UYOBLfTxAasT1mdv
         4m3BFLvbxzs/WArba4cG68T0JtR4kyic7JgDxTdwfbJ7O5+6mLQpoSvA2wkJneoViwK9
         Gbm8USF0tz0jyRco+yNxT7VZbigIRV2xslHj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740695014; x=1741299814;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nc0wnSKaiyBx0XEghObW7p9UeWF4XwuvJlERpK88ezU=;
        b=s4J3IJi+NoWw/PTvy8OkGszlcwZ9/pDFpVSYr7CEl3k6vRkCmH4s/6aCC87xLXEHHT
         SnIapg96e6EKY/VwC3IA2qsAwkHTDvOkXzJgBjAvjM+tn3MIxGbCfdaEiiepzjKdRjOt
         xHcTpJpzj0DJr7IQ/VF84krLG53tSS1yaU14zVwxZ8BMWXYKXLK3K66C60E02mW6BWMD
         pYmtRmQtZR46+yTWHZXzi4ulATqFEnLFkG/+uTAMMk1Uu3bM1sPVKLU/bzQYqc4yKgeZ
         52tBT4B1qSgH/nwn239dYCX5Cjn4w8CMpMOU2o9cg/TZpptwhMe8w68nni2Z6Iw6qlbR
         YN4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVurFFMbt241WKkhZgYUvTefzj8gnH0yMe0Y6y6ZFKpe1j672xEpkpAfTqy4A3n7awpB5dieOXoTwceR6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDlUCmWJACV2llSKi8vO1uUgNBqbBlH61KdoogYm4H0WdGfxdp
	dS4i4IhTG56PRVmriyeqck8DJ/D5CCZrC6pvc/cBSbpqHfHj8+yLNuBnE8xcjRw=
X-Gm-Gg: ASbGncsWt0gkdGx1EmuDi+MeTM3O86K8nNVfOQuC8zwVxe9ISSObhllePCHLfmS6r+W
	aqyWLj61SS0u84Wm5YwPcqhdtG2Onkt+uxf0eG/1B8QWRrFbkK4eYtN6xofyZO1wDlQIPTiPVQi
	EeE75vSY2L1dlB79CeernYFlVe7EDg+8UX3ZNJJnzMsIb1iS4oM+Sj3jbtKpFbexaB9xuDQoyYe
	DJYkuQKWtBvuWszgtztkmEkq1XgfmKzr16kusa8zkoVaD1H+7uw15kXCZ3ZHNNQHnu1/l/ce/MJ
	yNnfX70qFYdffMrShl2OJJObXmF2QjW013IZDKDZCt1w7YCm0yyYGWwY6fsW3lFTdQ==
X-Google-Smtp-Source: AGHT+IHTISNySSIBPoKLKvz1F9hb3EJitCO3o8D67sTtGjSpunY6Ifmd0pMZmtJHC5EPJn/RAnaGAg==
X-Received: by 2002:a05:600c:4705:b0:439:9f97:7d6c with SMTP id 5b1f17b1804b1-43ba6766cbamr6611115e9.29.1740695013893;
        Thu, 27 Feb 2025 14:23:33 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844913sm3282584f8f.66.2025.02.27.14.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 14:23:32 -0800 (PST)
Message-ID: <b14c166b-a66b-4ffc-a2a9-d771002de0ab@citrix.com>
Date: Thu, 27 Feb 2025 22:23:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order table
 and accessor macro
To: Ingo Molnar <mingo@kernel.org>
Cc: bp@alien8.de, chang.seok.bae@intel.com, dave.hansen@intel.com,
 dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
 tglx@linutronix.de, x86@kernel.org
References: <Z8C-xa7WB1kWoxqx@gmail.com>
 <94083f1c-dab1-4b57-bd45-a4d4f8ac262e@citrix.com>
 <Z8DFusMiUYPZ3ffd@gmail.com>
 <ea20d47e-88b9-46ab-9893-26bcf262d8b0@citrix.com>
 <Z8DY7P6UJFyCg47Z@gmail.com> <Z8DZcj-jrTJIOat8@gmail.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <Z8DZcj-jrTJIOat8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/02/2025 9:30 pm, Ingo Molnar wrote:
> * Ingo Molnar <mingo@kernel.org> wrote:
>
>> * Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>>
>>>> There's no incompatibility for a default-disabled feature that gets 
>>>> enabled by an AVX-aware host kernel and by AVX-aware guest kernels. 
>>>> What ABI would be broken?
>>> I don't understand your question.
>>>
>>> XSAVE, and details about in CPUID, are a stated ABI (given in the SDM 
>>> and APM), and available in userspace, including for userpace to write 
>>> into a file/socket and interpret later (this is literally how we 
>>> migrate VMs between different hosts).
>>>
>>> You simply redefine what %xcr0.bnd_* (a.k.a. XFEATURES 3 and 4) mean, 
>>> irrespective of what a guest kernel thinks it can get away with.
>> XFEATURES bits 3 and 4 are zero by default in the CPU, so the previous 
>> ABI promise has been fully met: MPX is unavailable and disabled.

I disagree.

XFEATURES is defined in the spec, and the spec demands that userspace
checks it.

XGETBV(0) & 0x18 in userspace has a very well defined meaning that is
MPX and not "MPX now but something unrelated in the future".

>>
>> I propose a new addition, an extension of functionality: if a new CPUID 
>> bit indicates it, and a new MSR is written, XFEATURES bit 3 becomes 
>> active again - and the MPX area is now used by AVX. Obviously only 
>> AVX-aware host and guest kernels would enable AVX.
> Erm, s/AVX/APX ...
>
> Too many acronyms.

With semantics like that, the pipeline designers will also be coming
after you with sharp objects.

~Andrew

