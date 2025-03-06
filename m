Return-Path: <linux-kernel+bounces-549271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32582A55023
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832FC176446
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9C91991CF;
	Thu,  6 Mar 2025 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tw79dSbe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA231A89
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277085; cv=none; b=lGE5Xgtj9NMlrCUHc65UOhJyfN/RL/M+jmKr11f2uTFxfJZ5W9PGks8gRm6BftLG7Xo694fYuflHpJwxaKjgPeRgZTinVossobE7Ux9SsqWIQX2oIfxcYPAXuYBaqkLRVzuXc1y3x3YHljb94vqrRvjqDyX6qrefXSn4WRFk3+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277085; c=relaxed/simple;
	bh=V6tdFFcyazi373LB4Se5Cta0BDpXosRQ9o1vr/ggNX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MW07HIDcA+Fk/zGZDHVz3IP12e/7owwBDzzCvOsAOYhHu1mPGCJWNm5SGFt+SXo45sqH5huRcaFHNdOeSAJHxYhOmqZSPnHrSmYlWf6KUeJocMaQkfHSAX9JnIl/XGO1Xomv+sYklP5vYAvRdyHhzjxnayUeu0aOv07CZ+itd0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tw79dSbe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741277082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EEIIfosSCEicnETzycTiMN0DAa96dcihxdXuVWzuuf8=;
	b=Tw79dSbeWHO+GXQj87rqY07ZFDrbndwOWNrxkYoZ9pCCkMOq6TPPPsNpf5g7LwTQ+p6qba
	mp0MGdZq7xqHxAT9ZHKpb4EWQmHN0beSpZLjRa8MkFeb9hgSn9WMh1syDuhPXtBPu5GszB
	g/YiqS21PLtL3G+ZRy6Dq//cB9qHRNo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-NIi4viKwP9amlp-dS4BhLw-1; Thu, 06 Mar 2025 11:04:41 -0500
X-MC-Unique: NIi4viKwP9amlp-dS4BhLw-1
X-Mimecast-MFC-AGG-ID: NIi4viKwP9amlp-dS4BhLw_1741277080
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e4987b2107so881074a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 08:04:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741277080; x=1741881880;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEIIfosSCEicnETzycTiMN0DAa96dcihxdXuVWzuuf8=;
        b=v40LUq4fhFMTbDsuf/rmMgeA6qkQGNASIJ4Tr2fuq7+KEdpi4lW9jo7BhUAJoHLvnM
         p4r7m7DY1U/EufC+N5xa5Vg/ZRNrLI0PJCRF0ATjTiboQKApg6Co+CFXFCpQDVkOEP+U
         NuOVKjvU2ot7wm4dyEaCWE7EUHpPUbBNxk+jA++0FeRlvnCpblRFeZw6NH2szPD/VYEz
         zE7ElFgS3Ius6/qQKHizNsritKH8mHRH1YLjCY6Z+cOB6gAlmHE2KpP11SGhppofx4Tb
         nxgHpEv5dGVtXX2TZQUIHVhfznm76jPKjtSedDmXZVfBVj/uv78tKXWnSXLCfJ3lufUc
         1FpQ==
X-Gm-Message-State: AOJu0YwaWGc8v0Kqozr9SSQdGvJ9avwTdWPcEmXlT6qXm4Him0qVizDL
	/0PvFht3L1y5rPARvPQsFFlEZsLVI5D/Ep94ZKyu14t3YDult5oa/BfhCX2DbAA5RnAA0fvpdyw
	ffkLTpXhHnGpvcMuKbITFu7pLbTZJgClFB9QYvscvuCxTwm3CMB2A2yI8+A8UcA==
X-Gm-Gg: ASbGncs9946CFlA2t4X7VRl4bzzv4qGFni8UOD0UnD1vl/nP6KCJlthK/D/+D8hwgsn
	ARq6TBPLp0bOcJijdNGSSOMijei4SSm6k1tzxcNowDhtm67ATgmmwfbbx+Tiaz74ViJ8o6q6Mnl
	EF747nuHy60KlBJwt1amicbmACeKONhBcFy7hU/gnCAynK/4dkEsRdFSg1BZTTBGlPypZ5Ku22L
	o/2xW5d3ht7A5QBAjug1OZQ19+s+72x0tX5DPhNDYzmic13+gm3smkyUL3oKkWezq2oJin+n4JD
	IsoD8MA2uj03bfbKPQ==
X-Received: by 2002:a05:6402:4302:b0:5de:dc08:9cc5 with SMTP id 4fb4d7f45d1cf-5e59f35eab4mr7156212a12.7.1741277079796;
        Thu, 06 Mar 2025 08:04:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBTlOsB5/SA0qewhiiI4gSDTKxOeYIQXrzoz2k4u4Q9CvzBwHjtDpqHVnjpVLfg63UXmLFOg==
X-Received: by 2002:a05:6402:4302:b0:5de:dc08:9cc5 with SMTP id 4fb4d7f45d1cf-5e59f35eab4mr7156180a12.7.1741277079415;
        Thu, 06 Mar 2025 08:04:39 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7472405sm1130578a12.21.2025.03.06.08.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 08:04:38 -0800 (PST)
Message-ID: <34e10dac-dfe2-453d-b29f-46c9b9a5c349@redhat.com>
Date: Thu, 6 Mar 2025 17:04:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/29] KVM: TDX: Add an ioctl to create initial guest
 memory
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>
References: <20250226195529.2314580-1-pbonzini@redhat.com>
 <20250226195529.2314580-23-pbonzini@redhat.com>
 <Z8E5J73BBGKk8bmS@yzhao56-desk.sh.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z8E5J73BBGKk8bmS@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 05:18, Yan Zhao wrote:
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index 989db4887963..12f3433d062d 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
>> @@ -1,4 +1,5 @@
>>   // SPDX-License-Identifier: GPL-2.0
>> +#include <linux/cleanup.h>
>
> This include is not necessary.

I think it was added because this patch introduces the first use of 
guard().  While it may be included via other files, it's a bit more tidy 
to leave it in.

>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index 622b5a99078a..c88acfa154e6 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -2581,6 +2581,7 @@ struct kvm_memory_slot *kvm_vcpu_gfn_to_memslot(struct kvm_vcpu *vcpu, gfn_t gfn
>>   
>>   	return NULL;
>>   }
>> +EXPORT_SYMBOL_GPL(kvm_vcpu_gfn_to_memslot);
>
> This EXPORT is not necessary. Though looks kvm_vcpu_gfn_to_memslot() is
> the only one not exported among the gfn_to_* functions, e.g. gfn_to_memslot(),
> gfn_to_hva_memslot(), kvm_vcpu_gfn_to_hva()...

Removed, thanks Yan.

Paolo


