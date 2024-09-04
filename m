Return-Path: <linux-kernel+bounces-315475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 358F496C31B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B8C5B2856E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF101E0B81;
	Wed,  4 Sep 2024 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W29J2V+5"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE5B1E0B78
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465139; cv=none; b=HIbAAisdPIOjan7cVdls2L//HlnGwYkjkS8r2N7OU24pEl4Q4UIejBo13VtQnG6YdzhO5OVybBFYpkW2BzoYWguzuxnmOHznhn/WlJghBsn09eOBvnAGLLjqa5eueM1m6CG4NwHGHrn/sz2954OWQcEMeb3kDfMMKQbbwuA78XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465139; c=relaxed/simple;
	bh=rYyRA6enZf3Z+Vz8JwkHG41q18ctJtQgk39vRKV2Scg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szYYD2ErYxG7RTYAIX+jXC/AgIJtiAoQ59ev4eebY9GDSiBi1asq9BWK+mZveiT3L/TntDp4cgqPUkqCHSelGG7QPHF7+w/7zSuRYmzyhqwSoGBqs5ax2VQTBeKjWFU6TVzqlcS24vymJL7b7m1SxXl3yQztF/T0gWAOLIQSFL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W29J2V+5; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39d4a4e4931so24481805ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 08:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725465136; x=1726069936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1F6z7aom2l+zwYv4bAFPmXnr+9mQvzC1zWeuLt2yJZg=;
        b=W29J2V+5+juvf3idKJ3mJic/TaaRyg8bS1NNfPvj4V3jBe3cx2qiHvoVGIMIQ1mkHE
         4zG644ubxbMhyxDRsuzo7dNFTQMvQBx5K5QfYC8RyIJk+jRyzq6wAwTOEPejWCHMNY7r
         NIDb2aO0FE6VTfK1LQCz+R3UJxppOnZXLDDlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725465136; x=1726069936;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1F6z7aom2l+zwYv4bAFPmXnr+9mQvzC1zWeuLt2yJZg=;
        b=Jo+gqBXAsdBt+ztfTGTnOdWF8FIK49B+HAjXarLlXVOzThIe6tz0fS11vk381ZTRSH
         sPJfsL8jDqMCJ8P1dN6noNsBOcXPPeKhGnXtbYXSp2Cyqy1zwCcBeR2d014BfG7ZH/SM
         ePT6L8/lc3Fpuni/dCrId73Ad/oWwaOTdNlM3m44+6neBecMRjNn0LyFRcQzR6B1SXpL
         MTNRgK0rguMrDcls1/TrYQmrxhdo8QG+zj51UeqVZsYjPISV3gU43DNdnzQpRzKmH2JE
         C4jVCevJfWCIuxSxb7m61DF+P/MD3JHkvvL/3ITN2KOZ3s077k6qpUbvTJkUkSkZVlbn
         GygQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvxIISxxc9/WoaeFQCIUo7MKah3tOHdqXmSd0PYkRt75rk1QJrGKhMatDXSoUwcvVQFexe4fHLqrUdjH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxLVPvM2C3un5TrjKi+rWMmtdfviKx1T/zvD0jFlNjMiDUBm2U
	KmoQqljGxn4zqMn8/2CaJ6pmF0fgGvV+UfxIw7UfyG1PzH5EFmhkH35d3dDhwhM=
X-Google-Smtp-Source: AGHT+IGJxj99I7Lx9VRpurNkyqRoE4VY2BE28+JGwvHWANHOTMtgECHvU2Ope7Zpogwhuz+Bze5fJw==
X-Received: by 2002:a05:6e02:152a:b0:397:a41d:aa8e with SMTP id e9e14a558f8ab-39f37879fc5mr237963445ab.0.1725465136595;
        Wed, 04 Sep 2024 08:52:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2de5f52sm3186226173.44.2024.09.04.08.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 08:52:16 -0700 (PDT)
Message-ID: <f469b5b1-a846-4add-a629-b0a415e9fcab@linuxfoundation.org>
Date: Wed, 4 Sep 2024 09:52:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add SWIG Bindings to libcpupower
To: "John B. Wyatt IV" <jwyatt@redhat.com>
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>, Arnaldo Melo <acme@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "John B. Wyatt IV" <sageofredondo@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240827062438.71809-1-jwyatt@redhat.com>
 <ab9e3727-9978-4a30-8bff-e366fa5defc1@linuxfoundation.org>
 <ZthrAiB2j-l-V2wu@rhfedora>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZthrAiB2j-l-V2wu@rhfedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 08:13, John B. Wyatt IV wrote:
> On Wed, Sep 04, 2024 at 06:41:14AM -0600, Shuah Khan wrote:
>> On 8/27/24 00:24, John B. Wyatt IV wrote:
>>> [snipped]
>>
>> Couple of things to address:
>>
>> 1. I noticed none of the patches have the subsystem prefix:
>>    pm:cpupower is the right prefix for patch subject for all
>>    the patches except the MAINTAINERS file
>>
>> I will pull the fix  "Implement dummy function for SWIG to accept
>> the full library" Patch 2 in your series.
>>
>> I want this subject changed to just fix as it is a problem irrespective
>> of SWIG - we have a missing function. Subject would be as follows:
>>
>> ""pm:cpupower: Add missing powercap_set_enabled() stub function"
>>
>> Make this the first patch in the series. I will send this up for
>> Linux 6.11-rc7 or Linux 6.12-rc1
> 
> Understood.
> 
>> Depending on how the timelines for merge window work, expect the
>> series to land in Linux 6.13-rc1. I would prefer to delay it anyway
>> so we can get some soaking in next.
> 
> Thank you, I appreciate it.
> 
> What kind of soaking are you looking for? Is there anything I can do to
> help?
> 

It is more the timing than anything you can do. We are at rc6. Please do
send the series with the changes I requested.

thanks,
-- Shuah

