Return-Path: <linux-kernel+bounces-550211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A4AA55C9F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0618188D660
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3EE82899;
	Fri,  7 Mar 2025 01:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwcNxivV"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89F2DDA9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 01:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309606; cv=none; b=AJk5oT1Wx85OCoZBf5ZEgDdhpD8J8Tg+gz/CfAWSyy7O85gXIUiibJYbCTon8HYPeV1n9gVkwRxSvPzER2E5Wc0aHOEPwNCBG9VUXyREi1EZjsDSWSKngvhFaRPePgdZ7VBfo3bjiVeCEKZwck7NlNWWM3AS6EdTfeNFh91wsfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309606; c=relaxed/simple;
	bh=3rq6FdcWehS+selXSyYUSaOTTLWNqtE9Jj1n5H5XK5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMDm/4sFTBss2hta+aRq4/F5rGpyK6EPLk4xJjLgq/4ENqrwZqFYJWG5+NbWsCec89XgMt4x47NvyILThJ1D2nNqoExPnJK25OBhN3FWYorEPLpaz8GI/HESJlPRvO1WozQOefH+brQRoQ5NqcFMKEAL7zJFfGBL+o1RfxpCUPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwcNxivV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223f4c06e9fso25085705ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 17:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741309604; x=1741914404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m2yycGHlxZwOczTAamkagrVVXeboHQ+mERBCKpmoV/U=;
        b=IwcNxivVF9n3x/SJx01G7GjpQ2G1wK7OvaxlWMZjcd4ue2/8G0KWDrSf+jBsG6XbPO
         rbsndDNjD3+LXHZu8HYkBIxCytTPlzU+dnx9maIBZPRo+WmwpAVn/Cf93nTWf/j3s/ry
         rbx4DhyivK+cy/4HiPkt6HqSWrUgPZxAgkfY+cqFMZ4BgbWLFmXixv620PLL9oLZd5Sx
         XR07m9hmF6NqaxTINmZ2sIIhQWpNXgxA/L4REdQb9tc3kcSXtTAeW0kwquF8yvJBpdO9
         1/ARooQj+C8vxOMWK4m37CDdS3Xdnvs9HegM4wKlkkc0zXJskwgDi6ZT4DyhvOm9Z81g
         3PgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741309604; x=1741914404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m2yycGHlxZwOczTAamkagrVVXeboHQ+mERBCKpmoV/U=;
        b=WH45EylUJncNspRA4d9+aiSpF/gZ0yBlq8eqx5XCCyKx7s0rcjE7nsguz984bJxrIT
         chzMfYtFR+TZgINHcE2cc3JiNx3oLF3MhJ1F0bpzgFVaB0eDKsFh7+2cH3kp6M0aeRmX
         GSR0DU4acB1dNo97R2josU61+yxhCfDBDO5HbnFfXhQZYC+YRJBGQayHdA3HI0dJvkDb
         G5odTAFA71H7myxOxJuqll39nWwXKuGMhgNmhv9RNffD0jMX+YSpAHuFNuHPdrTLOgzX
         qLpzheuHePZjooiN1SZc4Kuw1v3Yi+sYqwF8qJoQLgko0Xr5NVyHqEY0+st3VHkEnNET
         0dqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq7pXeVvIF2G0qgG56Wvh2+g/6u5jUhFhOEB3An8h2sqI/Yt9AFxKDJq53BbYFpskbqa9GulYc0k7Lpsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPa/IR66GVfklZiqJrE6LzFPBv51IojsO/r4cr+gpzt1nbgp0f
	IQc6/dtM+cIaFolqbD96DYuHn4ILBYudBJEHLEereE/I/UpvdbMTURtb3g==
