Return-Path: <linux-kernel+bounces-401851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3CC9C2020
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8830A2843BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3601F5857;
	Fri,  8 Nov 2024 15:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhDw5IQz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5611F5831
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078762; cv=none; b=QeaWRwW9KfpxYrZQXzkot80sCZIZjoHH1x6folT8isQ9qRIAHwlh60Mbj7GUQZIjBRkrkJR/nypzwmsW6ymUYPQr0EOkgwrh1oy86T9EemUk8YeWc1GVUjieSm2JI0aRVh4dHrKGnWH/DVze7HwSdnvN0tUIJvZYND5oaZ8UuPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078762; c=relaxed/simple;
	bh=JN5LmOQcqHvCG8Xjy120PjZxVUTkIuVNfUIolJJEF3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Is6WepZxPbAwXdevvGRRkDEgcc5Ok26P7ny8K6qiMG08jKzeYdDQq4g6ybHJjU6pKjbSi6+eDCqwstAGnLFoCto5yiv7g2nBNfcBqtxVIyu+mVWn4+rZrnjTjwkYlzSfqLlcoctBBIRFKk67Ucf/PxTDiQyTqx6kluUnjVm2Zk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhDw5IQz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731078759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tfQ/evUyi5J3GvkdmMI90Lup3kZFg3YFUYPq72ZTR4w=;
	b=UhDw5IQzZ9TgtAEfRUr/ka7Gozn39bwYEOzQEMkgBMuKjHQMCn1feNYi0rPkwaXBvltRTL
	BGnfYYH8J3LMQ75aNjBxPqgFbdAeOjrs685EPqqMXYgNqtjoM/vaobc9CrOHH57egYfvgl
	t1T3mtX1q9J1HPFQi3OvX++ZWN9X4to=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-yHl8ao-gPJKbWOdceTnhHg-1; Fri,
 08 Nov 2024 10:12:38 -0500
X-MC-Unique: yHl8ao-gPJKbWOdceTnhHg-1
X-Mimecast-MFC-AGG-ID: yHl8ao-gPJKbWOdceTnhHg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44CDA19560B0;
	Fri,  8 Nov 2024 15:12:37 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.67])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D16A300019E;
	Fri,  8 Nov 2024 15:12:35 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mei: vsc: Improve error logging in vsc_identify_silicon()
Date: Fri,  8 Nov 2024 16:12:34 +0100
Message-ID: <20241108151234.36884-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

vsc_identify_silicon() returns -EINVAL in various places without logging
what is going on.

And there are several bug reports about mei_vsc_hw_reset() failing with
-EINVAL before the "silicon stepping version is %u:%u" message get logged,
indicating this is coming from vsc_identify_silicon():

[   10.949657] intel_vsc intel_vsc: hw_reset failed ret = -22
[   10.988899] intel_vsc intel_vsc: hw_reset failed ret = -22
[   11.027140] intel_vsc intel_vsc: hw_reset failed ret = -22
[   11.027151] intel_vsc intel_vsc: reset: reached maximal consecutive resets: disabling the device
[   11.027155] intel_vsc intel_vsc: reset failed ret = -19
[   11.027157] intel_vsc intel_vsc: link layer initialization failed.
[   11.027159] intel_vsc intel_vsc: error -ENODEV: init hw failed

Add proper error logging to mei_vsc_hw_reset() so that it will be clear
why it is failing when it fails.

Link: https://github.com/intel/ivsc-driver/issues/51
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/misc/mei/vsc-fw-loader.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/mei/vsc-fw-loader.c b/drivers/misc/mei/vsc-fw-loader.c
index 9f129bc641f6..0d7e17322869 100644
--- a/drivers/misc/mei/vsc-fw-loader.c
+++ b/drivers/misc/mei/vsc-fw-loader.c
@@ -317,28 +317,34 @@ static int vsc_identify_silicon(struct vsc_fw_loader *fw_loader)
 	cmd->data.dump_mem.addr = cpu_to_le32(VSC_EFUSE_ADDR);
 	cmd->data.dump_mem.len = cpu_to_le16(sizeof(__le32));
 	ret = vsc_tp_rom_xfer(fw_loader->tp, cmd, ack, VSC_ROM_PKG_SIZE);
-	if (ret)
-		return ret;
-	if (ack->token == VSC_TOKEN_ERROR)
-		return -EINVAL;
+	if (ret || ack->token == VSC_TOKEN_ERROR) {
+		dev_err(fw_loader->dev, "CMD_DUMP_MEM error %d token %d\n", ret, ack->token);
+		return ret ?: -EINVAL;
+	}
 
 	cmd->magic = cpu_to_le32(VSC_MAGIC_NUM);
 	cmd->cmd_id = VSC_CMD_GET_CONT;
 	ret = vsc_tp_rom_xfer(fw_loader->tp, cmd, ack, VSC_ROM_PKG_SIZE);
-	if (ret)
-		return ret;
-	if (ack->token != VSC_TOKEN_DUMP_RESP)
-		return -EINVAL;
+	if (ret || ack->token != VSC_TOKEN_DUMP_RESP) {
+		dev_err(fw_loader->dev, "CMD_GETCONT error %d token %d\n", ret, ack->token);
+		return ret ?: -EINVAL;
+	}
 
 	version = FIELD_GET(VSC_MAINSTEPPING_VERSION_MASK, ack->payload[0]);
 	sub_version = FIELD_GET(VSC_SUBSTEPPING_VERSION_MASK, ack->payload[0]);
 
-	if (version != VSC_MAINSTEPPING_VERSION_A)
+	if (version != VSC_MAINSTEPPING_VERSION_A) {
+		dev_err(fw_loader->dev, "maintstepping mismatch expected %d got %d\n",
+			VSC_MAINSTEPPING_VERSION_A, version);
 		return -EINVAL;
+	}
 
 	if (sub_version != VSC_SUBSTEPPING_VERSION_0 &&
-	    sub_version != VSC_SUBSTEPPING_VERSION_1)
+	    sub_version != VSC_SUBSTEPPING_VERSION_1) {
+		dev_err(fw_loader->dev, "substepping %d is out of supported range %d - %d\n",
+			sub_version, VSC_SUBSTEPPING_VERSION_0, VSC_SUBSTEPPING_VERSION_1);
 		return -EINVAL;
+	}
 
 	dev_info(fw_loader->dev, "silicon stepping version is %u:%u\n",
 		 version, sub_version);
-- 
2.47.0


