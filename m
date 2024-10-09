Return-Path: <linux-kernel+bounces-357385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074A49970B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E951F211D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886DA201105;
	Wed,  9 Oct 2024 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zl0xW/N1"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C041FF7CD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489003; cv=none; b=ICBsDWQs0Z8stQkKPOx0n6xtMaJzD5qTbwSEfTScIai47NoKbnUeroC3mgEQ5lFdZHpEHKcDsaP5adGOg6wxitPxQIZmvxVy+JWojSC2ewsCT/xa5cFS7jFM8HO34TdSZksPf7GTKb0VluyWAm18jN+8Fpl8qmIbLUSaILJQwNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489003; c=relaxed/simple;
	bh=/7fWtV+q7/Fq6/s5md+zD0Cb6GIP2xL9NGhc499VzYw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m3p+bZ7jaJfv6KqZRclNgdOL0n+hTr+5swNKEMwUUhO5WIg0bAT0BJGt7aTOr2SL4Rq1YED6yv11035ApMKTWuDs4Zuubw4bRoVrn6B+pDtdkIK+p5KR+UCXXr3LtZjfHTBDvXwEnHOJMbeq0SwECoy++MSGdc+nzNYit0p0hNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zl0xW/N1; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25cae769abso9655265276.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728489000; x=1729093800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jVTsixz4sZ4koZFPUtECwdZDuBQDlBcuBCpi0vcsFcE=;
        b=Zl0xW/N1UhvCYjDzwG3PWxW2toYTEheC0YCTX8BmhyASF7lpfmJEOPP9Ylm71LpDuy
         0iJokk70f2MFxyZxv0Ngtfz8gPUXf/zVHELWWqKZbx7w9NocOOo06eKB3WhVknsC+Fii
         Jkc9xjVa9jPbNva3NFFbJ/WO7iHTmoZ5EtnsmCprmgx+4eqzG9/jaCiZr5wBNYQ3e5e6
         mpL+FYegINY9kc6R+uxmqX9qXCq/c6yjALMw2zVoasqUiL9eVJiC+nxClyri6ic5liXh
         T8KSk/wE1nxsUoLRrYeEl6oF3vxgfcumgbouDVTn4pasBnlJypNUjKXQqE9eyIxmziTY
         zXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489000; x=1729093800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVTsixz4sZ4koZFPUtECwdZDuBQDlBcuBCpi0vcsFcE=;
        b=cLvMGcMMPjDCL+iFcNhvpu1dx4IqTV9XtSwsClo7GruU2FVSgq8RjKDHWV7uZ0qGCN
         9MXWIFzQF00vN9Oc5b5DHmBGbkeBaYOdqyukF7RuKagLq2Z5K0UvIUjY9qvT4bvx8IaF
         EiHsl9z+/QgGmgZ8gVqBHBYs2TzkE88vCdpCFSTPJTtlCbe2EgdHw0II95epC/dODSA5
         ZdBvM3C39H3URsvd5lv+zG3jlQfjILeAw+xKGdM5htOn4D6n9jU57WJZpCSrTxhmXXHh
         FkPxk71mOMxuRGBMWVExF1Jq7jxgc9t6tZADbr0fe8ALBhlCeTHl34wGrX4fCBwa6b+a
         khOw==
X-Forwarded-Encrypted: i=1; AJvYcCWRDrYeDmlYrh8D/sAVgukGt25eo9dEMK71eLsvcDuilqrElztgGcg6RU8JI83cywZbKNvOel10FXDCbZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtlUfpNwi8zL3wXYVtx9k6rznwlsMmRlkgp0fZBgMPSonGa3NK
	F36CpAWb/OmMnNB4ij1UJIotd1p2dbVm9G5AlVD8O40ZMHGsVGdiufKJ8HvCTG0ONze9s3P6Tp9
	rTg==
X-Google-Smtp-Source: AGHT+IFJReZxJVdNM9WOc4CTIpT8xwBaol9zgUnZweoXlrW7QgctCL6Q+XRwMroT/XXO2vZfV7gZvg3Vxc0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6902:4ac:b0:e28:fdfc:b788 with SMTP id
 3f1490d57ef6-e28fe4426b8mr2248276.9.1728488999652; Wed, 09 Oct 2024 08:49:59
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 08:49:41 -0700
In-Reply-To: <20241009154953.1073471-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009154953.1073471-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009154953.1073471-3-seanjc@google.com>
Subject: [PATCH v3 02/14] KVM: selftests: Disable strict aliasing
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Disable strict aliasing, as has been done in the kernel proper for decades
(literally since before git history) to fix issues where gcc will optimize
away loads in code that looks 100% correct, but is _technically_ undefined
behavior, and thus can be thrown away by the compiler.

