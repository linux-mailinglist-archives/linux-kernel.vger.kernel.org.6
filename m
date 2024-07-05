Return-Path: <linux-kernel+bounces-241770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75811927F76
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FFA1C224C2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 00:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4AF947E;
	Fri,  5 Jul 2024 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4QJUXIm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED9610B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 00:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720140708; cv=none; b=Og9b3hB3U2rSeIeDfW8k8Xh5vKpKzmd5uyc6cCdk4Au6KbeCuBqDQbhgM2U8Jsg4ihpObs2sXsywMorwAasNuTxx9E+u9OtBCunafQhITMV019ug9lC55sL4kYuCslqyjgjAu3zOQ1puxfVVUEkvsIvMvPrclNk8qNDbGXvwxDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720140708; c=relaxed/simple;
	bh=afrW9DNgM3EaqVCX8MW5BiJs/xmbnPbSNDsym4RG/hg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pqNgi7slUzDmyRCfu/ikDsN6bO0gb1e8W9vBW5ZcH/MVrGJpBU6RT+6ZJTu3JX++zbMlxsxQGo0JeiUSgswUJsWt/BnFmgs76h98Az4f2A59bJQU3NURCMbms7GOIqvVfvqCizLLg2OAHrwRhI3daNoG7AcZIObzH63MKIKwH7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4QJUXIm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720140705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HsBEw6FKBeGQNgPPBBJpxIWhokMM/LE7Q5WTk7PgH8o=;
	b=g4QJUXImENfouXZ6B9FUE7lMV0XH3telgasFge/Z4tzJNRhdIgCYAWHUKMFyXJa7XVQEmZ
	btQPDG4J7HQpg3C/yMrmeJTJsGi1DlbuMWYnJp4kE1UivM2Zd3Er8iln/sG6SZysERkNMe
	InYgMwTFXBLDmVW4/nwenbj7K61+b1k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-EvfBTCRnM7iIREioQJF88g-1; Thu, 04 Jul 2024 20:51:43 -0400
X-MC-Unique: EvfBTCRnM7iIREioQJF88g-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b07ef34bfcso21747546d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 17:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720140703; x=1720745503;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HsBEw6FKBeGQNgPPBBJpxIWhokMM/LE7Q5WTk7PgH8o=;
        b=GVtLAFBrC22TM9vTS00WcUp3ZCzjyUWkLi+PMHHOeF6WSZeb0uIKz63q2jN2bSf8IR
         JMtxn42Iro4x2j/yaCdayXgPmPFiE9zXE4kAxQFPyN7EBO4VgQ6E9NE1m8obPUwwav2N
         tlP+UEmod2LxPMBu/GNUR4GRqJub4asCvXIUNyxhyh0sYJCt/7j4jMLZkcpN1UxCtUdi
         rnICkAlGXIKac3AO/i1ZHcmv/212hBwdsNPAzzCzItA9VRKYwOSmfc7zgG1TCNh+mXj7
         /amoQ36jAXepTSkRFnZO3GP1KbWROrDZRFQ2c0N+yotHmLpePOqh5Wehi+d1O9x1fWUC
         YNsw==
X-Forwarded-Encrypted: i=1; AJvYcCU4rGWImO3C64Cvu9EMeZuuaWTHk8ov80iNflIufUoH1F3Q+QP6RoxlEwtaDbVVrU8R5gAorRIhedBdAr2Yf7u20IR/M6m9xZrEJ5Cw
X-Gm-Message-State: AOJu0YwjunjSmfZNOQzjEmkjSY0YVSFSPt2O95j1TA4JI0DWF3urMKDc
	wueq5YswafmqdbB3CHt88VJwF7H7m869cusHOkc6kRSm5fe+jNo4RyoBv2zL46jjxNya5vzqwXC
	O7p+h3f9dnpXF/m5LW7zn4iT5F3ukHlZziKLdOVbAb0EjA6byXap0+QOwyKeavg==
X-Received: by 2002:a05:6214:5293:b0:6b5:7e74:185 with SMTP id 6a1803df08f44-6b5ee6837abmr39100706d6.30.1720140703182;
        Thu, 04 Jul 2024 17:51:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIUwM4axfCThXu9OzftOXpsneL9Y24QxF+iGnsgL0MTKtlxyiUip4Ff1wcVsJNZFm1zSu5IA==
X-Received: by 2002:a05:6214:5293:b0:6b5:7e74:185 with SMTP id 6a1803df08f44-6b5ee6837abmr39100586d6.30.1720140702806;
        Thu, 04 Jul 2024 17:51:42 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f1a6dsm68247046d6.83.2024.07.04.17.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 17:51:42 -0700 (PDT)
