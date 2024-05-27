Return-Path: <linux-kernel+bounces-190539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD65E8CFFA7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60881B22D06
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DAB15E5AA;
	Mon, 27 May 2024 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="oiOfkJPX"
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A415DBB9
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811993; cv=none; b=C2qUVoY77lBiDu+iuujXSV9nKShcPCAsCB5EhJ+EE4nPT7+hveMHMXmPrEshUBzytVUU0/bCVgk6L+sZ9hiTsR7liOYlP2ybLYZnmWDtpvudjtZLIUdS+xxHwdeSeIlCYtzMmGUlv5b9xQk6/3O8D3aw7KSxt0aw6//oZ/qGyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811993; c=relaxed/simple;
	bh=jEOjfncRnHrY/GOzNXLpivOmaWg+BBdNPnztm7r0mH8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SSbwEm3ylyO7Jb/2KdCOePcX8mGI5GrqRNNGCzVE7/igI9AXUIat0dz9LX7czdoimoMzAeVBcu12+y/g5zqBhqvF/0Toj2K6/NHTXgK5fjg8a0XQMbBkdvoaEVUrFuCofbmtZ4e3bujZCbWvxXBMtZtASa/MA0qUB00gh7dPoU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=oiOfkJPX; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716811982; bh=jEOjfncRnHrY/GOzNXLpivOmaWg+BBdNPnztm7r0mH8=;
	h=From:To:Cc:Subject:Date:From;
	b=oiOfkJPX8EvLromWEhc+OBGh0jTo6HhFUurBbH+ItJWBQgulfLoxrTNFWkPllmHzC
	 4f5nPBaR4/YBIhEb++Z7iaQLecrROgCM2Q5zOsXJgEw1+kjP2EHyzmKz7w6se1/lq+
	 SJw4kMmWLt/U1UObkRwM3Q4gyzCHXB7aOtkVhXr/7vnssqQySbrH1SCB/s2F3+51Vt
	 xTeG4KJOX7rdjMbooNAWbMDc2mQthgkI8pACSov7e0l8pMymF1C5VMTS6ZmeYfzhS/
	 B9N1U5T2Edvr9Km/Q8CNoUxdUA9oRTIjuYZCUJYvyC0bse39D5BGJUaEQgn9XlWzMA
	 30wkqU2xwtH9w==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RCCuar1921351;
	Mon, 27 May 2024 15:12:57 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Igal Zeltser <izeltser@habana.ai>
Subject: [PATCH 1/8] accel/habanalabs: use msg_header instead of desc_header
Date: Mon, 27 May 2024 15:12:47 +0300
Message-Id: <20240527121254.1921306-1-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Igal Zeltser <izeltser@habana.ai>

Struct comms_desc_header is deprecated and replaced by struct
comms_msg_header. As a preparation for removing comms_desc_header
from FW, all it's usage in code is replaced by comms_msg_header.

Signed-off-by: Igal Zeltser <izeltser@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/common/firmware_if.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/habanalabs/common/firmware_if.c b/drivers/accel/habanalabs/common/firmware_if.c
index d1a1d601bde9..886b3c07503d 100644
--- a/drivers/accel/habanalabs/common/firmware_if.c
+++ b/drivers/accel/habanalabs/common/firmware_if.c
@@ -2093,7 +2093,7 @@ static int hl_fw_dynamic_validate_descriptor(struct hl_device *hdev,
 	 * note that no alignment/stride address issues here as all structures
 	 * are 64 bit padded.
 	 */
-	data_ptr = (u8 *)fw_desc + sizeof(struct comms_desc_header);
+	data_ptr = (u8 *)fw_desc + sizeof(struct comms_msg_header);
 	data_size = le16_to_cpu(fw_desc->header.size);
 
 	data_crc32 = hl_fw_compat_crc32(data_ptr, data_size);
@@ -2247,11 +2247,11 @@ static int hl_fw_dynamic_read_and_validate_descriptor(struct hl_device *hdev,
 	memcpy_fromio(fw_desc, src, sizeof(struct lkd_fw_comms_desc));
 	fw_data_size = le16_to_cpu(fw_desc->header.size);
 
-	temp_fw_desc = vzalloc(sizeof(struct comms_desc_header) + fw_data_size);
+	temp_fw_desc = vzalloc(sizeof(struct comms_msg_header) + fw_data_size);
 	if (!temp_fw_desc)
 		return -ENOMEM;
 
-	memcpy_fromio(temp_fw_desc, src, sizeof(struct comms_desc_header) + fw_data_size);
+	memcpy_fromio(temp_fw_desc, src, sizeof(struct comms_msg_header) + fw_data_size);
 
 	rc = hl_fw_dynamic_validate_descriptor(hdev, fw_loader,
 					(struct lkd_fw_comms_desc *) temp_fw_desc);
-- 
2.34.1


