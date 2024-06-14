Return-Path: <linux-kernel+bounces-215149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 998E5908EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF096B262FF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7914B15A861;
	Fri, 14 Jun 2024 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYYlrVwf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C6E3B1AB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379106; cv=none; b=ApTFsyk5TaRRN/NeBkXoBHhFhow1uvnbBET74NBtgj+xQdOxW8qNnKWwWcg+n9j4c+xlY5Ab7ykVy4KFE9bIZu+Q302qVAjJXLu3NkrpMKYGUXav3QAVYS9fOVaEdn05IvtOeqiqqlxmhh7lahmi3qPf/Ha2bpKuqXVkF72or5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379106; c=relaxed/simple;
	bh=hSgZmiAS+svIYqQDF8KSPSvHB4W5pXbLYGkhdqqsXJI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ja4XhDgRYUhiLCk73AiImaXJTBhd6ZTy4Nx+H0ROPqzanMoNUqsLqMtSck6HIxugKSBUvVAXliBja/joDiHrb5PzMX1GMsQ6g1Fenv7eS4f7cH+kEhWZ5oeI5HxJh8y5iYt7fpLHKSqfBIhEvKA2XvG1+PJt4VI3T3t+jM+KQdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iYYlrVwf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718379104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zw5mxcQ5wldSbOobj9exImYqdyspUnQRuccECHVHSQU=;
	b=iYYlrVwf/7E5dJjkqlXEtw9gsO5bQTMVLz2AeeW3hAMXxBXb6PVc/VtXX7+0ncKC2mqFrz
	qmQeEw5btpqu2wPWR/RkxP3DO2KE7ah/4SNSRe5hr0RxI1Iu3kGSLxLsbRPWGM1SjjullP
	4YQapzzjpXGx4HzbGK4Ui5mOicecftU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-tO7Apc_BMVGoh2lYSJ1nTQ-1; Fri, 14 Jun 2024 11:31:42 -0400
X-MC-Unique: tO7Apc_BMVGoh2lYSJ1nTQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35f27bfa618so1247091f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718379101; x=1718983901;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zw5mxcQ5wldSbOobj9exImYqdyspUnQRuccECHVHSQU=;
        b=CzQdjFs07IOdTEyDQRl+D1eAMPsZiBrxgvmR8syKJ7/ObPsEpN/AHyPrxDtODoIkF0
         BEH6W1GAglze/LsH85VX40MPBzjjMMpGf3UC4qp5NKDd28xbL+OE/w4QiP1XUWe2OfiB
         tSPe8jSPEYmDX2UsCsK0fWc8ApvF/XK8jMYF2UTkQaTPfT1C5pxS13dArPJ4FUkUPK3G
         ERw3TyiJ4fUpaACuG63DEr8ZDXRgbMHL1WKiJ0YphkCT59YKd5bX9Bnbqdu//R9/vxLJ
         wEwfKiyLJ9QAR34Rs6XzQc0Vdiq0yQB0xhiaIrvcTef0mdAK7byQWlzMiPlKBmVFBbOp
         Hs7g==
X-Forwarded-Encrypted: i=1; AJvYcCVZumbpz6C8sx43PKvK+OsovozHMHouTrSZco6JDAx8pqR02UPzYKolrH4K4EQDUW7CTY8ICssma9cc4HlC/Glfr9u5z9svDhUhPUfb
X-Gm-Message-State: AOJu0Yy9kchn9x0N3CpPhZekS0GHTkUF/mvKRBLDRYg6+eaqpJ1H/OtY
	dFkxCW+NgqIp5KF6cSJg4mCdEeIoa5Lh5VaMSqcn6hxNjZ+9zQPk7IABda1cDu7UKoNfY+jeBUD
	OItEONtZdkC58/oDuYCNp5svUF1aIJwRLpjtFjCIM/Brka1Qr7BpKfdG0h1xmag==
X-Received: by 2002:a5d:6306:0:b0:35f:f58:38fc with SMTP id ffacd0b85a97d-3607a764d63mr1976969f8f.26.1718379100948;
        Fri, 14 Jun 2024 08:31:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFysnn8yQfXYEELPiEMpb7qalQGUfkEF5dvkN1fWbdzkeZrNdNu860UPxNqrvm/1llrzek+jg==
X-Received: by 2002:a5d:6306:0:b0:35f:f58:38fc with SMTP id ffacd0b85a97d-3607a764d63mr1976956f8f.26.1718379100569;
        Fri, 14 Jun 2024 08:31:40 -0700 (PDT)
