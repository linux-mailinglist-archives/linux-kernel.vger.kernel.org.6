Return-Path: <linux-kernel+bounces-243174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D86059292BC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE401F21D1E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D787641E;
	Sat,  6 Jul 2024 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="akN+M8DU"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365B74BED
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264452; cv=none; b=LYd9KQh9NPmxUWw1dyI9xNeuY4unBxpmGzw8b7ZwiMR+JjwrDCvOsyNQQ+mBdWXHrTs8w4yooPa+SRV0d/j/3Qm9WdH3YTihhzjU0mDGXKEotetGIntAQU7zYMpa0cViS45FYgmTCreGEy0sFUVkQSdhakmqwj2qBBLvly0SQQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264452; c=relaxed/simple;
	bh=KmJPYR5LmVanSRda8s/MbbISPHQ91elIY3Ty+C6vhvs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TaKwGcaQ7IjB3/rKqRDp0fYkROXaEYq66ElNCkHsjXmJ9+6JOu9Cy5REkpH0tga2sNFQoCCG/2AVLIx/Xdktyv1mt77Z6bz87WYmEnDB1l6aem5su4bEvr2mL5QtiYV/ascjnO8hgj0epa+iTdDPTfBn6ov2Cp/o7At8Ij98g5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=akN+M8DU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1720264448;
	bh=KmJPYR5LmVanSRda8s/MbbISPHQ91elIY3Ty+C6vhvs=;
	h=From:Subject:Date:To:Cc:From;
	b=akN+M8DUYUhdjxzbK5UKS0Pc6L6bA9rGD9wbfZqpPkBYuf4qwY9ubJGzgomPXN8Oj
	 I+Ev7DPSy/+4VNAM8lVJ4fus+Auz1Nnz4YSbjDE5fG008yFGXCXs2Oq2a1VuuY81lN
	 b/ZRTiODfIBALwOSeePE4ieLZaROzCNPj5IYLH48=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] regmap: add const_struct.checkpatch entries and
 constify regmap_irq_sub_irq_map
Date: Sat, 06 Jul 2024 13:13:40 +0200
Message-Id: <20240706-regmap-const-structs-v1-0-d08c776da787@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOQmiWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwMz3aLU9NzEAt3k/LziEt3ikqLS5JJiXSPTVOMUUwtj4xTjJCWg1oK
 i1LTMCrCx0bG1tQBcYg/wZgAAAA==
To: Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720264447; l=633;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=KmJPYR5LmVanSRda8s/MbbISPHQ91elIY3Ty+C6vhvs=;
 b=XobLqEbKYZHgggpXtJeBEthstZq9VOwuqC6cUKefxHom4Jym3T9ffcT/8WQktwZQYelAzC+j0
 TKvUGP3Z1A8DFJpERt0oRk3i7zlulmmAf1s5HXByMuk74GkggUbwILo
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Some non-functional changes to enable more .rodata structs.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      const_structs.checkpatch: add regmap structs
      regmap-irq: handle const struct regmap_irq_sub_irq_map

 drivers/base/regmap/regmap-irq.c |  2 +-
 include/linux/regmap.h           |  2 +-
 scripts/const_structs.checkpatch | 10 ++++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)
---
base-commit: 1dd28064d4164a4dc9096fd1a7990d2de15f2bb6
change-id: 20240706-regmap-const-structs-25e3d5833d3b

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


