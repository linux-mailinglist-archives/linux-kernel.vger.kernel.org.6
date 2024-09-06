Return-Path: <linux-kernel+bounces-318874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4872896F47C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFA17B21A28
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6231CB328;
	Fri,  6 Sep 2024 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JRBnxeLQ"
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097751CB15C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626648; cv=none; b=ISb7proh8kZdYC6UGEl9l3HXZmkcWmHTyPc/f+MSsRJ5hLqTyIccmupTkQKTkM2CLnV4Dg3g4dfUx61Eay3EtvGVhYzNAy9wyQR/QC6Ku+5aZ72yg4V2ehcty5zBmn86CkXsPa6UuQXge76lVFp4N+x/LqfkWMKv4kxsiyWJN6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626648; c=relaxed/simple;
	bh=2zfSnqJ/SRQ5t85COGHlS0xvx8Tv1Dw91EumNcoy2Gg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ZVlhbxGQjM44xsMI+hd/M029S63fTtNIYvt+pri3iE+IbbvTSir6ZC4h5pwJ/GYku0q9aWm+GP+J3U7+aUpfCgk1egaMa6dBhBOlNfr2/34eWjDWH0lAbMiIumBRN47KA/sbyKTcm39TJZEp7buQNp6FbLiWbw88NNUV54qZeJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JRBnxeLQ; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725626643; bh=oqGWNkgCT6oKf44bCATlmrcHw4iKj+6V3A/V6rSP/d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JRBnxeLQl1D/Cs9wWSOS2XsIDmeK8ZpM3tYlOd+OEelboA+muA71PxtaZjVvG1lXM
	 sATvIMVWxZLC8F4wIIRzAob35izRxI4xrVAlyilKPdbqCuoMLR0L71Ap7RlM7hrSN0
	 WQYhAt4YeUFVg7F3UaEktAMm4Bm/wBp0BM02wdxg=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 97A3E837; Fri, 06 Sep 2024 20:37:58 +0800
X-QQ-mid: xmsmtpt1725626278tnyn6m75n
Message-ID: <tencent_9909BBF933FF9E791B784B591B1525EDBA08@qq.com>
X-QQ-XMAILINFO: MhwNeVNHZfBEYdRf/Zbh4Wo9Z7h1hlyvI8RHAqp5/+q/8Tfi5gmJzi9u0c2YJI
	 /wswjLri5Qfw7QAq6ziLrQtZAE09wgw3BqlqFAk6N/h5D5pmazPHE1yUKVeO/2d6cB/Yyuk0Dofh
	 9ioh6HCkvQClm5oaXvFw4s9ANTAACcoKbcu9ifKJBAMEoxbngTRM2L2lVi8A6PZ7q9oUI9hWTXCP
	 0hb4PLqIW8L2MIAxctyZBLuSsY1jbpQwYtiybS6yFRTgvQ2DQziO2A7q1Z1+lYmnidDlr0yEnylY
	 hZ0maQ6PD7pUlP+gm2djfz1R2MwAw+ZgXBx2Nqz9UAnTEnPaiCxvCzUJhkSSb2I51WBqlIRPXcmX
	 ePrwCxHNd4srLBf+SWg9AXmg3okCsNxnS1+Dl3O+9criRoeGSqktYaIuifrMbKSfPSMv5NgGI9us
	 8D/s8y9co8LyTV+Tr2Yu3CKAa+UB+dUhbhxke+eViZjjY3otIWPZSEZXeyfUW/5NlzkoZO4Yaf7L
	 bFwspM1u0ZgrKecyqmu+J8H8pLDx+jaQD4N/DJoxAvbnLADctxOmkLSB3iAllNOevbhp2kVWtJM/
	 b6lq22WNcL5c95i0fhgoyh2hCHE/XSvXA3dxpzQiXqnyxGtjzbRZfRgNmpRq7lJLLPqfzCyjWzrE
	 fFHjezDp2lCR7dUgyM2xi/0eNU0qzJ2ZN7QgoLeSag/SbSdcmQLL288Ce2fosrISJRcktEo/pShw
	 16mGpoiDYXzHuMp4T7Ao65X+WUChonlASQVG5I5mDG7uE+Y+XwmcPpoZ3rV0eq42UgI7cq1vaciw
	 7cAMPsC8NbklFU7SWX/CWptxSiY3lpuAUuxFnoHqGgwkxppeX5/VbF5gcpQrYKcXXYUeXjEfcI8+
	 6jfGqYwO7RMFkxOKyBle1mvqZ+Y6rUnqrUGp2/7JCATqxes53tbB7gACxj5rmDdvrZd7xSzza+ww
	 LYFWJH53LBat9t3YtjQ2YoSAL63syQ
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
Date: Fri,  6 Sep 2024 20:37:53 +0800
X-OQ-MSGID: <20240906123753.270025-2-eadavis@qq.com>
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
 
+	if (aligned < buflen)
+		memset(&buffer[USBTMC_HEADER_SIZE + transfersize], 0,
+			aligned - USBTMC_HEADER_SIZE - transfersize);
+
 	dev_dbg(&data->intf->dev, "%s(size:%u align:%u)\n", __func__,
 		(unsigned int)transfersize, (unsigned int)aligned);
 


