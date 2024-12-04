Return-Path: <linux-kernel+bounces-432224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 426649E47E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D311188038E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDD01A3034;
	Wed,  4 Dec 2024 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hfsRkg0I"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612F923918F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733351440; cv=none; b=tBsOCrzgVkJOlnrg+vJ4Sy1imcJfh9b2uYBnDIQf5iOXm/6k+C/EbJ4wVred5h6XdjFiCI8NdRx4pB0HpQ4Gi6Fq6O2/dpcRNrVm95qDViPNjFd0MgxrXI03GxIhukoF7ypGWW2QcVr8JZI9iQpXe3oSJfKYhPwTSCHBduIbESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733351440; c=relaxed/simple;
	bh=2W76BwgYTaY8BMBUrSK3r3wqcVj4DI/Bw19AahkjuHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOQljjaxHHhAzaD6HRN/MZbSQpwLMofduK/wdgqtnKRq+4fZegfESEYBtxlWVaTF/C5Rf4x788r+Nk/7NyVLnk1HHFlGruSS2vHc0LvuN0+w76X/oVD7c6s3G+vQqyvNG3gDSWsnoWTPtShYyUpVqYWa1lQifKijEl0Sijr6XaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hfsRkg0I; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-84198253281so15477639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 14:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733351437; x=1733956237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBAPx5MutJG9QZBlRN1w16+Dcb9X7267OMnJ/wnzsDk=;
        b=hfsRkg0II3McClw2KA4kCf0fQegnBtjQm4EBaIcwV07WIuO3lFhQuUC3Qh+ghi53qh
         xLDoV/x6DyzgwtgA+TwYi0izkoIP17GCWxhQRYSLT/VLfR16hbd/7A7KnN/t0z1hhJYc
         0hKLsDJYG2jvpQdcFhkZwe+T9iZsImDUSYYcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733351437; x=1733956237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBAPx5MutJG9QZBlRN1w16+Dcb9X7267OMnJ/wnzsDk=;
        b=ShYx+r+jdciw+DjGf00+zsqKlyEDrnshHfKaH8GI5cSXGKZSAzjhgntDqFEw1U4n56
         IsieEH5/LkIYYdI4ajCNkIEpyNZYHx8YLrCL1TGym4CPG+QfG4eBtGyaTwvoP6ZQVFFw
         P1Mi0oJv6wkF/jSEzK2neXnOcqIcMgLc1bQFmi8jzwt3mzD/eOWzVzvrjvJ3CaBFMN3L
         T0eyiU2e3BMjxkFuzhlcezvFwAMIae/9IyAraj1JbTKgrJ1Qhm3P7Fpl1m64MYA1Rp+n
         ErKO8H7rZLIb0v8jWtjU4YKntEQcbGFc2vCIpllUCVzKUvWLU17gk5BeqKsyqIwLvrnH
         f3Ww==
X-Gm-Message-State: AOJu0YytmgiZywqdOhg2mysKem0U3kZ+7BIy5A5lI5CDR807Vgm146fp
	XimwLxeXx+abgySD6daSQxRHwfTb0iDSXg1JJ4vCWBqhg5mCmIe4qJ5WkcrMbuU=
X-Gm-Gg: ASbGncuHHhqB5ZkTczYTV5vKffK5YPSxgIK7gLJoRWUZX5PRKLGfpw1VlDYHeYouuJ2
	WBNcN1RijDAT3u3kg6BEaTWdHsPHKqdejx7DwNs200PC/rewDAElbl8vPboovgoAgVWVciTKpRa
	5HVZpMyKyCGh+adf7szB3JTsLDdpsSyCW0qxZej3z1AQxtk4T8Lg84QrYob6L7pptllYV3b6CBh
	E9j4OOwzQdslKy1o1tItU+EJqLEMquUhKFZhDsX4N5txR2inI6kDAtSySNigA==
X-Google-Smtp-Source: AGHT+IEtpVsNZMHovsy1F6jhvCGEmwJf1FkuOsG4iZhtjX2gQi9WDFjwraG74nPduIC6i7nXb7aOkA==
X-Received: by 2002:a05:6602:6b09:b0:83b:2c8e:c4 with SMTP id ca18e2360f4ac-8445b56f271mr1063808939f.9.1733351437544;
        Wed, 04 Dec 2024 14:30:37 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e28611b767sm25155173.42.2024.12.04.14.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 14:30:37 -0800 (PST)
Message-ID: <297cfe11-0418-4633-8c15-4ffc7d290a3d@linuxfoundation.org>
Date: Wed, 4 Dec 2024 15:30:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/vDSO: support DT_GNU_HASH
To: Xi Ruoyao <xry111@xry111.site>, Fangrui Song <i@maskray.me>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240915064944.2044066-1-maskray@google.com>
 <f229fbad-731c-4dd4-8c66-ff8829c2c958@linuxfoundation.org>
 <c828b254fb93bd136b36d3a06ab1d9d29ce13d88.camel@xry111.site>
 <b2723ccd-bf0a-4d9b-a545-f9e3dc336539@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <b2723ccd-bf0a-4d9b-a545-f9e3dc336539@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/3/24 17:04, Shuah Khan wrote:
> On 11/27/24 04:44, Xi Ruoyao wrote:
>> On Thu, 2024-09-19 at 09:37 -0600, Shuah Khan wrote:
>>> On 9/15/24 00:49, Fangrui Song wrote:
>>>> glibc added support for DT_GNU_HASH in 2006 and DT_HASH has been
>>>> obsoleted for more than one decade in many Linux distributions.
>>>>
>>>> Many vDSOs support DT_GNU_HASH. This patch adds selftests support.
>>>>
>>>> Signed-off-by: Fangrui Song <maskray@google.com>
>>>> Tested-by: Xi Ruoyao <xry111@xry111.site>
>>>> -- 
>>>> Changes from v1:
>>>> * fix style of a multi-line comment. ignore false positive suggestions from checkpath.pl: `ELF(Word) *`
>>>> ---
>>>>    tools/testing/selftests/vDSO/parse_vdso.c | 105 ++++++++++++++++------
>>>>    1 file changed, 79 insertions(+), 26 deletions(-)
>>>>
>>>
>>> Quick note that this will be picked up after the merge window closes.
>>
>> Hi Shuah,
>>
>> The patch seems forgotten.
>>
> 
> Thank for the reminder. I will pick this up now.
> 

Please rebase the patch to 6.13-rc1 and send it.

thanks,
-- Shuah


