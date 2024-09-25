Return-Path: <linux-kernel+bounces-339375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCBB98641F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C346A28DEB4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C2E347B4;
	Wed, 25 Sep 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBj12M/0"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC61E1BC23;
	Wed, 25 Sep 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279394; cv=none; b=GM1tafehOeke4513uECogqblhVf3CFR4a/f+QGNlEZzgzMru/trlMTR7zaaaqVhcnzhgqnxO5DEIH6aD6WSxaYfuylExmrJAz8etlN7CKtwFVSeRQUe9DEDov32L5zRibSFRBC/tfkDTlsGM7SFuQZ5vVmJaGSr92RIrcN3x4+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279394; c=relaxed/simple;
	bh=5fEuuU3XfUFHtBatfpDH6icGp8TZ4uJv28CJVwS77Lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YiXjswH3FHFxRQYsfylRLTpjwF8xLoRpCJwZCGPIXlkvmThFVGRpCYxmrLBIvzO//yx65MJKgMaBWwMuC/LwC3V0qCPUdgEQBofqRQpJJvJOnzqTTVFgJC0+oQOygHeEgMHcvnpOENReUmvuKvdLXTbuG1d8H9OacwTrYqfjwfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBj12M/0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so810416666b.2;
        Wed, 25 Sep 2024 08:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727279390; x=1727884190; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gwgu5WoJ6DYspehiMzjPYMRnAGWQtukEgNDYWoU759Y=;
        b=LBj12M/0NhZj5fwCc4MF+PGIO/qgGout3GItJwr6nDayzJ37lWdWY4UB5GsdWbFuGZ
         R+j0FrWemc6jR5aoeliswMle/fj9mQpnCaFVPLF6icXhPfk2VkgF9Crp/dED5x2oiEpz
         dGYACC9uWx59KwIWzbV2/Qx7YvJA14+mLCi0pRGqKsDw5OEKDzN6GaQENpAqN7ACq52x
         iezebD8n67ju8uv9k+jr5erzDzwINPWp01tjwMTqNz2M8972utOZZR+imeJ884zpqttg
         Yj/CPqQP2+Psr9rK6YpUmj1waw3lHlz/xnZu5tQHNvlN7SY98CT/OiyR8BN8wyFaYzzZ
         78/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727279390; x=1727884190;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gwgu5WoJ6DYspehiMzjPYMRnAGWQtukEgNDYWoU759Y=;
        b=meKN22P3L7GsYpehrKSTIF1/dXmAFFHMheCUe+wTybpV8t29x0bIhQW8zNZ6FaeOLj
         WGFz7LsvkqnMTagZR0ZceCOVEgjWQGb/rPJSdFm6UIMEPpBbWHX7i+ybjr9nAZv2DOXU
         rJYWc5QFuU/BZAcfYs0kD4QgSdG217qzPjO8FjZADcqwtsnTV6F7NDl3nkG3iMBOkWXz
         k0lIevV55H9fYSUhg6VOKVC+QiKN+S+t1SEKowtU7S7Wmdqp84EPDSQHJw9XZ8VpgT85
         CxDDsIwoXD6hmfSYoVHv8Pgc661UsjpdOVfEYtbhaZ3bj/KVKUO/CwCl7XB8DUfeQmfi
         EnyA==
X-Forwarded-Encrypted: i=1; AJvYcCVbuY+ysYSoUzBHeQCi/V7dF5GtXSogfVeJ2B/qsM5e5wZpQh5BjwbGe2ate27xyPO8tuPWE3SGa4vmzT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYxwvrO7EtSqNmN0oVe6uCZPdp4GG0RFm0XwfdwWpuTunwx6N1
	v/rs2LIl7WJjwhQkyzD7P95AWZqC7SvGpHn6HSqR+y3XaTH/tiK5BtgxcQ6m
X-Google-Smtp-Source: AGHT+IEJn4NvuVmT2YgjFUtwDpmAS42/4xefB/HbkI3jQZFEYj0g8ju/mrnE64021PgivlAsjOhXng==
X-Received: by 2002:a17:906:c113:b0:a8a:7549:2a25 with SMTP id a640c23a62f3a-a93a03c6e29mr271429166b.36.1727279390028;
        Wed, 25 Sep 2024 08:49:50 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9393133c51sm222861166b.189.2024.09.25.08.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:49:48 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 25 Sep 2024 17:49:46 +0200
Subject: [PATCH v2] usb: typec: ucsi: glink: use
 device_for_each_child_node_scoped()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-ucsi_glink-scoped-v2-1-a661585fff35@gmail.com>
X-B4-Tracking: v=1; b=H4sIABkx9GYC/32NQQ6CMBBFr0JmbQ0tBIMr70GIKdNpmQiUtEo0p
 He3cgCX7yX//R0iBaYI12KHQBtH9ksGdSoAR704EmwygypVXTaqEi+MfHcTLw8R0a9khDK1vFh
 stTUV5N0ayPL7aHZ95pHj04fPcbHJn/1X26SQwpbWoCVs2mG4uVnzdEY/Q59S+gJHwKUzsgAAA
 A==
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727279388; l=2431;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=5fEuuU3XfUFHtBatfpDH6icGp8TZ4uJv28CJVwS77Lo=;
 b=LmmyM+PjqIMF9yhYIe8WG4Jkw3i596y34lPHm3q9zy87UTIfQc98HEe3XXg4eN014LXk2exE4
 0HCML1RST9dDszTvjWgw6Xv6190QLoUpE4Hx92yXKIOMODPsDgCSsR/
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Use the scoped variant of `device_for_each_child_node()` to
automatically handle early exits.

This prevents memory leaks if new error paths are introduced,
as no explicit refcount decrement via `fwnode_handle_put()` is needed.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
This patch is a follow-up to the recently introduced commit c68942624e25
("usb: typec: ucsi: glink: fix child node release in probe function")
to account for a safer approach to iterating over child nodes.
---
Changes in v2:
- Rebase onto v6.11 to apply without errors due to the previous
  patch mentioned in the cover letter.
- Link to v1: https://lore.kernel.org/r/20240623-ucsi_glink-scoped-v1-1-f0fdcfec69bb@gmail.com
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 6aace19d595b..41db51e486e0 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -322,7 +322,6 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 	struct pmic_glink_ucsi *ucsi;
 	struct device *dev = &adev->dev;
 	const struct of_device_id *match;
-	struct fwnode_handle *fwnode;
 	int ret;
 
 	ucsi = devm_kzalloc(dev, sizeof(*ucsi), GFP_KERNEL);
@@ -354,14 +353,13 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 
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
 
@@ -376,11 +374,10 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
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
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20240623-ucsi_glink-scoped-2d417fc9afd3

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


