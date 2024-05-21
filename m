Return-Path: <linux-kernel+bounces-184953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169EB8CAE5E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14FE2824C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AB175811;
	Tue, 21 May 2024 12:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eH3Jcigy"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0031D6BB33
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716294830; cv=none; b=S1ppA5aZd/isugYoHi8hKt7wQJPobcOJ+skZfqCGT4jUbdZQp4vGJjp3KMKKUIYkDbPDFRBiK7THLxcNYk8g+fHJvJSHtXZqmiMGMs6i/haVpEAKNIAyBwmT67ZYrb41qCReNTyRZGidJVmQd30VCWcPxgp8UL4PK/6jMBduJ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716294830; c=relaxed/simple;
	bh=oAzwjNwCAQTsDGGzTI2IqR5CjgdQSLsyhBRqPlil1xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKBhXqr6Do6kVAHyYNGF8CYQgAQ87YtnEH09wM4NM/xLMuTfJOKBGvZLyH6oB6Wx09e7m2lkBneSbHekb+dmm3+siBq4md5/fKn6Rq3gMp3SbLrzlxuxDqH9DYiGx9TjNMP66dUAX+m4ZXggznxiyOASXKYhfdKUibaTv0T8XBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eH3Jcigy; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7e1b4f96994so291562839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 05:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716294828; x=1716899628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nSYyFEA0u90HBMfg2v5nbo6i1zSNMAA+C8CsRFK1nT0=;
        b=eH3Jcigy/72uOll+4sdh2TJt7Vy7WD78Vvki3R9PhDoG7UU6JwbHGMZYroMFBXI1Md
         lvGVJA3bjV1dP//DjRrcSLCCRz59TNobHQ89dPwCWMfSXwwsU2+MUtV5cVGbTXsPKJ5J
         yIloozQG1PDXHmGIi9iC2yntQ2Uv/mba/th+KbUVmlJZnLNwjejcHL08vNVy9712Kdrv
         VCfeEdZ+cN7Y9CbdaNCGADupngXUkcDsqF/i4P4WEJCXEpGH5hhU8Xv6RtgTfpQCCxpm
         FgmeQST9qHiF/OIhlnMLQoy9QeUArGJCPKVK3WrSCCI7IB6X7BidqqEtp6+ccBeVDSMR
         5wdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716294828; x=1716899628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nSYyFEA0u90HBMfg2v5nbo6i1zSNMAA+C8CsRFK1nT0=;
        b=lHN6aa7CSCNx01IZwhY13PejJfbGI9sETFckvjpsK2dGggikMW+Hl2oWNVIPWD1r2R
         O1NU2dEFYLkNcbliKWZxxykKus/WLF60TVjyIHs7KTsJ9d9fZKaIp/tOYMMh9wwrHo+v
         aJYooHOFX3L7QqYMIF4iYPTMXbTXIj3jY1+b1pP8FzEu+eE3B8hAIpR0MHs2x4d6ZVsF
         004akmzByKZ4ViTkN4CoURfGiuBt9CsxndRAAbcLxbMAGRSUPenFO7+KFuwWtaKIb3a6
         Oskckec5cnT6bo8C2wmV/Wt8EDMEMR6p7A+j+UFQOyetpI99w0I8fn/nZuDgQ3y2lKJ2
         oHig==
X-Forwarded-Encrypted: i=1; AJvYcCUQTziqSvvjuHn0SRD6tsfhc+eLbG/rvPzJtLa+E5bmVSIuoA05VzyxH99FMBXws37q9rQzpKKVdU5sinEzfc0lKwLQ/WIYQxP28NPW
X-Gm-Message-State: AOJu0YxKRxr62oQrIuiOgrrnL+REmk9yPCbmPbtsk1J1+Sq6qZzznprW
	uugOz0YJyfcD00TZoprGbiGK4jgsU09OMvGD4eIl7VlvDS+NxWg9QwSmHlVlJik=
X-Google-Smtp-Source: AGHT+IHcCWfnMUd5uszQ6OsE/SiIRYMmFw3SGsIaoptvW/OyNqO6nXYRznRUwaV3EnavTehN+g4pEQ==
X-Received: by 2002:a5d:8e0b:0:b0:7e1:7b87:add3 with SMTP id ca18e2360f4ac-7e1b50107abmr3408425939f.0.1716294827978;
        Tue, 21 May 2024 05:33:47 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489376de185sm6863661173.150.2024.05.21.05.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 05:33:47 -0700 (PDT)
Message-ID: <3f3b75df-3488-4915-bc21-54cb6a6e2a74@linaro.org>
Date: Tue, 21 May 2024 07:33:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bitfield.h: add FIELD_MAX_CONST
To: Yury Norov <yury.norov@gmail.com>, Michal Schmidt <mschmidt@redhat.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
References: <20240515172732.288391-1-mschmidt@redhat.com>
 <Zkuksm3K+pKugjgF@yury-ThinkPad>
Content-Language: en-US
From: Alex Elder <elder@linaro.org>
In-Reply-To: <Zkuksm3K+pKugjgF@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/20/24 2:29 PM, Yury Norov wrote:
> + Alex Elder <elder@linaro.org>, Jakub Kicinski <kuba@kernel.org> and
> David S. Miller <davem@davemloft.net>

Thanks for adding me to this.

My bottom line response is that I don't understand exactly
what problem this is solving (but I trust it solves a
problem for you).  It *seems* like the existing macro(s)
should work for you, and if they don't, you might not be
using it (them) correctly.  And... if a fix is needed, it
should be made to the existing macro if possible.

