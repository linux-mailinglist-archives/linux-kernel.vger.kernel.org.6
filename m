Return-Path: <linux-kernel+bounces-510216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2DEA319CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90F41884C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEAD26A0C3;
	Tue, 11 Feb 2025 23:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mOA426pG"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812E126A08C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317729; cv=none; b=qfbNTa2oO2wQtaFb5IsoowNtShlJB8m4PnS1MKm8ucupTfbCobQQ+goaIIgZk0wE7Pj+/A542+/U+32NM3LpDMivIrFhqZ2r81ar5Bh7zvr79bm4X44Wme5BozZJaKZN1UQGklw2JRDG6WXIhOF/Del9X/PwJsu1lmfNa8mtL0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317729; c=relaxed/simple;
	bh=cDnsalRb7YufpPDDPgfmjmAXw6jDSFsrdCQyPthOmCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DdrC8j7nnbcnDWGA4kfM0lpoO1whl2gktlRMbhI1Pqh91AC8bB1gMtMOIDUVazdTQCCwLXp/FFIuzHSquSohmeL4Ujiv4lhVsfPm3G12/n32o1sAK2bDveOQWG7+9trR9tv5m9Vml9uAlRXIjmTNvacKpLbJEURQpCxVmJ7mcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mOA426pG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa44233a04so7911072a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 15:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739317728; x=1739922528; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UGu/cNgqZkYuEVNIGjHmdyKZOLkegFa4UYLEoSBig7Y=;
        b=mOA426pGaYIz961rpdl1YmxZQ4bu2Wo5yTjgw7I1fH7Roz//tamqeWqfJx6sOppHGH
         WWHNhfvcJfocTrShWBMZYBR7Bd8WkNGyAq56ERlODeHwYAnqIcFeh74d1+PLYzTxxDXJ
         dJXjj2KBEcIQTLGsArHvG99qEXVr8ahyiMM0lVgo7GViiGSp2oaNErUDyUF9wDioOZuq
         t9ifeWIJSN/BloNPPqbZI0MOkTl5ut6zauykimriXYrSGUmRfRSagruwmL4tCcEFarGg
         oORILajK5IqiQg9/CjnqVYspan9zzI+fkyWNPLK7TvBAqJkLJGlz2zFC05aU/hYimNiH
         U2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739317728; x=1739922528;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGu/cNgqZkYuEVNIGjHmdyKZOLkegFa4UYLEoSBig7Y=;
        b=bgAcVeb1LQipxurZTshcVysPQhiLgVRy3T/76Ioj0UQVxdwx2Q5SbLmPLnoDiS2xiN
         Jy2OKPEOJ3IRozGjam4ZrWhk+H6yVu5TwJq9OZWVM7Jg/jGBetmiqDU09bYqL7Y+RqMA
         PDi4+No5PNpw+W0cGuJ/7uhykpi4su78+xgVZypD5fUYhKG/SwdBCELPxbVjvhCxlX1M
         GdbnOZiSjw3EdOt7cNajDue1YlwC+hTo4YLqkSppp4MtmaPFokfYv18OH7a89Isbbbmf
         ljNr0OYtciCrXBE2AW9KsSBer3xBNfdme2L/hegZ4MTifRb0xGbQEzxnCkDzwkvsV1HN
         DzMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIUZtrXCedP7BLCF+nFp0K3FDm3FjmENvUHl5fg1tS1Ywjn6O+uWD3YSRQQWQPNemmV5p7DyTo27OyPxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvjL9SZm9qU01fsyXkBkRMzt4duUm0X+CD48dbNM2UuBgk9JIE
	SSOe2RnP2ojMeReSXyxBKzTBbQsbYc2067CpRpYMFMZwJBK0LqHbu+RVR1oprLeRdsQsi4OOaxq
	3Rw==
X-Google-Smtp-Source: AGHT+IEc79RumyTWGFr0CkEmyy8mfvo7xYFKyN74swX+mC0k9PkA/d+lnmtjNfhMKlCCsGK17ol8aORl4zk=
X-Received: from pjbnb7.prod.google.com ([2002:a17:90b:35c7:b0:2fa:24c5:36e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:51cd:b0:2ea:3f34:f194
 with SMTP id 98e67ed59e1d1-2fbf5bf4afamr1801039a91.10.1739317727869; Tue, 11
 Feb 2025 15:48:47 -0800 (PST)
Date: Tue, 11 Feb 2025 15:48:46 -0800
In-Reply-To: <20250211025442.3071607-5-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250211025442.3071607-1-binbin.wu@linux.intel.com> <20250211025442.3071607-5-binbin.wu@linux.intel.com>
Message-ID: <Z6vh3ih37Xrmv4TJ@google.com>
Subject: Re: [PATCH v2 4/8] KVM: TDX: Handle KVM hypercall with TDG.VP.VMCALL
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, rick.p.edgecombe@intel.com, 
	kai.huang@intel.com, adrian.hunter@intel.com, reinette.chatre@intel.com, 
	xiaoyao.li@intel.com, tony.lindgren@intel.com, isaku.yamahata@intel.com, 
	yan.y.zhao@intel.com, chao.gao@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 11, 2025, Binbin Wu wrote:
> ---
>  arch/x86/kvm/vmx/tdx.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 420ee492e919..daa49f2ee2b3 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -964,6 +964,23 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
>  	return tdx_exit_handlers_fastpath(vcpu);
>  }
>  
> +static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
> +{
> +	tdvmcall_set_return_code(vcpu, vcpu->run->hypercall.ret);
> +	return 1;
> +}
> +
> +static int tdx_emulate_vmcall(struct kvm_vcpu *vcpu)
> +{
> +	kvm_rax_write(vcpu, to_tdx(vcpu)->vp_enter_args.r10);
> +	kvm_rbx_write(vcpu, to_tdx(vcpu)->vp_enter_args.r11);
> +	kvm_rcx_write(vcpu, to_tdx(vcpu)->vp_enter_args.r12);
> +	kvm_rdx_write(vcpu, to_tdx(vcpu)->vp_enter_args.r13);
> +	kvm_rsi_write(vcpu, to_tdx(vcpu)->vp_enter_args.r14);
> +
> +	return __kvm_emulate_hypercall(vcpu, 0, complete_hypercall_exit);

Thanks for persevering through all the ideas and churn, I like how this turned
out!

