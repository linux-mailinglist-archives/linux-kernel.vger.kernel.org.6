Return-Path: <linux-kernel+bounces-440576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2099EC134
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BC528547C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812C171750;
	Wed, 11 Dec 2024 01:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lO96BjeK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31602451D8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733878845; cv=none; b=q2AyWeKeRjjwmTzvwcK3MA4EPWcTU0eBeczKI+me4U2GW9dK+e1axdkoS729/VbQxzcA0ym+hWbHbvCGfPBJF8/Tww8ataQgjaskygT0hkt06nnzuxP8XKMN7WGniJ3X0covS7itI8msgY/hkJiIyDlMVUtTM/k5YeUVmjdAYz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733878845; c=relaxed/simple;
	bh=S2KrLO6QtkHdzcLpymCs+3ItlxNaNyHlYHT19R1x334=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GUE5G1DMxjMI7J4NDRtE/lMfTO+un/7FC/ovFWaof2vlEbT/qJtSHLdo5icDed8NrCoD5LDc2tPAP7Gau+BxQxAaWwr2QP64zXnY8ig0AH4mxGnvM5pnAwL+YsGVoC5I0Vj2ALmAgGrl0MJpq+2CbiINwPUnzktHcy+tUsCyTic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lO96BjeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8E2C4CED6;
	Wed, 11 Dec 2024 01:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733878843;
	bh=S2KrLO6QtkHdzcLpymCs+3ItlxNaNyHlYHT19R1x334=;
	h=From:Date:Subject:To:Cc:From;
	b=lO96BjeKwglqNntC8oSG7K70M0LLd0ZzADVX3mpE+Jk+eUKPE9pUGVMbNOL+klCQB
	 PHJSWL61UZnEVVSEE0U5X4CYCSWl+7OywAtb95/tTZreUxJMQfBYeaV5trSe/vZQjz
	 Dpr+qbotyMhoi/Ej5C2Z/oIc5yS3rxeidcATyi9XquY9p+xJkEcVXW3K8sbaUg4tRW
	 W6WJEeIJzVGn8xNbdoAg9Pu6qofWwxu++hwA7p/oltbXP5joO9n/0Z5tmWR1SJq91W
	 A1oTYBm9Yhmlhi+ZzZJr5IxDCnvRXXQXsNBhbpvhbgH6EXE298i+8VDtEPU+NKlGjW
	 4133+cXtHL7BA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 11 Dec 2024 01:00:35 +0000
Subject: [PATCH v2] arm64/signal: Silence sparse warning storing GCSPR_EL0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-arm64-gcs-signal-sparse-v2-1-c22f37216135@kernel.org>
X-B4-Tracking: v=1; b=H4sIADLkWGcC/3WNQQ6CMBBFr0K6dgytWAor72FY1DItjVjIjCEaw
 t2txK3L95L//ioYKSKLtlgF4RI5TimDOhTCDTYFhNhnFqpUlVRlA5YeuoLgGDiGZEfg2RIjnE/
 eNs72uva1yOuZ0MfXXr52mYfIz4ne+9Eiv/bXlOXf5iJBgtLGmJvrtTfN5Y6UcDxOFES3bdsHW
 h2an78AAAA=
X-Change-ID: 20241209-arm64-gcs-signal-sparse-53fa9cad67f7
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=2368; i=broonie@kernel.org;
 h=from:subject:message-id; bh=S2KrLO6QtkHdzcLpymCs+3ItlxNaNyHlYHT19R1x334=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnWOQ5jmYNkUFGViP2hjZSctb8CrTddTDjgqHe4Iqk
 +MZTDbqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1jkOQAKCRAk1otyXVSH0CfRB/
 wKn7l3wgpGn07pTk+80lOTsWnv+qAhObiFpacjUY7bvoW6NqKvLvSeYu9kujBqMwdOAfV69WFL9qs0
 PG8tkEenKCQ6eTHRn7XGfigWE0iRl9QjB5YKKSw8g0chflnLRtizM8eUT991D97T1rP5pYx3GEe+nb
 Rg5WeHtTrwfwCgxIt6GWMX8jsiU/2BNg+gFHUIesoI538BEqNjzhn0/6tK1nx/3VVYehw6/o+CGiEg
 Kst7yuCugmo5zw9TXCENIdQpvNhfDMvLDySrPA2Ig5w6ANVfdGRQqGx7Jj4YgW/K+Ukwhwt1FHmkYI
 VHNEa+3++QPg/LZC7LWqVqetPcOs+a
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

We are seeing a sparse warning in gcs_restore_signal():

  arch/arm64/kernel/signal.c:1054:9: sparse: sparse: cast removes address space '__user' of expression

when storing the final GCSPR_EL0 value back into the register, caused by
the fact that write_sysreg_s() casts the value it writes to a u64 which
sparse sees as discarding the __userness of the pointer.  Add a __force
cast to tell sparse that this is intentional.

While we're at it also remove spurious casts of the gcspr_el0 value as we
manipulate it which were the result of bitrot as the code was tweaked in
the long period it was out of tree.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412082005.OBJ0BbWs-lkp@intel.com/
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Use __force u64 rather than unsigned long.
- Tweak commit message.
- Link to v1: https://lore.kernel.org/r/20241210-arm64-gcs-signal-sparse-v1-1-26888bcd6f89@kernel.org
---
 arch/arm64/kernel/signal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 14ac6fdb872b9672e4b16a097f1b577aae8dec50..08d51fabdb9d47c848f14c9b25d6be04f109c2ee 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -39,7 +39,7 @@
 #ifdef CONFIG_ARM64_GCS
 #define GCS_SIGNAL_CAP(addr) (((unsigned long)addr) & GCS_CAP_ADDR_MASK)
 
-static bool gcs_signal_cap_valid(u64 addr, u64 val)
+static bool gcs_signal_cap_valid(unsigned long __user *addr, u64 val)
 {
 	return val == GCS_SIGNAL_CAP(addr);
 }
@@ -1094,15 +1094,15 @@ static int gcs_restore_signal(void)
 	/*
 	 * Check that the cap is the actual GCS before replacing it.
 	 */
-	if (!gcs_signal_cap_valid((u64)gcspr_el0, cap))
+	if (!gcs_signal_cap_valid(gcspr_el0, cap))
 		return -EINVAL;
 
 	/* Invalidate the token to prevent reuse */
-	put_user_gcs(0, (__user void*)gcspr_el0, &ret);
+	put_user_gcs(0, gcspr_el0, &ret);
 	if (ret != 0)
 		return -EFAULT;
 
-	write_sysreg_s(gcspr_el0 + 1, SYS_GCSPR_EL0);
+	write_sysreg_s((__force u64)(gcspr_el0 + 1), SYS_GCSPR_EL0);
 
 	return 0;
 }

---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241209-arm64-gcs-signal-sparse-53fa9cad67f7

Best regards,
-- 
Mark Brown <broonie@kernel.org>