> On Wed, May 15, 2024 at 07:27:31PM +0200, Michal Schmidt wrote:
>> FIELD_MAX_CONST is like FIELD_MAX, but it can be used where statement
>> expressions are forbidden. For example, using FIELD_MAX in a
>> static_assert gives:
>>    error: braced-group within expression allowed only inside a function

So you want to use FIELD_MAX() in the outer scope in a file,
not within a function?  And the way it's currently defined
doesn't permit that?

>> It can be used also in array declarations, where using FIELD_MAX would
>> trigger a warning :
>>    warning: ISO C90 forbids variable length array ‘buf’ [-Wvla]

Are you passing a constant to FIELD_MAX() when computing the
array size?  If so, I don't understand this warning.

>> (It's a bit surprising, because despite the warning, gcc calculated
>> the array size correctly at compile time.)
>>
>> A simplified example of what I actually want to use in a driver:
>>    #define DATA_SIZE_M GENMASK(3, 0)
>>    #define MAX_DATA_SIZE FIELD_MAX_CONST(DATA_SIZE_M)

FIELD_MAX() returns the maximum representable value, not the
number of possible values.

>>    static void f(void) {
>>    	char buf[MAX_DATA_SIZE];
>>    	/* ... */
>>    }
>>
>> In the implementation, reuse the existing compile-time checks from
>> FIELD_PREP_CONST.
>>
>> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> 
> Hi Michal,
> 
> So... FIELD_MAX() already requires the _mask to be a const value.
> Now you add a FIELD_MAX_CONST(), which makes it more confusing.

Yes, it's not clear when you would use one rather than the other.
I think a better fix is to fix the existing FIELD_MAX() (and
field_max(), defined later in that file).

> It looks like your new _CONST() macro would work anywhere where the
> existing FIELD_MAX() works. At least for me, if I apply your patch
> and do:
> 
>          #define FIELD_MAX FIELD_MAX_CONST
> 
> The implementation of the 'const' version looks the same as the
> 'variable' one, except for that sanity checking business.
> 
> I think the right path to go would be making the __BF_FIELD_CHECK()
> a structure initializers friendly by using the BUILD_BUG_ON_ZERO(),
> just like you did with the __BF_FIELD_CHECK_CONST(), so that the
> FIELD_MAX() would work in all cases.

I haven't investigated this much further, but yes, I agree that
you should fix what's there to work the way you like if possible,
while preserving all guarantees provided before.

Still, I'll provide some comments on the patch below.

> Thanks,
> Yury
> 
>> ---
>>   include/linux/bitfield.h | 34 +++++++++++++++++++++++++++-------
>>   1 file changed, 27 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
>> index 63928f173223..50bbab317319 100644
>> --- a/include/linux/bitfield.h
>> +++ b/include/linux/bitfield.h
>> @@ -76,6 +76,16 @@
>>   					      (1ULL << __bf_shf(_mask))); \
>>   	})
>>   
>> +#define __BF_FIELD_CHECK_CONST(_mask, _val)				\
>> +	(								\
>> +		/* mask must be non-zero */				\
>> +		BUILD_BUG_ON_ZERO((_mask) == 0) +			\

This ^^^ implements the opposite of what the comment says.  Use:
		BUILD_BUG_ON_ZERO(_mask);

Also, why are you adding?  The way this macro is defined, it
really should return Boolean, but you're returning an integer
sum.

>> +		/* check if value fits */				\
>> +		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
>> +		/* check if mask is contiguous */			\
>> +		__BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask)))	\

I don't really see why __BUILD_BUG_ON_NOT_POWER_OF_2() isn't used
here (and in FIELD_PREP_CONST() for that matter--other than line
length).

Each of the above checks can stand alone, and if they all pass,
you can simply return true (or return the result of the last
check, but I really think they should be treated as void type).

>> +	)
>> +
>>   /**
>>    * FIELD_MAX() - produce the maximum value representable by a field
>>    * @_mask: shifted mask defining the field's length and position
>> @@ -89,6 +99,22 @@
>>   		(typeof(_mask))((_mask) >> __bf_shf(_mask));		\
>>   	})
>>   
>> +/**
>> + * FIELD_MAX_CONST() - produce the maximum value representable by a field
>> + * @_mask: shifted mask defining the field's length and position
>> + *
>> + * FIELD_MAX_CONST() returns the maximum value that can be held in
>> + * the field specified by @_mask.

I don't think this part of the description adds much; it
basically restates what the one-liner does.

					-Alex

>> + *
>> + * Unlike FIELD_MAX(), it can be used where statement expressions can't.
>> + * Error checking is less comfortable for this version.
>> + */
>> +#define FIELD_MAX_CONST(_mask)						\
>> +	(								\
>> +		__BF_FIELD_CHECK_CONST(_mask, 0ULL) +			\
>> +		(typeof(_mask))((_mask) >> __bf_shf(_mask))		\
>> +	)
>> +
>>   /**
>>    * FIELD_FIT() - check if value fits in the field
>>    * @_mask: shifted mask defining the field's length and position
>> @@ -132,13 +158,7 @@
>>    */
>>   #define FIELD_PREP_CONST(_mask, _val)					\
>>   	(								\
>> -		/* mask must be non-zero */				\
>> -		BUILD_BUG_ON_ZERO((_mask) == 0) +			\
>> -		/* check if value fits */				\
>> -		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
>> -		/* check if mask is contiguous */			\
>> -		__BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +	\
>> -		/* and create the value */				\
>> +		__BF_FIELD_CHECK_CONST(_mask, _val) +			\
>>   		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
>>   	)
>>   
>> -- 
>> 2.44.0


