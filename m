Return-Path: <linux-kernel+bounces-515964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F068A36B47
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 03:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489551894631
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16427154C0B;
	Sat, 15 Feb 2025 02:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hjLcEcvs"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCC1DDA8
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 02:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739585209; cv=none; b=twEIbMrWI2759RgRux8swqwUTRgq6DIJKUaWUYSZ6xEswpL5qOUJsx1HkKGQu5t2bfs4EtgReLZekTv7uXC3yrvY72bRtu9L0AD+iRkLC5pfm16KVqPHzRCZ6uUEdMa/YTdyr6qedQtKMMlN9zEcVM1bYv5daGkhB6wOZ7pRv8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739585209; c=relaxed/simple;
	bh=MzthKMpX9KqIlm+3tgNfBQvwf9/vPDjpd5I3Y/62o5U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=EPSIctgOqSndGb/Dkkw2UKX4pMwK0rpo9HnyEERDA/iIKX7hEROpGezp1MHEdVfcuT5W3BRHH/F/z0vC3K7VpkfXQWd7VPaWWoEyxMRTIItiXhUaGUBSt3t0PcNwbI4l3QYnvVQnmQW9qaVM8dy+tGFKVlzAzH0ctUd29sQ7Rlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hjLcEcvs; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739585200; bh=kLWbNa7rHBqbc8lkjhhNsnqxVEvCI0tfPtnxNaOJp9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hjLcEcvsWQOxstzgqmMdKA6M6ruAST6/d5Ovhxjb8b911sStdHuOXly9kuX4d0Slz
	 d8nYmVhwL6I11iQn2FNeqCwowePZXqjD2Gwwmlu/wahB7pO4268eWmoWHLKMb1fOeo
	 W2MTRcYifXdmzsqHj+g6tgJyIwCeANfs+veyuKow=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 238400E; Sat, 15 Feb 2025 10:00:35 +0800
X-QQ-mid: xmsmtpt1739584835tm8u2aki3
Message-ID: <tencent_531E37224ACA755D7751666E3C2736789709@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLcW5XKGOg3GwknI6eo2Q77+MNgCTkhmEKBbofyLK2yS9ZO5JSxR
	 CohTFvykLF5tUprDksnSkC9nBa/KXl222QR3bmEnNWezZ3/gmvJHd3XCrM1W0FOFi+dGwFQXAHoW
	 KFCzlsg18J4SMFSD/IufNglgwB5qrAHifSVspRu1yxrrs18KLaeczLJMYjY1gCO2ljSCxIqrH1YO
	 fGsb1Cg7uTNkRCDWnpPRsODszSjgUyGD1HL0LL52xa/4GUp1cs3G/EaC+RNoSGBUl+EnsseKrKpD
	 z440I+AK+o+zTB2J2zWzjJVH1awW1pV+FC66Z/GBx51wKwKhQ/M0psuyRjy4hdG128rzBZ6vbGID
	 tjXIRHvdpfYWDeaHahrfl7B2GVlkPK51xY2Ktg4MDO9fYqb5JZgXn7BHQzTsKrt6bLNtL3G5Eryq
	 CWQt9y0JVMQ65KIuApLwgnQDEJ4j5gK3WJNNukDN4h/8q9SG5OUMOgn24PaPmz/1isVSfQwDUctj
	 q5zcgFfIA5jNove9mTjWj6QG3oY78Arzg6VknCDEy6HWufvmV2SvtkOq+m2S+HaUJJS1Or+/Znzv
	 czOFcO8Q3SLxHKFjGBwJioonLj/VGLL6Bv4tOUPCllWmPAoOikelCParEoc1kA3qDDsLVAYRLwHt
	 y4eGtSFojOLx5kShCjJPvXQBnEHD+zzWIcw8QuB25cJ7AeJDIdtLdvUr8qBqwt9qnJ4ja6ktiYhn
	 uOf3h+orNebuo8rJvyXofjwVKyZumha0fVipbNm8PrsbcoDTLzjENMdEETQ4whcOAU5RdV34bBzO
	 UyjGhiWQwufuycQ5+60rIfzksESToRicHx/a35OCqjx1lSesmjaztdlGTgB8SuX9KuDNZ4MJyYhv
	 NH9EYOi8qkL23AVaI9lVvDaQFmB52F3dyuQcLNuqTly9yjKWLdb+Uq68MJQWjMh3JOZ8EEiLeh8E
	 WR6gutkvRKKNPkr+WSNY8m6Exu0xk1
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [netfs?] KASAN: slab-use-after-free Write in io_submit_one
Date: Sat, 15 Feb 2025 10:00:36 +0800
X-OQ-MSGID: <20250215020035.1076254-2-eadavis@qq.com>
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
index f65affa5a9e4..93eb315fffea 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -371,9 +371,11 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 
 	if (rreq->iocb) {
 		rreq->iocb->ki_pos += rreq->transferred;
-		if (rreq->iocb->ki_complete)
+		if (rreq->iocb->ki_complete) {
 			rreq->iocb->ki_complete(
 				rreq->iocb, rreq->error ? rreq->error : rreq->transferred);
+			rreq->iocb = NULL;
+		}
 	}
 	if (rreq->netfs_ops->done)
 		rreq->netfs_ops->done(rreq);


