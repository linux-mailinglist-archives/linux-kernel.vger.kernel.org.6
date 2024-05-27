Return-Path: <linux-kernel+bounces-191407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E218D0ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA0C8B21738
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 20:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C20816133C;
	Mon, 27 May 2024 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="r+LgD27o"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDB54C618;
	Mon, 27 May 2024 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843533; cv=none; b=Eog9M9YIb9PYuLJCtEn5QG0edw3aViJf+I1XrXNa8eXWyEWDkaDVo0/ihxgjfEi7zcOCXaJnEg0cupVXN0qPYWNQockhx3gPRdbKvgHRpkrS7CR4YdnfHiC8K8mSDZbcVdYIWHuEZcXgaOAcDxhHkmlZ4oXwRMezPapmY4rfqnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843533; c=relaxed/simple;
	bh=Jv3YXe/SC98//myUonGdPxTG/IeuDd56iUFrzgy8BYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mIuHBTKc35JzhvA/E+jv2kfjI49M96KW4fHd9ATA0xG0SKZKKfIDY/YTew5ZM/CVSkjqpzvD69D7n05lBTMphmPWK5aLTwmEr8svKbIzcKoJ/UiwpJ9lfuR5u05bGgtDlnSsgOESROQ085M9p1axDYxBVQEH3HksR7PujcOU52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=r+LgD27o; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716843529;
	bh=Jv3YXe/SC98//myUonGdPxTG/IeuDd56iUFrzgy8BYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r+LgD27oHpxvJBsKqSzue+CJtIZZGjdlzdH/sFopSrIzQw/raH8dzu2zpIU8ZZ5Kj
	 zWKSAVoVi+qAORTbcjrpTd2pBrhTsMWpfLexrXJjqDhOyYWTKY7vaaQ05U2A7vKOLu
	 8GpLDDkZqPqp3y9xUw5AOsop0VuoRDEHI5sWZ8ss=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 27 May 2024 22:58:31 +0200
Subject: [PATCH v3 1/3] platform/chrome: cros_ec_proto: Introduce
 cros_ec_cmd_readmem()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240527-cros_ec-hwmon-v3-1-e5cd5ab5ba37@weissschuh.net>
References: <20240527-cros_ec-hwmon-v3-0-e5cd5ab5ba37@weissschuh.net>
In-Reply-To: <20240527-cros_ec-hwmon-v3-0-e5cd5ab5ba37@weissschuh.net>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, 
 Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Dustin Howett <dustin@howett.net>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Moritz Fischer <mdf@kernel.org>, Stephen Horvath <s.horvath@outlook.com.au>, 
 Rajas Paranjpe <paranjperajas@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716843528; l=2450;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Jv3YXe/SC98//myUonGdPxTG/IeuDd56iUFrzgy8BYE=;
 b=5jSi9+ClmSXH++kkF1hUwR2UN83iqHv+ObsvjcNU50XXoQuwwz2n1Cr62K8pbeBZYWn7QvUgX
 E652M/DufHyA8S6QoulZKDsQYz4zGuuWpq79fYtr4l0N7QAaMyD7PWJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

To read from the EC memory different mechanism are possible.
ECs connected via LPC expose their memory via a ->cmd_readmem operation.
Other protocols require the usage of EC_CMD_READ_MEMMAP, which on the
other hand is not implemented by LPC ECs.

Provide a helper that automatically selects the correct mechanism.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/chrome/cros_ec_proto.c     | 27 +++++++++++++++++++++++++++
 include/linux/platform_data/cros_ec_proto.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 945b1b15a04c..4b48fa1fe3e0 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -1035,3 +1035,30 @@ int cros_ec_cmd(struct cros_ec_device *ec_dev,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cros_ec_cmd);
+
+/**
+ * cros_ec_cmd_readmem - Read from EC memory.
+ *
+ * @ec_dev: EC device
+ * @offset: Is within EC_LPC_ADDR_MEMMAP region.
+ * @size: Number of bytes to read. zero means "read a string" (including
+ *        the trailing '\0').
+ *        Caller must ensure that the buffer is large enough for the
+ *        result when reading a string.
+ * @dest: EC command output data
+ *
+ * Return: >= 0 on success, negative error number on failure.
+ */
+int cros_ec_cmd_readmem(struct cros_ec_device *ec_dev, u8 offset, u8 size, void *dest)
+{
+	struct ec_params_read_memmap params;
+
+	if (ec_dev->cmd_readmem)
+		return ec_dev->cmd_readmem(ec_dev, offset, size, dest);
+
+	params.offset = offset;
+	params.size = size;
+	return cros_ec_cmd(ec_dev, 0, EC_CMD_READ_MEMMAP,
+			   &params, sizeof(params), dest, size);
+}
+EXPORT_SYMBOL_GPL(cros_ec_cmd_readmem);
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 8865e350c12a..1ddc52603f9a 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -261,6 +261,8 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec);
 int cros_ec_cmd(struct cros_ec_device *ec_dev, unsigned int version, int command, const void *outdata,
 		    size_t outsize, void *indata, size_t insize);
 
+int cros_ec_cmd_readmem(struct cros_ec_device *ec_dev, u8 offset, u8 size, void *dest);
+
 /**
  * cros_ec_get_time_ns() - Return time in ns.
  *

-- 
2.45.1


