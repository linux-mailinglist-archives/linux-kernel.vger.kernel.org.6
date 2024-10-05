Return-Path: <linux-kernel+bounces-351685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD759914B7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 08:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353FFB22694
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 06:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA5C49620;
	Sat,  5 Oct 2024 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeOdST8O"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7FE25761;
	Sat,  5 Oct 2024 06:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728108247; cv=none; b=E7GaVGEdXTbChBuqO1SM/6ZMkKAk2kgMbP2LryT6UI8HdOJwm6apBRiF/2R6LYFOx7giX/Q8blfP2ZhYD9exWRIuUCz909r5BLkzwg6IcJGYDXW5IWHMF1EnfG6fqrAPcT6C8lneXcZ8U66Ule83hBGtWzn+4Pxx2RvsPkd86Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728108247; c=relaxed/simple;
	bh=TUVPA1xJ+mbAuDb9hGUPvTEiioHQiPpAhU2qyR3WmgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UM/NHwpT09GCrN78U3gnYO1wCEuEMWatyit4BQMeioZ88M5QM+DBUmibB+5j1Yq/tBe7b1dBaBjgad0rRUWXlttQCIxCisS1BFzeZ16TAo7Jh5lxUCkchC1uXqi4B9rLXSnpelwlEIvLPNqlTVBS9meVJLFs5npPtYILt5MNGCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeOdST8O; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a90188ae58eso351552966b.1;
        Fri, 04 Oct 2024 23:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728108244; x=1728713044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R9kr4vKjCPLZStDemxX08AP6JqBGoGV/tSTH+/GYKi8=;
        b=CeOdST8OHmTBm6JTg2MZjygwKqne0z29IKvmmM3t3OWYUb3V8y9Y+xx36wc2y/vXKa
         e9OYx9Q79u64XJiwrBkPq4aqKXvPppKoAPwgB1dFTu+Wj7hpg4DBGQ02TIQupTKj7xmw
         sEm7DlW1GwiU6vSFjMY2xuzF3pShQCN1fg2U2JyaoFiOwq5RAU5wfvHkw9q/qS1sIoEJ
         DKTPqENWsrW/NCZSb5rZtwD3O5jwqAzcWRRSESWhaPUbUFxO132lyxOrKOd83iiv6bQo
         MVwjX9iHRBNQ5UUwtqSLNTVgQRqwExptCktWYnnI0C1t1RDNq2NJyt1mtFG1tW3JRlqk
         xWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728108244; x=1728713044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9kr4vKjCPLZStDemxX08AP6JqBGoGV/tSTH+/GYKi8=;
        b=Mtr4TNqIQS6tZvwno4+hm9VAfMQg+0SoKjKOnW758sdpg5Fo+DTon0XYjhvnEgik0z
         CWjCRY4bZhcoI9//qvODHCKnQyGP6RN9BUFzHGcihjXM4X+QAqvm+k1Xk2I6CkATXd+S
         miv3kBKAb5WprHAvgvd47fLtGMrXdfIsrS+VnHxGFNj7nxVSKCAHBUyNVdpx74N4InrZ
         Ou9CHW30P07WPidZRnbZM6+FZsnZHCHEkPS93tKNmXeAfmFh1MkY9xlVGnibEoDvuG1v
         48tRiU4UneiKQGsulrJjAjKlkt/D6r4/OKXjNhC6OYnb+G38bGaSKlWolgPevSk2DwWP
         nZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJWYuVgJ2DBjLvqyp4VbFTq3O8EgxCroE58M4WmNo41vTbbcEBb/E9+U4/3QRnOWzLsUeSoats2emzyRQ=@vger.kernel.org, AJvYcCXWRE6JGgF+VMpSOcEEhEAtEICP2U2l1yz1uVlPYrkwlRxCfQj+l33VRebsjwc9P0xxLbv011bWS3f+rlExG8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg9Jr6ozmmTTdKED4/9ka+rQhUyNM/Dllfsy0f5EggTmSF9rmM
	OukcRrgK912If5FWuKsFpGtTcwC+nZRdWNkpVuTDkwHrEsoSuYwN
X-Google-Smtp-Source: AGHT+IG0ifO/YT7/qnG+TfJgjCvvlyRUqVYXAh55UdIcYyVEGe60bVBm4TVIJStaT+WPV8hM/0Bcqg==
X-Received: by 2002:a17:907:1b05:b0:a93:c2b0:f965 with SMTP id a640c23a62f3a-a991c02fd4bmr397383266b.41.1728108244136;
        Fri, 04 Oct 2024 23:04:04 -0700 (PDT)
Received: from ?IPV6:2003:df:bf2f:2200:42f9:1ced:dc84:a82d? (p200300dfbf2f220042f91ceddc84a82d.dip0.t-ipconnect.de. [2003:df:bf2f:2200:42f9:1ced:dc84:a82d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993fdd2202sm13924866b.55.2024.10.04.23.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 23:04:03 -0700 (PDT)
Message-ID: <66651971-5d4b-44a3-9c6e-2aed6a7cfacc@gmail.com>
Date: Sat, 5 Oct 2024 08:04:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rust: implement `kernel::sync::Refcount`
To: Gary Guo <gary@garyguo.net>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Will Deacon
 <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>, Dirk Behme <dirk.behme@de.bosch.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20241004155247.2210469-1-gary@garyguo.net>
 <pKZ-hxxNoouLWnfXzFGWvcgGgfjpEixPzJ--cZeEufWI9_MoG_mpToSPflheyUhYmZ4qTKLVypVLRuvX7rfyxg==@protonmail.internalid>
 <20241004155247.2210469-2-gary@garyguo.net> <87cykfpuqd.fsf@kernel.org>
 <20241004200836.137ce41f.gary@garyguo.net>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20241004200836.137ce41f.gary@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 04.10.24 um 21:08 schrieb Gary Guo:
> On Fri, 04 Oct 2024 20:51:22 +0200
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
> 
>> Hi Gary,
>>
>> "Gary Guo" <gary@garyguo.net> writes:
>>
>> [...]
>>
>>> diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
>>> index f47afc148ec3..39649443426b 100644
>>> --- a/rust/helpers/refcount.c
>>> +++ b/rust/helpers/refcount.c
>>> @@ -8,11 +8,26 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
>>>   	return (refcount_t)REFCOUNT_INIT(n);
>>>   }
>>>
>>> +unsigned int rust_helper_refcount_read(refcount_t *r)
>>> +{
>>> +	return refcount_read(r);
>>> +}
>>
>> +EXPORT_SYMBOL_GPL(rust_helper_refcount_read);
>>
>>> +
>>> +void rust_helper_refcount_set(refcount_t *r, int n)
>>> +{
>>> +	refcount_set(r, n);
>>> +}
>>
>> +EXPORT_SYMBOL_GPL(rust_helper_refcount_set);
>>
>> BR Andreas
>>
> 
> Helper symbol export is automatic after
> e26fa546042a (rust: kbuild: auto generate helper exports)

Yes :)

What results in a question, though:

When to use exports.h and when not?

There are several users of

#include <linux/export.h>

like

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/helpers/err.c
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/helpers/kunit.c
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/helpers/mutex.c

but some don't use it

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/helpers/rbtree.c
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/helpers/uaccess.c

Any rule?

Best regards

Dirk







