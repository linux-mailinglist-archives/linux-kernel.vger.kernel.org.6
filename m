Return-Path: <linux-kernel+bounces-187332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBD88CD04E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83C52846A7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB21E1411CC;
	Thu, 23 May 2024 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D7xUTNRp"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D353D13D521
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459878; cv=none; b=DbFL5mIgCBXX8oQ3wXMakR1K9VQYnPTfT2bIpJHq1nCfuKMBKi89dwSDJbkTMfT3GStB6G7Iudmy0yYREPKPL/AJLPWzCU6AvtUCufW0uDXZi/Ve2N1Ow3ZSPtPlDnvYsTQ/nKZnXSosxKAYPrg9D7ISWV/eFQFpWZvi9NzLgCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459878; c=relaxed/simple;
	bh=8mmHL5zRdKDpfa+BX5Qv+EvBtvTwdEe/vT3Q2ZZV8Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjP0CHi08FmEMEN1hC55l/Z11/eM2/Smnx3bpVAEdPmpTyTAdBOYPDMgxX9QqBfPIA61lMUTiPVplNluxAHzdMxg4MQ1UCoMZ6ZynGMoKSd8Cu1vbqRFPSFhLDGvUXGbom97PcEpjA1pZFHke3/sPX9SbHXXxCfwI76QR93p9DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D7xUTNRp; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so10600317a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716459874; x=1717064674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ogUGYLdwLjzH6+2WofnJ6KEdP2Qlj68VzxkGxDXY+wA=;
        b=D7xUTNRpmMQQ9Md6BxJlAt8siSQw61Wp5Z/A5sWBNHDl9pvG5wDu4QLlKVJB8NxdWT
         IMqhDm+yg/NXUeh9Ky8OY1tzk4pnGBIRAsfVeCBB7zKGN07ykQxTlexhkCxqPcAFjjBH
         QiosM6gx5FYKreYlIqd63aCfLXY+oyfAr5l5Cp01pV8cOODoIpXBxVyDFn7WkNdw/RxD
         yyrlb2LjIxzLtVQMomDoVymzZO6F/hsoJ8G3yRRiQK1UKpmnMLPzbhkhFn8/S2xyci3r
         UDKwpGmf+TOhlDeSaeBRZhoX6EEU/4oT6ZlucJAwfqBJLnouGYNXaOwOyFVhl1HYZ+/B
         eEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716459874; x=1717064674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ogUGYLdwLjzH6+2WofnJ6KEdP2Qlj68VzxkGxDXY+wA=;
        b=LZVyhARobef0bYf0CRZwt33PopMkawvBA3DGbonmkzxUN1zq0hKVAMRDPJDvWT0MOe
         umvBgF+9ypXaKJ5DfwXukJZtqkxdfKSfwCe3v5iUIGxtEs+G7xyWPgTascGn3w8HYQ00
         z4V7nLdlRbeF9SWeAU2byJkFT9Pig/bRn/5Fb8AWkcGihgSVkRhZRhhzfxkT8hr7azXI
         Qv+GYiREnFXuMQOkwUZYCVB6PtCFQOwHhnTMJsGmMsiHuNnYnp8NIITN4b5j1FfzJ5LH
         VdSCCw+pWo9flxBFPSbrtwl0OFUSAcGIAbJVIKMlYGum5vKmyNVUTbGKqHNpcwEGXAeF
         fDeA==
X-Forwarded-Encrypted: i=1; AJvYcCXolKYkZ9TF29Nvy8ZCMlycVHZ4Jj68j/iHRgHsFwyjDRa0XC0PCbbb0hbqSSFaflYaSDRvElivR34AE42gYcbIsNDwkxfwWMxMJvAH
X-Gm-Message-State: AOJu0YyemNHeQMbMzwES8dy9c1MmyvWU4SZ+DotkmaOERhk4lwWtzlTn
	zDcPKZ3oqX+axDg5YAwh/2xlCkA6r9eN8WF1Lz3cVpJsiV8ldnBMldggn8QMzR4=
