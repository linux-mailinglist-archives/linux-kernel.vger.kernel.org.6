Return-Path: <linux-kernel+bounces-429656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A69E1FE2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60256B37456
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E271F4707;
	Tue,  3 Dec 2024 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N6WUcbOn"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B0136338
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236214; cv=none; b=RQfk/ABe0kgfZrVEZpJvokdG+jYey6MgHa6MZKaG1KH1+Z7QDKtXVb/tUonYOA+s8p9UreW4TjtsXRU6u4WXA7tvt4/qijltu1JduAQWribFwzpctiD7Qk6B/Jzedrmu9ofiMi4S73V4X8puZ2PhsstMZ7uB4fVi/H7wZeYqcA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236214; c=relaxed/simple;
	bh=rGhFjgaT9iY5cA8iRW+qva8sE0JbDy3heY2HVbFcvFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HP3MCztW3W3T7ba3lSRumub7kOPOgJaUIRnp6TRBFZsLb7wv4TBu7NO3nvDPN1MXMX/9xO08AP2IQgjc4DpwSG7U5BBF3GUiO+UZ77zi7etay8P/Rp5ylL2HGHY8A46nVcbSj/leyH2v79Za7LIu8ZbwqsbuRPUIuitfhAfJURI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N6WUcbOn; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385ef8b64b3so2049389f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733236211; x=1733841011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jH1wDfSwrqnpiRpVRmWuhaDo0LUKD1u9ndEwybYSX/8=;
        b=N6WUcbOn5zHRa6tsa76uEdDK/KdbyBVnOWS4UeHyn6ibnL4kUpA0OpIKwJrQeufJIc
         XWmcl+P+rlfDeW0ZMOkCrqDARKQdn6jiVLDF8g4H3TItl4KInusqs3NsoeaGfXGFkeG/
         XLVa+B7WYDeKxyHHWFlshxTXM602kn5//mePnbzeq3QuqcNc39wuGtZw90+OQY6QFin1
         B+ttXNy8cnA5T7+Gf1VkYnTG3QOqnzQjA0l31evU/0cP1OSm5krI3H6m1bUzlIqmTUj2
         Da/i7fk2b864wVQbSnq4y06yUzboGG5+dTL9SDy5XGK/Fv9/+CFubOFBX1+rAHs3+rKN
         EUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236211; x=1733841011;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jH1wDfSwrqnpiRpVRmWuhaDo0LUKD1u9ndEwybYSX/8=;
        b=UcShEKwgR/5F4P1Ayq9zJrZ2/t7VOpppw2/yAmqRPn2W5jOvmb0f7W4QOex2vcAc3P
         OpmaMacmydyk3v0uEAchW3bFcBAiU4QEg101lKXu9OhFB9J4CeIBjdQ+b67q8lWYNVJ4
         mmk9pxtH1cVFemoVGft87GOY9GQYTsFbclI+KYx4nSGKmRxz3WTbaFOGNiIQva4/+oW6
         zsOZdPEPXD/PLturdCmyGIkOor7ucXVRVGfnbwU8BY9+r/MLyaCTnxvvcpJESxS2gpV0
         taFCljRAzElLE4FoER955wfeuIi1WHJdk909/Q9nvijIcaVSOYoaqGdb9BrF0ZZtV2OD
         HCCg==
X-Forwarded-Encrypted: i=1; AJvYcCXczwAW3pO8cI/ict/8UH9ATsP83PkSOwbjdMndfW3Xt74+Be4HuEGgcV1XobwbtXIkQLF5MDSlyc/nR8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMmSDg/rEiFkgpJUC1eRiY8YLqmBvzBrRVYL/YzpCYrUT2BpAK
	m/8aJ32z7agzB1iSVdJxbp6/H+XLZVJ/8SPJXaKm847hoH/7aiZOrtxTqMIduE4=
X-Gm-Gg: ASbGncvqEyBnzQ33ttta9n0KT43NdX/dNuWGkpQqsjf7kuCPth3IIh8tTwaoic70Pgt
	fmE4z99T41vSZchnY8uDe/nwaN/BkjmaygVbEV6LWWKnxkI68BV6amvh3U0tZ9UGloTI48bf9ti
	ddNeDXvBIEXZTNV9Als5PjpKK/IkrERIvyWhpYEgWa2axRS+bygiGVERTeGG+n7mPIGZkCzSOtz
	MuUdCG2olD8RncFHATR8Xmdi0bOWzW/XksFDbpLh5YWPKoq3m7QQLmZ+qd7QMfWpQoLMZgyaWU=
X-Google-Smtp-Source: AGHT+IENAyfwuNFf6REPxs6hH3ur11j36rdkKcaMOs2F9u8bNyL6Z8dBI2oVPX4waJYwrvr2phFspQ==
X-Received: by 2002:a5d:6485:0:b0:382:d7a:315b with SMTP id ffacd0b85a97d-385fd3c699amr2274561f8f.11.1733236211089;
        Tue, 03 Dec 2024 06:30:11 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e940fef3sm9325106f8f.42.2024.12.03.06.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 06:30:10 -0800 (PST)
Message-ID: <be306052-4f7b-4964-9169-8faa5ee7bb55@suse.com>
Date: Tue, 3 Dec 2024 16:30:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] x86/bugs: Adjust SRSO mitigation to new features
To: Borislav Petkov <bp@kernel.org>, Sean Christopherson <seanjc@google.com>,
 X86 ML <x86@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Josh Poimboeuf
 <jpoimboe@redhat.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 KVM <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>
References: <20241202120416.6054-1-bp@kernel.org>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20241202120416.6054-1-bp@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2.12.24 г. 14:04 ч., Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Hi,
> 
> here's the next revision, with hopefully all review feedback addressed.
> 
> Changelog:
> v1:
> 
> https://lore.kernel.org/r/20241104101543.31885-1-bp@kernel.org

The series is pretty self-explanatory. So:

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

> 
> Thx.
> 
> Borislav Petkov (AMD) (4):
>    x86/bugs: Add SRSO_USER_KERNEL_NO support
>    KVM: x86: Advertise SRSO_USER_KERNEL_NO to userspace
>    x86/bugs: KVM: Add support for SRSO_MSR_FIX
>    Documentation/kernel-parameters: Fix a typo in kvm.enable_virt_at_load
>      text
> 
>   Documentation/admin-guide/hw-vuln/srso.rst      | 10 ++++++++++
>   Documentation/admin-guide/kernel-parameters.txt |  2 +-
>   arch/x86/include/asm/cpufeatures.h              |  2 ++
>   arch/x86/include/asm/msr-index.h                |  1 +
>   arch/x86/kernel/cpu/bugs.c                      | 16 +++++++++++++++-
>   arch/x86/kernel/cpu/common.c                    |  1 +
>   arch/x86/kvm/cpuid.c                            |  2 +-
>   arch/x86/kvm/svm/svm.c                          |  6 ++++++
>   arch/x86/lib/msr.c                              |  2 ++
>   9 files changed, 39 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37


