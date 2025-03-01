Return-Path: <linux-kernel+bounces-539816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067EEA4A950
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 07:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED76C3BC485
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 06:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9F81BE86E;
	Sat,  1 Mar 2025 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRvkIXyO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E6615574E
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740811763; cv=none; b=aCVeURIJBHt5FMqR4HV3y0B3/iOgzm5nevGpPGfJjl6DNiOHYog66UVomi60pBfavu78AyPGa+dtya4Lw/aA1M7ARyrARIh3OFVUowkY4OfwuDCIeqaGt7sXfPJmWPQYrY0PqGAuujaP0RDAarrIH8Q1i+1yMx9wYGkZf8gtQ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740811763; c=relaxed/simple;
	bh=+XTt2T+NNDGxQsafeQ/gUDMiiU9qaKZkYd8Gx4tEyIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svzWqxQ57bLoG6HDD6+nfFZAcUtsSxhsvOqjwSa8bRTqt7idvPip3eR3n8Zzm3sS2yL3gaJqYDCyYoKuHfOT82h6PaqOSKPjpNMf9GAjbyH9LokS6HBzMX3WIewyEEUolKW7Pn7SSH1XkUWy7DQA7T86HdYkWj7ufiC6DjVpNaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRvkIXyO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740811759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ob1zMtQeCx2FizyIGPPQJuzmyMcYLEn3QafWHtq0k38=;
	b=PRvkIXyO82up4MnF2lAEurct0sD0YkcEkjy+lAhJk9jnlhCM7OanYvcSpSQ4K6LlVLeCjd
	/5AhRuUYX0w0rgTALiaYZdtPct0z4UauvAD9zc+qth15TJTWm9VfTesKXgt1RuO79hSQaL
	1WHai9n81tX+cU8eknMJvkY+rzesmrA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-PlJEBk3MPfylpWsa3kw3tQ-1; Sat, 01 Mar 2025 01:49:16 -0500
X-MC-Unique: PlJEBk3MPfylpWsa3kw3tQ-1
X-Mimecast-MFC-AGG-ID: PlJEBk3MPfylpWsa3kw3tQ_1740811755
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-439858c5911so13406795e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740811755; x=1741416555;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ob1zMtQeCx2FizyIGPPQJuzmyMcYLEn3QafWHtq0k38=;
        b=i8K3OFCTWMmQRuVbbG2Mrd2XgybrXAIDIPyagnJShKG0sYOj/FKbGltrvrLvKFodOv
         wtYR5wmGR8Oltv0Cl4rwc8m/7AOW3RxCbqfPUrhOOt95r5Umt4+ykiuM/28oAaQdCeC6
         +3OXQKRLPkKikjmIKAAQ2N2egalBzM1vJjtvIzeJWF0sJrn1UAY0pPoxmvJxTXhd9pVc
         YQ3PotMmU3dwNT5OmioMP1OikhYTSPZkVTip3LJlx9aajCjQ1rh9f2H1MfvZyyCQARUg
         hBAAfMCbxy+9i/PHcpT9NxzhoYYAqUvOSMjAA5SNCyjpwHXPJtHmqEJpOyDULfCk/jWT
         gywA==
X-Forwarded-Encrypted: i=1; AJvYcCV3mnKwig+x6sQvIAAm7xz6YUnN9UBNyJE3I7mbHoOAXpWY2lJPquFcC66undi36MyjlogyVjnjyK5q4gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjqZq8ZK1KE0p0msruCYX0A6gvkLFFNNrqQciIpixXLu3NAQa4
	gBYQNmuavY80EdwzLBIlW9lMDzuGDDjB4+k1dEMWoDxwcs/9CAkMC1rtlQ7i6dpSHZAuX55geuu
	8S/5fhPvxFKxa7q+Y2dTag3qS/C155KrkxK3lG0Gz5T86YTELOTsDeeW59KhQQQ==
X-Gm-Gg: ASbGncsCoK/4I8ibsaaRzzwHdk4sog6UDPIwMnWGF5GHwWwWfEkf7nE5pR/7P/p3DF3
	rA0KnkMoiAvlbQEFIbzw3bc+7asQFmrnkpo95q3IKiuQHrOlENOn7cW6Iid5P+SrQl5v5DdJUYF
	iTR6H+GsFpxgNaObf8tmmzB5OGN5vk7O/Cw9j+U+FzeBwUgckAlqXTPTPIFs4AvcEbiUqXp0CZA
	kUC8NcKrT5SgxnJA4rZWwzr+UqanqGngZRQiWEqTWq4QKgUCGFXb8fCMzQYWXOWH37THTaKuSf3
	6hzJegwLSljQM/KqFHpb
X-Received: by 2002:a05:600c:1d0e:b0:439:873a:111b with SMTP id 5b1f17b1804b1-43ba66e1fefmr49407615e9.12.1740811755134;
        Fri, 28 Feb 2025 22:49:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzCbE5dNxJtPN94kpmud8e2Z5eOkG3U/VtN6XaHdVtBwL+NRa0ecKwWjuSibtbWK0k16rDAQ==
X-Received: by 2002:a05:600c:1d0e:b0:439:873a:111b with SMTP id 5b1f17b1804b1-43ba66e1fefmr49407485e9.12.1740811754716;
        Fri, 28 Feb 2025 22:49:14 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-390e485d785sm7398353f8f.83.2025.02.28.22.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 22:49:14 -0800 (PST)
