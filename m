Return-Path: <linux-kernel+bounces-408877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D43D9C8497
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9AD2816F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182EB1F707D;
	Thu, 14 Nov 2024 08:10:09 +0000 (UTC)
Received: from smtp.ps-zuehlke.com (smtp.ps-zuehlke.com [193.135.254.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C8D1F6662;
	Thu, 14 Nov 2024 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.135.254.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571808; cv=none; b=vCCktR1bhZeZfUsE4DrDpaYP9ZjTCNtsstRZ/PBgP1yy6dQKTMpzE2cTa2k3VO2wcVbxqzHajqwUQLVELnaY70DqzeC6EOgQ81cRWJ9W8b5aUoXCiqdwgtyqtwQtQaYIvPnapT6QynO496NAQiDUFoGu0puVJ0f/uul1iHdi0mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571808; c=relaxed/simple;
	bh=MMFNcDZl1O95DgMDsY1PAL4cRz865YcySfeAV8FEz+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Alu549Ef6NEksP3TekbhsoDccOuzfey7Uah3HyCAcDQjKiHeNYw7R1gHJgLzbBEucbEJ/kzpPhmMZ7i3lgZKfD5AZLJg6WimM7fqzG1WEAk633MSvSej82kYxTIss3zYT8wEHcqL2klIJhk3axiUTeUsNjiyTJiNCqxDZe6D14w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com; spf=pass smtp.mailfrom=zuehlke.com; arc=none smtp.client-ip=193.135.254.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zuehlke.com
Received: from ZUEN49445. (unknown [10.192.66.22])
	by smtp.ps-zuehlke.com (Postfix) with ESMTP id 7748B129;
	Thu, 14 Nov 2024 09:02:22 +0100 (CET)
From: Oliver Facklam <oliver.facklam@zuehlke.com>
Date: Thu, 14 Nov 2024 09:02:07 +0100
Subject: [PATCH v2 2/4] usb: typec: hd3ss3220: use typec_get_fw_cap() to
 fill typec_cap
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-usb-typec-controller-enhancements-v2-2-362376856aea@zuehlke.com>
References: <20241114-usb-typec-controller-enhancements-v2-0-362376856aea@zuehlke.com>
In-Reply-To: <20241114-usb-typec-controller-enhancements-v2-0-362376856aea@zuehlke.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Biju Das <biju.das@bp.renesas.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benedict von Heyl <benedict.vonheyl@zuehlke.com>, 
 Mathis Foerst <mathis.foerst@zuehlke.com>, 
 Michael Glettig <michael.glettig@zuehlke.com>, 
 Oliver Facklam <oliver.facklam@zuehlke.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731571341; l=1216;
 i=oliver.facklam@zuehlke.com; s=20241107; h=from:subject:message-id;
 bh=MMFNcDZl1O95DgMDsY1PAL4cRz865YcySfeAV8FEz+w=;
 b=8yynHsCy9WVM4CVOzaSXunNk89Nd1jajct9/wsLrGRXDuGUoRMHTO97bvd81Oev+lRCuPAQbE
 Js5ejRVBywsA4ISKgnmvvHIpSEkcX5aXBLzBn3Fz+QlJyV8I1+9yMGu
X-Developer-Key: i=oliver.facklam@zuehlke.com; a=ed25519;
 pk=bMlB+nko+ewJHQJLwq2t26VDbmRmNDPr/1woleqp7Lw=

The type, data, and prefer_role properties were previously hard-coded
when creating the struct typec_capability.

Use typec_get_fw_cap() to populate these fields based on the
respective fwnode properties, if present.

Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
---
 drivers/usb/typec/hd3ss3220.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
index 56f74bf70895ca701083bde44a5bbe0b691551e1..e581272bb47de95dee8363a5491f543354fcbbf8 100644
--- a/drivers/usb/typec/hd3ss3220.c
+++ b/drivers/usb/typec/hd3ss3220.c
@@ -264,7 +264,14 @@ static int hd3ss3220_probe(struct i2c_client *client)
 	typec_cap.type = TYPEC_PORT_DRP;
 	typec_cap.data = TYPEC_PORT_DRD;
 	typec_cap.ops = &hd3ss3220_ops;
-	typec_cap.fwnode = connector;
+
+	/*
+	 * Try to get properties from connector,
+	 * but continue with defaults anyway if they are not found
+	 */
+	ret = typec_get_fw_cap(&typec_cap, connector);
+	if (ret != 0 && ret != -EINVAL && ret != -ENXIO)
+		goto err_put_role;
 
 	hd3ss3220->port = typec_register_port(&client->dev, &typec_cap);
 	if (IS_ERR(hd3ss3220->port)) {

-- 
2.34.1


