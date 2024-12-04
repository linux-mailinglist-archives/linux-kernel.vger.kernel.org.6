Return-Path: <linux-kernel+bounces-431494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC7B9E3E1C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949B5280C77
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B820020C489;
	Wed,  4 Dec 2024 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epS7muEe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261B020C47D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733325748; cv=none; b=KYMU8eBQ6e+9e9U8yvGyCLSwnqNafbLteTuTZfIsySf4m3vllqubPw1rI5HueyDCr5fgYR+N03sIwp8ZKn0qEqW8rmD7HJeTZ1N0xDzWnVbjOUop0WZ5ZALICe+Ck/nTatf5YE9TLynwtfGxumZ/dNvMvpH5NmBGlz+HGZVDGik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733325748; c=relaxed/simple;
	bh=fwkQ2FXE6pq57Zq+2np3KAdjth1F3BAf6kMutQobcPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=trLpX1LYp79KgJbMPaKHR/a72IjyryOeXp0krrf55MUQzqBo/6PerpWxKKNIQBqbENexBHd8/hrKWbojkNDUBuPIKvtGI2uoveFqyYsNSkKxsHUZPUD8BStJ6UPYcuS1a57XNwVGou+1k6TmGeI+IkugOI+YlucWQpY4FqWoBnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epS7muEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B18C4CED2;
	Wed,  4 Dec 2024 15:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733325748;
	bh=fwkQ2FXE6pq57Zq+2np3KAdjth1F3BAf6kMutQobcPY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=epS7muEeP9lQIxwVtpBOEZfTUD0dsC90heQReQpjO5hSMDjQjehvJiOWNMEt5EZyV
	 Qzd1J2/mQ9EsWaCv7SFchHqtBbmUlRZ2c0o4hSqohK7YgGEjJ86kAqC35Stjhmxuwi
	 xIGiafCiyU6PJ/8ytGtdm5v64UKhjDqweVbn+3j2/ZCNwPM+miTwgqM5jUTOq1yBVD
	 bs5kHwXSsZKZEx70b4p0EUneQwhGzEDx4v48roXtTQ2SrGYp/W/DgsD+ZOKUmMFXsW
	 jHwnlx9WcXcLg6psEzSmW5j89JD3B+fyoO/xkl1vl+Aep0W5R3ksHMHKQ9FyvxT4T8
	 P2+F7BSdD6K3Q==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 04 Dec 2024 15:20:50 +0000
Subject: [PATCH v2 2/6] arm64/fp: Don't corrupt FPMR when streaming mode
 changes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-arm64-sme-reenable-v2-2-bae87728251d@kernel.org>
References: <20241204-arm64-sme-reenable-v2-0-bae87728251d@kernel.org>
In-Reply-To: <20241204-arm64-sme-reenable-v2-0-bae87728251d@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Dave Martin <Dave.Martin@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fwkQ2FXE6pq57Zq+2np3KAdjth1F3BAf6kMutQobcPY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnUHOpaUAs0CFqi8g5AEDwSl46+wYe2DIE2hvmh1nQ
 7ZNS+yOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1BzqQAKCRAk1otyXVSH0Hn0B/
 9VJPrFKOwDan2vT7C2sJe2gkAlzuDlnRvwYUVmOmEC+hyjxz0oxkJ72W+vZD/3ARoKBOO2aJyXtkFg
 X/4cmj2Y7cBdf9sPaTiqHG5lCSKOwptrpInRbgvIviUQqiTsMvY5G2i1c5jDCFu/30qASLdspMVGzF
 YSRBEdob0x1qVbfN5V5sytxnsV/txBc3wzGywRnNjwc9hGdEv3EOKAYhqyKBk3lorL7GpDsX2eTSbb
 w73NyNm5JxQLhQiKQTUXYVsNzaOni64A45ufDLjOfrmA1mYyJVmH6OiHnoFOLqqt6f5z/I+DhKk0YB
 pZVdXllCnDoQZM2Oz5zWMzAyJFHuBT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When we enter or exit streaming more FPMR is reset to 0.  This means
that when restoring the floating point state from memory we need to
restore FPMR after we restore SVCR, otherwise if we are entering or
exiting streaming mode as part of loading the new state the value of
FPMR will be corrupted.

Fixes: 203f2b95a882 ("arm64/fpsimd: Support FEAT_FPMR")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index eca0b6a2fc6fa25d8c850a5b9e109b4d58809f54..a3bb17c88942eba031d26e9f75ad46f37b6dc621 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -359,9 +359,6 @@ static void task_fpsimd_load(void)
 	WARN_ON(preemptible());
 	WARN_ON(test_thread_flag(TIF_KERNEL_FPSTATE));
 
-	if (system_supports_fpmr())
-		write_sysreg_s(current->thread.uw.fpmr, SYS_FPMR);
-
 	if (system_supports_sve() || system_supports_sme()) {
 		switch (current->thread.fp_type) {
 		case FP_STATE_FPSIMD:
@@ -413,6 +410,9 @@ static void task_fpsimd_load(void)
 			restore_ffr = system_supports_fa64();
 	}
 
+	if (system_supports_fpmr())
+		write_sysreg_s(current->thread.uw.fpmr, SYS_FPMR);
+
 	if (restore_sve_regs) {
 		WARN_ON_ONCE(current->thread.fp_type != FP_STATE_SVE);
 		sve_load_state(sve_pffr(&current->thread),

-- 
2.39.5


