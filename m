Return-Path: <linux-kernel+bounces-516011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 194FAA36BF0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 05:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57C316FFDC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 04:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A3718950A;
	Sat, 15 Feb 2025 04:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CQK1gpLH"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA3E21345
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 04:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739592636; cv=none; b=WhTW2Ya/Tc9fvC8cJX9hlTzA/MGdyq/3A6Ya/JaCjQw7ddMBzvyh3Y+kRYYAtYENK37WGWMjfyRapvqGlXI++DnxGbHaacOBCRpAQQgk8dqL3j76gkrrL5qcVSmvzm6LlNwNB0NPEfU5eTWiR8s5gFqxXbshmDyUjslEkdas1Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739592636; c=relaxed/simple;
	bh=sCdxMCkzHWRBZ3ztDqan7kQ8cy7gR+wccmJnXcqjrIE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=oPs/91sodk6D8GIgMcGVURfhSWgkrka8JLnF0nA7Od3uSICSaEB91wwNqJHTGC4VuPVc2lGhK89lW6ScUufh7beR5VfxTO/J6SATcTEX1O7PbmUDacbXuE5H1G6wo07r80gmmfm2+JUsc4/d7R9x0vEBxW9r/R+nm5khEobnA9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=CQK1gpLH; arc=none smtp.client-ip=43.163.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739592625; bh=hn7eniI7ejQ6Jnk0asupVxUvBLKiNPaSA+kH+lGVF3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CQK1gpLHv88H8PZLHoTpNFCQK54hwAUWz0fC1s9mS97aAHSE4YPmRMymmzVwcak6E
	 g2WqYSlxE3PJ/r7wZsjOXZ5LDJcfk2lhNra1BC1CtipEJP0gN8kDYQ7jCTyVqL6D4Y
	 304NGamT1ODk96izLmQs+zXQ6sIF8l6X5v8CzEws=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 297B4276; Sat, 15 Feb 2025 12:10:23 +0800
X-QQ-mid: xmsmtpt1739592623t27wrdanz
Message-ID: <tencent_69777A376EC6CD33652368897203A5C44405@qq.com>
X-QQ-XMAILINFO: MOnz+xTS1+9iYyVGmY44cQ5yWu+4aczBJoc8MwnRE7bgMnXZ3qujYPviUJbWDQ
	 7gEBkcfqnBTY/oGZV5omsOE1/yd+lSzT7I6mImVO51QGS2MPNSKVWATK87hzI+WLIM+O6j/NrEYR
	 ntKm0/JWApOBBkiP7p4qQ1Avpy4jkjORXa2m364gZHNpovKpS5mv7cVQKndDN8xb/aGhRGJ3RIA5
	 1G0EcSdgUkhfH67khXPVstM6HcEFQsoq9H+m6tiWZnYVV36wclxayiF3sUJQhI+d8nOQiu4Bl8Wq
	 IN1N6t8mbC9iV7PRSynkqq/5RRi4zzgt480mI6DPwA18mXi7QfMqY4K/Nz4W26/NVqO9pnl00rrz
	 jWr+OrPp5Cj3WBZouKrDZvyFjTapq2nb6Lo9heeOb2zH3jy5Yb2h+iWZ+DdCDnOBz3h/YTVSX3UN
	 7HCXknOv/OUqV98Ep1YNSf7znBEhJB+w4JGKf2rQI3sB3jBKFlrJYuqq8B2i8bcO9Ym2qerp52Kk
	 eHytpHlmTRM0dEunJd8Eyyw3zWMUg96kd6iRIkkyo6gLJQykQv1EehHtB58cnGnAVROWhGyrPalb
	 YGI6g7r+SpMEyMg23iFnEazedV379iLCrYL1xwuTKSO+LF3OMGd8fmVHVeJ1qZoyVbX7OSLROhng
	 UUsUkOIMbQbjy6fORgruhGoLDAL2M3+seOEmuJhsMG/2khVnrwYnMetpL08kplEAQNJuf4EQaNVF
	 7aXfY+rqrAb6hVkYG7EPtBZE9+ME0ko1CWg6jT+pxHVXDSRQoX4EKlI82gKUfSTWkuLK6749KZsg
	 uXPJjK2Yl7CVHLw+8QG1/Kkql/KtlsbbdM0oQxA3wdJJZ9XXKdqz2E6LSEuRKAfxAmb5Eg/SSW+B
	 bUHGELPpccUJfXq4pqVGx7lkIDCiL+coIcoODh7tw+G2Bc4bPP9ti8Ri40E3MBV5/HNnp7TbLFju
	 6/Gz8ddVXN16fswHcNYjFe93TgKe0qfSK3fqQBQOQxbuTbHdJ6VQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [netfs?] KASAN: slab-use-after-free Write in io_submit_one
Date: Sat, 15 Feb 2025 12:10:24 +0800
X-OQ-MSGID: <20250215041023.1193332-2-eadavis@qq.com>
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
index f65affa5a9e4..72b08c1709fa 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -301,6 +301,8 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 				     notes & ABANDON_SREQ ?
 				     netfs_sreq_trace_put_abandon :
 				     netfs_sreq_trace_put_done);
+		if (front == remove)
+			break;
 	}
 
 	trace_netfs_collect_stream(rreq, stream);
@@ -369,12 +371,17 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
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


