Return-Path: <linux-kernel+bounces-194861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A301F8D4332
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 03:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36501C22EE6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AE9179BD;
	Thu, 30 May 2024 01:54:08 +0000 (UTC)
Received: from smtp.cecloud.com (unknown [1.203.97.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC281757E
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717034048; cv=none; b=fLakPnPXWZu7DkvjYeTYA0QkMRQL9INPyrdSnAOQpIJS7G1b3V02l7GgETHvC0utvCZvixTSG1Z7xndm0V/e0KmjN/bUJEhOuB1emPuz/vLBAxozK+igT+vlIV18LAEdyUjyK+oKDbxjtJqGei4v3UvdT34WJmvumW9UC4RDh0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717034048; c=relaxed/simple;
	bh=sp/lBwrrnQAApOv3URh1IYYxF8YLzzMS+3rclMm+tYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9VO5E06w7eY6F4XTypkO1g+JRQzpw5nk2bqQlk3HfBoUObbGR1ugfXbFx0izihnSJ3E5boUz7mKCkagvm1Bs1/98ZYC9w4tBQIKpMrKdPtey8aZtA7dMnbZ9f3uaUFYbVg9QbF6eNrbE/0OsGPX5oRx5ufCuzGaLT2DXLr1iHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id A5F88900126;
	Thu, 30 May 2024 09:53:55 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-ANTISPAM-LEVEL:2
X-ABS-CHECKED:0
Received: from localhost.localdomain (unknown [111.48.58.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P894637T281472753660272S1717034033041744_;
	Thu, 30 May 2024 09:53:54 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:liuwei09@cestc.cn
X-SENDER:liuwei09@cestc.cn
X-LOGIN-NAME:liuwei09@cestc.cn
X-FST-TO:catalin.marinas@arm.com
X-RCPT-COUNT:7
X-LOCAL-RCPT-COUNT:2
X-MUTI-DOMAIN-COUNT:1
X-SENDER-IP:111.48.58.12
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<f09eada4100944e523f3c1585620a054>
X-System-Flag:0
From: Liu Wei <liuwei09@cestc.cn>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: prarit@redhat.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, liuwei09.cestc.cn@cecloud.com,
	Liu Wei <liuwei09@cestc.cn>
Subject: [PATCH] ACPI: Do not enable ACPI SPCR console by default on arm64
Date: Thu, 30 May 2024 09:53:32 +0800
Message-ID: <20240530015332.7305-1-liuwei09@cestc.cn>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consistency with x86 and loongarch, don't enable ACPI SPCR console
by default on arm64

Signed-off-by: Liu Wei <liuwei09@cestc.cn>
---
 arch/arm64/kernel/acpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index dba8fcec7f33..1deda3e5a0d2 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -227,7 +227,8 @@ void __init acpi_boot_table_init(void)
 		if (earlycon_acpi_spcr_enable)
 			early_init_dt_scan_chosen_stdout();
 	} else {
-		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
+		/* Do not enable ACPI SPCR console by default */
+		acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
 		if (IS_ENABLED(CONFIG_ACPI_BGRT))
 			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
 	}
-- 
2.42.1




