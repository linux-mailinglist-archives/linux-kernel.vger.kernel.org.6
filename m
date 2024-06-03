Return-Path: <linux-kernel+bounces-198791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2838D7D76
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDA91C2231C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A5274069;
	Mon,  3 Jun 2024 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="z7L+3c+Z"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE69C5B5D3;
	Mon,  3 Jun 2024 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403784; cv=none; b=dnsPGcTGnFyK96xndrQ/+E6je+21I6efaPbZuUAliRiQhST/P32Qiu4/nWRrMyS7YHbQ2f0AK9gwk8a4u54nenMpNY1Or2lE2qBasFsbRml0liqmuTec3VL6SKsthEtqCXIUsoABB0Chxr8LdQULk78bkJZY2ViNxT62xXqf9Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403784; c=relaxed/simple;
	bh=SjSnyJI/iMOQgwnrgExy7VarJd7DNOzblUnaTzUdmOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IH8ifG58sn95szchzaDqt6MM17Ygteb4O2ivVmgimZpyU9MSX29dWvYfUw2Nf04XRpUOvb7DqtFBxS2mVgUe6RMtfoIkJn3V2CnuIVD7d8CrsMiOZjNUnsbXLnn+MZQYb8h5PjcnfTbYWHLdvKxW3Jx0FhjHRGJrPBhNyh9TUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=z7L+3c+Z; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 324531FA0A;
	Mon,  3 Jun 2024 10:36:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1717403773;
	bh=FvTv0UUCUSa1ZKHUBhrFYAND7vgH3Rp2IDvUAdHC24A=; h=From:To:Subject;
	b=z7L+3c+Z9u/PkRfVuGZLUkBKXzzdDABDCTJeQqijXnxHptNkSBaPbGRNlfgubJT0N
	 oWc+XqQK/dhTDmoCd6mMPdPqGFGZEAERIc4k5QdRm1kh3/qpBCFJFFRBMJSDkKBYGP
	 w36p15bGGt9XwXqtu/xmKk+TLfpK4xnnPm/Z531j6QGlcV3CFXyVPQiduP5Yjtg1Ym
	 Av2KTbAQvZFbzcrgC1UGWS1UTsjULuMKzSGlkFouHeHkO5iKDUgUJm99RJa7hXex6+
	 wCSreLzJM5lyisF36GsFvQKWJ8nkAdp6ruJ2EdCFcBfL0ZsdmLmfBe6h8yYEYSnP+E
	 j/U/nC/Fcfy4w==
From: Francesco Dolcini <francesco@dolcini.it>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v2 2/2] usb: typec: mux: gpio-sbu: Make enable gpio optional
Date: Mon,  3 Jun 2024 10:35:58 +0200
Message-Id: <20240603083558.9629-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240603083558.9629-1-francesco@dolcini.it>
References: <20240603083558.9629-1-francesco@dolcini.it>
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
v2:
 - removed useless NULL check for optional enable gpio
---
 drivers/usb/typec/mux/gpio-sbu-mux.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux/gpio-sbu-mux.c b/drivers/usb/typec/mux/gpio-sbu-mux.c
index 374168482d36..8902102c05a8 100644
--- a/drivers/usb/typec/mux/gpio-sbu-mux.c
+++ b/drivers/usb/typec/mux/gpio-sbu-mux.c
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
-- 
2.39.2


