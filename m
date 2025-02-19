Return-Path: <linux-kernel+bounces-522583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB21A3CC10
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B61189B9AF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5DE25A339;
	Wed, 19 Feb 2025 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ohGtOh2i"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDE025A2A4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002930; cv=none; b=cLz1fdvM9Kw2lX5q1GvxCAFLRC5ms3Og4yxvJEm3bnoZxoeETQyGBH49KvYnY8Jk3Gn7pMiSRvkENIXxegfAm5zC/nilI5GdGd/S5Gm1CbEBh0CR6dsV+HcQnvnSmZBowT3okC9wSsyYXuLEfp49YnceFXEGx/YxTu1awhPQQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002930; c=relaxed/simple;
	bh=3Nii0phnNkecAu8xGxA4EPtRghqb3/w3q9uqtdzosNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Po5JkONRz4fyPPZ4bGsPF17unv19E9h6+X9peV9ua1kd2gdcuMZCTpO/boZ7bXVZyDT3k3RD3VPaEuJFXXkUVWJuN5AWekkCmB1xDxOrZKwv+Hwf1EYD+3wPHVXgPb9d4u8U9hDlmGQ9N3vt7bu7J5pgURkku6yPSP1i+Ug+DbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ohGtOh2i; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740002926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U34hNLBdTqtmX4109b7R2GaLljBxKsHbz31GdNFcKwE=;
	b=ohGtOh2ibiHCAS4Uc/bqxPICxCf1Jeen5MbQsQM29rZoqHxZBqkK9/Y1tupxZrnmjJ7RcK
	ASomJ8bPnv8uNiKKXPlCFYr0glo4FGJNXXkXf74KY+voFT4K70B2iKgOGFQeVWUYA7/VIe
	sTTwlhVlkcToeZGY2O4DMBU3hsZ0TBc=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] x86/bugs: Remove the X86_FEATURE_USE_IBPB check in ib_prctl_set()
Date: Wed, 19 Feb 2025 22:08:23 +0000
Message-ID: <20250219220826.2453186-4-yosry.ahmed@linux.dev>
In-Reply-To: <20250219220826.2453186-1-yosry.ahmed@linux.dev>
References: <20250219220826.2453186-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If X86_FEATURE_USE_IBPB is not set, then both spectre_v2_user_ibpb and
spectre_v2_user_stibp are set to SPECTRE_V2_USER_NONE in
spectre_v2_user_select_mitigation(). Since ib_prctl_set() already checks
for this before performing the IBPB, the X86_FEATURE_USE_IBPB check is
redundant. Remove it.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index fc7ce7a2fc495..a5d0998d76049 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2272,7 +2272,7 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 		if (ctrl == PR_SPEC_FORCE_DISABLE)
 			task_set_spec_ib_force_disable(task);
 		task_update_spec_tif(task);
-		if (task == current && cpu_feature_enabled(X86_FEATURE_USE_IBPB))
+		if (task == current)
 			indirect_branch_prediction_barrier();
 		break;
 	default:
-- 
2.48.1.601.g30ceb7b040-goog


