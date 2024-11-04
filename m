Return-Path: <linux-kernel+bounces-395672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2380E9BC178
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C3DDB21909
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856881F5855;
	Mon,  4 Nov 2024 23:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sjXOMbjP"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874B11FE100
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730763172; cv=none; b=iIjTy5w616wfLel+xh70cltR2FKW1rNW3vWF4zK60DlTJJ1I/+sJ9Kb+0Cdsc0krIwp4SW79RN8+dnvUzfoDlESLnBiLenlrFJuFqBKcdF4ydzuTuu+FoIhA83hWg6BUVHysEeTamBAfxVsP8cJOzvvrFeEyevdGQces92MehFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730763172; c=relaxed/simple;
	bh=9463fSkV7FqBg+ae6ErrihpOEctWELQJ3N8F+ouU/p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H36DGtpfE8b2htlBYv56huTdbOE+Rr0I9IbcMdC/T7GsCRV8fV3VCCb10SjtM4OIdOkh12p79L09emjKCXAmyPL7IS5NTWSDFya02p8ToqmieIwHfliMS2GPDQ1mnVyy5QVyvJtIl/keF0tv1UgyLff6+NI1mjn7oJniwBOlBUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sjXOMbjP; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730763165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a/kh6MtV+hVG1cOKRS4IyBRlKmLHbveTOAvSOev07Ow=;
	b=sjXOMbjPXgACjwacXYWPccp9XqS4qKDNg2s5+VxgmC98Y+SvY/6dYlbTPqsEW0VaPRk9Sr
	rK1acSrMWjDWNTqRE1x+kyZ81q0fLfmk+MSuOVZDeeR9L7pBHMvUmp0/qeukRpKo1RNolp
	ZdNo2bXGygicj80U0mqezJAx3Vf+SS0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] ext4: Use str_yes_no() helper function
Date: Tue,  5 Nov 2024 00:32:05 +0100
Message-ID: <20241104233204.7771-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/ext4/mballoc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d73e38323879..4d8e82cb90fd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5711,7 +5711,7 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
 			(unsigned long)ac->ac_b_ex.fe_logical,
 			(int)ac->ac_criteria);
 	mb_debug(sb, "%u found", ac->ac_found);
-	mb_debug(sb, "used pa: %s, ", ac->ac_pa ? "yes" : "no");
+	mb_debug(sb, "used pa: %s, ", str_yes_no(ac->ac_pa));
 	if (ac->ac_pa)
 		mb_debug(sb, "pa_type %s\n", ac->ac_pa->pa_type == MB_GROUP_PA ?
 			 "group pa" : "inode pa");
@@ -6056,7 +6056,7 @@ static bool ext4_mb_discard_preallocations_should_retry(struct super_block *sb,
 	}
 
 out_dbg:
-	mb_debug(sb, "freed %d, retry ? %s\n", freed, ret ? "yes" : "no");
+	mb_debug(sb, "freed %d, retry ? %s\n", freed, str_yes_no(ret));
 	return ret;
 }
 
-- 
2.47.0


