Return-Path: <linux-kernel+bounces-419668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 567AF9D7133
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 14:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BE9CB3D8E8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 13:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C231AC459;
	Sun, 24 Nov 2024 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzMDneQV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659421ABED7;
	Sun, 24 Nov 2024 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455205; cv=none; b=CSDpmkZejMhBc+l4t6V3Rn7aI0wm6mzTiYPxLeCoWrQNfB34g8TLcVbREfprxckpZSQiov6L0J210KqSeI4tzOExGp27CH3rz5IchWkYgcRem/OV/2YNK/vfo8ZiY38XBXKTAhIFay2zJeTX5X0qF5HPE7oaG/nUEkQ8HcXlNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455205; c=relaxed/simple;
	bh=3Q1VHE7YOzhFgexy8xYhyUdaAgdonAZxWGYEJwOtv88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKtzgJCHR3430sOwhho4fyAiMuba3NYs8feMYwyLCk5Hv7R8JmY6aqQU8eA2aTL7JyQIIDiKejCDenlWcdETIgp2l2VACTNHCPz8cUAMsrFyp1QCoUShQ6e3OlT7ZDUyyIx6fscjXmKVGO4QUu6PoHdir6P3p63hcupbp7SkQj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzMDneQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4B8C4CED1;
	Sun, 24 Nov 2024 13:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455205;
	bh=3Q1VHE7YOzhFgexy8xYhyUdaAgdonAZxWGYEJwOtv88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BzMDneQV8WVnqJTwylpBYmd58xE1iyGc7Q2m06a0VdL7Jv4uMw5l7nufAwrz5NlHR
	 mJnvwr3A3zXYw+KjmsgRrCskewmsJA7RFABL5GNsiobh0lCNwFbkzY5GFU88TRYkMt
	 pp07vkYUYpn6EAi6yXarwwP/NZxuE6+OzubXT70Dc7dvMVXrq/U8forLaPnrptBkgK
	 elr9d7wDpRg9+jxzBaZIywDbaiE+tLPTN12CRulz+WHaHDVFPtUi1OBHMBLwdMjpce
	 4AcFrF0THYfCOESqqR0STxG9Amb299qG+dpA0coi25NkZcKhOsbF8Zk33VgvwvEeDx
	 NpYtU/Vyo1cgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= <samsagax@gmail.com>,
	Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 012/107] drm: panel-orientation-quirks: Add quirk for AYA NEO GEEK
Date: Sun, 24 Nov 2024 08:28:32 -0500
Message-ID: <20241124133301.3341829-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Joaquín Ignacio Aramendía <samsagax@gmail.com>

[ Upstream commit 428656feb972ca99200fc127b5aecb574efd9d3d ]

Add quirk orientation for AYA NEO GEEK. The name appears without
spaces in DMI strings. The board name is completely different to
the previous models making it difficult to reuse their quirks
despite being the same resolution and using the same orientation.

Tested by the JELOS team that has been patching their own kernel for a
while now and confirmed by users in the AYA NEO and ChimeraOS discord
servers.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/40350b0d63fe2b54e7cba1e14be50917203f0079.1726492131.git.tjakobi@math.uni-bielefeld.de
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 01a33d33c4aaf..4a73821b81f6f 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -208,6 +208,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_PRODUCT_NAME, "AYA NEO Founder"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYA NEO GEEK */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "GEEK"),
+		},
+		.driver_data = (void *)&lcd800x1280_rightside_up,
 	}, {	/* AYA NEO NEXT */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-- 
2.43.0


