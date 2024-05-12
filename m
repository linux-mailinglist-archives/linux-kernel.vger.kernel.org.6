Return-Path: <linux-kernel+bounces-176846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E4D8C35E2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 11:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FF31C20442
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA7B1C6A7;
	Sun, 12 May 2024 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XyB9mA2G"
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8946011CA9
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715507252; cv=none; b=tub6XjpFbj6580JIGJ0XyOiWsSJS+8JUkxtYi5K6aPdsNxfLEOgIJSwInhsp7xU9I0036apy2j8DLOoyQZ/JtabK4Dn/VBjtS+mp0xRcuxISk0Lw/v3leJ78N/lSc3CUSaSfsPx5E5SfIlU2l8NcKQw39amiititTZmDJAqndQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715507252; c=relaxed/simple;
	bh=BtIoKk7QctKJrucwbHg1ijp0/3Ix36bC0jkLmCetR7Y=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YqmnH2Gbk/6Xm+dTGHYOFfOsGxCQxKlfGx18xY05r3xjnwntEbTQRKk2/q3AU254BUn3DIc5mLSiRuDZDJqJ/f82KxMm9zobra5Fma1J5mIMd0sP++UPUGw1I615nf+B5M+E8iV9A7cqGGg2Ey2uqxirlM9UEHp3dGq80wit9SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XyB9mA2G; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1715507241; bh=3DHUF7ltkFRCMBMMnA7sk08Cz4qv4ZUCjegKStZ5Jww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XyB9mA2GbprckxdRnuWQa22yX5xf4kiCuw/Zl7hq3iUF8c85J86Oh8Sx9OeYuaQcI
	 QFbLl8HscFDTH9/9qTwc0hbiNiKO38ua632AZkZEJCyiBtPBQM5gX+YVEhGPLJH28Z
	 OVEZULHGCNYwoR2hrmZnN8po+Wz96LK61uAs3Zww=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 9B6084C9; Sun, 12 May 2024 17:38:54 +0800
X-QQ-mid: xmsmtpt1715506734txco6kadc
Message-ID: <tencent_6BDDD81904CFB50DA5A5BD0D9612535DE607@qq.com>
X-QQ-XMAILINFO: MBjwNRQMz5zU6FmzQCNFwtIE/I12sqmXqAjPBUc2D4NuKPusnAFRjlPZMdHlss
	 iH25s+Ul6gDqy4JqLlQYKnl05+/C6oyr10OnGFEjvBDO1Bq3WrLg04hm9jk31vUz/gyV88k79vLv
	 hACPFLO0jo4SAdztn33VxOrQZauBKOg+Wu1PPSQxVyEsIiNWr3qsRSbmWAdTwa5s8fhCxjc47QjB
	 h9aW1sPfEped1b+FU/MeLL3XcWrMd0h6AMJxJQZNI+xa28krvWKwUTbuwrEIBi9G9SwEP1+pRlh1
	 y7pOgAqnusQ6MI3Elau596vMK6tCC62eR1MklqEZ4PUZJTTfQoPDiIBJYqRUHzB+BX31HMG4pDds
	 YO1PfY7SvuDnqpNpaNpAUUagxfq2KN4/JbLXoLu2Hov5ooBltulgrROm42APRiTk5zBRUDrJWTj9
	 X0dwV0fpslEqQ/bxMdHGJBzIdM8LuD6M6E5aSo7mqk20BcDKYWhT7eNYEzhKguw34ultQqbfI8ip
	 +Obj4qJ8y1y+Hiw2V9ZJGP19Dy21E44+KSYka2q9L87nTQFGZsht5LV/7ytaJeLQjWx86JW9JyVe
	 jCuxXOpUGTX43KQBjzata1BZo8DWF7SQWJG0U7MBkiPg7Wz0Qq2NIYQrp1t2ztH1TaRBBNDuObwd
	 IQy1CfA5xlreR9M9CPPe8Eg5wv5O6iP2nhSzyGFOuP0kFlhwjdoiWoENlmL+8cuBZYboTLt+bIYF
	 Y/tiVEldd4lz25Zxsb2nMJJX6tXpdfWi4cUjflL3yaJx3mMkZqE8kAO0mQ9S5iseJkCrivJzHszM
	 r0EPcUSXQDsD/n/L3AJhTpSEaixXb3PeC7oqKFGe26dGRQRp7bcKXz/MJ2VHJYgISKndq69g+OF3
	 VxGpHk8PsHNvgb3L6fjWe1poYp2qBF27lkOEj8FAldXCQI+Ye0CgDnXnUDk6K6gGedQJpHriWa
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a63a1f6a062033cf0f40@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bridge?] KMSAN: uninit-value in br_dev_xmit (2)
Date: Sun, 12 May 2024 17:38:54 +0800
X-OQ-MSGID: <20240512093854.3012612-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000d4e70506183d374d@google.com>
References: <000000000000d4e70506183d374d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uiv in br_dev_xmit

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git dccb07f2914c

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b99127712e67..578590c83580 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2247,6 +2247,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 		goto nodata;
 	size = SKB_WITH_OVERHEAD(size);
 
+	memset(data, 0, size);
 	/* Copy only real data... and, alas, header. This should be
 	 * optimized for the cases when header is void.
 	 */


