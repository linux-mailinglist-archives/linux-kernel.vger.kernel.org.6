Return-Path: <linux-kernel+bounces-247257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A6892CD37
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7827BB24B81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEF6143C58;
	Wed, 10 Jul 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAjOYz6F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F218512BEBB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600643; cv=none; b=LmsJ+t0zFTHs9LGZLZW99Oja4XhdqXBdgaXbU6B3inwTLSIT6Q7GfoQS+D+yak76hf9BplRY9lrqE54gm5xrKIRJq5ZP74y079/tIjmr8jyjHvWcFgzR8tmeOhscbJRJ7aHkKttrCWuvsizqevWZt8RzHo28uaua59VlNzv5+LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600643; c=relaxed/simple;
	bh=nlmPSyxX9qpxoDNYTGreHvGaR6e8CTjlqGKzsgnia6M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QMVkYLo4EGLCtNmp9rGqZ3KnOofHIDa3+tEI5x7WW6aFzyFQBWcTHRYJHlAfvbm/GE5hy1kOL2CfPCms8n/H2JL3m8QfkLkqt2LMgdqMdLBqvo/cTrzOxsqFcATLoaVT6KaItXZVQxL38oLwEBDQVx7UPsjQQq8G2VcKW9ODrM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAjOYz6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9158CC32782;
	Wed, 10 Jul 2024 08:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720600642;
	bh=nlmPSyxX9qpxoDNYTGreHvGaR6e8CTjlqGKzsgnia6M=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=cAjOYz6Fbq0FNo/yNWXaqCtiOGQGkOChWPaS62jBM65HmAKku8Te7i/TF/CEfj7FW
	 Qxrwfq0qKjatN1ma+kMRNWUYz0v5VIy73aB2dRh6T6yERYqYq2gZqL5FFEEVBQ5gsu
	 FJmqSI5Y2y0cr0tO0Pet6+4unLtxsXnU188f7yMmYCf3kIc/WkSDarf16zhdR7sW4J
	 Pr8Cp9t9ZwtH5ivBVcufAcljVVWyTqn8aW5B4HVGNxLXPMFuRlDbuHP5mULrIvYdv/
	 g1vwta7EGGRuJG1Q8iS4LJQZhLLb1/CK5nxqSNesMTSI14h15ycq6R+1JeIXEhM6Hm
	 C+rTru9AkGn8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CB3C3DA45;
	Wed, 10 Jul 2024 08:37:22 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Subject: [PATCH v2 0/5] Support alpha blending in MTK display driver
Date: Wed, 10 Jul 2024 16:37:18 +0800
Message-Id: <20240710-alpha-blending-v2-0-d4b505e6980a@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD5IjmYC/yWNQQ6CMBBFr0K6dsxQpVVX3sOwKGWkE0shLRIN4
 e5WWL6fvP8WkSgyJXErFhFp5sRDyCAPhbDOhI6A28xCojyjLhGMH52BxlNoOXSASstrVWm8qJP
 IUmMSQRNNsC5r4e19HsdIT/5slUed2XGahvjdonP5X/d/JXF/hrkEBC2VRtTSGon3nlo2E72Od
 uhFva7rDwKqYJ67AAAA
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>, 
 CK Hu <ck.hu@mediatek.com>, Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720600641; l=1214;
 i=shawn.sung@mediatek.com; s=20240710; h=from:subject:message-id;
 bh=nlmPSyxX9qpxoDNYTGreHvGaR6e8CTjlqGKzsgnia6M=;
 b=BdG6PnMbvs0sjxTdr+ziYt58EoMkDr3qc3N4Se8q7d5oHpLOA7lU7oBNSuFkDExAvdlTPqodq
 DaxQKgl/vNUBHQhTqfjD2UutH4EJr/dRwIIiWRPm9uEcGOlBAnA7c/K
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



