Return-Path: <linux-kernel+bounces-305749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DC49633C7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A46F1F21428
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB581AD3FD;
	Wed, 28 Aug 2024 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBD3SG4v"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B61AC433
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880244; cv=none; b=hZMpQDYFaMu7MfbGxxXmtzshGIdJSfq7Cs+5E+ZBx5KSj/+eYXrUKWSEydRRZ58I9c9ig8KUXyqhdanBxxg+dSF5KJBf0uG7tUosr2w6I2saM5JiMLJnNyuGRs5p2CLqv39HCUCMX2IchkwcCjg2y0/qZfYwMTngbkiFHLMuD9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880244; c=relaxed/simple;
	bh=VOkjTFoLXtGv0TViaHfsU+gppTJDsqZWATy+QAtbgww=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=P9WdPlxzVv+Yh7lr+PkcD5iW0bQK37zl7fqYHiJtIL9CNg3KW0yGI0rR+094VOY0IGwpDBmasgrsQhMp3vFiHlZ1HdzmZPAvHRiRhFfaeoNIfiwsT1ZCXSb0hDSIsK7j9jkaTLq8DKUlB+lXIOmuUFbKwhnR1X7DdTez72h/gIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZBD3SG4v; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-27040466ac4so797762fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724880241; x=1725485041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qZf5vS6nzeffxNNxcAI3Z4UnlXSlArXBSTkbZeQVRKE=;
        b=ZBD3SG4vwGor5kTHUJDTK38i5m2Gw1R+hG/K4bLTbBl/0U5YhhNiEtmD4Bhvv00Phc
         FSprKuFmci6OxbMeEfMOc3F0m+Qn7txlQ47Np6Q6FxFj/k/oxqpL8mNb5JK++wWZ1OMN
         oDcRfh32mZbD55rHoljMOym8vrrSv4MwIYYvH5SkzgjeGSWOR2W7nCQ+ZLgJUgEaJjYl
         JK0XQmipFzi6ED3GL0eYdVh7PI5FDHhd6mYrK3emJKSnHaITxsz4PRC+vuYVGY9VZGk0
         TR6C8e1Rq0lTgZdQVnTYtvd7gtCbIgq1uSdtwCvN5woPqxFNaSrrc/bP0Ytuqnp67M8R
         ld5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724880241; x=1725485041;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZf5vS6nzeffxNNxcAI3Z4UnlXSlArXBSTkbZeQVRKE=;
        b=BRwQpOh/s/2mfnESEQooUfrvSgA52fqiMcJfyzzGtk/koohiubH7Anlm6TZilJMOQz
         eYl5MpIAXgSD2+FJJMOi9L1WHUDvoKPYXRkpGOaM/KAAqBh4kRD1GMiGDz8erDKggVkZ
         FkvZzq1LTv+3xq7Xw9wR9SOItvXUZHQbeLwPBvSeJYzi167uLjQBT9IOLNiBPMJ4XFvZ
         WR1/X/5Pg5TtJFT5Mv6ZFHskV9cUiR5SzN748MmRzddLPT8Xpl4WqJ6+N1j1H++FSQaJ
         7JBRMHb0NcbBy5ppdOYwYsLWg9TtMXvY+uKD/XOtBELstJYHDoMaTyTeIb1Acr12eS01
         qmWA==
X-Forwarded-Encrypted: i=1; AJvYcCWz7/arY4G/9QR2ZUJiKezavzUr1zL78HNKNEeoNk4PTQ2wbdTV6yTV/o0DNlfuZxrjaTFUu2/GkF1IaT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3+gdHcubxWOVNvm6dBh/FzWOHcH+nwoySB8gz5RSK3R1L9gkb
	oAlfBSbSr6d6+EPEg6MYR+9MPHSA+ge/H0dPL6dnILtG4dxbWyosoAjJn8eBeMLjVZwkbAWvXTf
	KVDnQUiS/3XZtcSKj6sLu1w==
X-Google-Smtp-Source: AGHT+IHJilOsVOjcj476mr7NemZ02Wkts0F0ld7Ilool75wpEvDcZGSEQFGQLGm7UpH7JX3upxceg/2c0Occ46jKZg==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6871:e289:b0:270:1b61:48d9 with
 SMTP id 586e51a60fabf-277934e6bb7mr780fac.4.1724880241218; Wed, 28 Aug 2024
 14:24:01 -0700 (PDT)
Date: Wed, 28 Aug 2024 21:24:00 +0000
In-Reply-To: <ZsYwF5QJ8gqto8Mm@google.com> (message from Mingwei Zhang on Wed,
 21 Aug 2024 18:21:11 +0000)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntmskw9w9b.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 1/6] KVM: x86: selftests: Fix typos in macro variable use
From: Colton Lewis <coltonlewis@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: kvm@vger.kernel.org, ljr.kernel@gmail.com, jmattson@google.com, 
	aaronlewis@google.com, seanjc@google.com, pbonzini@redhat.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Mingwei Zhang <mizhang@google.com> writes:

> On Tue, Aug 13, 2024, Colton Lewis wrote:
>> Without the leading underscore, these variables are referencing a
>> variable in the calling scope. It only worked before by accident
>> because all calling scopes had a variable with the right name.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>

> This might need a fixes tag, right?
> Fixes: cd34fd8c758e ("KVM: selftests: Test PMC virtualization with forced  
> emulation")

> no need to cc stable tree though, since this is very minor.

> Reviewed-by: Mingwei Zhang <mizhang@google.com>

Yes it does. Thanks for the catch.

>> ---
>>   tools/testing/selftests/kvm/x86_64/pmu_counters_test.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)

>> diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c  
>> b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
>> index 698cb36989db..0e305e43a93b 100644
>> --- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
>> +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
>> @@ -174,7 +174,7 @@ do {										\

>>   #define GUEST_TEST_EVENT(_idx, _event, _pmc, _pmc_msr, _ctrl_msr,  
>> _value, FEP)	\
>>   do {										\
>> -	wrmsr(pmc_msr, 0);							\
>> +	wrmsr(_pmc_msr, 0);							\
>>   										\
>>   	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))				\
>>   		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflushopt .", FEP);	\
>> @@ -331,9 +331,9 @@ __GUEST_ASSERT(expect_gp ? vector ==  
>> GP_VECTOR : !vector,			\
>>   	       expect_gp ? "#GP" : "no fault", msr, vector)			\

>>   #define GUEST_ASSERT_PMC_VALUE(insn, msr, val, expected)			\
>> -	__GUEST_ASSERT(val == expected_val,					\
>> +	__GUEST_ASSERT(val == expected,					\
>>   		       "Expected " #insn "(0x%x) to yield 0x%lx, got 0x%lx",	\
>> -		       msr, expected_val, val);
>> +		       msr, expected, val);

>>   static void guest_test_rdpmc(uint32_t rdpmc_idx, bool expect_success,
>>   			     uint64_t expected_val)
>> --
>> 2.46.0.76.ge559c4bf1a-goog