X-Gm-Gg: ASbGncs1Xvc5X1D0aXZ2LlUkMflJCi/xiZM8dJX0FvVrA65pVPCLPHNm4jCoMBTm0Kk
	NkXst/ab9YQKuMZQfBdGrXzrasTFexiE6yU0jxNUw5kDT6gZBtS4V1zjqTyzsVEjbU5VB9MVaGW
	Ktji6b4zxSHEgFxJw/J/LhaLcLdwL9JY6jCc8+UU58xkStmSoe6ZTYvIbBlTCx4CzFsYxcRGbYK
	QxifPphOePN/vZ7B2KCnr+t+pQtu1wJr/cDRLAJvMaJ/Rev7cp8Fknr4MSRkvLle7M4uSrSE2rw
	D6RDGQkK430ET1I2yDd4Hk0kVkfCoP6rIb4xEvMpUT3aY5LuMwUQ8rUAqp7qFgGQsj2KXtXL57k
	F0HvkUthq4wvR9yc=
X-Google-Smtp-Source: AGHT+IGQB2JK30Ur4K4C2V18CwoN2sLc7QQ0rsJrBCGID8Yzs3mzNdwtN1/YQOazL60MmJv8di15RA==
X-Received: by 2002:a17:902:e802:b0:221:89e6:ccb6 with SMTP id d9443c01a7336-22427071ce8mr26562275ad.25.1741309603835;
        Thu, 06 Mar 2025 17:06:43 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a908a0sm18823665ad.162.2025.03.06.17.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 17:06:43 -0800 (PST)
Message-ID: <638eee89-dd74-4a7a-b780-03ac53860098@gmail.com>
Date: Fri, 7 Mar 2025 10:06:38 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
To: Yury Norov <yury.norov@gmail.com>
Cc: viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
 linux@rasmusvillemoes.dk, vincent.guittot@linaro.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <1489a042f329b1c1238756c68fd880e2966f242d.1741257214.git.viresh.kumar@linaro.org>
 <8cacf9df-fb8e-40d5-a716-cc43a266b43b@gmail.com> <Z8njHKwzQXdaUAjD@thinkpad>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <Z8njHKwzQXdaUAjD@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Yury Norov wrote:
> On Fri, Mar 07, 2025 at 12:38:41AM +0900, Akira Yokosawa wrote:
>> Hello Viresh,
>>
>> On Thu,  6 Mar 2025 16:06:50 +0530, Viresh Kumar wrote:
>>> This fixes various kernel-doc formatting errors in cpumask.h:
>>>
>>> - WARNING: Inline literal start-string without end-string.
>>> - ERROR: Unexpected indentation.
>>> - ERROR: Unknown target name: "gfp".
>>>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>>  include/linux/cpumask.h | 65 +++++++++++++++++++++++------------------
>>>  1 file changed, 37 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
>>> index 36a890d0dd57..73ba808c559f 100644
>>> --- a/include/linux/cpumask.h
>>> +++ b/include/linux/cpumask.h
>>> @@ -20,7 +20,7 @@
>>>   * cpumask_pr_args - printf args to output a cpumask
>>>   * @maskp: cpumask to be printed
>>>   *
>>> - * Can be used to provide arguments for '%*pb[l]' when printing a cpumask.
>>> + * Can be used to provide arguments for '\%*pb[l]' when printing a cpumask.
>>
>> kernel-doc (script) can recognize the pattern of %*pb but not %*pb[l].
>> "%*bp [l]" should work here.
>> (without quotes and a white space in front of "[").
> 
> So why not fixing kernel-doc instead?

That would be great!

At the moment, re-implementation of kernel-doc into python is under way [1].

[1]: https://lore.kernel.org/cover.1740387599.git.mchehab+huawei@kernel.org/

It is a bug compatible porting from perl to python3, but it is likely
to be merged during 6.16 merge window.

I think it would be nicer to do the fix on top of python3 kernel-doc
after that happens.

        Thanks, Akira

>  
>> No need to escape "%".
>>
>>>   */
>>>  #define cpumask_pr_args(maskp)		nr_cpu_ids, cpumask_bits(maskp)
>>>  
[...]


