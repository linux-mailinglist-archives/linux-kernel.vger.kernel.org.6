Return-Path: <linux-kernel+bounces-205608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5448FFE15
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1D31F22AC7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7A715B134;
	Fri,  7 Jun 2024 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PpnpWZah"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D5615B0FD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749218; cv=none; b=Qa8wPjQJU9eVOgpBImee73cYyaHg9f0snasQT8Si0ubYhZygJtHvNtxXZFZCLP+aPWmM6HiltFMV94P0mM59E0khrhvpt4EeQKpxOLB8FMU9qUxCaIyuciutd3iFUuWHUhmgFxWquU7Mnbj6Wf3r3eIGUS34vehSa6J+x7MC40I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749218; c=relaxed/simple;
	bh=7MbqiQOQ+OvzpyL+/T92pYG7EEVcaWMum8a/E3BthBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B96kaX4N0lKoGs9QIIDCRCH20z3M/ILzXWR7PquXBEYjzt8ZvpNodBfTE9qPf6uFUMW6tPnauisM6YwflEj+kRdtqtg2nhyWnlHnZ6sDT0nOeRkyrW7tM5pe8Hxz+Ubby7E9CjecHuzNaCbfUi21+nmAPb5CdhE4hTzEiR3UaKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PpnpWZah; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eab0bc74cdso18888841fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 01:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717749215; x=1718354015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2oEDQ4oEJDSAOydnGEzde0yFwLxpVFL6KrokDFm2YY=;
        b=PpnpWZahoxHe0+8b34hnVXOIkWvH3yvk6oVv8umarJX7EkWdEf3T6ERI54ghbeSEpf
         qV7JUYZNmGE/A6Y3zOUOOBPkYvyDarfiwfaAPNsrGGrEiUav+HPDE6G6Qrug/Qn9ZQP9
         sNffxLLMpIGBKa01iXnAfp0AADHgj+r+LXzQ6FMMhopktXrMQTVjHyRcQFON7Ss+eTOu
         op9wQlxdKfpkZePG1W367EMZaWTtjtQiz1wLzY+M/gbHHkNk0NojZRVbCZJSRP3mh8Rt
         8HWbUCgJyKzgzg5sWtH6J3EYDTZluG8JFP7lShzAt2tqN/D6uVxZX0U4ZjxdIvHMwqnA
         H1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717749215; x=1718354015;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2oEDQ4oEJDSAOydnGEzde0yFwLxpVFL6KrokDFm2YY=;
        b=eVtBUAKUzzomuNHund5BirrhxozKgjsgm250dx5xqs0bH9XeCDzv+ToWy7jSUUajiM
         2CVc9h8yzxVO9ZTlJPbr1/oHkKnXaU0DqkMe69erRWKhDWRrBbombe38Q6E932YSWJTq
         MrM39mJlNjskKOPH8OI+uRuEnweJ8asDm1Sg/Sl5hSYl1KcnAst0ROE6j2eJc+E8ikcC
         yFlldGULHiYa2Vu03mmSLm5NKzkmGdiaHiGPw13AK8GfxSGEr/MI0uF2EY6KoGqP54Bf
         0dsrUvqcMhAxV1o/P4ss1E99+Yh/u0tJk1Y+gyyWR3r4224HqGvxzv4CoA91p4MvyEhN
         8vHw==
X-Forwarded-Encrypted: i=1; AJvYcCWaeuOWL4gV68GlHLxRN8HX4NH7Y/yBL1WzisJp26Xvl9AhQQQMNG2v9HmFUB94cphOeQAwZno5UXaNWbE6LcxmHp/loEwlRzf4/TOu
X-Gm-Message-State: AOJu0Yy8GAFPwo7X8ca7h6rlH0mfQqWpU6UhY4pCSQvkPFc4TCBXIOYb
	uxmjrfXr/T8+q3ADlcmtCQFzcCIOuuQtIfHTdCBLq0dbyVuiox5mHr5htqXr0Us=
