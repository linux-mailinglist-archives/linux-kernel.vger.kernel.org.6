Return-Path: <linux-kernel+bounces-362324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEED99B399
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 13:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF5B1C21BE8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D96B1A08A9;
	Sat, 12 Oct 2024 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVFQPRqp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6FF1A01D8;
	Sat, 12 Oct 2024 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732411; cv=none; b=aOfdrmRfS5oZz6fHqlc6eckR/APm1riRxZsGv5ybx2iI4NyfO+WFwx5BRQ6nDdQa8i0vksFLyte3zELY2bMHwnSVNBIjBBrqwdMfO8SBM8v+dd27U66CxIyg/oAzKBcEEkGA29IkpKvMjKtcmThsGK7aBpiIVsXG+oS1gv5F6W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732411; c=relaxed/simple;
	bh=KRRLzBqHkoU7FseJTT5an88vfcLE/edbrAxlRGMve6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8u/LttKY9BTBJNm3yNiXOM5qK1XZlih9wm3Mt8ezB4rSMrnZZrNkz91tZ1hpCu4zhV7Wd6Y4rFNxZpBZ/IvbVHTUq2KC7SFJg3tu064NgOAHXfYKAYwR4rCwwdnrrbVSxJaf1e4jANPYCNR9g8+uuq8m0B1g/O5QFkVocdxBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVFQPRqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E895C4CEC6;
	Sat, 12 Oct 2024 11:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732411;
	bh=KRRLzBqHkoU7FseJTT5an88vfcLE/edbrAxlRGMve6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eVFQPRqpjaOvfV2k0nyqjxBEUOlzEHRwPrY/cbJP9AX3QDljF946n+tRWSHdJK3Fb
	 nXgidl4Wyk/4r1a5fct+2eizliYn6vmQz8w5NvktSXYGuOiTxpZRc2y1hcDZpOvaFp
	 NBq1RpaP9kyBKwUynBQMHz6T8LymiXxVhpVCqRsCdf67MCCwiFyuy2x97V6luvHv60
	 +fQ1qf1zvu1SG+ihSx7CZX2g+ymU6UBg5OfQJnceDIdvDP5KG1BFC0KTgjM4hY8qz9
	 YbB1X2YZmkd053NWCvInDmRVK25sdCFa/wqRDeZmRvQ45dNcThHm76v6fzDi1dJpF8
	 ZChSMMHbRFurA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Crag Wang <crag_wang@dell.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	prasanth.ksr@dell.com,
	ilpo.jarvinen@linux.intel.com,
	Dell.Client.Kernel@dell.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 16/16] platform/x86: dell-sysman: add support for alienware products
Date: Sat, 12 Oct 2024 07:26:12 -0400
Message-ID: <20241012112619.1762860-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112619.1762860-1-sashal@kernel.org>
References: <20241012112619.1762860-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Crag Wang <crag_wang@dell.com>

[ Upstream commit a561509b4187a8908eb7fbb2d1bf35bbc20ec74b ]

Alienware supports firmware-attributes and has its own OEM string.

Signed-off-by: Crag Wang <crag_wang@dell.com>
Link: https://lore.kernel.org/r/20241004152826.93992-1-crag_wang@dell.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index 9def7983d7d66..40ddc6eb75624 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -521,6 +521,7 @@ static int __init sysman_init(void)
 	int ret = 0;
 
 	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
+	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL) &&
 	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
 		pr_err("Unable to run on non-Dell system\n");
 		return -ENODEV;
-- 
2.43.0


