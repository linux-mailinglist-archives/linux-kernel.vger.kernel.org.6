Return-Path: <linux-kernel+bounces-190504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8328CFF4C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5F21C22217
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC5C15ECFE;
	Mon, 27 May 2024 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="AVTOolle"
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486CA15E5BE
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810524; cv=none; b=XraOimwGCi9npm6mwEh4ddC9iXEGGUAZl48JDmnx7nbWByf2Gyaowt/tIeW/ZKv2tOI1eaQ70CqszIJxMjHzmRWM2GNYR3BEDGqW+tAT3YU3/irSM95roalFw8foKt8bA8Uz1zwxIcHTTdW+P2xfZspcPpdKKUk4sNfa1grBr1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810524; c=relaxed/simple;
	bh=x6tqM8fBidIiiw78QtTBz20JiOc/vpqs+EK1lmsNOKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W5AwYAplJz+J3OHiW0j/ZNmh2Febeh5J65pdDskT/PTkWmX2sx6YAzXvYJw6rwO6gBcbv6spQFe8sDHR6uLXY1fqoWSEOJNkE9OmRI6ie1RVdRd831WAf9CHdQnJ7BXxYjoFJej8F+h2msJaa/v7KdZv9++clw6LWirSEbWX/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=AVTOolle; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716810481; bh=x6tqM8fBidIiiw78QtTBz20JiOc/vpqs+EK1lmsNOKc=;
	h=From:To:Cc:Subject:Date:From;
	b=AVTOollesVWN0FmcbNvyWhHx3idcaLiBLndGrGy29oMLV0zD9Hh1W5RfHvjuZjezA
	 OatrqsaEv+J9DiGVdgi3SCJW2gH5BBa0APEBjz1FZzVtyyLOpPSsubXLYt1wqlx3ii
	 2UyvvWkUWRXBe2vrFufQhEyKohFoP3+ec/jHXfpPxuS5hzSqZDVtZjYqNKZqrKJfEP
	 CkWg3ev1rJFL/MIWnmX56w0Dhzvml8Foz7hC0qwjWvRgO+92UK0zTKnwlqhOd5Lluq
	 hjIkMEeyR5gZo8ajRrILUd+KJz2cM9kQbsZg+B9IxbKyBLPtA++Nq5iqYzFeDfjbnN
	 Geu8CkqVyOfgQ==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RBltNf1919357;
	Mon, 27 May 2024 14:47:55 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 1/9] accel/habanalabs: add device name to error print
Date: Mon, 27 May 2024 14:47:38 +0300
Message-Id: <20240527114746.1919292-1-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dani Liberman <dliberman@habana.ai>

The extra info will help in better traceability and debug.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/common/device.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 8f92445c5a90..a381ece25592 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -439,16 +439,19 @@ static void print_idle_status_mask(struct hl_device *hdev, const char *message,
 					u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE])
 {
 	if (idle_mask[3])
-		dev_err(hdev->dev, "%s (mask %#llx_%016llx_%016llx_%016llx)\n",
-			message, idle_mask[3], idle_mask[2], idle_mask[1], idle_mask[0]);
+		dev_err(hdev->dev, "%s %s (mask %#llx_%016llx_%016llx_%016llx)\n",
+			dev_name(&hdev->pdev->dev), message,
+			idle_mask[3], idle_mask[2], idle_mask[1], idle_mask[0]);
 	else if (idle_mask[2])
-		dev_err(hdev->dev, "%s (mask %#llx_%016llx_%016llx)\n",
-			message, idle_mask[2], idle_mask[1], idle_mask[0]);
+		dev_err(hdev->dev, "%s %s (mask %#llx_%016llx_%016llx)\n",
+			dev_name(&hdev->pdev->dev), message,
+			idle_mask[2], idle_mask[1], idle_mask[0]);
 	else if (idle_mask[1])
-		dev_err(hdev->dev, "%s (mask %#llx_%016llx)\n",
-			message, idle_mask[1], idle_mask[0]);
+		dev_err(hdev->dev, "%s %s (mask %#llx_%016llx)\n",
+			dev_name(&hdev->pdev->dev), message, idle_mask[1], idle_mask[0]);
 	else
-		dev_err(hdev->dev, "%s (mask %#llx)\n", message, idle_mask[0]);
+		dev_err(hdev->dev, "%s %s (mask %#llx)\n", dev_name(&hdev->pdev->dev), message,
+			idle_mask[0]);
 }
 
 static void hpriv_release(struct kref *ref)
-- 
2.34.1


