Return-Path: <linux-kernel+bounces-241777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E046927F85
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083D31F24985
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF897B656;
	Fri,  5 Jul 2024 01:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMlJmkKm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA9BA55
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 01:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720141380; cv=none; b=CL1PY128F79UnXtDyhpWATYNoLIcKgPE6Mw0ZDG6+k89lUk2UqSNDhf5Vwg84VSWh6J8Az9YzUAeyrbRemrlx+bqEWxtTlErRDCEjramX1CSeaNdt2P0QdtfB6VZZvHzTSbVz9MG2/eGrUoquIuAXewaArM8Zd1L3dc54jI3WgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720141380; c=relaxed/simple;
	bh=eN/qlqR3Zo5kCHr/OMGtGHTTRM/b2jase/Y9KkmY4rc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=evIAIu5Il1eBLgnVyDqxJd8LwLcCvqK6oMJvgZXI+M1mCIw5AqiaPZK8MgFKtWzzrkiI3uyiTcOFwdoooa1CwfwgTIGRvY3CsxCOOzSnhlNHGhYefuFxC1MnaWNLv1vmpAJ7GJZVV5i3XvJYNWppLRZoqpOVbdR+3nSe0pNhg/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMlJmkKm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720141378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3rY5xknhh3FOvB98bwxPhUCsuh04Yjf4LYAQaj0PBE=;
	b=aMlJmkKmCyXhHewiA29iX75EWIlh8Ap/0VxGc2UUxuJEV1yEq732xTdcX7THACxzenRtUr
	Zx8QzaLxgKFJDAsad9VW0nW3L84v2q9tB6ku+TJM8th2A83fY/YADbWx7PcMT8xFb/4UiY
	+VqNCp1HcOdqusM7ZdjO1hJu+pFaRBg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-_QlqyXi9M1-1sExU2jiDAQ-1; Thu, 04 Jul 2024 21:02:56 -0400
X-MC-Unique: _QlqyXi9M1-1sExU2jiDAQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-79ee50c2336so80962685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 18:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720141376; x=1720746176;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3rY5xknhh3FOvB98bwxPhUCsuh04Yjf4LYAQaj0PBE=;
        b=oze0sCwRF53wRpKWb/EFvAY/rOyc92qb1W1wM9vSuRdKTXKHK/mED4iboMuYDGF8xC
         8cbyLZTSeEmExkCK8lZjdecOHTL2Uyo2TtGhFNzKdJT4UMuaf+/zaOUG24BG7JX0q5w8
         iv6mAANEXCNfeMbk/KgzsOYoNNld0tJUOaWuH+37UAerXikj/1lIgvXc0Y4c6ZnPw4m9
         BqYWr0s9GWkjoIkJl9BoNYF+JBl0ktUruugCWfaqJ8tYeaM51MS5mcsYQQKferPFUGvv
         nwvINMSya91wINHIfU11ktof0iX68eDnHTBgUpFe1SwvRDe5OZeCQKhbwrsRIGvYCkK2
         Xz8g==
X-Forwarded-Encrypted: i=1; AJvYcCVj1c16F3m4ANMFNPLZj8qFN3aH7ic+UO0j3nmrRk2ywXLu5us9mH+bHWzsDkplXjYuVgpjaqw4auV0u0fNvgphsQafYb/okfBM9SVI
X-Gm-Message-State: AOJu0Yy9AlEoYyihY07ITD0SiD0kLcMwvbi10fJEJx4GzBZyquh/rQaQ
	Y8hLAmovtYMWLwxXF4uDwMcl689Zf2zCDPJt054O8R7x3y03ljJo48ojZ5a4tBf7dxMWRDMpSgZ
	Z/ApMwHhQ3Urh5wV1TfNN1g4a+x6CtAqapOODeJPLsH01yExFBk59O6XuZYQrSg==
X-Received: by 2002:a05:620a:5610:b0:79e:f730:e2d7 with SMTP id af79cd13be357-79ef730e37cmr29294685a.51.1720141375941;
        Thu, 04 Jul 2024 18:02:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG81lv5DHPL7+sh38G2+I4b5M1hylBqtBNC/YO+HHkQMOM5Mg/mwn6+A4Sg5Y6rqZY1Y1HwQQ==
X-Received: by 2002:a05:620a:5610:b0:79e:f730:e2d7 with SMTP id af79cd13be357-79ef730e37cmr29292385a.51.1720141375649;
        Thu, 04 Jul 2024 18:02:55 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692eff08sm725026485a.83.2024.07.04.18.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 18:02:55 -0700 (PDT)
Message-ID: <4076d0c617d3e94ea742855f80a497c532107e88.camel@redhat.com>
Subject: Re: [PATCH v2 09/49] KVM: x86/pmu: Drop now-redundant refresh()
 during init()
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 21:02:54 -0400
In-Reply-To: <20240517173926.965351-10-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-10-seanjc@google.com>
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
> Drop the manual kvm_pmu_refresh() from kvm_pmu_init() now that
> kvm_arch_vcpu_create() performs the refresh via kvm_vcpu_after_set_cpuid().
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/pmu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index a593b03c9aed..31920dd1aa83 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -797,7 +797,6 @@ void kvm_pmu_init(struct kvm_vcpu *vcpu)
>  
>  	memset(pmu, 0, sizeof(*pmu));
>  	static_call(kvm_x86_pmu_init)(vcpu);
> -	kvm_pmu_refresh(vcpu);
>  }
>  
>  /* Release perf_events for vPMCs that have been unused for a full time slice.  */

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


