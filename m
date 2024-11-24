Return-Path: <linux-kernel+bounces-419949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ED49D73C4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 15:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5888B162B7F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 14:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2581A1E0DE1;
	Sun, 24 Nov 2024 13:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGNI44Wf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F9B1E0DCA;
	Sun, 24 Nov 2024 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456200; cv=none; b=mo31WAT06dD00njvQ0DRpp20C+LTWUH7nkJGRlhkZWrzFJPWl9XPxTkXGNSYxgc7gBhO/Rm2d33IfP+Ki9kL4EuvzWImhUADtSxJUM/UPIVOtMBHP84GF+H/XS57TBxpvpYfs2uZjEwTin6NQWg4sRPdEQXxu5wPeaQB7LYz9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456200; c=relaxed/simple;
	bh=Gfpt/WfrzJ/1Kk4TqUo4RaGL7b1jGBBk5YGmNBjr7mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsfFs6hcro1pZ4v9nwaNcN6e9DjSuILyBdrTKQt/JDQRNIDZBA9ZYIonz/xKc/hTvyitOoT/8aiGLEGG8pJULX35UmDzqvVs4xPn6f5qMTvB2ZmVw8gtdxYZgmozvvVcJC5eW5OB70Y9L4zeOrRWo/cDLi/PQdoS7tvuUt15oRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGNI44Wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DBAC4CECC;
	Sun, 24 Nov 2024 13:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456200;
	bh=Gfpt/WfrzJ/1Kk4TqUo4RaGL7b1jGBBk5YGmNBjr7mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eGNI44Wfu3jBOZGh+YHGtoYkSWalgQcxYF9aO0AWWZo/Xn1IzraAlb3DL9TZ9KHzq
	 SDqa4Kbj6sdk8ePK5lSSG7m9g7VvSDZNQqmoBwgzp3N2JJlMvN0TIlSTMd0Ub+MLdm
	 aXiMrWh/xXMxBFAPgKmOgl9FT3uiZImU04degNZFjTD3osu1VfJk+x2aByQVHy2Eo/
	 mcTvPrEbDDqsgWGywKL4xOB5KgrRTtKj+PwINw/fNrIZjxqBrWY5Xhz4v5vinAZNHT
	 HlTQ7eQ/UGzJEE3fyrXV9VPfUNEfMgFttcJPzEHoZEG1tEqq4yuEfmx8N0L8zbrjyo
	 5D9aySyjpb/Iw==
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
Subject: [PATCH AUTOSEL 6.1 05/48] drm: panel-orientation-quirks: Add quirk for AYA NEO GEEK
Date: Sun, 24 Nov 2024 08:48:28 -0500
Message-ID: <20241124134950.3348099-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index 87ab8009c8fd4..acf2dd02aad14 100644
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


