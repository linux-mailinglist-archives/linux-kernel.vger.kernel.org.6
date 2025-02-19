Return-Path: <linux-kernel+bounces-521691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A988A3C0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AAE41894E83
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93401F5826;
	Wed, 19 Feb 2025 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ev8eORLs"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF341EFF9D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973266; cv=none; b=sprjvVbhflLg4Os2vH4n4NyDEe3YFRoVMf5AeRtgMdUkBxOxr+HaGvCGSceQgFmtsWtr8ub9ltj1hfdZYTergH1GwINUfeXGuwwvpLYpf0K/RI+G3Kt8fJhpxWAiUNggMBezxeU40NuhUgH7T7+jt2eFT9azKpj2TfrPb2YUBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973266; c=relaxed/simple;
	bh=vGBTWvpUIw97tTe4w8yl5K0ojnEEl5FlFqfjhmKUBFQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NNWCIS48TJjKXOywXN9iYoMWS/bLOwAWlEKvxEHkjK3BpfUAEhj+v4YPMCRElfbmGvt2HMtZGipbFw4N9t/5f8ILDXa704cjopsfc7XG72/xmM4dhwDsUi1A43aPk9dm+EN29tDMmKJj8gUEB2BL+ZHsez/Fss0Swe1g8KUesU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ev8eORLs; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739973251; bh=3Nuz9e1oib+Z34P/zRN6r5EtIJ7+L5I7sJ+M5YRDEwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ev8eORLsXPUjyUyvxZSi3HYAxOMbnixwhWW1aLZyy1uwj3TuhdvKkaejuUVsJ+FrU
	 tP4BPcoQ6Y6CRQI5IR4htQb3BK+sSOWjbS3ilM+surHOZXhSTvlb72h06N8N1dI2B9
	 uDSBTOn5GroRcjIItU9OnibSV9Kl6SlGNDfhoGOo=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id C0427EAD; Wed, 19 Feb 2025 21:48:04 +0800
X-QQ-mid: xmsmtpt1739972884tiebj62ym
Message-ID: <tencent_E04373696603AD045CB76C977726C7D36D05@qq.com>
X-QQ-XMAILINFO: NB2Y38G+/V2YzFOpSuohHtGshZuG5zCtVqGo8Ct96j9iR1V5sRZFOtjhFykGlm
	 t/wpunqQeluXxERXQJRYG3xBAh9m9/0SrZ1V1Muvjhrqbi8AtPVLaVwz70rMlGxMU/faiUUsEkUI
	 mECHzxYcw4wL7XzYB1E+mba8UyWOrrUttF5pEYRzGlSBaHj9tu4/nVoZsAN/5ac4SDJZ7VjS/boP
	 E1QNGMoueLApRy3+VVjhTRMmjDlMFX2hCg6hw16SkSBcSRI95VWektaf/VBOEyOTUNKXRrlXnXTe
	 mxNO52FLnu6bTQyLVmHP/FgDnNxKUJmwG+6hy1bSIcS3DKsKfT5bz1PuSwQgZxcBGcXT65y3aGBv
	 xKkLx5LvfmyyWB6YQEcuKxNTes21dG1kiK1PkdvsuPA73rmPICZcCo/HiAOM2JWy75uK5t9gZN5N
	 QNQ8mhch/f1j2/JHN2oKNBbfTKf+xZG120m12HGd//qfCCf+HBi0E1RrIHn8vO+FxNodScCsVc5T
	 1YuC4O9JxopsaVPox+DNbn2vr4dxKWUcsDfEOmwB8Vw9Hp79jbnUVZdN9kXVdAGlGw7v7xRCBjyN
	 PaqwHQzNdsSJA1tDmmRGyvWbdxktahN6lFXQ/B96iqTxoa0MP9pCpkoYK5aATYdP4M5E47dzFGJ2
	 G6X/JaWos+ad+jx0zsp/HdiULbSIVrHng413Z7+V2DYJdkcZzj5bNKejoOxHaU2EPKE+5XCHizW2
	 7nm8oBx9ozBIFttYr8unhO6/5avjcqJJxUyOJh7a8HDJq9KdXIIl63KKfyA2QAW7UWudEn5NdZHv
	 qFi0oE6fWs9hg9ID0OH9QiqAJP9QY6mYO40ZuRyKIPaoRk9CMAm+brXFL9UZxiPi7qA05ckChXXJ
	 prNNj64e3kNC8zjVyrlhVPhcwq5y9wQQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+df6cdcb35904203d2b6d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] KMSAN: uninit-value in diFree
Date: Wed, 19 Feb 2025 21:48:05 +0800
X-OQ-MSGID: <20250219134804.1576109-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67b5d07e.050a0220.14d86d.00e6.GAE@google.com>
References: <67b5d07e.050a0220.14d86d.00e6.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index a360b24ed320..ff32b614a09b 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -134,6 +134,8 @@ int diMount(struct inode *ipimap)
 		imap->im_agctl[index].numfree =
 		    le32_to_cpu(dinom_le->in_agctl[index].numfree);
 	}
+	imap->im_diskblock = 0;
+	imap->im_maxag = 0;
 
 	/* release the buffer. */
 	release_metapage(mp);


