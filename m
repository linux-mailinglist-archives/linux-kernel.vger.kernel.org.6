Return-Path: <linux-kernel+bounces-518475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 024A2A38FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E40D3AAAA1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 23:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689ED1ACECB;
	Mon, 17 Feb 2025 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZz0hGjX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93F717A5BE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739835805; cv=none; b=DD786DcN5ICtHkMnkV2nrcwCsnG32FVwvvzxy3VSmdB6dtD1M0o5pyWhCqYjkq7WKoOToBEKXb7Wq2GTjSvMp+lZMgcM51GFwQO1JG9qAROQRqFa0yfr3XgLwOHDqTVO54IjwKIEzoDaZy+9yU4lS4ySsqz/qt2oju4QWiKnsbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739835805; c=relaxed/simple;
	bh=N61QqzpcOMoeHWqpfFmlVOvWCLR8YOYOT1A963i1cNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uwTvAzPvZoK4l7SV56Tb4IYMLuhUaChxMdYGAOGb+SVRoXWR0mRy2i5ZF7a6w3RWUSqTFhtjFPqKhdesW7p/daHjBMW27fAhoS3FL+bJY5TsOOvKz4Yjja0b5mdSQ+ISP2SY2gk69DVWbeAMIptxAcv4RYt+bKH5pGMH/kJOkEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZz0hGjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3841EC4CED1;
	Mon, 17 Feb 2025 23:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739835805;
	bh=N61QqzpcOMoeHWqpfFmlVOvWCLR8YOYOT1A963i1cNo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=sZz0hGjXVco0y8h2smR6NENtY+og9Eyw33ICIXehbDL3XrqOefYzx3hJCibxWLYwd
	 tXKODRTSbQxJi9rFBLjR14mk5kj13giEScg297XhPMZyMTj2jrtuNJvE17Y+auzE9F
	 LyOOtFAvWMkYf1/3SJ02cK96M1FzC8VjjJ9jKsSsLZHhE6j9+xlUvrSclAgZ8DE+qw
	 17OdpX/dVinXas0VpLoSiWxgXpLdSt678x3F+aKfj3sl+Kfs1TM+AneVEbiMSsWnV1
	 ZEM/T4JA2cFY/ymILk8SDPurasSWGp9X5P/RRJJJHNMsaSeG0L/NBHGyfzurISFNQA
	 xyG3HbBmHFbhw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5ABC021A9;
	Mon, 17 Feb 2025 23:43:25 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 17 Feb 2025 17:43:18 -0600
Subject: [PATCH] drm/nouveau/pmu: Fix gp10b firmware guard
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-nouveau-gm10b-guard-v1-1-0d96f0068570@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJXJs2cC/x2MQQqAIBAAvxJ7bkG3ougr0cFqsz2koRiB9Pek4
 8DMZIgchCOMVYbAt0TxroCuK1gP4yyjbIWBFHWKdI/Op5tNQntqtaBNJmxo2mZoFS3FICjlFXi
 X579O8/t+8YEsT2UAAAA=
X-Change-ID: 20250217-nouveau-gm10b-guard-a438402b5022
To: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739835804; l=1102;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=f8lb6sJV/0LlAIwBP7HgEJtH0QjoGFU98w+WZTb7n3A=;
 b=zrOqogMmtS+s+z9c0ZTFVovU04FHtGu75y4ymeQgMVFlFom3ckutTmS40FWLi5r9k/jjJ/PqW
 4EB3YkQumtdAcdfBGN24IIENroYNuD0HoEuQDww+AyIotTJtZzd7JP0
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Fixes: 989863d7cbe5 ("drm/nouveau/pmu: select implementation based on available firmware")
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
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



