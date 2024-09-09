Return-Path: <linux-kernel+bounces-321737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133B5971EBD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF04F28179D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754D2139D05;
	Mon,  9 Sep 2024 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XxrsWFrP"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAD43D38E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898057; cv=none; b=OHIDQhxbcNDQSQcSXWGQRhHqkKqQUjQM5kzVhdzx9V5g3g7qCNs/mH2T1jPVqzfZP1SjKdTL3QzsxxKEFwi6+HAH8XbHfP9AzpjrqX39tfuxLkC0E88ZWVOgrSNr7vMESHM/ncvYbyA11p03w4Sytp2wjLrSlDUV/nlfaFcIiAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898057; c=relaxed/simple;
	bh=f6yvKNsFjmjzWxrkN5lhYMejTXn6xE6/txpSzmpV8dU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ISjOSrC7wm0r29zGUZweb+0AEp3mK6V733BJPnSwsn9rguc3mjuWBJg5D8c1NNs6NY7aedg1IrDUu/081oOt81OzJCn8iOBNEPye9rvzSlrxCUCCCovXyezeyieoPAoXD7e9WfW6YenTjVeONr+qkFd/E5ex8L/Ziuk70k7+nAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XxrsWFrP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2daa02872c1so4731572a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725898056; x=1726502856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IOkcFs26faVAy+v5vuvM4jOtiHbzcdzkj3w0oqgWGOA=;
        b=XxrsWFrPqWMbZ/JaQBAYM0+gAK3AgT0DyiZu+bTmV8ZUU9OXpdaPuhjbewQzj61Zat
         14qoNaM2mYJXSivJP3ZzFYBsgfrpjobQay64D48cyt2aZgxQVRqb8Z/vMq/glXbIR5+i
         ZJ/PjU+K/OTev86yyt17IKUBjG0ygEbL2jiov/Mn4551P1wHjDvjjGvO/LSGDmfcHQaM
         wnngzP+vZCKs0VwTZYjvnn+ynO4EwpeMyR3LMKu4DM+yZ0070BmJUhsAu/f7Gi6E/lDA
         +FZaaT7JrJcI6vcDfis667RyEkXCillPptCreGonz2fB4T3YEk7q+Y+WDFpDMMDGfXBK
         NxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725898056; x=1726502856;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOkcFs26faVAy+v5vuvM4jOtiHbzcdzkj3w0oqgWGOA=;
        b=NX88M66dNAh/Labm5wU52qth+rr0LaWIUdNWfZVBJS37Pfb6F/31Mqfy9F90zq+igs
         E6Sing4rFaar0lF0tDA5pBG1TcrjQ18O9HZDRU4yZz216HO/wF6kY26Sc8q8aAMnl7I3
         o+atCruCxLXvPSUQSr+I+zEk2mRx33D8m3ech4bXZXFqLLaebY7k3DBMbviM2IFwbhzt
         CZjHXi2R9k9ozbDFuV+V7GMQ2mBrw9d0VS7IM0HQd30RLk8O8FpzjXP58nSeOsxpMjjv
         ccWciYZQaQ9T3LjB/U89q8tnKXanW1vrNTslPICRoxzC/GswVwIUqHiMBQPSD/1+n1xM
         RcHw==
X-Forwarded-Encrypted: i=1; AJvYcCW/hHlToxWddubrOczqm/m69U8bDEstK6kvEr1QV/fUiDA/pxHQnmNFMP++axl3uvSgqt4SBUGWIdjlMmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhblvJo0pQ8tcpvJp8/qSAkunVLKSdioZG6LhrSgGPx5zFs/ET
	FMu6CCB8cDjh1jYUl/by00hg30r6i4mn90iHax3kccwiN/3DQJx3ydX6w2aer2tRVxOlHWnXvK0
	HYQ==
X-Google-Smtp-Source: AGHT+IGdS5AEspkaZ5HysEAAR8XN5A9j9iYho87mTahmA+y1bRLz6oeeqrWw8yM7G4QQcl3nJY5hkgKGlW8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1481:b0:2d8:bd72:c5e5 with SMTP id
 98e67ed59e1d1-2dad4b82644mr27082a91.0.1725898055523; Mon, 09 Sep 2024
 09:07:35 -0700 (PDT)
