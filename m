Return-Path: <linux-kernel+bounces-513351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD9FA34986
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC963AB26A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5F9200100;
	Thu, 13 Feb 2025 16:13:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4868202F72
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463212; cv=none; b=XkhW+B1Oxy1P/cDtCaOL3JWdNdeb3eyHcZrKrT4bklAai9aXnr5TtvKmLSvIAZbx86MLJiVM9xjd/tggFBv+66TKBIfeILqEOflHq+pcWFaX5M1u10UEDk7r2OlYISweNwxUzb90F7BpxDKoHfY2apukDX4NU+plzIgQr5+q73s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463212; c=relaxed/simple;
	bh=MJNeQypHksqBGTQi1UN/30/JOXYdU1SM+UCWIlibTlk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GglNKmr8mDX1GJ1b36RtHNN4IHWM/62TShNW5M88di6/B00FjxGBlJZEdyWCjn+trxzNebQ2EYqC4a/4JiA2pQfJA0BlSh1OQPXJ7+edl63k+j/NmCQ0CiSh2gv3l7lEkIZLo5Lcz7BpOcflhLH6AWMCncUMuvpTLFDaiz1HCZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 598D21756;
	Thu, 13 Feb 2025 08:13:50 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE70B3F6A8;
	Thu, 13 Feb 2025 08:13:27 -0800 (PST)
From: Steven Price <steven.price@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	David Airlie <airlied@gmail.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Steven Price <steven.price@arm.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>
Subject: [PATCH] drm/panthor: Clean up FW version information display
Date: Thu, 13 Feb 2025 16:12:48 +0000
Message-Id: <20250213161248.1642392-1-steven.price@arm.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assigning a string to an array which is too small to include the NUL
byte at the end causes a warning on some compilers. But this function
also has some other oddities like the 'header' array which is only ever
used within sizeof().

Tidy up the function by removing the 'header' array, allow the NUL byte
to be present in git_sha_header, and calculate the length directly from
git_sha_header.

Reported-by: Will Deacon <will@kernel.org>
Fixes: 9d443deb0441 ("drm/panthor: Display FW version information")
Signed-off-by: Steven Price <steven.price@arm.com>
---
Note that there should be no functional change from this patch.
---
 drivers/gpu/drm/panthor/panthor_fw.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 4a9c4afa9ad7..645fc6d2e63b 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -636,8 +636,8 @@ static int panthor_fw_read_build_info(struct panthor_device *ptdev,
 				      u32 ehdr)
 {
 	struct panthor_fw_build_info_hdr hdr;
-	char header[9];
-	const char git_sha_header[sizeof(header)] = "git_sha: ";
+	const char git_sha_header[] = "git_sha: ";
+	const int header_len = sizeof(git_sha_header) - 1;
 	int ret;
 
 	ret = panthor_fw_binary_iter_read(ptdev, iter, &hdr, sizeof(hdr));
@@ -651,8 +651,7 @@ static int panthor_fw_read_build_info(struct panthor_device *ptdev,
 		return 0;
 	}
 
-	if (memcmp(git_sha_header, fw->data + hdr.meta_start,
-		   sizeof(git_sha_header))) {
+	if (memcmp(git_sha_header, fw->data + hdr.meta_start, header_len)) {
 		/* Not the expected header, this isn't metadata we understand */
 		return 0;
 	}
@@ -665,7 +664,7 @@ static int panthor_fw_read_build_info(struct panthor_device *ptdev,
 	}
 
 	drm_info(&ptdev->base, "Firmware git sha: %s\n",
-		 fw->data + hdr.meta_start + sizeof(git_sha_header));
+		 fw->data + hdr.meta_start + header_len);
 
 	return 0;
 }
-- 
2.39.5


