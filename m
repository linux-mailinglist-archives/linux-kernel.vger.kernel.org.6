Return-Path: <linux-kernel+bounces-241852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA454928050
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6A31F22342
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EE31758D;
	Fri,  5 Jul 2024 02:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrV/9Unb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB8E1D688
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720145929; cv=none; b=snpxjueMYfuBJcDcUcjd8ikRvYfMoJ27+gfoXF0d0ImXVZc72FqPrcsEkl1Lx7rR1GP6QS/VrBHAK9uv0N7P+amd+ikJVwe3j22EL7BOsPVZeOeIxxLCzqdXoJ8sIPG2SEhkPfKIRn1+mifaOYzR/Sg8P+cV4YXM2akyw0wEp48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720145929; c=relaxed/simple;
	bh=+2wqG4NpFMDYnBYgfaNisaUfobnUBeKE5vgJSPAusHo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KyKypb5SjjiBOO1xq+oMSZj6Fqr9epFjyQYCSaranwQ1tbuP+dOMc/cl0jXqjSvcU3go8Mr2mvXrCoeaLFzA8oflbn54Km4augbKVUtFjL9rORPogpCQegxMbW9hLFL0baEOtkPymPMV7+gPEu0D55Zwa/AJe6fziVI9EZSLNR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WrV/9Unb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720145926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CeU5ZXdnFTjQ32AowEM/69JBo6FJECNkW/27K06LO5g=;
	b=WrV/9UnblyCYz0uKebij8j2W8d2S5o/DyYOyCnJscoq+C9n/+QpPd3wbe8h9soTFeayZeB
	vZvsiXbkMf8HOlGtViBKzCO31Pe/V+G+Ih89SKpsWgUL7Avkd3A+UtJqO1BkhYcE5qyA+W
	JFpTDPnSI6zgCSpc9tTY+6FbZkrp6uY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-vrrja_7PPv6xuhfVMl64dA-1; Thu, 04 Jul 2024 22:18:44 -0400
X-MC-Unique: vrrja_7PPv6xuhfVMl64dA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-79ee509f855so146851485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 19:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720145924; x=1720750724;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CeU5ZXdnFTjQ32AowEM/69JBo6FJECNkW/27K06LO5g=;
        b=GJNnvSZFkzCIl5dDkNvZARzYVsjTwcfLQHkdhRUJkSojPqexVOI7Rs1zqMiDXSkMKp
         uvMNpzHs/sN4wZinwXCppgTOocPQLlc8DmxyT0TRvbAupP97pAmRlek06KoVArrjlA8M
         p2Z2yYrV0hGuJ01UFrRKTvBnZ/12vn5lZ4Qioba6wc4a6QlAlYDrDazFig1J/nezfsWm
         yXx08j54slMUBFTtjOWPaZi7UOK8YCI4GdZe6OmbgDDRXFtUdyuUzUUs9DIPc86JFI1t
         uy/cEX1XVx+oZ3MSXj82PepN+svfokQp9jDQzAbjP68H3ToM2HMR4RhisW0/dNgi9AwT
         qxKw==
X-Forwarded-Encrypted: i=1; AJvYcCVesrYhZDxvAdl5AwsAwikB3ZE77jx+S0UOn3+QcmypFsbvP2NDAhgfSmXlCffO/NTiWX0mkQWyvIBT0NziEJ8eXqQcqva09Caso7mq
X-Gm-Message-State: AOJu0YxK0YUJloWYbggsDND123e74Pi8bSN0IumrmigNthDQUu/zd0Ct
	s3lXAYr4iJozBXtpDy2PnHxvsShoSDSeYC+V1934yhqCNm3KmvBwcuLbdvJoKI/C37eIHv7boVi
	+N/FD8hC7igZPpqxcK2cYeMZgPepZfbXEYe2t4FMgNujb62SQG7w8uEI34B7X5Q==