Date: Mon, 9 Sep 2024 09:07:33 -0700
In-Reply-To: <20240904030751.117579-5-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904030751.117579-1-rick.p.edgecombe@intel.com> <20240904030751.117579-5-rick.p.edgecombe@intel.com>
Message-ID: <Zt8dRVdkT2rU31jq@google.com>
Subject: Re: [PATCH 04/21] KVM: VMX: Split out guts of EPT violation to
 common/exposed function
From: Sean Christopherson <seanjc@google.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, kai.huang@intel.com, 
	dmatlack@google.com, isaku.yamahata@gmail.com, yan.y.zhao@intel.com, 
	nik.borisov@suse.com, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 03, 2024, Rick Edgecombe wrote:
> +static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
> +					     unsigned long exit_qualification)
> +{
> +	u64 error_code;
> +
> +	/* Is it a read fault? */
> +	error_code = (exit_qualification & EPT_VIOLATION_ACC_READ)
> +		     ? PFERR_USER_MASK : 0;
> +	/* Is it a write fault? */
> +	error_code |= (exit_qualification & EPT_VIOLATION_ACC_WRITE)
> +		      ? PFERR_WRITE_MASK : 0;
> +	/* Is it a fetch fault? */
> +	error_code |= (exit_qualification & EPT_VIOLATION_ACC_INSTR)
> +		      ? PFERR_FETCH_MASK : 0;
> +	/* ept page table entry is present? */
> +	error_code |= (exit_qualification & EPT_VIOLATION_RWX_MASK)
> +		      ? PFERR_PRESENT_MASK : 0;
> +
> +	if (error_code & EPT_VIOLATION_GVA_IS_VALID)
> +		error_code |= (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) ?
> +			      PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
> +
> +	return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
> +}
> +
> +#endif /* __KVM_X86_VMX_COMMON_H */
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 5e7b5732f35d..ade7666febe9 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -53,6 +53,7 @@
>  #include <trace/events/ipi.h>
>  
>  #include "capabilities.h"
> +#include "common.h"
>  #include "cpuid.h"
>  #include "hyperv.h"
>  #include "kvm_onhyperv.h"
> @@ -5771,11 +5772,8 @@ static int handle_task_switch(struct kvm_vcpu *vcpu)
>  
>  static int handle_ept_violation(struct kvm_vcpu *vcpu)
>  {
> -	unsigned long exit_qualification;
> +	unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
>  	gpa_t gpa;
> -	u64 error_code;
> -
> -	exit_qualification = vmx_get_exit_qual(vcpu);
>  
>  	/*
>  	 * EPT violation happened while executing iret from NMI,
> @@ -5791,23 +5789,6 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
>  	gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
>  	trace_kvm_page_fault(vcpu, gpa, exit_qualification);
>  
> -	/* Is it a read fault? */
> -	error_code = (exit_qualification & EPT_VIOLATION_ACC_READ)
> -		     ? PFERR_USER_MASK : 0;
> -	/* Is it a write fault? */
> -	error_code |= (exit_qualification & EPT_VIOLATION_ACC_WRITE)
> -		      ? PFERR_WRITE_MASK : 0;
> -	/* Is it a fetch fault? */
> -	error_code |= (exit_qualification & EPT_VIOLATION_ACC_INSTR)
> -		      ? PFERR_FETCH_MASK : 0;
> -	/* ept page table entry is present? */
> -	error_code |= (exit_qualification & EPT_VIOLATION_RWX_MASK)
> -		      ? PFERR_PRESENT_MASK : 0;
> -
> -	if (error_code & EPT_VIOLATION_GVA_IS_VALID)
> -		error_code |= (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) ?
> -			      PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
> -

Paolo, are you planning on queueing these for 6.12, or for a later kernel?  I ask
because this will conflict with a bug fix[*] that I am planning on taking through
kvm-x86/mmu.  If you anticipate merging these in 6.12, then it'd probably be best
for you to grab that one patch directly, as I don't think it has semantic conflicts
with anything else in that series.

[*] https://lore.kernel.org/all/20240831001538.336683-2-seanjc@google.com

