Return-Path: <linux-kernel+bounces-275118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ADE9480CA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DFC3284256
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31DD15FA78;
	Mon,  5 Aug 2024 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgurIWvR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE7616078B;
	Mon,  5 Aug 2024 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880584; cv=none; b=AYlfN8HivRsU8qAS+ViRrUPSi8UpueR/XpdM5UdOci/+0BTvRL8QQE70ASo77vqyGKGvNS3CnXHxDRqv6iHmDgoWaDws/AbdGRXIWpf5QrqtONMTaacFFZf5V3OSL14z4M1RNCVn9UqYemX4oZyH4JD8Aqs5WL6kXB9ZiV9WdE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880584; c=relaxed/simple;
	bh=J4+/V+Dwdmxq8qixafP9CQPt188IMuIWGxzlQP8L6Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8KDM9F3XNK+Df3zA9clM5gEMO4NJ9Eil3KC9JU0++Cjj9uPH9VjA1EWpyVYINPfsKEz/WKkXOYcrisFRiunJynJ6OTKH6jQ5j8mGRf3HKIc8Q778VZvt9Fv7ZX2qK6cyWfuddDXOpZQfn3XEx42AwfEKS2FxQUT3Geb2NqEtbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgurIWvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113F8C4AF11;
	Mon,  5 Aug 2024 17:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880583;
	bh=J4+/V+Dwdmxq8qixafP9CQPt188IMuIWGxzlQP8L6Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hgurIWvRotW6aHU/yH6l6A+7rHmaGBu22APPNlMkrJ0W+AS+nqtIS4/Cw1TqsI8c4
	 NClQE0k93Dy/GZjQaNQn7R51Btnlr1jc9XJjQl+ohSkGNWXo2x9+U2DRdixiG9Q/VF
	 OsUICUjnMepVwPK5LsRdJhZfp4DjRb1kAtkX+kI1s9N1Ag/2QnXTF0uLGfdk7yGtJC
	 bnpt3k6eZ5f++WSVjuSJ1KGTQRlYxerQgIv+KElwmh8Q2KzTnWj6thdTp2MAwKBRi/
	 XD30X5ca3R7Z+7y3THOwNBPBou5EUu5qrhRsOsLu5NIrQAXTUaAyx91d9/FM2lIFXN
	 1zmWEDx+ATR/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Mueller <philm@manjaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 02/16] drm: panel-orientation-quirks: Add quirk for OrangePi Neo
Date: Mon,  5 Aug 2024 13:55:34 -0400
Message-ID: <20240805175618.3249561-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805175618.3249561-1-sashal@kernel.org>
References: <20240805175618.3249561-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.3
Content-Transfer-Encoding: 8bit

From: Philip Mueller <philm@manjaro.org>

[ Upstream commit d60c429610a14560085d98fa6f4cdb43040ca8f0 ]

This adds a DMI orientation quirk for the OrangePi Neo Linux Gaming
Handheld.

Signed-off-by: Philip Mueller <philm@manjaro.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240715045818.1019979-1-philm@manjaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3860a8ce1e2d4..903f4bfea7e83 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -414,6 +414,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
 		},
 		.driver_data = (void *)&lcd1600x2560_leftside_up,
+	}, {	/* OrangePi Neo */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "NEO-01"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* Samsung GalaxyBook 10.6 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
-- 
2.43.0


