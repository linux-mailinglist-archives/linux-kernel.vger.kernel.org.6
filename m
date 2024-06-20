Return-Path: <linux-kernel+bounces-222413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E28C3910124
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F681F234DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151B41A8C32;
	Thu, 20 Jun 2024 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Kz+Cx5hN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A121A8C1D;
	Thu, 20 Jun 2024 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878088; cv=none; b=tmU5Hj08SgkIln8OHqr5PJEiUUzLqe9V/J/De5Z56eaMCDB0ia5DB+QoxDGV+Yu88YdsmzTcC0Vj7hPxBaXlJwOgqt1wJslJGrlaiX5jzios9Flybgq2yMTjC5u3AZCZoOuGYnlON8HNKNOXUeSlrwamjksypngHqzqa9ggYIOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878088; c=relaxed/simple;
	bh=fcT31yM+NshgIhzfWXghtZi7e3NaZVSVWS2eQeAyGkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/2eMXO9zMB277/JnHJ5p51C9z7n5bglGlL3/L9JySs16Kq4oYp/oMip1Y9Dhtc4BcwTjWc6LETJLHleoczNc4j/51nl65EkLZ8uADCAKjBA6sW74PL+hThaxfwY8Pw2Obb9tx1d1GvV6Gvfnas0GTc2ESyqu5lkb3dAPXjXtoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Kz+Cx5hN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718878084;
	bh=fcT31yM+NshgIhzfWXghtZi7e3NaZVSVWS2eQeAyGkY=;
	h=From:To:Cc:Subject:Date:From;
	b=Kz+Cx5hNFgkqzab9aIBWCYtNRS2+Xat5GTL+bNOLeAqN8o/EJljq7PWQ3i+vE6qbm
	 sUmpW4mCOu9FM4+9loKTixn9/r9e2VNxyWpTCPoLOyweOJ9dXXi/kxz87gP+Q7LuXU
	 xo3MMk0769nV23qyhizW94PH0R8YiJoWrE/xIFr1Lx0zxLarvBEhndesWYxWqPKdh6
	 sYSmRf39xMo5Yjvya641afNrx3EIL8mVY0abFiO57CS7z7mafVprdrvtIMAjFb0JBe
	 FSGJFYp26zWxNeZ8M55400UOqbgMTDx1mlr+EaEer4VRC6+VJO82IyIfzI9aKdysqN
	 nLU7R+gHLgkyA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 213C6378143B;
	Thu, 20 Jun 2024 10:08:04 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jassisinghbrar@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	houlong.wei@mediatek.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 0/4] MediaTek CMDQ - drop clock-names and refactor clock probe
Date: Thu, 20 Jun 2024 12:07:46 +0200
Message-ID: <20240620100750.1075790-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All CMDQ Mailboxes have only one GCE clock per hardware instance:
remove the clock-names requirement and, while at it, also partially
refactor the clock probe code to improve both readability and its
flexibility.

This was tested on MT8192, MT8195 Chromebooks, MT8395 Radxa NIO 12L
and on the MT6795 Xperia M5 smartphone.

AngeloGioacchino Del Regno (4):
  mailbox: mtk-cmdq: Stop requiring name for GCE clock
  mailbox: mtk-cmdq: Move and partially refactor clocks probe
  mailbox: mtk-cmdq: Dynamically allocate clk_bulk_data structure
  dt-bindings: mailbox: mediatek,gce-mailbox: Stop requiring clock-names

 .../mailbox/mediatek,gce-mailbox.yaml         | 11 ---
 drivers/mailbox/mtk-cmdq-mailbox.c            | 87 ++++++++++++-------
 2 files changed, 57 insertions(+), 41 deletions(-)

-- 
2.45.2


