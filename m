Return-Path: <linux-kernel+bounces-431497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503D59E3EBC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F196B38243
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D442E20D4F4;
	Wed,  4 Dec 2024 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AA9I21OQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE2620CCEC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733325754; cv=none; b=jsJFB2opsyDJOK4narXUPOOvcEsf1e1rHVQpZwUhiiEgrGWWYZqb22Yl6m24oy7HJPY65Wpz/RPS4CwhkhvorsGFWEGcMXvBOuE373Q42azXFhBguKjSOI2+rhQULNvLla+cpVTTYB68OX4mj/CnnJWV0ceXUSFg99rmAujvxSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733325754; c=relaxed/simple;
	bh=NfLmqQjhH+UlQ7Y+G2ykkZMplv/ejiQc6RhXEP3cv9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K1/CqDI07zoh3rN4EjBXImAgvQUka+RcEutERLIyTV1IHekLwFJBCwEwDlVjfuQOZERfDEmKTI1UjTOYE7xVGdh1RER9uAd+iQBrj9helmr/d5ENp9ce+ASV0CqzmCEyvKv4cnxelX6kOvvl57CdMBL2SY/R0dxH8xs+9dS3y4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AA9I21OQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDB5C4CECD;
	Wed,  4 Dec 2024 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733325753;
	bh=NfLmqQjhH+UlQ7Y+G2ykkZMplv/ejiQc6RhXEP3cv9c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AA9I21OQzvXTD9ePUDrr5h9Z0wOHDh6jF35EaoAYsUMqsSJQxW38z3QkOpd4uHYoB
	 tEfGXOdRKuzb7ELZCXUubD3N98i0JUifocbJEzfA480VJGyFRORsIzShFIiRFiyoSO
	 /nKknR1fAaiEFa+JxnIfv5yDGERVC4xKTC548FcWGSMgmdS6NgymsjJgustYy8B3UM
	 eMjXR4jiRCqSQqOhLoyzk/MlxiWk6xMGFTz44c+XJM0BZYTT4S/oH3+uwZnQtON94C
	 HbdNt8+GPmbtflcy1j94owT2fq5Im2hpgRnGWSYtqbBC5qxwW5CrqJ/kULLBDpI8vc
	 77noG1ZMROR0g==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 04 Dec 2024 15:20:53 +0000
Subject: [PATCH v2 5/6] arm64/sme: Reenable SME
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-arm64-sme-reenable-v2-5-bae87728251d@kernel.org>
References: <20241204-arm64-sme-reenable-v2-0-bae87728251d@kernel.org>
In-Reply-To: <20241204-arm64-sme-reenable-v2-0-bae87728251d@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Dave Martin <Dave.Martin@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=769; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NfLmqQjhH+UlQ7Y+G2ykkZMplv/ejiQc6RhXEP3cv9c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnUHOswXh9Qp87YFQNiApq82JF8iKPIsacXChbC9NO
 xUMJkDKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1BzrAAKCRAk1otyXVSH0AmYB/
 4mHv/OIIIvF/5wo69xV2tpZJVLWHKrR4uBygEFPUTRdj9ULex3KfhOg6bIOKzNTK2cFoNeQrrGdI28
 djJn+ZpWtW75a077cHznj9M27QiE6xdldBJCpUOrhSwhJG4k0xvF/iyjfXdsFbk/d/Pr76AHgZmiht
 moDjnqoS7w0MDsRHyrvrUmKu7+YxSTxaD9/KB853GQNFi+fzpmviHqgELXfcOJsDf81gMCTihdl7IL
 dhwQ3/zQnZoHhXZiqLLXdFzoOcaKCS8o/oz92gHgzI4vcX0rwaeW6g30hkG2uuvMfI1UIp0H8pqRwX
 +o+yqh+aa19lMOpDLmNrsqHyA8X4Yh
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


