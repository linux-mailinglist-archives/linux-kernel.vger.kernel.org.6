Return-Path: <linux-kernel+bounces-334688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDBA97DAAD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 01:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3083E2836B5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 23:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061AA187322;
	Fri, 20 Sep 2024 23:01:01 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6919018DF8C
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726873260; cv=none; b=Z7xUsH43GTygMHjV3MkDeZGwPX3k2+H6kB+UNleoi2HWIrox5X1eVk+ONkKVtUtTUA1oCWBbZlOxs/+kT4ZAQXneQk5yeESqDVbbvmSwJ/yGK7PN6wdeyqsO1Riy+B9jhKitoLTJYYVZDmn3DfMWioqHXcxN1Bw6IZ+SqbgKjYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726873260; c=relaxed/simple;
	bh=Sjfw2c8bFMAF/LN1R6PFiwGk3J+36lUwXJ+Snt6qEbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=syIonlk7vefiE+11ZSHjl6Q9U+AfEehGu8uo5s7c58mpS6KoHigLxtmFmKRgSe3o9B4kX16XCqJPYGP6A5yWgOIjkV6DCw88mkPjJl2X9lt3eknWU8WA4INpdVH/XP/VnDDmnyXTbAJHT4nnUcpRRRj5DqsUGlACr7JvMcUyuaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.129])
	by sina.com (10.185.250.24) with ESMTP
	id 66EDFE780000538F; Fri, 21 Sep 2024 07:00:10 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 11520410748415
X-SMAIL-UIID: FD5569B2B6034575ADC3427ED70D31CC-20240921-070010-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a11c46f37ee083a73deb@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [media?] KASAN: use-after-free Read in em28xx_close_extension (2)
Date: Sat, 21 Sep 2024 07:00:01 +0800
Message-Id: <20240920230001.685-1-hdanton@sina.com>
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
@@ -3735,6 +3735,7 @@ static int em28xx_duplicate_dev(struct e
 		dev->dev_next = NULL;
 		return -ENOMEM;
 	}
+	INIT_LIST_HEAD(&sec_dev->devlist);
 	/* Check to see next free device and mark as used */
 	do {
 		nr = find_first_zero_bit(em28xx_devused, EM28XX_MAXBOARDS);
@@ -3910,6 +3911,7 @@ static int em28xx_usb_probe(struct usb_i
 		retval = -ENOMEM;
 		goto err;
 	}
+	INIT_LIST_HEAD(&dev->devlist);
 
 	/* compute alternate max packet sizes */
 	dev->alt_max_pkt_size_isoc = kcalloc(intf->num_altsetting,
@@ -4156,6 +4158,8 @@ static int em28xx_usb_probe(struct usb_i
 	return 0;
 
 err_free:
+	if (!list_empty(&dev->devlist))
+		em28xx_close_extension(dev);
 	kfree(dev->alt_max_pkt_size_isoc);
 	kfree(dev);
 
@@ -4201,6 +4205,8 @@ static void em28xx_usb_disconnect(struct
 	em28xx_release_resources(dev);
 
 	if (dev->dev_next) {
+		if (!list_empty(&dev->dev_next->devlist))
+			em28xx_close_extension(dev->dev_next);
 		kref_put(&dev->dev_next->ref, em28xx_free_device);
 		dev->dev_next = NULL;
 	}
--

