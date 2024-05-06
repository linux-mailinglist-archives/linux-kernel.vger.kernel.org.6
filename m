Return-Path: <linux-kernel+bounces-169817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C588BCE02
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255D52887A1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB2C6D1BB;
	Mon,  6 May 2024 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NXG/6rQ1"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE6748F
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998802; cv=none; b=OXFUazwfX4sfNbbtD3/d1aroox0wygTirviWunQ+MEnXFeDSkcf5seWRDAMYZ+SriSGQFdvkPBNaEvKPMOcjNZ+r3HG4DtR5gCqt5rOBMsii1ldRXr8viO3kzaUOavzHYkBlV6JZNEAceQIMj9yeovoEuLLEDo0bJqAcv7F5XT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998802; c=relaxed/simple;
	bh=zeUrMv4YPmWmqggruFENQkj3gL8x6Ll/crUUUnZKepQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=H8rJq56LQ/y/myXj3fRU+S9P3O4nFJlPrx69Ukg0t2MEz9bcPBXSieC6E9IOACzVjOnWQj5/f3C9QE4x8+VqquCtokwr1JGG7PmFdgMbwlPZKAHOZJ5uPEUF+Lv6GK36Dzmnw5VQ31lnOT6AofoEYJEkcPCwcQ6wWBfGAZNK80I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NXG/6rQ1; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1714998795; bh=DE4829lyVrF+En6PRkHDxupld9FoPj5DIEMQzg0SLBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NXG/6rQ1h6irWuFAsFk6+qASC3IUg0Rp8jRxSG1GoIPyXsUkpuCLg7d8XqDvydlqX
	 1n4MJ81dDjr+8LyElgjBn3E7TJd9u6YyKY/WLl6YxSCOUCHCBDCgwYp7GuymxRQlqQ
	 PeDYYJeyzVmVzhrMXxwHKAueOiC+q7eNCrEO4nyE=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 642A1C00; Mon, 06 May 2024 20:25:02 +0800
X-QQ-mid: xmsmtpt1714998302txyzmw36s
Message-ID: <tencent_52A96D03A9A44E1779F766C6CB5378436805@qq.com>
X-QQ-XMAILINFO: OdIVOfqOaVcrgGSuue8Ej3F4B4gyWNQvo5RBXITp8V2KF+0cd2MYrZrV8LwxgC
	 SlSm3eBvoTbhDk74f3Uud0e5MAhYHDFX73qLrm67K92auomOC1pqvtmN1lzt8d5Y1WW5wvDTcQpI
	 N3f8s0PFjeS2ta4gG22wbcKJPu5wyvqhdczY/gcPu8y7fBXDqHtLeXT8ohPMmgY3WbkuG57cpUbx
	 SDmSJBjgsMzfK65tsIAJyhoXTySCI+8zWlGDRTUEiyV+TN5TNl6hWT38UtXSd6m6ocUXkdtILb3E
	 uGrcNYGUWwIw85wm3WIpgQFHLxcR1tBCLnEZMJwGcOTkGjIFaOsByxAa5OQA7uf7grPfSGLze8hk
	 9rUlPaMSuOdZ8MftbGBbrmF/rthpNEhTq0HGMKILysp/9ZL25J68Mmo5urhFhPM97YQhkR+fahmC
	 n53Tr82NG8qOJcylh5CpKGR0V2S7LIqVMqFWp5wG+yGoysadIE7tOb3yuDJPRWjXkO8ze0z6u1a9
	 S/VW6eKGaQ3Pfu0FXCTdjzsKk+TfvbrrvPe481btpcbg1RbROAId5tWKhDZ3EW+eTBaYDNJEN0q1
	 CvVSbBbN4WTfbZfZiDoNwLxxtdwoR/36RBVymYaYh4T8qmTYGLqXIi/jbbsukWIdT1qZ5XUYqKYF
	 G0G7Dt5vtAOqg7Q/7tYq5ZXAHeVG4hBbj45tcj8kzoal/izJ4S91NVI/hPhs9evz9unk43duyxA7
	 KQaF6aK7SHzIhj+qp0H3Or7H4f7DEloN/i9vO6+KB0/ulE42alU6Po+XDoIzpB2HR2uU9F4vrQZG
	 xQSpVhvVABst6P1IFbRIKXUU8NY1BQgd6Dlr+DtLkpmFcSTMuW/PeUDMFIU5Xd2Ft/z6E+bAkPd4
	 oo/ryRdTA4IU3zPLIvQys4PA7Qt49P2w6/b64hXEZRcAuytOXmN2p5byeyQo1U8cE9q7dTLYEL
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+65fa06e29859e41a83f3@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dtReadFirst
Date: Mon,  6 May 2024 20:25:03 +0800
X-OQ-MSGID: <20240506122502.1966767-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000bc46690617606123@google.com>
References: <000000000000bc46690617606123@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test oob in dtReadFirst

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 5eb4573ea63d

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 5d3127ca68a4..f5d5467a49e6 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -3086,6 +3086,11 @@ static int dtReadFirst(struct inode *ip, struct btstack * btstack)
 
 		/* get the leftmost entry */
 		stbl = DT_GETSTBL(p);
+		if (stbl[0] < 0 || stbl[0] > 127) {
+			DT_PUTPAGE(mp);
+			jfs_error(ip->i_sb, "stbl[0] out of bound\n");
+			return -EIO;
+		}
 		xd = (pxd_t *) & p->slot[stbl[0]];
 
 		/* get the child page block address */


