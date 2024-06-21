Return-Path: <linux-kernel+bounces-224891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE034912843
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6644CB24457
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4E837147;
	Fri, 21 Jun 2024 14:45:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0C2B9A2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981123; cv=none; b=JWhJQw8ghIuFtLCuK7rQ1Mlr8kX45sxxqNvDS233D2ugWCzs7thE5+sRflAWyq/+9Vp1fhSFORhLE5PE5q6m8zzwoerKpT7wt8rOxb/WmZbBeruKHIgNAYl7ueGym2Z1ti3O/+ICJgsQ34xGWjS4PjjRfUGgcvKNTuuIIWe/t3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981123; c=relaxed/simple;
	bh=rXuKXuKiQkV1khbR8ect8VwlJovvQvr8Lq35ek4CboA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DRRoa4dbBBshfBzHjBwftmOQmQZJGpeS+lN0sfq6ydp6RA9hr5vER+HyW2LLPvB9Hq1IZc9Yrz8T1MoiAEHgjAOZvZ4iNwdgKZWgKljTZ/ASd0HDB2FjclIXpJzASSuw09LcDbqExuYLm1rK5iR/usIJTx33hhd7aztMbZ4CRlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sKfVn-0004LC-Ar; Fri, 21 Jun 2024 16:45:11 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH RFC 0/3] reset: Requesting pre-deasserted, auto-reasserting
 reset controls via devres
Date: Fri, 21 Jun 2024 16:45:01 +0200
Message-Id: <20240621-reset-get-deasserted-v1-0-94ee76fb7b7d@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO2RdWYC/x2MPQqFMBAGryJbG0iCf7xW8AC2YhHMp27jk6yII
 N7dxWKKKWZuEiSG0C+7KeFk4f+m4vKMpjVsCwxHdfLWF7byziQIDrMoEUG0PhBN6ZoyNChCbSv
 SdE+Y+fq2A/VdS+PzvPzQ5cprAAAA
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.14-dev
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
Philipp Zabel (3):
      reset: replace boolean parameters with flags parameter
      reset: Add devres helpers to request pre-deasserted reset controls
      reset: uniphier-glue: Use devm_reset_control_bulk_get_shared_deasserted()

 drivers/reset/core.c                | 103 ++++++++++----
 drivers/reset/reset-uniphier-glue.c |  24 +---
 include/linux/reset.h               | 274 ++++++++++++++++++++++++++++--------
 3 files changed, 289 insertions(+), 112 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240621-reset-get-deasserted-5185a8e4a706

Best regards,
-- 
Philipp Zabel <p.zabel@pengutronix.de>


