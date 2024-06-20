Return-Path: <linux-kernel+bounces-223294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4C49110B9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED1E28F9A6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E50B1BA89F;
	Thu, 20 Jun 2024 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FO8tPNXm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D4C1B4C3F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907612; cv=none; b=aFMvWOQq78UQWdjDPvzwjtm9qK4ch3gstxAHNsoEPAWq2Z+xGCou2cvipiojStfMG5VpPiQM3JFJTVzjp5Fl74K8k+yXYpPOLMV/F+bfJBMB+XUZRgFyJ2XmFSwQniuFdipRArALBEQB1uKaIYPjUQME6drmN21iulhqpyEK+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907612; c=relaxed/simple;
	bh=khQRGm2IIvTPuqSrSgs30CpqsUmN/Mnzv6zPLM/ZIkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGNORIIWySnn0T5W86dDDjqOgS9p5fihs1s5ScSxXnq9PaIhqJESfC/1egB7sIuQZoONzuINlKJPsXYKJ+ZKmbgH5BA3B9dRvxBNmDVULUMrzgrqij48c2I0MRrQ5y4r4mFsz1zlfi7yFJu+ms4iOJNGXafFeM6UotabhdfplDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FO8tPNXm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718907605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJbj8T1+UF7UMbUX9/SXZw2NvaJoZhTmvFC29onkHsI=;
	b=FO8tPNXmfv5g2TbRJTghnh5e+BEHqALL4ZNKBsMxJDznIJuRoRzt0zXTPMx8GSyEJ1CgKc
	M10Q6BPOKPHOi+WK/DEziC+fcm802qOiUZHLso28ITN6gQhsDkuHgIYOyiaJlyqUiWKX88
	HM9NoCcmwj7+0Yr3zl3XN9uRc0tt3/g=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-zz23wx_bOHi_MbJF4nkCbw-1; Thu, 20 Jun 2024 14:19:59 -0400
X-MC-Unique: zz23wx_bOHi_MbJF4nkCbw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52cb4cf42f6so1071778e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718907598; x=1719512398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJbj8T1+UF7UMbUX9/SXZw2NvaJoZhTmvFC29onkHsI=;
        b=GrjSIbjY+O5N94jOYl4zUqEiS3d1r07uh/mcSiOFjheT7g2AP0wyAslSo2BpYm1Xo8
         4Qyi/S6cY5+kk/HHmAHWow873xERg+rU55L02DyQBVOq5GQmN1lzwJrcg67h7DbYUBJr
         Ql0I9AsLTfoCCZBNCOdPxsYq7sHYOQ0JcIrV7RSf/QcxVs2f7kszLrO1z0nM/QL7tUh8
         oiPThD2ClqP/JDQ46cgQreZxm3gY5U/Ca/CaO+OSv/VZJ5epThuyVxH/GIZ9mDZDo/J3
         Ijo1M7jJjXsprtNNLyIFqph3AHTNrdc1kIV8p0S0dH2VwZPR2CeoPkWGz8mSxKhhd1AE
         6PUA==
X-Forwarded-Encrypted: i=1; AJvYcCUmxJ3f60xKVrqFMRw/8ZQHbhrx1rr8SJKtyXy10la8WZYrc+KOXLVL4tir4vDbSm7krDIMUfNVuOFH/ZWgV8FV4ZaESwxqlYSKfL/M
X-Gm-Message-State: AOJu0YwF33t9uoDdoKXeTJTwqzboF26cexWArlMjg8gJ+1l+vlQ+GLtW
	/hR/VVzUX0JU8WBewLrFyCu/Oxy4lMvXBp3xDTcWpuG2ECfmMugyP8zo2FI6YkGYbX0F1a/e3zc
	rWX3o9mhJ0dgBxXuX/r7OIwRWpQqm0Y1usRCy6bE2ARUkAi3TI+JM8wJBmsKgNjmmmBSuw07YFQ
	oqeu79k4MSmST2jjVNPWNlGbLBr/M9Jwtw6mv4
X-Received: by 2002:a05:6512:76:b0:52c:84a7:f9d5 with SMTP id 2adb3069b0e04-52ccaa5a0abmr3668068e87.69.1718907598346;
        Thu, 20 Jun 2024 11:19:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6QuwIFl7cNwfX3vPqB6O2YrcoQ8M+a+1NklUV4rEQP2gvoki6RiOGp2+FRboLJ5Yeo6yiF3Nh56sGQTj8yoU=
X-Received: by 2002:a05:6512:76:b0:52c:84a7:f9d5 with SMTP id
 2adb3069b0e04-52ccaa5a0abmr3668054e87.69.1718907597942; Thu, 20 Jun 2024
 11:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608001003.3296640-1-seanjc@google.com>
In-Reply-To: <20240608001003.3296640-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 20 Jun 2024 20:19:46 +0200
Message-ID: <CABgObfZSAGU18Yg3yQrfQfOM4AsL5y6VHZcJn3Z9UsosfF_R1w@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: Remove unnecessary INVEPT[GLOBAL] from hardware
 enable path
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 2:10=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Remove the completely pointess global INVEPT, i.e. EPT TLB flush, from
> KVM's VMX enablement path.  KVM always does a targeted TLB flush when
> using a "new" EPT root, in quotes because "new" simply means a root that
> isn't currently being used by the vCPU.
>
> KVM also _deliberately_ runs with stale TLB entries for defunct roots,
> i.e. doesn't do a TLB flush when vCPUs stop using roots, precisely becaus=
e
> KVM does the flush on first use.  As called out by the comment in
> kvm_mmu_load(), the reason KVM flushes on first use is because KVM can't
> guarantee the correctness of past hypervisors.
>
> Jumping back to the global INVEPT, when the painfully terse commit
> 1439442c7b25 ("KVM: VMX: Enable EPT feature for KVM") was added, the
> effective TLB flush being performed was:
>
>   static void vmx_flush_tlb(struct kvm_vcpu *vcpu)
>   {
>           vpid_sync_vcpu_all(to_vmx(vcpu));
>   }
>
> I.e. KVM was not flushing EPT TLB entries when allocating a "new" root,
> which very strongly suggests that the global INVEPT during hardware
> enabling was a misguided hack that addressed the most obvious symptom,
> but failed to fix the underlying bug.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 0e3aaf520db2..21dbe20f50ba 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2832,9 +2832,6 @@ int vmx_hardware_enable(void)
>                 return r;
>         }
>
> -       if (enable_ept)
> -               ept_sync_global();
> -
>         return 0;
>  }
>
>
> base-commit: af0903ab52ee6d6f0f63af67fa73d5eb00f79b9a
> --
> 2.45.2.505.gda0bf45e8d-goog
>