Message-ID: <ecbc1c50-fad2-4346-a440-10fbc328162b@redhat.com>
Date: Sat, 1 Mar 2025 07:49:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] KVM: x86: Introduce quirk
 KVM_X86_QUIRK_EPT_IGNORE_GUEST_PAT
To: Yan Zhao <yan.y.zhao@intel.com>, seanjc@google.com
Cc: rick.p.edgecombe@intel.com, kevin.tian@intel.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20250224070716.31360-1-yan.y.zhao@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250224070716.31360-1-yan.y.zhao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/25 08:07, Yan Zhao wrote:
> This series introduces a quirk KVM_X86_QUIRK_EPT_IGNORE_GUEST_PAT as
> suggested by Paolo and Sean [1].
> 
> The purpose of introducing this quirk is to allow KVM to honor guest PAT on
> Intel platforms with self-snoop feature. This support was previously
> reverted by commit 9d70f3fec144 ("Revert "KVM: VMX: Always honor guest PAT
> on CPUs that support self-snoop"") due to a reported broken of an old bochs
> driver which incorrectly set memory type to UC but did not expect that UC
> would be very slow on certain Intel platforms.

Hi Yan,

the main issue with this series is that the quirk is not disabled only 
for TDX VMs, but for *all* VMs if TDX is available.

There are two concepts here:

- which quirks can be disabled

- which quirks are active

I agree with making the first vendor-dependent, but for a different 
reason: the new KVM_X86_QUIRK_EPT_IGNORE_GUEST_PAT must be hidden if 
self-snoop is not present.

As to the second, we already have an example of a quirk that is also 
active, though we don't represent that in kvm->arch.disabled_quirks: 
that's KVM_X86_QUIRK_CD_NW_CLEARED which is for AMD only and is 
effectively always disabled on Intel platforms.  For those cases, we 
need to expose the quirk anyway in KVM_CAP_DISABLE_QUIRKS2, so that 
userspace knows that KVM is *aware* of a particular issue.  In other 
words, even if disabling it has no effect, userspace may want to know 
that it can rely on the problematic behavior not being present.

I'm testing an alternative series and will post it shortly.

Paolo

> Sean previously suggested to bottom out if the UC slowness issue is working
> as intended so that we can enable the quirk only when the VMs are affected
> by the old unmodifiable guests [2]. After consulting with CPU architects,
> it's told that this behavior is expected on ICX/SPR Xeon platforms due to
> the snooping implementation.
> 
> So, implement the quirk such that KVM enables it by default on all Intel
> non-TDX platforms while having the quirk explicitly reference the old
> unmodifiable guests that rely on KVM to force memory type to WB. Newer
> userspace can disable the quirk by default and only leave it enabled if an
> old unmodifiable guest is an concern.
> 
> The quirk is platform-specific valid, available only on Intel non-TDX
> platforms. It is absent on Intel TDX and AMD platforms, where KVM always
> honors guest PAT.
> 
> Patch 1 does the preparation of making quirks platform-specific valid.
> Patch 2 makes the quirk to be present on Intel and absent on AMD.
> Patch 3 makes the quirk to be absent on Intel TDX and self-snoop a hard
>          dependency to enable TDX [3].
>          As a new platform, TDX is always running on CPUs with self-snoop
>          feature. It has no worry to break old yet unmodifiable guests.
>          Simply have KVM always honor guest PAT on TDX enabled platforms.
>          Attaching/detaching non-coherent DMA devices would not lead to
>          mirrored EPTs being zapped for TDs then. A previous attempt for
>          this purpose is at [4].
> 
> 
> This series is based on kvm-coco-queue. It was supposed to be included in
> TDX's "the rest" section. We post it separately to start review earlier.
> 
> Patches 1 and 2 are changes to the generic code, which can also be applied
> to kvm/queue. A proposal is to have them go into kvm/queue and we rebase on
> that.
> 
> Patch 3 can be included in TDX's "the rest" section in the end.
> 
> Thanks
> Yan
> 
> [1] https://lore.kernel.org/kvm/CABgObfa=t1dGR5cEhbUqVWTD03vZR4QrzEUgHxq+3JJ7YsA9pA@mail.gmail.com
> [2] https://lore.kernel.org/kvm/Zt8cgUASZCN6gP8H@google.com
> [3] https://lore.kernel.org/kvm/ZuBSNS33_ck-w6-9@google.com
> [4] https://lore.kernel.org/kvm/20241115084600.12174-1-yan.y.zhao@intel.com
> 
> 
> Yan Zhao (3):
>    KVM: x86: Introduce supported_quirks for platform-specific valid
>      quirks
>    KVM: x86: Introduce Intel specific quirk
>      KVM_X86_QUIRK_EPT_IGNORE_GUEST_PAT
>    KVM: TDX: Always honor guest PAT on TDX enabled platforms
> 
>   Documentation/virt/kvm/api.rst  | 30 +++++++++++++++++++++++++
>   arch/x86/include/asm/kvm_host.h |  2 +-
>   arch/x86/include/uapi/asm/kvm.h |  1 +
>   arch/x86/kvm/mmu.h              |  2 +-
>   arch/x86/kvm/mmu/mmu.c          | 14 +++++++-----
>   arch/x86/kvm/vmx/main.c         |  1 +
>   arch/x86/kvm/vmx/tdx.c          |  5 +++++
>   arch/x86/kvm/vmx/vmx.c          | 39 +++++++++++++++++++++++++++------
>   arch/x86/kvm/x86.c              |  7 +++---
>   arch/x86/kvm/x86.h              | 12 +++++-----
>   10 files changed, 91 insertions(+), 22 deletions(-)
> 


