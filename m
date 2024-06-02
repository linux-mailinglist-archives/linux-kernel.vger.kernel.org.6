Return-Path: <linux-kernel+bounces-198079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F568D733A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 05:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E71C1C20BDE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 03:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8061B8BF3;
	Sun,  2 Jun 2024 03:21:14 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE54C3C00
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 03:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717298474; cv=none; b=mgM6V93Mss8Tc7OK8pr46yDojxSYQrAjlaVi3+5vm5dK4X3CJC6gmkVv/OfSame6Rd4vB8iOgHWQskkkDqIwEkerGju52D2glvqW/uyhHvS7x1do5E8vXUJIeRHxHyHiIvOi/x8JX59XuqRlqjTTLo8SETxzQtPm6VLm/yOoD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717298474; c=relaxed/simple;
	bh=RuC9B5bGfjVUSStXZNKYDtQORRp8jOrk3JShwdsvUEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsAm3bjAFcoAIrSAwsbHb3/rwZpgZZbhkpSSnqLeMW6pIIs0/y80BIJpwaepdAF9r4PydAieh5U+JN5mSOXS0vpK5JtSmjXzv7TBx9q+xIpL1M3gfzhs864kVXUlbp4G1egDGxYfc4zhemA0SezqlOo31kesBpn2LF3rFbbjnwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.183])
	by sina.com (172.16.235.25) with ESMTP
	id 665BE4F300002D5C; Sun, 2 Jun 2024 11:20:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4539634210414
X-SMAIL-UIID: 38F897CC208A423A89B7DEE855A13F49-20240602-112022-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+b466336413a1fba398a5@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [media?] [usb?] WARNING in usb_free_urb
Date: Sun,  2 Jun 2024 11:20:10 +0800
Message-Id: <20240602032010.3726-1-hdanton@sina.com>
In-Reply-To: <000000000000922b0b0619de5b8f@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 01 Jun 2024 18:44:29 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    e0cce98fe279 Merge tag 'tpmdd-next-6.10-rc2' of git://git...
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=157ada62980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/drivers/media/usb/siano/smsusb.c
+++ y/drivers/media/usb/siano/smsusb.c
@@ -168,7 +168,6 @@ static int smsusb_submit_urb(struct smsu
 		smsusb_onresponse,
 		surb
 	);
-	surb->urb->transfer_flags |= URB_FREE_BUFFER;
 
 	return usb_submit_urb(surb->urb, GFP_ATOMIC);
 }
--

