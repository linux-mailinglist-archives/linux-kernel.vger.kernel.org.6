Return-Path: <linux-kernel+bounces-223279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E5B9110CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E22CCB23BA2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33991BA095;
	Thu, 20 Jun 2024 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="St2w1jjR"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EDA2230F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907205; cv=none; b=Z/nDS9X7z32mlhBYslTc0JsaWrIMlOTgtQVanf9pbwR0IJ068gGUOhJVGn+i9LU53Y50Jw0egoaUFL8oTbo+rzpeAJImidLDmQ2+Cg9ZwkP6tXlnbYnLToE65vGBy62XsMZrgabZJ+eSEZqQ1ruuZqMsYbjG7265GAIhOccythA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907205; c=relaxed/simple;
	bh=EkQ74mIuZ5fmAIpUTCR52YETFKCZ1LkD1Q4d79bF9gI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y95tshEBeovZhh3AkZrSgxG9ShvR58Qyslk8pf7apKEoDsRG1MrZwk2Vc/Sx00VUKEnapBPorCsxRdNh6ipCG42w16cUl7jH9rTFq6u1rEY2q8rTNCTG3Vkdum7r4xWWY34w0kA/mecHQymNf7nEdiJYZRlgkk3nquVVD43sSqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=St2w1jjR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6338f71a577so22021427b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718907202; x=1719512002; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YMf6bHWa3WYlKn5BTDJ8mzHqJJrcfbUTWWG9rzjzXEI=;
        b=St2w1jjRjO4uZZSFZ9k4T5xNJnYnC+c/kYAw3sdPqGE7OFISQl6Aeg0J3JllT9fAvn
         aJhC3UfH0Q1U4+dOf99osMmDpxXoF4wbiJ8fUxCs8R8d8F1XYR0np+qrkRskBXDlofm3
         KNH5BNsweARlm0q8n/ge/ZjAx5GKumcplAbD43HXsrilidl4kXY0nOwjR/CiVO83vMYF
         a8bO+UeMXPWrtUkOpcb70+gUUpHwDcrQ2JwR4C7Vc3M5QZtPoOS2jxGMfrRlFGt4AOfN
         YrTIoXDio0DboFDIcLb51KxjsRkoDHpmEk0QLZAWGibUA5sSl1/Ga+3QPha1/wnDM5Uk
         srHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718907202; x=1719512002;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMf6bHWa3WYlKn5BTDJ8mzHqJJrcfbUTWWG9rzjzXEI=;
        b=RZw/Gkh+B6yaDnPKEvEa47yoZhTxfaEJxyTTDXSr6iCfdwHA3kK+qXmmZqRw4Os7b2
         kWwaz62J/eWJ6yKjlUk4YHennalARNVoCqx7khvmdFlbCzd3J4cy7i/ZS1zLvWrJyr2P
         Ws2lS54Ip7OyWS16YJkwzfUELHsGscC2lxJ+GFJO3jmqp1QP/e9dBHbZnHvy9TBs6ED6
         iRKdP8rTzKKExdkrUkiwOPnySWIegOoH051w5+xIZFdnHgqLztcoNCK/A+b6awd13Ol5
         rn19pYCgLM7d12Tjp56k1oWc9rQc9/FKcdSGjgqgg3xImmFD06tStuXf8cKU42M0AsJN
         ZdQA==
X-Forwarded-Encrypted: i=1; AJvYcCUFUa+Pyjf92kp/rArcWqQiZEjqZyuMq1E+wyvQGAymuOzFgME24lmxcI3U2irEd/Etv2M7z5NckE38e+GmbH8xIj+bdGaAhunpoPkV
X-Gm-Message-State: AOJu0YytBxOZMknqT54NkkXRgtLOuaW7CGbatUSvvAiHmUlLCgYYPZfu
	Tlq8Kg4XBmtxuhRVsuIPXcrx7QieZfIIsmLxX5fLjWI+vePtXHBSfn6zIbEIUtLtIj2i+DE3i7Z
	2ZQ==
