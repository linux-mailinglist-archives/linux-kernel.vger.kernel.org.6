Return-Path: <linux-kernel+bounces-388079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC1D9B5A39
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C611F210B8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D8F176ADE;
	Wed, 30 Oct 2024 03:15:24 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CE62C9D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730258124; cv=none; b=r/X3iCu1yIZL3TDzSwmw1N0E4H/KAQE0agiYlHdoVm5lsDj9a0hRC9Mw+kn/fdFmiMOJnF7EDSlajtKD1d8ZBFHr2UPBCCfDEeYgVvc9cdongtdpziZQc8k20klXbTbnSJZ4yPIoMLNjvl73m7XHuEkooTXbIkrwRvOhENQhTfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730258124; c=relaxed/simple;
	bh=9Ggd7OZVD4TnKV5+6yIRTIigzcXg4CWuc55yHFyjz7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sdowyJUGEeopcSJHbwpIodI6DwkhPkARlrBfy+WAPJV2vv+VSTa/WGaG137OcpKOaMFl7UXHpU1N530kK2VROhELmx+goE40NUAFOlzEvPiUbCTxgqfiWH68A0xFCW2oo/z/2/Il1gf1BN+R1JcOSIghoX5II+IrSGjwB4rol9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2c467348966d11efa216b1d71e6e1362-20241030
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:a5a54aae-f1fb-4afe-8c00-18e5ebaf5c59,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:c6c26d52bef55004983fb5b7b2dc2819,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2c467348966d11efa216b1d71e6e1362-20241030
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1521366705; Wed, 30 Oct 2024 11:15:11 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id D03FCB807587;
	Wed, 30 Oct 2024 11:15:10 +0800 (CST)
X-ns-mid: postfix-6721A4BE-702647591
Received: from localhost.localdomain (unknown [172.25.120.36])
	by node2.com.cn (NSMail) with ESMTPA id 88F3CB807587;
	Wed, 30 Oct 2024 03:15:09 +0000 (UTC)
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH] time: replace call_rcu by kfree_rcu for simple  kmem_cache_free callback
Date: Wed, 30 Oct 2024 11:15:06 +0800
Message-Id: <20241030031506.77064-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since SLOB was removed and since
commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache=
_destroy()"),
it is not necessary to use call_rcu when the callback only performs
kmem_cache_free. Use kfree_rcu() directly.

Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 kernel/time/posix-timers.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 4576aae..6a74a6b 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -413,18 +413,12 @@ static struct k_itimer * alloc_posix_timer(void)
 	return tmr;
 }
=20
-static void k_itimer_rcu_free(struct rcu_head *head)
-{
-	struct k_itimer *tmr =3D container_of(head, struct k_itimer, rcu);
-
-	kmem_cache_free(posix_timers_cache, tmr);
-}
=20
 static void posix_timer_free(struct k_itimer *tmr)
 {
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
-	call_rcu(&tmr->rcu, k_itimer_rcu_free);
+	kfree_rcu(tmr, rcu);
 }
=20
 static void posix_timer_unhash_and_free(struct k_itimer *tmr)
--=20
2.1.0


