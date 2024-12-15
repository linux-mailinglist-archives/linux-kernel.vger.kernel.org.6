Return-Path: <linux-kernel+bounces-446452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D329F2473
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 15:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95F81885F88
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899FF192B76;
	Sun, 15 Dec 2024 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Ef9Jb+aZ"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033E18C932
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734274160; cv=none; b=L3le375ZRGlFMTzUprvahEFXF81eqVC5xoamUsdTKDwO5PakUfmPRwLBhyzqTNyjKkO3wxyrNA/0/EEx4roZFDrjlompxsKvl00Lx24EJz1oY+bLkqeB6UDwzKL37L3dK3lxQ9aC2Fqay7l7WMKwS9N/HWhCCPtFmq3nE+/c+YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734274160; c=relaxed/simple;
	bh=0Z7Ii0LMsuPHFh88dP5q1oM9lHxsCesmSgUeYW9+ErU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TimAeVVHkG9eASaVEoi/7ttWleOgG0NBplI/jyyqypyoeUo3VxlENA4hEwiJAXlzdqlD3eo8nvdV3pBIWZl/hYT5lyszDiuJrB2CtEjlqQRwXT+uC100UI5VMbijEAEhzjeLr24vNFyVYz6v1bF9iHgw7LM/YbvOVVgM47NRab4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Ef9Jb+aZ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734274154;
	bh=0Z7Ii0LMsuPHFh88dP5q1oM9lHxsCesmSgUeYW9+ErU=;
	h=From:Subject:Date:To:Cc:From;
	b=Ef9Jb+aZiOjh6VQCCoeCJdVvGkwslTX34Rw6tHc6lEJH6y+dRwvjXpRYaxoE+PWEY
	 zKsvxZ78s6chWYV45Y/d+Z0FOapimxAnG5p1HuXtUs2j9bIPuA+2/My/kfOPn8VnGY
	 U/nEj6qSGrP2SZO+YS6/rkmsD06S2SGouuax1Dr4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/4] firmware: google: Constify 'struct bin_attribute'
Date: Sun, 15 Dec 2024 15:49:08 +0100
Message-Id: <20241215-sysfs-const-bin_attr-google-v1-0-e5c2808f5833@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGTsXmcC/x3MUQqEIBAA0KvEfDeQWkRdZVkWq9EGQsORpYjun
 vT5ft4FQolJYKwuSPRn4RgKVF3BvNrgCXkpBt3oVmnVoZziBOcYJOPE4WdzTuhj9Buhtq41k3H
 9YAjKsCdyfLz753vfD6cOBINtAAAA
X-Change-ID: 20241215-sysfs-const-bin_attr-google-2af43b3f793e
To: Tzung-Bi Shih <tzungbi@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Julius Werner <jwerner@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734274153; l=1055;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0Z7Ii0LMsuPHFh88dP5q1oM9lHxsCesmSgUeYW9+ErU=;
 b=e78bYtaovMDTT7CsnLZWJJV8/28yfSr5zElnJur8PxDQ4+eKQP0ScHQ7nbnmn7QUaFyh/VG9z
 jvK5KOT3KyLAH3RfbYTeS7juaXfOq5Si+FCQFSFye6C2GjOD3KJT5xc
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Please also note the remark at the end of the vpd patch.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (4):
      firmware: google: cbmem: Constify 'struct bin_attribute'
      firmware: google: gsmi: Constify 'struct bin_attribute'
      firmware: google: memconsole: Use const 'struct bin_attribute' callback
      firmware: google: vpd: Use const 'struct bin_attribute' callback

 drivers/firmware/google/cbmem.c      | 10 +++++-----
 drivers/firmware/google/gsmi.c       |  6 +++---
 drivers/firmware/google/memconsole.c |  4 ++--
 drivers/firmware/google/vpd.c        |  8 ++++----
 4 files changed, 14 insertions(+), 14 deletions(-)
---
base-commit: 2d8308bf5b67dff50262d8a9260a50113b3628c6
change-id: 20241215-sysfs-const-bin_attr-google-2af43b3f793e

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


