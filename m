Return-Path: <linux-kernel+bounces-263592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FF493D80E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC7DB22537
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A405417C9E2;
	Fri, 26 Jul 2024 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Q/tiFX50"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552D2E633;
	Fri, 26 Jul 2024 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017578; cv=none; b=pCUB/rjesTtjPbtQO0NfCTxwxS6Sx38OheEcCCunU5z35ARiszNb1I/h4NdB5OM9yujgLee11H4D4lshkDX3qziPlD1IrD/yhRBfCQcrkbPgAPGfKvuwWskvWf81eD3ukYbGgMPeFNUUQsMSo+sbKaZDg8EwFfsa5hNKrm/3nGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017578; c=relaxed/simple;
	bh=nFUGd7+L7sl/3I9FtSEOYJlOLSgdubB3hGLVG47KEYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DWgVdK/5zM2BcD7dy6MWO2L+O2hRy9bkOc/+UvwMjLFUp9EFihdRckY0hCp8Ac0bNNkhxIjbLV6b5Vq1g5TbIcw0vLc4syvsnzDdCcobZ49c1/kMvzeZmrvGCVMObBCXgcklkPEdiri8m2tmLjxLBqsmvtCSZLhHJFLnClv/KRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Q/tiFX50; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VLtBi/dJDi2LQ/y5ivzxuNTExu4QiDsYE//pYYFE1Bg=; b=Q/tiFX50GjPQfOA1Y+1anpUHdp
	79+GvYG7MB5/vcBXtLzC8FW+wMGjxVxey53x183MOY2B7BcuhmyoBbDjgXgwz7eFgz8vHJY5rln6+
	5rqYSgdKNPeWRGsqyzjog/UUs8K0sG2idtwZAAgQwkNwE7Fd2uHiGuKYM4RDseiZCKF2Xu46uDQsl
	/U1vf0XRRj9w+PI4XnP+Ag4q+KE48JCgawM9Rjo83ffNse8SsZcp7odTkjFp9oA9+h8W2n55bTe5X
	LUozUQ/rJsESxc+IlRGfyHogSAuFXPx+OOPIsbsd6VwYhIV0jWNDldEs+tQJT08o1Gw6WnjfF0P2s
	105NIEog==;
Received: from 179-125-71-226-dinamico.pombonet.net.br ([179.125.71.226] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sXPQu-002SbZ-IR; Fri, 26 Jul 2024 20:12:49 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: chrome-platform@lists.linux.dev
Cc: Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH] platform/chrome: cros_ec_typec: add remove driver hook
Date: Fri, 26 Jul 2024 15:12:35 -0300
Message-Id: <20240726181235.920335-1-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows the driver to be unbound and bound again. Otherwise, when
unbinding the driver, there will be leftover sysfs entries.

When rebinding the driver, it also ends up touching freed memory when
adding to the notifier chain as the old one was not removed and ends up
being traversed.

Add a remove_new driver hook, which removes the notifier from the chain and
unregisters the typec ports.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/platform/chrome/cros_ec_typec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 4d305876ec08..c7781aea0b88 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -1285,6 +1285,15 @@ static int cros_typec_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void cros_typec_remove(struct platform_device *pdev)
+{
+	struct cros_typec_data *typec = platform_get_drvdata(pdev);
+
+	cros_usbpd_unregister_notify(&typec->nb);
+	cancel_work_sync(&typec->port_work);
+	cros_unregister_ports(typec);
+}
+
 static int __maybe_unused cros_typec_suspend(struct device *dev)
 {
 	struct cros_typec_data *typec = dev_get_drvdata(dev);
@@ -1316,6 +1325,7 @@ static struct platform_driver cros_typec_driver = {
 		.pm = &cros_typec_pm_ops,
 	},
 	.probe = cros_typec_probe,
+	.remove_new = cros_typec_remove,
 };
 
 module_platform_driver(cros_typec_driver);
-- 
2.34.1


