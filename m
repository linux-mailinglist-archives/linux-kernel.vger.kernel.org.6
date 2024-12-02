Return-Path: <linux-kernel+bounces-427416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D319E00A0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD65286C07
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ABC1FECDB;
	Mon,  2 Dec 2024 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2l4/4dY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610B51FECD7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138722; cv=none; b=RMsRPD4dOILgpkAff48Zubxwirzpid18hj/GptrCFNzBqQuPQFynXhMSe0dE+CR49EAoCrz71KF4GSSx7Y31U2YNqkXe5B8DCUmLjJZtdPAUtCMtjZUjjZOFAzYo3z/w+uNbEjWMYMOxX05z8Punjc9wgBivEAFqYWj6kV34i/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138722; c=relaxed/simple;
	bh=2uqvsHsmU2KBwBwiLQTzowJxyoJ4ZywdDrBFU4cFoz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i3UL8cEH4Q5BLUjVhqWNITNQqBQTOV1Q4p+46bc8KZFYknptgewYGDVlqezc2YzqUE5cXT7Rn2mo5+Uua/TtJfjRyNXQGuWiSsQAgC6z2814vcg2c/QonwYZ/titxIhowkepnRXucHMfio7QCoj3S5rldLU5TOTTmo6fzk1aN3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2l4/4dY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DD8C4CED1;
	Mon,  2 Dec 2024 11:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733138721;
	bh=2uqvsHsmU2KBwBwiLQTzowJxyoJ4ZywdDrBFU4cFoz8=;
	h=From:To:Cc:Subject:Date:From;
	b=q2l4/4dYLd5Q/ezlwWOV7BXqyEPORxadCRJTrRR6vcu9Mm/ma2nKaGjRHP+rAOQym
	 XgrASSijumDPfZCE0yqXOmTTCQWlDs0OPhgrtqPfq6+d+B9muIhdmQGlStADavzYVN
	 f86jYFV67MKADRRfiMbsgCzE5nQr/gyRIESPbvmxkIf6OREoYlP+U/n6oaRXRm7XBo
	 AAgrfaqbNu28MDiF9zyyDdWr12XJj8bd+FxR7jBAAx4bqgHZvpus+BoS8zPWQ7SURe
	 sQic2bjVDoN4qw0vq+3vnr8ZXqz7G0eL285Ui/7a7s8T1GG77hgqeSzJ4x83872JD2
	 WBbxH8jHM4GhQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH] irqchip/gic-v3: Fix irq_complete_ack() comment
Date: Mon,  2 Dec 2024 12:25:18 +0100
Message-ID: <20241202112518.51178-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the GIC is in EOImode == 1 in irq_complete_ack() we
execute a priority drop not a deactivation.

Fix the function comment to clarify the behaviour.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 8b6159f4cdaf..34db379d066a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -817,7 +817,7 @@ static void gic_deactivate_unhandled(u32 irqnr)
  *     register state is not stale, as these may have been indirectly written
  *     *after* exception entry.
  *
- * (2) Deactivate the interrupt when EOI mode 1 is in use.
+ * (2) Execute an interrupt priority drop when EOI mode 1 is in use.
  */
 static inline void gic_complete_ack(u32 irqnr)
 {
-- 
2.47.0


