Return-Path: <linux-kernel+bounces-334272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F155297D4D5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E03BB22D29
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA6214386D;
	Fri, 20 Sep 2024 11:28:44 +0000 (UTC)
Received: from smtp134-25.sina.com.cn (smtp134-25.sina.com.cn [180.149.134.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D23E14290
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726831724; cv=none; b=tRmmNAyJ8v/LFlIEbgF/LqEs64QELX0t1uTM0IvgkJCIII+vkCJrjSgRQ6Lx/nfnPQ3YSxAlLm91QZS+tDkic34ruUc8Zbun3VbHU1KRR3xr2Eve8r7C2nF2rSH9+elmVbJomZMU0AqgPJwDsUkkSez69tgjm6fxKA/II0uctic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726831724; c=relaxed/simple;
	bh=jEqJ/+mSPKWOagHDO6i56B5narGLux3drkgc9G2BwsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uYJIfeXC5sdFgwHA73hgJExwqmTGlblAueCsJoOUJ9ooO/Wv58p8HWWgU4D8Qj/iDqh6GsIhNEskskAH+/g34ZZgDZavtWFvAuPuK4KWOM1JlZRpMEM/js/+mTjHk13GfrINXdPPEToI8xIEdMFA69D7j2KiWF5H9bA3/yGrRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.138])
	by sina.com (10.185.250.21) with ESMTP
	id 66ED5C5100001D2D; Fri, 20 Sep 2024 19:28:19 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9092103408272
X-SMAIL-UIID: BF091B63CF41477F87B282E8409A83F5-20240920-192819-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a11c46f37ee083a73deb@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [media?] KASAN: use-after-free Read in em28xx_close_extension (2)
Date: Fri, 20 Sep 2024 19:28:09 +0800
Message-Id: <20240920112809.627-1-hdanton@sina.com>
In-Reply-To: <66ec3c83.050a0220.29194.002f.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Sep 2024 08:00:19 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    68d4209158f4 sub: cdns3: Use predefined PCI vendor ID cons..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11166200580000

#syz test

--- x/drivers/media/usb/em28xx/em28xx-core.c
+++ y/drivers/media/usb/em28xx/em28xx-core.c
@@ -1134,7 +1134,7 @@ void em28xx_close_extension(struct em28x
 			ops->fini(dev);
 		}
 	}
-	list_del(&dev->devlist);
+	list_del_init(&dev->devlist);
 	mutex_unlock(&em28xx_devlist_mutex);
 }
 
--- x/drivers/media/usb/em28xx/em28xx-cards.c
+++ y/drivers/media/usb/em28xx/em28xx-cards.c
@@ -3910,6 +3910,7 @@ static int em28xx_usb_probe(struct usb_i
 		retval = -ENOMEM;
 		goto err;
 	}
+	INIT_LIST_HEAD(&dev->devlist);
 
 	/* compute alternate max packet sizes */
 	dev->alt_max_pkt_size_isoc = kcalloc(intf->num_altsetting,
@@ -4156,6 +4157,8 @@ static int em28xx_usb_probe(struct usb_i
 	return 0;
 
 err_free:
+	if (!list_empty(&dev->devlist))
+		em28xx_close_extension(dev);
 	kfree(dev->alt_max_pkt_size_isoc);
 	kfree(dev);
 
--

