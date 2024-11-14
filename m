Return-Path: <linux-kernel+bounces-409239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D338F9C8967
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F6B1F2393C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263991F9A9C;
	Thu, 14 Nov 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfGsn2Ks"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF557282EE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585754; cv=none; b=HIwhlnBaYH5kjmeJQ+wDPGsIJO6cIVMcW5rnxu0/QC1hhZJkQRdBucuOdeKiOQeijJ6lfp1d8mcfjV9vhlgFbqi/7nkturuRuCas0O8iUkZ6St2Ou6AnJk91bWazmTlKr4t8Yii94DMRSeQm0KKw+6AV4A97OEmRxfczI1QdboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585754; c=relaxed/simple;
	bh=1SXf8yP3VLSF2r5Eu6BMGoqQB0P+io11+GsJRJHX3oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQG8vo9lMyNKw52ojdOqQODPdqwAwysWY+dw7/B7nB1NIVDnOdyK1bVwHmzISTy3+yIP7jOa6nsvSG2AdpOmUxl59S7TjOg3UoICnxdyCB+K7fBJvnYw7SRrej0XqVlb6Tdhp6ybG2SbomuilT1k/pqavxaCWgsyEXbWqchVsbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfGsn2Ks; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731585751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uOt1qc+5tkbvuid9zgYMC/oMSVVglTuiNDtBt0Q2UoI=;
	b=GfGsn2Ksg26su65TjKEdQD1gQNdl18ZY7c1f1ccrDK5fqyhadBB+FMpUksPHH8QVHI6mLI
	6C/vFkJtegiwYC04/x3lWQfN/ZHikg6/YuUhD/2ZUWoCZhfHs0k1OZ+p3k42I/y9sOa/gi
	h3m2j/l9LI878OgWr+QSI+ZwmLx14jw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-UXynnbuwPOeE8si_Ldb5tA-1; Thu, 14 Nov 2024 07:02:30 -0500
X-MC-Unique: UXynnbuwPOeE8si_Ldb5tA-1
X-Mimecast-MFC-AGG-ID: UXynnbuwPOeE8si_Ldb5tA
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-53a017bc09dso373783e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 04:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731585749; x=1732190549;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOt1qc+5tkbvuid9zgYMC/oMSVVglTuiNDtBt0Q2UoI=;
        b=AkF7wUL3c9Qx0i+5vvCdEfr2l8IGIg6qX/H4kL4r+eVfYPQA/tz3wyAwwnEyOZeRA1
         8hsvmDGFvYgk7nA/0IcTRPttv8Rk2iodyanS8BpcGrFMDHIepF3dX8EwWRKdMlS0wJea
         a8Ra0t4bmarDubc0WkS3T1NqFmEUh98F1YvnwEejjo/9r9HXminsCYP46UrY8RvgAWfR
         BhPI3lZQFcGW5wYUYjgBxPULvS2BCSfhHt1hN8XwF+tK4q9GOGPMbx9N4RHZ3Tiw5zzs
         TboKp7WrQonSVGzGdowZFuTYspXNrcPteP4AhesRLMXgamjuCLr3SiiX1Rb2Eg/xTK+Q
         QC5g==
X-Gm-Message-State: AOJu0YxOouFY2rMw0JaEVNRAs2UhhAHn/HBWfmev8y6aUiHhjl5b5i1b
	Vbhum+ck4xkeE3lPCbDkUCZNpWX2yJHYpnZV96i8cg6dYxnSD3L59cg0PXaaSOuwk22W7K7o56e
	mkwJ6K8CjC71cpwz5blmkb/IqHGJlbYuEKaUVhGLkfoHyuwrnbGA8X7MPhAKr9op5MotlLAzx
X-Received: by 2002:a05:6512:39c4:b0:539:e6fc:4170 with SMTP id 2adb3069b0e04-53d9fe91a6bmr3993744e87.32.1731585748139;
        Thu, 14 Nov 2024 04:02:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwKIY5tRoZ8Bng/iyGL50AnU25kZmf3B+3O7vLZt60gMlyl0LcA6fxUzvbVVJludB/18g3KQ==
X-Received: by 2002:a05:6512:39c4:b0:539:e6fc:4170 with SMTP id 2adb3069b0e04-53d9fe91a6bmr3993713e87.32.1731585747655;
        Thu, 14 Nov 2024 04:02:27 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432da28cad9sm21487865e9.32.2024.11.14.04.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 04:02:27 -0800 (PST)
Message-ID: <70ee319f-b9ec-448a-a068-8165c8e38e6d@redhat.com>
Date: Thu, 14 Nov 2024 13:02:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: switch hugepage recovery thread to vhost_task
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 michael.christie@oracle.com, Tejun Heo <tj@kernel.org>,
 Luca Boccassi <bluca@debian.org>
