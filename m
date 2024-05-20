Return-Path: <linux-kernel+bounces-183338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 749528C97CF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303F0281FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735EAF9FE;
	Mon, 20 May 2024 02:17:06 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id E1C9A746E;
	Mon, 20 May 2024 02:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171426; cv=none; b=nE+VTPYTSuW+/kgOvFdCSC5ByzQoKSIBZsXlD4O4UoFqsEXoZrZyKHiPfMMoKHOBuq4ICAAug3D3V4RRuxFeWoR6iIUfI4FyvuJE5b1G7ApPL9tEE2C/tnHkDmH/ZP27kW9TxRvoMW2MvLBAkv/VX+KH9x/JthJOwKj/pcPtErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171426; c=relaxed/simple;
	bh=gvbWzLdHHAwB+c4e8VFjeusevcuOlKHRkliYwF5b56w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=dBAwVFLAKvPvAuOWzWQ1jcmvJUA5cLJ4DvyQFX2cIF4C39qDwiyTFq8KPJCbSO8UeRUeTgDqPwHzbNQPa5o8vD39Sz8unXw02P55ILTPbIAXsp4ezvg7JviR48laU0aKNaB6ULZlsixAH2YSJQmZxcO+slBc785SD+DYHENjKMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 0246C6026E8DA;
	Mon, 20 May 2024 10:16:53 +0800 (CST)
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
	kiran.k@intel.com,
	seema.sreemantha@intel.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2]  Bluetooth: btintel: fix use after free problem in btintel_ppag_callback()
Date: Mon, 20 May 2024 10:16:27 +0800
Message-Id: <20240520021625.110430-2-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240520021625.110430-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang static checker(scan-build) warning:
drivers/bluetooth/btintel.c:1369:8: Use of memory after it is freed.

'p' is equal to 'buffer.pointer', using of 'p->type' after releasing
'buffer.pointer' causes this use after free problem.
Change the order of releasing buffer.pointer to fix this problem.

Fixes: c585a92b2f9c ("Bluetooth: btintel: Set Per Platform Antenna Gain(PPAG)")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index f1c101dc0c28..d94a8ccd1428 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1364,9 +1364,9 @@ static acpi_status btintel_ppag_callback(acpi_handle handle, u32 lvl, void *data
 	ppag = (struct btintel_ppag *)data;
 
 	if (p->type != ACPI_TYPE_PACKAGE || p->package.count != 2) {
-		kfree(buffer.pointer);
 		bt_dev_warn(hdev, "PPAG-BT: Invalid object type: %d or package count: %d",
 			    p->type, p->package.count);
+		kfree(buffer.pointer);
 		ppag->status = AE_ERROR;
 		return AE_ERROR;
 	}
-- 
2.30.2


