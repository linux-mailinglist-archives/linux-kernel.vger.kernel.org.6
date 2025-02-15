Return-Path: <linux-kernel+bounces-516022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0DBA36C1E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 06:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81641888182
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 05:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF171624FE;
	Sat, 15 Feb 2025 05:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fQk/KTor"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8162F4A
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 05:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739596560; cv=none; b=eGQPvj8MgLN+uM7N+6GSUoYnKUi44YBHOEZS7J29DSGa32OpmfqF/XhR6VW45c0GVguuxIenAQYAWeZSRhWBOVyWaBjLj6w4od3UwUKHU3CKyPsI0mhBDl1qpH85YWnGMJysOHTGD4oUMrSjWiOQcPCuxqtOkiXajpgcuGrTxhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739596560; c=relaxed/simple;
	bh=1KfR0ReSOrDksD7Gqg4LeN9SGYnXYWhyRwfFTIQlHGI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=FLqQjzIIg/lmwj8Vk6bv3USXwpYvv/2lH3SPexwm2vM1Eid86fnIjPBx/zgZofcbtM6OFTkvCngDyxwtrgExWcipa5q/FzIM6KKbr7Q2UWPgA+J0ctm4leEbiy9MDQ2V5Did/xFMWN3DsZPXeOspZuWnEMqYH0u8qORu8CIHIAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fQk/KTor; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739596547; bh=74rJBhX2Y1r/7c7UIdfhVaNUGgmB6X6oiBsVf04pKTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fQk/KToru1684BjEvKjpEMFZfUg0Kf5bSS/j+eLWXPXpDLs601d6D2Th3D1L+NK5j
	 gMacQbEUg/KPzdzVrIYdzYVOfJXXRRXDZ2neE8ZYbY+CNFujm754INLYy+YCViPk6N
	 iSYGMEFnSFCGKxIUbcgrfjiPEmJMnqgweH2e3OsY=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc11-0.qq.com (NewEsmtp) with SMTP
	id 3EDA1E41; Sat, 15 Feb 2025 13:15:45 +0800
X-QQ-mid: xmsmtpt1739596545th4p146ak
Message-ID: <tencent_08922ECA6EE0CCB467D606C852E9464B0906@qq.com>
X-QQ-XMAILINFO: OYTBn1rNHH7tIoEqC4D8P+gx774JPNtVozebF1jSxS6DpHKzKWjBJrXWiIFftj
	 EJ4TTOVHyMH5YxfoQ1KwbldlifLBaWHcUu9R0hLkq3Jl0T0L+1M3+hRzT8iXqOE0A9LujEQ4IyO+
	 3F5C7La8DOIKJLNmmqdlHRfzfuq0G/5ACdILEwIps+eZboNJZagO9uOTvbtMVh+KxuRGMcxD2SRd
	 DJoQ2UHC/kNgJl1Mjktvb+T/9g0hyPghGvHLjALtfS0CkZaLkbRqu117erDhzsI78O3pNfTPQrBP
	 D7cPAnoAwuoGUXLVzG6O9CC8o3tyE/IQtRrATBF+JrbNTiAR3I0wC/Ds5IuFzeX/bFOW59u0UumM
	 b6FS7XGmXh48BMwa4PB0uSyd7Dcp12k58fMLZDt/pn9wI8R0i6ySnYo6cu3QU4cbiYkHQ75DWBvT
	 s2O7RUD6oVGn25hizI0vv8AWpLjZSIkavQlwrtrOa1uVz/AdoxIIkcvUeb/gVzz1JuM88FcS99Ov
	 f/P3taevgrB0zQU5Iqqus6PNp0kX6HSouw4MXdf2hOq2oa7zacFi7pub1mx80mSlXttGshXFj9Ds
	 ytiPNrT0Q1KfajGzHX1j5wzzl5Y5opm8OKZHyLhPERT2Ddm0sO2OoQ5WSD5tBSzYusRsERbUP1rB
	 z1rG/pHi57hFJvYRNTxB0dp2L29nDI8Y8Eh2C5uBUWvQLBbazHePVZxg6XMQGrnhSRHRWOvK5Elp
	 HWUSK8Onbqa+t2upAtoZJODlcXbERKqH86+RE1zT2SUXq82Nls0xwgK/bOx98hXB+6NawoPj/BIK
	 B/ROdCQ8DJmPP5nAnPKcCpf3c5/HngRiJ1t/Pstm/Fd70C1JWxnuRGcJd8SHc62Ea4zzCAWzTcyt
	 KJUo0Q8vqnjpTHem+33knijsuSTRX6MGxZmyQCczOuWb11OOOk3gfzLG3iL8u0Sbda9ydnMUc4Bk
	 RbCCrzcMtWOZ/+Q/OhqVAC2zTnr3F5wyDjavJrIuPFRRZH3EDKCEB6SomABzGA
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [netfs?] KASAN: slab-use-after-free Write in io_submit_one
Date: Sat, 15 Feb 2025 13:15:46 +0800
X-OQ-MSGID: <20250215051545.1260392-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67aedac7.050a0220.21dd3.002d.GAE@google.com>
References: <67aedac7.050a0220.21dd3.002d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index f65affa5a9e4..6f3c0404f4b8 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -207,6 +207,7 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 	 * in progress.  The issuer thread may be adding stuff to the tail
 	 * whilst we're doing this.
 	 */
+	spin_lock(&rreq->lock);
 	front = READ_ONCE(stream->front);
 	while (front) {
 		size_t transferred;
@@ -288,7 +289,6 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 
 		/* Remove if completely consumed. */
 		stream->source = front->source;
-		spin_lock(&rreq->lock);
 
 		remove = front;
 		trace_netfs_sreq(front, netfs_sreq_trace_discard);
@@ -296,12 +296,12 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 		front = list_first_entry_or_null(&stream->subrequests,
 						 struct netfs_io_subrequest, rreq_link);
 		stream->front = front;
-		spin_unlock(&rreq->lock);
 		netfs_put_subrequest(remove, false,
 				     notes & ABANDON_SREQ ?
 				     netfs_sreq_trace_put_abandon :
 				     netfs_sreq_trace_put_done);
 	}
+	spin_unlock(&rreq->lock);
 
 	trace_netfs_collect_stream(rreq, stream);
 	trace_netfs_collect_state(rreq, rreq->collected_to, notes);
@@ -369,12 +369,17 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 		}
 	}
 
+	spin_lock(&rreq->lock);
 	if (rreq->iocb) {
 		rreq->iocb->ki_pos += rreq->transferred;
-		if (rreq->iocb->ki_complete)
+		if (rreq->iocb->ki_complete) {
 			rreq->iocb->ki_complete(
 				rreq->iocb, rreq->error ? rreq->error : rreq->transferred);
+			rreq->iocb = NULL;
+		}
 	}
+	spin_unlock(&rreq->lock);
+
 	if (rreq->netfs_ops->done)
 		rreq->netfs_ops->done(rreq);
 	if (rreq->origin == NETFS_DIO_READ)


