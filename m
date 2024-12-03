Return-Path: <linux-kernel+bounces-429489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3AC9E1D21
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27705B62CBA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217EF1F4718;
	Tue,  3 Dec 2024 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu2+KZWi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8004E1F4710
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230100; cv=none; b=WIK7XVQJqib13MNfdxC1Z1B485IWGNrLaPEoELzcsH5iALUkHU9HrO6v/e0ad2pmyZ4v1HORLNmwa/4u2sX8Sr5TMqR9XDrzn+/5Og5WeizJSx5WKIFlgTk0EZ+AoH9e6//ZEQd45I/Euc/TGWyfmZgoYtF4AbsRTk84K+i5SVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230100; c=relaxed/simple;
	bh=NfLmqQjhH+UlQ7Y+G2ykkZMplv/ejiQc6RhXEP3cv9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=er8C50aWiqVesmsasM1rjcwwJkgxTE8Pmo3V9RkQKdOylFhrkUJHwrKFlF/pV07M+R0o9BCAH7e8AqjjvML44ntCK0eRDa6FE+QwPJiBRnBOULxn35MMHFj77LrHsy3FD0YYVOct/SzJGJelCOuMC+pqpomlWw7rCopAxl1sf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu2+KZWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C299CC4CED8;
	Tue,  3 Dec 2024 12:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733230100;
	bh=NfLmqQjhH+UlQ7Y+G2ykkZMplv/ejiQc6RhXEP3cv9c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yu2+KZWiSIg/vcibGpWsC4cSQbX7GUoTsRpfcjQeVzVoSvs+rjG+UlSrYzTyUDwdI
	 ga5ga1wgyLuIOxUK7PRdjOOwas0dHstcVRs4hb6Ct/oOTZlr3NpjewUgorCB0g1wv3
	 uTSF9S1gNIZJ4Of4zDoStJL+72ik3DAONCVZE+JXx74xTwu/2AFg8rcOcRWXBMcuax
	 mulsC1oYrj9JpLIzDjmaiHaRR9S9iFbbgMkR3dpxBTlauafShocbEDuyC47gx8wPKP
	 jz4tCO3BzZ6kbwKbJMAX7d3JQ/oCVDEUMAaDvZQYqRnKRyZ8qaz8bgndw9Vy1S5HNY
	 SNbYEK10lubvw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 12:45:58 +0000
Subject: [PATCH 6/6] arm64/sme: Reenable SME
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-arm64-sme-reenable-v1-6-d853479d1b77@kernel.org>
References: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
In-Reply-To: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=769; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NfLmqQjhH+UlQ7Y+G2ykkZMplv/ejiQc6RhXEP3cv9c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnTv4EwAM7vHQhCvbi4NPdM/aOb5HiD8WW+R04Hwxs
 zQLBaXaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ07+BAAKCRAk1otyXVSH0GhZB/
 sGRSMP+r1w2EvOeWpp1ren3qhBDoiJyO61GV2YT1wDopNT9HefjfeDe+yPisElGPZdPvi21dHByK0u
 6EHYKPBCF6TrC5EW4eLWCIl86ntF5Ym7Zw6qsBgrdlnQNoUF1NzxxOziu2h9Odun/EjCWC0Ted5Uf4
 31BnrqOPDSmcBabkjEVeXjvAKgHv5uFRVHS9MnPNuM1TD55kahcDYCsjQmTFiHM/3OI3z3OkxaMxpu
 Dr/XrY6g3eQ1/BD5u00yHaMQOHyF71QdwHBMgO6b6ZnKogrJcJcAUmmhlYqU7seGNaylYBWkSUfnum
 R0rvriv0KBw/bSl5tqqYZBYvZm8ePz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Now that fixes for all the known issues with SME have been applied
remove the BROKEN dependency from it so it's generally available again.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 100570a048c5e8892c0112704f9ca74c4fc55b27..7e3182dd6fa0dadd961c352f88484cff0e520eaa 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2270,7 +2270,6 @@ config ARM64_SME
 	bool "ARM Scalable Matrix Extension support"
 	default y
 	depends on ARM64_SVE
-	depends on BROKEN
 	help
 	  The Scalable Matrix Extension (SME) is an extension to the AArch64
 	  execution state which utilises a substantial subset of the SVE

-- 
2.39.5


