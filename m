Return-Path: <linux-kernel+bounces-536971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 984E5A48687
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C8E16CD05
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D9A1DDA2F;
	Thu, 27 Feb 2025 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hH5GT0bU"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE661D934D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676971; cv=none; b=V/vEg5P35jYvpFhjfzNf09+5Wsh1TL8v/7crdccLI4U+9uJR6F9yLEjmeJL01empWBeFM36lvkgPZsVcBpz++vCGoRgzQaBMk/OvDK5l52HMBzy5xEHKrGakTEtikLD1nimLYgVwmGpeCIaxBwccmVkmarkiOPcMECNp5htGRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676971; c=relaxed/simple;
	bh=eErh/pyXl+8fq+iSD8/YfcDSs8fSgQFFow7b5b199hE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r6WoKFBrPtnAU4nKC69LJ5TPkk9aQwZ6zOXnBpoJAQT/dFcKKAaWi6Rou+TWgwOvDyFJv09j2G5Rl0O5CVVGEqG+tu/tw59mnNrnmqOtze46OXfG0/9QfJ2p9iymTU9qB/Xz6APOzu7sPCxn3ixe4Q9nr4HcnhGuFbhB696oQyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hH5GT0bU; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740676957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kfcjng9ue/GFFUTz6SkApgIWXnYnxsO5SWJB9+YG+is=;
	b=hH5GT0bU8q1SUKh1CHIVq7AO0U5yazpDEixxp8YOjO8H3XNyfgWEKMbz+/QtXpK4WiW+l9
	ncf238qh0YSAB1ey8/AUxPhQcLJsk1mmY4QNpXWy5/HhioqreIxVtGj23JrCMJVd8Jj4E6
	ItaY62C1opm+Y+rvWdFnmQ4/ba30niY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bcachefs: Remove unnecessary byte allocation
Date: Thu, 27 Feb 2025 18:21:57 +0100
Message-ID: <20250227172155.4224-3-thorsten.blum@linux.dev>
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
index 15725b4ce393..4adeddebaae8 100644
--- a/fs/bcachefs/fs-ioctl.c
+++ b/fs/bcachefs/fs-ioctl.c
@@ -218,7 +218,7 @@ static int bch2_ioc_reinherit_attrs(struct bch_fs *c,
 	int ret = 0;
 	subvol_inum inum;
 
-	kname = kmalloc(BCH_NAME_MAX + 1, GFP_KERNEL);
+	kname = kmalloc(BCH_NAME_MAX, GFP_KERNEL);
 	if (!kname)
 		return -ENOMEM;
 
-- 
2.48.1


