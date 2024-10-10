Return-Path: <linux-kernel+bounces-358564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DEA9980E7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653ED1C28ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3051C461B;
	Thu, 10 Oct 2024 08:42:41 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6EA651BDA97
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549761; cv=none; b=qC3ZxTTihqEhPd0IKqA6jIznC7wvoVTjdqzr5gzXEQNSUcUFtWpApeN/3MPfTlb6WV3k+vneuJWUQlUFHi7Uz6aL/kySf7pg/8hBmoENqRn6YE5iRHLSMSzjWHIJ4jRIRbwllVwRbzCo4jLoRgExpdhjWisAZArDOhMe0o0Q1iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549761; c=relaxed/simple;
	bh=1SRuyuIohbLFtcg6BPhlqyGBJVjS20DAgNE1TE4cI6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gDxKu803fEOZJiMPrIOUJAGxEnqEzleeQphNUYiVj9zVPudjcYd7OA7fX7P8B3Zc7PxQjhklXlbgnVg+UQdJFASZiOdkO6TPfYMBDRq5cqnx1yfXX88T71HdckQoxF4EQBiyz2CI5ROVv6OKbIubc83fpQ5/TunqtMleQzves+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.3])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPA id CD6F760573D92;
	Thu, 10 Oct 2024 16:42:27 +0800 (CST)
X-MD-Sfrom: youwan@nfschina.com
X-MD-SrcIP: 103.163.180.3
From: Youwan Wang <youwan@nfschina.com>
To: jonathan.cameron@huawei.com
Cc: yangyicong@hisilicon.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Youwan Wang <youwan@nfschina.com>
Subject: [PATCH] drivers/perf: hisi: Fix readl DDRC_VERSION stuck
Date: Thu, 10 Oct 2024 16:42:17 +0800
Message-Id: <20241010084217.37540-1-youwan@nfschina.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CPU of the device I am using is kunpeng 920,
which can start normally with version 5.4 kernel.
However, when installing version 6.6 kernel, the
kernel gets stuck when loading the "hisi_dddrc_pmu"
driver. I went to debug and found that it gets stuck
when "readl (ddrc_pmu ->base+DDRC_VERSION)". I suspect
that the hardware does not support it. My modification is:
for the "HISI0233" device, according to the implementation
of version 5.4 kernel, the identity is not obtained from
the register. For "identifier" sysfs, identifier: 0

Signed-off-by: Youwan Wang <youwan@nfschina.com>
---
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index b804e3738113..3cecad46b01f 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -321,6 +321,9 @@ static int hisi_ddrc_pmu_init_data(struct platform_device *pdev,
 		return PTR_ERR(ddrc_pmu->base);
 	}
 
+	if (strstr(pdev->name, "HISI0233"))
+		return 0;
+
 	ddrc_pmu->identifier = readl(ddrc_pmu->base + DDRC_VERSION);
 	if (ddrc_pmu->identifier >= HISI_PMU_V2) {
 		if (device_property_read_u32(&pdev->dev, "hisilicon,sub-id",
-- 
2.25.1


