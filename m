Return-Path: <linux-kernel+bounces-516058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B32CA36C80
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 08:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9F416FD25
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 07:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119FD198850;
	Sat, 15 Feb 2025 07:44:12 +0000 (UTC)
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0621D18CC1C
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739605451; cv=none; b=Tr8FIgcEULZ+AK29EMrDm8wXpWvQjuubA+2QdoqGM1VkOPIG3Xlfh1Rwgk807m+WqIBTo11QrbOnM5HZsd3ONuz6vVbjYBaidjEoSrqNOX8CdQCKsFK7tOz21D1U21xwGfaxrbSO+P0iuU2RoXRojP2DCM1vPEMGdjNt6vtIaTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739605451; c=relaxed/simple;
	bh=4saBPwJljDQK9KvJhPcSoma0myEcGD6fLosOYYm/uIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n24DwmqICLReIwLDrQMiuSQGqp/mUbl/1KcfORN+fmvqRjb7OCGvJ+74lZp90ah1A35VzOpeF9Ye23cL3c6xZYH0SbOSB03wXJAOaNQIadgDM2uC2gEd2jPk+No1gXvRs9shMgtbVuFLaS59uvzDLzG0u4fqdD9APGYqXjTRXT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.83])
	by sina.com (10.185.250.23) with ESMTP
	id 67B045B90000574E; Sat, 15 Feb 2025 15:43:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6717758913293
X-SMAIL-UIID: 41D33E8F6A0449A79604AE222C01A054-20250215-154356-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Write in io_submit_one
Date: Sat, 15 Feb 2025 15:43:39 +0800
Message-ID: <20250215074343.2302-1-hdanton@sina.com>
In-Reply-To: <67aedac7.050a0220.21dd3.002d.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 13 Feb 2025 21:55:19 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    69b54314c975 Merge tag 'kbuild-fixes-v6.14' of git://git.k..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fcbb18580000

#syz test upstream   master

--- x/fs/netfs/read_collect.c
+++ y/fs/netfs/read_collect.c
@@ -289,6 +289,10 @@ reassess:
 		/* Remove if completely consumed. */
 		stream->source = front->source;
 		spin_lock(&rreq->lock);
+		if (front != stream->front) {
+			spin_unlock(&rreq->lock);
+			goto reassess;
+		}
 
 		remove = front;
 		trace_netfs_sreq(front, netfs_sreq_trace_discard);
@@ -345,6 +349,7 @@ static void netfs_rreq_assess_dio(struct
 	struct netfs_io_subrequest *subreq;
 	struct netfs_io_stream *stream = &rreq->io_streams[0];
 	unsigned int i;
+	struct kiocb *iocb = NULL;
 
 	/* Collect unbuffered reads and direct reads, adding up the transfer
 	 * sizes until we find the first short or failed subrequest.
@@ -369,12 +374,16 @@ static void netfs_rreq_assess_dio(struct
 		}
 	}
 
+	spin_lock(&rreq->lock);
 	if (rreq->iocb) {
 		rreq->iocb->ki_pos += rreq->transferred;
 		if (rreq->iocb->ki_complete)
-			rreq->iocb->ki_complete(
-				rreq->iocb, rreq->error ? rreq->error : rreq->transferred);
+			iocb = rreq->iocb;
+		rreq->iocb = NULL;
 	}
+	spin_unlock(&rreq->lock);
+	if (iocb)
+		iocb->ki_complete(iocb, rreq->error ? rreq->error : rreq->transferred);
 	if (rreq->netfs_ops->done)
 		rreq->netfs_ops->done(rreq);
 	if (rreq->origin == NETFS_DIO_READ)
--

