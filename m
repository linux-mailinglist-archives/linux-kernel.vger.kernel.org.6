Return-Path: <linux-kernel+bounces-345086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D51398B1CC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 03:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1348FB2296A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F5CE56E;
	Tue,  1 Oct 2024 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="UOmSh0aB"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB9817FD
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727746455; cv=none; b=Rk8Jcq3eY87udo8qZ2dLpTrP+BxVm8zlcJn0rbeD3yzlUUSeUhG+vLUzE6Epvhig0Xauhk4I0fbBQ/HkZo9xeUQB4zqE45H9MMK6MScPgzJpXzefXecu8Y09esScEeqjxs6tKLj4b4EzKnE+yx8GFxyGuQrQDJkQTq/VD4bKpIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727746455; c=relaxed/simple;
	bh=zLry8TzNDRRgIzGzX8HPcTV6sVV01NihTivJQEKfbX4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TRP28e+TxJY9tnitmgxDmu4XFKL4AbYNZ6d/3FmZDkfXNC2WrsIe5Z4QfMkEmrb1lHniWM6tDG68doQo5heLckU422CHN9uX06sGIg1/vbzDhrJxyVuoSjaWPiNqD3YSevxmAQIGD0doRF0IRmgLDBdB8rIYJgiFMhU5d1M95jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=UOmSh0aB; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727746442; x=1728351242; i=efault@gmx.de;
	bh=8M+Ahc0MLHKZSghAqswWmA8VFARZiXQLwECVb6k63J4=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UOmSh0aBV4CwYKthN8Vic8VRDfTjj5lzUdAkjVE/RW2AmKppO8S69Vjk9ABWixEO
	 cGer1fCWUrso9j3M4gSHMT/DLCTE3YbXobIRth8Msq2qEsteVFtREkwdc8iN8hBPr
	 R4jZYivyR3xScg1BYidtnrh8fdgcTlCHJBGx/keaQVh9663Y5PKSnpRJNjVhgcMS4
	 Gwy3PxhNoyMiv76c4Yng0MylpfLZ6LGFVcDFHCe04VesY4xwXS/DfHWMj4++Vfr/G
	 E3HqZc2NTF/eSQHy0KQn3G6wFpHodhhneX1ZmQbES8T3TKgLGYYGMRRXhb/In6ID9
	 Silwx5/cjj/UeOBD7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.56]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWzk3-1sO89b2KPh-00WSrz; Tue, 01
 Oct 2024 03:34:02 +0200
Message-ID: <7515d2e64c989b9e3b828a9e21bcd959b99df06a.camel@gmx.de>
Subject: [patch] sched: Fix sched_delayed vs cfs_bandwidth
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Venkat Rao Bagalkote
	 <venkat88@linux.vnet.ibm.com>
Date: Tue, 01 Oct 2024 03:34:01 +0200
In-Reply-To: <2fb24ab402d9de45e3cf16e6ba0ad23a7843e5c1.camel@gmx.de>
References: <82b9c434-a0fd-4488-95be-a45b8cd4b6e6@linux.vnet.ibm.com>
	 <2fb24ab402d9de45e3cf16e6ba0ad23a7843e5c1.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tSRFkQy097EwtO0qlfvBxmsItixI2ffYu4yEZOOoa0Bq2+sv1hp
 quvTYX2u9vSEaiR7qDNfJZL/+F65Kp3wTY0Uxnxu028atkjozKcGwutYgobz2mJPFIp11zF
 yZbETE4y1egpHQfg/TROQS4+9n+WL1M5gmazHi9Jf8MlYn63XamGvm0U/1a3gPp329FCwc9
 gxIdV7GM6n7SFgtODIgtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XEf++yx//qw=;tFTRO00sDLg6aAtroUhHkPROMT6
 gOs90t8f1jgNUr1x30O3yVW0w/0TKO00CHgxdVtRP0RbLUE0O2E6aPk69au+M1hUmRm9OeVhO
 7wNvQ/M24NT3xm/guZDQH60H7XmPPkXsE+hLzuEMn7Uw4MmJzdsuGyJi1cw5jj3ApTOvehdQu
 +s4WdU9hVUzUqca6ca2q5ipXQhQWis9ldtkSE7ljnkngKcwgcgi0wuYikMQOQVioP+5G5+h2g
 USt7697klSqiW9/jl1FPifUYvXiy+P+ttFXgJxiGHZCkbuHwqYGiSZrLsir388qJUbpg7GttJ
 DM80dIHaia6fh3Zi2FXQwQc3Jd0oL6i3VY20O0sTI8VQ42UgqMKmdtw2iRVPaspOtbUOVEyTy
 SiSY8kMjMaMXxne76a3EEAORYXljbWwc/uc32JIgQNpMmNEgNrxEvpyiE7hT0oP0LNPTThSWf
 dZmo5hnBXxbk7+ndy8rpqXYe6vY/Q4JK2usOJgPLBjCHL+musEPUSPw7tSuLu7GNPFzipPNZa
 8Rem+WwkNsczSfSAiJ5KcPUcjLplhd90PcXwWspYL5rxyhZ2rA4tyUfVTu/vMoCILZqGJmC6h
 4zTFJ2mpcJMshRerIp+psWxsx4opHJDOc8SOVBmOs4/oEO7EZ+0soY/OkNkY2VydOe3e6XNIW
 xfE5JIZvpJ1G31cfp/8Uwq2FZSBzvfxsZXmRUSu3VpA0MJqHIatG1A/Dfu/z+ZD/zpQgxZQPq
 CCjrPoU2Q9s15JbojjdnCyy+DzqjJcc3yEcV8634SiOur5VoldWCNHleiFpyA2EVR9Dfmn7Cb
 qdt00VVLVk6sbHG+LbaDJKFQ==


Meeting an unfinished DELAY_DEQUEUE treated entity in unthrottle_cfs_rq()
leads to a couple terminal scenarios.  Finish it first, so ENQUEUE_WAKEUP
can proceed as it would have sans DELAY_DEQUEUE treatment.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 kernel/sched/fair.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

=2D-- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6058,10 +6058,13 @@ void unthrottle_cfs_rq(struct cfs_rq *cf
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq =3D cfs_rq_of(se);

-		if (se->on_rq) {
-			SCHED_WARN_ON(se->sched_delayed);
+		/* Handle any unfinished DELAY_DEQUEUE business first. */
+		if (se->sched_delayed) {
+			int flags =3D DEQUEUE_SLEEP | DEQUEUE_DELAYED;
+
+			dequeue_entity(qcfs_rq, se, flags);
+		} else if (se->on_rq)
 			break;
-		}
 		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);

 		if (cfs_rq_is_idle(group_cfs_rq(se)))


