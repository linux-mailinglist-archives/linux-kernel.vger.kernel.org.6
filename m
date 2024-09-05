Return-Path: <linux-kernel+bounces-317262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4CB96DBAE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63EFFB2617F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB1FFC0B;
	Thu,  5 Sep 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BQ3CKMIJ"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E43CA6B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546107; cv=none; b=cTFTjRR6DkL76dh8gU651zjGT+h8+qzs99dbPC61wNtyf8ImPlJtpHD6qwcWUAvKGAOAiv1d42aQADtqtoGJQ6A9yKBmYjuxP1iq9+gqjWD7ztvthxvorWO3Mx7XTxvDIf/WVrKOGysTLFfdp9sSMVDmZ2jSO4JZkjjKK+zJzIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546107; c=relaxed/simple;
	bh=soe4lSBt3n/0AW0IvOwAvfTmHxrYurlhVZOxeGsvUzY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Oa3U3XMq5mA2rykyiSf6Fcb/CrtmzrksqRvylCQYpW+fxrw96OcyUpKPoeedHfOKCMYU0A3BcLG8GolJNIUvli0bdKb+D8kWcp1zwdry3m2Rm8Yfr8V111qcOYOK8wixm1EjDJitf9LQeJeSSnbneZtfjPiRUItefBsILOxNxmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BQ3CKMIJ; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725546101; bh=ijlHayz1ulziNTvGeLOjpuJ9VgH6XzHM9AqcFIyjmjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BQ3CKMIJcIMbUSPVJsg+J608Sckj7P+MK+mZjzOB50lnCqSgEOF2JA8sVhtu5861X
	 h5gsRTjkw3ZmawgAu19sk3A8nEGkjOJuuD1IAqt/Zzlg1vjQ1CP7Pd0xkemBkkilFg
	 XD9pHxRTitCdlpXPXEfxCf1ulBb/ORKgVlXYg+/U=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 5672282C; Thu, 05 Sep 2024 22:21:39 +0800
X-QQ-mid: xmsmtpt1725546099tj1b4ns5n
Message-ID: <tencent_BBD3CC8A27DA46FB12D0C64E89AD2ECDEE06@qq.com>
X-QQ-XMAILINFO: N9rp9v+OMEj5mN4gLYlMmDyyQay1oG1bhPaMSkJTOSXHhR5MHmU9M8v5aqY/Wx
	 bXq7AWO0GveB9SJm9pwLoXZeBON+/aqzFhUA2nqCd/l4CQ4xxf4+2H0Q8rFFO3+vVnOfaBk+Qck5
	 3u3BcoTlAdHDIFMKFLfw57mDXrKuh1bDhDC0MRYMP1OhzWqNoMILUSZSRMFR8CF1DzcFOOwuo4/w
	 GoK4LeklKw9urCDWFnGgSUElNAp7W8L1CUniSmqu5zKGJ8a92MswR/G5pA6o5K8x6pMGAmleQiD1
	 03cSxP59ihppxUB8/ccH8NtHk1aMO1HVCO52a1Paabl6ki5/hm7j1W8zKmYskOH+RRCqL0G4CIRs
	 c61QDH/ntS3tvgdO3AgPth64Mzhg0EZJcIWgamy5jEoSXiAzTUBlsrOgf+ta5Oihk1hUnNpH//Dj
	 iRJj0U3893htuJymrUHJh4hhl2NnVTPGYtvZs6yOtY/x+Tgn1VBCstSMt0xJ5kxDxkRGz2mHjaqE
	 Ak9H3z3Z88V2dpnFu64WSlZ7r+vlGLEnts9Tmc5PDFzR82iSYeOX5kdKgSR5r5LJdt4TnPNPJsgL
	 yeMGooOaTJ5/3eRs0YX04ZwAKdu/1ojf8XvJ0BArpMXuMGz5kYjgI+bm8Q2KDeSAnKX/Vz7HPzJI
	 qdLc0RUSRyq6FrPewCoulLer15lHq+ReVw1ufugP9fZYjz+2ktWYNGBrixsKVHDRWcId7VTx3bNk
	 Wr0ecmD7J1WDQTdNwqGrWRh+iJUHSoOsBSdAtv1DrVtzPjb5gY6BBIFSm7XmN/PHntUisPqhbdSF
	 zudBSHMdyH4G8QHTae5Bkr/WzoY3HT9Tp92vYmRCtyB2UeW/3GyTL/skvipQ6j6CFxIkm0XqxcIr
	 Om0tdoQkCeTlrakAcyptOVTrhMYmLCh6mDjT0J9/M9Y/tR+jrnzNBAvF4xh2EAr3vjhaYBuc9MZX
	 sMzB4k7Qkt/Nz3bdSyhvvwbZ+eb6fG4Jtj5hTadMRA39pQ9Cg2rw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
Date: Thu,  5 Sep 2024 22:21:39 +0800
X-OQ-MSGID: <20240905142138.203122-2-eadavis@qq.com>
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

clear save user data buf before copying data from user.

#syz test

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index e9ddaa9b580d..19bfe25e675c 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -1586,6 +1586,7 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
 		aligned = (transfersize + (USBTMC_HEADER_SIZE + 3)) & ~3;
 	}
 
+	memset(&buffer[USBTMC_HEADER_SIZE], 0, aligned - USBTMC_HEADER_SIZE);
 	if (copy_from_user(&buffer[USBTMC_HEADER_SIZE], buf, transfersize)) {
 		retval = -EFAULT;
 		up(&file_data->limit_write_sem);


