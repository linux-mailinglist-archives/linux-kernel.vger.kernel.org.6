Return-Path: <linux-kernel+bounces-567582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 251D4A6881A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6BE7179104
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76694255E51;
	Wed, 19 Mar 2025 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmumnTWt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954B255E39
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376674; cv=none; b=aN6zTxRlH7LooOCX+suToBs8wKXYCPDNiSHc8BYwidnkWQomXeV9wL0G/XPDCB+JE5dnKUZCLpDoAJM8UMhHV9L5JRhFLxapXZJkj6GLdnptFbf8NSl9KED6n61E6IgycPVBx2+X6pDqq1kiXItGOYx1lFDkxo31i2WvPM9Evj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376674; c=relaxed/simple;
	bh=NaUebujBUUHk/YLaA7S6CPpdQubsvT1Q6Qh1BsUzd/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4BaxxN7A+1XVaYscY/Zgl6dC+3llV37Yndr7HCDTObVp/co1RdoxRdjhTwYCEdnlAupUWLeSuvt+pG969zE1E6AuQEnw7jAMVOxopE62DBI0t8JKUrNxYYmo521+iakt8Bxo8DjzgQVzFhYaiUFjS/e2kP3b6RBJHJSBNoNg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmumnTWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBE9C4CEEE;
	Wed, 19 Mar 2025 09:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376674;
	bh=NaUebujBUUHk/YLaA7S6CPpdQubsvT1Q6Qh1BsUzd/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fmumnTWt09IkQ9Zs54sPuzsWTq54TsLy8Fdp67fx0LeQzaPU6mgHcRgGfbeTbsGzZ
	 Ev87+UcHK6d9xah6YPoAR1bKDvRXDICOipIReKNLnBi8FegARxeJ/Hd0UZjognqsDU
	 8pGrChIruS6SjslMWqmBAfTl5Yc8J2jTLen1KhmlwIvc1V7FEDbqH//ITGZcup9BA0
	 sfB+h8aC5Tl8hw94PR+5w5gKFmy/9EzMWr046aCNNvD+GV5ouBraAdMhjEu/Gs/Ipu
	 zVIZM4Arx/D+M1Q4XiKHf74RHOSB4R0dLkl30S+H5nosyX2bHyXUqp5NX6m43xjudc
	 SuEGwhKaaseUQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 10/57] irqdomain: x86: Switch to of_fwnode_handle()
Date: Wed, 19 Mar 2025 10:29:03 +0100
Message-ID: <20250319092951.37667-11-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_node_to_fwnode() is irqdomain's reimplementation of the "officially"
defined of_fwnode_handle(). The former is in the process of being
removed, so use the latter instead.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/kernel/apic/io_apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index eebc360ed1bb..487992cb0836 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2225,7 +2225,7 @@ static int mp_irqdomain_create(int ioapic)
 
 	/* Handle device tree enumerated APICs proper */
 	if (cfg->dev) {
-		fn = of_node_to_fwnode(cfg->dev);
+		fn = of_fwnode_handle(cfg->dev);
 	} else {
 		fn = irq_domain_alloc_named_id_fwnode("IO-APIC", mpc_ioapic_id(ioapic));
 		if (!fn)
-- 
2.49.0


