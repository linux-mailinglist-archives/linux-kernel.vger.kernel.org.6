Return-Path: <linux-kernel+bounces-285085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE33950914
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAED2282A42
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EC41A01D9;
	Tue, 13 Aug 2024 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2w2yaZH"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D719E831
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562865; cv=none; b=qSjDUTe1qWg0Lu/RZyxD5eO3qMsmezv0ZmLDbAesTGyM6vUf7//PAm4YHh3iiYUkdChLvnqwCFboOIEkGg9mirpRR+VmxoyF3biU12p8zWVRKhFFiZ8kPDQABHjmt6SRaBN4CjSZ4rBEXD7qNDbagxF9yhPGlVcAWGd9uxiawTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562865; c=relaxed/simple;
	bh=9iTZYX0IOdViDbeJkPHjoGuAtLhEKo08YiRbSxrLWqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KBuhyWjJDhrCbSrS5zkeneAKLcuhTKYDqe0gBznw84IcnlPm6C407AVQ+p/RT3qG6ocC4ngT+1HvbZUtJwmU616xKAfhgatAwXXlXvJX8yHVNbDjHJyweC1LodkJufqFEPiFoAqZ3pBCyT1SDK6NqnD6seaY/C7TpezRjtNP52E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a2w2yaZH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64b70c4a269so114658767b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723562862; x=1724167662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YgS/CxIk8degf9Ujhn4Jhee8VQkdqlo8w99w+08tpPY=;
        b=a2w2yaZHMmLpQP8kQxh1tQm4t02IZjobXzjA2xjIeMLYKyAxYcBE+XL/WC4k9hiTR3
         56jwEhnRKsdicoFO9LxjdulJPDOKk4TE2V8B45YhN/NQdkH5tJgPC36PrCX+GqzPRnx0
         6Axp1Og8bl1CGZ9VNAt8qYWjIdDuQL44MY6nWIDEsva3cqxamYuw6l8sV5bcj6DGDVpI
         oPzxixDDij4OlHepWfX+RT1F6H03Ooqgd824lmcMVaTeP3OBw0ZfK09bIhmI2suvuuxV
         9P1mxcsH8xumbm0r2uFycNc9owKUvDg9ti58wLBzX5MDqfYABFuebQxYBHTgG9Lrf3+T
         1Uog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723562862; x=1724167662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgS/CxIk8degf9Ujhn4Jhee8VQkdqlo8w99w+08tpPY=;
        b=lhKt5wrTrznQJGsRTD7HEv/gIB+vLaH/aLAIR2vQt+OC2njNO68VEA9xTX7Shj4kTd
         xiVvfqXkvrk0LSiKaf98MA5k2JOhjWzExK9hVibdrkQih5LWwAjoxIRojsLRnR8NfTlf
         6P2Y+GqiP2wHyui/BH8+GKiySnXZsP4zXJhR9SVXtdZUiQmMRMZAFwgosgB5dk5yCats
         4wQkxWc08Ch+XPxxmFg4Of1B0WwOyU17O14+n+bKNu3kcXj1Wbev44Ea9zyK282HgbNd
         kwmbzra69JQwAgS/2DdEaH3KeIqUV98M7E5xNe37kev3P/LS7Gp4fgnpWXNvYa8J9iKT
         kBRA==
X-Forwarded-Encrypted: i=1; AJvYcCUDvN/7oiHd1uzzv+sAJSpV59iF/dpXtsKQM1kx4qwPeFIce4YlB7zC8zecA3x27fW5iZg5lapBurHZaws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL2Lu0SgdMVPmGEC/Jgtm0p4KUX9uC6KN2jn886WN9P5XD8MRp
	20VmnPOIwsbs9/PpxV0GJwNnGJboWO9jHCyNnHtP/rglcvhRmnCIZ9xUYkU5JaTRYQp5xeN+nyN
	oUg==
X-Google-Smtp-Source: AGHT+IGN0g/iWJrWmwNOf6QYh3EnGuzEizz0+U/tevvxu9l/FVCnp8wtI05EYtrERSQOTEdtYRcJIz2Rvno=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:fc03:0:b0:64b:5dc3:e4fe with SMTP id
 00721157ae682-6a97151ca3cmr1036657b3.1.1723562862655; Tue, 13 Aug 2024
 08:27:42 -0700 (PDT)
Date: Tue, 13 Aug 2024 08:27:41 -0700
In-Reply-To: <5b32da03-addf-4f34-bcf4-76fbe420b8f5@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
 <20240710220540.188239-3-pratikrajesh.sampat@amd.com> <ZrY4e39Q2_WxhrkI@google.com>
 <5b32da03-addf-4f34-bcf4-76fbe420b8f5@amd.com>
Message-ID: <Zrt7bRGQJ1C9XZGy@google.com>
Subject: Re: [RFC 2/5] selftests: KVM: Decouple SEV ioctls from asserts
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, shuah@kernel.org, thomas.lendacky@amd.com, 
	michael.roth@amd.com, pbonzini@redhat.com, pgonda@google.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 13, 2024, Pratik R. Sampat wrote:
> On 8/9/2024 10:40 AM, Sean Christopherson wrote:
> > On Wed, Jul 10, 2024, Pratik R. Sampat wrote:
> >> @@ -98,7 +100,7 @@ static inline void sev_register_encrypted_memory(struct kvm_vm *vm,
> >>  	vm_ioctl(vm, KVM_MEMORY_ENCRYPT_REG_REGION, &range);
> >>  }
> >>  
> >> -static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
> >> +static inline int snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
> >>  					   uint64_t size, uint8_t type)
> >>  {
> >>  	struct kvm_sev_snp_launch_update update_data = {
> >> @@ -108,10 +110,10 @@ static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
> >>  		.type = type,
> >>  	};
> >>  
> >> -	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
> >> +	return __vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
> > 
> > Don't introduce APIs and then immediately rewrite all of the users.  If you want
> > to rework similar APIs, do the rework, then add the new APIs.  Doing things in
> > this order adds a pile of pointless churn.
> > 
> > But that's a moot point, because it's far easier to just add __snp_launch_update_data().
> > And if you look through other APIs in kvm_util.h, you'll see that the strong
> > preference is to let vm_ioctl(), or in this case vm_sev_ioctl(), do the heavy
> > lifting.  Yeah, it requires copy+pasting marshalling parameters into the struct,
> > but that's relatively uninteresting code, _and_ piggybacking the "good" version
> > means you can't do things like pass in a garbage virtual address (because the
> > "good" version always guarantees a good virtual address).
> 
> I am a little confused by this.
> 
> Are you suggesting that I leave the original functions intact with using
> vm_sev_ioctl() and have an additional variant such as
> __snp_launch_update_data() which calls into __vm_sev_ioctl() to decouple
> the ioctl from the assert for negative asserts?

Yes, this one.

> Or, do you suggest that I alter vm_sev_ioctl() to handle both positive
> and negative asserts?
> 
> Thanks!
> -Pratik
> 

