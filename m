Return-Path: <linux-kernel+bounces-219584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424A290D4F7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2352E290976
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37904154BE5;
	Tue, 18 Jun 2024 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxOGMpVp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3D6A33F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719528; cv=none; b=CBOYIFHlDICgm5jv0RS/X2PbaaM5iESwGJloMO/lBwzqcJgW8ls1zxtxQ41iP8uGieTX1J7JjD+uhXppChWwK3FAtABkNVLcjDaTqS2mRVE47Gafim9W4vF73uTV13Y9Ta1MvZgZga4fa9YggM8LH/eToc7H5aci9ezvTodLedU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719528; c=relaxed/simple;
	bh=voUsZu4+P8cVPFpKsisVJUT4+hz+waGqy6KYjg3O6XU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KYdBYOJV4el4M+2spil2Q9prcmBJbkBbRQHtcrc7xEVhBHVeHUX7ZBKEHthBfJMoy6MxB7VFnOdLbFHS/bYICezHGdD+Sunp+EwZWqoyDkWx0hA2DRI1Un7RbFUDDk0UzqNXx3B0ebacA5mhUYlQk24coMBdV19ZO5JDIRxH7Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxOGMpVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009C4C3277B;
	Tue, 18 Jun 2024 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718719528;
	bh=voUsZu4+P8cVPFpKsisVJUT4+hz+waGqy6KYjg3O6XU=;
	h=From:Date:Subject:To:Cc:From;
	b=cxOGMpVp/uVKJnoBTxmmDq2a6L/KRzgLcPVWECOqziTVSLE+nRbXhcH/AT0tLUBAL
	 h8M+t8rVGsu8JTdLjCfELjM/CzKgBHKxCvYmI2bfD+JMeNZ768pBdPwU98mA8K+Trc
	 MkOAy2yvom4y8ztPyhdVRNFC2/Pmgbj4211Fgfgq3tOLIXdLE9WiRnxyEO7RDdegMK
	 jH1z48fF8GyzDdj/CXR8K7yfkqq4hxCvYe9vhSqaW2mXyJL+vjEihAvZJFlrOANh/z
	 Bt1IliRmBX2PC+sciovs5QCGWdUkTGjqDPrd7ioA/goFd8WASSJjezoNVAqPPsT5rh
	 /l4pOUdrKc/Ow==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 18 Jun 2024 15:03:50 +0100
Subject: [PATCH] arm64/fpsimd: Ensure that offlined CPUs are not using SME
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-arm64-fpsimd-sme-cpu-die-v1-1-9a90d1a34918@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMWTcWYC/x3MMQqAMAxA0atIZgM1qAWvIg7SppqhWhoUQXp3i
 +Mb/n9BOQsrTM0LmW9ROY+Krm3A7euxMYqvBjLUm7GzuOY49hiSSvSokdGlC70wDpbM4GwgMgw
 1T5mDPP96Xkr5AByMX9FqAAAA
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=broonie@kernel.org;
 h=from:subject:message-id; bh=voUsZu4+P8cVPFpKsisVJUT4+hz+waGqy6KYjg3O6XU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmcZQlOfUtP8GynkL5ciAZnGDT43rip612ZKqNulU0
 2D9L3f2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZnGUJQAKCRAk1otyXVSH0HPIB/
 9qFQFzf6Kv8FGh2lCNWkw7r022T8RQMu2t56+VvJjGjE2R/wZjzeH1OCrQ5jXScZMqonk5JJ2burg+
 MkRKiHfE2oRNicvBkgdbqpSxyJKIvamJdv/TOOBastjQHzZLKMyKiVqNJwYFzFUOzY3HgE2qmlLrnM
 boRTkBuo7GDIIC1zFfKPrxAIqAAseWscgpuoKdl9qtSjhk11w+/lNDh8XsZoPPOn2MtUyWYXXGMrRC
 1Ykk3oOzJBy9lVsgbcDgPod3xwjWn7XxLU4rnuizGmoCOXfl4yGk8U/il+2CzvBrqXN60yq9DK3Jne
 ItSqnzNlEni1RNRPQE6WNz8NA6tZLx
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When we use CPU hotplug to offline a CPU we may transition directly from
running a task which was using SME to the CPU being offlined. This means
that PSTATE.{SM,ZA} may still be set, indicating to the system that SME is
still in use. This could create contention with other still running CPUs if
the system uses shared SMCUs.

For most systems this shouldn't be an issue, we should have PSCI or some
other power management mechanism which will take care of this as part of
offlining the CPU. However we do still have support for spin tables, and it
is possible that system firmware may not be ideally implemented, so let's
explicitly disable SME during the process of offlining the CPU in order to
ensure there's no spurious contention.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/smp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 31c8b3094dd7..9e8fc6ac758a 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -383,6 +383,10 @@ void __noreturn cpu_die(void)
 	/* Tell cpuhp_bp_sync_dead() that this CPU is now safe to dispose of */
 	cpuhp_ap_report_dead();
 
+	/* Ensure we are not spuriously contending any SMCU */
+	if (system_supports_sme())
+		sme_smstop();
+
 	/*
 	 * Actually shutdown the CPU. This must never fail. The specific hotplug
 	 * mechanism must perform all required cache maintenance to ensure that

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240617-arm64-fpsimd-sme-cpu-die-57205c7f220e

Best regards,
-- 
Mark Brown <broonie@kernel.org>


