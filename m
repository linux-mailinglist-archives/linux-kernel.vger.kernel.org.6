Return-Path: <linux-kernel+bounces-375742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEBA9A9A41
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E061F22192
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D6314658B;
	Tue, 22 Oct 2024 06:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jVu2CFeb"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADC1C8FE;
	Tue, 22 Oct 2024 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729579805; cv=none; b=ADO6GjRJc+msX6iP+XGDM+sI+ok629Q4m0gUKCQCTfpcf6MJlIVHGnSOCGsmgBk4zKEqwxyg8e/fL9dUpUflVjJzdyqDSeikKj6nSOt5Gi2cMM0M+zQk/2A/NoM2f8kKCPfqXCVIGfZj2lAoAceaduQa7hJJeYYC7Qyp8artfFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729579805; c=relaxed/simple;
	bh=gAgxmfdP2jyUpNQG51UsfINhavCuMPmSuDngPIlM+gw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UPkVEdJC+i10bISmerS2JggG04QHDwwtiO1iOT7aiWrGZw2jSbwcpaiQPmweqFKuIPk27XcDKx2QG2gZ15UgMdoEsVRkeHbofzMxuf5zVtkMyH/dmBZiqYaHwHSbcxffvrhXhY1bCDSrsj3CIHAIIbf+WdGhgBSNddHGsblQHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jVu2CFeb; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=t9HfF
	lGMV6vlGQ1vROC5AV/hdJqyGhuWNLp4zGqDEtY=; b=jVu2CFebWN+DE5i3o7GQS
	CXXfaj31+L9n9FHtQUZ6SuFl5BvlBVSw1jgXoZmL7d20PtVOzgh92simUpv9JBGt
	CAgEP+Ar+6MHJ/0IWn8sPKPWKrPiJ7jviGsut55yz0HgwdskVS/ls8k27OHVeLdB
	Zbo0DLgiSVMqfAF1fwv6ec=
Received: from thinkpadx13gen2i.. (unknown [111.48.58.12])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBHhy4CSxdnVG+dAw--.41336S2;
	Tue, 22 Oct 2024 14:49:39 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: valentina.manea.m@gmail.com,
	shuah@kernel.org,
	i@zenithal.me
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH] usbip: tools: update return status when failed
Date: Tue, 22 Oct 2024 14:48:56 +0800
Message-Id: <20241022064856.4098350-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBHhy4CSxdnVG+dAw--.41336S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtry3XFy7ur4xur1DuFy8Zrb_yoWxCrc_C3
	y5Wr4kWrWYka45KF1DGFy8Cryrt3Z8WrZ8Ja1UKr1fG3Wqywn5JFyDA397CF18ur1qqFnx
	twn0qwn8uan5ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8x-BtUUUUU==
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/1tbixxqAq2cXQVKpZwABsa

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

Have to set "ret" before return when found a invalid port.

Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 tools/usb/usbip/src/usbip_detach.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/usb/usbip/src/usbip_detach.c b/tools/usb/usbip/src/usbip_detach.c
index b29101986b5a..6b78d4a81e95 100644
--- a/tools/usb/usbip/src/usbip_detach.c
+++ b/tools/usb/usbip/src/usbip_detach.c
@@ -68,6 +68,7 @@ static int detach_port(char *port)
 	}
 
 	if (!found) {
+		ret = -1;
 		err("Invalid port %s > maxports %d",
 			port, vhci_driver->nports);
 		goto call_driver_close;
-- 
2.34.1


