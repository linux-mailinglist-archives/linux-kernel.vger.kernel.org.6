Return-Path: <linux-kernel+bounces-179258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E51C38C5E17
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 01:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AF62B20ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27181182C9C;
	Tue, 14 May 2024 23:23:48 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1EB17F387
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715729027; cv=none; b=FFsnN/6lEb2NpoXIf9bYxMN0+8WloOQHk7m3lqiH0M9EI114BZZ0pYVR+pMxP966aAZSvG8UAzTss2b+yGug4sGAAS+xQq5Hi5tshxG7uH8YI6osKGMqhjgtEj4Tez5Yeu5ALRH0LP6/MtNeNxo825Xy2s6hmU/e32B5/PcBCWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715729027; c=relaxed/simple;
	bh=E/+FvuS49WZ8xLGNg0sPFrJl+qyl+4ZKrTgtjh3LYMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dj8dxf3TTdxul1u3FWfCW3Ddsm09xZRH1VAS0pqV1DhyZOU7MXQnJdR5R8oHtqyy0ED65BRzPfrK6q62o/XCOKFexHmkgIGdm6PBuA1I575wCeMreeWo5BZHVXf7X8SZHkrn4y+CVLfUoPLhKzPi+lACdo3aK1Hxk7NPwmi7zqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.224])
	by sina.com (172.16.235.25) with ESMTP
	id 6643F2720000638A; Tue, 15 May 2024 07:23:32 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7550634210254
X-SMAIL-UIID: 6371BC7211E04BC4A02C5D589C930A86-20240515-072332-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2f44671e54488d20f0e6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] [usb?] WARNING in kernfs_get (5)
Date: Wed, 15 May 2024 07:23:19 +0800
Message-Id: <20240514232319.3252-1-hdanton@sina.com>
In-Reply-To: <0000000000007224f506186be18b@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 May 2024 08:44:43 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    26dd54d03cd9 Add linux-next specific files for 20240514
> git tree:       linux-next
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b06900980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  26dd54d03cd9

--- l/drivers/base/firmware_loader/fallback.c
+++ f/drivers/base/firmware_loader/fallback.c
@@ -83,15 +83,15 @@ static int fw_load_sysfs_fallback(struct
 
 	dev_set_uevent_suppress(f_dev, true);
 
+	mutex_lock(&fw_lock);
+
 	retval = device_add(f_dev);
 	if (retval) {
 		dev_err(f_dev, "%s: device_register failed\n", __func__);
 		goto err_put_dev;
 	}
 
-	mutex_lock(&fw_lock);
 	if (fw_load_abort_all || fw_state_is_aborted(fw_priv)) {
-		mutex_unlock(&fw_lock);
 		retval = -EINTR;
 		goto out;
 	}
@@ -120,10 +120,12 @@ static int fw_load_sysfs_fallback(struct
 	} else if (fw_priv->is_paged_buf && !fw_priv->data)
 		retval = -ENOMEM;
 
+	mutex_lock(&fw_lock);
 out:
 	device_del(f_dev);
 err_put_dev:
 	put_device(f_dev);
+	mutex_unlock(&fw_lock);
 	return retval;
 }
 
--

