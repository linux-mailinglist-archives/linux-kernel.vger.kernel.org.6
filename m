Return-Path: <linux-kernel+bounces-396600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C199BCF46
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188D41C22C23
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDD61D9340;
	Tue,  5 Nov 2024 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lx62HE2m"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF051D0B82
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816972; cv=none; b=CZqg6m4dn9s25K0zaEgp1/7jCdRgcgWPpYQIHy+/pPKiqUd/0FGzRlbgjFmePvwzu5lzd1i+A7G6SozN1bpWNacUXNF6k+zi1hJYpM51igfb+zfgvatjSvcSXO114SO0frNe3hTnNM9zwsIaAPOurNYIx0BPJVNCoSsPZ+4xwKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816972; c=relaxed/simple;
	bh=6Q21XBG/rkegRl0phZ335sIvAzzjFtK5j2o7saAseuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdyD+SHUSXP9T7JqdaPycl+PnDBoGCTurmGe0bT4DS9FRd49+5TwtZMWltwYdU0LzdtU1y9fBRmqVuEy2JwOfRDnjKbgDcEyaqWQMV3Q1qQj16tSTa/Uqgzo5B81W10AdwsKnCgcZKTsd+0BmTEdLPZzodMOFbnr3UVbCe0euCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lx62HE2m; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730816966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fTHpML+cXhXVk5sDOgFNdpjjjYAsXUVhALDoRO9IXDc=;
	b=lx62HE2mIT5yV6IjaQigoSAjcRMR3L4gQMevde6wgRw+knv/1FwvnqZhSIfSKUMNAyIyod
	rwORfNrTNolw89HDLGERgV6XsG+LpIwPpzRhIfMIx6jtCGNfhECQgJL2VEuRHWfglYvaE9
	X/zpGXtHXyTnogVBO0TnZKLyHLRsyU8=
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
Date: Tue,  5 Nov 2024 15:29:09 +0100
Message-ID: <20241105142909.12604-1-thorsten.blum@linux.dev>
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
index c88e9657f47a..3cd157c2c0a5 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -491,11 +491,11 @@ cifs_ses_add_channel(struct cifs_ses *ses,
 
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
2.47.0


