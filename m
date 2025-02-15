Return-Path: <linux-kernel+bounces-515976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7715EA36B77
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 03:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244611895857
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98AD126C18;
	Sat, 15 Feb 2025 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="vow8CzMM"
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BFA1078F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739587090; cv=none; b=c/siVkOrlOOHzDo5muLzfuomBR+fFNsFfmmmHtn9MYqgQEam/wAB95tkBfifYrA0B+TNW6Uv9DbPlm+/X4xCN86x5soMdZIHjrBm0ZKkqCEOQ/wwncbyaW58QkGaUsVhJVM6HX1FC5tPXM7028lhdCaTnzX8zn18KpRHkDEOMCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739587090; c=relaxed/simple;
	bh=fntRfHLzd+gC7rYNWfA89pWzDYvKJBwRkg72USikgLA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=c+XPF1Mml04vd8PE42/c75+BGu++JLrnWVQAKmhSFbku/LxKEj4uXMNcpRN9n0e3shXysVYVsFc+gvbkcKARkZT7lMgmMjAeBPCJeRlN5mG+hF1x5mhNArs8hbtuok4PV6oJPrOV0dt6nttJXdNDXFdYo2PWPn3B209c491+YuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=vow8CzMM; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739587075; bh=TfBom4Sfy5dI4U02rtTBzeFpPHniqYcxOo0nv43U0WI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vow8CzMM3yaTF2U4liWPA+dmVVDgiI/6zHXXxeMFsiXOw0rAROwpMmB1BOkKFjUM9
	 VZnAZQ/z8/gob5qBeiFs6Jn29U18gr+OyEkiX3jlZRsQrKulEgrm+IHLZE+dBHRa6b
	 IhJT4VE1/v3zngDhVw5MEBrZJJd8sW6MTimeHZ5o=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 929860E1; Sat, 15 Feb 2025 10:36:41 +0800
X-QQ-mid: xmsmtpt1739587001tro9kgbb2
Message-ID: <tencent_7E9E251B1E4B791BAD2507BA27BB48330008@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLcW5XKGOg3Gzb3DYw8I6rgNrsVElVYG02HWBLry/eSGE+lbrGiR
	 yIKk1YGhPBtILl5M/gh1lWL+qnRkzBJgj5J7lPbiW+rN98VHXVMRyuoUnpQwYfimsC89TGq5rHM3
	 9SAKVH/11qrhnOhNwGT1YzNmoe7LyNMqmKFujIZADSnS0qCxyQIer7njOoQeb7h778MSfQQZb7X2
	 2e80wwt9iijJ7fDf7qeKsd2ZM+iqLBrvubhJDNKewL30EHOkA4xyu7ML3JT1Z0AQOaNbJvUCXnTs
	 WlNcCC815PICKiUqRE2fOcdhb6LbKgySdcNjHptqEBpJ1jl2z5XmcGlhqdWeb3M50/ptdbMc3VBJ
	 WEeBC97/LbbKeFN/UwZDumPfRMCYAcyzKBuIO4MR01LK7aJait52VmeBZk7ZI4cVMDwayqTrfO2I
	 Oq0kP4kovpjMvpS4guoRFaKCb2p2LXGDfmH4rt2quVtcMiCBtiWvZER0kL7nIEZhB4XLrRRpERU1
	 IYvS3Grr+qeZz0JFLPAybxKZTlx84hmmauTrIjoxxRUPujhFiScdft/J3CF0sKBeRgg25xv7tSVQ
	 Dal0GnhSTxiRJsJzqF5Gm7OKoFTLFsvWJ4Qjhvofg8R12kQ78kB5U5KJWlpPjvM9u25c9T6CMaJI
	 clxI44/QtF1swKBEIpN4o7lFPTccwbK5GS8OjZ5Ie4rY14Zbsfgoy3pQsnV9DhY0omcTlBK0cFQy
	 ijk/4w9WO3neAWeslYsdpvrvna4u5IS0uk1DnI+ktte4CzUeWOiJe698QzM92cZT6yMw4F5XtkyX
	 xJ9hwVoWe7Kufw3iQouBoZCUqRN21+pBfx7Lp4G3OmECqF/ojzVdwNAnZF/CBuZ4SdWxqwLgn7to
	 6S1+4PxTAR8kcn8OP1Yushvy/ADXLAakk0Kra/i0n0JzOkVIodXh13EU/eUcPQxenHHIgzXjraPE
	 Jp5CC9cZbESulCWk3NZF4dqD0moyE9DjWK9q6ujjo=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [netfs?] KASAN: slab-use-after-free Write in io_submit_one
Date: Sat, 15 Feb 2025 10:36:42 +0800
X-OQ-MSGID: <20250215023641.1108730-2-eadavis@qq.com>
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


