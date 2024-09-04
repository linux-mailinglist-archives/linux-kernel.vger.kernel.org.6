Return-Path: <linux-kernel+bounces-315052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE3D96BD37
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DE91F22783
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BFF26AED;
	Wed,  4 Sep 2024 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KEOIq6hV"
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C541DA31C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454447; cv=none; b=ig+qrJr5IX2tn3UAANNInqbFAwlt5GWMxsEUPipdhHOXUXzENs8Pc2BImfxgpvObmDeE9gAX/fdZEAuaz//qjlL0iZy9prEvS3ZZGJslK2UiJXpc9XohEf5FezONC5HJ1lTtijC9QN8iPY4MP0uP2iyi31rIeN/w1zTeHp/c1JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454447; c=relaxed/simple;
	bh=046RFLhkfGFj/Nbwb24oGDOR3meKhAVCzU3jESfr7HE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=BN5P2Y/E9+sLcy0b3gAXYx5FtBJ1JqC0Q4rqKiTGLACTgTeqBBSjezXQ5KZmiN9lTFFrpP4WK7Nv929djIGtq4awc7f2WstuYkEbhkStOCnVE003EQrZiqSmSUWaF/Z3WLJ2oO+rwZXiDXOqf73ATWvy5RCXx5LS4z6KvPhVQu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KEOIq6hV; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725454430; bh=4Akw6XbNWVpEbbA3HqMh1oScv/rb5TuPGINhaPXGUWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KEOIq6hV7vHJXYvZUPe555M+gU7k2XWD3gbozo6tmh9vDLBsaKXN4nmS6BiHvEq+N
	 pqdYDGrgqyefu+oiZ8lOMnvt4JyhqgTyCFUYgbZi4DtaWB1p2AFW86FRHunHft1nv0
	 eUMMcitftCH3D3aR/YmUXbJOUb0/5DbSwoET3aUE=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id BEDACC47; Wed, 04 Sep 2024 20:47:45 +0800
X-QQ-mid: xmsmtpt1725454065tnepb3zy7
Message-ID: <tencent_CE76CFE28DD5A5A20DF7121F5DDBDDB71907@qq.com>
X-QQ-XMAILINFO: NWaY/LEHNR/FE0GfLsii6F6J+S/D9qf5Qd0zaM3G7sJsoXI+mEqAzma6DVTQsB
	 DIFX8ou0SMQugBqeSI8Uh5tpWyi7HYD297S3C6DF5ude/2Oo84NVP37GxsOGsTseVqN92NbNwS6i
	 WUb5ze0ZDwtsbIo9tw83Kfj9bEgZm6PYT/xMz9eNDtbOdbKSB7t+B1jEGDim/1+I9ylEyj2XujHw
	 hQMb00AREtoIi10q8580s1kpOrqDGgdS1yX296a8KOnhtAyUQp3PgRFLRBRlx45MavR3K20E2+6f
	 wcmRHUgaRs8jjzURcySJhuXaYa3l2STlTCJmjefDrinJ+J7MZoJ82Ntwjqkuh1iTCoBGlz3lTB+t
	 26ATkSINNRuewv0yp3B2bwFNqZnh0uoRXfFOZWbpD4yK1NR/2ZPQPvy9AaSIYpwM4z3d1bXSrJvd
	 dvhVmm8rG3gNirv0xiwPQR25g7OSvxbXxzRtoHYJ2JKsj2RKGzB4AMg2oytwaXAbihNARs5T+9od
	 DwiFYxZDXjwDBAhu9pTfZaYSgiuapsuOuSUFtqajyVaGvOggU9iW4ioTLyYbGzqpvsqdb3MebzkE
	 xtu2vieFLRGWfQFugCej8O6sqnv7IIpLA7P58/PN5egfOqA4z2iLZdflQQB+z58YrSYD0lUaMLV/
	 6ez2885cnj9PF6tTS0bojyHrxiBDmtcs9lM0obo8My0MoAMZjUEC1JnnHx8CVI/NXGCMPuT2AC5j
	 NZgw5A5YSneoPyxILaGAG61XDZqO76WJldfsPVoO7VC/Te96UEi4BPtYCc/tW2fl1APCVuhQbsB4
	 F7O1gKVYmio9UHMOWepvD+XUnwto6G34XSSEB+jCRB7UtjfVIZHBz86q8NpyDgdrPQm3CQMweuek
	 axna6yhuBeAuDdCU7k0yrC9NyJ/XBYAhpRKjNhIpMgCGp1hYunU4RYxs583qImRQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
Date: Wed,  4 Sep 2024 20:47:46 +0800
X-OQ-MSGID: <20240904124745.4113899-2-eadavis@qq.com>
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

prevent kernel-infoleak.
We need to clear the structure before filling fields.

#syz test

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 6bd9fe565385..e9ddaa9b580d 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -759,6 +759,7 @@ static struct urb *usbtmc_create_urb(void)
 		usb_free_urb(urb);
 		return NULL;
 	}
+	memset(dmabuf, 0, bufsize);
 
 	urb->transfer_buffer = dmabuf;
 	urb->transfer_buffer_length = bufsize;


