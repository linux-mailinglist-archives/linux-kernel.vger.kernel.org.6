Return-Path: <linux-kernel+bounces-364789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B3399D962
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10AFFB216D7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516A31D0E3E;
	Mon, 14 Oct 2024 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="FKPJFFcs"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96C81474B7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728942847; cv=none; b=IIuriCERylpvEFggA5kfRwr9Al3NfcpcxbH6BbaJSarC6CYvtiT5K8Ur24IV6P7WwpCSFpxVAVKIV/1fY+dsMoDxLfDQqThevWGO+w8IOM8S8eff8p/cv1yQCfG5Wr4+f2m16EFAZU6V45rt5lecHXEjB7becVUPWVBYB10SP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728942847; c=relaxed/simple;
	bh=K/Ct3IZFPedMTA/teu2nd5ZIsr8fp6lOGXWENzl8zWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKMWrQkoYhsuZU2EiLZ9eNBSeIeoJNiBfGaugjeOhUX0vtw2hlDdaMC6F3oxCwIyaPh5CIZCw/sX5qTAT6gzyoTS/ML7cs1E4PbRXJzoN/fWRiUcP9K3yr3Zfe8f7R43jDCTpx24206VMVkN0AdyHXYNMkcIbrXjcrbvl7Z6SAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=FKPJFFcs; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e63c8678so2324230e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1728942844; x=1729547644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K/Ct3IZFPedMTA/teu2nd5ZIsr8fp6lOGXWENzl8zWU=;
        b=FKPJFFcsg+yieYLfqg/NxM3fOcTUqyuuTr/algezW9CNddROS8aWjk8ChcjVvG2fT3
         K8SlgkoxGxeb2q4gVBif8wvwDflabkLQifqPajZpWa+tsvSR4qS1GZkxbuqUGTQEczGS
         qbU5pWHt+QBZaz+PlGCQol56p6KKf7KZbnt0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728942844; x=1729547644;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/Ct3IZFPedMTA/teu2nd5ZIsr8fp6lOGXWENzl8zWU=;
        b=R2YxPHir5vhWuUACj93APKclHhEu31Qe5hYIt+qrNkMZXHSdsyk7GatDMy9H+H/Mtz
         OigvNkec+hqmGRRLJRkSEfhAWsX4tZazXrpLT+akA2IeJyrYCS3Q9Ez4kI3x0JE9cePi
         u0G3zGRY34kvpwXmoA0pwsCgeSd4kzzcmL8cp03oocO19GH0JWwNiVlU5+p/u/3ANjgq
         KgprcgLm02EZKY6Pvz0vSg0Yr177WjsdL8OCaNGSsIQOJAdHpogMPbzZrM6oA9mPVyJq
         B7J4SC4jF0xut7+7ZE1o6fEDxjS3wB0uVakI+sYvB1wV3tqhH+33baqkGC9Agaa3wF1i
         w+LA==
X-Forwarded-Encrypted: i=1; AJvYcCWZAYjcenu4fQEo9sMkT16E7MouuykUu/fTvV36UKZwQ2S/+kgM9aiCqYSuIEt8Q6oupPRrzXsqy1EBkfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO+1G4W6cfqNF+0SfHLq3XZTEeCfoNPiZBppipZzzYEXs7pSIK
	t0v87x7WONJoF/d7xG5BejbJP2PavxC6FmTzU+rRdYH4sxEOvn6WdM/zGEdCHhc=
X-Google-Smtp-Source: AGHT+IEX8G18uEBj1LBNLu2Z12W3g2RV+IgTbg4b4lPizIvPx2/xtALGJw0QLonxHtdDROftLYBOiA==
X-Received: by 2002:a05:6512:3083:b0:539:964c:16d4 with SMTP id 2adb3069b0e04-539e551ff2dmr4391214e87.36.1728942843619;
        Mon, 14 Oct 2024 14:54:03 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f5698casm45105e9.14.2024.10.14.14.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 14:54:03 -0700 (PDT)
