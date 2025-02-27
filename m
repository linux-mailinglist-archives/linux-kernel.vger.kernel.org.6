Return-Path: <linux-kernel+bounces-537007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A3BA486FD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4041884453
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5C01E51EC;
	Thu, 27 Feb 2025 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ooIuQeV/"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE511D5CD3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678590; cv=none; b=iO0fhoAv3qZHF2MbDSr4FDQ1jxG1xbd2RKQvfYQuJqWRHt+CMJQNS9/du+Xr2AeJyZyvEoL+BNCsJQqwB5RFLAMibt59HNgRFQPKCN6RBmu3JmJFC1KTcmEZSDQIXAzvxOR2+Vm4gRnsIKBaFnLLuGtAeSE7cbKDo/aSmFtbwLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678590; c=relaxed/simple;
	bh=Krp0hRcnkmO9FVzzmnUG7JaNepHi3MNQIk7r1KS5hT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jcivgVRSSmPRwBd3vNrfqQocX90ZswmuiD/Ce73XAvoAXX00X2E6TOOIS9lnnwf7ffjBYu6omwnKp9c2bmGA93PetvHcXILAk0v/NqlmK+WruSjInpHw95CWLEuN56cP0i7EfeEEAypmZVyB00g3YSNPWOG1W2cGLSTRYqwBDJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ooIuQeV/; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740678585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hwQtXwdz+nRfwMkoG537Y+tMlAkJ6gBqNuVsZ/4bXk8=;
	b=ooIuQeV/o8Waang5wjBnKHn8WmD5JPDz3r+XUOH6i4zQHuNiY0rFLq4oMlq3+atWxf18/C
	YY+wdUcojtHWPY2Z5vgjkUctvSNpP0yO9c11ExMLIV+7RrIIOhkhBNUbn4rX0+mKZlDQtY
	fUDRQ/lnDTQLkJaBhvf4pBUvQ/zBL1M=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] ovl: Use str_on_off() helper in ovl_show_options()
Date: Thu, 27 Feb 2025 18:49:30 +0100
Message-ID: <20250227174929.8262-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_on_off() helper function.

Acked-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/overlayfs/params.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 1115c22deca0..8a8bb336b40f 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -1053,17 +1053,16 @@ int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 		seq_printf(m, ",redirect_dir=%s",
 			   ovl_redirect_mode(&ofs->config));
 	if (ofs->config.index != ovl_index_def)
-		seq_printf(m, ",index=%s", ofs->config.index ? "on" : "off");
+		seq_printf(m, ",index=%s", str_on_off(ofs->config.index));
 	if (ofs->config.uuid != ovl_uuid_def())
 		seq_printf(m, ",uuid=%s", ovl_uuid_mode(&ofs->config));
 	if (ofs->config.nfs_export != ovl_nfs_export_def)
-		seq_printf(m, ",nfs_export=%s", ofs->config.nfs_export ?
-						"on" : "off");
+		seq_printf(m, ",nfs_export=%s",
+			   str_on_off(ofs->config.nfs_export));
 	if (ofs->config.xino != ovl_xino_def() && !ovl_same_fs(ofs))
 		seq_printf(m, ",xino=%s", ovl_xino_mode(&ofs->config));
 	if (ofs->config.metacopy != ovl_metacopy_def)
-		seq_printf(m, ",metacopy=%s",
-			   ofs->config.metacopy ? "on" : "off");
+		seq_printf(m, ",metacopy=%s", str_on_off(ofs->config.metacopy));
 	if (ofs->config.ovl_volatile)
 		seq_puts(m, ",volatile");
 	if (ofs->config.userxattr)
-- 
2.48.1


