Return-Path: <linux-kernel+bounces-257751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9756937E6B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 02:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534291F25D90
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 00:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66576EDE;
	Sat, 20 Jul 2024 00:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIPt5FH1"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7093201;
	Sat, 20 Jul 2024 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721434032; cv=none; b=jybI+l8rsYIaIp+HYpyoks5SSAYnoROrPjWN6ugcXmnkzBEMBoM1vbY9mA0EGXbpKHEnPZQ/gYmFx9eVx3jjm+f0teG9K8hVC+AiQPtJJT7dAl1UI4pChPhySW/cUCRAOAny+CULDRp42h8LT4IGzNM581LxyrJq6bjaIEisxE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721434032; c=relaxed/simple;
	bh=k3hBCtkSebA8AJGEiTfejozm3uyEXASbHLVBRsrHJSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aB2HoT3J4i2mPLBaVawRp5KALxJhNZ4c0I7dxM27WdtCbA1Beqa7ZVQGGBds2jg+I9YN/w+tr4oL3Zw3T9hbJdG3Qmt9dvqWmnEyHKl3kaaj1xSeO4XjK02pP5/sMHpqk6hUh+aAgDeV7ZOxoEIhzBtJkuTPT25ZXpymZ5ovBCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIPt5FH1; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-25e3bc751daso1249413fac.3;
        Fri, 19 Jul 2024 17:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721434030; x=1722038830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZuvNILcrHmZjVuCm63Mu8D6irELlymR43t41iUuR3/0=;
        b=nIPt5FH1JiXzelGySuhqniPX+dVipI3PpoBVKWlwHGqNQROeDVeV+NzqtcOBuTowXL
         UxNMlMfILJ1BK7STT7xMkhoTfpF+DvD5GoT+pZmriUsbz2Pyh8l7QDxWQM0BPDnau16X
         kE9QJQsDPGmlapqAmialg8zBV+fWRfzuRB4v/R42SAXX7OLkPCFd674MzEcT6263+S3R
         u+S2+jBpPaM1DZfXifgcZTI1fLBoZKoqnnCZgFqoolWh/xnn93nUj5GXx/8O2gWOEJkQ
         DyIAz1BFltOcxkd4Vn+e+3k/czfzm1MXr32XhJlWvuz8cm0cRNXjaikf7Uk5Sxc985Jr
         gffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721434030; x=1722038830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuvNILcrHmZjVuCm63Mu8D6irELlymR43t41iUuR3/0=;
        b=hdHpjKtFvN9K8ye9bGd3NIpMP14SA4+S0ULzdng4fEmlQLL3JgQmZj33/fd73Gvj1l
         j0P77u/FXF3J5HrHEHR9JPBWAQAFlgHSRsJ4XLZPnyRwGMsPHa30VhVRY8AbhTMAo9pv
         RTrIkIKLDBb7JWvAqH6kJPSPpMa99KzieWTpK6nBq776GGucDQXxv2EKC4YRhdtPFzTE
         CeAFjbOl/SaC01Pe9P5UjdkUKwzxUiFvSWjh3egUkjbJgksb7RmlEbybH7TFNt1k8uRy
         K1bnELElgP1AZSYJDocshqJvkoIFrcmzU1x16jaqJSmU/iruu538F+eaWwz0+fHfBToJ
         CWyg==
X-Forwarded-Encrypted: i=1; AJvYcCUyXlGJKjnoH52mS/8GQugluwyHyjwyB/rhxJM05CsYsThR2vwQk3sAa5Wh52es/xUchsp4SAU+XuaEO4T9VXHfiYKdg8nrwhVj5W5rD32J9vn/dMiToplZ8kFJu20xYuMxego4vp8m
X-Gm-Message-State: AOJu0Yw49MdcWXi3vurtxwV8uSKGKOtXCK4CuNPEsgbK9uXOrMnaJY3C
	Qkt8PSHEpdemqUgdD+U6xN/ohIvngIqSY4j7OKVHoYBty4oicD1Q
X-Google-Smtp-Source: AGHT+IGswl4b/RLWR3aV8ZSPIJWzAyWE1Vi1y7/s9z4GFnEpVS6pXmbk8+gCTcqsD1JycoFXVtoNPQ==
X-Received: by 2002:a05:6870:9613:b0:254:b337:eebc with SMTP id 586e51a60fabf-261215e714fmr1159283fac.35.1721434030220;
        Fri, 19 Jul 2024 17:07:10 -0700 (PDT)
Received: from ?IPV6:2603:8080:2300:de:3d70:f8:6869:93de? ([2603:8080:2300:de:3d70:f8:6869:93de])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60a582fsm526556a34.12.2024.07.19.17.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 17:07:09 -0700 (PDT)
Message-ID: <55674f3f-30d5-4da4-8fe2-0efafec5d3bb@gmail.com>
Date: Fri, 19 Jul 2024 19:07:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] docs: scheduler: Start documenting the EEVDF
 scheduler
To: Jonathan Corbet <corbet@lwn.net>, sergio.collado@gmail.com,
 peterz@infradead.org, rdunlap@infradead.org
Cc: bilbao@vt.edu, jembid@ucm.es, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240713140455.4072847-1-carlos.bilbao.osdev@gmail.com>
 <20240713140455.4072847-2-carlos.bilbao.osdev@gmail.com>
 <878qy1uvyw.fsf@trenco.lwn.net>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <878qy1uvyw.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/24 11:45, Jonathan Corbet wrote:

> Carlos Bilbao <carlos.bilbao.osdev@gmail.com> writes:
>
>> Add some documentation regarding the newly introduced scheduler EEVDF.
> A nit, but one I wish more people would make note of...
>
> [...]
>
>> --- a/Documentation/scheduler/sched-design-CFS.rst
>> +++ b/Documentation/scheduler/sched-design-CFS.rst
>> @@ -8,10 +8,12 @@ CFS Scheduler
>>  1.  OVERVIEW
>>  ============
>>  
>> -CFS stands for "Completely Fair Scheduler," and is the new "desktop" process
>> -scheduler implemented by Ingo Molnar and merged in Linux 2.6.23.  It is the
>> -replacement for the previous vanilla scheduler's SCHED_OTHER interactivity
>> -code.
>> +CFS stands for "Completely Fair Scheduler," and is the "desktop" process
>> +scheduler implemented by Ingo Molnar and merged in Linux 2.6.23. When
>> +originally merged, it was the replacement for the previous vanilla
>> +scheduler's SCHED_OTHER interactivity code. Nowadays, CFS is making room
>> +for EEVDF, for which documentation can be found in
>> +:ref:`sched_design_EEVDF`.
> If, here, you just say "can be found in
> Documentation/scheduler/sched-eevdf.rst", the right cross-reference will
> be created and ...
>
>>  80% of CFS's design can be summed up in a single sentence: CFS basically models
>>  an "ideal, precise multi-tasking CPU" on real hardware.
>> diff --git a/Documentation/scheduler/sched-eevdf.rst b/Documentation/scheduler/sched-eevdf.rst
>> new file mode 100644
>> index 000000000000..019327da333a
>> --- /dev/null
>> +++ b/Documentation/scheduler/sched-eevdf.rst
>> @@ -0,0 +1,44 @@
>> +.. _sched_design_EEVDF:
> ...you can take out this unnecessary label.


Love it! Labels are a source of warnings.

Sending v3 now.


>
> Thanks,
>
> jon


Thanks,

Carlos


