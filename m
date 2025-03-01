Return-Path: <linux-kernel+bounces-539696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1262EA4A777
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3296C3ADCFB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB39322318;
	Sat,  1 Mar 2025 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i765qmnR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641BDB676
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740792867; cv=none; b=NKqK1eWwIwdFmDguLC8YcFDSNLMip25kF4mla4Or+24tHmYFKHnG8+fcdrZTyCX2WljeyQntcRubIm8j4G8yfGKLVdMuiXIHib9iU0crW5+avztPAmmL40j9ejTd87xJZ4n33t+VH/FznjH7mJfras40tNv7s8FF/eduqpsUwZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740792867; c=relaxed/simple;
	bh=fnh3fwq5HR0yTHAmHdMT421sbicofsP0HTiVsJhWt6g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HW5TWvkB0N7M9JY5CjCrM0pJoa/8kZDDqxPmljQZc5SSjh4VsYAzG91sxWPdQr3WIC31ZxXOwu7KqNXM9a3JtPHQeKne8ZxYwdsy9k+e/XCdVnDWvQtZ6taag7Kc4NggqE4pQXpnSKMxX5lx9UGMCF8O7UXSJ/85GeBxXBLfAAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i765qmnR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740792864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yL+DXeBooPzKSt9J+mbcjwBug/6vCcWna4sgw9dm4c=;
	b=i765qmnRevRFAW0omjrDW9ujElHHYZvdiPmFRZPbty0d+FMTqToGUjccYRHPrXqr97Pn9J
	jlDK2pa+CHN+kwFk+LUzIjAdxMCy/VVArFJOIiceqWIQuA4PSJkaanxkXRZciKkx/95GGi
	omLWw6Dy7Uz2AKA6NnxNCwj04XtNTj4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-S7U9QRlmNrObDxHksXYRWQ-1; Fri, 28 Feb 2025 20:34:22 -0500
X-MC-Unique: S7U9QRlmNrObDxHksXYRWQ-1
X-Mimecast-MFC-AGG-ID: S7U9QRlmNrObDxHksXYRWQ_1740792862
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c0a7b2905cso459914185a.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740792862; x=1741397662;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9yL+DXeBooPzKSt9J+mbcjwBug/6vCcWna4sgw9dm4c=;
        b=ftSXnSuuu+1AolIn16MuDrJdMRq3XdJhmgRMC44Ug2Qjm8didQ9gvfBZYE/THHKgZm
         rvCm6gJyGX91QtI50Q0+oNVN++FxxwEyrOoba1wdZLm6V/s7gnR0Q48YuJk0w1jZRXi7
         SvwRh5iFz4ld7ZgeW0I41Wz+KasxvZc7P7xb1pYxg7X4fZHKHYcNtfj9N+HqxGLJkPpV
         MlsQqFAGOW3V7oAw7MPixgkQKkTj82FqWM6LOspYjYrrbddmq4FBNxfCT0JKHPR7SiAb
         uRn+FpedSxwIfF6+XkFWleQ4vXl2qnDDr+VGQwDMhixS7Sge9O2mJ2BC2p1vIWM44b18
         o5gg==
X-Forwarded-Encrypted: i=1; AJvYcCWpl3LvVy0a8wfjV1omGZgbydEMXLuV/rCRGVXbGHMV0goqPiAwUcBQJ9609sTlc+uV4K/r1D/ek/pz990=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOE5PdJ6ngtx0eAzdEklRx+rbTbfWBx/kAYUgeUOA+sEaJCrMg
	K149M0uTXLHh7XsI27unIDtpPtyVkJ77FIy/IAQp/yXCcys95DBh7Z7S6LIRp8klOD7avo/C26D
	zzbX7joyp0pS2z+UeKTU1GVMTnAPTod8oUIFARpY1SAgY/reP1t5gwjRpzCUgyw==
