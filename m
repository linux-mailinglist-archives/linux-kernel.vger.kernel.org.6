Return-Path: <linux-kernel+bounces-186568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3A58CC5C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB80C2864DF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DB6142E6A;
	Wed, 22 May 2024 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clnf1PVx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0389776048
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399895; cv=none; b=WtrdPFADn+7zdazIZALyIxbp/rJqSpX7XI+na+PiqwORh55iKmt6NP/VsN1+dTkVYjXFTxZDnvwJ9Aa6cSEBlFmQ1hHzpeqarKhRQxO6sp0/dJEl7agpUYKeas4aYkEmf0tcm2GPwOKbYBuhCcc7wewO2hJ10kpVxqCixYZKG80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399895; c=relaxed/simple;
	bh=ISa/9A9sTfOrlUnAeGnim+Gt5o4gpr/3BuYQQpAPN2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AHCOdOJ98nlIwAK8uETBsWNc6KncZbbAicBvWfCuYh6DoBfbxyxEPGOdCGijpqj3b0LOMCyrQtrQ0QqSbviLWWQ5x2aA+/Qq7BiLFq8AW8Njb6w/cmgkfKJk19GemDHgKUmmmhDWY+1GyqzRt6rthlCJs6YVfjua4Ydp5EyAgQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clnf1PVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1172C2BBFC;
	Wed, 22 May 2024 17:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716399894;
	bh=ISa/9A9sTfOrlUnAeGnim+Gt5o4gpr/3BuYQQpAPN2E=;
	h=From:Date:Subject:To:Cc:From;
	b=clnf1PVx5pjEIBXXPLoZHu7Wc9+wp7wYokdhCiFEUIWQksZfqGuAtYCxEf8OGiZS8
	 bCvXCk39ABvG925EuhFZ35B2nOruJKwf8T9istziSOsn4Fa5ConD+srCCQuD9iL/Ew
	 WETLZinMfQQ6uecsxLhY2mQAgr7NO7ughzPcsrKZJY3m/XD5jsT1NyhbJ0k9LAAU2K
	 7vCMi3/t/Kql0Q3b5imC0a4ec4fTDNdNhvqMhhk67X2BxTNYgynYXNkjj5oMDJe1jU
	 joIGQLta4OMjKbVteqr3L0EWJyQnuL4pXDqQtBtkS5Fc2E2TSLnuqEo6ga8Cz0zZ0C
	 4ckwKiNAhKGpQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 22 May 2024 18:44:41 +0100
Subject: [PATCH] clocksource: sp804: Make user selectable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-arm64-vexpress-sp804-v1-1-0344cd42eb77@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAgvTmYC/x2MSQqAMAwAvyI5G6i11uUr4kHbqDm40EARin+3e
 ByGmQRCgUlgKBIEiix8nRmqsgC3z+dGyD4zaKWNarTGORzWYKTnDiSCcnfKYG0bb/u6W1TrIKf
 Zrfz823F63w9Kr0K/ZgAAAA==
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Ross Burton <ross.burton@arm.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-621fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ISa/9A9sTfOrlUnAeGnim+Gt5o4gpr/3BuYQQpAPN2E=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmTi8TQANlzhzfGOBFS1jd6/1jJABcH9JyDpWkLZOO
 ikTKWJqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZk4vEwAKCRAk1otyXVSH0OBCB/
 0aZpC6NKdXSpgQyq9v0fvqYE9FhffOVFgF6tT3x8iUzVJk0Ie5DmJK0S7qx7o2xU7iRq6PRlSGsAgR
 njHkxfVrWetShIZ7Paq4PxA4pB8yti98rw8FsxOuICJjtMeErJj+lx4/NLEgbrpzm7DTHZcgMrX/SI
 OChKJZ3TkgNaIy872LmoIejlK9QRZ1Mf8aNGzUJi5fleIAi2V1i1yT6IIcmpKbb/gN/b04tEQfaBbM
 T8j/ouOAbEbiu/7cy744tPe+8h+mKl6byuSrD7dNYKfbela270OLBGH4On9X1h+Cj9IZ1YuYKFFgrP
 Uu0wAhxV9aX0poip0AqR6v5YHbzFXv
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
Signed-off-by: Mark Brown <broonie@kernel.org>
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
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240522-arm64-vexpress-sp804-365d6938b07c

Best regards,
-- 
Mark Brown <broonie@kernel.org>


