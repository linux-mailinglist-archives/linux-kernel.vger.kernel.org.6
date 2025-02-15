Return-Path: <linux-kernel+bounces-516006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6212CA36BDE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 04:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174EA1896695
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 03:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793CF15A850;
	Sat, 15 Feb 2025 03:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fcwo70Co"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E69C7485
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 03:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739591721; cv=none; b=s/XoelGhbRPJG82RlSVPFIWd3fuTRRFOzDeK1V3Z1/46aAb02bDDrQmCaD2QhRFpqaUOT+Qd8kcUBEoxhDkxMMO5gWghs1fVJQX7HN2SxpMoYfES0N0SSk7qjHKpR3D/M0rFyg5NvhI/UCG0tIUWdmQECBu/sVKrWMd9HY0d5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739591721; c=relaxed/simple;
	bh=qi6cFKtH1yQZEMRIFrtDpsKg00+G1WKaGiDxHpGQKgw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=AB0i5HlRDcOOLtPSWbJdvkZ8gzb1NE4TlGx3O7FcFEj9C+MH+/xpkZtv8bsEw3D78BMdtTOy8M4aNTuFSu05f02M7IP8O9YROr3xwjZbR5buzFM0PgqptmC9fcm67ndFFqWoqTMYc6IB5T27s6ofPYbC2vbQr1TRQbloJUrM7Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fcwo70Co; arc=none smtp.client-ip=43.163.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739591411; bh=RAnwCpgmuHgPOXDg1ENMIUab10vz5/8J5h946J0sM/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fcwo70CosEwyug8sD04rfj3+9tpSgsAzAjx5hgCNOd5ewa9tlzEYHUeeUpM04+90y
	 h7eM5g0PZYNtH7piMNov8KA4qSezcUicG6cSz3Y3EYLfYML9vCz1UxxSBi5TQ/zLNe
	 cSU654Y6maVwGwSJSYHR7aPor/ag/IULzDprJHto=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id C8A35695; Sat, 15 Feb 2025 11:50:10 +0800
X-QQ-mid: xmsmtpt1739591410tgiu3002p
Message-ID: <tencent_7DDE136DA373496063A0644EF772177AE605@qq.com>
X-QQ-XMAILINFO: Mga4xQMTMa7SaBE6rhXDcq7c5WAFPeL48Dm32Sm8MxuRbRPNoHypNcyG0HiJ13
	 ZhbLOU0VOmixo/47oq5gZyviVwvg1KuGAtGbHQpyc2HBS69LEaG3Tnj33q+9FCbHTDvLOoZCuQ2m
	 P+D/rMZrSZm1gnXg6jF/Hpxg7lau4QclGxmLTVjNQkAFH4nKSjIzjVK38I53qSHtr4TdgOjm914n
	 jM49Azuk8jTQCZw/pC6Zeut6ibblGp8N32yZCgHZP9Mv8IPSK7WRoP5R7bn2T7jABfFyb8mZVHxN
	 f+FFlKWyBBJ/2X27kGX9GLDLqyB6jAIfGpiQtHTbzlGIrPpqtAEYIQNHemRx9OiQD7uXCj5oEjyi
	 9E1ZRiAW255cvwKhyaQdxrFqkx9TyhcVttsNcGbXprtIxZ8loFzczRK0UDyUyPFHVOivZuj6wesL
	 IyfWw4FjpCaucxMPBYurbfJHcq/bPgBHUIc4jpVrCXJ3W3xUhvOnZJ83J/pEeFnjC+kYrYazCqs7
	 wmgLtHjvWyIA2wfoEgg17TCTEQiuIMjTN4vVhZ9hHwKbuyb+MBC7w/P4SlouSvizV+0HqlFIpNng
	 eihozN95pDz23141x6MnZdtC72KYYd1KATXRjeh6ywszkvHcYXkm78/UKIofVb8IzY2So5g2zzoH
	 cp/rfgcclhl5CS/QuVygB5bTTy3F5qBJybxMMOI2EVo+Jkju2xpi4VU62nf1GUhbnnUKrkzwz02H
	 wlYBVDj+AeXj0E5xrrIOpme283/+Kk80nTFlttUDgzmQ/a7FRZsS4K1KR6Y19EVQqehb6jFvbp7d
	 bWVyhArO9P7ORutwOdJVasA6RnIA3iwcABzqkjvY1AA/iUk7FmONllBPgfbJabuSPkGK5Gu5o01C
	 C3z6MpDVwkFVXn+PR8QJyeJpyq/8b7+Z/RFB14DOikMWljxv9Z+EoGxp5lOEWltqVY9QHabaVoOk
	 lYEmPOwLTJ86u/skjB6w==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [netfs?] KASAN: slab-use-after-free Write in io_submit_one
Date: Sat, 15 Feb 2025 11:50:10 +0800
X-OQ-MSGID: <20250215035009.1175809-2-eadavis@qq.com>
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
index f65affa5a9e4..73fea10d9a78 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
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
@@ -301,6 +301,8 @@ static void netfs_collect_read_results(struct netfs_io_request *rreq)
 				     notes & ABANDON_SREQ ?
 				     netfs_sreq_trace_put_abandon :
 				     netfs_sreq_trace_put_done);
+		if (front == remove)
+			break;
 	}
 
 	trace_netfs_collect_stream(rreq, stream);


