Return-Path: <linux-kernel+bounces-194499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BF48D3D31
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4FC1C22E43
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D1D180A80;
	Wed, 29 May 2024 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+iK0dTr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98315B566
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002460; cv=none; b=dJ714lCNjRjWpUCRcJWGMFGzv/nIC9xTwYj4HV3P72F3ULsoh+JiCqsofH/gX2RjcUy1bbQ0JGWtcM6n2806TaTRgoOMZy53KyitTqkfc5N+WS0oY+4NwYI1+HH/mAihwueKHYUiVCFb5gUJSV+t8kGuck3HzAxGCv3fNarP3hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002460; c=relaxed/simple;
	bh=FR8yYe75HWYrYeY/1bStScRCW8IABhMCe4gz0rDrl+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txiFQpqsYCg++AXYx7x8bNiSveZuhyiJjLbOJyLBuYJ3aGfv0lDq6+WtTaMILWFcWufXMEhKNF3YZbckrRavMZmqSMrTuKahw5w2ec9dskPMOtpBMX6oIXrRyedYJpeWeq43tqfj9MvKAw0zzs1l8c7Q0SWbTvXCvNmfvHqXonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+iK0dTr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717002458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcsPFJDOY4WvNKS218Ds2wH8/diG1/Nx2QoDq1sbdEw=;
	b=A+iK0dTrOQOWiggOETKclp5lIRcZr3VN892a10uDt/f0UXvRLi93cD2/qSKkaqpklZdPeI
	mRqZqGuL8JF3mc5q0lq+L9wbQF4+Tpbd9COdt/UuqS+U5pTPVbr2lzLlE0bweg+YNE0hlm
	Xpf6ziJ77TB2Oj4gyhL2FdveXdie8wc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-r_CfUJi4PsO0_0GROSwjqw-1; Wed, 29 May 2024 13:07:35 -0400
X-MC-Unique: r_CfUJi4PsO0_0GROSwjqw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-794aaf57a38so1216085a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717002455; x=1717607255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcsPFJDOY4WvNKS218Ds2wH8/diG1/Nx2QoDq1sbdEw=;
        b=MRAJCeJW0K4jqVy1uieZbuCukUorXcbRu+pfVIkKmYH3Yp7wb5SgU+iD4uyASPMhKd
         EnD6CHUXtZGnmfqqKrVVVPgJyVsu90CG4JzUuTyPXO7OftKUbDYtxDu9n4JUsvriQ4v6
         FFlUopAXukHvd5ufD/OxipXjPxXenj1YwLKdCroWCTi77rkUWnOY+WGNrYRuob9X4Ga/
         e5xFnzebFfd7vE7Kiu62AU+ShaVxaXVB/5Sk7sLF2Oi7/4BnQraHT5/aSBUJ3bn1VAse
         Niq6z+IO+h9glLdGW7i9aLmoud1lStkzNMDY6y2tQkOUDDfHsCIqVUvslEbGerVWdRfK
         eqJg==
X-Forwarded-Encrypted: i=1; AJvYcCUMO/up3nAhZFlvge4j0bgbO0CwBKdpuE0zr9h7yObAMzScxS08TLVwHNQoW7Az6nvkqdUGJK92v2ef3AZS311qDqrCLdjwDIcAxYgc
X-Gm-Message-State: AOJu0YxpKJu6IkyJio2THcC1hoow5fktRy51WM94yvYM9E1IP2HlE6Mb
	43GM17VXIN2osjT5+GCzpI9Aro1CafBj6gOC79rx9WZx6ePsHEk74smcikY/+IPLlMiUyScU3AA
	i7KuDecxDRn+iiJozwNSVLOKzyEiRYQmB0j23x3zi53fBBxLkOC/5oDRWHM9oUQ==
X-Received: by 2002:a05:620a:5dcb:b0:792:c524:c67a with SMTP id af79cd13be357-794ab053910mr1638680285a.2.1717002455157;
        Wed, 29 May 2024 10:07:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKjn8rn4gwlhs28dVyWvkBZLPmaJ15NOY/2o2GdYFzO6vL1OT/ySs4/cIF7RhqxM0QEP1QGQ==
X-Received: by 2002:a05:620a:5dcb:b0:792:c524:c67a with SMTP id af79cd13be357-794ab053910mr1638675385a.2.1717002454607;
        Wed, 29 May 2024 10:07:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794db33d9f8sm107027885a.134.2024.05.29.10.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 10:07:34 -0700 (PDT)
Message-ID: <535bc49d-1b8c-4dae-8ee1-1b7815473524@redhat.com>
Date: Wed, 29 May 2024 19:07:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] KVM: selftests: arm64: Test writes to CTR_EL0
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
References: <20240514072252.5657-1-sebott@redhat.com>
 <20240514072252.5657-7-sebott@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240514072252.5657-7-sebott@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/14/24 09:22, Sebastian Ott wrote:
> Test that CTR_EL0 is modifiable from userspace, that changes are
> visible to guests, and that they are preserved across a vCPU reset.
> 
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


> ---
>  .../testing/selftests/kvm/aarch64/set_id_regs.c  | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/set_id_regs.c b/tools/testing/selftests/kvm/aarch64/set_id_regs.c
> index a7de39fa2a0a..9583c04f1228 100644
> --- a/tools/testing/selftests/kvm/aarch64/set_id_regs.c
> +++ b/tools/testing/selftests/kvm/aarch64/set_id_regs.c
> @@ -219,6 +219,7 @@ static void guest_code(void)
>  	GUEST_REG_SYNC(SYS_ID_AA64MMFR1_EL1);
>  	GUEST_REG_SYNC(SYS_ID_AA64MMFR2_EL1);
>  	GUEST_REG_SYNC(SYS_ID_AA64ZFR0_EL1);
> +	GUEST_REG_SYNC(SYS_CTR_EL0);
>  
>  	GUEST_DONE();
>  }
> @@ -490,11 +491,25 @@ static void test_clidr(struct kvm_vcpu *vcpu)
>  	test_reg_vals[encoding_to_range_idx(SYS_CLIDR_EL1)] = clidr;
>  }
>  
> +static void test_ctr(struct kvm_vcpu *vcpu)
> +{
> +	u64 ctr;
> +
> +	vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_CTR_EL0), &ctr);
> +	ctr &= ~CTR_EL0_DIC_MASK;
> +	if (ctr & CTR_EL0_IminLine_MASK)
> +		ctr--;
> +
> +	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_CTR_EL0), ctr);
> +	test_reg_vals[encoding_to_range_idx(SYS_CTR_EL0)] = ctr;
> +}
> +
>  static void test_vcpu_ftr_id_regs(struct kvm_vcpu *vcpu)
>  {
>  	u64 val;
>  
>  	test_clidr(vcpu);
> +	test_ctr(vcpu);
>  
>  	vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_MPIDR_EL1), &val);
>  	val++;
> @@ -525,6 +540,7 @@ static void test_reset_preserves_id_regs(struct kvm_vcpu *vcpu)
>  		test_assert_id_reg_unchanged(vcpu, test_regs[i].reg);
>  
>  	test_assert_id_reg_unchanged(vcpu, SYS_CLIDR_EL1);
> +	test_assert_id_reg_unchanged(vcpu, SYS_CTR_EL0);
>  
>  	ksft_test_result_pass("%s\n", __func__);
>  }


