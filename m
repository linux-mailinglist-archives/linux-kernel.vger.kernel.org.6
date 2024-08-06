Return-Path: <linux-kernel+bounces-276305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DCE9491EA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9192860D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24C91EA0DB;
	Tue,  6 Aug 2024 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="p5eOHRl5"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7CC1EA0C8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951853; cv=none; b=rzLHZqeR5DZIqYOKmBoTVrjZ2W3uY8+v82sdSQd7Afqy2VrHKTsvWvniYmSlQSrlATLMQ4XFSN+dTeWy1Za32kPUwtA/M95z4z0iHSwp5q10ff1Wj2lhU8jzAZJax+zhnt7I+5OYk0xbZ6RiwK8z8X0e8ZNd4o8G5Nj4SqbRMrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951853; c=relaxed/simple;
	bh=W7qOO+itSScYp9MgXK6h8Lt+dTjjWTsE0JIPmwSnbIo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=WbmD8uEs635J9mSCraFYNGOOUyif2nS/IQYlOi0mMzqOS4alf3a/DnlH8rNeAI6uSIKFeCwri5OAV6IjASSI+2Ntbnu875IyytwMoOsoRru9auPSohrG3C3pDCTzjRoKO6sqW2e08OzBzcIoZ8mpl+l2ktUkMN7iVkwtc4JnA6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=p5eOHRl5; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722951542; bh=jhSRwE/+HNJENB5Mf85xwGGqSbuh2d2jWWC94TRoOMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=p5eOHRl5YUbNGPDvrGXSM13aADBnspSeCWoDA5p9YsnCf5Ux65DSXObUH2yP8Mb4j
	 KbTe8ZbXEgMUzUAer+bhG0Iaa7lm1Ufl4wTAR57Z0auXt29h326bVmBjO08bxTuJv7
	 8fTnbtNipYKcOwTwKIzvPtKsz2WKzTetdoR1h1jU=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 9C08DE53; Tue, 06 Aug 2024 21:39:00 +0800
X-QQ-mid: xmsmtpt1722951540tqwnf8hr0
Message-ID: <tencent_71042D016F7497B0E81EEE1ECD607A9E6D0A@qq.com>
X-QQ-XMAILINFO: MqjY5q4G7TFLPVH+qFAtW6KDfR3BNZpwQ+I/mtRFmqES8+QM+mU3MwIYDGobMZ
	 liGA4BiJBBDGiowHb7NseFHfPe6JyXa1p+kWymgwzXLOTqIDV4iAqfdb7sLpZom8sgBkpZXSNxVw
	 7nFtB0aozUUO6GCFNP82sbUAWn6bYxVClBzutk+FN6Jvs2M0x50Klj1mY57sx2YCe2s0p59WQ6Py
	 5joI3qU/e6kTUKGeriPdG0MBWo1RAViMb1MDDVLuw1kxKuVM0xd99pzlySaOWJm12Fqaeyug6WJy
	 6Xg/Lt6wBvHfd7ij/XV/7VRnX6Q0ZbLtyVglUzF8AbP/ZiI8siINLeJ1HzEP/9aZwzeuHoGP0jva
	 HRjZT4tfoxwx2VWmHYDO7mZl5rR90+g/hSFgkMMVr5OM2QFnAhXEdjt997XW2MpdtF7qL0zTaU9T
	 XwrDbJ/i8y8qIPTRCwGD5CDJWFEmAe3ABTvhFWxCVKVAfcUps1C+ObL6UIXWlt0AD6OsfNfIY+Vn
	 xp+05le83HWWyso1WlmUBCIIvDU85DT2ol0vZ9Rmvq1c8VNlY8ABbwUzViVE23BU28kvi0F3Cglc
	 d8/2dwCsbVBVLMffQXrLZ14aKZl9JjJMrewMKALHd2sS/8UoiAU42gfbzY2/RDa0rGgClrfBD/Gm
	 U+CBLtHLWB9YbEeoXxeKrm/F623vQkaWwKK7TCvXzFDcBvH/57c1I1eiIeIoBByvHrL4ZYkZ2C8Z
	 m3dNbDjvrzUAgcpE1/GWjMtbQxrOZyZ2jOIfYYKgfTjfWOMjxui8fahhBE2fyC1Dt19ajGmbCnK2
	 lcbLLR+rl+3APUOZKt2m2B2eOtEbkPq9UmoVyArE43M839k13cuHqa4Gas145ovzOD+tLEJkQ+OG
	 ywi/BOB/qGxJ4YJfWICjY7PHLYZjVEmHcuTT985Rg2hMrn//+nklhMgXHe0F+bjw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
Date: Tue,  6 Aug 2024 21:39:01 +0800
X-OQ-MSGID: <20240806133900.3853566-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000af9991061ef63774@google.com>
References: <000000000000af9991061ef63774@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

session skb_queue get ref to skb

#syz test: net-next 743ff02152bc

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 4be73de5033c..5881d2081aeb 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1506,6 +1506,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 
 	skb_queue_head_init(&session->skb_queue);
 	skb_queue_tail(&session->skb_queue, skb);
+	skb_get(skb);
 
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));


