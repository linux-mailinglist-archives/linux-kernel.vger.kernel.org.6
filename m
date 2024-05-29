Return-Path: <linux-kernel+bounces-194716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C50878D4094
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 23:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 539B7B23114
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 21:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2921C9ECF;
	Wed, 29 May 2024 21:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FI/Vb4UP"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1431C9EBA
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717019750; cv=none; b=FJsvRKvBgUOypuwq8iwT8cnUJR591gMjMGkxwbM6J/cxMgU3EQWc5ullMyOIDPjlq08/bbszHexAWN4Dl5nS1BpQv0dIDDpxudnFMGnvYH6L9eh81lbJrG5fL2Qdb8ky807rRJzOCPp1CQyKAhoBBolbOIzXMd4zu0e8hEVRSuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717019750; c=relaxed/simple;
	bh=UNxJLMGZl1gnRZO6sW+znZ/L8AD9EkiPEE3WJ3MdUgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Spz1CJMydRLAbREuG8QYLGXF5EBASqSmF8HKi3A65cKp2VSbWhkajb2xGDZPmLCvl0mubv7+jsnGVttoKwkXzLvWO0Zx6AhcBiVzh7Nu9ZU5IuTwLl8htJa/a+jpLU3QW0hYtmazGe8cIHEcbvVtVehkKDo+d/VtPv+xCLlNuL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FI/Vb4UP; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-68194ee2242so215978a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717019749; x=1717624549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0O8RdWVLc2UjPDSDGViR160MauFo82inRxl7GpP6bk=;
        b=FI/Vb4UP86exDz3dIJiCXtaFMKxh27cM2trVsP7atzrPcumEz2F1G+FtFyry7U4D8A
         Fha8DDVcjugcrgjcCCbBoSJg8lTTb4RTwiNB+UpkBZNonB21vGIDLzXn6PcALb8RdUBx
         tTUlteIUJBV1wmlGDcPckPc0+s7vGdz5tEtgwVkgEx+xxErqaYorw9uYtXUTppjmMsmX
         Y0GrTT/ftr6abfC7IihASGMF9Nvo0ilZbPvakLP55DLlqhvB8Diir+zBLEtvTB/MAnID
         F1zv+ZRBTEPoaeH7AFLEMy88nBRzK84vyfOtTxv/l8nI3e00iamT0iCxXAhQECepprKG
         WGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717019749; x=1717624549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0O8RdWVLc2UjPDSDGViR160MauFo82inRxl7GpP6bk=;
        b=j+GqIZHSHpgyu+iolbdZGhNmC53Z6wx2wP+uoJyC6ewAKa9jY/Vg5DjWy9lblLpE6k
         HKHA3v7B6DL+bEmZ4GCn/ldUCXqkChwa3VrhHlHy+VqVaFkyMOjHdvTtJDuBDW5sJYQL
         4acj8VSbJav7WigSdW8hc8NejSwYs8cMOCb3OfyUrIE6Kh5EC1g/U4C86IOC7dvFhXbe
         Pw7cFCsve78WKDmlLTW6UroBj5PLV3PxKumGA37m2eeHsX8fz6sQVPCgAIf5lYzy62Js
         +nqhdOsL8/kazmne8tCnjI48mQ3GlilyA03s0abpr25E0Xc+GcObOmc9q8BGjBqApdzj
         Adtg==
X-Forwarded-Encrypted: i=1; AJvYcCWqbKXGlGhJq9XDRZHh7waHd/wNdVsZQ68tqAh8J8ZFTDheILW+PNeOrixR00/1CBN/PS2r4FWio+WsMLMR+Zsu2DI4EHXtPF2FrFjo
X-Gm-Message-State: AOJu0Yzt8Fk/8pBK9rsiIQ5wPn8t3norG4gpD9JzbQeS3TgzGxgJiwly
	TK0gYe9r1YeYV+rMS46vrofS3cBsAKmSb3kJx9oSO2flBB25/dMb0ao2+QxVUqbo/dHccd/VSXl
	OoQ==
X-Google-Smtp-Source: AGHT+IGx3SrykKCWRo4963j21qgI5u7l1D5l4vFz5cSTor42JO4rQICXW/WPSO9JICYG6TRZvTrpM8pyR8k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:308:b0:65c:f515:1590 with SMTP id
 41be03b00d2f7-6bfdaf2b2f6mr480a12.11.1717019747924; Wed, 29 May 2024 14:55:47
 -0700 (PDT)
Date: Wed, 29 May 2024 14:55:46 -0700
In-Reply-To: <20240529180510.2295118-5-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240529180510.2295118-1-jthoughton@google.com> <20240529180510.2295118-5-jthoughton@google.com>
Message-ID: <ZlekYljG7KJwblUj@google.com>
Subject: Re: [PATCH v4 4/7] KVM: Move MMU lock acquisition for
 test/clear_young to architecture
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Ankit Agrawal <ankita@nvidia.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	James Morse <james.morse@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Raghavendra Rao Ananta <rananta@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, May 29, 2024, James Houghton wrote:
> For implementation mmu_notifier_{test,clear}_young, the KVM memslot
> walker used to take the MMU lock for us. Now make the architectures
> take it themselves.

Hmm, *forcing* architectures to take mmu_lock is a step backwards.  Rather than
add all of this churn, what about adding CONFIG_KVM_MMU_NOTIFIER_LOCKLESS, e.g.

static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notifier *mn,
							 unsigned long start,
							 unsigned long end,
							 gfn_handler_t handler)
{
	struct kvm *kvm = mmu_notifier_to_kvm(mn);
	const struct kvm_mmu_notifier_range range = {
		.start		= start,
		.end		= end,
		.handler	= handler,
		.on_lock	= (void *)kvm_null_fn,
		.flush_on_ret	= false,
		.may_block	= false,
		.lockless	= IS_ENABLED(CONFIG_KVM_MMU_NOTIFIER_LOCKLESS),
	};

	return __kvm_handle_hva_range(kvm, &range).ret;
}

