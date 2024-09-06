Return-Path: <linux-kernel+bounces-318834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644E296F400
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9B02B211A9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9551CBE81;
	Fri,  6 Sep 2024 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="vDf4Fpuv"
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F471C8FC7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624426; cv=none; b=irpboq31nKfR5uJ23V/h3g3erhcoRX8Z8QahI+HKgt6KPf4O/pJjb/NKvwdzmnGhKE4wboTVlWaSMu/MwzE3JdzNcdYdPBa18TPbl+R4eL8U167PGhaHlXacxhHZFejUjR/IN5PsOAt3TeShmx85frr9FSAlVTcYTTdI/fwHjj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624426; c=relaxed/simple;
	bh=BFzhYHWk4ut1phrJ5VlDkzwyuVmEGhXXTSYXKCK6Q0w=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=RC0nrXwByA+M/YdjdOd+79uNHxKzu2/LOT7IkJrZWrXApx5+/e6DFqV4y+tu6TACZLRr+y1GiCIhKV0tKZF9pv2MOvuJJ3CYw7g5DNfc80hfTuBdiAco1GP2maIXZ00BNTT8Nsq0LJ31lXj1NIgJ3epB5/nfDmi4nxTC6azJxuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=vDf4Fpuv; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725624114; bh=Zie2Fg17vBEc5qPWoyJWYZljSevNgXOUXWgjk+bmZiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vDf4FpuvFXpTZXy4wgZb07mW9CvfsulH8fmX3xVjVo7ePf/5SbEl4lqo4k5DSLKR+
	 AFANskC2ChzZEsjcJAXptOpKteFWRDHfOwfac05HMKaybchW4K03ByNqp3vCqTLE7l
	 TZpqWESllhcZqTy5ghvYUTi5Y8PhxGh/WA7fQdq0=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id DF328273; Fri, 06 Sep 2024 19:55:51 +0800
X-QQ-mid: xmsmtpt1725623751t983yoe37
Message-ID: <tencent_9A6ED2CC9A27D2C6CB92DA0671C98BEED806@qq.com>
X-QQ-XMAILINFO: NDz66ktblfzJMMKkOY9ThhFT+uqPshQ4UmBjOe27YNzOUt/CmhsPMRpXucsTUA
	 ouN7H/QgceJd81H81MP2n9RBKf6cl0OerbgxiaVkK65hC2dRpkYAgUFnckLHP5Q1/dirqAzPotqk
	 D4Y0uEGSBEoMnF33vIyevnRa4nmzoGYMEv5WPm44bhUHWoh8mJ/HO/hScX8ZO+mxJmiIAnDNJymu
	 6HgNDBuRDW2clM2qnWWXsWLDeiJmygW/71TE9x9XGVXk3A0H4KYi202MJG2v6Yh7bSdEPve5gj5H
	 TUDV6OpqP/V2cz08Q03W2+120fINLGdkHb97xr/aX1ahqgnRTW+I140JC/E1rL6/Oh3l2DyPSg3z
	 SPdLl5Hxsi9oR0bka24nz1W4iyvEgVoTje71FnoSdJ1j6b094SQ3Zfxevuxp/bV8nwQEJk3mJrbo
	 +7N3BdgMW0tlSLFoX9V33TGjAa9x4EY90HHM6YaAC3c/CkVH2cAzujTPs/isN37y0BDeeCkhMupR
	 xlrhdWLqm3uxsc3FZ8c5Xjr3uMTik7aUpI3NH7dkf58/KUTx3D54HsNuncRoZXInhxUBV47L1qTP
	 g84pGZOj8msX+spk8jXn/siESgrrtNKPOwRSsX8fgrdQk4d8jBjSgtrmjnogzYy1eINs6HacVlom
	 B/RTMn6R9Yz1HNC5EubZVdZPOMRRG5S2F4pEUM3SyYO6D/Et8lg1xxl6+AWxWyzryGYBy0A6Xafr
	 bOhJzgwVnVkamTRxLRIlsX4tMWWxYgOGj2uYH8JBg0z0p5Jwc8kRZjJa2W5FuMYxV55wPyfeLK+7
	 GHsZJxq9otyJemFnr5AwbHpSeinNcdfgPWBtgc4kCWvRdIIHBS3rDBM60j7/qg1x9g9UvXf3j8mD
	 Q25ecaRFTrKju9ddCVf1ZyESKhmHLd7vfLpU434xQ0tASiE6MXg1k=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
Date: Fri,  6 Sep 2024 19:55:50 +0800
X-OQ-MSGID: <20240906115549.230383-2-eadavis@qq.com>
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
index 6bd9fe565385..5159f1c01116 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -1590,6 +1590,8 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
 		up(&file_data->limit_write_sem);
 		goto exit;
 	}
+	memset(&buffer[USBTMC_HEADER_SIZE + transfersize], 0,
+		aligned - USBTMC_HEADER_SIZE - transfersize);
 
 	dev_dbg(&data->intf->dev, "%s(size:%u align:%u)\n", __func__,
 		(unsigned int)transfersize, (unsigned int)aligned);


