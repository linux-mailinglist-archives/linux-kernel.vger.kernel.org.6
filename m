Return-Path: <linux-kernel+bounces-306318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55158963D38
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886AC1C23E77
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41DA1898E7;
	Thu, 29 Aug 2024 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MuktuyYN"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCA718785D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724917027; cv=none; b=u6gOjzEjSRItMAE3GBJ857lQ0ptnx5h4aCxEZKcrADjsNhGMkPFU4/nD8nt2NX6jH8HxhySInc7wVCViXHGMo+GAStuqM0qvpfT16p5z/PPeMpe2cmGkFXlC5XKerxe8Uzd+e5Bunghz/vk/XzSvzazRHnaD86QnMKvN3rdj7Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724917027; c=relaxed/simple;
	bh=579e1em72hYppKwvYLuoJ7xtVA6CYWQqEq2DSOX2Bss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K33zLlVLOka3meqvr3SYlg7IUl1IX36Ug4j+P5vwcgec6w3fGiQyhroGapCsIOuHHCN/uRiuroFEuWa5M13OzqGnauzRjehgeGQ3eSjMBd0nWJHizGy9/Z9126IKMjL+evaDm+XyN1Nx/IdX41XbjOODInY3eTYdJfJmwAJNJE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MuktuyYN; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724917022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ALtutDznnBIBWRl97NM8C++LDGb9aRH7cJ3w/3pEQXQ=;
	b=MuktuyYN1AEa9jhJeCltEu+uQqOa+EnZSeKTDLDVSChsT2VDtBgTrbtamMr/nLQbKg4bxp
	0VdoWS1SbKRaXzbAqQSxmEccWASLqKJL9Ak14yW2TsnGXuTh8P5X+WfKi2/IKrIrIyFlvL
	xy17u+lqyf6u38hm36X48c4cQa21yIY=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] dm-integrity: Remove duplicate 'unlikely()' usage
Date: Thu, 29 Aug 2024 15:36:56 +0800
Message-ID: <20240829073656.37399-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

nested unlikely() calls, IS_ERR already uses unlikely() internally

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/md/dm-integrity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 51e6964c1305..8306f8511078 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -2447,7 +2447,7 @@ static int dm_integrity_map_inline(struct dm_integrity_io *dio)
 	bio->bi_iter.bi_sector += ic->start + SB_SECTORS;
 
 	bip = bio_integrity_alloc(bio, GFP_NOIO, 1);
-	if (unlikely(IS_ERR(bip))) {
+	if (IS_ERR(bip)) {
 		bio->bi_status = errno_to_blk_status(PTR_ERR(bip));
 		bio_endio(bio);
 		return DM_MAPIO_SUBMITTED;
@@ -2520,7 +2520,7 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 		}
 
 		bip = bio_integrity_alloc(outgoing_bio, GFP_NOIO, 1);
-		if (unlikely(IS_ERR(bip))) {
+		if (IS_ERR(bip)) {
 			bio_put(outgoing_bio);
 			bio->bi_status = errno_to_blk_status(PTR_ERR(bip));
 			bio_endio(bio);
-- 
2.41.0


