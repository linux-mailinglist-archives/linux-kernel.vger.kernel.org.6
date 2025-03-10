Return-Path: <linux-kernel+bounces-554947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D35A5A3B5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C049C7A7A00
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7BB230BD4;
	Mon, 10 Mar 2025 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V5K6HG65"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A791CCEF0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634498; cv=none; b=umBknWooejRSKb8WWxJt7v3AELrdMJm0X1A2V9ystky2BUNE+UIDBHmUSnbLCciu7HIYM1K0imOS/D7w5HdOY+PwUVwDamny8z2MZjTQ7w1ijWbbvNbdiTfzHqO60If49aks/5NgW0NwbIgGS3MVfLFM0eSbtlJfPpx0/UsmGd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634498; c=relaxed/simple;
	bh=wmtgrd4Yyflou9lds3N1NlcgvGq23JCJo0t84LhDX4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZDZej5RxAEV8fhvo7kq5Pbedi1XqIN2Kj3//6n54RVGeerUjf4htzHYbPGvEXEl7e1MzsVHDxF44GZjbCb8iGf/tHGgCF/FVFaN6/65EQc+vjexyjgq2lBJWUo63PMOrJk3I+lLZF3JwlzWuzvqtuy0y+zyTu2xLGttCSou07ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V5K6HG65; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741634483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vf/jHlASJNsHG4o/m4N2LSWfzEAnf5BZcxzVvU1NXkw=;
	b=V5K6HG65H6R6mA6/HyHIToH2HYS3tzhdGkvMkVSwVhMEwB68c0h5I1JvXZZw3bbORvWanK
	Gg2KBIGRWnaX1IfPES+OI9mJBiAZjwDMo7XNvTHF0DioyJFrqZ2GG3eoH6mud8gUguq2Kg
	EWqOztmS+J/3KFRhIgXQ5qdjw3gAFA4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bcachefs: Fix error type in bch2_alloc_v3_validate()
Date: Mon, 10 Mar 2025 20:20:29 +0100
Message-ID: <20250310192028.442751-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use error type alloc_v3_unpack_error in bch2_alloc_v3_validate().

Fixes: b65db750e2bb ("bcachefs: Enumerate fsck errors")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/bcachefs/alloc_background.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/alloc_background.c b/fs/bcachefs/alloc_background.c
index ecad4a78c3f7..4dfcf3e6fffd 100644
--- a/fs/bcachefs/alloc_background.c
+++ b/fs/bcachefs/alloc_background.c
@@ -232,7 +232,7 @@ int bch2_alloc_v3_validate(struct bch_fs *c, struct bkey_s_c k,
 	int ret = 0;
 
 	bkey_fsck_err_on(bch2_alloc_unpack_v3(&u, k),
-			 c, alloc_v2_unpack_error,
+			 c, alloc_v3_unpack_error,
 			 "unpack error");
 fsck_err:
 	return ret;
-- 
2.48.1


