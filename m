Return-Path: <linux-kernel+bounces-262578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7F593C8DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02791F22C64
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719F957323;
	Thu, 25 Jul 2024 19:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="Ts2qSIR3"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1141876
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721936567; cv=none; b=PB5+NZulaSO7F2vOpifO8Rs0Hh4+XI56w9gZRxye7jsNG7iZSieqDSkI9cP3Px5nELHgbTDaxZA4MkpZf2VH5TBELlr0NXP5qik1JdGPr+JgdSvKlm3qbq5TesrTLCgwBsP2qfuDcyJ67rnQEV4VkG6bvpIZhTqG2nmZJR62Lv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721936567; c=relaxed/simple;
	bh=A/p7FxrZ7NB9QQWCuGcHnOqYVTSYUTD3YARi1FnytCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbk61x0NsPYFmN8ZbC0IDcI8EFTwXsBKRDkAMbde/gaDGFNrP5p+xWDDsAsGFWu5MMtLil0kC3uefMOSeERZNSHCtXM5Go3HPlrT6UiHbm0/zv/g+qroDFwlWmtRXo6SgL/MRfD/xvtGhswNYBEMDg7EzNtRzbfs13hWbQuD7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=Ts2qSIR3; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a3458bf7cfso1695841a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1721936563; x=1722541363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4JqtTvVFp0BnLiN7tLJLe0UGmp5oVTE40fFINTIQjJE=;
        b=Ts2qSIR3jWBHlOkz1pRW290oSUzv8L4G9st7UbjvMkKcuORWvupOvowFu5z40YwGxU
         j6vG7qfe12Sx8CHZiVFj2ztnlDI8/n9za9h3OnspO42NAhk4OoyyDN2JXHHxOVOJUXum
         zaRP7Qj8gCDpCa7F7rsAy5qHFcoy/+V3dhBEAYUebtVEcCgNTBLdQu69NCPg/vkCmFVl
         8ioLt7SD5Z3I6uofSL5MuG4fiGQCg+l49Ynjl9NgJMEeBONarIjERJQwege5H5vG2EMC
         IGCKEW5V0Fei44CgLTnwAJHJOomGjKNmEez4DhLnjOiZR8UbUUpU20xrk24w8JWB/krC
         L1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721936563; x=1722541363;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JqtTvVFp0BnLiN7tLJLe0UGmp5oVTE40fFINTIQjJE=;
        b=ZvQBttNgjh5YdqBdUuR+Fn5IRKFZ97kYUMkFrdxNnUwVFdTdmVKSWGsSbb9i5a+KNk
         DXoo4vNqkuip63a+VK2lCIuU1u21HsZk7zsGzfoZgzG3HG/cxyZb7RsvhYlAyySQJcyh
         j3lIdTxO7jbAZdTpwk6mZD4u/yLQ29G+eKKN8r94+VDujPNLrWQ7vOn0VUY3N4EzG5Hw
         6vT6ebQ81mEkTz5gMEh1n96SFDyzMHeKvJvmRZR3LBwo9jk6xhg/vSssY3O6/BRJaTef
         i3GBDdhm3n5dNnVS0jcxeXW5gc2kcDa2+NxdFTBpWN5v69KmUf8IulHa2rI/JsnrDEsD
         Y2Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXX3LJQ3Mm+ySGazRTIOj1NY6f0s+y9MmKc2M2PSSSkD4pdmynSe8xRCkICWroPInGOwNQI3lcS+DM1oS8aPwxLQ6M4Ilh35ROcsM1F
X-Gm-Message-State: AOJu0YySP0xLgHzFqwUzotIUk4t6mj3L1JkJIvItRS97aACP05ZY/HhV
	NTVlZC5U+dWYdKLPVg1tIZYGmXBsd5fOMfRgPF/TFsDpd9ERmh6HKASdld0T+m4=
X-Google-Smtp-Source: AGHT+IF3L9OFHSP0BzpVzKX25iSS/PLDPOb+0Psfi7MI8yG/PTzIG+UKwUnt7XveVIq+9zsOZ0YvPQ==
X-Received: by 2002:a17:907:6ea0:b0:a7d:2391:6037 with SMTP id a640c23a62f3a-a7d23916250mr166564366b.41.1721936562604;
        Thu, 25 Jul 2024 12:42:42 -0700 (PDT)
