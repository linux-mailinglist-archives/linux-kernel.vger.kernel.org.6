Return-Path: <linux-kernel+bounces-437318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4919E91AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3EBA281D10
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B152421B8E4;
	Mon,  9 Dec 2024 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IVYqKEFg"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9721767D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742443; cv=none; b=YTpdDamVBenvzER61hDQYONT9Q+f/PWp8sXy0dh8bvve/kGihDQ2q+A94D8eP8m0xFaVTLze5pHyttsFpZBwIKQjMhk64jHa8G6LYey1A8krZj49AeWWpt38yqcCOXwMWAAuz+3HlwdK38ojim+8BLlzYYAAPVf0hTRkfBJsVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742443; c=relaxed/simple;
	bh=lROEBNsLHx6CvV4nVTBmAWKvm0kcFGCjtz+FSkuFsY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XfzNlidqdzVs1oNXC9zKQXMpGsvIL2jmGTOCX0yXbIxgZ1ZUDWHJcEnNEGS+nYL/velOHXzAVJjjhFmB/6eXPRmAY8L/TpZwxwAvHM8dmhhRMzD0C6CuCCBs3NxdxPvV9O9DMDaC1SDdjOotRA9IuoGhWZGL2sQ8IFzgSdE7YSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IVYqKEFg; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733742439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nPGSPQpFctHvf0+LoH0mY0kXUyMu8TlAiFauSH5Xvow=;
	b=IVYqKEFgsr+Zubh98hhyagrFFP91trz946HxrvfVJVQCnKU1ZwNsO1a5CO051DJ4fboPrZ
	teaXRp6Totj5VqYfeVZYxWTwquSi9101UNddHQKAvmKNjlcIVRhurn0q4WzRXfn5mS1kKN
	X8aZZ9Mnz4yhj0Y8fmDhWo7Ra0ZPs+A=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] cifs: Use str_yes_no() helper in cifs_ses_add_channel()
Date: Mon,  9 Dec 2024 12:07:09 +0100
Message-ID: <20241209110708.40045-2-thorsten.blum@linux.dev>
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
 fs/smb/client/sess.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 0bb77f9ec686..3306fb655136 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -488,11 +488,11 @@ cifs_ses_add_channel(struct cifs_ses *ses,
 
 	if (iface->sockaddr.ss_family == AF_INET)
 		cifs_dbg(FYI, "adding channel to ses %p (speed:%zu bps rdma:%s ip:%pI4)\n",
-			 ses, iface->speed, iface->rdma_capable ? "yes" : "no",
+			 ses, iface->speed, str_yes_no(iface->rdma_capable),
 			 &ipv4->sin_addr);
 	else
 		cifs_dbg(FYI, "adding channel to ses %p (speed:%zu bps rdma:%s ip:%pI6)\n",
-			 ses, iface->speed, iface->rdma_capable ? "yes" : "no",
+			 ses, iface->speed, str_yes_no(iface->rdma_capable),
 			 &ipv6->sin6_addr);
 
 	/*
-- 
2.47.1


