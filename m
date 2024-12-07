Return-Path: <linux-kernel+bounces-435878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C0F9E7E2E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 05:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7A916CA53
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 04:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD48C4F21D;
	Sat,  7 Dec 2024 04:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJMKTNR4"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBBD4644E;
	Sat,  7 Dec 2024 04:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733545450; cv=none; b=Ti9YiBeFfva6aJlZYKhjD8tajjozJJVzfBtR/od/q3v55a113DzEnHG0oTHe3o5tyvUjWb3Gp9qf2bDWVIxxCyR4bEnrfJRelI7DXsCKYiHqg6Kldwbf29nI41VrYMuareQFDkL+tghatocGWbHy61pqTVDWKz83R+2CGEgeeys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733545450; c=relaxed/simple;
	bh=Xo/3UGIl2biL7g3RigrWGPelsEgVg6G6GfE049j4KEU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=YO2tb4GCJVgPzVhMVDh4FvK4qSnQcM28RkBHsYuW1ZxWw6GB7AaDDlhUekFN07Lr87if1dnfIf6Uj5hMDxSFiL9v9TjNSTkoNpPZNgrHQGm5cS3KJYqdH/aA1SpvO40nohCHdf1agAaBGrHNBgms9H5fkRuyHapsePE6gP+RWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJMKTNR4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cf3e36a76so24091355ad.0;
        Fri, 06 Dec 2024 20:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733545448; x=1734150248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYUGdhq/mGb5oiUNzEBADFNnjpGP75R+ldAacHlJ15U=;
        b=fJMKTNR4bxAgVwHKsexJjdZ8Y7okc+rYKSPSNq1IrHsBZbUMMytqy6zXrNUZBYsSKj
         P5B3/5lS6l4tfVCCXiaWMGotj0CZAl18cX+3TpkOTQlW9dxVvH/mHipcJUUgWobAJ7S9
         7kbKT3qkn/FhVkQCV/0c0BFkT7WLuiLODroyusb089Oi2RARlHgF11eMVG0Jf3cTYe9b
         sX/3vXy94n6w34eO1XL/RHgQN8GbDan2aTAiAXzsDssWkeb5zjILOeqLI1WJEHeIzAlK
         gZ4JE1fVmImnV4+vJza0KloH8YbKypy0H2V/ZKO+07qbk/2P3wr/c2Nt9nzPu9q3ZLFs
         avdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733545448; x=1734150248;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYUGdhq/mGb5oiUNzEBADFNnjpGP75R+ldAacHlJ15U=;
        b=ZUMGSEpZc1oLmVDZB6HEYFquLQxLb01W2xt4H1ui4fPGWchJURh1qgVlpzHJmNpi7y
         UVfu1ebVTjBGg0Am/+Sv7WrLC5XDoq5gli2f7uaNmDOyax/6NvBtR9L3nS71Tc9XlTed
         MiVlpm/yyAAvLqVOtcBTR7hGIzCEEcEk0NNlODfNC3W4uaxR5q6bFMgoY9ayos7MFNKA
         b3t7zqVoC6jwWr8K87sH5mPdS9iw7EBVE5Qmua9p/Vnb2zp0V4F2fnbG/xNl3HrDntLt
         6iAhMd4BBJtW5U6NHlN1aOZ8xIN7tIyNJ2maAHOtG/KM/mqyf/CbMuHA+ddMEAmuf/Yb
         R0FA==
X-Forwarded-Encrypted: i=1; AJvYcCUAOL6wFwutnLaU2w6TCYaq4vjhsTrdaT+AMyCX9vPGzEmgbOKVlgOGJjXasp5kd+8RAxDzbSFahxXMBvf+@vger.kernel.org, AJvYcCW2tk0/XGXCMeHeMJE0VnpEAlJQjKGGVGlGWxyBiwPYP1kVJVVpQiQgLDgEDYbHSCTf0Q7tNeQlNXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRQpqefQKklZIGH0O9iek/zI6Q7zVsRskLburlepIKfD73CH5k
	FAl1rE0/HiiVq5TnOYxigq4RNKqhz+M88iEUkP9Rh0LYsQ1NTm1S
