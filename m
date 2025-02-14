Return-Path: <linux-kernel+bounces-515779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B21A368F0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4F81896411
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72A41FCFCA;
	Fri, 14 Feb 2025 23:15:02 +0000 (UTC)
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4FC1FC7C1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 23:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739574902; cv=none; b=ljI2R4H/DIgX9+GGEF49p3ju/QYv9OxJxEQZwCn5fMVWn3szV1oD4M+buHTFSnPA/wNFFyivg1x0g/Qu9n1pxhNJYUOkcUDsDqHMo3VSgdd5KAONxcO3xotJmMKd26vf1UbsD3SAsG7cV1aDB+pT70evLTa2SL+Q9/PFi7jIfE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739574902; c=relaxed/simple;
	bh=4X471InxMmtfF4A7bgweUnPLjIAku6Oe2oJBgud8gCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0P+3IEk7TW4dC93h9Q04Nv4elCFhmNYaNC9bDO/45LcHUe5LP7RPkK/+4Qj/pB/nXNbm/gzpFXmhS1XOXK4aCAwYputPX2IUp8c6UI/oCAMev2pJnrm+aziY5HhE5PguDcks4cMMKUtMkc/bmPK5XMPoM/I3ieDW02X59qqEYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.83])
	by sina.com (10.185.250.21) with ESMTP
	id 67AFCE3E00003E80; Fri, 15 Feb 2025 07:14:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 335883408230
X-SMAIL-UIID: D2D8C46820C44DE5B594D046E3844EE2-20250215-071409-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d9890527385ab9767e03@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] WARNING: refcount bug in netfs_put_subrequest
Date: Sat, 15 Feb 2025 07:13:53 +0800
Message-ID: <20250214231356.2285-1-hdanton@sina.com>
In-Reply-To: <67aee51d.050a0220.21dd3.002f.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 13 Feb 2025 22:39:25 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    69b54314c975 Merge tag 'kbuild-fixes-v6.14' of git://git.k..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13aafdf8580000

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

