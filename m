Return-Path: <linux-kernel+bounces-273148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFEB9464F3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA168B22223
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163436A325;
	Fri,  2 Aug 2024 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hgzVJ5Ry"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9B27D3E2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633655; cv=none; b=lY7+ALOQ0YBInJCkYQm6SZwvs5qX6c8zh0FT5mMjtR0PSkSKCviXlRgqioDCaUNJN3Ky/T8rApE1VR5iINIqYOHRt0MlwWyNQYr0hdR/dc5C1poHjlRzGVJlMX6HP1cGhrexwKlguGZGBN3FaaVoTBQGysNT1QxBAdShuYQ56go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633655; c=relaxed/simple;
	bh=hPTm8twJbQwP1gA57rf1nLexQTY1IA3FxQkljDvuAUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksYS1pKGCd+FbqYg/Vj0VcqQfVbGPciaAbsMKxWxkTaPgyk+lMJ4N4V/2oNG1HR6EPWu4P45s5Zjgh8MZWufT4bHE1qNFfa9dW5w7e7jwBwPtd6gUQmFCJ3V56gcMPDS8upO8Fe+8EA/59sO1+n/0gyUCLmxgwLVB3+QKfgzXy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hgzVJ5Ry; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-38252b3a90eso1950235ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722633652; x=1723238452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUVOjx3qvNsCDEecpqknYfmTs+/UlFgyedU0CA/KD7A=;
        b=hgzVJ5RypqIelpgQWFyI5/qk8DueP5zFQsYMVzlCdZStrFG08ZxyQGiy+6H3qsGJub
         ofuZ3NytAB/cdLxvQKJU0gD6kUU+dHD9tjYTBlEpaUyS8wClDEy23NoAOqDag+detChD
         a9LHLqvTp1GLaGZPZ5rY9ETgTfVjDkipvDluY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722633652; x=1723238452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUVOjx3qvNsCDEecpqknYfmTs+/UlFgyedU0CA/KD7A=;
        b=ZcEz5LRzOan/KfeXw2qkWU+rxZQyhevT14pYc9vPd+X74C65W8F4FDIsIrh0ZNWgSD
         WaTD/cPse/934fHPaK3tL5s/IFUByIF1Oy2FnZLK6WoEY+oPu+VGgpjmxvfTaj2n6QVQ
         U1khTiuvhHab46/V7eP2p93DJCGluPk05GFFcscYNgVFoMJDvSYeGw5hihaGgUt6bKyC
         veAJP4zAoPSk5zGAJEcpXrjcOdgG4hH8tCmLrog4Gg8ICXpkeLwHtB9m0XZRefaIDcOE
         ITNhlUz916yMnPOWoUN4DUZnFVCqIYbr3vssOc2WpfFEHEPhn3sP2wb1ewowJREn4wc5
         KIEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxsLGW1GJ2bP3JPC9v8U/pLBPz2Q36p3tPpUkwpbrIbOasFDRVjjTCDRvqPwMrZNzO9UB6qsl85j4uUJyLXZiByG57N28rXr2+iuce
X-Gm-Message-State: AOJu0Yza3bN2+wOyQp1JLFpz56vYq9nXGzsM0tvxrzp/4RDh61aTfJRa
	zU4bgspxGL4kBkU2ghSs2UJs7flNeOq4OX3XRIdCFTwynOBBcRUarVLVTSkyAvw=
X-Google-Smtp-Source: AGHT+IFVau0I++EGUzffsnsNKUNWsupcmCH5zGbYtBcWlZKAnldqk0URodLsZDCVj07G8p0H5y1gIw==
X-Received: by 2002:a6b:f415:0:b0:81f:8cd4:2015 with SMTP id ca18e2360f4ac-81fd4395206mr364445939f.2.1722633652288;
        Fri, 02 Aug 2024 14:20:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81fd4d3a1e2sm71986339f.26.2024.08.02.14.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 14:20:51 -0700 (PDT)
Message-ID: <fc8a6e83-98fa-4809-8b05-ea9f94dd2c71@linuxfoundation.org>
Date: Fri, 2 Aug 2024 15:20:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tools/nolibc: add support for [v]sscanf()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240731-nolibc-scanf-v1-0-f71bcc4abb9e@weissschuh.net>
 <20240731-nolibc-scanf-v1-1-f71bcc4abb9e@weissschuh.net>
 <3956cee8-1623-42d6-bbc6-71b5abd67759@linuxfoundation.org>
 <5db920e0-51e8-48d9-b0ae-95479e875fad@t-8ch.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5db920e0-51e8-48d9-b0ae-95479e875fad@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/2/24 09:48, Thomas Weißschuh wrote:
