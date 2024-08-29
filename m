Return-Path: <linux-kernel+bounces-307010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13939646C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E861C20F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC3F1ABED7;
	Thu, 29 Aug 2024 13:32:54 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A88F1ABEA8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938374; cv=none; b=PuY8C6gMWX98pCB2Ri0TRLoHPME6Uw4yzEEHg/CvYOHnKW9yTPhRDA/DZqc6CLhW/jql+E180swZpf/uodOwjWbaWc7Zi1KalvhT0nYAOPYqcQorBWmhgln7UsRBA3sEmGN0Ft5+8URuEG8xw+i4sV2qqxB3/TP7fXcjsIP/TMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938374; c=relaxed/simple;
	bh=MmX1CmtLsaNaQxXPUyOhcWdouZuyyk8hiwX+AaiDa1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lnGQZqOSNjxbVxZljR4+xx5VgrhL+JL6+rKd+7OCq1Ei4/9XTLLn7+2c/F660qxXMmDnlTwX/JV8q0dNiXU6AM8Wd5DIM2u9HixNVD3gvtA2bciJGgEIayf2mC1XnqgZRHaoen+Eh2aZRVmItpH7ZNwesVMIh/Luvez8L4zZjOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:fbdf:b855:e99a:9ec0])
	by michel.telenet-ops.be with cmsmtp
	id 5pYj2D00K0Yrr4n06pYj8Y; Thu, 29 Aug 2024 15:32:44 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sjfGS-001GQE-VN;
	Thu, 29 Aug 2024 15:32:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sjfGV-0002At-MJ;
	Thu, 29 Aug 2024 15:32:43 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] nvmem: Fix return type of devm_nvmem_device_get() in kerneldoc
Date: Thu, 29 Aug 2024 15:32:38 +0200
Message-Id: <d2748e1873daf55973de9c99ffeb6de6fa6451af.1724938228.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_nvmem_device_get() returns an nvmem device, not an nvmem cell.

Fixes: e2a5402ec7c6d044 ("nvmem: Add nvmem_device based consumer apis.")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/nvmem/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 516dfd861b9f968f..33ffa2aa4c115239 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1276,13 +1276,13 @@ void nvmem_device_put(struct nvmem_device *nvmem)
 EXPORT_SYMBOL_GPL(nvmem_device_put);
 
 /**
- * devm_nvmem_device_get() - Get nvmem cell of device form a given id
+ * devm_nvmem_device_get() - Get nvmem device of device form a given id
  *
  * @dev: Device that requests the nvmem device.
  * @id: name id for the requested nvmem device.
  *
- * Return: ERR_PTR() on error or a valid pointer to a struct nvmem_cell
- * on success.  The nvmem_cell will be freed by the automatically once the
+ * Return: ERR_PTR() on error or a valid pointer to a struct nvmem_device
+ * on success.  The nvmem_device will be freed by the automatically once the
  * device is freed.
  */
 struct nvmem_device *devm_nvmem_device_get(struct device *dev, const char *id)
-- 
2.34.1