X-Gm-Gg: ASbGncsSOb4nd43ZKhB2MuO43cXwNbnlH/plz3R8eZM/at+YFNHKm6/awiFIo5Xnwmm
	sj840Gf0GRyepUth3j0v6pU9slSf1glNilhwUW0hlH4wvpWa/4UhG8mem0e2KmU3HM7gbz/YWsS
	wQ9ThhSkDBMYl1RlQBBEFjjOR4EabzK6QkaZUpp0XNGXN7edAz8hQCK5eUqyiqoor1JspvZy2c6
	TMdbVwcmsM9m0Kc3Bj6SxWnl5a1800LuAsRjTYpiX199QggxiID1w5qeDiGorrEXiGAqB2F0a34
	eB1xdapz392S8+eL
X-Google-Smtp-Source: AGHT+IGMGpaA90GHEQ6E0t84HtFzEX9s6mfNRK1/lHN0kH62/PnZ68jZEVHeyllrAP8z4UXqOgvqdg==
X-Received: by 2002:a17:902:ccc4:b0:215:6c9a:15 with SMTP id d9443c01a7336-21614dc52b5mr77649245ad.42.1733545447904;
        Fri, 06 Dec 2024 20:24:07 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e5f24esm36224995ad.83.2024.12.06.20.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 20:24:07 -0800 (PST)
Message-ID: <c7cee2d4-5bbd-4867-ac12-a0a2f73f6c44@gmail.com>
Date: Sat, 7 Dec 2024 13:24:00 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: rdunlap@infradead.org, surenb@google.com
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
 dave@stgolabs.net, david@redhat.com, dhowells@redhat.com,
 hannes@cmpxchg.org, hdanton@sina.com, hughd@google.com, jannh@google.com,
 kernel-team@android.com, liam.howlett@oracle.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, mgorman@techsingularity.net, mhocko@suse.com,
 minchan@google.com, mjguzik@gmail.com, oleg@redhat.com,
 oliver.sang@intel.com, pasha.tatashin@soleen.com, paulmck@kernel.org,
 peterx@redhat.com, shakeel.butt@linux.dev, souravpanda@google.com,
 vbabka@suse.cz, willy@infradead.org
References: <9baeaab7-61d8-4121-8aa5-cf1c129daa40@infradead.org>
Subject: Re: [PATCH v5 6/6] docs/mm: document latest changes to vm_lock
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <9baeaab7-61d8-4121-8aa5-cf1c129daa40@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 6 Dec 2024 19:23:59 -0800, Randy Dunlap wrote:
> Hi,
> 
> Can someone explain what the (consistent) usage of '!' does in this file?
> This is the only file in Documentation/ that uses this syntax.
> 
> 
> E.g.:
> 
>> diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
>> index 81417fa2ed20..92cf497a9e3c 100644
>> --- a/Documentation/mm/process_addrs.rst
>> +++ b/Documentation/mm/process_addrs.rst
>> @@ -716,7 +716,11 @@ calls :c:func:`!rcu_read_lock` to ensure that the VMA is looked up in an RCU
>>  critical section, then attempts to VMA lock it via :c:func:`!vma_start_read`,
>>  before releasing the RCU lock via :c:func:`!rcu_read_unlock`.
>>  
>> -VMA read locks hold the read lock on the :c:member:`!vma->vm_lock` semaphore for
>> +In cases when the user already holds mmap read lock, :c:func:`!vma_start_read_locked`
>> +and :c:func:`!vma_start_read_locked_nested` can be used. These functions always
>> +succeed in acquiring VMA read lock.
> 

Quoting from https://www.sphinx-doc.org/en/master/usage/referencing.html#syntax

  * Suppressed link: Prefixing with an exclamation mark (!) prevents the
    creation of a link but otherwise keeps the visual output of the role.

    For example, writing :py:func:`!target` displays target(), with no link
    generated.

    This is helpful for cases in which the link target does not exist; e.g.
    changelog entries that describe removed functionality, or third-party
    libraries that don’t support intersphinx. Suppressing the link prevents
    warnings in nitpicky mode.

But in kernel documentation, there is a preferred alternative.
Referencing by function names is the way to go.  For example:

  calls rcu_read_lock() to ensure that the VMA is looked up in an RCU
  critical section, then attempts to VMA lock it via vma_start_read(),
  before releasing the RCU lock via rcu_read_unlock().

  In cases when the user already holds mmap read lock, vma_start_read_locked()
  and vma_start_read_locked_nested() can be used. These functions always
  succeed in acquiring VMA read lock.

They work regardless of link target's existence.
Kernel-specific Sphinx extension named "automarkup" does conversions
for you.

HTH, Akira

> thanks.
> -- 
> ~Randy


