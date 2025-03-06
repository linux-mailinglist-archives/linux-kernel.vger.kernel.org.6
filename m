Return-Path: <linux-kernel+bounces-549809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DB8A5577D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21BD43AD998
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E44E269AE0;
	Thu,  6 Mar 2025 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XBwR+uC7"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989B11FC7D5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293240; cv=none; b=JVpHp9qtDA+sWKihKeo4WkcUdIalb69RlC6rdwuN6Adq0xFNQZii4FKYRwhOK4/TAWGfFsafOgdOCOSVGubfIusY2Gr8DrmMRsIBZJloDQMCXUV7XdxOR7lJio7q0Uvlzq1AJsrGydjx7skugPH+JIq63pF1jFhDtH4EZSlXHDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293240; c=relaxed/simple;
	bh=SIZ0tBXr7dUaXQTtqSJRA7y83aQRtS5SAAGiC//XLHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McUDCcaJ4b35gEjFKS4jy3R46OmbXej8oY3/n872BsZ2BiujvRAish3V2PScQeD8ijmUWhH4Qu6lS5FO3fb0eebxK3e16z56kzeteIb3hUTMwHib6B6lkOOEB/A8rv4t1cmcJlfGgEpAT6m2VKPOeMJmoxBP9w2UXuOcXH+IQBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XBwR+uC7; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85ae131983eso81155239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 12:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741293237; x=1741898037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WIhhdziM3iU4t3IzVbBCpNdmTjl/KV+FrSoZ0CpQigM=;
        b=XBwR+uC7DnUuJgQ7ErTZQU9j/84AHydPK+ka135A2N8wgC9jNdkIcS9QZRQIoYdt6y
         Y3K/6Utsh2lnVAPwP/m9nUrTapVluHWCZiMbrNkqZ5/EBRipjxbwFF+UefS7GjmQ2u0w
         h1p0fyioSesokouMJ0HURPR00Zz6xbV45mBYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741293237; x=1741898037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIhhdziM3iU4t3IzVbBCpNdmTjl/KV+FrSoZ0CpQigM=;
        b=Einbjk50MNfQOgHQXhTbul25Z1fLBLohSYBlofMAVd8oBtDR0B0AV3+rKcqhIPlf6p
         1t5KaRlrRvhksgX0X7PxR+CoC1FRT+qBI/WUFj+Ob2hJ1CyEnyLBAT88GcGXFhN+pdXu
         pxeeVMJRPwQXdHxjwu9x9lJi9j5DpGkA3YipUxbPfoc8DGJJsqrmM0xN74zoPS4RsqTC
         Pjf/5IFIrap84voFAQywmuAVBhMqX2xvr1l+BiDQDhzer4E8omFxyMAr847RUxkKp91v
         WDbGtUnWEDlUVBuY42XcdVmIbYtbwr2CFcNZqJ6YWrKkQrD51h+csIBrNi3NoHX4lOSF
         aCTA==
X-Forwarded-Encrypted: i=1; AJvYcCVJsKQS+n2s2k6khVQErUW/Sqg0yXXRXbd1sgdEN9aa9K+E1uBOfl+Bk2kkQPa9n9NjC1b67n5EUooO1aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxPrnSLEfktct69BgprqCHo7cR0qYKEG1qa6YQMNgsLd+0033T
	HpIjOtWtk90zLzE7xeuD3ygipfpsCYXPljwY8OVYfdn0tfzZ/4FTKJCR4fYsifw=
X-Gm-Gg: ASbGncu8Qmnvw+bzBN9eGIevd/QSSxD/mvm+wWxJBva1su0kB6ELof6mqYm6uLpkofr
	bop+jqMKs3gSranwSNxT7yifqcnjji/RB7UcitUmSrwssZssTod3weRcPFnZYp/sH6Nayy9SXaV
	V3d6LZULiIimU69+hf/Q5UXZWj21WiFPZkGkVYj8nzM/pzkMGQEaLABmJN0glcQSnueJm1tfdvG
	Orb2myY1vY+PqZjb2pXbIYlnfHp/BbP9xOtt2LEKKSAGXlsIkYGsR9e+4PBe6VrhVjtw8g0xCi1
	b9is/s7ScxgVScofXWPGhV4Grdjxu0L12nU/F294SYHKaN0N994qYBA=
