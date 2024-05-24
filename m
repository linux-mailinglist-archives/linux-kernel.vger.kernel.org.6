Return-Path: <linux-kernel+bounces-188383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616A48CE158
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D781C210ED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4340A1292D6;
	Fri, 24 May 2024 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="dDYS3wFJ"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B1C127B69;
	Fri, 24 May 2024 07:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716534655; cv=none; b=XEVDKQKimv1K/2QuaGfd42f/5as5O0YPT6xfsJyz5t0JIufrKaEQ54N2BUg3dGz1agtCPA0eF3M5lunAlsxukU+Hdln1vtJ1jEYCFNsm6aFa83Egehah+4CWRaK96R26721dBI2deNfD4hGf1K6jPZ7JbFAvNS9CoYsxY2SmoYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716534655; c=relaxed/simple;
	bh=HXpxaOrRDAPP2CP2iir/hke44+TLFRVRz0rqBRXLEtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A0NBeMPtig+ViHRnvFHjOdSSp7SpTChLQllv0/j8wOP2jF37g8Bndo5Qful5tMLpeTJ3uaugfA5ZfZp6fEDsQb/2EFLF+CoaZAEc8dwi+YPCWhHiIiduSUzWiEsw1Ise6dHBfURmdgDIsGIx7f5L+vDOIlSps2iPAYSfyeoQdHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=dDYS3wFJ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 29EC91FA23;
	Fri, 24 May 2024 09:10:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1716534650;
	bh=c5sIWFFIE6HBCH8g2ES2lCEKcdDGNWDD+aCgSLy4Et0=; h=From:To:Subject;
	b=dDYS3wFJUM0+CjEvqBrgrvjSHuBjb5AWzJ004jLncA/Xzv/0GTj5ZTLGAYJInO50t
	 gAeBj5q3eV9OU3/ndys0xKm0DVxag3bqqL2dufyI6+AmSP9je8bDnxmxs5uos096np
	 +d25E0XLVK3vCj9B7+9gOZIH7FIZSohVrDU3ME32lVFw4XfFFan2I4gXwDEOdg+Ph9
	 Ehfk/ntkBrrKAmnjXoAXcyWvy4c7KwIp2R9OU9xNyLIlBn3VlqpYhFp8nr/13WmW6R
	 Aj/RycMHBeVDhwqsf6ZGWutvnb4VaWcB61yNMKAxAwpP4sv2RzRN+rAII8kA6jUqgE
	 GUN4NNQ5lmnJw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v1 2/2] usb: typec: mux: gpio-sbu: Make enable gpio optional
Date: Fri, 24 May 2024 09:10:34 +0200
Message-Id: <20240524071034.4441-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240524071034.4441-1-francesco@dolcini.it>
References: <20240524071034.4441-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The enable gpio is not required when the SBU mux is used only for
orientation, make it optional.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/usb/typec/mux/gpio-sbu-mux.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/mux/gpio-sbu-mux.c b/drivers/usb/typec/mux/gpio-sbu-mux.c
index 374168482d36..cf44259980a1 100644
--- a/drivers/usb/typec/mux/gpio-sbu-mux.c
+++ b/drivers/usb/typec/mux/gpio-sbu-mux.c
@@ -47,7 +47,7 @@ static int gpio_sbu_switch_set(struct typec_switch_dev *sw,
 		break;
 	}
 
-	if (enabled != sbu_mux->enabled)
+	if (sbu_mux->enable_gpio && enabled != sbu_mux->enabled)
 		gpiod_set_value_cansleep(sbu_mux->enable_gpio, enabled);
 
 	if (swapped != sbu_mux->swapped)
@@ -66,6 +66,9 @@ static int gpio_sbu_mux_set(struct typec_mux_dev *mux,
 {
 	struct gpio_sbu_mux *sbu_mux = typec_mux_get_drvdata(mux);
 
+	if (!sbu_mux->enable_gpio)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&sbu_mux->lock);
 
 	switch (state->mode) {
@@ -102,7 +105,8 @@ static int gpio_sbu_mux_probe(struct platform_device *pdev)
 
 	mutex_init(&sbu_mux->lock);
 
-	sbu_mux->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
+	sbu_mux->enable_gpio = devm_gpiod_get_optional(dev, "enable",
+						       GPIOD_OUT_LOW);
 	if (IS_ERR(sbu_mux->enable_gpio))
 		return dev_err_probe(dev, PTR_ERR(sbu_mux->enable_gpio),
 				     "unable to acquire enable gpio\n");
@@ -141,7 +145,8 @@ static void gpio_sbu_mux_remove(struct platform_device *pdev)
 {
 	struct gpio_sbu_mux *sbu_mux = platform_get_drvdata(pdev);
 
-	gpiod_set_value_cansleep(sbu_mux->enable_gpio, 0);
+	if (sbu_mux->enable_gpio)
+		gpiod_set_value_cansleep(sbu_mux->enable_gpio, 0);
 
 	typec_mux_unregister(sbu_mux->mux);
 	typec_switch_unregister(sbu_mux->sw);
-- 
2.39.2