Received: from rh (p200300c93f02d1004c157eb0f018dd01.dip0.t-ipconnect.de. [2003:c9:3f02:d100:4c15:7eb0:f018:dd01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c8fbsm4690652f8f.43.2024.06.14.08.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 08:31:40 -0700 (PDT)
Date: Fri, 14 Jun 2024 17:31:37 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>
cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>, 
    James Morse <james.morse@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 3/6] KVM: arm64: add emulation for CTR_EL0 register
In-Reply-To: <Zmty99X4hnYwtRS4@linux.dev>
Message-ID: <0b148e21-1714-f4f7-bc77-2a12b990572d@redhat.com>
References: <20240603130507.17597-1-sebott@redhat.com> <20240603130507.17597-4-sebott@redhat.com> <ZmtwjLbP283ra0Xq@linux.dev> <Zmty99X4hnYwtRS4@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Oliver,

On Thu, 13 Jun 2024, Oliver Upton wrote:
> On Thu, Jun 13, 2024 at 10:19:56PM +0000, Oliver Upton wrote:
>> On Mon, Jun 03, 2024 at 03:05:04PM +0200, Sebastian Ott wrote:
>>> +static int validate_cache_topology(struct kvm_vcpu *vcpu, u64 ctr_el0)
>>> +{
>>> +	const struct sys_reg_desc *clidr_el1;
>>> +	unsigned int i;
>>> +	int ret;
>>> +
>>> +	clidr_el1 = get_sys_reg_desc(SYS_CLIDR_EL1);
>>> +	if (!clidr_el1)
>>> +		return -ENOENT;
>>
>> This doesn't actually matter if we agree on dropping the cross-checking,
>> but if this lookup fails it is 100% a KVM bug. Returning ENOENT isn't
>> exactly right here, since it gives userspace the impression that the
>> sysreg index it tried to access does not exist.
>>
>> So in the future it'd be good to return EINVAL in places where the
>> kernel did something stupid, probably with a warning for good measure.

OK.

>>> +static int set_ctr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
>>> +		   u64 val)
>>> +{
>>> +	u64 ctr, writable_mask = rd->val;
>>> +	int ret = 0;
>>> +
>>> +	mutex_lock(&vcpu->kvm->arch.config_lock);
>>> +	ctr  = vcpu->kvm->arch.ctr_el0;
>>> +	if (val == ctr)
>>> +		goto out_unlock;
>>> +
>>> +	ret = -EBUSY;
>>> +	if (kvm_vm_has_ran_once(vcpu->kvm))
>>> +		goto out_unlock;
>>> +
>>> +	ret = -EINVAL;
>>> +	if ((ctr & ~writable_mask) != (val & ~writable_mask))
>>> +		goto out_unlock;
>>> +
>>> +	if (((ctr & CTR_EL0_DIC_MASK) < (val & CTR_EL0_DIC_MASK)) ||
>>> +	    ((ctr & CTR_EL0_IDC_MASK) < (val & CTR_EL0_IDC_MASK)) ||
>>> +	    ((ctr & CTR_EL0_DminLine_MASK) < (val & CTR_EL0_DminLine_MASK)) ||
>>> +	    ((ctr & CTR_EL0_IminLine_MASK) < (val & CTR_EL0_IminLine_MASK))) {
>>> +		goto out_unlock;
>>
>> I'd prefer if we addressed the issue w/ arm64_check_features() by making
>> CTR_EL0 behave like the other registers in the ID space instead of
>> open-coding these sorts of checks.
>>
>> I believe that can be accomplished by using kvm_read_sanitised_id_reg()
>> as the ::reset() function in the descriptor and initializing
>> kvm->arch.ctr_el0 in kvm_reset_id_regs().
>
> Durr, I got rid of kvm_reset_id_regs() in commit 44cbe80b7616 ("KVM: arm64:
> Reset VM feature ID regs from kvm_reset_sys_regs()"), I should engage
> brain before responding.
>
> Adding a check for encoding == CTR_EL0 to is_vm_ftr_id_reg() seems to be
> the best way out.

Hm, but in that case we'd use reset_vm_ftr_id_reg() meaning we would have
to make IDREG() work for this reg. Either by adding special handling to
that macro or by increasing kvm->arch.id_regs[] a lot - both options don't
sound very appealing.

I'll think of smth to make arm64_check_features() work for this.

Thanks,
Sebastian