Received: from ?IPV6:2003:f6:af0d:f500:3285:7112:e461:c95c? (p200300f6af0df50032857112e461c95c.dip0.t-ipconnect.de. [2003:f6:af0d:f500:3285:7112:e461:c95c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad414d7sm101512566b.110.2024.07.25.12.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 12:42:42 -0700 (PDT)
Message-ID: <0d1a8c46-43a7-42d6-bcbf-647a5a68c3c5@grsecurity.net>
Date: Thu, 25 Jul 2024 21:42:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tracing: user events UAF crash report
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, =?UTF-8?Q?Ilkka_Naulap=C3=A4=C3=A4?=
 <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Beau Belgrave <beaub@linux.microsoft.com>
References: <20240719204701.1605950-1-minipli@grsecurity.net>
 <CAD2QZ9bDcQ46jOAc_Hxy6sG5-N5RPxw4zPuLK6R+M_GhxZR+=g@mail.gmail.com>
 <5083301c-6dc9-45c9-8106-da683ac6bfbb@grsecurity.net>
 <CAD2QZ9ZxZ+mjfju2JMw3fPATNNWkqT1p97QxXgeGo54AFzQ-Cw@mail.gmail.com>
 <CAD2QZ9bTrQ1p3zTZOXe6Gk4Xq8kjYSziAYAdbTrvRSZzAGPY9A@mail.gmail.com>
 <CAD2QZ9YAzq3jq8CyAcoG9YuMD9XWHbk3jKxAmszuSkJ3mtGoGw@mail.gmail.com>
 <20240725131021.788374d0@gandalf.local.home>
 <20240725131632.64cab267@gandalf.local.home>
 <cff51d4b-80eb-4587-b4ad-bfe7d7361b19@grsecurity.net>
 <20240725150517.3184e078@gandalf.local.home>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20240725150517.3184e078@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.07.24 21:05, Steven Rostedt wrote:
> On Thu, 25 Jul 2024 20:12:33 +0200
> Mathias Krause <minipli@grsecurity.net> wrote:
>>>> @@ -973,6 +975,11 @@ size_t copy_nofault(void *addr, size_t bytes, struct iov_iter *i)
>>>>  static struct list_head *user_event_get_fields(struct trace_event_call *call)
>>>>  {
>>>>  	struct user_event *user = (struct user_event *)call->data;  
>>
>> Dereferencing a potentially free'd object, so 'user' is now "random" data.
> 
> This is the callback function of user->call.get_fields.
> 
> That is, we have:
> 
> 	user->call.get_fields = user_event_get_fields;
> 
> And the f_start() code eventually calls trace_get_fields() that has (from a
> previous email in this thread).
> 
>     trace_get_fields(struct trace_event_call *event_call)
>     {
> 	if (!event_call->class->get_fields)
>         	return &event_call->class->fields;
>         return event_call->class->get_fields(event_call);
>     }

Right. But the point is, that 'event_call' is really some '&user->call'.
With 'user' being free'd memory, what gives? Dereferencing 'event_call'
is UB, so this function is doomed to fail because it cannot know if its
only argument points to still valid memory or not. And that's the core
issue -- calling that function for an object that's long gone -- the
missing refcounting I hinted at in my first Email.

> 
> Where it calls the ->class->get_fields(event_call);
> 
> that calls this function. By setting:
> 
> 	user->call.get_fields = NULL;
> 
> this will never get called and no random data will be accessed.

As 'user' is free'd or soon-to-be-free'd memory, that's a non-starter.

> 
> That said, I was talking with Beau, we concluded that this shouldn't be the
> responsibility of the user of event call, and should be cleaned up by the
> event system.
> 
> Here's the proper fix:
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 6ef29eba90ce..3a2d2ff1625b 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3140,8 +3140,10 @@ EXPORT_SYMBOL_GPL(trace_add_event_call);
>   */
>  static void __trace_remove_event_call(struct trace_event_call *call)
>  {
> +	lockdep_assert_held(&event_mutex);
>  	event_remove(call);
>  	trace_destroy_fields(call);
> +	call->get_fields = NULL;
>  	free_event_filter(call->filter);
>  	call->filter = NULL;
>  }
> 
> Can you try it out?

I can try but I don't think that's the proper fix for above reasons, I'm
sorry.

Thanks,
Mathias

