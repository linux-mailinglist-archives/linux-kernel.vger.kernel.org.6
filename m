Return-Path: <linux-kernel+bounces-182304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7C18C896F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAE91F21DBD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5DA12F586;
	Fri, 17 May 2024 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="iulV5qwE"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC9D399
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960346; cv=none; b=WNrhxLBcagyvmJ2v/5vCeIB0De7Ocd0E6CsdX+Gyxj/w0wkkzJPfruJFo9ZkcsjQLWC5Ipm+nZknAbLkUIX+dJ3jC4WUKKOicgXjpgYYGZX3pTDqHtEj7kK4dNr7SCCXX8MHE9jNx5X9KPTGimuahxggVFpCmvvtf7+mMnwZx8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960346; c=relaxed/simple;
	bh=mIWuLHQXFJA3fPsK/2/DpeMWfr4s5/DPccEXuN3UTwk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t4TQpRgc4vvALpMqE7+DS0dTucMMpKgiUC+EQcNlkIophkYGcw19tXLO9Phk44wAe9Ix0yJX4nCu5bqjYZFI1ZJTW8FapEqkeod+sPRtARvb3s3Bq4RROvUolNZBGz3vScguoQx9zOdf66S32U8JefFWD72sHlrcw/tmHzMFQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=iulV5qwE; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44H9IA1X031613;
	Fri, 17 May 2024 09:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=9
	HFJH8HtJRV3b6jFWJ0QFKdL+PkB882/okW3yMr/QCE=; b=iulV5qwEaGSGYyX3T
	vFFgD6Jn78m2ithdqKdOMCsG0787dkg5dqJpKWUpmLfOJycOgp8rEz98od2yUJq8
	wFJcDQX+oMUaIfByG8pZL6fxMHSDuttbCPJ5ZyITNUwEAUUhYQfBIKyirl3WFVxF
	q4lwTtW62aa6WtL3iedvrVtvXy5O+70KuG6VH8W/eqc4Ni1sBTJMRsX1K9R/AOHl
	rAGAm7NOn1hSICP5B6h7Jm7F2q04Qev8ogyHi9yFWh7ZOO1tnIGfNcuitRXNM3Cq
	Ggnwit0ZS+N/QkKfgUBEAW6QCJsQSRBubjD+Kqe+XOvMxND5YVuCuyUqWgywXM5F
	+n1Hg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3y253hpgyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 09:47:19 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 17 May
 2024 15:47:03 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Fri, 17 May 2024 15:47:03 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 4EEB7820244;
	Fri, 17 May 2024 14:47:03 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux@roeck-us.net>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] regmap: kunit: Fix array overflow in stride() test
Date: Fri, 17 May 2024 15:47:03 +0100
Message-ID: <20240517144703.1200995-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6UvhAdmPS5elTTw3XAj2WCvYz_O6eEm3
X-Proofpoint-GUID: 6UvhAdmPS5elTTw3XAj2WCvYz_O6eEm3
X-Proofpoint-Spam-Reason: safe

Force the max_register of the test regmap to be one register longer
than the number of test registers, to prevent an array overflow in
the test loop.

The test defines num_reg_defaults = 6. With 6 registers and
stride == 2 the valid register addresses would be 0, 2, 4, 6, 8, 10.
However the loop checks attempting to access the odd address, so on
the final register it accesses address 11, and it writes entry [11]
of the read/written arrays.

Originally this worked because the max_register of the regmap was
hardcoded to be BLOCK_TEST_SIZE (== 12).

commit 710915743d53 ("regmap: kunit: Run sparse cache tests at non-zero
register addresses")
introduced the ability to start the test address range from any address,
which means adjusting the max_register. If max_register was not forced,
it was calculated either from num_reg_defaults or BLOCK_TEST_SIZE. This
correctly calculated that with num_reg_defaults == 6 and stride == 2 the
final valid address is 10. So the read/written arrays are allocated to
contain entries [0..10]. When stride attempted to access [11] it was
overflowing the array.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 710915743d53 ("regmap: kunit: Run sparse cache tests at non-zero register addresses")
---
 drivers/base/regmap/regmap-kunit.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 9c5314785fc2..be32cd4e84da 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -609,12 +609,19 @@ static void stride(struct kunit *test)
 	config.reg_stride = 2;
 	config.num_reg_defaults = BLOCK_TEST_SIZE / 2;
 
+	/*
+	 * Allow one extra register so that the read/written arrays
+	 * are sized big enough to include an entry for the odd
+	 * address past the final reg_default register.
+	 */
+	config.max_register = BLOCK_TEST_SIZE;
+
 	map = gen_regmap(test, &config, &data);
 	KUNIT_ASSERT_FALSE(test, IS_ERR(map));
 	if (IS_ERR(map))
 		return;
 
-	/* Only even registers can be accessed, try both read and write */
+	/* Only even addresses can be accessed, try both read and write */
 	for (i = 0; i < BLOCK_TEST_SIZE; i++) {
 		data->read[i] = false;
 		data->written[i] = false;
-- 
2.39.2


