Return-Path: <linux-kernel+bounces-192100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EC18D1861
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0CD288A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E9216C6AF;
	Tue, 28 May 2024 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Tvxnf/1s"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8DE16B72B;
	Tue, 28 May 2024 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891637; cv=none; b=BE5shheb9/pAV0dQ8Puv2Lqboetj4LpBhxTdNlm4zF2KkDQY9JpttgjiXwJmTO3R0NZRYkst5ccEVh9pmO5Mbtw2Ro6nlnHzgKZRcJsk1Maf8oZsEvOb/PjlD4fNHvY1Nnbt7wkMShBHdas7/T2OcfSfaAwliwdeyy3wt157hSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891637; c=relaxed/simple;
	bh=tPOaqNwFB7dfq+H7qsVa/mabtlwOrj5IgAb7rv2aADo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUIQubf3WDPGmwhuSH4XBY04RUsltzTSipA57pmELGi5HuTm6bdNAAVu3zQJ+2jlWRx6qEaheYp9KAnyllQTBL/02oNLRaPv1gDhOc42ZFi1ljW5OIRcu6Hxht7/4nNBAIjR6GuDarxNnEUy6e8Nq2uUVEPz5WiRMNPbHhiFW7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Tvxnf/1s; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 9D4C624000F;
	Tue, 28 May 2024 10:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716891633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zGUowIjjvnUnYJCOfP5hA4A3GSUyMwVNLn232niSHqg=;
	b=Tvxnf/1sOxG7YTTlw/W1NXEz9FHTMOZtCPTbp39/HNLu3Qmmh41gSNHJUYTqYktQguxUns
	950m2EEkYFKsnYsS8vxMnYUd4BJSgIixtf8ZxxM6lV06qmctdPAuv2EoAs/u1SICFvndKr
	HaGWBvV9pJaLlXAG8uLkOS6qVTnIPZsiM7CfpvXx2AXuSSIhVNT8XIzQzZFe5Hsy9f4Xqs
	KkhbWl8xr9yjuhEaQFRiBQS6fXmm74mV6pg5s/Om6s4OUAy3czrEfgOap7TLPxTn4Hdne+
	hrIV8gBBH4HUgMOMGn+zB3UUV+CzJA8Sy3rVmjDkdcwQAiBZthQJeGW0rl950w==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 3/4] usb: musb: da8xx: Remove try_idle implementation from host-only mode
Date: Tue, 28 May 2024 12:20:25 +0200
Message-ID: <20240528102026.40136-4-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528102026.40136-1-bastien.curutchet@bootlin.com>
References: <20240528102026.40136-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

The idle_state is not meant for host-only mode. When the device acts as a
host, it fails to exit the idle state once entered. This prevents new
USB gadgets from being detected once plugged in.

Commit 032ec49f5351 ("usb: musb: drop useless board_mode usage") removed
a is_otg_enabled() check in the try_idle() that prevented from entering
idle_state. This was removed because at that time it was not possible to
select host-only mode with CONFIG_USB_MUSB_HOST so dual role was always
set.

Add #ifndef CONFIG_USB_MUSB_HOST around try_idle() callback to prevent
from entering idle_state when host-only mode has been selected.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/usb/musb/da8xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 1681f9fba3da..c5cf733673a2 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -191,7 +191,7 @@ static void otg_timer(struct timer_list *t)
 	spin_unlock_irqrestore(&musb->lock, flags);
 }
 
-static void da8xx_musb_try_idle(struct musb *musb, unsigned long timeout)
+static void __maybe_unused da8xx_musb_try_idle(struct musb *musb, unsigned long timeout)
 {
 	static unsigned long last_timer;
 
@@ -476,7 +476,10 @@ static const struct musb_platform_ops da8xx_ops = {
 	.disable	= da8xx_musb_disable,
 
 	.set_mode	= da8xx_musb_set_mode,
+
+#ifndef CONFIG_USB_MUSB_HOST
 	.try_idle	= da8xx_musb_try_idle,
+#endif
 
 	.set_vbus	= da8xx_musb_set_vbus,
 };
-- 
2.44.0