Message-ID: <7e621780-3b19-4b60-b8a5-c0727c1eb5fd@citrix.com>
Date: Mon, 14 Oct 2024 22:54:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] x86: BHI stubs
To: "Constable, Scott D" <scott.d.constable@intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Milburn, Alyssa" <alyssa.milburn@intel.com>,
 "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
 "jose.marchesi@oracle.com" <jose.marchesi@oracle.com>,
 "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
 "ndesaulniers@google.com" <ndesaulniers@google.com>,
 "samitolvanen@google.com" <samitolvanen@google.com>,
 "nathan@kernel.org" <nathan@kernel.org>, "ojeda@kernel.org"
 <ojeda@kernel.org>, "kees@kernel.org" <kees@kernel.org>,
 "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.707462984@infradead.org>
 <20240930213030.ixbsyzziy6frh62f@treble>
 <54d392d3-32b3-4832-89e1-d2ada1af22a8@citrix.com>
 <20240930223848.ulipiky3uw52ej56@treble>
 <20241001110310.GM5594@noisy.programming.kicks-ass.net>
 <a7912ce1-131e-4b30-bed4-2576441c6212@citrix.com>
 <20241003121739.GB17263@noisy.programming.kicks-ass.net>
 <630467e0-6cd4-441d-a2cd-070a002c6f95@citrix.com>
 <PH7PR11MB757220761F23360280DF4A0DBB442@PH7PR11MB7572.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <PH7PR11MB757220761F23360280DF4A0DBB442@PH7PR11MB7572.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/10/2024 6:50 pm, Constable, Scott D wrote:
> Hello Andrew,
>
> Your observation is valid. If we assume that the hashing function used by FineIBT is uniformly distributed, then the distribution of hashes at the call site and at the call target is [0,2^32-1]. The difference of the two hashes computed in R10 will have the same distribution because of wrap-around, and the mean of this distribution is 2^31-1. Therefore, to reasonably bypass the proposed mitigation, I believe an attacker would need the hardened pointer to be added/subtracted to/from an attacker-controlled 64-bit value, or an attacker-controlled 32-bit value scaled by 2, 4, or 8. Therefore, I think it would be reasonable to additionally apply the CMOV hardening to any 32-/64-bit integral parameters, including enums. I scanned the kernel (Ubuntu noble 6.8 config) and found that 77% of parameters to indirect call targets are pointers (which we already harden) and less than 20% are 32-/64-bit integrals and enums.
>
> I think that this proposal would also address some other potential corner cases, such as:
> - an attacker-controlled 32-/64-bit attacker-controlled integral parameter is used to index into a fixed-address array
> - an attacker-controlled 64-bit attacker-controlled integral parameter is cast into a pointer
>
> Does this proposal address your concern?

Hello,

Thankyou for the analysis, and I'm glad I'm not just clutching at straws.

However, I'm not sure if extending this to other cases works very well. 
While the second point is probably easy for the compiler to figure out,
the former is looking a little bit more like a halting problem.

One key aspect is "how far can speculation continue beyond a
mispredicted Jcc", but it occurs to me since the last email that there
is no answer that Intel will give here.  It is uarch dependent and
expected to increase on future parts, so safety wise we must assume
infinite.

And infinite is no good, so we must reason about "good enough".

My gut feeling is that blindly using the residual from the hash check
isn't good enough.  7 years of  speculation fixes have shown that the
researchers are constantly proving "this will be good enough" wrong.

So, instead of simply using the residual, why don't we explicitly set
%r10 to a known value?

Because we need to preserve flags from original hash check, we can't use
any of the simple zeroing idioms, but we could use MOV $0, %r10 before
the CMOVs targetting the pointer parameters.

But, if we're using a long-ish encoding anyway, why not MOV $GB(2)-1, %r10 ?

This way, in the bad speculation path we'll set all pointers to 2G,
which removes most of the risk with backwards references, and makes the
behaviour invariant of the hash residual (which itself reduces the
opportunities to leak the hash value).

So I suppose the real question is whether one extra MOV is acceptable,
and is it good enough?  My gut feeling is yes to both.


To the extra cases, they can of course be added if the compiler support
isn't too horrible, independently of the extra MOV.  But, if 77% of
parameters to indirect functions are pointers anyway, isn't it work
considering CMOV-ing all parameter registers and turning the 57 stubs
into just 6, and improve I$ locality?

~Andrew