X-Received: by 2002:a37:de0e:0:b0:79d:7777:1f52 with SMTP id af79cd13be357-79eee29b370mr374053985a.64.1720145924382;
        Thu, 04 Jul 2024 19:18:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSh7GgWJ6tVdavrY330ke3bIne4kuWLkPjC14UYb6bOIadTXYbZtwdARpKCh9EG9fERVdN/g==
X-Received: by 2002:a37:de0e:0:b0:79d:7777:1f52 with SMTP id af79cd13be357-79eee29b370mr374052485a.64.1720145924016;
        Thu, 04 Jul 2024 19:18:44 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79ee5970614sm206009885a.2.2024.07.04.19.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 19:18:43 -0700 (PDT)
Message-ID: <960ef7f670c264824fe43b87b8177a84640b8b5d.camel@redhat.com>
Subject: Re: [PATCH v2 39/49] KVM: x86: Extract code for generating
 per-entry emulated CPUID information
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 22:18:42 -0400
In-Reply-To: <20240517173926.965351-40-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-40-seanjc@google.com>
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
> Extract the meat of __do_cpuid_func_emulated() into a separate helper,
> cpuid_func_emulated(), so that cpuid_func_emulated() can be used with a
> single CPUID entry.  This will allow marking emulated features as fully
> supported in the guest cpu_caps without needing to hardcode the set of
> emulated features in multiple locations.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index fd725cbbcce5..d1849fe874ab 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1007,14 +1007,10 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
>  	return entry;
>  }
>  
> -static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
> +static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func)
>  {
> -	struct kvm_cpuid_entry2 *entry;
> +	memset(entry, 0, sizeof(*entry));
>  
> -	if (array->nent >= array->maxnent)
> -		return -E2BIG;
> -
> -	entry = &array->entries[array->nent];
>  	entry->function = func;
>  	entry->index = 0;
>  	entry->flags = 0;
> @@ -1022,23 +1018,27 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
>  	switch (func) {
>  	case 0:
>  		entry->eax = 7;
> -		++array->nent;
> -		break;
> +		return 1;
>  	case 1:
>  		entry->ecx = F(MOVBE);
> -		++array->nent;
> -		break;
> +		return 1;
>  	case 7:
>  		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
>  		entry->eax = 0;
>  		if (kvm_cpu_cap_has(X86_FEATURE_RDTSCP))
>  			entry->ecx = F(RDPID);
> -		++array->nent;
> -		break;
> +		return 1;
>  	default:
> -		break;
> +		return 0;
>  	}
> +}
>  
> +static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
> +{
> +	if (array->nent >= array->maxnent)
> +		return -E2BIG;
> +
> +	array->nent += cpuid_func_emulated(&array->entries[array->nent], func);
>  	return 0;
>  }
>  
Hi,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>


PS: I spoke with Paolo about the meaning of KVM_GET_EMULATED_CPUID, because it is not clear
from the documentation what it does, or what it supposed to do because qemu doesn't use this
IOCTL.

So this ioctl is meant to return a static list of CPU features which *can* be emulated
by KVM, if the cpu doesn't support them, but there is a cost to it, so they
should not be enabled by default.

This means that if you run 'qemu -cpu host', these features (like rdpid) will only
be enabled if supported by the host cpu, however if you explicitly ask
qemu for such a feature, like 'qemu -cpu host,+rdpid', 
qemu should not warn if the feature is not supported on host cpu but can be emulated
(because kvm can emulate the feature, which is stated by KVM_GET_EMULATED_CPUID ioctl).

Qemu currently doesn't support this but the support can be added.

So I think that the two ioctls should be redefined as such:

KVM_GET_SUPPORTED_CPUID - returns all CPU features that are supported
by KVM, supported by host hardware, or that KVM can efficiently emulate.


KVM_GET_EMULATED_CPUID - returns all CPU features that KVM *can* emulate
if the host cpu lacks support, but emulation is not efficient and thus
these features should be used with care when not supported by the host 
(e.g only when the user explicitly asks for them).


I can post a patch to fix this or you can add something like that to your
patch series if you prefer.


Best regards,
	Maxim Levitsky


