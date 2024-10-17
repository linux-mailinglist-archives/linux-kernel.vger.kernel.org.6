Return-Path: <linux-kernel+bounces-370255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D366A9A29EE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705921C20C82
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FC51E0DD9;
	Thu, 17 Oct 2024 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAK1xX1v"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1079E1E0DBC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184160; cv=none; b=jtAxuxoS9zFhT9eWZmFv34JdMIz9nXIGkZ/EMFdnCXueqzIJv7vTRd1Abz0m+3DMsyXH8mLtDaCHYe12Deo6Pf5BXXcGGUH4Fon4kGds0sM7lBqfxYsQ6wBXy+DyqKg0pb20ZyBDJRaffT6zBL3soaV63Nlh4aDAThfB3LZ55nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184160; c=relaxed/simple;
	bh=A3Bik+uED0TcCq0mhqgECk3LPeT4BajnICFHkP82o8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FH1QCVuqazJNtXs6Kjnyfoc0iow58+le4yhszThGe8xFxDAh4eFRBF9NeKb/DNs4wcYmddV42ESb5BXi9KArLXLhMYXdNRwnYC2MMe8gIlBqez0EHE3Kb+tGCYh5uc5J322JKyHRsVK8zNl0lvaSPR/uf2FjFNlpsHnYgLdoTg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WAK1xX1v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729184157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+TF4EjUQe4akBV6YOBjHNWotRzFr1rk74khyhgxzXjA=;
	b=WAK1xX1vFin5xiHSQgZe2YtIPBMNlkHYCg76nC9a6fiXcmNFIc0YKHpDnJmjvrr3GlYoXH
	K2+J8jiQr+NEhO0Y6IkE8mL5vKME75E4RDSEfBdzTPS7BRYiVkYLJ64P5k+Y8LP+5F9tQ8
	pvU/Jdsc16/8kOmKkz1klNLcFFV88qQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-VM3LTYrOP6KB1rl0nPqE0w-1; Thu, 17 Oct 2024 12:55:55 -0400
X-MC-Unique: VM3LTYrOP6KB1rl0nPqE0w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d458087c0so1345436f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729184154; x=1729788954;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TF4EjUQe4akBV6YOBjHNWotRzFr1rk74khyhgxzXjA=;
        b=Kk7PBiqQCE8HPmZcGgZTNd18rm+xOwaFfEhIp6e9JnWLgA8vZaXeuJOYTIzBK9BmOF
         cjTlfMarcmggHy+uKcP+5Yw9YuB6xKIyOTFvOyCjHFPsVMYfGA7i8CeqK9HsOVngR/KA
         oUjaqWPQ2ftu7jF5NRA766n2AkiBnx86ww+zeppmuXWqfOTus6l9CyF/unzHSPk0aDuq
         7zxu9vCPaiXYlKDDMFiYtdQJZfidD26OdmvRs0uUuUXBJqjutzaCByi64vTNpFP64YxF
         zideCdMy4r4P6swq51MBkxQ6UgWegKvO9e9hGmj2D67eVrX9qItw/41gPUvWmfWSAVh0
         C81A==
X-Forwarded-Encrypted: i=1; AJvYcCWoBtstHZGVVvusGWOzDRpshizHv7i5EEyCrzbud5Zz3gOq/8hqdKuhtEdl2hWjLRq9P7uJfWQeg2u+VGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrYyhMcpr1MyOK+MEXKN7NhaIGCT5MM6vU7DpTJ/TmuPl5ZcXm
	4aQ8RnVTQ1lNudBh+tgbqgEG/jK8yiU6eXnJyb6APhJjM/RCl7JRJGKNyWsLthrOU776QORpTyC
	vwSoNmbbzrDWoqKONN5PDEQH5PJy+J1UqnMkTtp+/c72kSUL8j3hbZJC5InonfA==
X-Received: by 2002:a05:600c:46c7:b0:431:5475:3cd1 with SMTP id 5b1f17b1804b1-4315875fb2fmr24947565e9.17.1729184154475;
        Thu, 17 Oct 2024 09:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGftvJZcxEKWFhN/3/ufIEpcdyKySAIL5OLAG96TfSpAvg7JFTk4Yz8MPMsb+oJ1rNYefBfRw==
