Return-Path: <linux-kernel+bounces-303584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79639960F41
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243BF1F22305
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388021CDA2D;
	Tue, 27 Aug 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWGWjKPD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1761C6893
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770560; cv=none; b=Kas5PZ5wo5ZSU81z1f7glDuwtgaT3uqpiEb4oNpJ4ZJ5g56E0v7KxMM9hU70XNOBOYRUGe7h7P+qDDOjpEDWEMqcYz1UKZrpZgUNNUxpKznKn5Ri5e5ssCc0tpMJpg5q81iQYqAfrpxXxZY03Tw9+MRepy7pCJpXIT2kGPewUys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770560; c=relaxed/simple;
	bh=QZQ5u0mI5GTvIERqL7sO8uE4R1i9WTqn8mFJ1e8m6Cg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hPeL/rJON0G/kdNL8RPNpMi6o6PVJjYRNQbh9SIpI/qcg2fOo4a3FFUFhQdGy6JpOjqsp8ozaD36lqC4um8uEO3OrUs5RYb+HmnJ+DBV9qgtwXN0x5zflf9FrHXJdAp6dL/Na4xiDLyzYENcj5pFnzsfzKk1GZA9bmns9lR6nxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWGWjKPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5085FC4FDFA;
	Tue, 27 Aug 2024 14:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724770560;
	bh=QZQ5u0mI5GTvIERqL7sO8uE4R1i9WTqn8mFJ1e8m6Cg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=BWGWjKPD/AvbpNJKSvtRj7sGxxg8NP2mnJKLSXpT/MCkEvGdfhcX45YwzSp907+Fj
	 5WzZ8QZmJEPureIe0j5U277lDDnJyo4M24GQGTkPdA9QauhMxhuM5fWW+eeBew9/09
	 AMFcvGjr7wx5mbUaFyhRRLqbTlSA4rEJthfxUEiXvRC8qpTrmmAgvCeEUqTW23Gly8
	 uNKCmneoeoKdQrRRdJlMdhGBYn5mhTA2zQdFbz6l7LqKkY6NxiqWV2RuwYoXxiZC+a
	 +hkiJlwPSqC9kOkjxAWUZKQin4kyyj+4OamshVvEBYs8fzBJyn+4r6PT/ol85MuBzT
	 +200DCkqRtAmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D75C54734;
	Tue, 27 Aug 2024 14:56:00 +0000 (UTC)
From: "Jason-JH.Lin via B4 Relay" <devnull+jason-jh.lin.mediatek.com@kernel.org>
Subject: [PATCH v3 0/2] Fix missing configuration flags in
 mtk_crtc_ddp_config
Date: Tue, 27 Aug 2024 22:55:18 +0800
Message-Id: <20240827-drm-fixup-0819-v3-0-4761005211ec@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANbozWYC/0XMQQ7CIBCF4as0s3YIFA2tq97DuCBlsFMFGqjGp
 OndJd24/PLy/g0KZaYC12aDTB8unGKFPjUwTjY+CNlVQyvbs+xUjy4H9Px9L3jQXxS1Ths/OgP
 1tGSq6xG83at9TgHXKZP9Z4zUSmotO6Gk6jtUONuSIs6TeHEcAjm2Kz3FmALs+w+OtgfXowAAA
 A==
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, 
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 CK Hu <ck.hu@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724770559; l=663;
 i=jason-jh.lin@mediatek.com; s=20240718; h=from:subject:message-id;
 bh=QZQ5u0mI5GTvIERqL7sO8uE4R1i9WTqn8mFJ1e8m6Cg=;
 b=vtG4j8YW0CdzhCv8m6K3/A14B+OP06kMhQBxegBLibqv5A+ThNrS9j9AtzKCmfL5WKoGsUltR
 pkKWr0ek2bACtvFDpM7Yc2/BNhHDyMbTxGxk84DGDUjNJmsCM1zIoJP
X-Developer-Key: i=jason-jh.lin@mediatek.com; a=ed25519;
 pk=7Hn+BnFBlPrluT5ks5tKVWb3f7O/bMBs6qEemVJwqOo=
X-Endpoint-Received: by B4 Relay for jason-jh.lin@mediatek.com/20240718
 with auth_id=187
X-Original-From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Reply-To: jason-jh.lin@mediatek.com

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
Change in v3:
Change config_lock from spin_lock to spin_lock_irqsave

Change in v2:
Add spin_lock protection for config_updating flag.

---
Jason-JH.Lin (2):
      drm/mediatek: Fix missing configuration flags in mtk_crtc_ddp_config()
      drm/mediatek: change config_lock from spin_lock to spin_lock_irqsave

 drivers/gpu/drm/mediatek/mtk_crtc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
---
base-commit: 469f1bad3c1c6e268059f78c0eec7e9552b3894c
change-id: 20240819-drm-fixup-0819-f51e2d37fcd7

Best regards,
-- 
Jason-JH.Lin <jason-jh.lin@mediatek.com>