> On 2024-07-31 17:01:09+0000, Shuah Khan wrote:
>> On 7/31/24 12:32, Thomas Weißschuh wrote:
>>> The implementation is limited and only supports numeric arguments.
>>
>> I would like to see more information in here. Why is this needed
>> etc. etc.
> 
> Ack.
> 
>>>
>>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>>> ---
>>>    tools/include/nolibc/stdio.h                 | 93 ++++++++++++++++++++++++++++
>>>    tools/testing/selftests/nolibc/nolibc-test.c | 59 ++++++++++++++++++
>>>    2 files changed, 152 insertions(+)
>>>
>>> diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
>>> index c968dbbc4ef8..d63c45c06d8e 100644
>>> --- a/tools/include/nolibc/stdio.h
>>> +++ b/tools/include/nolibc/stdio.h
>>> @@ -348,6 +348,99 @@ int printf(const char *fmt, ...)
>>>    	return ret;
>>>    }
>>> +static __attribute__((unused))
>>> +int vsscanf(const char *str, const char *format, va_list args)
>>
>> Is there a reason why you didn't use the same code in lib/vsprintf.c?
>> You could simply duplicate the code here?
> 
> lib/vsprintf.c is GPL-2.0-only while nolibc is LGPL-2.1 OR MIT,
> so code reuse isn't really possible.
> Furthermore I think the vsprintf.c implements the custom kernel formats,
> while nolibc should use posix ones.

Ack.

> 
>> With all these libc functionality added, it isn't nolibc looks like :)
> 
> Well :-)
> 
> The main motivation is to provide kselftests compatibility.
> Maybe Willy disagrees.
> 
>>> +{

>>> +done:
>>> +	return matches;
>>> +}
>>> +
>>> +static __attribute__((unused, format(scanf, 2, 3)))
>>> +int sscanf(const char *str, const char *format, ...)
>>> +{
>>> +	va_list args;
>>> +	int ret;
>>> +
>>> +	va_start(args, format);
>>> +	ret = vsscanf(str, format, args);
>>> +	va_end(args);
>>> +	return ret;
>>> +}
>>> +
>>>    static __attribute__((unused))
>>>    void perror(const char *msg)
>>>    {
>>> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
>>> index 093d0512f4c5..addbceb0b276 100644
>>> --- a/tools/testing/selftests/nolibc/nolibc-test.c
>>> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
>>> @@ -1277,6 +1277,64 @@ static int expect_vfprintf(int llen, int c, const char *expected, const char *fm
>>>    	return ret;
>>>    }
>>> +static int test_scanf(void)

Is there a rationale for the return values 1 - 14. It will be
easier to understand if there are comments in the code.

>>> +{
>>> +	unsigned long long ull;
>>> +	unsigned long ul;
>>> +	unsigned int u;
>>> +	long long ll;
>>> +	long l;
>>> +	void *p;
>>> +	int i;
>>> +
>>> +	if (sscanf("", "foo") != EOF)
>>> +		return 1;
>>> +
>>> +	if (sscanf("foo", "foo") != 0)
>>> +		return 2;
>>> +
>>> +	if (sscanf("123", "%d", &i) != 1)
>>> +		return 3;>>> +
>>> +	if (i != 123)
>>> +		return 4;
>>> +
>>> +	if (sscanf("a123b456c0x90", "a%db%uc%p", &i, &u, &p) != 3)
>>> +		return 5;
>>> +
>>> +	if (i != 123)
>>> +		return 6;
>>> +
>>> +	if (u != 456)
>>> +		return 7;
>>> +
>>> +	if (p != (void *)0x90)
>>> +		return 8;
>>> +
>>> +	if (sscanf("a    b1", "a b%d", &i) != 1)
>>> +		return 9;
>>> +
>>> +	if (i != 1)
>>> +		return 10;
>>> +
>>> +	if (sscanf("a%1", "a%%%d", &i) != 1)
>>> +		return 11;
>>> +
>>> +	if (i != 1)
>>> +		return 12;
>>> +
>>> +	if (sscanf("1|2|3|4|5|6",
>>> +		   "%d|%ld|%lld|%u|%lu|%llu",
>>> +		   &i, &l, &ll, &u, &ul, &ull) != 6)
>>> +		return 13;
>>> +
>>> +	if (i != 1 || l != 2 || ll != 3 ||
>>> +	    u != 4 || ul != 5 || ull != 6)
>>> +		return 14;
>>> +
>>> +	return 0;
>>
>> Can we simplify this code? It is hard to read code with too
>> many conditions. Maybe defining an array test conditions
>> instead of a series ifs.
> 
> I tried that and didn't find a way.
> Any pointers are welcome.

I played with this some and couldn't think of way to simplify
this without making it hard to read. It would help adding
comments though.

thanks,
-- Shuah

