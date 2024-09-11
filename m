Return-Path: <linux-kernel+bounces-325607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 477CE975BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14C41F224BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC0F1BDAA7;
	Wed, 11 Sep 2024 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yw8c9b2R"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261331BDA87
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087361; cv=none; b=d2YDB1ZI/sVIwj+69qH+xvg7sZdegkmxiW2l65zxGU1w7XA+LiYDYGu7FWtDWwJtPW4Mbdt+6F03SKoaYQz20H/Iizx9Z4OtzxjT5FP8kzLa3g92TF2a6VejRijJFg9lQJw1KMTrktbmOG4JOVi9jKwrfRx5vVrvwn8zje20RRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087361; c=relaxed/simple;
	bh=gMePtUPb5fvMNYGIlnFPhk6LbY7QAcbzAoZpHwWYGO8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LAFKfazO/IAL4oLGlNL3aV7s/41ztRWS8V+Xcy/B2j25CSGfK2GxYtQFyKfPLp50oKQsUW0zM6OyAasWOR0gwwDoI5/J9EPKVZkAu0kvXxDS+3yfZNn9NyIgEv5OCrtqcPzZXu9ai+QwStKbAuc8CCqEhn+yYb5AWFTBNC1hKJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yw8c9b2R; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7b696999c65so528022a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726087359; x=1726692159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4Mm6F1KdfaC470dFwf81yhaZh6FdF3AX9IDG0p0k3Sc=;
        b=Yw8c9b2RZEBe0pPMF77ouMoX2IDLc5gqALGEBWGO5wWKo5fWm6OIXd5HeBeaxvi+Qr
         x0Gp0zswLeKcKJHRKZbgNIWdNtZaCe7LtuLXO6t8xeantMvkG99PLQK2jcncNYw4ZlVL
         sEE5WD6SoDfgE+GlPQm0afCVl6mbEn55/C/D8EI3c//MdTwNrL8wDobCiu9PCB6oH5vC
         dNUzizv2mPep+qGkHtvKgW0yr7/rO7Tah5oCe0iSff8hzJidweBO3XpcDvjqlITn6BNQ
         jB508vWvX9lNa02e89GcobLgpmdPEAPwftPC2OsZeO2ITnqU/ThGJEogHmmDMxB3VTFe
         a3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726087359; x=1726692159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Mm6F1KdfaC470dFwf81yhaZh6FdF3AX9IDG0p0k3Sc=;
        b=UovTb1bKFh/Fdc4ycb9j1vIKhqS/h6YUBe84OJNfcuf585kCZtBTySHJX2KumWLs8s
         /UqsNG04hB13u3lSmWjAAx/5Wlg6lrDij3XbZ4Ndt9ZfDpK8PHxDgZnm34McqHfd3pXf
         PoTJKLqirac1VCX5tSaCyGTPCgpQOdYhk0O9smEdRGUA2gFBSChekl6yQMmBWgrlhfkJ
         JY4X86niQ3FbstFUhwa2yXlMI+6AIJ2yTbqIvI1cc2aoYeF3aVbrYxXQX+znBrO8ZoIB
         p5P62Zy/D/7oN7gBjJiNYfIoILFDF8ahaVoyBp8pIleKSN+wI5ukfxLaFP4XwdlACTkS
         zJAA==
X-Forwarded-Encrypted: i=1; AJvYcCUPG9nWD/HoRp7AyuKmHts4jdtah6HVf2wfxkJBk4SQ8CgcDO45INxRQWTpQ5ECCwKWHDd9i585IiHZm5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsePx9+p/CV4CyU+9U8m/IYeKbVBQJ4kra/uEpWmrKQE87gCHb
	4ZfzJYfKn2M0x070VsprMP+4BcpnwtlT3XJsReaDjWaY2TZbjY+jdPtP/uiVYIy7SY+KJYnNxBj
	LdQ==
X-Google-Smtp-Source: AGHT+IH2JHcNsNqRshbivfFJlAxw7IQtkbHmI9wZd8VBGGSLJ0WTJqdKfu0VETV264VsvIEa8GzsVh026XU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:4a5:b0:7db:18fc:3068 with SMTP id
 41be03b00d2f7-7db205d627emr1361a12.5.1726087359304; Wed, 11 Sep 2024 13:42:39
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Sep 2024 13:41:54 -0700
In-Reply-To: <20240911204158.2034295-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911204158.2034295-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911204158.2034295-10-seanjc@google.com>
Subject: [PATCH v2 09/13] KVM: selftests: Enable mmu_stress_test on arm64
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Enable the mmu_stress_test on arm64.  The intent was to enable the test
across all architectures when it was first added, but a few goofs made it
unrunnable on !x86.  Now that those goofs are fixed, at least for arm64,
enable the test.

Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 93d6e2596b3e..5150fad7a8c0 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -174,6 +174,7 @@ TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_aarch64 += kvm_page_table_test
 TEST_GEN_PROGS_aarch64 += memslot_modification_stress_test
 TEST_GEN_PROGS_aarch64 += memslot_perf_test
+TEST_GEN_PROGS_aarch64 += mmu_stress_test
 TEST_GEN_PROGS_aarch64 += rseq_test
 TEST_GEN_PROGS_aarch64 += set_memory_region_test
 TEST_GEN_PROGS_aarch64 += steal_time
-- 
2.46.0.598.g6f2099f65c-goog


