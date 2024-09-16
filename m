Return-Path: <linux-kernel+bounces-330696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CC497A2D5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFC21C21FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9292D155322;
	Mon, 16 Sep 2024 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="MZ+kEfpq"
Received: from smtp1.math.uni-bielefeld.de (smtp1.math.uni-bielefeld.de [129.70.45.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D094A155352
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726492835; cv=none; b=IjYHCncKCWU//fHEggImaSA7rR7mT8HIEP7tLZ7VN5oiKDy2rWB4ulB5Gd4rFPp3IGKeMMNh/FGuhiOkyoOVNDs7RazcGlxONSIyTWQOHHL/qp1BupbGKOZjp5wxYaGQgIyU34NLmuZM1DktYeOTOSUFKvQNNxtKT+Q0q+HGzRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726492835; c=relaxed/simple;
	bh=1+TT6VGnYhNjqiR9MTCYSA9nIQtx7OKbu6pDyhL6JLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZEbc5LT38O4tSmwkwn0Z5kMi7vn5HrRCVBc6+afEM9E5hWqJQPhSzwk2VwayyMZPoXK6ANSXAI+hc9u+IHWN72vTN1F7uybOszf0BNQBi5+w554GsFabJDZE8rGz2ClKuA9X6oewEr48QlvcifipTmvSlera9Kn3vB0SA0woYa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=MZ+kEfpq; arc=none smtp.client-ip=129.70.45.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1726492830;
	bh=1+TT6VGnYhNjqiR9MTCYSA9nIQtx7OKbu6pDyhL6JLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZ+kEfpq+o95Tfb2S2EuUhvCXRdrbXq0BRL6EWnJgML3Czxmplax8DxD9Imn44BU3
	 jNyzOIWjuScOIJFRlFAs9jtcRoyncFg7kyI9hJWZXF3n2ilqsyJ6xaOiktfmUQ0jLT
	 md3ReGIfH22gogWc2JwFJCBbJkkwuXSdMyI+iVWutoWB10w1LNBIdKebKaRTMTe5NL
	 n5V6pX1UfwcPjFrjEETU1Dn4QoQS9bWZjgXksVNIk7OyJa/GO9JY/ivIqYZine4EJr
	 R28FfYslrS5Lx/RFQqfbMqf3ybeTzWWIkz6IT9as1aa3JFu1YfUCtyCBLMYS554xFZ
	 1ndmGh/wpSzZg==
Received: from localhost (dslb-088-074-203-146.088.074.pools.vodafone-ip.de [88.74.203.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp1.math.uni-bielefeld.de (Postfix) with ESMTPSA id 826B32066F;
	Mon, 16 Sep 2024 15:20:30 +0200 (CEST)
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
Subject: [PATCH 1/3] drm: panel-orientation-quirks: Add quirk for AYA NEO 2 model
Date: Mon, 16 Sep 2024 15:18:51 +0200
Message-ID: <2b35545b77a9fd8c9699b751ca282226dcecb1dd.1726492131.git.tjakobi@math.uni-bielefeld.de>
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

Add quirk orientation for AYA NEO 2. The name appears without spaces in
DMI strings. That made it difficult to reuse the 2021 match. Also the
display is larger in resolution.

Tested by the JELOS team that has been patching their own kernel for a
while now and confirmed by users in the AYA NEO and ChimeraOS discord
servers.

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 2166208a961d..3044927c0c5c 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -184,6 +184,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T103HAF"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
+	}, {	/* AYA NEO AYANEO 2 */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
+		},
+		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* AYA NEO 2021 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYADEVICE"),
-- 
2.44.2


