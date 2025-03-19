Return-Path: <linux-kernel+bounces-567618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF8FA68859
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7946617526B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DEF25D53A;
	Wed, 19 Mar 2025 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="motJKL+7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FAF253F0D;
	Wed, 19 Mar 2025 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376777; cv=none; b=B1Ays9wpy3c85T2wnXDqUpRfd/SiAqrmIA76OlhD5/IjKaDPLla72PSS+PphhSDBC2Qm7LoTZOIZIhwlC1Webb0SN1e3OH0OZPQc+xICiMBZ1XbyRFiIvtzHbB3zBmRtsbvtcQ1klOF79BSMETggqNqkETI9e77DcxhGDU+grBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376777; c=relaxed/simple;
	bh=gT6RvvOH9rE65zTzqqEWjqya5oBeXsEraVrUGC8winU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJbFGuySBCerqYdV/jPjXm7/qC4fVZqY9TMzjEtYydGih/+5Z6QO7+/iLWzgDxH35q+O4TfQk+9oonqCXH3RZ+k8x5HoefdCDF4D4lvb/l+wlGQO59fKbmWnLcnAs0LAAYGnJNXSwK1whU53CoxfLb06KMc2FfcQ3YvMeunu+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=motJKL+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D14DC4CEE9;
	Wed, 19 Mar 2025 09:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376777;
	bh=gT6RvvOH9rE65zTzqqEWjqya5oBeXsEraVrUGC8winU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=motJKL+7zOVGILPaWf+2KVIoWmMkzDTQR/ZLR1tVo+xmAhkqOxIP64q8ld3xayxK8
	 OAm4LsCiBs1TYIB72dm0TRr2xhMPAd2GTzhEOmGQD6W8AjLt3tJNEC6B18xRh3rgy/
	 0jwOPhJYphYQ9D1NAXIoFtXwgwr+Sxc7Vh+SyGxImmdcHlk4Z8HENT9i/N+HvmBRAX
	 rF6q2473FYGG4fOoTRfLrXvvgRKBdGJwvcmZl7jJCmxZeOwbJQKtyniu9TfHlZ2H7L
	 uWUvGJ1VTKjcYjMSr3Vj52O/hFZ0lDPfQw0rk6RYYBfvx5FmNDQomAb73swnh9og65
	 eEKPSMjRMX5MQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org
Subject: [PATCH v2 42/57] irqdomain: sh: Switch to irq_find_mapping()
Date: Wed, 19 Mar 2025 10:29:35 +0100
Message-ID: <20250319092951.37667-43-jirislaby@kernel.org>
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

irq_linear_revmap() is deprecated, so remove all its uses and supersede
them by an identical call to irq_find_mapping().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/boards/mach-se/7343/irq.c | 2 +-
 arch/sh/boards/mach-se/7722/irq.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-se/7343/irq.c b/arch/sh/boards/mach-se/7343/irq.c
index 8241bdedcc82..730c01b225bd 100644
--- a/arch/sh/boards/mach-se/7343/irq.c
+++ b/arch/sh/boards/mach-se/7343/irq.c
@@ -71,7 +71,7 @@ static void __init se7343_gc_init(void)
 	struct irq_chip_type *ct;
 	unsigned int irq_base;
 
-	irq_base = irq_linear_revmap(se7343_irq_domain, 0);
+	irq_base = irq_find_mapping(se7343_irq_domain, 0);
 
 	gc = irq_alloc_generic_chip(DRV_NAME, 1, irq_base, se7343_irq_regs,
 				    handle_level_irq);
diff --git a/arch/sh/boards/mach-se/7722/irq.c b/arch/sh/boards/mach-se/7722/irq.c
index 9a460a81907f..49aa3a2b1b8f 100644
--- a/arch/sh/boards/mach-se/7722/irq.c
+++ b/arch/sh/boards/mach-se/7722/irq.c
@@ -69,7 +69,7 @@ static void __init se7722_gc_init(void)
 	struct irq_chip_type *ct;
 	unsigned int irq_base;
 
-	irq_base = irq_linear_revmap(se7722_irq_domain, 0);
+	irq_base = irq_find_mapping(se7722_irq_domain, 0);
 
 	gc = irq_alloc_generic_chip(DRV_NAME, 1, irq_base, se7722_irq_regs,
 				    handle_level_irq);
-- 
2.49.0


