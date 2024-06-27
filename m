Return-Path: <linux-kernel+bounces-232331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 715E491A6F0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F2CB277D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAF917C7C7;
	Thu, 27 Jun 2024 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VVPE+XSO"
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC5179663
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492604; cv=none; b=g++X6rvIbKPr7Fr+BLyYjMAG4fMfK1/Q97FxmeHhfPktmTSe7aj/siZDvn9l8Hu6BOlLPuo5npILZxrkjTiNQ6PpbOtCxTP9ahAkLR4YthpGB4vqoszSZZfPHBD7vL+NTIlXn6GwDX2s0AohKd0V6ryBgagWt7QxxONp0K7Q+KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492604; c=relaxed/simple;
	bh=1s6KL2A5BxKto0IMZbSrcHTZhim/DFbU3qpH6hFSrMQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=iSYintI/TZMKI3b5jqCrKf4/cMeMIO7uyuwFLDJunZM3wZBaWhTid/6PdDMEsw7GWQ4XmNKb8pbai5DtosoTAdLrBtHETlUjv/AIrhdheEwNp2lBg9k04hLO7k4RV3fRFqOdSqq4TEw8L6jtvvJtvE/jv9BquuSw+XzKLTaxzSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VVPE+XSO; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719492293; bh=3vgEVukpScf348J5ES58QzjOcxzTTmMqGrdr9uaReSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VVPE+XSOMTiRZra3o7vY8PzErya5zZNIpYLRboOnmH0KOSoJ9HU65EG2CSBwESKjd
	 8R4Ht5pAeJa1lhxYLJj1tjRdgen1aGA9+NiwE1CWZf5tMmKmIldbqgN+I+gaRvfhB5
	 Eslf3CcRxq1pt3Gp2fzCqEeJ6YzSOvRTrIfX8O0U=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id B3381EBD; Thu, 27 Jun 2024 20:44:51 +0800
X-QQ-mid: xmsmtpt1719492291tnx2pguym
Message-ID: <tencent_C7923A5DABDDB2191E4F830DC6A58B8DEB07@qq.com>
X-QQ-XMAILINFO: MBjwNRQMz5zU6FmzQCNFwtLT1jZBSQ9kGjzLaeGXlw23s0kxWHnFWzs8nbqS2a
	 w+fer0NSyxk1WTJ/jHJwY0jZG9mYLLjccvcYUFYfWhPi+4SxlJ5qz8mRFy8qL8gK8hHF5iFAG077
	 bQ2avVy2k9xGrgVeCv7ytTj9YQTDpZ2oYx4IYBhgxDZyGAmc4EqtoSiqtkIRYLB8OtuIaWDdCaq0
	 lge+cwyXg/Xt8QgQ5GAYgXUlWPnI542L4yIfPnVHpY9PBpedHAfe/EcKp5KnV83us1znvUsBOILr
	 RqxkIUqvPl662JhF+JUchpBRLc5+E90CCHHRCDSPULOgGBcto53bSlFdWUUsTJiSsRgyXNq0t0Kl
	 Nd/ATy7+Tfml8+tyGN3MjJs8trM/yr5bCijb9XAxXgZ56eWUcLUbBqsIbd9U/MPGaiprgNbW1pGX
	 zqLtopPsy0VvHdgU44lwQaXgcNL+le0Sn3xhNfY3FnQxAmwEh6wDVb9n7n8xIerDNBd8Uja3++Tl
	 oZgzqDkTNJsJj8kKsCrH9eJ1neeRk7rzPYWqaS2pKIEfeCOQHM7R6sHqTHmHnpBJMZOpgD9PT6Xp
	 jHVeodN3BOQ71zj3RekLnMi3V8HWUbg+cRTfrWNsmkKK5LQCJ5HSp1iLf7M9JZ8Acs83AgbVOLSR
	 f49Wx4QLippxhS6SeRz1a5pRVNC6MLui9Q/9d4CudndJXBs/GYCejlnP09kmkilz9uyiM2MBwOMz
	 r6lke81Y2NpDE1RdFZCuOz2KJWc8s0BE7zp1Nacy5rcYV/0OkP/LJ3lG0WW2e099afj/7drgM4RG
	 rTm+Qj3zgX1AWq2lmc688qXDNR0hS4sY5nU8WE/Zbzk/PaLjLJVsXoKokK1YKYo9r4IguNMh+/v0
	 3/5YvxAHHkliEFg7Q4O/1jBwhnCAX6fH3zLunBjz4OsZl4kHYPJIE=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
Date: Thu, 27 Jun 2024 20:44:52 +0800
X-OQ-MSGID: <20240627124451.719448-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000008405e0061bb6d4d5@google.com>
References: <0000000000008405e0061bb6d4d5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

delete tunnl session list

#syz test: linux-next f76698bd9a8c

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 3596290047b2..1fd27c902d80 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -446,6 +446,7 @@ static int pppol2tp_release(struct socket *sock)
 	if (session) {
 		struct pppol2tp_session *ps;
 
+		list_del_init(&session->list);
 		l2tp_session_delete(session);
 
 		ps = l2tp_session_priv(session);


