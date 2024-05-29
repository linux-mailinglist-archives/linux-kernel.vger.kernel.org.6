Return-Path: <linux-kernel+bounces-193508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8C88D2D35
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8481288E64
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86321607AA;
	Wed, 29 May 2024 06:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="AsTYe+fa"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CB215EFDA;
	Wed, 29 May 2024 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964044; cv=none; b=q9prvmx9Xa3w4jfx5BSCzqqCUNESwj8A2PrIaDjXGJm/xoy3pI1SddrKrS/qlNYtFwa/Y/JBjzzPF2t01EWTOCWWWIoMivRVsK8ybrIxpcbu/u1cqwx4sJR/4YnI4HL423/z6jAFmsMkleqlsFvB6WTpDO+LSOCtOOrrGUgS1x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964044; c=relaxed/simple;
	bh=YXsw9Xicl8EATJ4ZrHMH0cJ6u503P6Q2iTyqNUPD3Zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l3tzD5sOteAs4kiayYXQOBmdfvquLVmYX3BrNt39MebDUKW2m+4FUwalAieNOKIYrHvUojC/G9Gc6bsvivw98RDucKQ5BZMjKNFI+YgV3OwYRwt2oyTAZ6K9E/SB/dMv28RffA6cqV+sCdrL4lWuA3l0cwrQXaTXAM5qfqmxtic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=AsTYe+fa; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716964039;
	bh=YXsw9Xicl8EATJ4ZrHMH0cJ6u503P6Q2iTyqNUPD3Zs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AsTYe+fafq71rhigQ0nCUQ5bRYUTvFzsk8bNulgzOOQbudjBfXTVbj02dWbJ28MJS
	 SqLL0L8Xr8/NTGvkpp4uKzGle7NovX3w7wNE2/zcIYuDR1Bpi8eR1ZchS8R+PeKhYn
	 oUEJ+4iLrz3Y35cnSR4CFqxD4RYSC0ZvsFBVnlMM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 May 2024 08:27:11 +0200
Subject: [PATCH v4 1/3] platform/chrome: cros_ec_proto: Introduce
 cros_ec_cmd_readmem()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240529-cros_ec-hwmon-v4-1-5cdf0c5db50a@weissschuh.net>
References: <20240529-cros_ec-hwmon-v4-0-5cdf0c5db50a@weissschuh.net>
In-Reply-To: <20240529-cros_ec-hwmon-v4-0-5cdf0c5db50a@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716964039; l=2309;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YXsw9Xicl8EATJ4ZrHMH0cJ6u503P6Q2iTyqNUPD3Zs=;
 b=+sofws1B8KLLelgmW9aJk2d8gV94HqdSiWSn61jhVzcBoJ33D9eRxoGAG28lYHD8DW2KjbC4y
 q+ufw94H2odAqWfRlndYmxj8b3zx3INTwPR7j+ApuNKY/gyXvJNKuin
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
index 945b1b15a04c..daddc8731cef 100644
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
+ * @size: Number of bytes to read.
+ * @dest: EC command output data
+ *
+ * Return: >= 0 on success, negative error number on failure.
+ */
+int cros_ec_cmd_readmem(struct cros_ec_device *ec_dev, u8 offset, u8 size, void *dest)
+{
+	struct ec_params_read_memmap params = {};
+
+	if (!size)
+		return -EINVAL;
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


