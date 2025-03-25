Return-Path: <linux-kernel+bounces-576186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69098A70C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32645189A20A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ECD26657E;
	Tue, 25 Mar 2025 21:35:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929581A83EE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938506; cv=none; b=eXuISrgW7FUQ1xAE2IvvHnkObyJPuNW5e2kqPt9LNZxgLnoSGCjiVTRZG/SVmilMPASJfqKaxX30O8DhrV47iS9E+Dtz9nT1iEO4sgkouBMV0yQ3beDp7PoYOFtJBrWV2LDyx75aLsS3wlu7SVd9ZoBNS2EPI/c55cHZuvFSXrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938506; c=relaxed/simple;
	bh=aJxthH/gs783p5sABlUHr+hOns0Po/519M66ZUux8oQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V9+oLbQZQoRc9vinU9gw3joycajtPAhB9QCg54kqgHWeOFAr3MVS0CgdfjCwrKqdNGfOrsAt+AOA0D7Sp6I2gO0q8gOrWupldJiHganmn0fiUAsXd3mg4cq/Z+DSrp7QU+nvMdsHvv3Y4TZpCBlIQEIvfz2YH1pJOhQubmf9X60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1txBvF-0001nz-PX; Tue, 25 Mar 2025 22:34:57 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: kernel@pengutronix.de,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: soc-core: fix remaining of_property_read_bool usage
Date: Tue, 25 Mar 2025 22:34:54 +0100
Message-Id: <20250325213455.3952361-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325213455.3952361-1-m.felsch@pengutronix.de>
References: <20250325213455.3952361-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Replace the of_property_read_bool() by of_property_present() to avoid
warnings which are triggered since commit c141ecc3cecd ("of: Warn when
of_property_read_bool() is used on non-boolean properties").

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 sound/soc/soc-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1e0cdd778a3b..34dc24e07336 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3046,7 +3046,7 @@ int snd_soc_of_parse_pin_switches(struct snd_soc_card *card, const char *prop)
 	unsigned int i, nb_controls;
 	int ret;
 
-	if (!of_property_read_bool(dev->of_node, prop))
+	if (!of_property_present(dev->of_node, prop))
 		return 0;
 
 	strings = devm_kcalloc(dev, nb_controls_max,
@@ -3120,7 +3120,7 @@ int snd_soc_of_parse_tdm_slot(struct device_node *np,
 	if (rx_mask)
 		snd_soc_of_get_slot_mask(np, "dai-tdm-slot-rx-mask", rx_mask);
 
-	if (of_property_read_bool(np, "dai-tdm-slot-num")) {
+	if (of_property_present(np, "dai-tdm-slot-num")) {
 		ret = of_property_read_u32(np, "dai-tdm-slot-num", &val);
 		if (ret)
 			return ret;
@@ -3129,7 +3129,7 @@ int snd_soc_of_parse_tdm_slot(struct device_node *np,
 			*slots = val;
 	}
 
-	if (of_property_read_bool(np, "dai-tdm-slot-width")) {
+	if (of_property_present(np, "dai-tdm-slot-width")) {
 		ret = of_property_read_u32(np, "dai-tdm-slot-width", &val);
 		if (ret)
 			return ret;
-- 
2.39.5


