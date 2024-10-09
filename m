Return-Path: <linux-kernel+bounces-357393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713C59970C9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2F53B20D57
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3710F20495C;
	Wed,  9 Oct 2024 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SC0Xr9KF"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533BE204932
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489018; cv=none; b=siUIy0RvpRYD4JRpJse7XxnZaaAOmTB2jNWvuv04vraEDrxh3m360EWLbsAmK+48sQfkSMvctcVbqIHo9jSEnmBZTKQzvJ/+4w9p6KfMBdXZLSK1aJ8tcncwFhJWxpSy1kVdTJ6NuNN/IbE4KxYeEXRjrNEm/UYfljw3HhYH10Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489018; c=relaxed/simple;
	bh=IEk3C5HK+2fLDSHn3IY0LURHtrY8S+z4Dg7g0+3tBIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bqIqAgDBO0hhaQpCOc8+/UNgL0lzaPYMonqjuEBurlH9LcOUNJiP2I+NnWLyEDG/ZsBv/RMTRDoDmsaSEywDpdsl4rFfV3h+ZPpvVrkSpOkdM5lAeY0pL5Tm/XU9XA4VGPlq9wMBOXffM+rIYcJ5IdRldTuEdPdUKbkd3MLXZA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SC0Xr9KF; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e019ab268so4380401b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728489017; x=1729093817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jc3MwSNX0+J+oR+H6AzLHubLG9mcnf8agevCb1Rjaqg=;
        b=SC0Xr9KFKVS+OuNrNVXnfhZhUQDs143QXNtk9fObCyxmmza2V56z0t/hM6ig7CWTWR
         HMDoYKBqXZOHF+OjTm5QK2Z8n0qVVKZgcnRM11BGSez+VI8/wDxNeP8pBakF5t38BJMF
         BDwjjtEJ3jEHSvzDydtJAw0pDWHsbbPKUaKbIhRLkj9GScfZr7io170xOsV1db06kIlJ
         mhBpNFA+7weoNjrxq4Xuu9wWBzIdiHFiyUOU+DCIW7GAlKksrqiHrGN/6+YJD37rCCoy
         +rP5x/KYH8vwCX5qu58QUAEO6EGpV0V2XLvI69K14+zxqFfY6t29wG/dBTcERAaK8S5S
         bKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489017; x=1729093817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jc3MwSNX0+J+oR+H6AzLHubLG9mcnf8agevCb1Rjaqg=;
        b=thJwAfhHfkB/m5dArPOz/cO4mlf9XwPI6dgSyuJL8lan1SE+yK7jHUEFgtrXRD/++N
         N5VQNkpv6IrHbYFhDqkMOON828wJAIzRbldyAeIfu6HwEhtu+bXvv6w8DcdFU9ztckLF
         gDKiU1oIo5EBYVeS9XlfN8kkvOj5SUt1E9hW7tP3Tgqd1yr474O656+AvV0Mzl7wf/Fb
         82hEFd0b/qhjmN4qBOdZu+GiWZ/XlLujLa/wEvao7GjTJiMutZvuTO9vea7aCUrP8VzX
         UkJ18MAJ1xTvAS+y4FEYzmi9kWUxGQkvE41brPeLXVsEUmprmZx1wuPDf5vNdQh7D+v+
         SMVw==
X-Forwarded-Encrypted: i=1; AJvYcCUMas/mhzP5bcYVPsa/fJIX+yCdQpWFW1V6WNtcBif0jJzsE5x6JaJtEMgOPv/0vdAFg8TpKEjeolQworA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9YJErJnsJmBcwEdRWHLdHIFkUbQeLliLDbsFawIej89MuSfek
	BrzkwtPj2YYtW3UIecBDhdTEvEj8NMSZcPZuisfnVE12h1N+2wZgegk5mFvMA0SRO6O1K6cemcy
	WXA==
X-Google-Smtp-Source: AGHT+IHtPJEK4UvnUH2lB7bwyfqs7oKhFlAZAFDdmrNEVSIuNr6gJJns/OGC4yt52V7y0o2FJEVYvG06l9M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:aa7:8f88:0:b0:71d:ec11:1214 with SMTP id
 d2e1a72fcca58-71e1daad342mr3780b3a.0.1728489015563; Wed, 09 Oct 2024 08:50:15
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 08:49:49 -0700
In-Reply-To: <20241009154953.1073471-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009154953.1073471-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009154953.1073471-11-seanjc@google.com>
Subject: [PATCH v3 10/14] KVM: selftests: Enable mmu_stress_test on arm64
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

Enable the mmu_stress_test on arm64.  The intent was to enable the test
across all architectures when it was first added, but a few goofs made it
unrunnable on !x86.  Now that those goofs are fixed, at least for arm64,
enable the test.

Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>
Reviewed-by: James Houghton <jthoughton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 8c69a14dc93d..4db74792d689 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -178,6 +178,7 @@ TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_aarch64 += kvm_page_table_test
 TEST_GEN_PROGS_aarch64 += memslot_modification_stress_test
 TEST_GEN_PROGS_aarch64 += memslot_perf_test
+TEST_GEN_PROGS_aarch64 += mmu_stress_test
 TEST_GEN_PROGS_aarch64 += rseq_test
 TEST_GEN_PROGS_aarch64 += set_memory_region_test
 TEST_GEN_PROGS_aarch64 += steal_time
-- 
2.47.0.rc0.187.ge670bccf7e-goog


