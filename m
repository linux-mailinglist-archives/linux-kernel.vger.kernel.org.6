Return-Path: <linux-kernel+bounces-234875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FA091CBE2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 11:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF6328343B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 09:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E62A3CF6A;
	Sat, 29 Jun 2024 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JsLkESlh"
Received: from msa.smtpout.orange.fr (smtp-69.smtpout.orange.fr [80.12.242.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA68140849
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719652853; cv=none; b=MyrTD5BhKF9tQTMcVvXKbRleYKvaCIwEo2U9Y/qqwhAq6SPJewmsBoBYNykGDlBhurFHAZvYWSSVa5nLIHl0Rw9C3tDdh5rOady6/2W09AQM+00sng3XyhSjlHZA/JmMUcOk2q8f2xF6+cm0tCJVR8JUxCIS1rHDm3gah8P4558=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719652853; c=relaxed/simple;
	bh=pC6V2+u2WQ4S8FkLlPfozSbePEASsC7GRAOeIw4oKM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePDZFyWM78Z/6ckF8GSG7aDNF7YpQaL9xZ6L1UXPEB412M9dntXJdojX9R46YKPvYvOF3l/rIwT7vXrIE9LmFCcYEp4DhRCnmMld4BulbiwbPmyMLGs3SEz454XVbQLDwYYLIqEWBf6LHHELIcGfSUzJ7pfNi3bEpKNjilv1xlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JsLkESlh; arc=none smtp.client-ip=80.12.242.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id NUF6sgiHDa7etNUF6s5cmT; Sat, 29 Jun 2024 11:19:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1719652778;
	bh=JpucOAbumbHAvBNa/G5y6qwvaXXu9oGDOGj7Rt8h4IU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JsLkESlhxnCH4AOpFKKtHgC4mDBa19akQInXPCbNnj95NJ8Wci32l/R3/SEs0/nlI
	 OiLuG0aA+55ZKQODcJZw4mqFJ9UnFpn4FvUpHyvFup7F9nWnju5/znFUMaIJzTS7w6
	 s28pwX0JmYGUtr+W+tKGS0QRMKKKqDTyexKkAMd6i1In1HWPt+/cbwZMX4ESMeWeq+
	 hPDwdNa37H4UxaefqvbA1rNT29/LrJOwdvj0YVlTq6KzGTny2nszRyAsH5ZnI8rS8B
	 3xzgGHvDpWMFyDWtafT+lKtwLka6Lw3t6q52x64dw/CgArFoc35nz5pA5My2fjiQgM
	 pULIr6daqPvnw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 29 Jun 2024 11:19:38 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	fparent@baylibre.com,
	fchiby@baylibre.com,
	s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/4] soc: mediatek: pwrap: Constify some data and other improvements
Date: Sat, 29 Jun 2024 11:19:29 +0200
Message-ID: <cover.1719652155.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is motivated by patch 1. The 3 other patches are some
additionnal goodies spotted while looking at the code.

Patch 1 constifies struct pmic_wrapper_type to move some data to a
read-only section, in order to increase safety.

Patch 2 does the same for some int arrays. This helps move about 7 ko of
data to a read-only section. Not that bad!

Patch 3 simplifies code related to clk management. It also fixes an
issue if the driver is unloaded.

Patch 4 is just a clean-up of some messages.

Christophe JAILLET (4):
  soc: mediatek: pwrap: Constify struct pmic_wrapper_type
  soc: mediatek: pwrap: Constify some struct int[]
  soc: mediatek: pwrap: Use devm_clk_get_[optional_]enabled()
  soc: mediatek: pwrap: Simplify some error messages

 drivers/soc/mediatek/mtk-pmic-wrap.c | 125 +++++++++------------------
 1 file changed, 43 insertions(+), 82 deletions(-)

-- 
2.45.2