X-Google-Smtp-Source: AGHT+IHN3kvQkjReCp/g8HSroGvDlo5ZbuhiSLYW/HKESy0FSoypqb6FdnEpxMPaUktG/XwDHK4vZQ==
X-Received: by 2002:a50:d715:0:b0:578:3096:ef5a with SMTP id 4fb4d7f45d1cf-57832a1de5bmr3369225a12.22.1716459874110;
        Thu, 23 May 2024 03:24:34 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7315:e681:bab5:4646:cf21? ([2a10:bac0:b000:7315:e681:bab5:4646:cf21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bebb73esm19846205a12.31.2024.05.23.03.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 03:24:33 -0700 (PDT)
Message-ID: <3eadcc8c-d302-4a70-a16f-604285c1257d@suse.com>
Date: Thu, 23 May 2024 13:24:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-35876: x86/mce: Make sure to grab mce_sysfs_mutex in
 set_bank()
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2024051943-CVE-2024-35876-d9b5@gregkh>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <2024051943-CVE-2024-35876-d9b5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19.05.24 г. 11:34 ч., Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()
> 
> Modifying a MCA bank's MCA_CTL bits which control which error types to
> be reported is done over
> 
>    /sys/devices/system/machinecheck/
>    ├── machinecheck0
>    │   ├── bank0
>    │   ├── bank1
>    │   ├── bank10
>    │   ├── bank11
>    ...
> 
> sysfs nodes by writing the new bit mask of events to enable.
> 
> When the write is accepted, the kernel deletes all current timers and
> reinits all banks.
> 
> Doing that in parallel can lead to initializing a timer which is already
> armed and in the timer wheel, i.e., in use already:
> 
>    ODEBUG: init active (active state 0) object: ffff888063a28000 object
>    type: timer_list hint: mce_timer_fn+0x0/0x240 arch/x86/kernel/cpu/mce/core.c:2642
>    WARNING: CPU: 0 PID: 8120 at lib/debugobjects.c:514
>    debug_print_object+0x1a0/0x2a0 lib/debugobjects.c:514
> 
> Fix that by grabbing the sysfs mutex as the rest of the MCA sysfs code
> does.
> 
> Reported by: Yue Sun <samsun1006219@gmail.com>
> Reported by: xingwei lee <xrivendell7@gmail.com>
> 
> The Linux kernel CVE team has assigned CVE-2024-35876 to this issue.


I'd like to dispute the CVE for this issue. Those sysfs entries are 
owned by root and can only be written by it. There are innumerable ways 
in which root can corrupt/crash the state of the machine and I don't see 
why this is anything special.


> 
> 
> Affected and fixed versions
> ===========================
> 
> 	Fixed in 5.4.274 with commit 976b1b2680fb
> 	Fixed in 5.10.215 with commit f5e65b782f3e
> 	Fixed in 5.15.154 with commit f860595512ff
> 	Fixed in 6.1.85 with commit 20a915154ccb
> 	Fixed in 6.6.26 with commit 5a02df3e9247
> 	Fixed in 6.8.5 with commit 32223b0b60d5
> 	Fixed in 6.9 with commit 3ddf944b32f8
> 
> Please see https://www.kernel.org for a full list of currently supported
> kernel versions by the kernel community.
> 
> Unaffected versions might change over time as fixes are backported to
> older supported kernel versions.  The official CVE entry at
> 	https://cve.org/CVERecord/?id=CVE-2024-35876
> will be updated if fixes are backported, please check that for the most
> up to date information about this issue.
> 
> 
> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	arch/x86/kernel/cpu/mce/core.c
> 
> 
> Mitigation
> ==========
> 
> The Linux kernel CVE team recommends that you update to the latest
> stable kernel version for this, and many other bugfixes.  Individual
> changes are never tested alone, but rather are part of a larger kernel
> release.  Cherry-picking individual commits is not recommended or
> supported by the Linux kernel community at all.  If however, updating to
> the latest release is impossible, the individual changes to resolve this
> issue can be found at these commits:
> 	https://git.kernel.org/stable/c/976b1b2680fb4c01aaf05a0623288d87619a6c93
> 	https://git.kernel.org/stable/c/f5e65b782f3e07324b9a8fa3cdaee422f057c758
> 	https://git.kernel.org/stable/c/f860595512ff5c05a29fa4d64169c3fd1186b8cf
> 	https://git.kernel.org/stable/c/20a915154ccb88da08986ab6c9fc4c1cf6259de2
> 	https://git.kernel.org/stable/c/5a02df3e92470efd589712925b5c722e730276a0
> 	https://git.kernel.org/stable/c/32223b0b60d53f49567fc501f91ca076ae96be6b
> 	https://git.kernel.org/stable/c/3ddf944b32f88741c303f0b21459dbb3872b8bc5

