Return-Path: <linux-kernel+bounces-368406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 903239A0F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473361F22583
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AB820F5D6;
	Wed, 16 Oct 2024 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="WJ/QF4nL"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B268E12DD8A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095545; cv=none; b=AuAKStYbCWEhI0I/MGipXM9NNuMDYTpLB9rv+VMHH14YjCzANa2jEUy78YK1lAZ4pYT1C949ZgkNmaaAh7DilxrtBvWD4UX2ZluiFJLaR7F7o5rY8mwTHyzpyXuscaiBCQLcB/ElTSi+I8Ey2b2RkIpwwCOtBoDVViuZd0SXRNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095545; c=relaxed/simple;
	bh=DU3xxf8OS0wf5uz6rRlojBdb8lFaqFGZboU2hsawZGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sbhrUwP43HOyWS/4YtqmvyLmtT5iWp47vSj+5lzZF2fjvV4Gj/nnLlefZiA4khNsOqrLOlcKn3pjklsJLY8so2iCBAkGNI/80gXVj8r1fI4jA1hGJBSiPZFLJe7Q1qEqEw9ZK5T4NUTQX5JzdA04lvXMV3lG2Q5x+d9sFgK3qio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=WJ/QF4nL; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 93B8920005;
	Wed, 16 Oct 2024 16:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1729095535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mr7Gdw7WuWDfM1YLaYtR0LiWnWmLO3/eoqes+Yrm7II=;
	b=WJ/QF4nLydyMTO7Fjhyy6DYaUrnG1JJWlCM/DoIcKrmcecaq6H6f6tcHYXXhrQHWRMCvSI
	2FC8QlkFI/dSEbZ0Y2YyJUuxLfqx4PwFjoRZ2H0xbZbsSGFLJMN2CZClBpaYV1nXyf+h6V
	jfe+/YB+lrDS9Mb+EoHIozOpyjYgdBtbCc+yyF5xsuqzqs4JKzyy8U41yXXmpzSMfeJm+k
	XfpfK6JhNXty3x9ywAdhxbpKR+2GVau4aXY/VKo7JefKmYLcOZehK81o3Eicc4+RC2esd+
	7JYMB+pRIxiR78Ww/ORyKVcydFOZMg/fnWxHygIjYrk0XvZ55tot0UhBO+n2gA==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Wed, 16 Oct 2024 18:18:55 +0200
Subject: [PATCH] m68k: Initialize jump labels early during setup_arch()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-fix-jump-label-v1-1-eb74c5f68405@yoseli.org>
X-B4-Tracking: v=1; b=H4sIAG7nD2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0Mz3bTMCt2s0twC3ZzEpNQc3WQDC+NUS4PklJRkMyWgpoKiVKAKsIH
 RsbW1ABiFqOZgAAAA
X-Change-ID: 20241016-fix-jump-label-c083e90cddc6
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729095535; l=1129;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=DU3xxf8OS0wf5uz6rRlojBdb8lFaqFGZboU2hsawZGU=;
 b=N6bEtSVo1NMnwHa/0M7mhDieNTCxlI+cwDRWBmtQf1ANSRvGtmNodTI3pgbh5orM9zmqRzLAW
 Z0SU07AN2ldDEkCXUqfTe0Ug7miK49r8SH5OFHx/nCLouzSvz0a7uN3
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

The jump_label_init() should be called from setup_arch() very
early for proper functioning of jump label support.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 arch/m68k/kernel/setup_mm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index 10310b04f77d8d79bec858c6989c2cf21d0af557..15c1a595a1de0bef7e6565b7a6e02d773c23bb8c 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -249,7 +249,11 @@ void __init setup_arch(char **cmdline_p)
 	process_uboot_commandline(&m68k_command_line[0], CL_SIZE);
 	*cmdline_p = m68k_command_line;
 	memcpy(boot_command_line, *cmdline_p, CL_SIZE);
-
+	/*
+	 * Initialise the static keys early as they may be enabled by the
+	 * cpufeature code and early parameters.
+	 */
+	jump_label_init();
 	parse_early_param();
 
 	switch (m68k_machtype) {

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241016-fix-jump-label-c083e90cddc6

Best regards,
-- 
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>