E.g. arm64's vPMU counter access test casts a uint64_t (unsigned long)
pointer to a u64 (unsigned long long) pointer when setting PMCR.N via
u64p_replace_bits(), which gcc-13 detects and optimizes away, i.e. ignores
the result and uses the original PMCR.

The issue is most easily observed by making set_pmcr_n() noinline and
wrapping the call with printf(), e.g. sans comments, for this code:

  printf("orig = %lx, next = %lx, want = %lu\n", pmcr_orig, pmcr, pmcr_n);
  set_pmcr_n(&pmcr, pmcr_n);
  printf("orig = %lx, next = %lx, want = %lu\n", pmcr_orig, pmcr, pmcr_n);

gcc-13 generates:

 0000000000401c90 <set_pmcr_n>:
  401c90:       f9400002        ldr     x2, [x0]
  401c94:       b3751022        bfi     x2, x1, #11, #5
  401c98:       f9000002        str     x2, [x0]
  401c9c:       d65f03c0        ret

 0000000000402660 <test_create_vpmu_vm_with_pmcr_n>:
  402724:       aa1403e3        mov     x3, x20
  402728:       aa1503e2        mov     x2, x21
  40272c:       aa1603e0        mov     x0, x22
  402730:       aa1503e1        mov     x1, x21
  402734:       940060ff        bl      41ab30 <_IO_printf>
  402738:       aa1403e1        mov     x1, x20
  40273c:       910183e0        add     x0, sp, #0x60
  402740:       97fffd54        bl      401c90 <set_pmcr_n>
  402744:       aa1403e3        mov     x3, x20
  402748:       aa1503e2        mov     x2, x21
  40274c:       aa1503e1        mov     x1, x21
  402750:       aa1603e0        mov     x0, x22
  402754:       940060f7        bl      41ab30 <_IO_printf>

with the value stored in [sp + 0x60] ignored by both printf() above and
in the test proper, resulting in a false failure due to vcpu_set_reg()
simply storing the original value, not the intended value.

  $ ./vpmu_counter_access
  Random seed: 0x6b8b4567
  orig = 3040, next = 3040, want = 0
  orig = 3040, next = 3040, want = 0
  ==== Test Assertion Failure ====
    aarch64/vpmu_counter_access.c:505: pmcr_n == get_pmcr_n(pmcr)
    pid=71578 tid=71578 errno=9 - Bad file descriptor
       1        0x400673: run_access_test at vpmu_counter_access.c:522
       2         (inlined by) main at vpmu_counter_access.c:643
       3        0x4132d7: __libc_start_call_main at libc-start.o:0
       4        0x413653: __libc_start_main at ??:0
       5        0x40106f: _start at ??:0
    Failed to update PMCR.N to 0 (received: 6)

Somewhat bizarrely, gcc-11 also exhibits the same behavior, but only if
set_pmcr_n() is marked noinline, whereas gcc-13 fails even if set_pmcr_n()
is inlined in its sole caller.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=116912
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 960cf6a77198..6246d69d82d7 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -241,10 +241,10 @@ CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-Wno-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT \
 	-fno-builtin-memcmp -fno-builtin-memcpy \
 	-fno-builtin-memset -fno-builtin-strnlen \
-	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
-	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
-	-I$(<D) -Iinclude/$(ARCH_DIR) -I ../rseq -I.. $(EXTRA_CFLAGS) \
-	$(KHDR_INCLUDES)
+	-fno-stack-protector -fno-PIE -fno-strict-aliasing \
+	-I$(LINUX_TOOL_INCLUDE) -I$(LINUX_TOOL_ARCH_INCLUDE) \
+	-I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(ARCH_DIR) \
+	-I ../rseq -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
 ifeq ($(ARCH),s390)
 	CFLAGS += -march=z10
 endif
-- 
2.47.0.rc0.187.ge670bccf7e-goog


