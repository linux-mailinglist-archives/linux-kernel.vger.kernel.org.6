Return-Path: <linux-kernel+bounces-275161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF6394813C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13B21C21E2B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A7116D9DD;
	Mon,  5 Aug 2024 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsdTJP3T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63AD16D9A8;
	Mon,  5 Aug 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880758; cv=none; b=mRacYyOaNPKj0JnU2WebTj8BdQQUSWU1FAMNC4rit9Pjo/2+713jmieJZdPFX2r5PrrFDh1tboGRy8MJfKG9JxLIdfwcX2+tKIWQzXPyCMzug2fFGo2JAbdE2ITww5lo8+DXGVtXgEnmEwUsLNB0KdDylaS3nCizZ76sFIbjnzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880758; c=relaxed/simple;
	bh=9ksv/G/aFOuCm5jYIeueKidNCRidn+d+FACT/CaLoco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VecmObCzQcN9AqINrR3GFmVuKxi/70YP+80TFwrsJFaAi9FEtBvco3HNnXvw8NyAW80UzFIKt8us2u3OKfPzDddAaw+3Z5HiFqsYZgThCdLaoG+1Ba8uY1nE02ppIs/+TJDq0C06JW4bihgDQXInwmP+xdEwZ3ZJ153jiQh8FcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsdTJP3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6763CC32782;
	Mon,  5 Aug 2024 17:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722880758;
	bh=9ksv/G/aFOuCm5jYIeueKidNCRidn+d+FACT/CaLoco=;
	h=From:To:Cc:Subject:Date:From;
	b=jsdTJP3TPkdZvYzHgwTwO1itvvEzA6DWLBQeapwGdof7bO7MA0ltFFQTWcFoQbxCw
	 TPvGjH+TqxG6qwccmlBX/IhMWQ8jmW+WoWm06oHC6ZW7QzJTBcUaE22CeDyX/hBd8g
	 VWdUD1adWekF2vIs5lQKq82sXd9G6ZxwRYXOHO9WX8x9q9M4Z1TbY/7UbXw2WCef33
	 JceKftE5gjybR6xXDf2xcaixX2VLBa358Ezw7N0YmcYFf7K7FWplsWXWo531MCMdnh
	 Dq5G41xOKJr37ClKIG8bn0JLZDxEgIWltj2sTmqQ+XJ0QSxjX+Aad4XpsUpLlkK8e0
	 Z63Kmegm3rnKA==
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
Subject: [PATCH AUTOSEL 5.10 1/4] drm: panel-orientation-quirks: Add quirk for OrangePi Neo
Date: Mon,  5 Aug 2024 13:59:08 -0400
Message-ID: <20240805175916.3257027-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index 43de9dfcba19a..f1091cb87de0c 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -318,6 +318,12 @@ static const struct dmi_system_id orientation_data[] = {
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


