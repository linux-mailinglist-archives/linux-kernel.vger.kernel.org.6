Return-Path: <linux-kernel+bounces-226058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BF0913996
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 12:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BFBD1C20977
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9827712DDB8;
	Sun, 23 Jun 2024 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4aRN9jK"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A30512DD8E;
	Sun, 23 Jun 2024 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719138920; cv=none; b=u7eNZeqFQ8c8OiEfSATXEBFpOaoubwpN4SbDCab4hs6WRZkEZBKcSFNr4EHcHxvuN6wP6n7BZBNAXleP/LStwLxf0C9cqAv0bFbIaf7ujJjJiOAq+iYi53Fha7HhL/eijDvd/rIYxgQsVcNcgdWuhn6lG/pudsS4ZgEAnxN8nxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719138920; c=relaxed/simple;
	bh=FxJFq2Zu0xdJEBU+ACbCyheOIBxfVpNwZGkLyj9+2qA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ak6FkG+9lveghXasj+swx96uSW9RQPQsnCTWmiEZOpRoSPiq4bYj9LbVIpHJGn+ytL7wtWLuK5ZcribrBAhxmz+bF0IZfTzllIVQV0L6l0an/T9ipVkpX8pQ8NljY1ol/2QT7dsQHpTFLRxSK9JVioRfu2ehiEuKgjLYr/Kp4ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4aRN9jK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so29313805e9.3;
        Sun, 23 Jun 2024 03:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719138917; x=1719743717; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RDlSa6zikaW9BcixltoR0hCmj2l7mTdd8TF9b5/qKaY=;
        b=Z4aRN9jKCzr6s1oYRBiZ+CwNoYOoU1BXAhoEFP6ZkQ3Gp8LTS+xoQetsjJUFmIY7T0
         UZ++jaurrq6+2XqyhQW7zdkRg4/yJA1cjq35hk3ReMk/q0aOaypF/vPM3ToRS889yOvW
         n5NMDPDoECPCx9ren/iutJw6PuaXUUlU+a+DcPXslfoixt9z7/EXr3+SQH1KfAwgr8rq
         C6dtp7tom7c1vugf2XkQx59uMwXSZ7TPrUEiYRFHH+FKF8W2TrCS5l1A/MUM5mWJWGjs
         O7zS7IjIzs5ErGT8SR4DwE2vQW9QtFLt9383eP4JU1fRti4Z6qoo94GMuIAJihm4DljC
         cQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719138917; x=1719743717;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDlSa6zikaW9BcixltoR0hCmj2l7mTdd8TF9b5/qKaY=;
        b=E0oskPX35EG4F6wF+D9iWYGaEQ4UrtHyBKPLvVAob093goVOyEOC6PpXJK2DUqUTXJ
         YI9qfoEB/VXs0EbOHo2ttdkL7R+Fl9fJ95NSzPd2ibpR4EZ+ZlZi182pjctG9IfNL0as
         afFxIh/YbX/EiaOhQEKFshYy1ABL3WkLP6SxpA7DBA+wmxW9OkkgkycnWsHeQfLTXORb
         9Q6sZXujzqXnzvqWRSY8b/jKTJfw9zoRIfJQZkB7pFDagOuZMzMJKdTiQWedyBOaMuOz
         DLg5ZufKzNdDAK/kK4tbUtsXPORKsnl2Fd6Yy0IaN7lFUrbO4mrJK9L3JB/bSS90q/9m
         CT1A==
X-Forwarded-Encrypted: i=1; AJvYcCUcDn2cadvryEkZUt5Xfi8xePhosErSDct5wqvvO2oUsccCVivki+2dQ2zoYM6i2n7cfnEUQPz4XzkzkFb9nm3xIpnGeFxHferqq4F4
X-Gm-Message-State: AOJu0YzhwvY3pLraZ3k/cp/fAowxHBNDlghBMPWBPYJzkMQCM46Ry7Ga
	oLcsrtbfcNoC3aYMQxyR5nlD7lSaiXODf3A6zGBczJFAoWGsS24m
X-Google-Smtp-Source: AGHT+IEtNHcmbv7bOpkQl0Yk9zopa9sGSiM7q6O2LsF3za6ZlKck7Q8fH0abfO+3JFGEMoAky8bZmA==
X-Received: by 2002:a05:600c:28b:b0:421:7e88:821 with SMTP id 5b1f17b1804b1-4248b9cfab2mr22346775e9.32.1719138917411;
        Sun, 23 Jun 2024 03:35:17 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817aa340sm94789735e9.19.2024.06.23.03.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 03:35:17 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 23 Jun 2024 12:35:11 +0200
Subject: [PATCH] usb: typec: ucsi: glink: use
 device_for_each_child_node_scoped()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-ucsi_glink-scoped-v1-1-f0fdcfec69bb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAF/6d2YC/x3MQQqAIBBA0avErBPSoqirRIQ4Yw2FhkMRRHdPW
 r7F/w8IJSaBoXgg0cXCMWTosgC32rCQYswGU5mmak2tTic8LzuHTYmLB6Ey2OjOu956rCF3RyL
 P9/8cp/f9AHQciZljAAAA
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719138916; l=2145;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=FxJFq2Zu0xdJEBU+ACbCyheOIBxfVpNwZGkLyj9+2qA=;
 b=hljqv3P3CBVnJBFBidEb5lVJ9MXZkFW+wdMEE1JdNkPeto1e/9jCMEvwNvQnjThjliNzo47NK
 Qq4jZqtbbGqCX/wElrofL5zzssYNpuwPASavvEVPk6WDSqZEa2NrWxN
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Use the scoped variant of `device_for_each_child_node()` to
automatically handle early exits.

This prevents memory leaks if new error paths are introduced,
as no explicit refcount decrement via `fwnode_handle_put()` is needed.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
This patch is a follow-up to the recently introduced commit c68942624e25
("usb: typec: ucsi: glink: fix child node release in probe function")
to account for a safer approach to iterating over child nodes.
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 2fa973afe4e6..d41c9caa84e0 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -333,7 +333,6 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 	struct pmic_glink_ucsi *ucsi;
 	struct device *dev = &adev->dev;
 	const struct of_device_id *match;
-	struct fwnode_handle *fwnode;
 	int ret;
 
 	ucsi = devm_kzalloc(dev, sizeof(*ucsi), GFP_KERNEL);
@@ -365,14 +364,13 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 
 	ucsi_set_drvdata(ucsi->ucsi, ucsi);
 
-	device_for_each_child_node(dev, fwnode) {
+	device_for_each_child_node_scoped(dev, fwnode) {
 		struct gpio_desc *desc;
 		u32 port;
 
 		ret = fwnode_property_read_u32(fwnode, "reg", &port);
 		if (ret < 0) {
 			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
-			fwnode_handle_put(fwnode);
 			return ret;
 		}
 
@@ -387,11 +385,10 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 		if (!desc)
 			continue;
 
-		if (IS_ERR(desc)) {
-			fwnode_handle_put(fwnode);
+		if (IS_ERR(desc))
 			return dev_err_probe(dev, PTR_ERR(desc),
 					     "unable to acquire orientation gpio\n");
-		}
+
 		ucsi->port_orientation[port] = desc;
 	}
 

---
base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
change-id: 20240623-ucsi_glink-scoped-2d417fc9afd3

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


