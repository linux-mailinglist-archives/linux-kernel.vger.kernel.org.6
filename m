Return-Path: <linux-kernel+bounces-567604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC13BA68840
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18B017BCE6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C499625A332;
	Wed, 19 Mar 2025 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwjUA4ME"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A725A32A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376735; cv=none; b=PpgoJbFm6t4WgfPmNT7bJ+DMG3cMqdoU6RDavoSO6tCXQeZoMxRpjipAdENcPjcKKyTQkWOr6FqzMFznE5nPv1YVh0AusP9qybFM3GoFGEbkK6Y1v2KDmYRMKzQ2ReUWJo0rAZsIZvBYELKdo4Fj170QRHm66xkrdWLweDGI6oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376735; c=relaxed/simple;
	bh=f0dWSgJvlbqpksXdJKfOe7BCnUM3QhjW8ZzPV9bgfZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuO6FgIJoLPkJF5/Pb8AwdmWIG/2PYGVkFLhoyyQwmQTmDwoA1nq0qCkNe9+AE/f4sBguKTF4/XDwkQF8OWCnMtfHB82MyCNsJ9qQZghsnL3eAxtywqrQdOwuX/W4OJpVTQP3+EptVZcEYOdpVRL0EcBTDp2CNcmQprL68ywHgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwjUA4ME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3BAC4CEF0;
	Wed, 19 Mar 2025 09:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376735;
	bh=f0dWSgJvlbqpksXdJKfOe7BCnUM3QhjW8ZzPV9bgfZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HwjUA4MEr63Hg3LfwHhw5F9O2Ctvtsu5cI7SYVe/hM2z10pwbW5qUU2XoqPY8IGtt
	 XHdHU9eVbZOJIuu9KZyrj5kL9SR9LeBlcFAVeunnfB6udNOuy/rCpkssVlsGUxvBnm
	 FUIeOIBKNOsvWlOJFgTdLsTQoxrqYGuMmYSKbHCmu5apJ58wwLSULBL2gNag6gmbw9
	 UfiEjUCLK/Q3nsZPUW/pxAWlhDoCZ89+8gBJNOaNR9SokBdetIR0xr/yf58qoLV7Vp
	 DLBj0DUkMIXIFifoDU4uw1VU7B6RiI5ZiSXjAWi0XAteYDKaHMjjWIinXQgod8RmL6
	 to7sbzgdT/bnw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH v2 28/57] irqdomain: nios2: Switch to irq_domain_create_linear()
Date: Wed, 19 Mar 2025 10:29:21 +0100
Message-ID: <20250319092951.37667-29-jirislaby@kernel.org>
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

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/nios2/kernel/irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/nios2/kernel/irq.c b/arch/nios2/kernel/irq.c
index 8fa280660051..73568d8e21e0 100644
--- a/arch/nios2/kernel/irq.c
+++ b/arch/nios2/kernel/irq.c
@@ -69,7 +69,8 @@ void __init init_IRQ(void)
 
 	BUG_ON(!node);
 
-	domain = irq_domain_add_linear(node, NIOS2_CPU_NR_IRQS, &irq_ops, NULL);
+	domain = irq_domain_create_linear(of_fwnode_handle(node),
+					  NIOS2_CPU_NR_IRQS, &irq_ops, NULL);
 	BUG_ON(!domain);
 
 	irq_set_default_domain(domain);
-- 
2.49.0