X-Received: by 2002:a05:600c:46c7:b0:431:5475:3cd1 with SMTP id 5b1f17b1804b1-4315875fb2fmr24947435e9.17.1729184154064;
        Thu, 17 Oct 2024 09:55:54 -0700 (PDT)
Received: from [192.168.10.28] ([151.95.144.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-431606c64b8sm899815e9.38.2024.10.17.09.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 09:55:53 -0700 (PDT)
Message-ID: <1012877d-1a99-4d0c-92bc-53025dfaf489@redhat.com>
Date: Thu, 17 Oct 2024 18:55:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] KVM: x86/mmu: A/D cleanups (on top of
 kvm_follow_pfn)
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yan Zhao <yan.y.zhao@intel.com>, Sagi Shahar <sagis@google.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Matlack <dmatlack@google.com>, James Houghton <jthoughton@google.com>
References: <20241011021051.1557902-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241011021051.1557902-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/24 04:10, Sean Christopherson wrote:
> This is effectively an extensive of the kvm_follow_pfn series[*] (and
> applies on top of said series), but is x86-specific and is *almost*
> entirely related to Accessed and Dirty bits.
> 
> There's no central theme beyond cleaning up things that were discovered
> when digging deep for the kvm_follow_pfn overhaul, and to a lesser extent
> the series to add MGLRU support in KVM x86.

Very nice - looks obvious in retrospect, as it often happens.

Paolo

> [*] https://lore.kernel.org/all/20241010182427.1434605-1-seanjc@google.com
> 
> Sean Christopherson (18):
>    KVM: x86/mmu: Flush remote TLBs iff MMU-writable flag is cleared from
>      RO SPTE
>    KVM: x86/mmu: Always set SPTE's dirty bit if it's created as writable
>    KVM: x86/mmu: Fold all of make_spte()'s writable handling into one
>      if-else
>    KVM: x86/mmu: Don't force flush if SPTE update clears Accessed bit
>    KVM: x86/mmu: Don't flush TLBs when clearing Dirty bit in shadow MMU
>    KVM: x86/mmu: Drop ignored return value from
>      kvm_tdp_mmu_clear_dirty_slot()
>    KVM: x86/mmu: Fold mmu_spte_update_no_track() into mmu_spte_update()
>    KVM: x86/mmu: WARN and flush if resolving a TDP MMU fault clears
>      MMU-writable
>    KVM: x86/mmu: Add a dedicated flag to track if A/D bits are globally
>      enabled
>    KVM: x86/mmu: Set shadow_accessed_mask for EPT even if A/D bits
>      disabled
>    KVM: x86/mmu: Set shadow_dirty_mask for EPT even if A/D bits disabled
>    KVM: x86/mmu: Use Accessed bit even when _hardware_ A/D bits are
>      disabled
>    KVM: x86/mmu: Process only valid TDP MMU roots when aging a gfn range
>    KVM: x86/mmu: Stop processing TDP MMU roots for test_age if young SPTE
>      found
>    KVM: x86/mmu: Dedup logic for detecting TLB flushes on leaf SPTE
>      changes
>    KVM: x86/mmu: Set Dirty bit for new SPTEs, even if _hardware_ A/D bits
>      are disabled
>    KVM: Allow arch code to elide TLB flushes when aging a young page
>    KVM: x86: Don't emit TLB flushes when aging SPTEs for mmu_notifiers
> 
>   arch/x86/kvm/Kconfig       |   1 +
>   arch/x86/kvm/mmu/mmu.c     |  72 +++++++-----------------
>   arch/x86/kvm/mmu/spte.c    |  59 ++++++++------------
>   arch/x86/kvm/mmu/spte.h    |  72 ++++++++++++------------
>   arch/x86/kvm/mmu/tdp_mmu.c | 109 +++++++++++++++++--------------------
>   arch/x86/kvm/mmu/tdp_mmu.h |   2 +-
>   virt/kvm/Kconfig           |   4 ++
>   virt/kvm/kvm_main.c        |  20 ++-----
>   8 files changed, 142 insertions(+), 197 deletions(-)
> 
> 
> base-commit: 3f9cf3d569fdf7fb451294b636991291965573ce


