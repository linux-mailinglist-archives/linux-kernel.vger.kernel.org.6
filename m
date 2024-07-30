Return-Path: <linux-kernel+bounces-266608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A32E9402EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 02:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD61FB2171C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF5A33D5;
	Tue, 30 Jul 2024 00:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MS062Onl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A048C17D2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722301183; cv=none; b=ttFXA4up/M1iWbZQpEQpwtFEizICOXuFa03zse0jg7sjvzCzDWhT7KOmmzluQpNuHXsXMUVNP36UAMbcqtzuvKl+4f57Ez2QIpfJ5+BpwhOgp6C9yNyHmcqBxlgt1IeMUkg2NOE/aAOloh7hFICYyOQO0QvCzZt4VPLpM2+cS+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722301183; c=relaxed/simple;
	bh=hCqS+gATuiSNsPHqmsj3ZpZ+hs+LXgdx1d7Z/zn+hyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rtkB0gRPflXBg+/T2GzXk07mxCL0bsRG4TUDpLXavVcnCXl9nWHDwIvpCS0vcPKR44F3I6yx7JkkIJR/UYh8tJEDujT47DHwUQeHyhWxjB+p6KDw49YiB5S+TbZgh1LpGz0iTASJPwICzBaTv6zkOM2t7vl1YYbOnK7UB3wf9gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MS062Onl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722301180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wlQLbFShtGMFNw4a9BwZ9YXN8ivenvafdtuakdDThQo=;
	b=MS062OnlohkXfa/fT8NhLQTDQlKgM516Sf5tJUNiu9fdloC++ZqGnwW+4D23A+avkxG1D5
	Bu2jAGXSfz1f0v85P7v55bBo13xNlCmGG8p1TKzcDWIkVk0PEpVP997UgoGNlukH8b/FzP
	LU7u44gGAzUAAWvFUrZgcPlkaG51o18=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-DSohAOdzPlCxozAb6_C9fA-1; Mon, 29 Jul 2024 20:59:38 -0400
X-MC-Unique: DSohAOdzPlCxozAb6_C9fA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-6e67742bee6so1768180a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 17:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722301178; x=1722905978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlQLbFShtGMFNw4a9BwZ9YXN8ivenvafdtuakdDThQo=;
        b=jqroOXUJRJoX7Nlc6KxBHlOhBDxR5Hg0SLQSAUsmh95dRGa9ARwIcm2WgaOo+GfaBD
         9liQVBcDA0eIZU/aRXHF7EaZxr+aLt6quzUrBRwQ6ZfRUxO399WH0e/uey2Nk4HjGcLC
         8CjPJ8kyv6uPi5WIjs6jwRabe3EQawjCMDIG2fSyaV6wna4+Efa3qY3RKlYSjNIrEZSH
         ZLuPfs4T6JHU7zF/OIls5N/rV5pF3yDhpxWY+kFDhar7YLEvYHD6mg6Lj1diTcVUweiC
         ygaQY2NucrzTajO2qszN3/TBVW4I4au8xuTOVqpbVEnaKBSdJJTfbeOe9u2Wp6DuIC9n
         J2OA==
X-Forwarded-Encrypted: i=1; AJvYcCW9a5OxTXIvjpvC2KpeFLXJAFDpP3gColDOaJKkvJWaCE7LpGMbT7ZM+vCYY+8ULLaMphqiIrsq0yQUVQSDRMqjB/xHaVf1vXdBRig+
X-Gm-Message-State: AOJu0YyMTmW+1ZaWI1bP4tDM4iFCKM/LEdTqLjDVJPL/PdjJnIU2VvLJ
	4ysDH2fSbGWi3OIrbiFQueDOCMctj3lJhSW6vglF7OXQLUNCtmR9in45V5nTaoSHpK/DaPgufUx
	qLD1/Lmne8FvR/Z748WvB3q0auI/T7fV9Vj/KzbDeGp73NDNoUXainyAUypz9Jg==
X-Received: by 2002:a05:6a20:9f8c:b0:1c0:e4d6:9c05 with SMTP id adf61e73a8af0-1c4a130df35mr8584749637.32.1722301177770;
        Mon, 29 Jul 2024 17:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5zoRfUcqcon+k8GME2L0SdMCToEh9aYEGehCVh/L5s1baauFlHQ6qI225tH+ayi+XLEyYDg==
X-Received: by 2002:a05:6a20:9f8c:b0:1c0:e4d6:9c05 with SMTP id adf61e73a8af0-1c4a130df35mr8584727637.32.1722301177165;
        Mon, 29 Jul 2024 17:59:37 -0700 (PDT)
Received: from [192.168.68.54] ([43.252.112.134])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f9fbd256sm6627844a12.58.2024.07.29.17.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 17:59:35 -0700 (PDT)
Message-ID: <280d48b0-d915-4130-8aa1-53395ef6d4ab@redhat.com>
Date: Tue, 30 Jul 2024 10:59:28 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/aperfmperf: Fix deadlock on cpu_hotplug_lock
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, rafael.j.wysocki@intel.com,
 catalin.marinas@arm.com, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, Terry.bowman@amd.com
Cc: linuxarm@huawei.com, guohanjun@huawei.com, miguel.luis@oracle.com,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 shameerali.kolothum.thodi@huawei.com
References: <20240729105504.2170-1-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240729105504.2170-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/24 8:55 PM, Jonathan Cameron wrote:
> The broken patch results in a call to init_freq_invariance_cppc() in a CPU
> hotplug handler in both the path for initially present CPUs and those
> hotplugged later.  That function includes a one time call to
> amd_set_max_freq_ratio() which in turn calls freq_invariance_enable() that
> has a static_branch_enable() which takes the cpu_hotlug_lock which is
> already held.
> 
> Avoid the deadlock by using static_branch_enable_cpuslocked() as the lock
> will always be already held.  The equivalent path on Intel does not
> already hold this lock, so take it around the call to
> freq_invariance_enable(), which results in it being held over the call to
> register_syscall_ops, which looks to be safe to do.
> 
> Fixes: c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to use same path for cold and hotplug")
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Closes: https://lore.kernel.org/all/CABXGCsPvqBfL5hQDOARwfqasLRJ_eNPBbCngZ257HOe=xbWDkA@mail.gmail.com/
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   arch/x86/kernel/cpu/aperfmperf.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


