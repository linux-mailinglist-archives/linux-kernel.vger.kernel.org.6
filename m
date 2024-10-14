Return-Path: <linux-kernel+bounces-364810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58B099D9B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E898B21A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09F7158D79;
	Mon, 14 Oct 2024 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtZ8UA56"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886C21411DE
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728944339; cv=none; b=hi8sXjOwYIJ4ykXECQcX5oz/zv00QbTeYWr0NhG+pGcGct1z62gC+cotNQ9Pmu/tE3MJHx1+nF5qz66FMuEFBUxW2zBzYzwGPRKpPR4+PH39CWGUaMZ6NBN0judJJ6vjZT6qoQljWxFkEruI8MGQNuAegYWdfJF5fU954rq1Ckw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728944339; c=relaxed/simple;
	bh=yB3I8uiuIfodLQQg70tjfVrEE4L5/9aX3fHruOdlsDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S7Qy5xlaJQ/VLupTaS6GNE4QQaehH5qmBkUb6skzBQE8lkC73pk0pPi9bgyL/uBkf/u3CVqZTIAKOvbfoXrBhmezikR/tiGWqGHfKDU97vUOSpsq4gNsfVU/m33RjSY25jIMlDwAQIaRBTbCnx4nn4QAZnE+t2eSAECLLoq6JPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jtZ8UA56; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e28b624bfcso67385737b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728944336; x=1729549136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TY1Bpkrr53yL83DAOoYM0CZgNHKv6sxwoJKshYPV+pQ=;
        b=jtZ8UA56LYCq1zl3D0FTWT/JxEWYjpCNRNA+vpxMPpbG/Xal10G60URayiLuVYbPYZ
         gOPj/Cn4vhMsSTsNiE233V7Q3lNAYcjFY/V3D4dVGrvpnYV5Q79779ZnoeWSpe37MdLV
         ZstXtTJH6A0hMQEeqp8UrzL2QH+0srJeBGt4QQzDM0xxrb9LlvXPbtD89dZsGpXx9KDt
         1TiBzJMPeAWiTw/w6uwriZFe1c2yrvjfDTErvPjvsDCVWql9Y34+KL9lfYfXQ7w1EGiL
         CcXwd5OklvQA3Qp2ewWIXpRbSNnxabNhPoengmllurLBz8/wNbNlxHFUA3IlZSJoRABs
         F2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728944336; x=1729549136;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TY1Bpkrr53yL83DAOoYM0CZgNHKv6sxwoJKshYPV+pQ=;
        b=RxnvOT4JrtyAWSbRCa6F8804qf/PAbO9s+myCP0pFgFJ6UgmEJKyRQevMVNYoSiIcC
         4qWVdv5l/6kdQ74yA7fdxTTVj60NzHT93BwPMX7XpnkNE613SR+WkD9dqKOU5ZRGa24Q
         AnpbJ+drXxQ8UrbJvFWFba08cF/w7aqMI3PKjjUMVVuhIeN2gwLOAocRsjpO6QoVd8/3
         G9prRVnR9b4YOWqdRA7mWsDCNCqzaTe9vOPql9pmtqKnuNDyfHD2hCkog31VGeke2kQY
         gEIVrXdGTJGIyZVxgHlbiF2oh8C9478njr6o4/iVvyppy8BmW28rORQ0IETJtCpj1i5M
         9eBg==
X-Forwarded-Encrypted: i=1; AJvYcCXuSHFf36lRn2wI2YQdO7x+tINW+5oRXbDB6QBeNiy/WxXkIicwSOynZQUBCIB6OVRd6U65nNb0qIj3Jzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrFmCX/rCyMLUheRcmBPTLh8k2odOFwThm6+dC2nK7tsUZ21jT
	fZ8+x+ChVeIaJaZsP87pByaXhTrmbSIXCaBhnbREo6NpusZ+ircAwqCvBktPARiz3mFgk3HA50t
	p2g==
X-Google-Smtp-Source: AGHT+IGmKxrngJUuCWLjHKOARMaUFTzc06SCFOqpWBfOT7Q1F3B7SJdXCtSJeIXIUx44V54dolQvTBOidIU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:c09:b0:6e2:6f2:efc with SMTP id
 00721157ae682-6e347c52d2emr3662017b3.5.1728944336631; Mon, 14 Oct 2024
 15:18:56 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:18:55 -0700
In-Reply-To: <20240905124107.6954-2-pratikrajesh.sampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com> <20240905124107.6954-2-pratikrajesh.sampat@amd.com>
Message-ID: <Zw2Yz3mOMYggOPKK@google.com>
Subject: Re: [PATCH v3 1/9] KVM: selftests: Decouple SEV ioctls from asserts
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, pgonda@google.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 05, 2024, Pratik R. Sampat wrote:
> +static inline int __sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
> +					   uint64_t hva, uint64_t size)
>  {
>  	struct kvm_sev_launch_update_data update_data = {
> -		.uaddr = (unsigned long)addr_gpa2hva(vm, gpa),
> +		.uaddr = hva,
>  		.len = size,
>  	};
>  
> -	vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
> +	return __vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_DATA, &update_data);
> +}
> +
> +static inline void sev_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
> +					  uint64_t hva, uint64_t size)
> +{
> +	int ret = __sev_launch_update_data(vm, gpa, hva, size);
> +
> +	TEST_ASSERT_VM_VCPU_IOCTL(!ret, KVM_SEV_LAUNCH_UPDATE_DATA, ret, vm);
>  }
>  
>  #endif /* SELFTEST_KVM_SEV_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> index e9535ee20b7f..125a72246e09 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> @@ -14,15 +14,16 @@
>   * and find the first range, but that's correct because the condition
>   * expression would cause us to quit the loop.
>   */
> -static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)
> +static int encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)

This is all kinds of wrong.  encrypt_region() should never fail.  And by allowing
it to fail, any unexpected failure becomes harder to debug.  It's also a lie,
because sev_register_encrypted_memory() isn't allowed to fail, and I would bet
that most readers would expect _that_ call to fail given the name.

The granularity is also poor, and the complete lack of idempotency is going to
be problematic.  E.g. only the first region is actually tested, and if someone
tries to do negative testing on multiple regions, sev_register_encrypted_memory()
will fail due to trying to re-encrypt a region.

__sev_vm_launch_update() has similar issues.  encrypt_region() is allowed to
fail, but its call to KVM_SEV_LAUNCH_UPDATE_VMSA is not.

And peeking ahead, passing an @assert parameter to __test_snp_launch_start() (or
any helper) is a non-starter.  Readers should not have to dive into a helper's
implementation to understand that this

  __test_snp_launch_start(type, policy, 0, true);

is a happy path and this

  ret = __test_snp_launch_start(type, policy, BIT(i), false);

is a sad path.

And re-creating the VM every time is absurdly wasteful.  While performance isn't
a priority for selftests, there's no reason to make everything as slow as possible.

Even just passing the page type to encrypt_region() is confusing.  When the test
is actually going to run the guest, applying ZERO and CPUID types to _all_ pages
is completely nonsensical.

In general, I think trying to reuse the happy path's infrastructure is going to
do more harm than good.  This is what I was trying to get at in my feedback for
the previous version.

For negative tests, I would honestly say development them "from scratch", i.e.
deliberately don't reuse the existing SEV-MEM/ES infrastructure.  It'll require
more copy+paste to get rolling, but I suspect that the end result will be less
churn and far easier to read.

