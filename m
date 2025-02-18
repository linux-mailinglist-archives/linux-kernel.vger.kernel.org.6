Return-Path: <linux-kernel+bounces-519016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F23A3971B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C222C1665C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27E322FE0C;
	Tue, 18 Feb 2025 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMK47/Sm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1DE22F166
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870891; cv=none; b=QYuJEZcXs5RosO5SlC9kgT/715BNmopnAGn+VO6Evm74b1xrO3oyRBhZDerjq2/OsbFbTOidcZ6i0Y/b5OG2FeBvrnZa5guy4TXTu2ujxcUlVI7k+gfOJFSDPbdEXfNQrzrolDPKh/e2AvkerH8Q4KWlDsb6GEfxuvJYVtfcSRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870891; c=relaxed/simple;
	bh=nTDz2H8bAQQHerq28wSLdq0QqWnMKAumb1JZb4bf3Gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c2KCB3wJTFYuo/8PheB0otXS3HyAIQ8WE8A3MMmHSyzLKD/xEpEH4meBJgGUc4bUZlNHncKOD9tqGxf9shjNy8/QBVWud1eoFSsE3Jsp5CIKTBqYUq4+ySSbfwi+sAIhoRxrLyBVidVP8oz2sP8MDK8I6MJKh45KKQN6l+c2FKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMK47/Sm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE1E2C4CEE2;
	Tue, 18 Feb 2025 09:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739870890;
	bh=nTDz2H8bAQQHerq28wSLdq0QqWnMKAumb1JZb4bf3Gw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=oMK47/SmtupzDs0fY30DFG/ZfykMmjsrjGX+ctO55teDSs+/bhp5VPNV4QXRcf3fJ
	 kKTR8mSl8Gi9rNd2yYHYJmWpLgnFW5RKbk837IJj1df2LxPFv2NyTs03WyMG+Ao+DT
	 YqwLNCVrqFwlPP/48vUjkwQZhXHQjAxmkrpQFXaTI+mWzXtovyfz/Pw9m7gWaCBF8A
	 t+CvbEEtsMUwyWZpIkSzAbObz2zelhDiamiah5bK0ZKDovaEJbhSVVSpo3oKSuWCWj
	 Pf3NcD7q6OYTZlgQbmYuaj01DhhZVQ+SmFTu3Obb9xFjIw+bAIHrgBKtk3iW0zTMCQ
	 PpDev5jjlQMNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15F8C02198;
	Tue, 18 Feb 2025 09:28:10 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 18 Feb 2025 03:28:03 -0600
Subject: [PATCH v2] drm/nouveau/pmu: Fix gp10b firmware guard
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-nouveau-gm10b-guard-v2-1-a4de71500d48@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKJStGcC/32NTQ6CMBCFr0Jm7Zhp5U9X3sOwKLSUSSwlrTQaw
 t2tHMDl9/Le9zaIJrCJcCs2CCZxZD9nkKcChknN1iDrzCBJViRFg7Nfk1ErWieoR7uqoFGVl7Y
 k2eeGhLxcghn5fVgfXeaJ48uHz3GSxC/970sCBZK+1iNR3VYN3a1T/DwP3kG37/sXkW7/abYAA
 AA=
X-Change-ID: 20250217-nouveau-gm10b-guard-a438402b5022
To: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739870890; l=1447;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=oUmXAASwstZ9XuCaJCBOKOPtkuHQeVnyTw6zIVfBoIM=;
 b=Lc4eulMZkHiDkKi6LmyfgLQk8uAW71n7exKAE83hBn0tADQ7hyCGlswDiVHvEmbVq2f8Kpa5s
 wlo7lYLG0dRBUP99CQs/v4eg5jVp+iZh9casmSptBVFutS7WfmrcHQ7
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Most kernel configs enable multiple Tegra SoC generations, causing this
typo to go unnoticed. But in the case where a kernel config is strictly
for Tegra186, this is a problem.

Fixes: 989863d7cbe5 ("drm/nouveau/pmu: select implementation based on available firmware")
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v2:
- Updated commit message to include a body
- Link to v1: https://lore.kernel.org/r/20250217-nouveau-gm10b-guard-v1-1-0d96f0068570@gmail.com
---
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c
index a6f410ba60bc94ec9d52fc78868acddfc6770e19..d393bc540f8628812990dffe4c2f7e9014be07c5 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c
@@ -75,7 +75,7 @@ gp10b_pmu_acr = {
 	.bootstrap_multiple_falcons = gp10b_pmu_acr_bootstrap_multiple_falcons,
 };
 
-#if IS_ENABLED(CONFIG_ARCH_TEGRA_210_SOC)
+#if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
 MODULE_FIRMWARE("nvidia/gp10b/pmu/desc.bin");
 MODULE_FIRMWARE("nvidia/gp10b/pmu/image.bin");
 MODULE_FIRMWARE("nvidia/gp10b/pmu/sig.bin");

---
base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
change-id: 20250217-nouveau-gm10b-guard-a438402b5022

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



