Return-Path: <linux-kernel+bounces-573689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E118A6DABC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484DE3B2040
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AB225F7AC;
	Mon, 24 Mar 2025 13:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IbamtVFi"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1481C6FF4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742821327; cv=none; b=JgWFCYMAHyq9/cKXy6fNyvvYS98COM9+mpVS8BWaAabymabLlnqZfvrims6gyyoxOTYDnUHGhkH3MX2+D9tQ+oJDbK7dhKFISDp8vIXxbe0uVvbqMkaQZIik5jVV8z2QK2Ydjv7BBht6L7No3F5BVbWNBTI7UmeVIt+Sn3iNMLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742821327; c=relaxed/simple;
	bh=Y/FjfnWa+UQSPhqlykCOWz1lOmRheCUDAFGBEYFhcvc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pj2rh+pTz/0CtGMUpol2iPF+f/KsJiyR4hTEgaIJPPIFeVXVKHr5M8qWewMPwp+7Po9FpKRmyF4eh4hGsRC23sWrusvwjV9K3DGzs5LgE+5dpKgnevRSkxduF6x8/YVdJZX58sW/9M4hZ2ROU68S+MYCtiFxpQMEnNuBum9KdX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IbamtVFi; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742820921; bh=+RzKwyK9Vuh/fyCjmPrG6ccN09SXq3szO9bLjSALOk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IbamtVFibZSGzOI2ApQV3eVg+CajaDKrGQgyKrj17I18IaYon2BeCblTSmyy93+WP
	 LFiMwq6bCaTwsZG9zJr9Alo8VFwEsSRHVTEv2Lp9sms6R41LReLNWqlnB8xdtcZDk2
	 8FadAqsjl/LQtkNWv2IAGHqYhQKwVRxwmrxQ28oQ=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id C493F662; Mon, 24 Mar 2025 20:49:09 +0800
X-QQ-mid: xmsmtpt1742820549t3qhbpyi1
Message-ID: <tencent_BE4FFF8D8C259C0DE7126FDD8A5D96992507@qq.com>
X-QQ-XMAILINFO: OdIVOfqOaVcrbZktt3mjEBVXFMnglbwDdyTizjmy8sXDG/MPDVuiFfTfS4Dsya
	 vFZxMJTKFaYV5TrqMSKZwkCt1F8a7z5Nu6f9tXYQTeEaBMJtTDL4ipkEC0Jd3LoxoS2ChQ1Mybz5
	 hlIbTgAbh9YVfaELDLpp6ajRG5Nhxsv+f+6nyYdiszl1UGf6UXSYBZWEvz4aVVK8rAml6eF/QP26
	 /PnAKGJ5N+D9O2gS3dmQ1mRWOtrGEJULAnJmz7hC8RjHddP+LsdKhLYlf97BBqjnNPeQGKRcZJEz
	 QUMDMOB2l+txx3rCkT9kU4K/A97lqQkN8vRn6qRT6WeeNcRuXPpgDGCzERDcmzXg65UPRnx2vYc8
	 Qf1Sim5jUPbAuZoNhQ7FDPQ0fJgpyzVUtDEZD92DJFyeXjQP0yuQuxPKUBuyHxNGQaghKhj79fmT
	 fic5H0OC/JhbDiV3Tjy2UlRYhVmtFGonYohbKdDpNuxFliFf7MTQW11fOxoNh3Jr0HImOEjaVtNo
	 JdpGvxAys/foNg03DIoWjbTQYbABX2NNnsygla6gxZrh6PtTEX8NPz1YY4sGVzFpX1IgHXs7eRnp
	 MLS2TMj9RF9LLhHioz7qgxZlVXlui/7XaNvpu3A5y3RURHVP0rmlb1KZSP37RWQKfKP6LA2Zwg5H
	 0PUcVZVpw+txguTs6KhNeleEBDTCEyIMnG/IH8V3Ob4IXj77h2camrXKwrd8Nlg8dnNXXd7jKuqX
	 7hl65IdZVLZv30V/941aNvhuK0sfClt7JhifvKMJ/BGvScJJHM+zfFoYHaFhjI/cAGtw0XnBdKJG
	 vNRe+RfGg6BT2Rq8CDn973GQjf5hCxswlPvDigDTfxtj1t6gFiXsI3oduXuZj6lgzYYoYzPC5U2O
	 WbTzRbTx4IeAfgqfQp6nH5Qf6ttro6+w==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Date: Mon, 24 Mar 2025 20:49:10 +0800
X-OQ-MSGID: <20250324124909.1549575-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <67dedd2f.050a0220.31a16b.003f.GAE@google.com>
References: <67dedd2f.050a0220.31a16b.003f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: upstream aaec5a95d

diff --git a/fs/pipe.c b/fs/pipe.c
index 4d0799e4e719..bc683599a5bf 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -396,6 +396,9 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	}
 	if (pipe_is_empty(pipe))
 		wake_next_reader = false;
+
+	wake_writer = pipe_full(pipe->head, pipe->tail, pipe->max_usage);;
+
 	mutex_unlock(&pipe->mutex);
 
 	if (wake_writer)


