Return-Path: <linux-kernel+bounces-281175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4CB94D3F4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEFC1C21006
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E23B198A21;
	Fri,  9 Aug 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u5zGJCwD"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090315B992
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723218538; cv=none; b=cNfZGtqM60E5e7SCBH35TJsaK/AWoljE0GGz2CEgXPH/ux3rvzuN6SGNm6HB8VyxpI/7OUZuIDw0zaW5/di6I/KjRkZsp7P120IXKqO8nKgwer70gEioAauN0TiG7DeigWMiCALzOB3KT16iQx7ePCKV7OUDqCYaK9KiK1F4cpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723218538; c=relaxed/simple;
	bh=boPHeK/FuzEsdNVjN9wdS1yaAPavvyaLNZ/AYT7mH0o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nXsJlZOZ7gyzhwMlqf77Ht52/dc7K8AbPr9L+aGBj1YFuVObKYgKZnoLJB9I5qGsRPiewtUIaQyeN6HfnQqbQ7Ipj9dsCH6s7UzdqT77dPo4ZM0qz6z7T0uHVOm/LJz30kORshIPSaP0M6NwzWw3Uq5hN8RKY6KakuJO6MsN4kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u5zGJCwD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-778702b9f8fso1540713a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723218536; x=1723823336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EKWC05ur8qJ9dixBuWa+E5r9HRoDV0qFqOeFXTmXV1c=;
        b=u5zGJCwDvT+FJj+8DAncoZY9zVb+UKMn86t7ShWWYqU1EgSkmYV1bYhcodtu08K1BD
         WD/Ho4maoXtCa1pmOZHT1TN7vyy/4XB3yg4EZzbDDLDuFerahrHtyYgI116CZeCcIJSV
         w04Usxo+fZiWPLz2TbmxNDx244ywpAyTZ7PyuWT6ym12fIPQHyPqEOkHi1due54fBerV
         OE3CYM8UnprkBT0v3MIDY4mfSdZoldcQLMlFcOGh/TdbDfrIfNwXibAqc8RwlDUwSqQr
         IBhNUX9m+Pw0EbUx/fA/qMI0B3/ysqH1fubO0l/IdZX0CKVLco2iWHANDIFkDjLegrsw
         X18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723218536; x=1723823336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EKWC05ur8qJ9dixBuWa+E5r9HRoDV0qFqOeFXTmXV1c=;
        b=hqJ/+B0m5GCi20DU3ucIh4b0KqWgbOz6xxQdCs5Z6/kTNUUJ42zr/Egez5xEVhm2pu
         AOw+R1SBM08s+XXn/GYPPsGLr0mUlEkeKEKjU54t/XDhKCVE7ypoRXujJXroH2hos8i4
         4FSnppCYPLPfC0Y5Mn2MgvOguFfDzqrvbd5JjHRQuFsdSeXrnmXnNawf2T6CKdC73iQi
         ir0wEYguo9EsQFwsunF6qUqgmcGTv+xPCYCAf0m1XqFKYSFg7ezfF3lMvcQM2LhPEG9P
         iqCa8feaRi2daeppno7etHXGxtTBDi9o8LbNSFXSgA0Cly9RH/ZT0faiFsEqwl/g7au5
         MaLA==
X-Forwarded-Encrypted: i=1; AJvYcCV3FTRaBXlI1ZY/1TUyciOfqdXWRxmhixa6HukPIjOQ5WHQAv7rqeFbAr6ErJ0pZedE0ox9upwhgI2xJPgkCRIeW8Qkqbu0cxOnQSdd
X-Gm-Message-State: AOJu0YyhoZzH5U+9/oIb+lrWi04qt9TxXwM6nPEqtJgtpy73HrYpo2wk
	wpnXLLQQh22P3M197Ja8UQGaFO3KDiQWBzGScAehDGAiaqZt+/WRtz0Pe+oQgztiUYHB/+wAItS
	QvA==
X-Google-Smtp-Source: AGHT+IGcUTh0RPjHcAl9Gl6mOs8y4fOTciJ0KSSIq9N9x9qDCHR+caHcNrvhuZvHbeuXJhBlCaUN/9h7Hoc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:410d:b0:7a0:b292:47cb with SMTP id
 41be03b00d2f7-7c3d2b997femr4904a12.0.1723218536385; Fri, 09 Aug 2024 08:48:56
 -0700 (PDT)
Date: Fri, 9 Aug 2024 08:48:55 -0700
In-Reply-To: <20240710220540.188239-5-pratikrajesh.sampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com> <20240710220540.188239-5-pratikrajesh.sampat@amd.com>
Message-ID: <ZrY6Z4mbbohVRbEh@google.com>
Subject: Re: [RFC 4/5] selftests: KVM: SNP IOCTL test
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, shuah@kernel.org, thomas.lendacky@amd.com, 
	michael.roth@amd.com, pbonzini@redhat.com, pgonda@google.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 10, 2024, Pratik R. Sampat wrote:
> Introduce testing of SNP ioctl calls. This patch includes both positive
> and negative tests of various parameters such as flags, page types and
> policies.
> 
> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
> ---
>  .../selftests/kvm/x86_64/sev_smoke_test.c     | 119 +++++++++++++++++-
>  1 file changed, 118 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> index 500c67b3793b..1d5c275c11b3 100644
> --- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> @@ -186,13 +186,130 @@ static void test_sev_launch(void *guest_code, uint32_t type, uint64_t policy)
>  	kvm_vm_free(vm);
>  }
>  
> +static int spawn_snp_launch_start(uint32_t type, uint64_t policy, uint8_t flags)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	int ret;
> +
> +	vm = vm_sev_create_with_one_vcpu(type, NULL, &vcpu);

Is a vCPU actually necessary/interesting?

> +	ret = snp_vm_launch(vm, policy, flags);
> +	kvm_vm_free(vm);
> +
> +	return ret;
> +}
> +
> +static void test_snp_launch_start(uint32_t type, uint64_t policy)
> +{
> +	uint8_t i;
> +	int ret;
> +
> +	ret = spawn_snp_launch_start(type, policy, 0);

s/spawn/__test, because "spawn" implies there's something living after this.

> +	TEST_ASSERT(!ret,
> +		    "KVM_SEV_SNP_LAUNCH_START should not fail, invalid flag.");

This should go away once vm_sev_ioctl() handles the assertion, but this assert
message is bad (there's no invalid flag).

> +
> +	for (i = 1; i < 8; i++) {
> +		ret = spawn_snp_launch_start(type, policy, BIT(i));
> +		TEST_ASSERT(ret && errno == EINVAL,
> +			    "KVM_SEV_SNP_LAUNCH_START should fail, invalid flag.");

Print the flag, type, and policy.  In general, please think about what information
would be helpful if this fails.

