Return-Path: <linux-kernel+bounces-416259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECFB9D4297
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 725F3B21B07
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7BA158A13;
	Wed, 20 Nov 2024 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="iqlzkqKo"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A222F2A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732131302; cv=none; b=if+dLeElTqeT52eeiui1eq+R5q84aIesJORX8HtfFsfV5UgyiEnauF8dWaxVNppWuaWra+EKUpcMR6qC7NI06f3HEM7KpMbYnqf51WcktDHUI7MebpgXbqfjCut9uBqLEVuz95XtDS8Cv/Fu5ddR9GgJzNLq5pO7Z+LBHA/Ezfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732131302; c=relaxed/simple;
	bh=CvyrcF2HdYsaa660DNb7uq7rxgBzJqSKLkWSuvl3S1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSIwp82hNO1hwisxhxEnarmBUrdtrFzCUvwCkQxsiOg1fvmlO6cFsACS1uYjLRwlqQ3PfM5yJl+SknHRIoVhipNiKqjzq2l5s5HlQfuZmPZecAe90c7NjCYVsWxoSx7Wcscvg9IqjNaI2A8SejlR7tm/iF/9B3UhKq8F/p7QqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=iqlzkqKo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cfcf4df87aso89708a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1732131299; x=1732736099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CvyrcF2HdYsaa660DNb7uq7rxgBzJqSKLkWSuvl3S1M=;
        b=iqlzkqKoMU/jOcMGN8K+EhL5jb+JpNNbFACqf+sPcCm7y91OdAO5L1eIK6237yJarJ
         IrW0OgGwhOzhUh4nAq1Dj4Tv5KqHwciD4yuSvOGg3FB6xbwN+MkmgtqIxizmyTfLIQcb
         BklUhN1lOy6GyvBrEKezOxtZ/mJRBBxjpXiXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732131299; x=1732736099;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvyrcF2HdYsaa660DNb7uq7rxgBzJqSKLkWSuvl3S1M=;
        b=HmyroxDm2J7/6qkSbSfGQ6D9t7kSsmzIvGLsCPKdSPcRk5G/9DmheX41aWnXugusz/
         v+HnWWMCso0tfFndmtvQb/YDLzC+Y5aSCwfNn7FZlrJRBlgYUcQlb+LAX/Y1JW2tX3+5
         K9s7Ux82yX7pTyKT0a1Ho7ad//j+X/cr9mjUIWG60bIddHy45/Avwuw4qlbuEHukj3zl
         2deKMnIExGry6cpPFCtDszJGOrrkkGypnofp4xpQ59UEKZ/L8UvWcgTdqhyia3YBEpTZ
         458I2ud0KVaXzWp12SNgExxDd+BLGy9KkR978aNffZIAPBqplUjn6r0aNnxaGIVOCyDe
         rxxw==
X-Forwarded-Encrypted: i=1; AJvYcCVQmeKM55ykGLZ3fIcHMNszLkjNCUKGj8Dcqw+0A9M/aVg0Jm4asbYHEdJCTv9D0oVmN/r9cESz6Wb/Sl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz4Z+It6lwRVBQPTee1QgxOe/VSHQtm/veAe4Ay/CXOxNCDFaT
	WRSV5uNrdwqQKi9zxjfQqma80Ce5XsJFVvSA1XIcKpTDyTmORrTY7NMU5lwbu9c=
X-Google-Smtp-Source: AGHT+IERkDzZf0bireqFO5/m2Fe6GJZ1xX+o4THtDKmAEBD8f5/9PNOJaqDD8sq3gP/mJ0qth0vPXA==
X-Received: by 2002:a17:907:9495:b0:a9e:85f8:2a6b with SMTP id a640c23a62f3a-aa4dd57e901mr296937366b.35.1732131299046;
        Wed, 20 Nov 2024 11:34:59 -0800 (PST)
Received: from [10.125.226.166] ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dfffc3asm806299566b.92.2024.11.20.11.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 11:34:58 -0800 (PST)
Message-ID: <7b819c31-1972-44e0-87c7-1d11ac13f530@citrix.com>
Date: Wed, 20 Nov 2024 19:34:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] x86/ia32: Normalize any null selector value to 0
To: Xin Li <xin@zytor.com>
Cc: bp@alien8.de, brgerst@gmail.com, dave.hansen@linux.intel.com,
 ebiederm@xmission.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
 Andy Lutomirski <luto@kernel.org>
References: <20241120081721.2838905-1-xin@zytor.com>
 <3680972b-1871-4c92-9f61-c28ef7c10a4c@citrix.com>
 <b6f8fb05-057f-4531-b03b-839374ac9dc0@zytor.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <b6f8fb05-057f-4531-b03b-839374ac9dc0@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/11/2024 7:09 pm, Xin Li wrote:
> On 11/20/2024 1:33 AM, Andrew Cooper wrote:
>>> GDT, selector values 0~3 all point to the null descriptor, thus values
>>> 0, 1, 2 and 3 are all valid null selector values.
>>>
>>> Furthermore IRET zeros ES, FS, GS, and DS segment registers if any of
>>> them is found to have any null selector value, essentially making 0 a
>>> preferred null selector value.
>>
>> Zeroing of RPL in null selectors is an information leak in pre-FRED
>> systems.  Userspace can spot any interrupt/exception by loading a
>> nonzero NULL selector, and waiting for it to drop to zero.
>>
>> Userspace should not be able to do this; Andy and I lobbied for this
>> during the design of FRED, and Intel agreed.
>
> I wasn't aware of this, and hpa just told me you're right :)

We lobbied for many things.  Most got accepted.

Some did not.  e.g. MCIP isn't on the stack like the NMI flag is, but at
least you don't lose state on the stack any more, so it's definitely
better (if not ideal).

>
>>
>> Right now, this change is codifying the problem behaviour we were trying
>> to fix out under FRED.
>>
>> Under FRED, if userspace loads e.g. 2 into a selector, it should remain
>> 2 until userspace changes it to something else.
>
> Okay, I will fix it by:
> 1) For null selector values, do nothing.
> 2) For non-null selector values, set RPL bits.
>
> sounds okay?

Yeah, that sounds okay.

The selftest ought to work under FRED, but it was speculative coding.  I
can't rule out that tweaks might be needed.

~Andrew

