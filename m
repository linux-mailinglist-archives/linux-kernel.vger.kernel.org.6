Return-Path: <linux-kernel+bounces-318980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8D296F619
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153B61F25349
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77301CF7A4;
	Fri,  6 Sep 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="vJJ/0Te7"
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEE51A270
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631104; cv=none; b=nYY1TdBVQOpQFvj5s8U2krdVwkJpeah81zSNHjDcSs6AbGPB3Lpcj+gaInwO15oauoq25RJrTb/aojwGbAUPuqFh7vuHHlkQYNEPwXlhBCPl1mQvSmB3tlrSfoNe2XN7BXRBSGBuw1HVJIt9fHsNiKN++xn0CVgHTiWEqvFgPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631104; c=relaxed/simple;
	bh=Zs6JLfEDNxU0CbDkcmAvyoFvHr9KjhTBWUZLJcWLiHU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=r/FT8akurtTrZzMfeHGx9nSs1dnsjrb+HG8zdDESISBnH9KiK5H8Y/Z/3IMkM/WU5yZgF06vXT3aLH/TpwlSWgiGmJtMx0CAeGzgha56ss1UUCuJki/M5oX6crrLh7Vp+g64MT9pLzHiBmV9dvY4Tk/y7PKbbGzg9hAA/hag8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=vJJ/0Te7; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725631093; bh=GXdBqNs9pHSeg5f67zHqNjEragJTIci0fmFCWN8IG8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vJJ/0Te7fwtzNTwkaDyxVloilogeXTbyavhi44FiR+UAW9d3HSBR/uJMHE1EiIHQu
	 wvQeHd6KrqgMyIzrvqsLHv5rHGvVlLLqtoHxqk0011yofQIvXhARuDJGsJB7FHONDe
	 LLkypRuqrxiG+OB93pUkExZTNrcSgSEqOWh9QjEU=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id D091E44F; Fri, 06 Sep 2024 21:52:09 +0800
X-QQ-mid: xmsmtpt1725630729ts1nzl7mq
Message-ID: <tencent_08AE7451777167B63C51364097F8363A4A09@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH3Y+BlOD1Zk6euFBdN0V1rjbNQrSez3LROmxaCMmI+EgxToiDs6C
	 IAbx9FtzG43aI86FB1ZUzKXl0cp3F3ziUSWWUODbptGDekrRBFTF8PpR8sU3m1BkZTqeM+eCFPbk
	 ZWpv1tCZlVcyQBu6dhic6mjbM5tW06/X63nDAGNqLKC4yHJFFaPB1aOBbm1eYikTJ5w42vVmwcbL
	 4X8XhAKUK8hqgt1kY7GehXzaVTunv8htKGVVs6x7fo8aFeh+RH8+JdwGREBH/Z2FjTIyPYGi6jP/
	 L3YaD5hvRuoDpx5hZBVQGNIY125pZPZO09LWEAeoZj/3trCbqo5L2O/S3WLwn37N7gIJ+dS7wmck
	 mxIOMHqrJp60agSimlC2bcYbT2nphOTJ5t6XO4ltAL3Hgk1Y2lSvVyIJEgVrwVrtluN7w6/4iGON
	 pEzFCCbF84VX3PpRcJUWIheaJypEwKcrV0jPy7CZPpfrYuwMQmUlq1nD6vwgGaT1K0muSzfL107K
	 TWfifmkD6QWQb4plhAywcRJm4uWwtiwRsmfyjd+RUPxudq/hgIEmmCn2b2OpoaSmD6KP110gxu7C
	 kv9a2VQ0eTV9/NgQg38vZ7i6IbAu3TMPnLsI9aswvwvD8FUR1nZz0QOiIf566ldFtwmjog715DLk
	 Z5zMrRYDIhwjC1Ro5tRoi5MuFZv8W54C+3HAp2EDvK+GNJRZI4pRaxtLcyM118sMpLy/kSX7DWKU
	 fd9IRULzUalP+KV6cI9UrHb6yd0+Pitbzj2gkt7/FMtmpSxYBGayfQQ7D6TTYapkVwKE80gPj2/R
	 ITCNEIPzk4BFv2RXTy8m8omUMoySWRFtlXfWIq5Box7+jI8MH4UK5ENzOLdoSYdhfnmzjY5wmJ+P
	 gFG1DGBI7IAtaAikYdjjR9SOoKwO45XlJOYZTfN2vgM6knRssVxzMNk7dsVDSWCSCqTDhemoU0Y3
	 bLmT2PBkGqyTHNjwvs072Xpipvdq5pScabqZDLySvyguwS7XByow==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
Date: Fri,  6 Sep 2024 21:52:09 +0800
X-OQ-MSGID: <20240906135208.343979-2-eadavis@qq.com>
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
 
+	if (transfersize % 4)
+		memset(&buffer[USBTMC_HEADER_SIZE + transfersize], 0,
+			aligned - USBTMC_HEADER_SIZE - transfersize);
+
 	dev_dbg(&data->intf->dev, "%s(size:%u align:%u)\n", __func__,
 		(unsigned int)transfersize, (unsigned int)aligned);
 