References: <20241108130737.126567-1-pbonzini@redhat.com>
 <ZzU8qY92Q2QNtuyg@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZzU8qY92Q2QNtuyg@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/24 00:56, Sean Christopherson wrote:
>> +static bool kvm_nx_huge_page_recovery_worker(void *data)
>> +{
>> +	struct kvm *kvm = data;
>>   	long remaining_time;
>>   
>> -	while (true) {
>> -		start_time = get_jiffies_64();
>> -		remaining_time = get_nx_huge_page_recovery_timeout(start_time);
>> +	if (kvm->arch.nx_huge_page_next == NX_HUGE_PAGE_DISABLED)
>> +		return false;
> 
> The "next" concept is broken.  Once KVM sees NX_HUGE_PAGE_DISABLED for a given VM,
> KVM will never re-evaluate nx_huge_page_next.  Similarly, if the recovery period
> and/or ratio changes, KVM won't recompute the "next" time until the current timeout
> has expired.
> 
> I fiddled around with various ideas, but I don't see a better solution that something
> along the lines of KVM's request system, e.g. set a bool to indicate the params
> changed, and sprinkle smp_{r,w}mb() barriers to ensure the vhost task sees the
> new params.

"next" is broken, but there is a much better way to fix it.  You just
track the *last* time that the recovery ran.  This is also better
behaved when you flip recovery back and forth to disabled and back
to enabled: if your recovery period is 1 minute, it will run the
next recovery after 1 minute independent of how many times you flipped
the parameter.

This also fits much better with the "restart function after
schedule()" model that vhost_task.c requires, and it gets rid of
get_nx_huge_page_recovery_whatever() completely.  It's also silly how
close the code is to the broken v1, which is why I'm sending it below
instead of sending again a large patchdd.

Paolo

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 72f3bcfc54d7..e159e44a6a1b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1444,7 +1444,7 @@ struct kvm_arch {
  
  	struct kvm_x86_pmu_event_filter __rcu *pmu_event_filter;
  	struct vhost_task *nx_huge_page_recovery_thread;
-	u64 nx_huge_page_next;
+	u64 nx_huge_page_last;
  
  #ifdef CONFIG_X86_64
  	/* The number of TDP MMU pages across all roots. */
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d0c2d9d2588f..22e7ad235123 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7394,19 +7394,6 @@ static void kvm_recover_nx_huge_pages(struct kvm *kvm)
  	srcu_read_unlock(&kvm->srcu, rcu_idx);
  }
  
-#define NX_HUGE_PAGE_DISABLED (-1)
-
-static u64 get_nx_huge_page_recovery_next(void)
-{
-	bool enabled;
-	uint period;
-
-	enabled = calc_nx_huge_pages_recovery_period(&period);
-
-	return enabled ? get_jiffies_64() + msecs_to_jiffies(period)
-		: NX_HUGE_PAGE_DISABLED;
-}
-
  static void kvm_nx_huge_page_recovery_worker_kill(void *data)
  {
  }
@@ -7414,12 +7401,16 @@ static void kvm_nx_huge_page_recovery_worker_kill(void *data)
  static bool kvm_nx_huge_page_recovery_worker(void *data)
  {
  	struct kvm *kvm = data;
+	bool enabled;
+	uint period;
  	long remaining_time;
  
-	if (kvm->arch.nx_huge_page_next == NX_HUGE_PAGE_DISABLED)
+	enabled = calc_nx_huge_pages_recovery_period(&period);
+	if (!enabled)
  		return false;
  
-	remaining_time = kvm->arch.nx_huge_page_next - get_jiffies_64();
+	remaining_time = kvm->arch.nx_huge_page_last + msecs_to_jiffies(period)
+		- get_jiffies_64();
  	if (remaining_time > 0) {
  		schedule_timeout(remaining_time);
  		/* check for signals and come back */
@@ -7428,7 +7419,7 @@ static bool kvm_nx_huge_page_recovery_worker(void *data)
  
  	__set_current_state(TASK_RUNNING);
  	kvm_recover_nx_huge_pages(kvm);
-	kvm->arch.nx_huge_page_next = get_nx_huge_page_recovery_next();
+	kvm->arch.nx_huge_page_last = get_jiffies_64();
  	return true;
  }
  
@@ -7437,11 +7428,11 @@ int kvm_mmu_post_init_vm(struct kvm *kvm)
  	if (nx_hugepage_mitigation_hard_disabled)
  		return 0;
  
-	kvm->arch.nx_huge_page_next = get_nx_huge_page_recovery_next();
+	kvm->arch.nx_huge_page_last = get_jiffies_64();
  	kvm->arch.nx_huge_page_recovery_thread = vhost_task_create(
  		kvm_nx_huge_page_recovery_worker, kvm_nx_huge_page_recovery_worker_kill,
  		kvm, "kvm-nx-lpage-recovery");
-	
+
  	if (!kvm->arch.nx_huge_page_recovery_thread)
  		return -ENOMEM;
  


