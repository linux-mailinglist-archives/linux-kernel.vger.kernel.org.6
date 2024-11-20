Return-Path: <linux-kernel+bounces-416103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D969D4049
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BEC281649
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D481547F5;
	Wed, 20 Nov 2024 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9ZKrwdS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F0D57C93
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120873; cv=none; b=LuGcR5x8gOjdR5WTZ2meiEtKXn7prVsVzbYVGd8TP3+NbO3p6HQDIKFiU/NTqTXLxsU0CGmmX1QLd9Rxe7HHSwXV7ZhmVWmrXZEC61uvtAuo4UEtFbek75czPxpaIYn6zBP2EAlPsDgghNzd8l3AcWmg9c4oxttJO/ryb32J6Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120873; c=relaxed/simple;
	bh=aUx8WmvWUdZe9uCMbeOk+jGccDxP0v/Ty901ThIZ4mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I64OHLIZ0sdjEhw6hEoItetrRQ8JTSe2ozHfi28u5twaSiyIRp8qb8w4fIQI77W/ARMmbdf+gxYBZv6z67yExrLUnGEzTziYg5gpZNVa7m00VAYq8449HHQvfOT8dpiC7cbk/lPgmYweEfZDDiP66msjh06WJXSJP3v/Tx21ZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9ZKrwdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F790C4CECD;
	Wed, 20 Nov 2024 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732120872;
	bh=aUx8WmvWUdZe9uCMbeOk+jGccDxP0v/Ty901ThIZ4mw=;
	h=From:To:Cc:Subject:Date:From;
	b=Z9ZKrwdS9ZyEVCD6hk720/pVYqlXnt+g5p0RZARxQZHy8wN369KFm6kZkSFGBNCOT
	 9iVkdTsQxlzj8A8U8uHGGmLKerBOAzpuPtN6Yfn1QOsxPTILo/+J1rff5SDSL7uIQr
	 biPvRqhPR+yUi45Q7BUW0mHr1USfIS2lYIRKDyXYuY+eLuGPTDFY/1s3P6lSfRLV8x
	 iAO+88OL++YYqWiUyNAI9kpRs/48XF//reGdrx6FlRIpqDeSUC1TwZFASaCa10OVpM
	 3PyTtA2tyESB5y4+DzIi1CBDZ+4CU7kkrw2ZKsDizVq953LmXT9X0JQma/MXW5SsK2
	 OBr43+lRu0k4g==
From: Namhyung Kim <namhyung@kernel.org>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Stephane Eranian <eranian@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf/arm-cmn: Fix arm_cmn_node_to_xp()
Date: Wed, 20 Nov 2024 08:41:10 -0800
Message-ID: <20241120164110.266297-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The portid_bits and deviceid_bits for XP type nodes are set in the
arm_cmn_discover() and it's copied to others in arm_cmn_init_dtcs().
But to get the XP from a node in the arm_cmn_init_dtcs(), it needs
the {port,device}id_bits.

This makes arm-cmn PMU failing to count events on my setup.  What we
need is the number of bits in total which is known by the cmn config.

Fixes: e79634b53e39 ("perf/arm-cmn: Refactor node ID handling. Again.")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 drivers/perf/arm-cmn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 49bd811c6fd6efdd..0e0d2f5cfdaea890 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -386,7 +386,7 @@ static struct arm_cmn_nodeid arm_cmn_nid(const struct arm_cmn_node *dn)
 static struct arm_cmn_node *arm_cmn_node_to_xp(const struct arm_cmn *cmn,
 					       const struct arm_cmn_node *dn)
 {
-	int id = dn->id >> (dn->portid_bits + dn->deviceid_bits);
+	int id = dn->id >> (cmn->num_xps == 1 ? 5 : 3);
 	int bits = arm_cmn_xyidbits(cmn);
 	int x = id >> bits;
 	int y = id & ((1U << bits) - 1);

base-commit: bf9aa14fc523d2763fc9a10672a709224e8fcaf4
-- 
2.47.0.338.g60cca15819-goog