X-Google-Smtp-Source: AGHT+IHj65srhREZE1E3IcSiXfDYLsTilyE3EaAXWu2gQuzsizOP8c6SaYdY5Ud/AiA3ZvB3NTHF6q9xvZ8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:fc5:b0:62d:48f:30e8 with SMTP id
 00721157ae682-63a8dc09c71mr14779407b3.1.1718907202341; Thu, 20 Jun 2024
 11:13:22 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:13:21 -0700
In-Reply-To: <20240619182128.4131355-3-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240619182128.4131355-1-dapeng1.mi@linux.intel.com> <20240619182128.4131355-3-dapeng1.mi@linux.intel.com>
Message-ID: <ZnRxQSG_wnZma3H9@google.com>
Subject: Re: [PATCH 2/2] selftests: kvm: Reduce verbosity of "Random seed" messages
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Like Xu <like.xu.linux@gmail.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 20, 2024, Dapeng Mi wrote:
> Huge number of "Random seed:" messages are printed when running
> pmu_counters_test. It leads to the regular test output is totally
> flooded by these over-verbose messages.
> 
> Downgrade "Random seed" message printing level to debug and prevent it
> to be printed in normal case.

I completely agree this is annoying, but the whole point of printing the seed is
so that the seed is automatically captured if a test fails, e.g. so that the
failure can be reproduced if it is dependent on some random decision.

Rather than simply hiding the message, what if print the seed if and only if it
changes?

--
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 20 Jun 2024 10:29:53 -0700
Subject: [PATCH] KVM: selftests: Print the seed for the guest pRNG iff it has
 changed

Print the guest's random seed during VM creation if and only if the seed
has changed since the seed was last printed.  The vast majority of tests,
if not all tests at this point, set the seed during test initialization
and never change the seed, i.e. printing it every time a VM is created is
useless noise.

Snapshot and print the seed during early selftest init to play nice with
tests that use the kselftests harness, at the cost of printing an unused
seed for tests that change the seed during test-specific initialization,
e.g. dirty_log_perf_test.  The kselftests harness runs each testcase in a
separate process that is forked from the original process before creating
each testcase's VM, i.e. waiting until first VM creation will result in
the seed being printed by each testcase despite it never changing.  And
long term, the hope/goal is that setting the seed will be handled by the
core framework, i.e. that the dirty_log_perf_test wart will naturally go
away.

Reported-by: Yi Lai <yi1.lai@intel.com>
Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index ad00e4761886..56b170b725b3 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -21,6 +21,7 @@
 
 uint32_t guest_random_seed;
 struct guest_random_state guest_rng;
+static uint32_t last_guest_seed;
 
 static int vcpu_mmap_sz(void);
 
@@ -434,7 +435,10 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 	slot0 = memslot2region(vm, 0);
 	ucall_init(vm, slot0->region.guest_phys_addr + slot0->region.memory_size);
 
-	pr_info("Random seed: 0x%x\n", guest_random_seed);
+	if (guest_random_seed != last_guest_seed) {
+		pr_info("Random seed: 0x%x\n", guest_random_seed);
+		last_guest_seed = guest_random_seed;
+	}
 	guest_rng = new_guest_random_state(guest_random_seed);
 	sync_global_to_guest(vm, guest_rng);
 
@@ -2319,7 +2323,8 @@ void __attribute((constructor)) kvm_selftest_init(void)
 	/* Tell stdout not to buffer its content. */
 	setbuf(stdout, NULL);
 
-	guest_random_seed = random();
+	guest_random_seed = last_guest_seed = random();
+	pr_info("Random seed: 0x%x\n", guest_random_seed);
 
 	kvm_selftest_arch_init();
 }

base-commit: c81b138d5075c6f5ba3419ac1d2a2e7047719c14
-- 

