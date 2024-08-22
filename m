Return-Path: <linux-kernel+bounces-297970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 876DE95BFD0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45034283425
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD3C1D2F6C;
	Thu, 22 Aug 2024 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FItOjIsA"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046A1D2F62
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359396; cv=none; b=KU1iBR8rh1Kwa270Djq4FOAd2cTwrI3FdTYpYNVFcYrERC+S33l6Gt1Px+ykplTu5kmmQJM7ZD1Hz2Lo/hkVJvaXsL0+sjM4TQSpXp9nKe3/Cqvt1lhCiIL8S1x69CO4xje2uOMRr09Nk+58s68DXcvCqUMWCn9pd1eTP79auSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359396; c=relaxed/simple;
	bh=sy5HovMLhMxejdKHhBK6iWKaS9qP3NR+A708tOEZxfQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=THee9Bf55DbEuriQOYkvmfk+owivPHL2YunILLflcT9PhwHYMeUsHFAyJRhqovHtbBEP777ip3mjgDJj/V/4Z4fnDhfV53O2mcx164Ws+aMUqU2ss+CwcIiMEDKMLUTL4oT9KUwYDGA4fVwTxOzKVC3GuSAPOTtF5Qn4h3cbz5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FItOjIsA; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e117c61d98cso1725466276.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724359394; x=1724964194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RN+xqVCU/80tozSyGedYp0hXJH+VNCIE4IyZN+mwjB0=;
        b=FItOjIsAyZxJw9aKLLSSH5/rL+YThrhKXWHzRxirpw/U/HIbTKoFLZaTbTGVO2tgcM
         P6hCYlS9c6bHgpgoJ5Oja6ZucHORSPO6Ws2/822Ig8vZ+gbVfkH/NQabSdFkfOZnhY6c
         VNjzgLUfQP+caIaHxm7y77Sr6iS3N3Hcfo0b0N7mu6fHmt44bJluJFFvy3FJMQpsTJxD
         sHaD8q8U3oTH4mhGFoTf9oLKrAjR1/wBG96+ndWnmP7aelyO8+EGm9xHQ3vOd3OQOp5N
         4+4Kfu3iof1XGnW+A7d7/9t+Pk63ng3yH1uyfLsXtevBL3+aWovsEU/RZh4gVIsRxgd3
         xVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724359394; x=1724964194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RN+xqVCU/80tozSyGedYp0hXJH+VNCIE4IyZN+mwjB0=;
        b=K6Sny3ux/r/j1kVuQ9l7K/NY7VjrfoqEhWvBzh+QS0MC/wryf1ZosRX5Z9O9d+Xvp3
         r9HYL3m7iw67XRmp0coJzZZJtdIIWsFuHPH4Uej6LGIu3kqczTRQz6UVq5F3llHl3VQu
         sjTBwDkh4FwksE37Hz+9maIeRqfT4eiT1Xtod7Nb4TzF+cknCrpiuALxFpXbtnQz42IZ
         uRVuKYXyhq543amv0OGQijIbF5X+LATVm1tnB4Pni9vDEouqRzw7gT6xDH3gf3iAOojd
         mvlNpaoMrxzhs1MfQFKoZKytd1r8V9vbFlJLwbVBPb9Z1ByfXOWzsJXfkw8HV5cbANzJ
         C/Og==
X-Forwarded-Encrypted: i=1; AJvYcCXRGR0zmg/UFWvLWnTH0wl2idUZSBv8ipCCVtri9HyQ96TyOQIfx4/qqk5O2XM7paXbKvm2aV7krxof0CU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYJJYjX49iOIZlh+EBAt/JzGY8BZnjRAkTBLVzt4VIdCa9fjp
	jsgpmjLadBxyTjvvSoVga/OsLpXQi946C8p5UgldDoElq/q3TCM7FwDioXmyS0nXruN9RKl/M9S
	veoekyHc1kh9XwgKdIpFuuA==
X-Google-Smtp-Source: AGHT+IG3CrhGWtEqsFmgfRB/p78f2CuCZK6Dr7k19D7v3s3hh2kMhTrrFDf8xsnt9CwxS71P5CXOCduucVIs0+JJwA==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:1367:b0:e0e:c9bc:3206 with
 SMTP id 3f1490d57ef6-e17a83ca1e3mr183276.5.1724359393716; Thu, 22 Aug 2024
 13:43:13 -0700 (PDT)
Date: Thu, 22 Aug 2024 20:43:12 +0000
In-Reply-To: <ZseOAY0OIrEIGG2h@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230227174654.94641-1-ackerleytng@google.com> <ZseOAY0OIrEIGG2h@google.com>
Message-ID: <diqzv7zs2srj.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH] tools: Copy linux/align.h into tools/
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: yury.norov@gmail.com, andriy.shevchenko@linux.intel.com, 
	linux@rasmusvillemoes.dk, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Feb 27, 2023, Ackerley Tng wrote:
>> This provides alignment macros for use in selftests.
>> 
>> Also clean up tools/include/linux/bitmap.h's inline definition of
>> IS_ALIGNED().
>> 
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>
> FYI, an almost-equivalent change went through net/, commit 10a04ff09bcc ("tools:
> move alignment-related macros to new <linux/align.h>").  It doesn't have these
>
>   #define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
>   #define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
>   #define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
>
> but I'm pretty sure your use case doesn't need them, so you should be good to go.
> And if not, it's easy enough to include a delta patch to add them.
>

Thanks for letting me know, please ignore the patch then :)

>>  tools/include/linux/align.h  | 15 +++++++++++++++
>>  tools/include/linux/bitmap.h |  2 +-
>>  2 files changed, 16 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/include/linux/align.h
>> 
>> diff --git a/tools/include/linux/align.h b/tools/include/linux/align.h
>> new file mode 100644
>> index 000000000000..2b4acec7b95a
>> --- /dev/null
>> +++ b/tools/include/linux/align.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_ALIGN_H
>> +#define _LINUX_ALIGN_H
>> +
>> +#include <linux/const.h>
>> +
>> +/* @a is a power of 2 value */
>> +#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
>> +#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
>> +#define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
>> +#define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
>> +#define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
>> +#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
>> +
>> +#endif	/* _LINUX_ALIGN_H */
>> diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
>> index f3566ea0f932..8c6852dba04f 100644
>> --- a/tools/include/linux/bitmap.h
>> +++ b/tools/include/linux/bitmap.h
>> @@ -3,6 +3,7 @@
>>  #define _TOOLS_LINUX_BITMAP_H
>>  
>>  #include <string.h>
>> +#include <linux/align.h>
>>  #include <linux/bitops.h>
>>  #include <linux/find.h>
>>  #include <stdlib.h>
>> @@ -126,7 +127,6 @@ static inline bool bitmap_and(unsigned long *dst, const unsigned long *src1,
>>  #define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
>>  #endif
>>  #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
>> -#define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0)
>>  
>>  static inline bool bitmap_equal(const unsigned long *src1,
>>  				const unsigned long *src2, unsigned int nbits)
>> -- 
>> 2.39.2.722.g9855ee24e9-goog
>> 

