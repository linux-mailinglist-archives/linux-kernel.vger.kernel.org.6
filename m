Return-Path: <linux-kernel+bounces-514950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A392A35DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9523ACECB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8040A22D793;
	Fri, 14 Feb 2025 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zjVzz1tg"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9172D2753E0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537569; cv=none; b=S/nUMML17b5rbxkjl2RfpmjKrj0JqRnF57aGADkUIkuYr0nje05oY583s8jFGN+wSab8sn7IELByQ5cP2/eS3Oi6rnIPOIWn6kK85LhhX4L1lIvTTaA5C5jMfGnmYlyLJTgyC9cjVhPTotqHd6oz1E1bNBmjJWzuI9EoVZwjOT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537569; c=relaxed/simple;
	bh=G9RP4HAdNG5lnGWFyEKBYzLe5LWlSSHiW8Y9+2BxC0M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=M39M/MsDyA2wkuXNeGR0zUEqBh516MbsXmKSktBSRnTuiAarDosPUsHiWLUBbXHvP1MKa7X6+gFZwTMblM/sYCehYW4QxdWG2wQbZZnSk+RegSjNmrbR8fK8M4k+SwQWpBjXJiMMgZD9HbFAaIOJxyqwT1urK9SmB8cx4wLTIsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zjVzz1tg; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739537553; bh=8D6bFUm8Xr4oGQYiTiQbQ47HC4u4PdN6xq2N/Cs+KR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zjVzz1tgh3OEj3a6CWAEvdWc9iNRLvHz/pMP0I6G1pzx0lj8v18RtUBa4oaB1uNN0
	 ug+nC4FCvvYL56zp1p56FeZ1/U5rtEz1ZYMvR3m0MOLRmAa0qHhcoCla314UJH4uSS
	 9EOa7vNnlrNp0+Qez+s4hkWG0pqSVFmNkxyKjeO0=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc11-0.qq.com (NewEsmtp) with SMTP
	id B8D11E77; Fri, 14 Feb 2025 20:46:13 +0800
X-QQ-mid: xmsmtpt1739537173t4mur07qy
Message-ID: <tencent_C7123BDDD75DA11956CFE20D8225938DEB07@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1j68GC9Fp5X6/XAo65JFxnfeG6UJMKkQF0hQcHYpSz+nqPTQqPj0
	 eENzJpa4Q/eJUOqOGKQVH36RyzbQJH4eoN05ZzVBrYzdHSfjmZzfIauuuufOXkokjcD+lRdC4fVi
	 FHpQwwy8PdZaCUPeHPLoFRhWLtPp+8rCLElGXps3ibjrC2SsxkpZQM3regN1JR43j92o+O8VzXjX
	 wQFi3SZwu9Tng8zsvXPbFElmZ25ceOFOqWpfF2KJE4AxFsJaBHibOt9hpVZULPYtX//hlksLh3zx
	 Aaeb372eJdB+ElCkxbUDw5VmSU+pDKJfXQHDLyStvq/e+jPei0dr6O48fqP3zXNsqnpdxRBwgJD0
	 6pxedxCFjtPgBlMREcVA0p6GTrtrs1wmB4glBq1xyju5IqTxXg6ciCbYQ1XoGb5PMTprkxDP2mc8
	 94+Y3glKvX3b9/LTGxjpwv0jau+LqDSGr+x854EvbsjqFsvEiEI15AGG5sC4MYENd1EcJfHP7j33
	 1NzOcckyP54KroxGdfbg8yfPdR+v0vM+OXCbj4dxLiMgtymaB2g/A483XcZ4Xm7c4nXPZDiXhsc3
	 D/Chde1eRrZEOz9bhT5WaS7iDMifukbv7pytvsMo01Cy08TOkEvKQ1e2We++2s9lC23shXaEfW5z
	 Jhlu++/2neClJdpQJ5AGaNsvUC4A4Li3U35U2vWSCadyU3N7F9w4Q5Ryh6w/9rA1mhYoyvnFwICd
	 ALYuUSa/7xKtcb+iuPaZdR7k4ePTPP6VFdtvxeqm5+Pl6YzAmfNKEpLeM0098jVbNajKqtLGQq1m
	 fOIhxNR9be/wKLeD97B3N+8QM1Jd+tpW4C1rYmjMvlvt7G2a6gkuGArMSN8zJnNHmTpGvrg5i2cy
	 XYot3Sm++R2csrBZgV48HQzF3A6KIVF/s+0tVjj6gW
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [netfs?] KASAN: slab-use-after-free Write in io_submit_one
Date: Fri, 14 Feb 2025 20:46:13 +0800
X-OQ-MSGID: <20250214124612.826903-2-eadavis@qq.com>
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
index f65affa5a9e4..40c408705f1a 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -371,9 +371,13 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 
 	if (rreq->iocb) {
 		rreq->iocb->ki_pos += rreq->transferred;
-		if (rreq->iocb->ki_complete)
+		if (rreq->iocb->ki_complete) {
+			if (rreq->transferred < rreq->len)
+				refcount_add_not_zero(&rreq->iocb->ki_refcnt);
+
 			rreq->iocb->ki_complete(
 				rreq->iocb, rreq->error ? rreq->error : rreq->transferred);
+		}
 	}
 	if (rreq->netfs_ops->done)
 		rreq->netfs_ops->done(rreq);


