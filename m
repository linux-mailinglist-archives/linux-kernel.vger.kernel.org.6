Return-Path: <linux-kernel+bounces-241788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C390927FA4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C824528357C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E0814AB2;
	Fri,  5 Jul 2024 01:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Imsxz6Or"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EDD11718
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 01:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720142262; cv=none; b=YBx4t5lxZlspGHzLQW/PVWkAI/DmbC8EISDrOM8tKeGGR/eEXkPkr5sTm0pAuEBwCzCUYdiSaBcFedVMdc1h52xPGUROjqM6k55hstCzlRZo1W4j36HYifHVaW/vgepnzibCkHJnaHpvO7R1IJi6OkiNdd8v9zh3aT2Mgjgq83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720142262; c=relaxed/simple;
	bh=0jlmeq8iNWASLgWZu+Yime6G8pnfesdkddowuokoWFA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K29zvLKp/Un9ztg1d9t34zfDGiT9L7+zalzNR3gCbru2+pzU2gpx5sgg4/C5MMKWi1WCH8OzlLoThrQ5Yld63070F1R99UqHx3dyjrztNYqo5jgx5az1SflQhn3UMEjnI2+aSvcG6XboXEv2cs4fTAJO8FtEphOusBrDdNhxqUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Imsxz6Or; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720142259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZdpqctZK0lnPgw4v/NwKvnGdyU7+XtXpVPHKpjWtEI=;
	b=Imsxz6Or1KiqNtaL3qoCZj9ILZV/zSNaq8DLRW9156fh5JxsXU9lrTiLmOm/lihRxWpEuv
	mMW0bjI96HHu22UST2TqcD4GNwkSjsIDqPdtjvYJJpfkYJYDxAfoG6sBpuAaXUMIDtrCp/
	MhIlkhTHiefr3DLEWD5we2R09W0WOxo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-rgoOKL5APsm9V6MjtNioNw-1; Thu, 04 Jul 2024 21:17:38 -0400
X-MC-Unique: rgoOKL5APsm9V6MjtNioNw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-79d58cde65eso144226285a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 18:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720142258; x=1720747058;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZdpqctZK0lnPgw4v/NwKvnGdyU7+XtXpVPHKpjWtEI=;
        b=tPEKSAvO9GaK3Phb7Xja/bJA3pw0hEV6CFZ5bSQ1lsvs6s7dThRsMYdAPwD12EUylA
         jnVXre8B7Wifo79Os1/zblQa9P+zr0oMtpcjx+g1AM8e38zGSjEkoRQABcX7IGLaIem0
         8vT/DX2ZHC/jPOJORNoB6NowHL1x6LMYwFD+62WVS8MPpXK19NuXy5EvKGWWo5yl0/8x
         h1FBLbY02GZr8VxWuo3fwOl7rDUT5gs5Rq8DM5KhXKC2WB7m/qXq7JW0WyeBBPYZnA7Q
         Ts7xhiymC1kZjgyz0pAz9vKE9VlW7QQBPuf7vkEP7CDxf4Y9DmvAIekWivugGGs74oGa
         U6DA==
X-Forwarded-Encrypted: i=1; AJvYcCVa7DSeLJYgiA8Xe8cKbs1SNBKdE0tmvvE8pcPyfQ5BAbNYpXPdUXu4i7hcQXamHNWIStCfpgGq+90c5gfrUQgaqE6NQLcJfnG7HM2J
X-Gm-Message-State: AOJu0YwUCQt6Uls7Tc9Xj0v4qgEZVK4gvLRB7Cc5L7fT5RDM2L8Se2fc
	cWC0fiesgC+GQFDIpKeVWcagcluAID5RIqWVCjDcFkfp2TSoL2nGxqb/FXhypcGdJT+UAn5tExJ
	lAkhyyrBqdYz+G63e1QcSHl2oGjFV4gpzJvcezGY2iPe+Vuuj0uDCjOji1tpf/w==
X-Received: by 2002:a05:620a:5343:b0:797:a485:28ef with SMTP id af79cd13be357-79eee193311mr293929985a.8.1720142257980;
        Thu, 04 Jul 2024 18:17:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9n2tSZ8Hrz4jp8hEVRmgj4S+DhW2AV216ObXnCIpoWjvDsNTMJ4pjCYePPvQxIXv+Rhm/RA==
X-Received: by 2002:a05:620a:5343:b0:797:a485:28ef with SMTP id af79cd13be357-79eee193311mr293928785a.8.1720142257695;
        Thu, 04 Jul 2024 18:17:37 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692f05dcsm730170385a.92.2024.07.04.18.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 18:17:37 -0700 (PDT)
Message-ID: <8fb52f51eb1ff52f5fe666806205cb77a98b6195.camel@redhat.com>
Subject: Re: [PATCH v2 15/49] KVM: x86: Zero out PV features cache when the
 CPUID leaf is not present
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 21:17:36 -0400
In-Reply-To: <20240517173926.965351-16-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-16-seanjc@google.com>
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
> Clear KVM's PV feature cache prior when processing a new guest CPUID so
> that KVM doesn't keep a stale cache entry if userspace does KVM_SET_CPUID2
> multiple times, once with a PV features entry, and a second time without.
> 
> Fixes: 66570e966dd9 ("kvm: x86: only provide PV features if enabled in guest's CPUID")
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index f756a91a3f2f..be1c8f43e090 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -246,6 +246,8 @@ void kvm_update_pv_runtime(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_cpuid_entry2 *best = kvm_find_kvm_cpuid_features(vcpu);
>  
> +	vcpu->arch.pv_cpuid.features = 0;
> +
>  	/*
>  	 * save the feature bitmap to avoid cpuid lookup for every PV
>  	 * operation

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


