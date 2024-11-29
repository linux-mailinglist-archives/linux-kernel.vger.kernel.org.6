Return-Path: <linux-kernel+bounces-425997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 195E29DED99
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C659B21A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 23:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14861A3BD8;
	Fri, 29 Nov 2024 23:23:59 +0000 (UTC)
Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3791A38FAD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732922639; cv=none; b=a/t+p7oegSN1sBxGjFAIFRaLHVlKHIhmmUJ3mTP3zusOUMYVAx2qk8cJFurwhjlvMtPig+S8P8vrKuCJ+EXR3jVe5t6rp1hJQrfx/w1iBOah/2CsTrsdinGkc2iHPgA/j2uM6c5A4RaH2XZsRq1VuvQxBh+is+gBXUlzi3xyDTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732922639; c=relaxed/simple;
	bh=A4tIgoaMPG32VB8dlIc9Mb12Q5WZCs890AqVHcwM1jI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wgym1jKeZVLvvDfR2b+Bly1/QqBayDHsANYfuWVDn/leGBicVwn0MSyqE9M937dHZ1uIix1sY/XqN5zBvYqr/tW1nxomHrP6fd3e0NHMw1X3E2BaaPrFqFJuhFwyzuz5w1OHxnftv6cmrlas7vebY5w9t/S45+yFn9u9kLNpdfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.216])
	by sina.com (10.185.250.21) with ESMTP
	id 674A4CF500002396; Fri, 30 Nov 2024 07:23:38 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8175273408272
X-SMAIL-UIID: 417AC9DC2453461C8C857EAAC26143CC-20241130-072338-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+fe139f9822abd9855970@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] WARNING in netfs_retry_reads
Date: Sat, 30 Nov 2024 07:23:25 +0800
Message-Id: <20241129232325.2100-1-hdanton@sina.com>
In-Reply-To: <67496cdc.050a0220.253251.00a5.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Nov 28, 2024 at 11:27:24PM -0800, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    85a2dd7d7c81 Add linux-next specific files for 20241125
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e3a5c0580000

#syz test

--- x/fs/netfs/read_collect.c
+++ y/fs/netfs/read_collect.c
@@ -619,8 +619,7 @@ ssize_t netfs_wait_for_read(struct netfs
 
 	for (;;) {
 		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_queue);
-		prepare_to_wait(&rreq->waitq, &myself, TASK_UNINTERRUPTIBLE);
-
+		smp_mb();
 		subreq = list_first_entry_or_null(&stream->subrequests,
 						  struct netfs_io_subrequest, rreq_link);
 		if (subreq &&
@@ -628,6 +627,7 @@ ssize_t netfs_wait_for_read(struct netfs
 		     test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags)))
 			netfs_read_collection(rreq);
 
+		prepare_to_wait(&rreq->waitq, &myself, TASK_UNINTERRUPTIBLE);
 		if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
 			break;
 
--

