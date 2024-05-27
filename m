Return-Path: <linux-kernel+bounces-191037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E9A8D05CB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A851C20A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5390D16F823;
	Mon, 27 May 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="C9DfpX3s"
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D04316F0FE
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822165; cv=none; b=kyJNI2Nvt2wwkSyyUjclLPqLbRqOkHwqGAEINC2bF7CXj/axtcGRmbK6rhS8tbY9ORFso98SBSRePAyyr5+HfJ3YTBLq3MvfMHSyv7S04AQz0UIzxMlXMACiugGYCEHo+RLTwrl7/iKp7P+pAHtQCGUeu4vJaeOrCkG4X+B/P+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822165; c=relaxed/simple;
	bh=3+YL0eQjbechtjlZb3uB0GxuQXjYmHn+ITIAg1aUPEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FJgHNqhSIQg5Oh8yyCUWYvkq25cYpIdejOmGbcPZI+MUfSMz4Yk2OoBhyh+gf3cj1yiHt+9xswoAT9bPDGm/uGdFgaukuj65vDq+5ZS2WJXtGIhLtbX+53uUcBtObbCBKhkrqsJ0IzSYSTLh6v3bWpuCw5kshFv9iSds+COq6ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=C9DfpX3s; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716822151; bh=3+YL0eQjbechtjlZb3uB0GxuQXjYmHn+ITIAg1aUPEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C9DfpX3sPr8XuD5qvYfKgzv7yT1uDuxthmI+jZAwXvStGpd+6Ob4hp0jgI6kzq9y+
	 4raN1k3zAFntcTcuomUAXid5l18NuFDS8xQQiaRKEr/JCse6Fxel7ZjUQYeK+itxUS
	 w2RvauWjnaO9JIM7nJmM3cjHs6u7ikKo2au/Q1X2VR02OdQZNqBROrtXLN+EP9VHWk
	 eNXOolsXpmvXpYofsL6Xdg/Wv3ZdZlhQnJrGn9b7VahTaFxxpU0BvJQpC9dWwQ4Dcv
	 G1ywwBF61DXnsQr0kC4v8QUasQDKODyHA8Gc+k30jT/Z7zXPxGQy8lek1g6Cu7Atsv
	 M8wbqUXKDajcw==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RF2PiV1954007;
	Mon, 27 May 2024 18:02:26 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Vitaly Margolin <vmargolin@habana.ai>
Subject: [PATCH 4/8] accel/habanalabs: add cpld ts cpld_timestamp cpucp
Date: Mon, 27 May 2024 18:02:20 +0300
Message-Id: <20240527150224.1953969-4-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527150224.1953969-1-obitton@habana.ai>
References: <20240527150224.1953969-1-obitton@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitaly Margolin <vmargolin@habana.ai>

Add cpld_timestamp field to cpucp_info structure and return cpld
timestamp as part of cpld version

Signed-off-by: Vitaly Margolin <vmargolin@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/common/sysfs.c | 5 +++--
 include/linux/habanalabs/cpucp_if.h     | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/habanalabs/common/sysfs.c b/drivers/accel/habanalabs/common/sysfs.c
index b6c63f8a0c1b..e9f8ccc0bbf9 100644
--- a/drivers/accel/habanalabs/common/sysfs.c
+++ b/drivers/accel/habanalabs/common/sysfs.c
@@ -142,8 +142,9 @@ static ssize_t cpld_ver_show(struct device *dev, struct device_attribute *attr,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	return sprintf(buf, "0x%08x\n",
-			le32_to_cpu(hdev->asic_prop.cpucp_info.cpld_version));
+	return sprintf(buf, "0x%08x%08x\n",
+		le32_to_cpu(hdev->asic_prop.cpucp_info.cpld_timestamp),
+		le32_to_cpu(hdev->asic_prop.cpucp_info.cpld_version));
 }
 
 static ssize_t cpucp_kernel_ver_show(struct device *dev,
diff --git a/include/linux/habanalabs/cpucp_if.h b/include/linux/habanalabs/cpucp_if.h
index 0913415243e8..1ed17887f1a8 100644
--- a/include/linux/habanalabs/cpucp_if.h
+++ b/include/linux/habanalabs/cpucp_if.h
@@ -1146,6 +1146,7 @@ struct cpucp_security_info {
  *                (0 = fully functional, 1 = lower-half is not functional,
  *                 2 = upper-half is not functional)
  * @sec_info: security information
+ * @cpld_timestamp: CPLD programmed F/W timestamp.
  * @pll_map: Bit map of supported PLLs for current ASIC version.
  * @mme_binning_mask: MME binning mask,
  *                    bits [0:6]   <==> dcore0 mme fma
@@ -1193,7 +1194,7 @@ struct cpucp_info {
 	__u8 substrate_version;
 	__u8 eq_health_check_supported;
 	struct cpucp_security_info sec_info;
-	__le32 reserved2;
+	__le32 cpld_timestamp;
 	__u8 pll_map[PLL_MAP_LEN];
 	__le64 mme_binning_mask;
 	__u8 fw_os_version[VERSION_MAX_LEN];
-- 
2.34.1


