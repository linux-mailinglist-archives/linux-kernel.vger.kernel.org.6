Return-Path: <linux-kernel+bounces-515931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F39AA36A8B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9BE3A9BAE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8871C8624B;
	Sat, 15 Feb 2025 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BpJZEjAd"
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2507213C80E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739581476; cv=none; b=FgZfuObr1uUiNBKRJz4VOoaKATu+/buQ23+r3efgy476EaqjUDWQLSzMUm32YFpfTzDKgCdRhJWQG90Cp6Q3EM5dmEXuo0eK2QpH4HejkqDkzrC59qOLchdbKFpCXJ21VoQLm13A5csJ01dhNzXRV/t/R6L0xbYnWb6KdE9v28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739581476; c=relaxed/simple;
	bh=W1PfXsK8Dj/IOV9U04Ew3tdiTcOqnHPCWj3pwXw3J4w=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=J9s+mZKM+xisRAEmMFlKTqg76qAqqLdrfv4mIYw1BFzslsbaeqIsDw8F8ORu4dLe63oJKe6kFL2d5vI3J8NMwtAa8AO8uzBpOlLnyx7cEAXq6LXbX84sSH+oM+BAolXQ4p8cK81Z0wp3qKgR2yhDV29KDoWsbGS/MMAb/OGhEXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BpJZEjAd; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739581161; bh=6/QcT1QkuuTKM24+t2ztN8oGZqIds9C+fSou5xFgRNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BpJZEjAdIv5b4EkMRdOwhbQH9wzondu3O7i1Xuupyl5dIrJXVT06TIW1NwlIDhwKd
	 zIyLZOstfGFMaUajcq6U8mmFV2A+BHPFTmNpmX81FkCPWyncPHflSDbB+dSBwuIyrO
	 TClccbGQISc9PpCmiRA2dxtoTrWzWMCtVab/fiv4=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id ED409AA0; Sat, 15 Feb 2025 08:59:20 +0800
X-QQ-mid: xmsmtpt1739581160ty8xvmc1e
Message-ID: <tencent_6EC0D361236A496543ABC44E176E577EA605@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujNMaS2jrERWzTKyQb2Ge+20+a1oCANOFq3Au3b9DLQm/ECPDv7D
	 g1mrSuUKZdCw9Fl4IOAnvBbD1KSSxBeyN9/D3WHtk6E7X2mROZ/aEt9uJHtxbsLEQlqu7/4ij+HV
	 1BwrQlk/361JJ/FPctXY+iU7EJDSM/gy25KybBboMT03HqBTQ5F+9t+de1zcdl+wSbf15pKpm8w1
	 SOc5mLzd8t6fyKFxfzib36wccgvSbYyjWinTG1PIHaikKVHkIeXMp/f9yeH2IhHxCDv7Ez9yjxRn
	 Xj53PVpt5zR56VdQtjr4awl8goNRoDQL9/yBDiW0EUTzmCvtCdy1o0/4xpW5ZujbcZJRiAdEFeSC
	 lBxMm/mQxlUA3aCRsUvunbqa+5AlQXZBFgjD+JQuVdlIIfxTpNtqe+el1eanivBZk73V1Ygxm7er
	 q6xmAv6A/UZPKtnOMCNGcsegTGan1EkisrCsfOfgvjtBdqresoJS34Grx2tfIINW+cA6DUYcDUmN
	 /35U/qgspL8nMESPcFYXwQzF3rVBGwXAGd/tY2hPastOHUHEKwQxZR9TnoHZ8X8lm0uPDdfGsr8R
	 l4P8bkh2UeaurJ3ZBLtCIOQAlcqqARYObBSjZ5umcWu+KRSdfXkFT/hiJcR82CKKBvDH1iRIJIi7
	 TP2NrU42owH0J89wx+AdE/tUfH9RzXhccm0cnLciQgR6ptzqJHTvam/DtCFyuHC5N8wxizu/NMjV
	 yY2hlWAI/qQhQptiCxVq5oQoK+BnQSmq2l9f7E8sfBYyVx3YIiM/5LtOnHHWEzypWFWDJVQG2H9w
	 TeYAiqOWIFwdIdFdLtUNnvhaIu2RC6YlSJzamhNbaTEMENoY8PDSPIeYnWCVPY8BBIIEi6r0GZF7
	 Da9U46sUBl/Rojhd9D/4qcNoshvIXlrQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [netfs?] KASAN: slab-use-after-free Write in io_submit_one
Date: Sat, 15 Feb 2025 08:59:20 +0800
X-OQ-MSGID: <20250215005919.1020762-2-eadavis@qq.com>
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
index f65affa5a9e4..7854d55120b8 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -371,9 +371,11 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 
 	if (rreq->iocb) {
 		rreq->iocb->ki_pos += rreq->transferred;
-		if (rreq->iocb->ki_complete)
+		if (rreq->iocb->ki_complete) {
 			rreq->iocb->ki_complete(
 				rreq->iocb, rreq->error ? rreq->error : rreq->transferred);
+			rreq->iocb->ki_complete = NULL;
+		}
 	}
 	if (rreq->netfs_ops->done)
 		rreq->netfs_ops->done(rreq);


