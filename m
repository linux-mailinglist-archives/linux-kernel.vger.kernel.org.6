Return-Path: <linux-kernel+bounces-359785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AF59990B8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8F728273F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9417201268;
	Thu, 10 Oct 2024 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMjYV7ju"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D76201244
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584774; cv=none; b=iMi63pUGzGAAHDxS9UCVhdJNWPSS+Jsu6nF1egtjPX5c44rEr1HwlyELXQ7lJOjPRqQynZ0VF8bfFcCpPXG0Ry+I0io2s8mXxxDNRxT5CG6krUAavGDWyUbvVf1JDL4UHB3gvLkejQnokdGh6bUkn+AEe2E0mai0SBxmyebatsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584774; c=relaxed/simple;
	bh=t32hhiDzmz/KF55Q/3vtmKLh+T++3xGW8zC+Y7mhAxY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WeTrhex4v0u1gPanCcL15a9ihylm50Ht28eSfd/mKFg7V5zgQielucb0DlS53qbWAyeXu1496fs0HaUZqpdXyZHsyqmrnJIPrdf864zqfsjUm9mZwZW7jDQI8ESWq3opKb70vXufSqGIvU3Oo5IQ/RZZuioEsT8xNBviZjmgRFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bMjYV7ju; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-70ac9630e3aso1195401a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584772; x=1729189572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQkfEcPm4BCGA2NCPxYbIcRTjXNaFQKnzNzKtIM0PSc=;
        b=bMjYV7juBeFlVMGvI7NvnOECGx9NNcc/zEtv4XL/auuP5Ka903KuEIjSTMzcC1Eugg
         j8rtVp7Wpeix1cw/WDIwsZIU0wTWT5U751Nxt1Ns0Xa2Fr7UkWo6hT9YrDpr7YpS6OTw
         LU+YXtX5CGLiB6ZjvIB4nH+NtxFny5aWZnAqymn5BW+gfWLaiXeYGy+NAT0NJ5UGu00k
         4dsKzgGcgqUs6EjEUOnGq7lwY8emCm7AxNltyvDSO0iq23nJjbJoWCfuddHB0rSEfkzM
         JWAWaFN301LUh25d47GCwzrcPcxjw1ki4q6ZHEZ7nWT/H19p2Slj5JxKjRL74P3AOnEm
         sJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584772; x=1729189572;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UQkfEcPm4BCGA2NCPxYbIcRTjXNaFQKnzNzKtIM0PSc=;
        b=dRV7KLNXus1xnebEPjh90vsuUjZawgotftTlRtlS6Vvka1AdNHt1isEpCLOMk5pA5N
         9pHnPuRw1lfdRoO6yclh+jXfgVvxD7nUkBxRMaowyaW54jD0411nEhVsvMBFF5UO7LWZ
         ODlPXDx5YJQp6upPs5OL18fj9SVOQ0R6jR9IwGDbabEvKzo3OOSbGVp3mogbdDPXq9Sl
         sirthjIYH25TVVoc3FpxaBeATa5u55M3kd2Ek1+hn/BYVyWfK0t4VrjsxVOYNyKeB6ec
         3PCHuMH0apm0A2fwCjjJyANhZQMZI57p+ARA9ytSDxsaa8PI7Ysfw9zqQKwBsrKeiRL9
         akUg==
X-Forwarded-Encrypted: i=1; AJvYcCXWXBQpbK0Lm9yncNXIVqb2whGKY58RwK7zZ8ThLmnOxVZctNcrGzUe/Rvg+3Ma5crGOdP+otBBOza3SHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS7xF5t3cTi5iIA9P8YjQauhRnIWRsYllTdvRNrtwaDuqnvcGf
	fqQg7rCxMnzFg8jcibJkif25RnQaAmgSrMI2hja1nFAb5BeyrCrO3Kq8iB4ocaLrCXXvorTbXs8
	BVQ==
X-Google-Smtp-Source: AGHT+IHq9hr54ORGaKAudrJMY0Hy9bRYjmUvRYz8zAm0RAj3x+bD9YD3f2uWGLgDblXeQYOnnP141duUJXA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:1d03:0:b0:7db:539:893c with SMTP id
 41be03b00d2f7-7ea535a65c6mr17a12.9.1728584770873; Thu, 10 Oct 2024 11:26:10
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:23:40 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-39-seanjc@google.com>
Subject: [PATCH v13 38/85] KVM: x86/mmu: Put direct prefetched pages via kvm_release_page_clean()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Use kvm_release_page_clean() to put prefeteched pages instead of calling
put_page() directly.  This will allow de-duplicating the prefetch code
between indirect and direct MMUs.

Note, there's a small functional change as kvm_release_page_clean() marks
the page/folio as accessed.  While it's not strictly guaranteed that the
guest will access the page, KVM won't intercept guest accesses, i.e. won't
mark the page accessed if it _is_ accessed by the guest (unless A/D bits
are disabled, but running without A/D bits is effectively limited to
pre-HSW Intel CPUs).

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e451e1b9a55a..62924f95a398 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2965,7 +2965,7 @@ static int direct_pte_prefetch_many(struct kvm_vcpu *=
vcpu,
 	for (i =3D 0; i < ret; i++, gfn++, start++) {
 		mmu_set_spte(vcpu, slot, start, access, gfn,
 			     page_to_pfn(pages[i]), NULL);
-		put_page(pages[i]);
+		kvm_release_page_clean(pages[i]);
 	}
=20
 	return 0;
--=20
2.47.0.rc1.288.g06298d1525-goog


