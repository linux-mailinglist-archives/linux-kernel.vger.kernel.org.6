Return-Path: <linux-kernel+bounces-393801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDC19BA567
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 13:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F2B1F217D6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 12:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8951A1632DB;
	Sun,  3 Nov 2024 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PSlF0CDo"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73BA23B0
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730636324; cv=none; b=lTNx+KGuvZu6WDyoWDm+GpBFXQioJzP6ikNuNmR2Dqgnwv9vRP98YFU2bhuRRS7UbB6+RmNye5+YD2UEKpNMJM8pDG1jgVsrUU7llH96MLrPfzqTQGsjQzTjHDgCPpwJAUBKujchEBBh/FEyH6oWCwBenPxIZAaflJ8n90BUuEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730636324; c=relaxed/simple;
	bh=JBR5OYH6HGg/nV5dE4xfZ8tnOwX8Q8ZrEz65y0CMjeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eo9llP335D0nQYDHYhPjRurwQelyZkqS/wCYfwSXhMtsX2EGVLxJIVpckTBDKF9caVmrIsgMuFRYCSmaQEf9bcmifEKlBFFqW1Qc+72HA4fRQCkstxAYpd+tNkGSpVI17knPgQEaDn1k8KA8ueHEIZBBnv6COaMHNdPbMtyGD54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PSlF0CDo; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730636318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NyBn8heEe2xkvBGW5DCMbPyQa9qZDQbub0DgJexbKCs=;
	b=PSlF0CDofKfBxlvP+aoNL49ohrb6cDn6esGcuRPUqBJ4bwIpp+2ij0OUGAB3ZHIxv7L8u6
	rsl28sasHfc4m9jt+AAAFxrlg9OtT5g4h2hwWbryuyzGTd4CIRMVGCLnQuHvli+H6/8aO3
	J3zBX42O94CAiEZrSWf/+JSU6A7U2LM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] freevxfs: Replace one-element array with flexible array member
Date: Sun,  3 Nov 2024 13:17:09 +0100
Message-ID: <20241103121707.102838-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the deprecated one-element array with a modern flexible array
member in the struct vxfs_dirblk.

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/freevxfs/vxfs_dir.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/freevxfs/vxfs_dir.h b/fs/freevxfs/vxfs_dir.h
index fbcd603365ad..8c67627f2a3d 100644
--- a/fs/freevxfs/vxfs_dir.h
+++ b/fs/freevxfs/vxfs_dir.h
@@ -25,7 +25,7 @@
 struct vxfs_dirblk {
 	__fs16		d_free;		/* free space in dirblock */
 	__fs16		d_nhash;	/* no of hash chains */
-	__fs16		d_hash[1];	/* hash chain */
+	__fs16		d_hash[];	/* hash chain */
 };
 
 /*
-- 
2.47.0


