Return-Path: <linux-kernel+bounces-358591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E61998140
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED48D1F269DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DB01C3F29;
	Thu, 10 Oct 2024 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eH0G0aBL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066AC1BDA9B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550665; cv=none; b=updUvtxODzfH+fxuLZfc2K+rl+tvREZaIqE9MOCS5yr5DUxHtGfZCZ9uI37xIvHXohQB2/N9L/srtjMHhwrctWVPwgKNekI7cobecYgOHhGDIp9Py8BP5tNzcsmB5SorWwhcGeOHmB/z7CZHuGWe2GQTr0M8Uqx5qGYkceswvrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550665; c=relaxed/simple;
	bh=jzd87EcNDbdw6bw+ZOELD0fitbOeuelfZ1tFytR59eg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ANGcZp3B5cV+EHdlIsUJZDaggyNIHZ7b8b+cVPa56J0jlb9P49Yabsp46GMtFuuxIVu3u7m6JUCo414bw84KMrXsfV0yAdLv3ffx1oUe//KnqJyjuPQTMbuy+PL/FM8+fkVUawSSg3PPWN389XuVOAqrb3JSKlNNI3bEDV4VAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eH0G0aBL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728550663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TVThSOvoNxV/KE/0q+DXcUSmpgIScmqPjQ+ixsvMJSM=;
	b=eH0G0aBLoZqIfWKI9I+y9MjFaOHLtUiH1fNdffo2QZwAaWGVaHX8Lyqh5mDTOTWLo4ee4j
	rOd8NOHTZt4+JFRQmayrBvm9tvt2Sj84BOwStYjbbvOykw347lAFxp20LGW6qR5P1tc3UA
	9ofSxDX3fFNGbSy+OLDdKYErbK2BHoM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-ylCXzyDKMDOFCRHS_Fa-cA-1; Thu, 10 Oct 2024 04:57:41 -0400
X-MC-Unique: ylCXzyDKMDOFCRHS_Fa-cA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb830ea86so4297075e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550660; x=1729155460;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVThSOvoNxV/KE/0q+DXcUSmpgIScmqPjQ+ixsvMJSM=;
        b=PL/mMaVt01gmQ/nYQzSf8joGuns2DjaJ3eYGjt89CQZUjVWhhAKz4TPk6yuyYb/1Sm
         P/bfFJCuUpS8BEK24jymEnVkgTlN2tG48u0W91cJa/GOYEoEA7M0PpZnFGRCMxSzdvvt
         S7cK9ZUu6FAXf+ujx22ykSNt6uyRscQdlfnJwe3pwetayVvTXqMN/vtPaH9/QK9uobW3
         UGmnDbZMHwTWISfhlJ+DKJXVt4KTwzWpRHRwudItO5WE0CxxI2fvz2PFNSIYJABdiyoi
         zSfzK/AyFr82H5nuX91qBTeoBNgoctQgD00tyDjzQpeqH3YOGthD9jK8KrSe10mX33Ka
         zThQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb5omQZZ4FRtG6I0BKGqjN2RGqaKVY2klkPtcidePmYEfp1vYoddS+mtLPYS7QpvZbhcc1ci8bZSCRoHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqDr78mm+3pIp26cnk8fa+KFAy6La3ErfPy9gYIZRzYTzeSvtW
	ZVSszI7k12fx1PI4BdACm72dU17wOjxQdT2jM/9CbLVtT0hwFENBYL9OWzgYoMl06rMBJNGFzwP
	Jr+/E8a73dhi/UT2mgNZjJHS0W2Ch4WH/MDBBNFXxXG2DrngEc1ZcmRY+4IcqEg==
X-Received: by 2002:a05:600c:384c:b0:42c:ba1f:5475 with SMTP id 5b1f17b1804b1-430d5d89857mr49079385e9.26.1728550660371;
        Thu, 10 Oct 2024 01:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg1fwLzWN7F6wE7fj226buZ5WpkZAnIyD5LIz/nUpwxzScWIAB3w1FhioDK5Do+tAdTOoEZw==
X-Received: by 2002:a05:600c:384c:b0:42c:ba1f:5475 with SMTP id 5b1f17b1804b1-430d5d89857mr49079225e9.26.1728550659967;
        Thu, 10 Oct 2024 01:57:39 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf51770sm42504825e9.22.2024.10.10.01.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:57:39 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Nikolas Wipper <nikwip@amazon.de>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf
 <graf@amazon.de>, James Gowans <jgowans@amazon.com>,
 nh-open-source@amazon.com, Sean Christopherson <seanjc@google.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Nikolas Wipper <nik.wipper@gmx.de>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, Nikolas Wipper
 <nikwip@amazon.de>
Subject: Re: [PATCH 4/7] KVM: Introduce KVM_HYPERV_SET_TLB_FLUSH_INHIBIT
In-Reply-To: <20241004140810.34231-5-nikwip@amazon.de>
References: <20241004140810.34231-1-nikwip@amazon.de>
 <20241004140810.34231-5-nikwip@amazon.de>
Date: Thu, 10 Oct 2024 10:57:38 +0200
Message-ID: <877caggwsd.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nikolas Wipper <nikwip@amazon.de> writes:

> Introduce a new ioctl to control whether remote flushing via Hyper-V
> hyper-calls should be allowed on a vCPU. When the tlb_flush_inhibit bit is
> set, vCPUs attempting to flush the TLB of the inhibitied vCPU will be
> suspended until the bit is clearded.
>
> Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
> ---
>  include/uapi/linux/kvm.h | 15 +++++++++++++++

I guess we can merge this patch with documentation (PATCH1) or even
implementation (PATCH5) as I don't see why separation helps here.

>  1 file changed, 15 insertions(+)
>
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 637efc055145..3bc43fdcab88 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -933,6 +933,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_PRE_FAULT_MEMORY 236
>  #define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
>  #define KVM_CAP_X86_GUEST_MODE 238
> +#define KVM_CAP_HYPERV_TLB_FLUSH_INHIBIT 239
>  
>  struct kvm_irq_routing_irqchip {
>  	__u32 irqchip;
> @@ -1573,4 +1574,18 @@ struct kvm_pre_fault_memory {
>  	__u64 padding[5];
>  };
>  
> +/* Available with KVM_CAP_HYPERV_TLBFLUSH */
> +#define KVM_HYPERV_SET_TLB_FLUSH_INHIBIT \
> +	_IOW(KVMIO,  0xd6, struct kvm_hyperv_tlb_flush_inhibit)
> +
> +/* for KVM_HYPERV_SET_TLB_FLUSH_INHIBIT */
> +struct kvm_hyperv_tlb_flush_inhibit {
> +	/* in */
> +	__u16 flags;
> +#define KVM_HYPERV_UNINHIBIT_TLB_FLUSH 0
> +#define KVM_HYPERV_INHIBIT_TLB_FLUSH 1
> +	__u8  inhibit;
> +	__u8  reserved[5];
> +};
> +
>  #endif /* __LINUX_KVM_H */

-- 
Vitaly


