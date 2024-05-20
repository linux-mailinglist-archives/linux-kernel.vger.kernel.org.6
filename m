Return-Path: <linux-kernel+bounces-183337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B2E8C97CC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C541F21DDF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C8DCA4E;
	Mon, 20 May 2024 02:17:05 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E1C664C80;
	Mon, 20 May 2024 02:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171425; cv=none; b=uBsgMOMDuNV6JL7jB0W83u8B/hiOSuhASMHzvDXlyoTG8hr+OduI560JQXLV2ez5J5KizwqUh9HI2G+ysYw/GYILHfIj6LkA+MiuoUYTFnrxub8aiJuH4G9yjmCbebd3FHlXV5RgPMPpMzAs5MmdW6pioLFud2D3tO73XOK+0lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171425; c=relaxed/simple;
	bh=XHIQ95g/vueEcW57EIQgD5QSEjqfOnGsPYbNMssLwlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zrmn2nMx5RngrEIZYVRtDMSJ7Ff7owdPDk9w4SKsKSV5PeQxnyA3SR66PRXE4TOCHSRa7gI7Ns41odQKJDGyI+yx+4AqisYkKi0XxWVye2xzivMZ7LDu5Dd5FIBX6BZM8jvQu6pwI3/ScdhmEJzpWP/2afMPchrujBShdZb29ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id DE43D6026E8D1;
	Mon, 20 May 2024 10:16:49 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: btintel: remove useless code in btintel_set_dsm_reset_method
Date: Mon, 20 May 2024 10:16:25 +0800
Message-Id: <20240520021625.110430-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang static checker(scan-build) warning:
drivers/bluetooth/btintel.c:2537:14:
Value stored to 'handle' during its initialization is never read.

No need to repeatedly assign values to 'handle'. Remove this useless
code to save some space.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/bluetooth/btintel.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 0c855c3ee1c1..f1c101dc0c28 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2542,8 +2542,6 @@ static void btintel_set_dsm_reset_method(struct hci_dev *hdev,
 		RESET_TYPE_VSEC
 	};
 
-	handle = ACPI_HANDLE(GET_HCIDEV_DEV(hdev));
-
 	if (!handle) {
 		bt_dev_dbg(hdev, "No support for bluetooth device in ACPI firmware");
 		return;
-- 
2.30.2


