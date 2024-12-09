Return-Path: <linux-kernel+bounces-437907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4271C9E9A52
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3BA282986
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD5C223C48;
	Mon,  9 Dec 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XJSysGl7"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50805216E27;
	Mon,  9 Dec 2024 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757527; cv=none; b=nw+dJYJTxpbXBq6UatWqQNJw+06qDtKOcLYFDSxC0D2iCxC9/Tm/0MH2fE0h3DF9f2SIeBap4cgnyv8elTcXfPauNsTOZb6XxrLWODvZVtTsuH8rxy3Xu4VNO6s8xnTFTvU8Y/1ZpmxrHeUeQ4f7zCHMTjxwdObmZ251ACi1fAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757527; c=relaxed/simple;
	bh=ujhvA7+BR+nmPw0JGxSahQU55HLF9c4VmOg6XJE36nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKGOTa3nUdUqWZRCaclirlD/lVCVo7vpSCvQYVCll9RD8ZsOZRTVKmbfkrP0940MGSukG4+EU9nwEsYL/1cK+82UgOe/FHbPUNfhgXguEW2mn/klKV24liTo2HYo1LmMyjEWtraRSXaK3zcDk21RLoP+skeGALF2a11w5Q1hrFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XJSysGl7; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 565C81C000C;
	Mon,  9 Dec 2024 15:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733757517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJOxQ8jWT4sQQnymSLHfN5zi4FNkUE+3+rzULzxbc1Y=;
	b=XJSysGl7krZgHCqcEamL+Uw7b6xn/HuokO14fDt5sVWbcR5PLI8h6xG/sDzTnDSQQ/5DjF
	pQ5MtTXVHpJuDV1ROkklIAsRS9pW4vjj4DuIH4ncEQZ+nFDTiyZ9VijVXvWLoHW3mA4hAq
	T8xvoYRz6kRvOiPnwplFbHSJFqElliLIOeC8GmOw+1swSVhwDQTPx18tlvHlP4uBNqt5eS
	NRDIqA9FyS0LQ4BobNXI0qQ+HdDkQzjluF85+4zFbaokZ5UKLOnqBdusOnIQhxy9Wr7c87
	0GNOqvTX1YAw/arRx0tRNhD8eOvT/eJilA900JASLN/MRyNiTK76h3kdpTTXBw==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Davis <afd@ti.com>,
	Ayush Singh <ayush@beagleboard.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 6/7] of: overlay: Add support for the export symbols node
Date: Mon,  9 Dec 2024 16:18:24 +0100
Message-ID: <20241209151830.95723-7-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209151830.95723-1-herve.codina@bootlin.com>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The resolver already supports the use of the export symbol node.

Add support of the export symbol node feature in of_overlay_fdt_apply()
simply getting the export node from its name and passing it to the
resolver.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/overlay.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 9bceeed45c9f..b69245a50746 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -887,6 +887,10 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  * of_overlay_apply() - Create and apply an overlay changeset
  * @ovcs:	overlay changeset
  * @base:	point to the target node to apply overlay
+ * @export_symbols_name:
+ *		Name of the export symbol subnode of the @base node to
+ *		provide extra symbols. Those extra symbols are used in
+ *		the overlay symbols resolution.
  *
  * Creates and applies an overlay changeset.
  *
@@ -911,11 +915,24 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
  */
 
 static int of_overlay_apply(struct overlay_changeset *ovcs,
-			    const struct device_node *base)
+			    const struct device_node *base,
+			    const char *export_symbols_name)
 {
+	struct device_node *export_symbols = NULL;
 	int ret = 0, ret_revert, ret_tmp;
 
-	ret = of_resolve_phandles(ovcs->overlay_root, NULL);
+	if (base && export_symbols_name) {
+		export_symbols = of_get_child_by_name(base, export_symbols_name);
+		if (!export_symbols) {
+			pr_err("overlay get export symbols '%s' from %pOF failed\n",
+			       export_symbols_name, base);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	ret = of_resolve_phandles(ovcs->overlay_root, export_symbols);
+	of_node_put(export_symbols);
 	if (ret)
 		goto out;
 
@@ -1055,7 +1072,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
 	}
 	ovcs->overlay_mem = overlay_mem;
 
-	ret = of_overlay_apply(ovcs, base);
+	ret = of_overlay_apply(ovcs, base, export_symbols_name);
 	/*
 	 * If of_overlay_apply() error, calling free_overlay_changeset() may
 	 * result in a memory leak if the apply partly succeeded, so do NOT
-- 
2.47.0


