Return-Path: <linux-kernel+bounces-221054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D22290EB43
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74F61F21FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497291422A2;
	Wed, 19 Jun 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tr9Ckg7u"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DC614262C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718800661; cv=none; b=rIfyt6IVVPoeQTK6WRYdDl3U4/pl0OW/BZOLGEB+Ps57CO7Jd+8qiG66uX/s4S1coObLwUgMVlZ9DSv09rBlqfPYAwi+ZG2DcL6Xd5C43UyOaRWKrEh5gnBBsJ88Ji92vr6mcAZSznHUEv/IX5JANSMDko/T/MsK7+P8VDvaUkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718800661; c=relaxed/simple;
	bh=C98l63zLvMtVSAel73Q2HeZYeiWlY3niBgI2rKAn8dE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=j7oD8buxJJ5X6SRgXm4Y9I7BZ8be0M6+Mk5ptdpifQ6u4bPYo45cGGZCYkX11vZ5UTNOJSDxQAfHq43UYRuxo0EO3cLd1BE+DY9a0zJvAxvSBsHIPYsLd2YjqE+i21YH6JmptIlVbROyinhQ9ES4ALLaGWe8DW0M0MICAYV0UZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tr9Ckg7u; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718800347; bh=3tr1aoIrnxc7KAny8fOwZJpfb3wKnMB//QLthIi/rvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tr9Ckg7udf6deunTXWU0uXAB3vaNzazK5x+SMfrBGZsEr19IWHnQ52ncKnzVTh2o1
	 TFUHCO5RTxZKdLVJop2jhhPTd93Cuv+euTdiA6rm/01hEgDoDgY5BrTES6cbvye2HT
	 jg8W8sxRwBYV3dnPa5i5rm8wUW50GN9WQivrpxzk=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 81982A79; Wed, 19 Jun 2024 20:32:25 +0800
X-QQ-mid: xmsmtpt1718800345t1w2eeuva
Message-ID: <tencent_E56D8C9494EB5EEE52CDB8797A6E742CA10A@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMmaP+1mcOH883u0lEt9zf5/vPzK8732fT7RtFloE6aaXm4dHC87/c
	 qPu9chOlJzfzkxjJUs9p4f6q1erIBxwcsjAYNP+jWmObeLFMMs5CHrj3cjhVhdpLYmHfU5hfXkPV
	 JmcsPWhF7PHkFcQB6tStjNpsjPQbXfoXCECtevrIUYbGvxR1vtzgltHKMlTDZ3GUgAI3EGH5xlAp
	 GkkwoVBgPTRphyA6cTYzgoS6d5volQxmwICuwqajXYsT5ojahPykPknfKNno6g4IpMxhZYfOTwc6
	 XXkyZ5vbLw0EQ1gG8rRe2JaEqq10lMhvhVeZ+qhV2IIRBGIDkl6RNE83E1DraC3iP8HwdVJxCItK
	 +9swmEjNBl36CgCLykEgiU2QsBPDWQ1zbe/epZ/SAV/AXX/wrt0pjfmgJvUCBxwG1+IVhWCCZr6a
	 NIioEAmOVaVh4wMEiihV4LrRquN97lnFGdJLOaSIC9e54YK93KNkKqCplV59M02OKyeeIII5NpAz
	 Ww5UOBTwe0vlgif3wJ0zUqBHqjx23LAStbmWtPtxIMFHlMGzUNiYGdUefNkFeVQ6ibQ5ahdYyzwA
	 N/PekBFjiVM6uQeZYIkOKmkHai4e33GSKwMvRK7iQT5r1btx/ZOtZbDA9eamokVZzSsGdG1xHw5E
	 Ant9cyweVaktSBvMAqPBkY20gvlvyjDfL+Annzj2NhmXNPut4KqKmjuazXOT4Fo+6cCrkV0dY+aw
	 O/VWhK8yGWTjUYR6XMsIeLBNBqrP2RUJ6Sl+1sxz1w+ldDmCGiyGRVMVKfeIg3pm4La972mQ+8pt
	 3VMpZLX4foqVdwyJC1cU854mAQtTySbA7vPnsq1f3Xbh6ysbqH0A+nMF417w4k0HzQOwdVKN1GDk
	 5pFfHY42wgc9JCiP4we1VL7jOea70Xh2wZiNZpZkYfnrBZ/6DgWJPwmJjmeqMaXg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: invalid-free in hci_req_sync_complete
Date: Wed, 19 Jun 2024 20:32:26 +0800
X-OQ-MSGID: <20240619123225.2305462-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000033a6e8061b3c6d4a@google.com>
References: <00000000000033a6e8061b3c6d4a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test db free in hci_req_sync_complete

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2ccbdf43d5e7

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index efea25eb56ce..ac27ea24844c 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -106,7 +106,8 @@ void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 		hdev->req_result = result;
 		hdev->req_status = HCI_REQ_DONE;
 		if (skb) {
-			kfree_skb(hdev->req_skb);
+			if (skb != hdev->req_skb)
+				kfree_skb(hdev->req_skb);
 			hdev->req_skb = skb_get(skb);
 		}
 		wake_up_interruptible(&hdev->req_wait_q);


