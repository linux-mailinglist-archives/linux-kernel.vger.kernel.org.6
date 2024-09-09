Return-Path: <linux-kernel+bounces-321938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD10797217F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8957128359B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DBE158521;
	Mon,  9 Sep 2024 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5iGktuw"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBEF364CD
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904942; cv=none; b=QcfWGgqF+zz70fEJtFnV21Mr4oqGCGlJfUY5lRGUHynCJeE76KbbQKbuKS0unbVL2x1rlCFO6ayd0OD36l0klCBSDUeX7lnS3snYkr0s0vN27K78SWkVJ23EXjAeWDVyD2z/+rK0j4ZpXU4444AyMCkFJujdw9TuDa1FlYvD3pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904942; c=relaxed/simple;
	bh=m/wGZi8BcTf1EOpqGRqnWjiKZB6QmIMK4V1d+BMQEsk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r3Mo5sI8K8Sfx0dVc5+VGxB/nKfMCmFUjqLYB45nCQB1zXXiuN3i0oORsl1xn4VUuizB3CLCNd0zrju7OIeEoKhwbM6Jf2pFG+STxqW1SVU+CAWHw1PBRSsVW0a7GX+PJbUFKrMVnd8BhGZqYNM1+EyI8xmrw7GFXlzRa0n0n98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--snehalreddy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n5iGktuw; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--snehalreddy.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6db791c41daso43094907b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725904939; x=1726509739; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4GzdOAnXsu8VayoX45huUrzJ6QMBoTAjQVvSrXaAbFE=;
        b=n5iGktuwmsrYcUtfdii+78dIct02mmwAbl3XiuBUxAhIGgiolW5uemJd84NcXxJVJL
         g8CE0NrADn79BYtrnZLSh/3zgRRM+XvVGyx/5fjigX4LS7MYugk3hkEVV/96jltR4e7b
         gzZ73kleJaHnWbPYznbxVAKkwHwhQWPT59vbcJDavurdhsz3uQ+wsz3ECEfpUmg/fbu6
         8ixwo87PgZOwUcQYUMFlB8aRAhygYm6Vl0d3eMcvSecF8mu/FtNn3IMWioaKes6kjII7
         efnmoRAB0eMGsu9jHAL3HvFJqPQxxnzo3+rI7LHiksw4SE/azclFALInFta/y/pHn9il
         1eTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725904939; x=1726509739;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4GzdOAnXsu8VayoX45huUrzJ6QMBoTAjQVvSrXaAbFE=;
        b=s5y9HE2YzGuoT7+Cvgz8QEk6twh7sfh+pSZiCNdgjaAi2sN7aXYDCPW0wcRNSVyoOT
         tD0LtCV4b8zO/2aO9u6PfP191CteLrbmdfvWdDus8pyZ2Lbo8TzVyszvG3YbbC/TXbHj
         3nhQWZW8HmkfpLkTrOkUwjj4SHAQgkxj6aUsVt7fXVA2w3iK7R1QvIAa/Lo3BX80I/3Z
         HX+lT7fG+h/iZigtJQbEUeA5fk4QIcYc/FwQ9FEmeKLPfc1S80ie4mNAqxrCetlJaHBQ
         Mzws8GGEG3AIj+ca66k0UGMa2OCd2KlEsCSRiSQ7yo8pMFhniL/areMuudSPjcSPDrQN
         gtqw==
X-Forwarded-Encrypted: i=1; AJvYcCXxnhAj37Zp0LfdOMYLF2nyK1TSrgIX7MfOSTi6JhzMWFR4X4inqXeCtlmDrye5abMBoKMHBCrkNkDScuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyqNpKBabliCffCmzjUWfKv6rtPZPoWpqM8iKf4W6K0jCk4XQN
	ySWHELE7jxh1Wfcmm777CR8R9ptTJSBZS53rkAGA25aXyVn2Mb/2cpwnJoRQINegUwoXagMN0Y1
	S3qBr+onLXgB/JQ02Ju5JOg==
X-Google-Smtp-Source: AGHT+IFAuTEL+1ahwEy/aM3fSi5ne7wxws+pnvSGN+IlqZz9OjmkUToSqSs13gvLLdON+5TO44ygwJ2bXIpXxfgvnA==
X-Received: from snehalreddy-1.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:c1f])
 (user=snehalreddy job=sendgmr) by 2002:a25:680b:0:b0:e0b:958a:3344 with SMTP
 id 3f1490d57ef6-e1d34a3abb7mr28584276.10.1725904939453; Mon, 09 Sep 2024
 11:02:19 -0700 (PDT)
Date: Mon,  9 Sep 2024 18:01:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240909180154.3267939-1-snehalreddy@google.com>
Subject: [PATCH v3] KVM: arm64: Add memory length checks and remove inline in do_ffa_mem_xfer
From: Snehal Koukuntla <snehalreddy@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Sebastian Ene <sebastianene@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Snehal <snehalreddy@google.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When we share memory through FF-A and the description of the buffers
exceeds the size of the mapped buffer, the fragmentation API is used.
The fragmentation API allows specifying chunks of descriptors in subsequent
FF-A fragment calls and no upper limit has been established for this.
The entire memory region transferred is identified by a handle which can be
used to reclaim the transferred memory.
To be able to reclaim the memory, the description of the buffers has to fit
in the ffa_desc_buf.
Add a bounds check on the FF-A sharing path to prevent the memory reclaim
from failing.

Also do_ffa_mem_xfer() does not need __always_inline

Fixes: 634d90cf0ac65 ("KVM: arm64: Handle FFA_MEM_LEND calls from the host")
Cc: stable@vger.kernel.org
Reviewed-by: Sebastian Ene <sebastianene@google.com>
Signed-off-by: Snehal Koukuntla <snehalreddy@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index e715c157c2c4..637425f63fd1 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -426,7 +426,7 @@ static void do_ffa_mem_frag_tx(struct arm_smccc_res *res,
 	return;
 }
 
-static __always_inline void do_ffa_mem_xfer(const u64 func_id,
+static void do_ffa_mem_xfer(const u64 func_id,
 					    struct arm_smccc_res *res,
 					    struct kvm_cpu_context *ctxt)
 {
@@ -461,6 +461,11 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
 		goto out_unlock;
 	}
 
+	if (len > ffa_desc_buf.len) {
+		ret = FFA_RET_NO_MEMORY;
+		goto out_unlock;
+	}
+
 	buf = hyp_buffers.tx;
 	memcpy(buf, host_buffers.tx, fraglen);
 
-- 
2.46.0.598.g6f2099f65c-goog


