Return-Path: <linux-kernel+bounces-281499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2948194D787
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A718DB20E67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44925169397;
	Fri,  9 Aug 2024 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="voYt1Ial"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AD41662FE
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232625; cv=none; b=p1A7RzGzYSxObY0B/sBooEtDKc1a+AWl0Qz4nJzEUA/n8ByRmlqGtlYKvtNTshTc6qw6zlNGo27DzQuyGMKTu8PNrsq1Piy9gRm0WCIBH/T7k8ua9idqbE9INKY4VjJQYteq+BhA7HWOxncXAPjxzSp2lPsac5om33kXq7FVBCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232625; c=relaxed/simple;
	bh=ht4r0fbuo5n7i8loKFQk+Ce1717qM4Ak8JQynsJUkR0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g7zRfYaaJL2mPkMu5f8BeE9GvR29kmOiEUbJa6c4lXX+wOyXqdE5LjaYiHOMRLaHUJOnIJ5T0NJJTecE8VEoYAnCuZb8s5awyNKFMP4uRViUwF6SW0qTaMkIf7Dn2qrZA722zxr3eczSzBSfWAjIqNspBczM3Om9qzOK0sxbRTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=voYt1Ial; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0be470f76bso4061835276.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723232623; x=1723837423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=D+L1OtzzgTK4mUsnsbZ07IxjRBCo4OaeWvC+DT5ZIuI=;
        b=voYt1Ialpznoltp+hT0r4u1JwjHZY1y6xSPgveyofeQ5rOrSTAn9PM/SZUcxvf3mXa
         OwXnZBTpRwL9oVbaed1gH8oLH6gs1OmqFrgbu3PXhfYmedF5wsmXxZxRivSHNJwhg4mu
         4aFkpsfbQwmVBD3B1orVO6Bfu83R8oe3vGrxeggaz58ewESOpmAObo9dL1Sh5bpw1Rv0
         aYN0SBcOHO/oyROXa9T4r95ujEyIV69d3UeGRvvnx0kLqaaBh5626FSYDX8YTv7UGFCX
         0XWFUOAOTycrBthgxv/mHQJgwWfvi9b/u9Daw7Cp3hvxj+3EU4wZpcNaWd6HnHxWfjSY
         T7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232623; x=1723837423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+L1OtzzgTK4mUsnsbZ07IxjRBCo4OaeWvC+DT5ZIuI=;
        b=cqIYtM+1YleFPvHBYwSJhn5eBaPEIwwU26Bo2mlsp+vkJhrqA9Xh3eXbZFPm2buTOl
         2CRrnDEYIyHMqA2VQd1PFhiXcxvZ3BI+VA/KJeCWG/lM5Noo9JcinFL0I7ozRwH/Nl24
         n7SXHZmbSxuvMXhpib79G5V97JeS1mmUxFasJlblX/kFiOJVdm2nS4gUyUp6pZjL97aG
         uylZG8QTgDcZyFIQbK8WtjxaSTcuIVH8psUJcKdHlm0PKLSGm06N+6fgt5hnK2q3zsg4
         aJUmptQB1FCCj+NDtyR3xcDHDDeTEjSK1FInZ+FC5zw55cOb6mvI8kilY3egkg0lnQgB
         1vLw==
X-Forwarded-Encrypted: i=1; AJvYcCVN5dzThQdhC3Wly/xW0rA5TnNesVYDRTv397q9bkmFDf9T20xCvTpUmlKzOEhbA0mHUQRy1KzXr8tP+BZTGgkdA63wais+p1WPNu5D
X-Gm-Message-State: AOJu0YwbDrNmaFA63dAKMsYsA6sw5PbY4ynZ8oEWUjRkJP6ZFLT6xra/
	xuEyMWgAjI9cXtkIqY/zPAKR5eoFgizLQlPaLktmWQwabRtKavw0jUhvxSjghtU+KtAf3MvSVVY
	/lg==
X-Google-Smtp-Source: AGHT+IEKeKIaPW8YLP4xWw2FBfo2QHuCebzeo0dHE5fX5nmyiW5fDNnzekf775+ZUqeRP6mPt7GOOOJZQOw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:f0a:b0:e08:6c33:7334 with SMTP id
 3f1490d57ef6-e0eb9a10ac7mr19255276.8.1723232622954; Fri, 09 Aug 2024 12:43:42
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:43:14 -0700
In-Reply-To: <20240809194335.1726916-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809194335.1726916-3-seanjc@google.com>
Subject: [PATCH 02/22] KVM: selftests: Rename max_guest_memory_test to mmu_stress_test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename max_guest_memory_test to mmu_stress_test so that the name isn't
horribly misleading when future changes extend the test to verify things
like mprotect() interactions, and because the test is useful even when its
configured to populate far less than the maximum amount of guest memory.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile                            | 2 +-
 .../kvm/{max_guest_memory_test.c => mmu_stress_test.c}          | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/kvm/{max_guest_memory_test.c => mmu_stress_test.c} (100%)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index b084ba2262a0..cc25f19b62da 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -138,7 +138,7 @@ TEST_GEN_PROGS_x86_64 += guest_print_test
 TEST_GEN_PROGS_x86_64 += hardware_disable_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_x86_64 += kvm_page_table_test
-TEST_GEN_PROGS_x86_64 += max_guest_memory_test
+TEST_GEN_PROGS_x86_64 += mmu_stress_test
 TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
 TEST_GEN_PROGS_x86_64 += memslot_perf_test
 TEST_GEN_PROGS_x86_64 += rseq_test
diff --git a/tools/testing/selftests/kvm/max_guest_memory_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
similarity index 100%
rename from tools/testing/selftests/kvm/max_guest_memory_test.c
rename to tools/testing/selftests/kvm/mmu_stress_test.c
-- 
2.46.0.76.ge559c4bf1a-goog