Message-ID: <d5ef3d7082f28fcad58b3f55a99c9cae17c4de5a.camel@redhat.com>
Subject: Re: [PATCH v2 02/49] KVM: x86: Explicitly do runtime CPUID updates
 "after" initial setup
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 20:51:41 -0400
In-Reply-To: <20240517173926.965351-3-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-3-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> Explicitly perform runtime CPUID adjustments as part of the "after set
> CPUID" flow to guard against bugs where KVM consumes stale vCPU/CPUID
> state during kvm_update_cpuid_runtime().  E.g. see commit 4736d85f0d18
> ("KVM: x86: Use actual kvm_cpuid.base for clearing KVM_FEATURE_PV_UNHALT").
> 
> Whacking each mole individually is not sustainable or robust, e.g. while
> the aforemention commit fixed KVM's PV features, the same issue lurks for
> Xen and Hyper-V features, Xen and Hyper-V simply don't have any runtime
> features (though spoiler alert, neither should KVM).

> 
> Updating runtime features in the "full" path will also simplify adding a
> snapshot of the guest's capabilities, i.e. of caching the intersection of
> guest CPUID and kvm_cpu_caps (modulo a few edge cases).
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 2b19ff991ceb..e60ffb421e4b 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -345,6 +345,8 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>  	bitmap_zero(vcpu->arch.governed_features.enabled,
>  		    KVM_MAX_NR_GOVERNED_FEATURES);
>  
> +	kvm_update_cpuid_runtime(vcpu);
> +
>  	/*
>  	 * If TDP is enabled, let the guest use GBPAGES if they're supported in
>  	 * hardware.  The hardware page walker doesn't let KVM disable GBPAGES,
> @@ -426,8 +428,6 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
>  {
>  	int r;
>  
> -	__kvm_update_cpuid_runtime(vcpu, e2, nent);
> -
>  	/*
>  	 * KVM does not correctly handle changing guest CPUID after KVM_RUN, as
>  	 * MAXPHYADDR, GBPAGES support, AMD reserved bit behavior, etc.. aren't
> @@ -440,6 +440,15 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
>  	 * whether the supplied CPUID data is equal to what's already set.
>  	 */
>  	if (kvm_vcpu_has_run(vcpu)) {
> +		/*
> +		 * Note, runtime CPUID updates may consume other CPUID-driven
> +		 * vCPU state, e.g. KVM or Xen CPUID bases.  Updating runtime
> +		 * state before full CPUID processing is functionally correct
> +		 * only because any change in CPUID is disallowed, i.e. using
> +		 * stale data is ok because KVM will reject the change.
> +		 */

If I understand correctly the sole reason for the below __kvm_update_cpuid_runtime
is to ensure that kvm_cpuid_check_equal doesn't fail because current cpuid also
was post-processed with runtime updates.

Can we have a comment stating this? Or even better how about moving the
call to __kvm_update_cpuid_runtime into the kvm_cpuid_check_equal,
to emphasize this?


> +		__kvm_update_cpuid_runtime(vcpu, e2, nent);
> +
>  		r = kvm_cpuid_check_equal(vcpu, e2, nent);
>  		if (r)
>  			return r;



Overall I am not 100% sure what is better:

Before the patch it was roughly like this:

1. Post process the user given cpuid with bits of KVM runtime state (like xcr0)
At that point the vcpu->arch.cpuid_entries is stale but consistent, it is just old CPUID.

2. kvm_hv_vcpu_init call (IMHO this call can be moved to kvm_vcpu_after_set_cpuid)

3. kvm_check_cpuid on the user provided cpuid

4. Update the vcpu->arch.cpuid_entries with new and post processed cpuid

5. kvm_get_hypervisor_cpuid - I think this also can be cosmetically moved to kvm_vcpu_after_set_cpuid

6. kvm_vcpu_after_set_cpuid itself.


After this change it works like that:

1. kvm_hv_vcpu_init (again this belongs more to kvm_vcpu_after_set_cpuid)
2. kvm_check_cpuid on the user cpuid without post processing - in theory this can cause bugs
3. Update the vcpu->arch.cpuid_entries with new cpuid but without post-processing
4. kvm_get_hypervisor_cpuid
5. kvm_update_cpuid_runtime
6. The old kvm_vcpu_after_set_cpuid

I'm honestly not sure what is better but IMHO moving the kvm_hv_vcpu_init and kvm_get_hypervisor_cpuid into
kvm_vcpu_after_set_cpuid would clean up this mess a bit regardless of this patch.

Best regards,
	Maxim Levitsky





