Return-Path: <linux-kernel+bounces-206945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E1A901027
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0CA28328A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 08:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D8F177991;
	Sat,  8 Jun 2024 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hDGxVpzr"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DD1176AB4;
	Sat,  8 Jun 2024 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717834372; cv=none; b=FyCtJdfdbEzLqS4GJaBEgCf6V5wQWqjOgLK89vMacbIE8ch3dZSpY27SMUmahlTpLx/DvZ6FtNhqijoqnLqEJNsW/dlIFc8Yd5X3LzXFTA88nFJXaQArPqKEDoiB1bP7etZWfjx/3L2DFk1g21zg3D297aUmORir4DkYCR81LRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717834372; c=relaxed/simple;
	bh=fw/y4pJzNvdZK5afG+PBEc6PoUftleG4LWfjkyyWgdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A2QkdPbwIRz6sEaHkddhNUCaAVCdf/Esue+aMckgU2EP4Z/VBr1KsCnwryiuCeHqkvl9ySNDb0xhyKn5B0L4VHnJm+7nri6IgtLRNKmwOWPLX/ryTiLsDhepBP49awog+dlquPHi1rU3GKtd68urNlcttR/eZDxGanoHqqU5Arw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hDGxVpzr; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1717834365;
	bh=fw/y4pJzNvdZK5afG+PBEc6PoUftleG4LWfjkyyWgdE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hDGxVpzr4v6gAQwt4+MQ66E5eH90CFQbiNBcikb+fdfVzDvTZkLnreacjF7gg8eYu
	 o4U5QADxXE1ci2VR0FtORdU5J4uMGh0gopS0D/JJN2gtNJFA3ba+9jLXKcnXUoqoTg
	 kWnTz4N/sBiMPE1DZdSIEVV4UE+ZN2X3AmNRW/mk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 08 Jun 2024 10:12:43 +0200
Subject: [PATCH 1/5] platform/chrome: cros_ec_proto: Introduce
 cros_ec_cmd_versions()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240608-cros_ec-hwmon-pwm-v1-1-d29dfc26fbc3@weissschuh.net>
References: <20240608-cros_ec-hwmon-pwm-v1-0-d29dfc26fbc3@weissschuh.net>
In-Reply-To: <20240608-cros_ec-hwmon-pwm-v1-0-d29dfc26fbc3@weissschuh.net>
To: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Guenter Roeck <groeck@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Dustin Howett <dustin@howett.net>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Stephen Horvath <s.horvath@outlook.com.au>, chrome-platform@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717834364; l=2290;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=fw/y4pJzNvdZK5afG+PBEc6PoUftleG4LWfjkyyWgdE=;
 b=Dapg4fmR1zg9VbRdnm6FMME0ObVhZaPf2rel7zyHMY2xz8MFj6Pzop/fpuX0q7arf5JIWX+7O
 Pu80aZ3RhZ9C809lKbIP9LCgv98GdKy2n8nHnVG6wiYFCByb5VpWuMZ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Retrieving the supported versions of a command is a fairly common
operation. Provide a helper for it.

If the command is not supported at all the EC returns
-EINVAL/EC_RES_INVALID_PARAMS.

This error is translated into an empty version mask as that is easier to
handle for callers and they don't need to know about the error details.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/chrome/cros_ec_proto.c     | 26 ++++++++++++++++++++++++++
 include/linux/platform_data/cros_ec_proto.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index fe68be66ee98..9cfe885a5301 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -1069,3 +1069,29 @@ int cros_ec_cmd_readmem(struct cros_ec_device *ec_dev, u8 offset, u8 size, void
 			   &params, sizeof(params), dest, size);
 }
 EXPORT_SYMBOL_GPL(cros_ec_cmd_readmem);
+
+/**
+ * cros_ec_cmd_versions - Get supported version mask.
+ *
+ * @ec_dev: EC device
+ * @cmd: Command to test
+ *
+ * Return: version mask on success, negative error number on failure.
+ */
+int cros_ec_cmd_versions(struct cros_ec_device *ec_dev, u16 cmd)
+{
+	struct ec_params_get_cmd_versions_v1 req = {};
+	struct ec_response_get_cmd_versions resp;
+	int ret;
+
+	req.cmd = cmd;
+	ret = cros_ec_cmd(ec_dev, 1, EC_CMD_GET_CMD_VERSIONS,
+			  &req, sizeof(req), &resp, sizeof(resp));
+	if (ret == -EINVAL)
+		return 0; /* Command not implemented */
+	else if (ret < 0)
+		return ret;
+	else
+		return resp.version_mask;
+}
+EXPORT_SYMBOL_GPL(cros_ec_cmd_versions);
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 6e9225bdf903..98ab5986f543 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -263,6 +263,8 @@ int cros_ec_cmd(struct cros_ec_device *ec_dev, unsigned int version, int command
 
 int cros_ec_cmd_readmem(struct cros_ec_device *ec_dev, u8 offset, u8 size, void *dest);
 
+int cros_ec_cmd_versions(struct cros_ec_device *ec_dev, u16 cmd);
+
 /**
  * cros_ec_get_time_ns() - Return time in ns.
  *

-- 
2.45.2


