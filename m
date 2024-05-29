Return-Path: <linux-kernel+bounces-194622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B54F8D3F09
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 21:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA271F23761
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D97A1C232B;
	Wed, 29 May 2024 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4SHCxMy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F4D1C0DF2
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717012103; cv=none; b=lmLkDorWF5k3optYnDwKxtL07BR7iNgXs3T58/F0OtONdelgUvmG2I94I8zb6i2vjJOXax4TTC7LU0zq92HEGgEdvX9fVBOXcYRTCVIoeGL7Hl85H2Ijm/Ql8lgEzxZlYSJrBMg9gITyZd0jr+QPUzMItLVSWXSwKo+jfu4bgjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717012103; c=relaxed/simple;
	bh=TSNUIaMF3kpXKqglBYc37Xm+HyAvY4aeML8pg247L1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YN16R8+CGiqMDvaq0APRG7PVXGz3bbentgHzo4YPj6otWQWCwyXPqc+0LQZRsfu1G/t0pfJCku+UZWQS6q2Tg8onO/gi/HdELD23fspYm0h+R/DF+mxa3EdmAakQNG4gbcm89Hbg9CYsX7VckBxz3LZ3ZdGoTZib4ecEweRocBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4SHCxMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBDBC113CC;
	Wed, 29 May 2024 19:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717012103;
	bh=TSNUIaMF3kpXKqglBYc37Xm+HyAvY4aeML8pg247L1M=;
	h=From:Date:Subject:To:Cc:From;
	b=u4SHCxMyZu/nbNoHUIZ9X9SolX1ensSBOVtAhPSy+/JWnl3Iujd2VaKKhWvjErehf
	 uQM1zB/8N9OFrGCajBHUzYB5LAm3Srj22LbMYbqMfmKb/ntQ2bFaYoIj50OefTCy7r
	 eBC8KV2XCjGHC5qXjfcOGrNgWyJ7XlpBVaysrpYOclyOF4lQy/+52Nu/ctEJvtqhXq
	 iDJorpIzhm7SEkxq6jxzIeyL49g+5ifS6qfCiB8P8aVQuI1iUuP5iBx90wX5mjlnZP
	 gfHlARDkd56hu8ZrQf46lj/yDueT8Yo3jhLlBXHl02Aedpbkr6hjPj4eJXJYzqp9V+
	 +pJO/b7tJdBRg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 29 May 2024 20:48:14 +0100
Subject: [PATCH v2] clocksource: sp804: Make user selectable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-arm64-vexpress-sp804-v2-1-c542a80af33a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAH2GV2YC/4WNQQ6CMBBFr0Jm7ZhSCkVW3sOwADpCowKZMQ2G9
 O5WLuDy/Z///g5C7EmgyXZgCl78MifQpwyGqZtHQu8Sg1baqFJr7PhVGQy0rUwiKGutDBZV6ap
 LUffKDpCmqbv77dDe2sSTl/fCn+Ml5L/0jzDkmKMqjBmc0dRbe30Qz/Q8LzxCG2P8Av5UU5C5A
 AAA
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Ross Burton <ross.burton@arm.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-2ee9f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1926; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TSNUIaMF3kpXKqglBYc37Xm+HyAvY4aeML8pg247L1M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmV4aEWf26AfwBkWBp0X95MoX+Epah6ddUKq5agg+2
 812d5BCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZleGhAAKCRAk1otyXVSH0LlFCA
 CGlCHUjhuUGyWIONwdnesEQYaouzvq7EmI1OVMS3BVrm5gpyEx/l48SH+VcFzMwjv8Kc3Ak3mmx1f/
 hfzMOsIw+1nD/pYc9H85XwecpRCGllzHZIvuB2v7ry553jKMkPE7udQFBnwH8XpS78YJdDugz7sr7D
 mUzcwrOaSYzNBM4z7rkL2OBlgyZmQoY0oWoGwpMYApdVBT7XMGXwkgtOzvxgCwis+QsKsIz0fNARVu
 nqYq+ymlFpmMbVceH4jCczsRLHqNU7Cm2q7WBnP7z1rNiUDxPfdB1c0Jt9R4DGLWYgdcHS/CL+d6hW
 HpucJvXdkO/B6URpfSAlKUbPdyZnfW
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The sp804 is currently only user selectable if COMPILE_TEST, this was
done by commit dfc82faad725 ("clocksource/drivers/sp804: Add
COMPILE_TEST to CONFIG_ARM_TIMER_SP804") in order to avoid it being
spuriously offered on platforms that won't have the hardware since it's
generally only seen on Arm based platforms.  This config is overly
restrictive, while platforms that rely on the SP804 do select it in
their Kconfig there are others such as the Arm fast models which have a
SP804 available but currently unused by Linux.  Relax the dependency to
allow it to be user selectable on arm and arm64 to avoid surprises and
in case someone comes up with a use for extra timer hardware.

Fixes: dfc82faad725 ("clocksource/drivers/sp804: Add COMPILE_TEST to CONFIG_ARM_TIMER_SP804")
Reported-by: Ross Burton <ross.burton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Rebase onto v6.10-rc1.
- Link to v1: https://lore.kernel.org/r/20240522-arm64-vexpress-sp804-v1-1-0344cd42eb77@kernel.org
---
 drivers/clocksource/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 34faa0320ece..ca6045f90000 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -390,7 +390,8 @@ config ARM_GT_INITIAL_PRESCALER_VAL
 	  This affects CPU_FREQ max delta from the initial frequency.
 
 config ARM_TIMER_SP804
-	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
+	bool "Support for Dual Timer SP804 module"
+	depends on ARM || ARM64 || COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && HAVE_CLK
 	select CLKSRC_MMIO
 	select TIMER_OF if OF

---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240522-arm64-vexpress-sp804-365d6938b07c

Best regards,
-- 
Mark Brown <broonie@kernel.org>


