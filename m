Return-Path: <linux-kernel+bounces-547562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CD8A50AD4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2C618844BF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D60253330;
	Wed,  5 Mar 2025 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="oXarqZDv"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFBE1A9B2C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201311; cv=none; b=E1hAgqleuqO/K4GvbnotYTazapYqGiif5JKfwlm9fP298uWK3cAV0/Eqd6KMNYrSDZEIKVh2wmUwxLrl8TQh9xriKr/imRxlgMUP45jfhuvwi+B1CedFxkLpeUQPE+A6Wax4T4yxNyXlqngLNx7mv/j7sJRHC+sj3kDl+75Bp8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201311; c=relaxed/simple;
	bh=6BLD9Z/hGy7Ht1wALMaxSo5j9kppcw+vDPIX5QwEoJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUyFjVr1Yu4eIXi83mfH2kMkjslqMHGybsSREVt90yR3GEWFOyvlqlgJ8qfYjgw5c4aUM/ma1+f+q2Ifm2Yz38E6vvgGsH8D47zH5vLUJaEqUbR0dYKQazIX01I1ktkjdRaGArbwLI/ezSliLqrj7EXEROGZ8DTmk5ZXIlgE3gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=oXarqZDv; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abf48293ad0so784311566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1741201307; x=1741806107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6BLD9Z/hGy7Ht1wALMaxSo5j9kppcw+vDPIX5QwEoJk=;
        b=oXarqZDvLcpb3ST8UHWWzpsInEva8TGArnUFEZUgg71co/XNDlt4IQvOf5jXnP3t/u
         LY2Xp6qQ8HltvDdjqInvSJcMNw+kYN8TBiOr19kZXhbaxshlgtz2Bhaecks+1HdyX1FP
         taexLmU8/G4R9fyVFH92uT6knK++jJZ8Kb0T0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741201307; x=1741806107;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BLD9Z/hGy7Ht1wALMaxSo5j9kppcw+vDPIX5QwEoJk=;
        b=qSdMCYs2ifOwp53Caa5RyZOrCNnpnbA/OHxb4lkL9ySAddEmZEoiB1NN3o6H0OXsip
         LCoGqb5mpXY6F0Yk0GySoeM9Pw8Yk0cnoiv9f7vEjnaxn1XXFNXH0phwwXIkzBCLlqnC
         k9THvgz/zZkthtq4Ka3gBknwuIkSibTNF4Rwpw5Qp0dlmCPIuJYpUUIDVdDqP/D981Nr
         RVMLtImGvqkuysU1iFZz4IoNJt79oUA9H6Lj+MbOokASCPKNJEcWiw3M9wbFG9MKi/L7
         POsKxI3FQ2YDoNJrONXH3hzzW+aB4uhra8RelLlnj8vkEkNJeUnMnDJn0tewbFwf8RdR
         gAHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkEGEOFkFIH+YK1KBCvNVNu9l0zr6kMVYXqvUba2PJFFFT8GsCzJZJ33iHdRa3CWEJR67EMHB01yMQ9WI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFNLWv/XdfybdOiFQ7R3pPjuDu9yVkKReY4mHz7zNe4S4k3Axu
	Gzr6tLp2ULvjkBxJw2W3CXX7BUA8Ybk6KSMdhOpEICaSd11xZTgtzu0MCydHf40=
X-Gm-Gg: ASbGncsBlFx4aqvgW7iszKn8TpqNB+W0S5VLBNtlv4bDwwks5VQfktW6UR7+jzUem7S
	3iE1YT99DGVlMjZ/B9/3PkunyHDgJ6iE/h16Plp1OrTeT3stXrdqU4C0V6Og1qoEr1VU8HHYBvB
	2am8mot6W0ANMsfpniHJ7tYKCtT/64pamu5NinjhQMyc8qcF98Rc3hMepUA3VU4Zbw7FMUrHZ00
	MnmqFw5qQdvZZ9TzKRXg1Z0cadgDWjEzQ3gwaqBNWC8EnUthQ9HIJcoySIyyvCP22Ay6tAdGEpg
	9DtmQJNday4SCbhsnP1pL5vJ2vhYepAu9cJvsjZIk7XfywK1m4EIJTGr/DyWoSdUhZ7YJj+XpwH
	fzdo/RS8c
X-Google-Smtp-Source: AGHT+IHTYFuxIjvJYTQv+7fq8irerSI3QTG1wMaacaKDnFUC0Pw8uOD92wk01Y+rMdmCuAm1EtCsnw==
X-Received: by 2002:a17:906:6a27:b0:ac0:6e7d:cd0b with SMTP id a640c23a62f3a-ac20d951583mr435653466b.34.1741201307348;
        Wed, 05 Mar 2025 11:01:47 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf7710fb5asm585568166b.10.2025.03.05.11.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 11:01:46 -0800 (PST)
Message-ID: <a2acde2d-d3bb-496d-bb65-e1ff322f13c4@citrix.com>
Date: Wed, 5 Mar 2025 19:01:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 37/40] x86/cacheinfo: Extract out cache self-snoop
 checks
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, John Ogness
 <john.ogness@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, x86-cpuid@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
References: <20250304085152.51092-1-darwi@linutronix.de>
 <20250304085152.51092-38-darwi@linutronix.de>
 <01367a6b-8eeb-417e-9a66-e7a64d518319@citrix.com> <Z8iahUTYuq0gVXmP@lx-t490>
 <6ba638d3-b3a3-410b-9761-0b3658e3215a@citrix.com> <Z8iewiPz4WZOdmbE@lx-t490>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <Z8iewiPz4WZOdmbE@lx-t490>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/03/2025 6:58 pm, Ahmed S. Darwish wrote:
> On Wed, 05 Mar 2025, Andrew Cooper wrote:
> ...
>> It turns out not to be safe in cases where the underlying physical
>> memory changes from cacheable to unchangeable.  By skipping the WBINVD
>> as part of changing the memory type, you end up with spurious writebacks
>> at a later point when the memory is expected to be UC.  Apparently this
>> is a problem for CLX devices, hence the change in the SDM.
> ...
>> CLX (Cascade Lake) != CXL (Compute eXpress Link).
>>
>> CXL is the new PCIe.  (So say the CXL consortium at least.)
>>
> Oh, sorry, you wrote "CLX devices" above, not CXL... Only thing my poor
> brain could come up with was CASCADELAKE_X :)

Oops, so I did.  Sorry.

~Andrew

