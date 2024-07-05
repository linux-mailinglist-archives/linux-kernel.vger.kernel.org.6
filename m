Return-Path: <linux-kernel+bounces-241804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D20C927FC5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA2A1F22B7F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AF9EEDD;
	Fri,  5 Jul 2024 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Grrxe4iu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CAD1847
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 01:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720143049; cv=none; b=ZXxk/72y1oyPcdomE0+BCVaVD6cLfNykJF5+9+5BvtbCN3/d2TbbDbrab8M3G1OoZAxfxN9vWzE6VQx2EOSKopBwfZxu1yqkp2tddkA0KjvYcsbKYoYAk4fp057Hr+GC+INAdgoguA9QHdNiKiLuop+GIBUS1mX2NNzOV1J5Upg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720143049; c=relaxed/simple;
	bh=b1KFjrHIxvI8jgSgd4bJYAuJiLdVGAj7jOM75ne/lrc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jZEGAtwSmtLv2eI7sroBPTlvS+SkOwPtVX8zk3iqLqVqrPb2zhYQskWNTFNSxBCzoVb0u6m05HD4/CA2pKnk5mmFoFea1QpDZmWW8n82lHTzcAURJ8CMt19xaTTgh2eUFQl+zSbAblkE8Fk6aNdQqYLCZQ3yLgCYGVdFTAf6hWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Grrxe4iu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720143046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nh3E9KkkAhpYyCrnjfD6rjhdH8UezPd9bJ8upEPnys4=;
	b=Grrxe4iuOwPBUoMHc/vn2KA5m9xOLaUYaOydSHInVYtzLJJSzq6v6yDhitKZkNFcqeN2ER
	lF72rxwUKKtVdUjTn5IPSYel/YpSkIJA2Gg6UFm1MOJ/hcvUT8tmmhlwsLZysyVBAw2UOA
	5WteyW/pVzb6CO6aIvt1pq1qrAEwgvg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-u-bEpj_QPWW5ALkCPrVXVA-1; Thu, 04 Jul 2024 21:30:45 -0400
X-MC-Unique: u-bEpj_QPWW5ALkCPrVXVA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-79cae2abcfeso161298985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 18:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720143045; x=1720747845;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nh3E9KkkAhpYyCrnjfD6rjhdH8UezPd9bJ8upEPnys4=;
        b=Gz75lItCDVuSzku813auo5Wa/lFgp+DPrdCPGKOBP7zxiyYc7mKUYQQYEnclNJSmTz
         X+PrxGIIEsjwejrJLaO/OvWjHKGl8HFD1MCfKNA6TS/B+kFS524BCY8kZrmgVOrQbolr
         rCJ1cPwdUbzfxTwTakTcURuy530e+DktqO3N+PwOPk4so2DYRgyEvyJe0PF3zMFyoqX0
         1F5EJHdOH3mXjCuuSyjKV/z+/YCkioH2QpzX4rimBxz+q2P9XbaSC/OtZhfBrDFPHlTh
         M8jUarDpMref8OFP0hd8dK/e9zbGg2sImqDuqxzCxC4LrwR4kMVPVR/nyhSYmx9mHlaj
         Syfg==
X-Forwarded-Encrypted: i=1; AJvYcCV959hs6PCFIK6rIDi0GxPctkF01I1L92pCX794vPAkjuWLSDI5nR5ySCg9H/6zX8ICNsOYxphbkCJv6W07DeYGwoKW11eK4ZMYSfeQ
X-Gm-Message-State: AOJu0YyUkZ2/TDXvNWkB5zLVHUDvWS21HchX5GGSO/QWCh3JFQqtgcmW
	X6ZsPBB66FL7rcMa0OOwl6XV0UqfLIkIziW6miYowCq68cZ/fWoUdynFmZ5uPvbFUR1w2oqc7WX
	3iUMXAxxHtifQhIV5HCcXST+1iQT4sTwoZ4qEaWVW/igxiR5a97FZNnSAZUbKCg==
X-Received: by 2002:a05:620a:5652:b0:79d:75f0:e91b with SMTP id af79cd13be357-79eeded1c62mr379506585a.0.1720143044989;
        Thu, 04 Jul 2024 18:30:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW2sVNKVe1kjmam9dwHPQKpWfza+eAvYyhoHb0g9AzFonL3o5DNaZvNia17QTPD1lvnrJGng==
X-Received: by 2002:a05:620a:5652:b0:79d:75f0:e91b with SMTP id af79cd13be357-79eeded1c62mr379505585a.0.1720143044754;
        Thu, 04 Jul 2024 18:30:44 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692f05dcsm731005485a.92.2024.07.04.18.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 18:30:44 -0700 (PDT)
Message-ID: <20d3017a8dd54b345104bf2e5cb888a22a1e0a53.camel@redhat.com>
Subject: Re: [PATCH v2 24/49] KVM: x86: #undef SPEC_CTRL_SSBD in cpuid.c to
 avoid macro collisions
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 21:30:43 -0400
In-Reply-To: <20240517173926.965351-25-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-25-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-05-17 at 10:39 -0700, Sean Christopherson wrote:
> Undefine SPEC_CTRL_SSBD, which is #defined by msr-index.h to represent the
> enable flag in MSR_IA32_SPEC_CTRL, to avoid issues with the macro being
> unpacked into its raw value when passed to KVM's F() macro.  This will
> allow using multiple layers of macros in F() and friends, e.g. to harden
> against incorrect usage of F().
> 
> No functional change intended (cpuid.c doesn't consume SPEC_CTRL_SSBD).
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 8efffd48cdf1..a16d6e070c11 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -639,6 +639,12 @@ static __always_inline void kvm_cpu_cap_init(u32 leaf, u32 mask)
>  	kvm_cpu_caps[leaf] &= raw_cpuid_get(cpuid);
>  }
>  
> +/*
> + * Undefine the MSR bit macro to avoid token concatenation issues when
> + * processing X86_FEATURE_SPEC_CTRL_SSBD.
> + */
> +#undef SPEC_CTRL_SSBD
> +
>  void kvm_set_cpu_caps(void)
>  {
>  	memset(kvm_cpu_caps, 0, sizeof(kvm_cpu_caps));

Hi,

Maybe we should instead rename the 
SPEC_CTRL_SSBD to 'MSR_IA32_SPEC_CTRL_SSBD' and together with it, other fields of this msr.
It seems that at least some msrs in this file do this.

Best regards,
	Maxim Levitsky


