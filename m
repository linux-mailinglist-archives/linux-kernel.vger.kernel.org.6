Return-Path: <linux-kernel+bounces-566844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BA6A67D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6CEB421CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9114207A01;
	Tue, 18 Mar 2025 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="rTWKLMyP"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A54920468F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327059; cv=none; b=hVY6nJD25ravjqq+Oxn0MfJELfr520XwDsgz9hMAO+GdLyOAEhINY3PJXjQmGOpLT98Xm9Z/JZD0D9A67uHg5tx+mrBmxDCvnS7atp4k9HiBu1hFNiDOahAI6uCrrGsPxXQlOkmee8OQUqkFXCDklFDdgYxKJFyUAX7LcQ0mZnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327059; c=relaxed/simple;
	bh=+0Fuh311HcmkwzNSHgY6ydq3cYOkXrULOuyqlKmtxX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hed59V3fgoWXLDouvA11ZP9l/N7dzFc+8Isv8uyV+lYp8e5MthMBW3bvhJbhDo+U5DQzKqPhmH/3oKZ9N0tTbyDh7c2crd8i71zb4nmBp0ts+T6oHh6/XeWg4+/W0xThCUJr6i6+MMhiLn9KH4i6ig/Xk9gWTOfDqo0+T5EzVkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=rTWKLMyP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso27438155e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1742327055; x=1742931855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+0Fuh311HcmkwzNSHgY6ydq3cYOkXrULOuyqlKmtxX4=;
        b=rTWKLMyPmO/AZtQTRa+w+XcyZnUngxAbpWWbF72shNGuWxA+L93/EFjMLh3vCAJ36r
         cFduTOoIJ3nvAQma3HsCjHvNU3AGH0Y7V9NT5HB70ufKDycjuy0el5e4w5lK8NYu0CCW
         X0LTixrodOCQw/3VzQzdeg1Ye+2LwQmEXd7zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742327055; x=1742931855;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0Fuh311HcmkwzNSHgY6ydq3cYOkXrULOuyqlKmtxX4=;
        b=dU02VMwPweXy1qgKAcSwSQzf3OhX7dzhlA5IjkemZl8MZ5uyHbKAdF5cUtAPU0wMTS
         6hvNxUG4WiUMYBfd4JGHBC3hJ0NMu5sxrHUuzbGd7km+Tp8CADbLIoTAh+MVVQbzGsZz
         iU3m6R2fH7kY/REJKNFF09qOOvGRCxbrYnWqpGrYI9KIPunE0+9qk7RvcwZX+Zi1QE0D
         hlZEtTTReuRd6ULjbQfanF5UT6KaBo+GFbL0TFmhXE3usyqI7Dt4k5poTzHVH+oxnLdu
         r5puVd7Il/plrj3FMSL5ffS/DY2E9zMwFfvIBiaElhq/ctyfGo46Mi12TwOM/Uzh0kSa
         2ACQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW+4+ylHfmPZsNWShlAp3zt6ecePXhYYCGNws4OazYt4sZE/2sjFB+XkWD30ydApchTL78DROjrCer25U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66QKIMZo8syHfRiNrBRomisag2Q6g/af4lbr4AXT8uBM4Gk1D
	ky9bNVQvATE1xKaqkf2XCzYqM5LQIj8UCF06SkMWQOi+PUyu5TT/HIfgO6nXpsU=
X-Gm-Gg: ASbGncsCYnQ5kHOqrOoX9A8Vm4ePtAxLZwzsCn198vV6iOBEg315vO/VbSnGIWBABhO
	02TQL09DXJapVasDeehCMc0YITuBSSDSK+SKK7uRXdF5qj+IT+J6dZsJkW9vnaREc8TZ4/uyRIC
	9RAx1UU+ckib4/NVe9vCjJ9j6ZfPfSe55FP96obi4YqkwzRhz4xnLldgsyNJVf/W7pEJ999SH37
	7+te6C7Tqc3TFxacrhWwD6v7z4qbScX+IEEcwV9MRnHMa/gX3DwCx4p7qTA5AJQ9Pu4pVA7bCww
	GtWMZELFcpvAmXE+dv2UzxXZBInXzpM78Fj1vfyf5L0Gx2q6fn+ypoBsfQTsb1twGS6mVRVjHML
	gTwhFTLuB
X-Google-Smtp-Source: AGHT+IGdwdfoh10YGvMxcrRkTY2pspX1eYrVehtLYEtgx/xlmWH74x3tq49FPEpRJxbqVbWqRYzwZA==
X-Received: by 2002:a05:600c:458e:b0:43c:fe90:1282 with SMTP id 5b1f17b1804b1-43d3ca66b96mr37384715e9.7.1742327055137;
        Tue, 18 Mar 2025 12:44:15 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb3189absm19309068f8f.71.2025.03.18.12.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 12:44:14 -0700 (PDT)
Message-ID: <674403fd-5c94-4cd3-aa6b-fc48879e641e@citrix.com>
Date: Tue, 18 Mar 2025 19:44:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] x86/cpuid: Standardize on u32 in <asm/cpuid/api.h>
To: "H. Peter Anvin" <hpa@zytor.com>, mingo@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Ahmed S . Darwish" <darwi@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250317223039.3741082-1-mingo@kernel.org>
 <20250317223039.3741082-5-mingo@kernel.org>
 <5D7935C3-8CAE-4821-8E31-A43169B8CB83@zytor.com>
 <bb1d6eb7-7dc8-49be-a4b5-aa461e85ac0b@citrix.com>
 <57505261-45EA-48B6-824E-49AF2203C094@zytor.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <57505261-45EA-48B6-824E-49AF2203C094@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/03/2025 7:25 pm, H. Peter Anvin wrote:
> On March 18, 2025 12:09:59 PM PDT, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>> On 18/03/2025 6:48 pm, H. Peter Anvin wrote:
>>> One more thing is that we ought to be able to make cpuid a const function, allowing the compiler to elide multiple calls. (Slight warning for feature-enabling MSRs changing CPUID), but that would require changing the API to returning a structure, since a pure or const structure can't return values by reference.
>> It's not only the feature-enabling MSRs.  It's also OSXSAVE/OSPKE/etc in
>> CR4, and on Intel CPUs, the CPUID instruction still has a side effect
>> for microcode patch revision MSR.
>>
>> There are a few too many side effects to call it const/pure.
>>
>> That said, when experimenting with the same in Xen, there was nothing
>> interesting the compiler could do with const/pure because of how the
>> existing logic is laid out.  Removing volatile and the memory clobber
>> however did allow the compiler to make slightly better code.
>>
>> ~Andrew
> Well, I guess I lump CRs, DRs and MSRs together. There is also CPUID for serialization, which is really a totally different use for the same instruction.

Andy Luto got rid of all CPUID serialisation ages back.  It's about the
worst of the available options, even on native.  It's IRET-to-self
(doesn't exit under any virt), or SERIALISE on bleeding edge CPUs.

> tglx has suggested that we should cache or even preload the cpuid data (the latter would have the potential advantage of making the memory data structures a little easier to manage, given the very large potential space.)
>
> The biggest issue is that there is no general mechanism for detecting which cpuid leaves have subleaves, and if they do, how many. I *believe* all existing subleaf sets are dense, but one could at least hypothetically see a vendor or VM define a CPUID leaf with a sparse subleaf set.

XSTATE is sparse in general; AVX-512 being the notable absence on
Intel's client line, and AMD has LWP at subleaf 62.

But yes, these are all problems trying to maintain an in-memory copy of
the CPUID state.  Maintenance of this in Xen leaves a lot to be desired.

~Andrew

