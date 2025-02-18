Return-Path: <linux-kernel+bounces-518850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66F3A39537
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9643D7A140C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A9C22AE7F;
	Tue, 18 Feb 2025 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ue2WDAeQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7CE1FF1B4;
	Tue, 18 Feb 2025 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866993; cv=none; b=rdfRZe3LsqXms83M8iRTs8rlNlQ9ShPz2AVz0rVTklx24oJGGn3nQNXr6yL+54A9ln0LegJFEBWOGMWqhZ86QvEnQtRyETz+0tLOi/63EutvtrK1EMRK7fp/g9BEXEeLFgWgAo5RhZVMLEYmNIBCN5uYX4QzOHxtCDOD2OB+M5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866993; c=relaxed/simple;
	bh=p6YzcyfZTI2awbpmNRLFZOrM9ZUlgJUmwUZ83JNsVM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PYE4WeO4cmHzyUJL/T/v6uOKn9EYo0Oj7gb2tAQ8RwQPfbuAgk4bjlzLwYdwj7LoazIPCzIMhTGshWkFbOuf6WU/5acNCQjgqm3ngME7IZD0E/t9M7SfRZPY/pOrbLV+uTp5P7L2yxIMHx911Cl7qBvafgC7Mn5hU3jq95s7BnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ue2WDAeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D9DC4CEE2;
	Tue, 18 Feb 2025 08:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739866993;
	bh=p6YzcyfZTI2awbpmNRLFZOrM9ZUlgJUmwUZ83JNsVM4=;
	h=From:To:Cc:Subject:Date:From;
	b=ue2WDAeQ9ahdmETC2736iv7XZV4xUcU2vmA9SJsbv39kC/+uSJrTx9Jv3hkehZknO
	 Pjj4Z9zGrtxM1sLiqEZTjWKNa0qf2yJo4RKHoxGaR4RQVyw9BcAuaD24E//cf0etiz
	 rFxRDEPFm4+/F7XesRiczpjJAlq/dVpvbjqniySiPbZ4tLtPoFVtfDvvwBo50HUlQK
	 T02yJykk9jK8yLxs8TehvZi+3C3TnyMSc9M44vLEBSwNoty7pBdqNAUdGEW+wzZSr6
	 D0QVuyNWesS+vh+gfHpb2AHUHINS+9ZoSufjO5t4SpuPjwAQ3x5BnOgpUzPZYCB+Uu
	 WpAB6w7EzgftA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tkIsx-000000002R5-2j2W;
	Tue, 18 Feb 2025 09:23:20 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH] usb: typec: ps883x: fix probe error handling
Date: Tue, 18 Feb 2025 09:22:43 +0100
Message-ID: <20250218082243.9318-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the probe error handling to avoid unbalanced clock disable or
leaving regulators on after probe failure.

Note that the active-low reset pin should also be asserted to avoid
leaking current after disabling the regulators.

Fixes: 257a087c8b52 ("usb: typec: Add support for Parade PS8830 Type-C Retimer")
Cc: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/typec/mux/ps883x.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/mux/ps883x.c b/drivers/usb/typec/mux/ps883x.c
index 10e407ab6b7f..ef086989231f 100644
--- a/drivers/usb/typec/mux/ps883x.c
+++ b/drivers/usb/typec/mux/ps883x.c
@@ -387,10 +387,11 @@ static int ps883x_retimer_probe(struct i2c_client *client)
 
 err_switch_unregister:
 	typec_switch_unregister(retimer->sw);
-err_vregs_disable:
-	ps883x_disable_vregs(retimer);
 err_clk_disable:
 	clk_disable_unprepare(retimer->xo_clk);
+err_vregs_disable:
+	gpiod_set_value(retimer->reset_gpio, 1);
+	ps883x_disable_vregs(retimer);
 err_mux_put:
 	typec_mux_put(retimer->typec_mux);
 err_switch_put:
-- 
2.45.3


