Return-Path: <linux-kernel+bounces-226197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F2A913B66
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 15:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449291C20CAC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 13:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA28419ADB6;
	Sun, 23 Jun 2024 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFld02+r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317DE19AD97;
	Sun, 23 Jun 2024 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150334; cv=none; b=CftEID/PMtG3CZfA6nSpLVx7iS1k9sNitagFD9an5iaGMyEKehGfyOswja/RQy3UpulyhztAKGrmYifM5novcZ9jPcWUdArr3Wj+EWA7ZZJnTdYX53RnXpOw7LBOsagYyDkaQDv27vLjS8K867PM2qZyGPM/3uX+yBg4GkwQ9yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150334; c=relaxed/simple;
	bh=4nkdyw11JFFQf6jwYWNjBj2N7W+HZsqxpLYv6cEgvGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bO+K/bilhipzo6YMWsFXHEBwizXasIXJEoAn2OTK/Q6OLQAKttv/ysd9Eu2O/n52hZ6a4bQzp4wGkfSXIkE2zdq4sEOwns+VWRqxSazehspm/Xox6DZs6ICYnprNRkd0J1LCZa4MMwGTL2qUric3jxgTxOrAJaAsuxED5sSgZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFld02+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB603C4AF0A;
	Sun, 23 Jun 2024 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150334;
	bh=4nkdyw11JFFQf6jwYWNjBj2N7W+HZsqxpLYv6cEgvGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LFld02+rV6ekiOKHWWZFAnY8VlvS/CChEF2zn5h9OXfYRY7MUPM7Y3hdRMes79f3x
	 M0WRVbtBqp0ACbO5iM35R5XetNwysyiFrwLWX4OlnisZlwjP/AFwN/Lyy9P+bOczd9
	 K8/ZNdd/5sOBRPh0OlNDVMSMiw2oGvldR1ZP1sD3adTVy+iN/VrBaHyVh/i0Xy8Kjf
	 zw3anb2y6we+Wn6gVBUz9B1NnBfSuhu7cgCJUls1rmF0BAkhoBhzNMTJ1HxDAfKK0u
	 e3BiqNTnP56kimCEbIfgO4HJWhmhG52VUfXtR0YqNt8MMkagLLQMLyoiUSnnT4mWr1
	 oRzeunioaS+9A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 10/12] drm: panel-orientation-quirks: Add quirk for Aya Neo KUN
Date: Sun, 23 Jun 2024 09:45:13 -0400
Message-ID: <20240623134518.809802-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134518.809802-1-sashal@kernel.org>
References: <20240623134518.809802-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.95
Content-Transfer-Encoding: 8bit

From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

[ Upstream commit f74fb5df429ebc6a614dc5aa9e44d7194d402e5a ]

Similar to the other Aya Neo devices this one features
again a portrait screen, here with a native resolution
of 1600x2560.

Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240310220401.895591-1-tjakobi@math.uni-bielefeld.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index aa93129c3397e..2166208a961d6 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -202,6 +202,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "NEXT"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYA NEO KUN */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
+		},
+		.driver_data = (void *)&lcd1600x2560_rightside_up,
 	}, {	/* Chuwi HiBook (CWI514) */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
-- 
2.43.0


