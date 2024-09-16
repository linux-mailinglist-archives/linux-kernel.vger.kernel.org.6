Return-Path: <linux-kernel+bounces-330697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA4A97A2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769A3286C04
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF91215574C;
	Mon, 16 Sep 2024 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="psnQIEix"
Received: from smtp1.math.uni-bielefeld.de (smtp1.math.uni-bielefeld.de [129.70.45.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00941862
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726492914; cv=none; b=Rx/FZbrAdXiRi6s9dlhb39tNZxMLA5Xjw6qjPmDZSeTeC4zgEBWBUOg8QyR9wsoafN8MfnN6angMGlN493i1WLpfH156/9gEDTUNa+CUn/pbR6PIgNjBfrPF4irOc/m2/t9r8/WKwQtjC6piXxuehlGITRkH96w4SVM2YLICcVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726492914; c=relaxed/simple;
	bh=PtaU0PjHbdO0sNN5fkkU0y+2eRLBqNws1vmyaaveI8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4Na36gqB2w4nICzMyxK1qXhsZ7rhrLt7044s3Azr1Agjho654TUvtj00x7U9G4J2/Rp1KlgOeQ4Nlvko3+Buof1GMdoK3z29bW8tXHToMl3LlOiMqewtAn5C+69IxyQNtWBFmCYULo8GhcPXGl+SXD14l7SC1G74Db5hxhNHPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=psnQIEix; arc=none smtp.client-ip=129.70.45.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1726492911;
	bh=PtaU0PjHbdO0sNN5fkkU0y+2eRLBqNws1vmyaaveI8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=psnQIEixxGf2tCi1GG70W2MZrh2YralcgBdSvUZN6DnbfHr1rq1BivNKsB9CX9vsx
	 3h+nX6pg4Fmt0qWh5NW2BOFnXiJtF8QvbsRGvAo1g3YMFQPSSup2cQsK6u5nGNtDab
	 pssRWJFrqPuz3arFqQ7PRk54ZLoNy9//vjCLo5bmds6/yPGPZPx8aZK/tyOBtZ8qJJ
	 D7q3FhxbMaiSJVT3Sx7BS7QEv6DQ5R8uvrSAASRR9x0j0AQCkvCm3IXiWXOc7agQnW
	 +HXcUOOniUjOaLuuTbdMPvu73I42AvQsH/E/UxG5HTy2R0pRpP8QtmuAPuLt8yyY6J
	 9vWKT8EZgsy5Q==
Received: from localhost (dslb-088-074-203-146.088.074.pools.vodafone-ip.de [88.74.203.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp1.math.uni-bielefeld.de (Postfix) with ESMTPSA id 118262066F;
	Mon, 16 Sep 2024 15:21:51 +0200 (CEST)
From: tjakobi@math.uni-bielefeld.de
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= <samsagax@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Denis Benato <benato.denis96@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] drm: panel-orientation-quirks: Add quirk for AYA NEO Founder edition
Date: Mon, 16 Sep 2024 15:18:53 +0200
Message-ID: <f71889a0b39f13f4b78481bd030377ca15035680.1726492131.git.tjakobi@math.uni-bielefeld.de>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <cover.1726492131.git.tjakobi@math.uni-bielefeld.de>
References: <cover.1726492131.git.tjakobi@math.uni-bielefeld.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joaquín Ignacio Aramendía <samsagax@gmail.com>

Add quirk orientation for AYA NEO Founder. The name appears with spaces in
DMI strings as other devices of the brand. The panel is the same as the
NEXT and 2021 models. Those could not be reused as the former has VENDOR
name as "AYANEO" without spaces and the latter has "AYADEVICE".

Tested by the JELOS team that has been patching their own kernel for a
while now and confirmed by users in the AYA NEO and ChimeraOS discord
servers.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3044927c0c5c..d1302123071e 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -202,6 +202,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_PRODUCT_NAME, "AIR"),
 		},
 		.driver_data = (void *)&lcd1080x1920_leftside_up,
+	}, {	/* AYA NEO Founder */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYA NEO"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "AYA NEO Founder"),
+		},
+		.driver_data = (void *)&lcd800x1280_rightside_up,
 	}, {	/* AYA NEO NEXT */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
-- 
2.44.2


