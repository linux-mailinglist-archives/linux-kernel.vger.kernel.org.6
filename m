Return-Path: <linux-kernel+bounces-339430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCA39864F8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6883286FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E9A4F899;
	Wed, 25 Sep 2024 16:40:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8EBDDC5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282424; cv=none; b=oQGTlZleQnaopbg+HaufuoMYUgLnpiml9ulYUaxoWjCgc4BAe3vg95tHxCIYVw7qnKQTw1jBybMz1qOAThMnv3LAo4njaVNi1l/rwNNN7ms/EbJtISclk08+KbwseSGW9xoVhC+O8EsDjoBQnLpFcuNolyH2BvciI8pYKtnJCEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282424; c=relaxed/simple;
	bh=/J0NACCwzQKpTcnb37RzWHUS/e5Msi7D0szViVVSXEI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ajb97+YCG4x/BsBKcILIYX0bbiQlJLJmMesQlf2caGUDTae9T9omm7TJ/hxtRKmBv2pyPsM0p5sf2y0SE8dptufjvTucnEguHDz/zwDSJOUJ0h32jEpuad8fOjDqB+7pE3HziNZJgsyDN+c9C3b236JBNeaS2VMeJp1KGDRaU2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1stV3r-00046t-IE; Wed, 25 Sep 2024 18:40:19 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 0/3] reset: Requesting pre-deasserted, auto-reasserting
 reset controls via devres
Date: Wed, 25 Sep 2024 18:40:08 +0200
Message-Id: <20240925-reset-get-deasserted-v2-0-b3601bbd0458@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOg89GYC/4WNQQ6DIBREr2L+ujRAVGxXvUfjAsuof4MGKLEx3
 r3UC3QxizfJm9kpIjAi3audAjJHXnwBfanoNVs/QbArTFrqWrZaiYCIJKYSBxuLneBEo7rGdqi
 tkS0VdQ0YeTtnn33hmWNawud8yerX/hnMSkhxqwHTjoMZjHus8NM7hcXzdnWg/jiOL5QDzYu9A
 AAA
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.15-dev-13183
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

There is a recurring pattern of drivers requesting a reset control and
deasserting the reset during probe, followed by registering a reset
assertion via devm_add_action_or_reset().

We can simplify this by providing devm_reset_control_get_*_deasserted()
helpers that return an already deasserted reset control, similarly to
devm_clk_get_enabled().

This doesn't remove a lot of boilerplate at each instance, but there are
quite a few of them now.

regards
Philipp

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes in v2:
- Clear RESET_CONTROL_FLAGS_BIT_OPTIONAL out of flags.
- Check flags in __of_reset_control_get().
- Fix devm_reset_control_array_get() documentation.
- Clear RESET_CONTROL_FLAGS_BIT_DEASSERTED out of flags.
- Link to v1: https://lore.kernel.org/r/20240621-reset-get-deasserted-v1-0-94ee76fb7b7d@pengutronix.de

---
Philipp Zabel (3):
      reset: replace boolean parameters with flags parameter
      reset: Add devres helpers to request pre-deasserted reset controls
      reset: uniphier-glue: Use devm_reset_control_bulk_get_shared_deasserted()

 drivers/reset/core.c                | 119 +++++++++++-----
 drivers/reset/reset-uniphier-glue.c |  24 +---
 include/linux/reset.h               | 274 ++++++++++++++++++++++++++++--------
 3 files changed, 303 insertions(+), 114 deletions(-)
---
base-commit: 487b1b32e317b85c2948eb4013f3e089a0433d49
change-id: 20240621-reset-get-deasserted-5185a8e4a706

Best regards,
-- 
Philipp Zabel <p.zabel@pengutronix.de>


