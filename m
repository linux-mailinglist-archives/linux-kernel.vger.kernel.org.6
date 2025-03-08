Return-Path: <linux-kernel+bounces-552767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87451A57DE0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7739B3B15AE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 19:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBC91EA7F3;
	Sat,  8 Mar 2025 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DVNHGFPO"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC481392
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741463661; cv=none; b=Btk0hyuYPH9IbhDz0PSdd0vEsk5iahKe8ao62jenuQkh7hYu7dF/b27WfP1D152mCSS6z+oF1zBglHKoqJuoGagger9AFTzPINllNvq4Ku5stYsejwEUERkEetezNfyyLdz4PEAcq1KOVnDNgCoEkXFAoC8mr/Ph3XY3RcWR4ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741463661; c=relaxed/simple;
	bh=t6WB5fx0rHjhMtjcjQnz0mPgR8QLo8e815vrOJrpZ1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWXGMBmIesWsEgsndDXZ+xVaw/aV4uUobFJBzJopcxn1cW17DurI2DG+KnhqNVnRILzJTfmidHF5jMDUIjSub2sssAipW0nuTAGRy46YLJ8NBmrE1Ce1fEz77zj8SltZ6d79WsAgWEKumyVHskQ+Ga55ZPBgjID59u0loKTHOB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DVNHGFPO; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741463655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dUcqRxrAumHIfnW9n8O0WkK51jybPI0vkc2ANXUC6po=;
	b=DVNHGFPOYZVQBv1pvU1Il14JWY8EF6ju0bto+EpetrP7VY6TwburmWDWIHlSAdS4I4BZiF
	wHOrQqzaxR9DwSsmwa/NYQnI5aqofP9AsR/+snCi64k3ojXDaKq2aaSoEoVh5VGDy4/W+J
	CSHszUr70vcLnXPo8HlD8kqaVlIFQy0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] bcachefs: Remove unnecessary byte allocation
Date: Sat,  8 Mar 2025 20:53:53 +0100
Message-ID: <20250308195353.194683-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The extra byte is not used - remove it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/bcachefs/fs-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
index d9f1a7c09e85..9761a365552a 100644
--- a/fs/bcachefs/fs-ioctl.c
+++ b/fs/bcachefs/fs-ioctl.c
@@ -244,7 +244,7 @@ static int bch2_ioc_reinherit_attrs(struct bch_fs *c,
 	int ret = 0;
 	subvol_inum inum;
 
-	kname = kmalloc(BCH_NAME_MAX + 1, GFP_KERNEL);
+	kname = kmalloc(BCH_NAME_MAX, GFP_KERNEL);
 	if (!kname)
 		return -ENOMEM;
 
-- 
2.48.1


