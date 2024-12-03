Return-Path: <linux-kernel+bounces-429937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A56949E2C8C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92B2B2F047
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CD41FA82C;
	Tue,  3 Dec 2024 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DbKrH6nF"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643131F76AE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246921; cv=none; b=BpLrJQ/bK7vivMoTRkN7msMKlv14NcW7Ps9IrO/nG/ETmWtZYhQYvBRyExWptmQKqgG0YXvP4AekMnGEWqDfqr8lxQkKAH5Q4ahjlwVjDp54udmQwWVqLXCCEAQk724r5w5wj0g+vxLgKtcNKjGkK2ilDXgh4OsSsYgMO4XIqvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246921; c=relaxed/simple;
	bh=/gTNyCXQU03C39326vEnqkA1N6Vo2JlTmY89Tz79xhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUu9ukvJd7mwSESR4KV3NZABifWk+Qth06Ar2kXsh1Oqk62FiulGYIDN8y7KXgvg4v3hOoN+sw28M9iS1xWY8y0xpwYQyCEHg91YxE++9qmRdsPXKSnZbHRXn9wiZAwFzqnGR0TPCVHX4ZXZ+d7PZhXeNlGAUEH7CXXJMzYMVI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DbKrH6nF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385df8815fcso2844834f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 09:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733246918; x=1733851718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZBUj9SMqVIY6pqeS7vZcLy9CSGD7zkKQLE0TkTYaXo=;
        b=DbKrH6nFm0J3kTYpKYwDT4eAgUR8pF6b6wzWKb7lsBx+wpoo4ERu0sDrEfjeRqWXu5
         aCc9Y0+xXT0M7hAHobhyVQI8l9YbUPBKE1S+Wcly00KpBrmEc4ZZ4rsmWohRrzxRFXoX
         Fvk+T2vqdyi4ES02ApVa/KVSl4tvuCxLevUhUYMSbDgnyjZiaayJPqowiWTE3/77PBI4
         6zitNDV5sUI2KVD3i3K/StNCytcrZ/VjlCV43GGPs4MYsRcRCsfCPVbO9/T8+mGf6WvH
         D9sw6GAKNStn5zh9NrE/qbaQP7hi48X3/l8OfDpmNVk4Nv5RSFMRIbpvNzg34eHQP0pU
         jgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733246918; x=1733851718;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZBUj9SMqVIY6pqeS7vZcLy9CSGD7zkKQLE0TkTYaXo=;
        b=m5vH5v6ibS7j+gn0HbzTb2z1kDDjcsI89Z1jukK8TFOICxxpGKxW0JhAxWKgPW7Uni
         yGpOVOScL8QWfAzUsDpKO0Etd1zgle9pWZ6IaiydL69diaAgDYA9abUPUFF+DVEPcF1l
         tQbjup37QLAnLGgAAvu0jNwj13Yt9DRTeBDykOgSIzDmRxUOwShOqUyMWoG+qcBiDJhm
         CFkoFEwDA0CX0xC/bhBft08kJZXmkvf8d2y46m97vd3nzqXWhSTufYaSSnHv9qTp8jty
         L0f2AqQ0Fcd/aXQd2pBabpHxO3W8+yvUXFq66GPg2YYpKVkEwz4iVeKffNVyRSLBUiOS
         7fyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8w8yWH4GlU8LDx8yD3153LHMqUBFXCt9DNG/d+RGKTWFRNHguHFP3wYSaUrxe2tpjUiwu/9gDMjy9MBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCj121Zch6FqOSzrnies9m1/bWg79PjjJvEbSsfVCJYNpavyQk
	bcHR9u4kJqfxjxcFG31bL45MSk9IsiOoyiYKLZl9n5XttYvXRB0H1f3luyuwado=
X-Gm-Gg: ASbGncs68Z/Sx7Q7rXJg4e8VuqPYuvDm4FKt3PPZOk65xvgnyPEUK7ew9Qi1XBX6Tnb
	43jvMTG3v3geIVnNIH8y/qkJmcQhTv0zCew7sS2Y77akRnQDrUeYAeyFW3bFbyRfOMvNwTTEj3H
	UzGOcc9k9VbldYUFZ2PLzflwjyfas4ArhMB7z+yNw3+M7ie0g2TGJTrR6wpO2yHSp0VoyImcpyb
	oYp5YJsZkb5jaTBm0YptIaFEjYpwn4L586zeFWQC+Cf5vt3tSIZUZ7AeSEQoJ1J1KFB5m+8jvE=
X-Google-Smtp-Source: AGHT+IGPNn94J2dpQ5kh5lIK6FeDE5RanphaqK7PW7F/ltFApM1dfvj99MJkhyaY+6+eyweaw/QpUA==
X-Received: by 2002:a05:600c:5125:b0:430:563a:b20a with SMTP id 5b1f17b1804b1-434d09bf79fmr29233945e9.11.1733246917749;
        Tue, 03 Dec 2024 09:28:37 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7691b0sm227956775e9.17.2024.12.03.09.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 09:28:37 -0800 (PST)
Message-ID: <4c92909e-cb0f-4917-834c-3425284db808@suse.com>
Date: Tue, 3 Dec 2024 19:28:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tdx: Enable #VE reduction feature
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241202072431.447380-1-kirill.shutemov@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20241202072431.447380-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2.12.24 г. 9:24 ч., Kirill A. Shutemov wrote:
> Originally, #VE was defined as the TDX behavior in order to support
> paravirtualization of x86 features that can’t be virtualized by the TDX
> module. The intention is that if guest software wishes to use such a
> feature, it implements some logic to support this. This logic resides in
> the #VE exception handler it may work in cooperation with the host VMM.
> 
> Theoretically, the guest TD’s #VE handler was supposed to act as a "TDX
> enlightenment agent" inside the TD. However, in practice, the #VE
> handler is simplistic:
> 
>    - #VE on CPUID is handled by returning all-0 to the code which
>      executed CPUID. In many cases, an all-0 value is not the correct
>      value, and may cause improper operation.
> 
>    - #VE on RDMSR is handled by requesting the MSR value from the host
>      VMM. This is prone to security issues since the host VMM is
>      untrusted. It may also be functionally incorrect in case the
>      expected operation is to paravirtualize some CPU functionality.
> 
> Newer TDX module provides REDUCE_VE feature. When enabled, it
> drastically cuts cases when guests receives #VE on MSR and CPUID
> accesses. Behaviour of a specific MSR or CPUID leaf/sub-leaf is defined
> in the TDX spec.
> 
> Enable REDUCE_VE. It brings TDX guest behaviour less odd, bring it
> closer to an architectural.
> 
> Note that enabling of the feature doesn't eliminate need in #VE handler
> for CPUID and MSR accesses. Some MSRs still generate #VE (notably
> APIC-related) and kernel needs CPUID #VE handler to ask VMM for leafs in
> hypervisor range.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>


<snip>

