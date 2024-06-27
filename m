Return-Path: <linux-kernel+bounces-232683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0394691ACD7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78823B26FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B225A197531;
	Thu, 27 Jun 2024 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2H8JgTP"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A71487ED;
	Thu, 27 Jun 2024 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505827; cv=none; b=dOWATntwu2j3y/0ZTh9UWWgfcnOl0Wr0w4EUoCXFlCsNrqWDou7xMZNG6mB4PtdXKYsss6hkWHZkH04IPN+i+S6IJYzau2Q0UQLiDUc9gUZpRqjupclVA0aIFG8ixLjTsSQqIW5s22avekYspPn/NuFBqazDPKrRiSyylKfAEE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505827; c=relaxed/simple;
	bh=lLAb8xHD0kK96O04UOh2jrtKgkgm0SY5bvXSLS8pZLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNWCKQ5PZTZZIFVAeaV5o0kcTHfA/j8I9RWC/sGqO6bh7aOuCBPnPhWDndJoxeP5zykmjOvGzVwToSSpOUHCYVKSXgCdeM+l5pMPFcmDMhXmCmGqWTWIGCSDc9Gq0WjsqIRN5adlp0rTG/u66FIJc+WCOEInUCK3WB2DI+Il/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2H8JgTP; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5c40c72c407so423477eaf.1;
        Thu, 27 Jun 2024 09:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719505825; x=1720110625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TFxvBUpgkff4OOWHQfrsMUrnqbP3Vis0skgt8SfYOB4=;
        b=H2H8JgTPYaJDKfUOFaqoLKKl2WjC8hMeilpT/m+GG3X8geNT82CKqS1HCn7xaNy8/3
         NtpXPEeyBSzzh6QisWCqAdwnkEUM4ZzezNCbYyiuKIiNi2BS/jkadXxQZ0LVDV6eLSCK
         mnhPcoz5/fe0Lr2o5qeDtE2oYVeBevmSoz98Pm8b+r0dglthS38oRLfPf9yA3AGFvy3A
         Gl5+qIlPUGesOak8bHvwiHgZKj7rXs/5qKIpGAiO2zYnkjWHxsC4RxMkeIUjhNyKrKR9
         f+k5pyxHVfKRL7MkpcZfjg3j/Hog6yr0KxRoyUmz0iVShNI7jeMNSFzFmjdMyaRR53ig
         syjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719505825; x=1720110625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFxvBUpgkff4OOWHQfrsMUrnqbP3Vis0skgt8SfYOB4=;
        b=qMXpvqcR8DzZ38xgVVygEsuU/KEEYOSeRROR9WbMmqIJAYLJ/jQNDMNtYNgA0DGbjT
         BabEO/nQT35P7gSavDyXlRLQoXq1fsBMKIS3FRcTvxfIg46jFYJHbi8Y0PIc2tynhvv7
         GhwW9mIihdRQUGJ4/R+/jd0WaO0DuxNzbfSeiep8aN8+gBG7it3tNjX/9kOd31YQy+Rc
         xrvAI1lWSjzSSMgrJXKGnu5xOAvL4JpSACeg5UCtoIcc7gOy8lgIrgCg050k7jX4XlZq
         P8b797/4ABO3C+5e8k6XsYysgpSm0NT21zQ7+osel691Y6B+1r2q4YMOst6GllxST9Eh
         K73w==
X-Forwarded-Encrypted: i=1; AJvYcCXYDZbfEp/OK3gGgm/o3os0ZUrM0YZNql2RZp/EdIqPBMe7bURccnD6QoYzA/HsJ2tMtRFhpNYJLz5OpvwOGbMP3u1bDpwk+2VRDfbIFhueoHrj5hSKFugTo7EntQcOCiuOAMvt6Elr
X-Gm-Message-State: AOJu0Yxmh1gNzPzrX1keJodmnKnO+HgHt7q1SUaebnD/4VYhhlAMri9X
	IgukoAxAtFboao6ZfE+hvwpFlUCyyw5VsK8i7IbWvCYjpvxF8aSX
X-Google-Smtp-Source: AGHT+IEPZvKP5U5S28rOh5uRsXbOx7o5V9e0LDJq6EHZaedJ8VjnFjfWoDb4YsG/O0Evw/2nYWyjBQ==
X-Received: by 2002:a4a:7650:0:b0:5b9:e7db:1cf8 with SMTP id 006d021491bc7-5c22a03d393mr5031005eaf.4.1719505824655;
        Thu, 27 Jun 2024 09:30:24 -0700 (PDT)
Received: from ?IPV6:2603:8080:2300:de:3d70:f8:6869:93de? ([2603:8080:2300:de:3d70:f8:6869:93de])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5c405c4fc5esm295692eaf.3.2024.06.27.09.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 09:30:24 -0700 (PDT)
Message-ID: <d3a76784-e3ed-437a-afe8-0121e51348d8@gmail.com>
Date: Thu, 27 Jun 2024 11:30:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Extend and refactor index of further kernel docs
To: Jonathan Corbet <corbet@lwn.net>
Cc: rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, bilbao@vt.edu
References: <53bd3bbf-0410-425e-84e7-1d34cac60412@infradead.org>
 <20240622194727.2171845-1-carlos.bilbao.osdev@gmail.com>
 <87v81vxqm1.fsf@trenco.lwn.net>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <87v81vxqm1.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/24 17:53, Jonathan Corbet wrote:

> Carlos Bilbao <carlos.bilbao.osdev@gmail.com> writes:
>
>> From: Carlos Bilbao <bilbao@vt.edu>
>>
>> Extend the Index of Further Kernel Documentation by adding entries for the
>> Rust for Linux website, the Linux Foundation's YouTube channel, and notes
>> on the second edition of Billimoria's kernel programming book. Also,
>> perform some refactoring: format the text to 75 characters per line and
>> sort per-section content in chronological order of publication.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
>> ---
>>  Documentation/process/kernel-docs.rst | 68 +++++++++++++++++----------
>>  1 file changed, 44 insertions(+), 24 deletions(-)
> Sending this as a reply to previous postings badly confused b4, but I
> did get it to apply this time, thanks.


Will avoid doing that next time, thanks!


>
> jon


Regards,
Carlos

