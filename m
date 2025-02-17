Return-Path: <linux-kernel+bounces-517940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B6AA387DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA111898D69
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A06224B08;
	Mon, 17 Feb 2025 15:39:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D56225796
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806777; cv=none; b=IeBTMpH68jtIYX0l6iMPIeqOD/9i8DDssZyd56p4LvRAZCDrOBfA3HoKk21zvhgnJBMFaTXX1hwlFRtWoOZbBnMhX+/86g2xc6SQxClpJrg0pnhOmx33MlfeIFuZHl+h21iys1NmlWThw+AwocuPQcxfmwq8Zsu4T0QjVoOSIu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806777; c=relaxed/simple;
	bh=6tk8gj2eQR3xF36vKVIBCFo6uvkjtZ49zGerQFo2eXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=S1SRzBqhWaZJtB6RCfVlayH9hiH820iNtLlBdHlAfdyzPqZKSt2pYywRPGLmZgx2HnAZGM3ry6kjCv4GBzi8JbwlYrnJfN87qD7kK7cXavS8M/oTM8zMeczPd/ZhGrW70FEYB53T/F+67+yAcjJrM2oqJChxVutlsKkZASnSobs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34A01152B;
	Mon, 17 Feb 2025 07:39:55 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50C3B3F6A8;
	Mon, 17 Feb 2025 07:39:35 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Feb 2025 15:38:48 +0000
Subject: [PATCH v3 07/19] firmware: arm_ffa: Handle the presence of host
 partition in the partition info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-ffa_updates-v3-7-bd1d9de615e7@arm.com>
References: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
In-Reply-To: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1299; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=6tk8gj2eQR3xF36vKVIBCFo6uvkjtZ49zGerQFo2eXY=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBns1guFR2P3ZAYTDXm79bampucM4MzsML2AAF1Z
 wlfbUOBIBOJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ7NYLgAKCRAAQbq8MX7i
 mA9gEAC/s7Ip5MiS5BNwl3ycwMoksoHHeMdXCXWGldQWd4NYn/MI0Vp63/rrUiQp2ZPkfPobLD9
 aIyQP/QiPRSsl0uPiJbJxUjgKVGWxtXzIkmuC6w6nqzEDWpw6lbSHe55e3WIVuMCBBSS24VRYN2
 XsI91tS+cOQMftfLSXmBW4RJgwB4f7zVhz2nxOJTCe5zmlLl5hc4V1NFCFii5d4lRkx8wiKbK7g
 GvmeTPDyPFx+cwSfiCrVAhrQ12TW1HcoJTZ7L8Gb2OKdaLSDAJop6/HHzXL9SmuFHX2XVFfW/+K
 A20jqhQzcYikgSN5Gw5edq7eCiY9hSodIXBm7vfmpJxbzd8Ac7EkWlwcL0sB2EmKDnOhnMYe7Ka
 nKcGpQ3c9e4Jf9GojZ47uFmw8h8iOuQTTVpdd/Y8nJTetRb/VahjdnTDUouyTtNMc/nsSwSieKf
 J679LyxffXfO3gqNU1sFd9stK/Z8lU9cf99g5WzJV3y0NT5d1tjrn9MbBZZ/cQgIbpGaiA3k89L
 GckMHKc47WtYpJB1GUVoy6dLWANzF/YkvznKT0oB7olu5avlhOCBUm4lufyumg9i2zw4tfngNPD
 edeHnGh/82UGjpO5pF6o6+ahLiZzlQHrEc+QrJAi6jRTFXZcqbFY5z6DzZ9H6q4b9UHOjI7aq/4
 VRN2Luipkw1WgDA==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

Currently it is assumed that the firmware doesn't present the host
partition in the list of partitions presented as part of the response
to PARTITION_INFO_GET from the firmware. However, there are few
platforms that prefer to present the same in the list of partitions.
It is not manadatory but not restricted as well.

So handle the same by making sure to check the presence of the host
VM ID in the XArray partition information maintained/managed in the
driver before attempting to add it.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 2994b5ee63bc7feafc15e535cf8a2d46e6003968..320ae654cb968ef573995764d9d35c027d74a33b 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1488,6 +1488,10 @@ static int ffa_setup_partitions(void)
 
 	kfree(pbuf);
 
+	/* Check if the host is already added as part of partition info */
+	if (xa_load(&drv_info->partition_info, drv_info->vm_id))
+		return 0;
+
 	/* Allocate for the host */
 	ret = ffa_xa_add_partition_info(drv_info->vm_id);
 	if (ret) {

-- 
2.34.1


