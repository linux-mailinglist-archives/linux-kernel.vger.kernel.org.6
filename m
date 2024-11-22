Return-Path: <linux-kernel+bounces-418736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 091949D64D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA135B21E86
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 20:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3AD185B7B;
	Fri, 22 Nov 2024 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HXYv6hyB"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8B183CD5
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732307029; cv=none; b=eF6IZ5LS+7gYPs0jgK2NtyTUvS+Cz43o9R0SdEYPgDq4Mt/DaSkCSbDKP0RE03XIp4uSwtYdOQ4cHsrn0H2sW65zHh+uwn9fzEm/GRttrtkqT7j8cjPkaAH2BiyR8zZMMJYEBrQORB9qISF7y4LUx59D8GejyduakL9XKdK7+00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732307029; c=relaxed/simple;
	bh=wj7XC8Ez6cCJRJw6pmUFCOa1cTS03sRVxyKXqSIFc0A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IpBpeqwfMQNhyLQtlTM8EWJqehG9MJYB7VI08Al93HCf6M7g4aWY+UJc/geXDsjsuSgkgZGOzhoWPKMc1n5hKeQq3WW4kDPTLt4CV+S+AcCiC+xVNqcitXmklpflZTpW6xpuAWPQehgSqsjwHbpwHgyH9Xp0wzryKsUKgjCmc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HXYv6hyB; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-83a9bd80875so258186539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732307027; x=1732911827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wAvtorLGZx/ko8b438WYo5+MNdJYJiGYAvo9sCnf2Dk=;
        b=HXYv6hyBDFssWjaTZvX1JKMdWTFVaZzHM3xC9UHY4FcFRMT0nws3CM/WMi6+qjjacA
         0oInsGgqyeuF5addaxQ1RFYFmmKwPv9rfHOWmil1DRf1WYgveFCu4FJwjNqQO1PZ75Bo
         lu/TLpzRCnu9qUMTAZyGtZN/OE+zr4+U9Ybz9IdMQ3+mplzLwDHIogxMfuEuQXYSH28H
         uO4pyBgjDLmGOFRH9enFogQb/ngy2vC9mpAT44CAUTwPvajjCBU4m7JKiSjWyLZpSi9J
         4+oUf2urkJoZa+tOMj4H6HrImj8ouAkEjA7J0lCNlks1b6BtUAnLPqkc6KZ0bD971RCu
         0GMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732307027; x=1732911827;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAvtorLGZx/ko8b438WYo5+MNdJYJiGYAvo9sCnf2Dk=;
        b=J6IeG/FEBSS7VXZnZ6hZtjhX7QA8wCef6LTvy9wkIIpXq0LUwLKaHMp9btm+ULkv8i
         irn7hbdBK2VUz/028Uh+sMQ8oKwL8Q0zEZAfFx5juICoN8nrLHV28cqu3z7sAE2IgBn5
         0TH7oZt2vuMrIiHbWy9ygeSOCRpOzzGQOb5gbMMrFjc5OnXzwX256oXiTXJ+W+N+POGV
         8gGebj67P+T+blKmtKiKuGZxoYeYBxvgxUypASiHaVMea4ZmDGN3dKridpuBNGJVefHn
         x34uoSc7jX7RC1Yr7p0nqiijeXVIJ7dKDagNsjBI2SBhjt0CA/4m3cEro6iFOyEAG1my
         f3IQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/KmmU+jZOLa//TTvdN+h2L+tLD+dCQYVFDwicjVoPc0Te4fGmG0evDWsPI509YAwqXWYdmIr8ncEJpo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywob4idI0xvHk3tC9xqrIjZFimqlz9RdCTK3X7HEeltHb1KDL2l
	iZb5V6UBR6dKEwqlsJnz14bM0/NIo7hvensylo+i0o4lf3rfMX4uexqlJGNM/SaoGVbfJm507Wh
	LeGHamBsE4l3KQHPK78pMI6NO8Ereyg==
X-Google-Smtp-Source: AGHT+IFGfGyQ/kG0DjXGx2MTm0uZZBFfTrQdjVPbwPi4ifMA2Fyavhcy39JEKlfPhY46pkaQNMH4oWL2136ugsGNyLER
X-Received: from loughlin00.c.googlers.com ([fda3:e722:ac3:cc00:ba:c019:ac11:dac1])
 (user=kevinloughlin job=sendgmr) by 2002:a02:c656:0:b0:4e1:dc53:cfd4 with
 SMTP id 8926c6da1cb9f-4e1dc53d481mr4059173.6.1732307026503; Fri, 22 Nov 2024
 12:23:46 -0800 (PST)
Date: Fri, 22 Nov 2024 20:23:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241122202322.977678-1-kevinloughlin@google.com>
Subject: [PATCH v2] x86/sev: Add missing RIP_REL_REF() invocations during sme_enable()
From: Kevin Loughlin <kevinloughlin@google.com>
To: ardb@kernel.org
Cc: ardb+git@google.com, bp@alien8.de, kevinloughlin@google.com, 
	kirill.shutemov@linux.intel.com, sidtelang@google.com, pgonda@google.com, 
	thomas.lendacky@amd.com, x86@kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

commit 1c811d403afd ("x86/sev: Fix position dependent variable
references in startup code") introduced RIP_REL_REF() to force RIP-
relative accesses to global variables, as needed to prevent crashes
during early SEV/SME startup code. For completeness, RIP_REL_REF()
should be used with additional variables during sme_enable() [0].
Access these vars with RIP_REL_REF() to prevent problem reoccurence.

[0] https://lore.kernel.org/all/CAMj1kXHnA0fJu6zh634=fbJswp59kSRAbhW+ubDGj1+NYwZJ-Q@mail.gmail.com/

Fixes: 1c811d403afd ("x86/sev: Fix position dependent variable references in startup code")
Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---

v1 -> v2: Fix typo in commit message, add Ard's and Tom's "Reviewed-by"

 arch/x86/mm/mem_encrypt_identity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index e6c7686f443a..9fce5b87b8c5 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -565,7 +565,7 @@ void __head sme_enable(struct boot_params *bp)
 	}
 
 	RIP_REL_REF(sme_me_mask) = me_mask;
-	physical_mask &= ~me_mask;
-	cc_vendor = CC_VENDOR_AMD;
+	RIP_REL_REF(physical_mask) &= ~me_mask;
+	RIP_REL_REF(cc_vendor) = CC_VENDOR_AMD;
 	cc_set_mask(me_mask);
 }
-- 
2.47.0.371.ga323438b13-goog