X-Google-Smtp-Source: AGHT+IFn1RRbyMg/82EdQHWJDM6fySYuvESRAD5YIJzAaWoT1EYQ7doQLWKl0VFK0CXtlAmzhAUxTg==
X-Received: by 2002:a05:6602:720a:b0:85a:fd37:1c65 with SMTP id ca18e2360f4ac-85b1cf985c4mr146678439f.5.1741293237713;
        Thu, 06 Mar 2025 12:33:57 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209df50e4sm529476173.8.2025.03.06.12.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 12:33:57 -0800 (PST)
Message-ID: <cf81280a-fd37-436c-aefa-fba5a4df87f6@linuxfoundation.org>
Date: Thu, 6 Mar 2025 13:33:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Implement CPU physical core querying
To: "John B. Wyatt IV" <jwyatt@redhat.com>, Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 John Kacur <jkacur@redhat.com>, "John B. Wyatt IV"
 <sageofredondo@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250305210901.24177-1-jwyatt@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250305210901.24177-1-jwyatt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/25 14:08, John B. Wyatt IV wrote:
> This patch is also an issue report. get_cpu_topology will always save
> into cpupower_topology a cores size of 0. The code to handle this looks
> like it was commented out, and what is commented out is missing a curly
> bracket.
> 
> https://elixir.bootlin.com/linux/v6.13.5/source/tools/power/cpupower/lib/cpupower.c#L206-L212
> 
> Inspiration was taken from psutil to implement this by querying
> core_cpu_list. Instead of using a hashmap, I used a sorted array, and
> counted the number of valid unique strings. The counting of this takes
> place before the qsort for .pkg as the following code says it is
> dependent on the order of that sort.
> 
> The previous code claimed Intel CPUs are not numbered correctly. I was
> not able to reproduce that issue and removed that comment and the code.
> 
> This commit was tested with the libcpupower SWIG Python bindings and
> performed correctly on 4 different setups. The most notable is the
> Framework Intel laptop; a hybrid system of 4 P cores (8 threads) and 8 E
> cores (8 threads).
> 
> The 4 setups: A 4 core virt-manager VM running Fedora 41 4c/4t (specs not
> listed) was tested as a sanity test for VMs. A Lenovo Ryzen 7 Pro 7840HS
> 8c/16t. A Supermico Intel(R) Xeon(R) Gold 6330 CPU w/ 56c/112t with 2 CPU
> sockets. A Framework 12th Gen Intel(R) Core(TM) i5-1240P with hybrid
> cores.
> 
> CPU(s):                   16
>    On-line CPU(s) list:    0-15
> Vendor ID:                AuthenticAMD
>    Model name:             AMD Ryzen 7 PRO 7840HS w/ Radeon 780M Graphics
>      CPU family:           25
>      Model:                116
>      Thread(s) per core:   2
>      Core(s) per socket:   8
>      Socket(s):            1
>      Stepping:             1
> 
> CPU(s):                   112
>    On-line CPU(s) list:    0-111
> Vendor ID:                GenuineIntel
>    BIOS Vendor ID:         Intel(R) Corporation
>    Model name:             Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz
>      BIOS Model name:      Intel(R) Xeon(R) Gold 6330 CPU @ 2.00GHz  CPU @ 2.0GHz
>      BIOS CPU family:      179
>      CPU family:           6
>      Model:                106
>      Thread(s) per core:   2
>      Core(s) per socket:   28
>      Socket(s):            2
>      Stepping:             6
> 
> CPU(s):                   16
>    On-line CPU(s) list:    0-15
> Vendor ID:                GenuineIntel
>    Model name:             12th Gen Intel(R) Core(TM) i5-1240P
>      CPU family:           6
>      Model:                154
>      Thread(s) per core:   2
>      Core(s) per socket:   12
>      Socket(s):            1
>      Stepping:             3
> 
> Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
> Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
> ---

Thanks. Applied and will include in my PR for 6.15-rc1 to Rafael

https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah

