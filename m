Return-Path: <linux-kernel+bounces-247283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF3592CD8D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D63C1F22FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A028217B43B;
	Wed, 10 Jul 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIVsdcf9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E161F158D7B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601575; cv=none; b=YkeYGRI1op74PO3gkdr+GYX+58ffbIujoMMykIb7tRWCGKVnZKBti3gubbII1j5uwr6DGsmkh+3SZyE0I7noET5Xs8LAjlKRf/TFQzQyDm5LBWMD4RgdcjP99UCXO44x6ctrVCpQDxrILwjPiv4vmYweLphbYODUBGwmDD1rYks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601575; c=relaxed/simple;
	bh=PhMCKB+xJTR+gWnIW4XNQs4NwAAVWihotq9v6lufwcc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DxA0670MVv8tr/LArg1s4XbtWg1bsnlFnoCBN9kEDC49dGIaKGaTLPf/3OPawO/nOt+KaNrEmOhjjX1Pn42r45Hcp0l8mgeZIAN+2zo85+RPDtChejfFc5S07Kxv1GDiSdhGH9fbVxpODNrX3LuaEhlqREIg0blM75YqUMfvgyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIVsdcf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 818F6C32781;
	Wed, 10 Jul 2024 08:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720601574;
	bh=PhMCKB+xJTR+gWnIW4XNQs4NwAAVWihotq9v6lufwcc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mIVsdcf9Wq8E3d8aADG4+Ad/topqdU/CzpA38t5GjNHBmlgrzJ7vQPmrlq+1NNZ60
	 5b64GvL5nk4XMFsyiQ3gIVvODP2fIWuRx1Niho4Y1gs9wEg/IYqgi5z4pvkF/tnIwP
	 ux8eyIsDwT5fN74oki5yn5pTldkTGGlFLzDs4O2tI39uMw9cVQymbgHlmqfMlH9aNB
	 d81d/dzO3Pbm6KdNvXnecazvXxfrkwnC5hQMBTMzvrhNy30aBdPOwHjNR+RSH5Hf/a
	 CiRrE4VJu21uxO6COyZLhWcyTgLp18i0fJtXc9v/g03+F8v65/G7kFX9vOw4iu4h5s
	 le0CBuq0+5+aQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CFDC3DA42;
	Wed, 10 Jul 2024 08:52:54 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Subject: [PATCH v3 0/5] Support alpha blending in MTK display driver
Date: Wed, 10 Jul 2024 16:52:50 +0800
Message-Id: <20240710-alpha-blending-v3-0-289c187f9c6f@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOJLjmYC/22OQQ6CMBREr2K6tubzgRZceQ/jotAvNEIhLTYaw
 t0tsDAxLmeS92Zm5skZ8ux8mJmjYLwZbAzp8cDqVtmGuNExMwTMQCbAVTe2ilcdWW1sw0FILPN
 cQiFSFqFKeeKVU7ZuI2afXRfL0dHdvLaV6y3m1vhpcO9tNCRru/sFwm7mIeHAJQoJILFWCJeet
 FETPU710LNVEvAL/jkWMBp0VuWQkygLUD+GZVk+xAF9pv0AAAA=
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>, 
 CK Hu <ck.hu@mediatek.com>, Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720601573; l=1352;
 i=shawn.sung@mediatek.com; s=20240710; h=from:subject:message-id;
 bh=PhMCKB+xJTR+gWnIW4XNQs4NwAAVWihotq9v6lufwcc=;
 b=0Y6YJ9l6hxNTlX0eT4eoJURDFUA2bVcNpmPnbtUiNExoTDahpGjBRDE/4MJ2UbOapU7x5pPeU
 EEEFzTpFXvMBWiv6eU0YelHHmhb3XA8smpTagNVshdUtYeK+kQZXD6S
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