X-Gm-Gg: ASbGncsShvQanTvzJlBZYn8DzB/vokcmfoybN72QhwhEMjilzkRQ6LjLOd0L8sgyGc3
	bBHZRUX7QGkW3wcTxgYmbOoYYNIZIL5IzcK174qZUOJldbdfDGQY1gCKk3zJ/N2x8T8MgOy5STn
	g5ivQ/EEbDOpVOQjohnC8IkkMQXKQsSZ+zsbTutc6BuQ7MTxqxCrbNUOb/fT8Img8SrTGAqhvJX
	qcHKDCvGikJf+cII6V+3gAE3aiKig4I6Ejg/ExDrwiSqebSZsczUeiuyvEA9pVuyBBjDZQuW6Va
	UXfWmNeavh+PxOw=
X-Received: by 2002:a05:620a:6082:b0:7c3:9d34:e666 with SMTP id af79cd13be357-7c39d34e743mr862874185a.15.1740792861822;
        Fri, 28 Feb 2025 17:34:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZOSNDJhIJKTBsRU1jV9sv/N+QSCwUc/hKZOGRqdOLDg5v3mfrAbcVJB8Is74143ja5GmkIg==
X-Received: by 2002:a05:620a:6082:b0:7c3:9d34:e666 with SMTP id af79cd13be357-7c39d34e743mr862872485a.15.1740792861546;
        Fri, 28 Feb 2025 17:34:21 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378d9e32dsm317624985a.74.2025.02.28.17.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 17:34:21 -0800 (PST)
Message-ID: <de4a5000d03a4697a419231d766f95dfd1cbe7c6.camel@redhat.com>
Subject: Re: [RFC PATCH 03/13] KVM: nSVM: Split
 nested_svm_transition_tlb_flush() into entry/exit fns
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>, Sean Christopherson
 <seanjc@google.com>,  Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 28 Feb 2025 20:34:20 -0500
In-Reply-To: <20250205182402.2147495-4-yosry.ahmed@linux.dev>
References: <20250205182402.2147495-1-yosry.ahmed@linux.dev>
	 <20250205182402.2147495-4-yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2025-02-05 at 18:23 +0000, Yosry Ahmed wrote:
> The handling for the entry and exit TLB flushes will diverge
> significantly in the following changes. Instead of adding an 'is_vmenter'
> argument like nested_vmx_transition_tlb_flush(), just split the function
> into two variants for 'entry' and 'exit'.
> 
> No functional change intended.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  arch/x86/kvm/svm/nested.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index bbe4f3ac9f250..2eba36af44f22 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -482,7 +482,7 @@ static void nested_save_pending_event_to_vmcb12(struct vcpu_svm *svm,
>  	vmcb12->control.exit_int_info = exit_int_info;
>  }
>  
> -static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
> +static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
>  {
>  	/* Handle pending Hyper-V TLB flush requests */
>  	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
> @@ -503,6 +503,16 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
>  	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
>  }
>  
> +static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
> +{
> +	/* Handle pending Hyper-V TLB flush requests */
> +	kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
> +
> +	/* See nested_svm_entry_tlb_flush() */
> +	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
> +	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
> +}
> +
>  /*
>   * Load guest's/host's cr3 on nested vmentry or vmexit. @nested_npt is true
>   * if we are emulating VM-Entry into a guest with NPT enabled.
> @@ -645,7 +655,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
>  	u32 pause_count12;
>  	u32 pause_thresh12;
>  
> -	nested_svm_transition_tlb_flush(vcpu);
> +	nested_svm_entry_tlb_flush(vcpu);
>  
>  	/* Enter Guest-Mode */
>  	enter_guest_mode(vcpu);
> @@ -1131,7 +1141,7 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>  
>  	kvm_vcpu_unmap(vcpu, &map);
>  
> -	nested_svm_transition_tlb_flush(vcpu);
> +	nested_svm_exit_tlb_flush(vcpu);
>  
>  	nested_svm_uninit_mmu_context(vcpu);
>  

Looks reasonable,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


