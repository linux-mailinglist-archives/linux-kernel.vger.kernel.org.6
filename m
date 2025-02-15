Return-Path: <linux-kernel+bounces-515913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF36A36A6E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B6A1895FEE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72DF81732;
	Sat, 15 Feb 2025 00:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/yQ3cbi"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43867CF16
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580945; cv=none; b=gGOHHpMSU56Q0GCTIxcTAwZd1cva2wl9jcoE3fIX+keX1dbevofzH8CDHkRvLWO5vszyl8Wt4YF+pTT/nD4Y3ilBaF49EEIkoBN+FaKGVcmztyZ/FwINx02MRhwTjJRXaxeZsoS5WNipk6a50aQ7qxa3FnB2tG/xjLY9s5DEy2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580945; c=relaxed/simple;
	bh=oTrztYsLyvwtgGLVf1tQ8GAPVF5vvtL5w9W5awmGqWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BAc6oUcEW+UWDZG0tjl8zBhhVaMrkCbgg8DKb7wHj0QdDhJCPYnf2biKhZ4kHR9CKkPWu613546vTRBoYwlW0i+wSeDtX6NRaqRsNeoSMkgtq0PzH3R27f4Se3jLp5e0Q6AQ1kQPxnep/NgLNRpM+8Le5zLKyLsDV7CpDkPKg68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/yQ3cbi; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc2fee4425so3361460a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739580942; x=1740185742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pNsIgOyf4QC9I3CvrkHrF/C70G83LOB+aLDY9O6HBIc=;
        b=i/yQ3cbihV/Ik0YOx9Cygpca48VSYCeJ0KLb4389/eyGMBuIjen9Vs5kMcxStwldDU
         bqU83omkwKQKXedsre+vl0BUYTaMBzTR1+TEk9Mm4bVJQ4HLfzN6TgRjcuWirTTQ1QBn
         HWVWyotS77GKSTdQ/Hr8ovlxcg26Vhr/xQd0NLPy9YLxTR/pHIQK3YBB5QNHvCBWukwn
         F6QA+4R5MQCj+e2RLnB43xRwWFM7ENzigyT9AxuOTFgf8HQnJFQ7N41eLbyDsXBnc7Sm
         8Wje5Jc3jgjydXUaO1sVGQadfLZaykAG6EADwvX3z7nio+M1EAyvvOE7MdGo/tWYM3qB
         Oszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739580942; x=1740185742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNsIgOyf4QC9I3CvrkHrF/C70G83LOB+aLDY9O6HBIc=;
        b=fIIhmclDzzRjG6KnH65acJehaFdw17DwQdRcZnx2e1AgtWgUXY9nwghwPQEx6MJq8x
         JtM5bPYDrAKcJgBxjPzOv1R3wXzYHAnnfLFGyC7RRUpgnrciRA1PmHqWFisCS7cAhs0B
         62fh1gO46OnCf1OQA8/fzgdVMdARHM5F5AbOfKoorXrcqWE8S0Jmqd5VzXIRW9Sn4eaY
         /UH+1RTUIutzytokPrhoMup02LwlG2HnmJ8DkxDLy/3TU4iM+013e9GenejBi2R9l1mM
         R1NPLtbgWACFoaRgrgKUMgpwKKkpdgRmPdhmwxXSRHeVeKwlesOdkkR1Zz/ZP6Deb62u
         PISQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3QLhM4bm9Q7YqeQIA4aULEe4n8SM/xqwihSTxnP4h6lCZPBiFSAkxq5dwuJrxIuL45nb4m2X+M7IFZBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxOyZLPu3Vh9g5K7/SANeBARjlKA07+JPCJvA7DfUkPHsMoucu
	0cscqVNBzR864hcnUip6cVThTD1UjvsKGSDkXgeF7y5h30Logu/+QvTVkIp8ydrRf3b5Tfmc20a
	xXA==
X-Google-Smtp-Source: AGHT+IFivmaYswWZhaa6Czc5kcx3boX9fghq5jele205LhNXaQ8LsTuPJ7sgZ5ibW32cKGozhQE/CKLT3Eg=
X-Received: from pjboe14.prod.google.com ([2002:a17:90b:394e:b0:2ea:9d23:79a0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e0e:b0:2ee:8427:4b02
 with SMTP id 98e67ed59e1d1-2fc41049fbfmr1809156a91.28.1739580941915; Fri, 14
 Feb 2025 16:55:41 -0800 (PST)
Date: Fri, 14 Feb 2025 16:50:24 -0800
In-Reply-To: <20250204004038.1680123-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204004038.1680123-1-jthoughton@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <173958060314.1192011.10710541316458092620.b4-ty@google.com>
Subject: Re: [PATCH v9 00/11] KVM: x86/mmu: Age sptes locklessly
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	James Houghton <jthoughton@google.com>
Cc: David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, 
	Yu Zhao <yuzhao@google.com>, Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 04 Feb 2025 00:40:27 +0000, James Houghton wrote:
> By aging sptes locklessly with the TDP MMU and the shadow MMU, neither
> vCPUs nor reclaim (mmu_notifier_invalidate_range*) will get stuck
> waiting for aging. This contention reduction improves guest performance
> and saves a significant amount of Google Cloud's CPU usage, and it has
> valuable improvements for ChromeOS, as Yu has mentioned previously[1].
> 
> Please see v8[8] for some performance results using
> access_tracking_perf_test patched to use MGLRU.
> 
> [...]

Applied to kvm-x86 mmu, thanks!

[01/11] KVM: Rename kvm_handle_hva_range()
        https://github.com/kvm-x86/linux/commit/374ccd63600b
[02/11] KVM: Add lockless memslot walk to KVM
        https://github.com/kvm-x86/linux/commit/aa34b811650c
[03/11] KVM: x86/mmu: Factor out spte atomic bit clearing routine
        https://github.com/kvm-x86/linux/commit/e29b74920e6f
[04/11] KVM: x86/mmu: Relax locking for kvm_test_age_gfn() and kvm_age_gfn()
        https://github.com/kvm-x86/linux/commit/b146a9b34aed
[05/11] KVM: x86/mmu: Rename spte_has_volatile_bits() to spte_needs_atomic_write()
        https://github.com/kvm-x86/linux/commit/61d65f2dc766
[06/11] KVM: x86/mmu: Skip shadow MMU test_young if TDP MMU reports page as young
        https://github.com/kvm-x86/linux/commit/e25c2332346f
[07/11] KVM: x86/mmu: Only check gfn age in shadow MMU if indirect_shadow_pages > 0
        https://github.com/kvm-x86/linux/commit/8c403cf23119
[08/11] KVM: x86/mmu: Refactor low level rmap helpers to prep for walking w/o mmu_lock
        https://github.com/kvm-x86/linux/commit/9fb13ba6b5ff
[09/11] KVM: x86/mmu: Add infrastructure to allow walking rmaps outside of mmu_lock
        https://github.com/kvm-x86/linux/commit/4834eaded91e
[10/11] KVM: x86/mmu: Add support for lockless walks of rmap SPTEs
        https://github.com/kvm-x86/linux/commit/bb6c7749ccee
[11/11] KVM: x86/mmu: Support rmap walks without holding mmu_lock when aging gfns
        https://github.com/kvm-x86/linux/commit/af3b6a9eba48

--
https://github.com/kvm-x86/linux/tree/next

