Return-Path: <linux-kernel+bounces-441757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EF39ED3AA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72AD281E83
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B351FF1C6;
	Wed, 11 Dec 2024 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUfGzhSO"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD51FF1C2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938199; cv=none; b=GHIoT8YjH+WfNVM9iIk4kIVZIyQzaTbGK3P1o2fLuJBtYm2TFilkn3lQBSvqc2afc9qBdtF3igBiYnBfEyC9GL5unOBsylxybfj5z561ZA1ZV/3QXBAMVpz+swUYZDamQyHc8wwo3mQpDhwxuNUuZrguyVVEkuLgUuNCNe3Bj+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938199; c=relaxed/simple;
	bh=Lk+Ha5wxFQ+Mh3b1LwsGP/EOGKHkzmqvcnz+ZP8JKUg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rUfnwUynzLrcAOXh2PZmdWlxaJQ/ok+1PJ3fL6cre1/XVzdfTTL9RMFRlNHeej31d4nuK/jyPWtgiu+W2t+ZRb7Wvt+KGTB52dwCi+lkNzNCYBxFxA+nnRtrodacB48t6ThnfjomT7UK1HQbuZpf3HAW1iJ4E76wv4fYyuxujD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUfGzhSO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee36569f4cso7136809a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733938196; x=1734542996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cs2OyeuqVZvLJyvF9hJVcimYDZMHCiD1C4FXtPFGvoo=;
        b=VUfGzhSOBiXl7PhmBtQS7TouC3yLN/c85kiqD38kGl2WfYvYei+T9HUKKLQ508STpg
         bQJqP35zjjctlsoS8X0pd9/cotzJio9esuPESdprzdU0P3puDBl59Vo2BeRfXH699tuh
         aoVpGRQmxYl51XT2Ai+XDktTYA/71e9FnKKeuurcc1b+yK2U/Sd1qERVV5KykOZ4iNwA
         Kz3oBcmyFLqKtblhXB3chw0vd5zqvj5RWiQ2D1AeJwtdhRTLfMcnrSaDT/t9lar6muRU
         PswXS/0p/vWWA2ggadgmZ48bXjvhAbaD+fnCEqW/Dm5fEK+65mJsfBO2sCgkkrtOXVWA
         CG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733938196; x=1734542996;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cs2OyeuqVZvLJyvF9hJVcimYDZMHCiD1C4FXtPFGvoo=;
        b=SvhOcoBNYJ8k5MH29zK+uwqhDZNdU8ULhPvUYHgZBezouHpuVx5YAdFx1LHbw0GWCf
         xAVgT74hgOCK5z3v5s9c5X8ebG8vMuZYpNN0Z4M07qUEj7Rdent9rEoRoTD0cKt9PkCj
         5Ky+LOIBh7/AyWzZ5JaD+J0u/ckgvBU5u6CO3sGUOPiVgMHZOPq5uMXVsgfFx3PcGJ5k
         qJAj2SCAAx3iOOr2RTHC+zZ/D47DkJpYJRNmDXCCfvAeE5sXVWhYVE23bNf6lgw82H6I
         wYPG1pRyWUnqECA28LzJ9n/Mk9H12MaEEMZl/mq1PXphwQtpQd3nMZscIw6yFz6RKvKp
         fuEw==
X-Forwarded-Encrypted: i=1; AJvYcCWxDINPCtVqYxrlZQqsfX5TJqYFWRDVjVrf59ff7O9M+VZKE1zOGz/caiLvu+/lrJTnEWEA/Tn1hynw7/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuihJNnQOO4nBS/Qp/J2jhpyk+4Iu9Zkdw2w4pBgcYeuRqa2p+
	I6nttBJCFPxpjXItYJNP4EFzhQ6DqAOmBWZPMYdUtKo0KWxafpwcmJmasSCw5od4jclDYMONGa3
	cLQ==
X-Google-Smtp-Source: AGHT+IFufc8TXj11zrpajD1CnjIdyF+fE49Tlzc87TuIZTOcSb7mTLdHCVV9hJ4SvHQ7hecMnEHAOzzXzPI=
X-Received: from pjg3.prod.google.com ([2002:a17:90b:3f43:b0:2ef:78ff:bc3b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a8c:b0:2ee:45fe:63b5
 with SMTP id 98e67ed59e1d1-2f1392577ebmr1129021a91.3.1733938196340; Wed, 11
 Dec 2024 09:29:56 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Dec 2024 09:29:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211172952.1477605-1-seanjc@google.com>
Subject: [PATCH] KVM: SVM: Allow guest writes to set MSR_AMD64_DE_CFG bits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Pilkington <simonp.git@mailbox.org>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Drop KVM's arbitrary behavior of making DE_CFG.LFENCE_SERIALIZE read-only
for the guest, as rejecting writes can lead to guest crashes, e.g. Windows
in particular doesn't gracefully handle unexpected #GPs on the WRMSR, and
nothing in the AMD manuals suggests that LFENCE_SERIALIZE is read-only _if
it exists_.

KVM only allows LFENCE_SERIALIZE to be set, by the guest or host, if the
underlying CPU has X86_FEATURE_LFENCE_RDTSC, i.e. if LFENCE is guaranteed
to be serializing.  So if the guest sets LFENCE_SERIALIZE, KVM will provide
the desired/correct behavior without any additional action (the guest's
value is never stuffed into hardware).  And having LFENCE be serializing
even when it's not _required_ to be is a-ok from a functional perspective.

Fixes: 74a0e79df68a ("KVM: SVM: Disallow guest from changing userspace's MSR_AMD64_DE_CFG value")
Fixes: d1d93fa90f1a ("KVM: SVM: Add MSR-based feature support for serializing LFENCE")
Reported-by: Simon Pilkington <simonp.git@mailbox.org>
Closes: https://lore.kernel.org/all/52914da7-a97b-45ad-86a0-affdf8266c61@mailbox.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index dd15cc635655..21dacd312779 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3201,15 +3201,6 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		if (data & ~supported_de_cfg)
 			return 1;
 
-		/*
-		 * Don't let the guest change the host-programmed value.  The
-		 * MSR is very model specific, i.e. contains multiple bits that
-		 * are completely unknown to KVM, and the one bit known to KVM
-		 * is simply a reflection of hardware capabilities.
-		 */
-		if (!msr->host_initiated && data != svm->msr_decfg)
-			return 1;
-
 		svm->msr_decfg = data;
 		break;
 	}

base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
-- 
2.47.0.338.g60cca15819-goog