X-Google-Smtp-Source: AGHT+IFd5ZfiuLNyBYmLsG6n5jwcxtkp6jfGA71uDyertT8R4yhF7FEbS2GDfRdBJ5wpCJqlWfHsng==
X-Received: by 2002:a2e:6a0e:0:b0:2ea:904b:1710 with SMTP id 38308e7fff4ca-2eadce7f8dfmr10996141fa.47.1717749214891;
        Fri, 07 Jun 2024 01:33:34 -0700 (PDT)
Received: from [10.100.51.161] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d4a582sm3457775f8f.35.2024.06.07.01.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 01:33:34 -0700 (PDT)
Message-ID: <95a98eea-a6bf-423e-9ee6-9be784138b60@suse.com>
Date: Fri, 7 Jun 2024 10:33:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/ipv6: Fix the RT cache flush via sysctl using a
 previous delay
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuifeng Lee <sinquersw@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240529135251.4074-1-petr.pavlu@suse.com>
 <CAHE2DV1S4oKved063WaYzqsoiEe1hY=ZoRxjFfPX1m0-N0MsdQ@mail.gmail.com>
 <cbd56289-c9e9-4cd1-87d8-623ae7e39347@suse.com>
 <111ad356a137d0b69550cd73ff0cdef915c16e2e.camel@redhat.com>
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <111ad356a137d0b69550cd73ff0cdef915c16e2e.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/4/24 10:30, Paolo Abeni wrote:
> On Fri, 2024-05-31 at 10:53 +0200, Petr Pavlu wrote:
>> [Added back netdev@vger.kernel.org and linux-kernel@vger.kernel.org
>> which seem to be dropped by accident.]
>>
>> On 5/30/24 17:59, Kuifeng Lee wrote:
>>> On Wed, May 29, 2024 at 6:53 AM Petr Pavlu <petr.pavlu@suse.com> wrote:
>>>>
>>>> The net.ipv6.route.flush system parameter takes a value which specifies
>>>> a delay used during the flush operation for aging exception routes. The
>>>> written value is however not used in the currently requested flush and
>>>> instead utilized only in the next one.
>>>>
>>>> A problem is that ipv6_sysctl_rtcache_flush() first reads the old value
>>>> of net->ipv6.sysctl.flush_delay into a local delay variable and then
>>>> calls proc_dointvec() which actually updates the sysctl based on the
>>>> provided input.
>>>
>>> If the problem we are trying to fix is using the old value, should we move
>>> the line reading the value to a place after updating it instead of a
>>> local copy of
>>> the whole ctl_table?
>>
>> Just moving the read of net->ipv6.sysctl.flush_delay after the
>> proc_dointvec() call was actually my initial implementation. I then
>> opted for the proposed version because it looked useful to me to save
>> memory used to store net->ipv6.sysctl.flush_delay.
> 
> Note that due to alignment, the struct netns_sysctl_ipv6 size is not
> going to change on 64 bits build.
> 
> And if the layout would change, that could have subtle performance side
> effects (moving later fields in netns_sysctl_ipv6 in different
> cachelines) that we want to avoid for a net patch.
> 
>> Another minor aspect is that these sysctl writes are not serialized. Two
>> invocations of ipv6_sysctl_rtcache_flush() could in theory occur at the
>> same time. It can then happen that they both first execute
>> proc_dointvec(). One of them ends up slower and thus its value gets
>> stored in net->ipv6.sysctl.flush_delay. Both runs then return to
>> ipv6_sysctl_rtcache_flush(), read the stored value and execute
>> fib6_run_gc(). It means one of them calls this function with a value
>> different that it was actually given on input. By having a purely local
>> variable, each write is independent and fib6_run_gc() is executed with
>> the right input delay.
>>
>> The cost of making a copy of ctl_table is a few instructions and this
>> isn't on any hot path. The same pattern is used, for example, in
>> net/ipv6/addrconf.c, function addrconf_sysctl_forward().
>>
>> So overall, the proposed version looked marginally better to me than
>> just moving the read of net->ipv6.sysctl.flush_delay later in
>> ipv6_sysctl_rtcache_flush().
> 
> All in all the increased complexity vs the simple solution does not
> look worth to me.
> 
> Please revert to the initial/simpler implementation for this fix,
> thanks!

Fair enough, I'll post v2 with the initial/simpler version.

Thanks,
Petr

