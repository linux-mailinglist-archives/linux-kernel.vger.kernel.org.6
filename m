Return-Path: <linux-kernel+bounces-254685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 454B493365E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9785283DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F94134C4;
	Wed, 17 Jul 2024 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cT+EVE30"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD8E57E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 05:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721193886; cv=none; b=Gf3thak+1So3RU4jygky/13Jinp+LOQGvBHKdTMhZmNtDFdTU4/y7CISSpU8zOezkgo7Y2kRnYnPCv353wN4Ux6LG54gviw20IVZJX0jkqWpf4lSpICaGZbrJxATVIahGOfRg4XMjIhXk8EbLCKKKZebgOZZVWgdHxPBOK1mIX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721193886; c=relaxed/simple;
	bh=Vp7p44aMYOx+W/3oDa9KRPvAbAMMO3I7LRS7pOl1nxQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tztuY2bT9gL6DHCQ01gAh0KHYlicrgQm39mxDCzQk8txa6E2/CLxZ7pAbGhavt8OocL41OGLSimx+D7NfUsjYbDlzogXRrbiGttHqQt8proOzIuz1RBYOTI/5OhEwBN5k6IOSlvO6l8n293huRYwDHs6hMvukifUdxBWOP7pqJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cT+EVE30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10677C32782;
	Wed, 17 Jul 2024 05:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721193886;
	bh=Vp7p44aMYOx+W/3oDa9KRPvAbAMMO3I7LRS7pOl1nxQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=cT+EVE30qqDOPx77JlU6a1Rc6BS16f7s8CdRdhMoTqSNwhvY7VCV4u3JSxrT6wqdt
	 CfPSe/EcjaFA6c9jU7sA8YFLz1toAnOM3jxfKxuQXnXZuMm9Mu0pXPQ8OW638zusZ2
	 8xt4QwwvjwFYiRNCiUUoO7JCOeKKvc7U3uVt7gBVRw4LAn0XQ5fr9njx8nfuyXiMA5
	 1duOE+R/RqxmePhI/I5zKlDVSEc/xar5fhCaW6Kk7Dm/OItA7LbK7QowStJ0CwwLd/
	 DLR+hr3jz0KjbOSWLai8q+xeodfSN3lRvyBhx/jcrxfO/6TsLKYA3FjYu1P4+C8YPa
	 KlpoH69Hlbh+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE29C3DA4B;
	Wed, 17 Jul 2024 05:24:45 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Subject: [PATCH v4 0/5] Support alpha blending in MTK display driver
Date: Wed, 17 Jul 2024 13:24:40 +0800
Message-Id: <20240717-alpha-blending-v4-0-4b1c806c0749@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJhVl2YC/33OQQ6CMBAF0KuYrq0ZBmjBlfcwLkoZoBELabHRG
 O5uhYWJIS7/JP/9eTFPzpBnx92LOQrGm8HGkO13THfKtsRNHTNDwAxkAlz1Y6d41ZOtjW05CIl
 lnksoRMpiqVKeeOWU1V2s2Xvfx+PoqDGPZeV8ibkzfhrccxkNyee6+gJhlXlIOHCJQgJI1Arhd
 KPaqImuBz3c2AcJ+C1uPBYwCnVW5ZCTKAtQG0L6X0ijgEWpk0I2pRbNjzDP8xsk0D81PwEAAA=
 =
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>, 
 CK Hu <ck.hu@mediatek.com>, Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721193884; l=1512;
 i=shawn.sung@mediatek.com; s=20240710; h=from:subject:message-id;
 bh=Vp7p44aMYOx+W/3oDa9KRPvAbAMMO3I7LRS7pOl1nxQ=;
 b=+A8fttIjotYhj8wUeKovyfjjqKhR+tv2ri5BcloeuhTVq31xjLyG3wh3H8ppI9q8gkU+M8u50
 U6OUuROaJmgAEsuPzXOHDTTy2Z54rv7ObsgnLk9nciTQ6u+5Db778DJ
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=VRlGZ3diQkQtpDd8fCL9/mx+TpZStm08pg8UPaG1NGc=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240710 with
 auth_id=184
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

Support "Pre-multiplied" and "None" blend mode on MediaTek's chips by
adding correct blend mode property when the planes init.
Before this patch, only the "Coverage" mode (default) is supported.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>
---
Changes in v4:
- Add more information to the commit message
- Link to v3: https://lore.kernel.org/r/20240710-alpha-blending-v3-0-289c187f9c6f@mediatek.com

Changes in v3:
- Remove the Change-Id
- Link to v2: https://lore.kernel.org/r/20240710-alpha-blending-v2-0-d4b505e6980a@mediatek.com

Changes in v2:
- Remove unnecessary codes
- Add more information to the commit message
- Link to v1: https://lore.kernel.org/r/20240620-blend-v1-0-72670072ca20@mediatek.com

---
Hsiao Chien Sung (5):
      drm/mediatek: Support "None" blending in OVL
      drm/mediatek: Support "None" blending in Mixer
      drm/mediatek: Support "Pre-multiplied" blending in OVL
      drm/mediatek: Support "Pre-multiplied" blending in Mixer
      drm/mediatek: Support alpha blending in display driver

 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 36 +++++++++++++++++++++++++--------
 drivers/gpu/drm/mediatek/mtk_ethdr.c    | 13 +++++++++---
 drivers/gpu/drm/mediatek/mtk_plane.c    | 11 ++++++++++
 3 files changed, 49 insertions(+), 11 deletions(-)
---
base-commit: 8ad49a92cff4bab13eb2f2725243f5f31eff3f3b
change-id: 20240710-alpha-blending-067295570863

Best regards,
-- 
Hsiao Chien Sung <shawn.sung@mediatek.com>



