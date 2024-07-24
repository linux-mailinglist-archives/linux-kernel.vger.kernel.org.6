Return-Path: <linux-kernel+bounces-260500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F14293AA49
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365CC28479E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7555695;
	Wed, 24 Jul 2024 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nRUeiTpK"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907F45221
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721783073; cv=none; b=QnhlrIACEiIhvBGRVFXKcFdll8jUcC/NZcjGbmsRfNsyBOCvUmBn18Ys/hAy/P+NBm8oCFNrHWFoUKVn9wcXE5dRId8xnjZQILAzzxuY7b83kYqnN+5NWD180jZpKK2Qjnn+GQWpV8naUSQHKGmYuyocDmJRfZzVPFs3z3eJxjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721783073; c=relaxed/simple;
	bh=Amyrtn9P9xPBvQbPV1tQIX3oErzGGnroFntyZV8wYu0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=RtCL75zlG0D9Zp7aEyr4v5jM0UF8IeZyXZn5zgoOFrB/bmFO8hgcwFt1nMulX88kFx8YnuIB09SLYFeuSsrqTJ2tA7q84AxCi5LV7O2MfH1oLSgyfK+DpT141Vn4gs/XiTxvNFedOWlBZEo9p0PtCr3iisS5p0bRUIl26mh7vvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nRUeiTpK; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721783068; bh=eiLdSwM9x1dbSakvWPVVzTWaHk5sHwN7kZ5kvV1aoSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nRUeiTpKAOEgtutROuZK5T5W9S0knmX36utnf7AtfgpQ2IKVOSOSUZ1j2Hml802uP
	 Yqp8AxK48MT1Q0kSPAEfd9uK/Iy5o/uwCys6E0U36FEMtGqwBfjPgUiSyqwrVStJHA
	 RnMYICaY6Bvh12kuO9RbFECH3+yRrTA1vBpNo2Bs=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id E109A8F4; Wed, 24 Jul 2024 08:56:16 +0800
X-QQ-mid: xmsmtpt1721782576taj4eirbg
Message-ID: <tencent_1C33839ECE1B1A4BC11B35251ABA11BBAC08@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/VlmtfTzmjpg/xvw6jITExvmvaW0bvka1UBvBU4LkVIX0BsY6iE
	 t8tMgK/DKn4K3lAu74vK9c4BG0cQQ4zn6t1t51uAX8yTnX0l2bFobdNQG1NAhueDuO5PMZNNYRvN
	 CFNlTlpmMrTdU6JnaOS1+Z7iL40Zzh3hTBourkhCokeyalfzIvBpHx1fjDFlShT5ub5z8oeIyJEn
	 qEMQD/4DnhezafcP+tvO/eHDpc+ZGQ4uzxwS27EcrkJVal2KbAwkdJTo6zKKCkwnAaGmcSsQy0UZ
	 6DaXdTCuTF4VT6VCzwZzDjUD/7G1VjpU0TpO1xPsCxnIzutBTVvD1KQnhf2D6x2CW9ZqS3MOmpqR
	 KuGTFio2ATpnDydwQ+c3OTeTTcUzWcaH75ZGo3r6HxYfZ2RHuLLJ6vQGjksp3ZgwJnjDxPI74vMW
	 HWF8Du5UwhOfS8ZuVM/lyL6f0hJBs+OUrF8jk2SOXoBaOwQvlMVhwj9r1N8L2lQURo0txw1BeLpe
	 lk36DseRDlLQJd0xrgl/TyvH5fOJnMs+4vqjdqEL7vJ0UW1qTh5GJzB5y+2UXY5JpeBeqWCUDDIZ
	 Dt1ddsDut5eqLuwe7UvJwsa/47y5NDcCT/g9yraJ9dYXi4MUihk3SYAnZ7cj5dugC0Rb3MPHnuqf
	 yHp+56E6zGJ145R3XfY4/LEcYtPnu3AoiHnD/QYp9D/onz1sqSxGOprcyFcprCRDVJboVcymD4+g
	 khIAPi44FWEyECSYXsALlZZpcdNwUhWRdZqgzLpgeFUQi8Qf+ywvJXYzp866lwYtzg4Q+4WCcR8u
	 slqDQt3zMrJpCyXDLI7xI3nhPN4dXbTWd3oB0a3rUZtAwIK9zylaAKPHPA4ektWNSAFEnEW9uKea
	 lHbpeKgFbxlE5lHlxIOs9dVAe7G6aazoUmTuw+VJyj
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+78eccfb8b3c9a85fc6c5@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] KMSAN: uninit-value in line6_midibuf_read
Date: Wed, 24 Jul 2024 08:56:16 +0800
X-OQ-MSGID: <20240724005615.1066762-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000000949c061df288c5@google.com>
References: <00000000000000949c061df288c5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when alloc buffer for midi_buffer->buf, init mem to 0

#syz test: upstream 2c9b3512402e

diff --git a/sound/usb/line6/midibuf.c b/sound/usb/line6/midibuf.c
index e7f830f7526c..1b699cb3b38d 100644
--- a/sound/usb/line6/midibuf.c
+++ b/sound/usb/line6/midibuf.c
@@ -48,7 +48,7 @@ void line6_midibuf_reset(struct midi_buffer *this)
 
 int line6_midibuf_init(struct midi_buffer *this, int size, int split)
 {
-	this->buf = kmalloc(size, GFP_KERNEL);
+	this->buf = kzalloc(size, GFP_KERNEL);
 
 	if (this->buf == NULL)
 		return -ENOMEM;


