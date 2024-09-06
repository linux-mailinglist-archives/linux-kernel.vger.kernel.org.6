Return-Path: <linux-kernel+bounces-318915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B9B96F507
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61459288914
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7081CDFA4;
	Fri,  6 Sep 2024 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="igq5pTxn"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A111C8FC0
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725628003; cv=none; b=ZF0Xbn2HA5jfLukKhgZ3/5XJ1/cmYQ4/a+lxZcmle+ZdTewc3Wdm48Wjvqfx86keZa0B1usit+R49KtG9GF21RxFVmHXFL+ZTKIdc6R6cdO+pCvy+/UUl6UL3pf+LWMxnXyTH81seAQ8+vmgey+IPLWqTlc7Lq/7ctv3dVj6lRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725628003; c=relaxed/simple;
	bh=N4r6Z4LilYknUGdeTdFJ4rurd+at5Hv7n2OtIfvg9mM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=U8th1d+BfccrMfadOxdIvb3cPO1Gbgz8eyNUY2VegtYAX+Zc48AnhG7qLdT+i0JFNUmRsBFGTFVpQqCji2CFQSIw8tbY0J61SBS4kPbTFhtTjxYuemTxxbkYkwKEVl4CLymhymnxq69YVivvywvM4XXOnlrzYJuOMfprcjg0j1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=igq5pTxn; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725627993; bh=XicgIRu8/O9XUmcqZyRvKUd0R0MDBc92c/muUV4mj0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=igq5pTxnwRkY1cwEkhfF2AN6CAvH+IAtxg21W6t6nb40tHcVpEUEW4aBLcb0+f3kF
	 iV4t1bJ2xKOMkCLSgv0GMJu/2xfqTe8yT5LdfTgiwu9LBWmi+Shmlddv5//je/uj6g
	 QmeahviVRNN0X6Ngd+SFx21NesbmpouiRM2VtBxE=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 19F23C78; Fri, 06 Sep 2024 21:06:31 +0800
X-QQ-mid: xmsmtpt1725627991thbfba84p
Message-ID: <tencent_157C251EBA15BB1533CB9E1C1B254BF11B08@qq.com>
X-QQ-XMAILINFO: M0PjjqbLT90wWKn3VHFFpdRKvOU6II1ykxcvTYY3pBcbYeU6myoz9eaOCsHPeG
	 Yl1RTBUbFBVIyMG3nHMc3vJ4w8Jo7m2Rau0T4VVSELUUFkNqhNVPXNMPfchMIACVovuB3Y/zCHYd
	 I45I5vhxAtVtQDsm+gTKHoC1eo6A79rw6XUkwVOVdFOSelb6X+4cwdeysPvc8BIEDf48wKNnS/sP
	 N0zIwL+ayThXyt4Rv4EqmE/7Zw8JyEN7MA59dV+SWGRsEDc+nlnztgaqcOxy7RhIgdA8mClrKzEz
	 SDqNQq9tRHry60V40ZkXLSAKqwEZ/CptDB5Zgp4yQIg6gIYbsTQsQfF+x74nMXv7ckZTxqW3pO17
	 VJk2BAJY8dE/h3c2rPDmbyQ1RHV5wfXfs86P1BjSa9SqYgqLUHFV+SmxlNf3Qw6K2JDfPvROOYtw
	 4ncyGHb10O/J0BTstC/Tiq6KFvd8AAbQ9ESg12clRnjEau2ExWRAJZpJUVP/MvLgLh4CJwBFf5TR
	 Lpz/Wv2rYg96H1yMfvr+OjWOi33faxoIciFq/b+sX2/U18iiO+W8nult+v14d6stiIa25HtL8BU7
	 F8A1YzrQcKpnT44e7i/Bk4vrX5/G8bmZ6diuxFanPB4ImYZxzSgd7H/531oWpn9IPLafsGAbepbq
	 FWFv9DYqFn4NlT4Rq0L3lO9wU8kYT59sSpQhK+Zs4zYChpsPllwfw7opW9aG4P3dknhLUBMoh/za
	 4B0WTQn2Pls+vjo2QHP1w8UN3faAjf+ybm1TGS/Yf8Hw+LWerp2yiIcOhOqwy8bbKwONkN0YO8aG
	 nwNna4Z625qWXum0dzNIWh3AGxPTXw7BKvKXDbU5aig2KzJWK64Xd9JGkkJ4RmW5rJtiW8LoACvg
	 0QlD+HEzWYElffxcGm3BlJzHoWvaHaafBhO4BDFA+RKFMnoz4YAwVM7Byc9qZ98WVu4jS2Dy3jsh
	 7ioP6nnXrdwyYov1Jx5UrtwcHlvYglDBTP7bwZqCtO2+5agMEvoA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
Date: Fri,  6 Sep 2024 21:06:31 +0800
X-OQ-MSGID: <20240906130630.299785-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <000000000000a338d6062149eb22@google.com>
References: <000000000000a338d6062149eb22@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clear the buffer that has not been set, after copying data from user space.

#syz test

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 6bd9fe565385..faf8c5508997 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -1591,6 +1591,10 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
 		goto exit;
 	}
 
+	if (transfersize <= 3)
+		memset(&buffer[USBTMC_HEADER_SIZE + transfersize], 0,
+			aligned - USBTMC_HEADER_SIZE - transfersize);
+
 	dev_dbg(&data->intf->dev, "%s(size:%u align:%u)\n", __func__,
 		(unsigned int)transfersize, (unsigned int)aligned);
 


