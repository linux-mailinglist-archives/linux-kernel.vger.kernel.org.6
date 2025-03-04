Return-Path: <linux-kernel+bounces-543080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6064A4D13D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65DBB7A70F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAEA13AA38;
	Tue,  4 Mar 2025 01:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BEvOCYxu"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B13FDF5C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741053090; cv=none; b=aVqsHKHtBqua4X3zNbC6kWFp6jJ7veElXUqZVwga88h9KqYvo/A29yv48s40OHvGbn8Ol1iIUzJoW1F46AMmpgPKI9/nDB+uhKrk0tMR2hzVBcX58pKTqbalIYSYfGc77Um+lwRwukDcJFQlubExlsfcrATD5bBPBIQAeCeUkew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741053090; c=relaxed/simple;
	bh=Tnc9QYLFHMTbHxf9Pjrurw2eFXWx2cGybMwUu8FZlxU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=dNXu6npwwoZ/fhdsBKH1JEiN7crBNz8fShrrxzt+jasyh3lkSXDPHVJMwDsidIqT5kZ9K5g9lhichAD0hS9rgD5xLTI4W7fUvBSHrqEH0Bbi+E/hT/4fEU0OJYnBjrxAgX94e2lJ1egBvCnBHICXj62vwkWusaQLK0rALWC0+Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BEvOCYxu; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741053083; bh=4IpTC/uMXQrR+mSWj3V7OazI/DHQCb0+Nh1aJnKfhbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BEvOCYxupWLlzBOoLLtnzdCe9PpAnfq9luphzJQy74jrTb0SzHrvV561bOd40UyKO
	 0/3vY6C1/m476foieOeKk52SIRM8CwMqz7nLqMIqiRqRSkV2ByoixZgu4Q4iBM6FWN
	 /VqDm6YcF7eb+KMOpvgJRlsTjaDoRF/gMfJ7UYbw=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 98BA0EF2; Tue, 04 Mar 2025 09:38:11 +0800
X-QQ-mid: xmsmtpt1741052291t2njof3fz
Message-ID: <tencent_2CD78CA727DD06C992F4C65189BE6ED72E06@qq.com>
X-QQ-XMAILINFO: Mjkyxxrp/C7/w0LCZrseFHRR8LydWfyBpbFiC51y+loJdogg05mzeDk8J8yAkF
	 NFQrvohgwrgrStIC81wx+EN/p1y+jqyJuURHMuYHI1hATNTFud7wJDkHEXM/IaCigbNCz9vsFLxU
	 Zpko4T3bJ0wuUDsHGpMUBv7/t3vpwXG+iZW6SLrWDsBYT4Sm7yGJaCOrguJH+Q+QVNUePvdWWtva
	 4LrVUCJFeLOTuICT5douHOWaF3TtYy4biHJByeXo7sxtTpL7h15dl/n4kSED6KW9qHFvH82wo6iN
	 ZWoAxyIKbWJHu3iS8nVX1JKfcPmkhfURC8IRiNmLFLXUIQG82AV0uEOLlt4/wdxZQL0HIi/bMRbA
	 6XVQ7BF4bOfnJQXI6rMRsSE4nliyS4xX5aKg9iZoeP0HtgNO3xBnHYmqAbRqlA72Ew2Lly5q64Rh
	 K4seRtCGjJ6w01swEUmvAlBeWW3m5tRo/LrVpXWoep1eor9Pvj6XY74/kZFXBFCdjRJL9km1cyIj
	 0xbwfo1ObtUxoDlrRm+zoFTUKozJ+6fmBvkfuJ/z0DEOGT07ERfeatha2HODGMaSkHNMuPJMkAob
	 eK2o21gVtonOPBBi/fyWELn4PnTMBBu5RTVLVZbLfA7DhPrHbd4wUThaY0IbnrNxejb3sYhcCtSd
	 cwmuBZbb4HWymJrJelQB+q5i8nlgY08LSSj1D9yBBm8EC1sUDzXQSNrq5VMruJnf0i8LDj7zsNWu
	 OAGfXGpQx7MU/jj/4fOUegDu1SIyuylhSo9tUNMtXxzhwwcHUZNxK8XDUjgPOG6Q4QKFHR5VlraO
	 SHxNODUrx3haXPskup041mEtUcUlvDG/inGRlrFAwCPwcUvwz3900QlzfgxxJ4fuIgpnoDngpf94
	 /RMMyDfC+z0rv/o4OSUu6gGCl4qY7z0EKFjHP/0//Y
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
Date: Tue,  4 Mar 2025 09:38:07 +0800
X-OQ-MSGID: <20250304013806.4172685-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67c49230.050a0220.55417.04d5.GAE@google.com>
References: <67c49230.050a0220.55417.04d5.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/mm/gup.c b/mm/gup.c
index 3883b307780e..4caa7c635320 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1998,7 +1998,11 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 	struct vm_area_struct *vma = NULL;
 	int locked = 0;
 	long ret = 0;
+	static poping = 0;
 
+	if (poping)
+		return 0;
+	poping = 1;
 	end = start + len;
 
 	for (nstart = start; nstart < end; nstart = nend) {
@@ -2042,6 +2046,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 	}
 	if (locked)
 		mmap_read_unlock(mm);
+	poping = 0;
 	return ret;	/* 0 or negative error code */
 }
 #else /* CONFIG_MMU */


