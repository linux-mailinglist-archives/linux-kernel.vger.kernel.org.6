Return-Path: <linux-kernel+bounces-187721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E52F8CD727
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF521C21B1A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4845611723;
	Thu, 23 May 2024 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYRobr3L"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E2318026
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478510; cv=none; b=RqhNYfoHQc9XzzMnQEFQYMfRuXMaLZ75VdAYVpluSjK0BqPJPHhG0fZRvswseYGTLQ6roFK6O4kJLFDfBHCVOFn5+o8CW5BDh1+b5msGZymJzQMkHcY94qWtsjsSzwA8ezBZ26u8WZ4vod7hm/hBb4lsMY3T/Q2zaGF0pcoicEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478510; c=relaxed/simple;
	bh=Epa6p0WiUcII668vol4NtXtNkWKG+qcknEpx6s86hxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnntmMAZ4lUggwBUYG6DJp7NWss8sPluFgDo5EXrmrDDTR+uAGmSBptu8A1Fe17k5lElaBWlVyClVSM7KEdadhSgUl3PZgiUR8qFJtWGPG2n6YYgTeEIQwRjlcZAt6E1KsoPmJp2ZZQMoBl99TQumKI+E/BxO3oMAUiywX7wLWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DYRobr3L; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e1fa1f1d9bso109725551fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716478507; x=1717083307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aOvQxFRbcxYkm/Tz05v9NM6rfH41Zt8Flh04Mv7Dqsc=;
        b=DYRobr3LvYvrndNzNS3kD3T59PeCAPDE5X65zSoNcb6yrLAPmy+GoIR2j4TJkOw2AL
         wd92q5+EuXXD2NdHWgOWvU6axHHE856Gzm75yU10I52zw/5KlxjK2ZtM8iLdMxePNAp9
         KGVHoZRxbokimmIyzj9alutSOcvvmr3eQNuXfEvG7Z9SVUihWJ3W9fs+y/GE9r0iEbWN
         YjumddemuQDu3FEpEwJxQmPWanHyPERtMNdEgnsBberAiWC4M9avaon/oyqZvgutwaY6
         VfuxoPYSlCRA73X7XV7Pbh6WYicnUHrQ9ASaqG4KqB+IuRd1/RXGEyDXqASIeKMSNuOt
         RN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716478507; x=1717083307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOvQxFRbcxYkm/Tz05v9NM6rfH41Zt8Flh04Mv7Dqsc=;
        b=RFMUK6YntqRVz6YVmbpaWxKHQZDLXyTEf2EollPaIle+KZc9bGC3bnVhkjRqDU0eO+
         2+p5Fn7ZWR9/Ajuh/leeYthyH8HT7r2rlXT6UkuBDYassv+rpa/zxhKZRDoAS1oR6tVk
         ctjKpVyXGq0Sak4vKL7EmkkV71ym1BNGXE2DBkv2uirmVjAEaVixWr+GuxDbItKOM++i
         VT7beXWdQnhD9NMws88vethW34G+M5pzj/Suiom1z3wsdSx34ZKz9Z44a0IJm0yorwqu
         QaEphuTPhhsrhvcAgf7UGEc32DLtsxAdmJJdsD12TB/ia8oWY1dUZWvN0mN8D2JZalxx
         NXhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJlP/yHf2bSi4JVw/riXLjuiXvcjgWaqkVxzzS97caGCCCtUbt0MGugp/jSBBngvzGdnelnjG8My0AQ0V52QMg3T1XG6oImLO+6z5V
X-Gm-Message-State: AOJu0YzX7PLXpjA0cxgdgCo52FsbxIe2OX51WGWjVvk5Hz1creXdXQQB
	N/ojvxK29dZYlzoqkzRFlzbbgAkbq6KsmJ0KWImGQlphQAby6PBv7zzfGZXnMMo=
X-Google-Smtp-Source: AGHT+IHyu7a5dgm+ZLm9NrbzpbVq+k55CrZv8rXn8T2Ikss68TYZof8GfyRY0kYs3jFpGkT8WMJcqA==
X-Received: by 2002:a2e:99c6:0:b0:2d8:5af9:90c5 with SMTP id 38308e7fff4ca-2e949540d10mr43991071fa.39.1716478507009;
        Thu, 23 May 2024 08:35:07 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f5d189sm28802185e9.24.2024.05.23.08.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:35:06 -0700 (PDT)
Date: Thu, 23 May 2024 18:35:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] selftests: kvm: fix shift of 32 bit unsigned int
 more than 32 bits
Message-ID: <da8581c8-3d56-454b-bddb-e523a983cb44@moroto.mountain>
References: <20240523113802.2195703-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523113802.2195703-1-colin.i.king@gmail.com>

On Thu, May 23, 2024 at 12:38:02PM +0100, Colin Ian King wrote:
> Currrentl a 32 bit 1u value is being shifted more than 32 bits causing
> overflow and incorrect checking of bits 32-63. Fix this by using the
> BIT_ULL macro for shifting bits.
> 
> Detected by cppcheck:
> sev_init2_tests.c:108:34: error: Shifting 32-bit value by 63 bits is
> undefined behaviour [shiftTooManyBits]
> 
> Fixes: dfc083a181ba ("selftests: kvm: add tests for KVM_SEV_INIT2")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/testing/selftests/kvm/x86_64/sev_init2_tests.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c b/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
> index 7a4a61be119b..ea09f7a06aa4 100644
> --- a/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
> +++ b/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
> @@ -105,11 +105,11 @@ void test_features(uint32_t vm_type, uint64_t supported_features)
>  	int i;
>  
>  	for (i = 0; i < 64; i++) {
> -		if (!(supported_features & (1u << i)))
> +		if (!(supported_features & BIT_ULL(i)))
>  			test_init2_invalid(vm_type,
>  				&(struct kvm_sev_init){ .vmsa_features = BIT_ULL(i) },
>  				"unknown feature");
> -		else if (KNOWN_FEATURES & (1u << i))
> +		else if (KNOWN_FEATURES & BIT_ULL(u))
                                                  ^
Should be i.  How does this build?  :P

regards,
dan carpenter


