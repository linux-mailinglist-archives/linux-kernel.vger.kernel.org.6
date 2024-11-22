Return-Path: <linux-kernel+bounces-418314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851D59D604C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356FC1F231D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB82D745F2;
	Fri, 22 Nov 2024 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wyDMQ9dm"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E682AF12
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732285957; cv=none; b=Vsr8HYru7TlTjIKrF/ySAPRjTM3taFCYOBVwsuQuq+tr+97mwFtJrGxqo4haS81MegaxLhdcbRy16l0U8aKakLCj+rQY19HgN1D4Xi9r1hVJ1e4X5r/VazGYzOL/5oDsqEfh4WovxXJO+Zi6ldw5F4pyUBCq38tpbFabJ0nSXs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732285957; c=relaxed/simple;
	bh=US7qdoAbpFXy3HycJWgoYHmOo5xoB8xu1iweI2W82rs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q+wKUzrhECEAlbLoUbhf548jH4w6+z50ND+HjR/mabdmO77F6YmjThZKPkBR+oekQW2zhuNBAXvvG0sfvMq/wvIXBEJmKXwS94JeyfGSS72htkzLZa5LrmP5fDXvVCdOyFh50s91I2ylTQqkS7B+ckstoRPTo2lWgsoUw8dZb9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wyDMQ9dm; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-724e2c587b1so708115b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 06:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732285955; x=1732890755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5G90mSkkJJPm7o2FPUh6y7QehjJIhx3sfMq0f0QAJw=;
        b=wyDMQ9dmSmy+m8bSgKUKs6xqxFip9Bke0eI/hXspfnregbQgVaoYvCDGrEzjrHuVQO
         trML95bAkm9uXjXYjTZnJER638hJTaHgeuIQ3otbybgvrzBsKMfOwtvuQ9sD2qsvn7qP
         HPUW6UoGyINQWX/IQS03KpoRxFIxig1W7e9FF/Y6BBjFfWyRlNKIanf68Sjgtyhb1TmW
         7WS+Rt79vJrODwuwjlHHkj6fZo8dJm8MZ6FJm+wB8zaC3IbqaPHlGi17fEEPRLDl1/n+
         yR2Gnh64EFn9oUpDtUyU23JgNC5u9j8/eM+4bNVD5cAmmX2bMzBAX/BtPpIGzFTRsEsz
         dcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732285955; x=1732890755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5G90mSkkJJPm7o2FPUh6y7QehjJIhx3sfMq0f0QAJw=;
        b=tFsM1veOyDJaOPDgpEqKEVNJG8g89NP9wqhmDBdg8RrL2MZM7Kyck35uEpCmaS5bvv
         i+Anr3/mv6Icbn1lALWWVAPy6PPHm+xo5hGEk2/rC+H6sASNIxvJtJmhhAxgkpCGhHct
         Dyc5ovnOsXhkFhDzD48Sh5Hojxw3xEcUC/PXxbD7xD/s/ZAYiRgfbnTNiQtxijG1wXA5
         Atn86z1wE7qOoMf5jGktew/nZbNu1+rixkrlzobQjcR57lT17tOy9MkVapFhGRKniqQ/
         s52gfv9yLXsYoqmoY3MUX1hFW5xQn9aT/DGSOun97AhcjLbXM4LNGETVypQ+nnOf2/sF
         +9Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXsQNlQx9Ho6LNJ+/yZ3HU1V5Xv6IBpvfswPxSxMsQhxol+7aHfYxVSLBzZh17kZJAPJ6FOC3iz3+mZoCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5qPO11PGN6YUREy5T/BSgWFBgPASluycBckKBAnLB7zL+ieCM
	JnTZjIS5mwLAPRldbDkhH4HuTsbMpRTEnctzv564KtgJM6vMM4viXvVCUcOKOAHpelKgOrVmTaB
	rig==
X-Google-Smtp-Source: AGHT+IG2xRZ0B9krkD5T1dy/mXTNVTFzNXb6ngm7KcA6kjjz+MsRPalZoSLYmPTFr94jg1adiFpcMH9byDA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:919d:b0:71e:69bb:d0f8 with SMTP id
 d2e1a72fcca58-724df3e3b0amr5230b3a.1.1732285955277; Fri, 22 Nov 2024 06:32:35
 -0800 (PST)
Date: Fri, 22 Nov 2024 06:32:33 -0800
In-Reply-To: <878qtbvcho.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241118130403.23184-1-kalyazin@amazon.com> <87h684ctlg.fsf@redhat.com>
 <f8faa85e-24e6-4105-ab83-87b1b8c4bd56@amazon.com> <878qtbvcho.fsf@redhat.com>
Message-ID: <Z0CWAXqMl-wTdGXm@google.com>
Subject: Re: [PATCH] KVM: x86: async_pf: check earlier if can deliver async pf
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kalyazin@amazon.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, gshan@redhat.com, graf@amazon.de, 
	jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com, nsaenz@amazon.es, 
	xmarcalx@amazon.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 22, 2024, Vitaly Kuznetsov wrote:
> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
> index a1efa7907a0b..5558a1ec3dc9 100644
> --- a/arch/x86/include/uapi/asm/kvm_para.h
> +++ b/arch/x86/include/uapi/asm/kvm_para.h
> @@ -87,7 +87,7 @@ struct kvm_clock_pairing {
>  #define KVM_MAX_MMU_OP_BATCH           32
>  
>  #define KVM_ASYNC_PF_ENABLED                   (1 << 0)
> -#define KVM_ASYNC_PF_SEND_ALWAYS               (1 << 1)
> +#define KVM_ASYNC_PF_SEND_ALWAYS               (1 << 1) /* deprecated */
>  #define KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT     (1 << 2)
>  #define KVM_ASYNC_PF_DELIVERY_AS_INT           (1 << 3)
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 83fe0a78146f..cd15e738ca9b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3585,7 +3585,6 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
>                                         sizeof(u64)))
>                 return 1;
>  
> -       vcpu->arch.apf.send_user_only = !(data & KVM_ASYNC_PF_SEND_ALWAYS);
>         vcpu->arch.apf.delivery_as_pf_vmexit = data & KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT;
>  
>         kvm_async_pf_wakeup_all(vcpu);
> @@ -13374,8 +13373,7 @@ static bool kvm_can_deliver_async_pf(struct kvm_vcpu *vcpu)
>         if (!kvm_pv_async_pf_enabled(vcpu))
>                 return false;
>  
> -       if (vcpu->arch.apf.send_user_only &&
> -           kvm_x86_call(get_cpl)(vcpu) == 0)
> +       if (kvm_x86_call(get_cpl)(vcpu) == 0)

By x86's general definition of "user", this should be "!= 3" :-)

