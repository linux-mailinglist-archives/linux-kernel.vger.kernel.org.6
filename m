Return-Path: <linux-kernel+bounces-179766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 616E68C6504
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8801D1C223D8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5065EE97;
	Wed, 15 May 2024 10:33:53 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93F81F60A
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715769232; cv=none; b=kzyEj1J8KnO3uROmR50gWigYfagGJq/3wL7TqEkqhQbDNKXbnLyjCuP1jMTmEh1om5E1lCFqOUEi4oe2uVRjThQ3oXMBBTlmxNiqSki8IABl859RzL/S4EsVJlTDHQhBe9rATnh8ZNPGyIyy2eI4vOpZuRwxhoVoSoTkOOdJkKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715769232; c=relaxed/simple;
	bh=hzsLl4hnc1S8rrNS8S31yLuEiocyTSovK8Hm2XTTWas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJgCVQBS5yQd2h/0kogO9VOcWrTh6Ao87hAV7IUiegmwyeBRGspsaNw27Wj4DG09Wk1Bjo5ax2pdrMPS3pAo3y9tF0fK9YU696gzq/2lTcA7/irOdhKgWl7O8PwEGsjc2jTsqvVjCAD4ysBW45IrzZYnNl40rfSR7945+zvNCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.224])
	by sina.com (172.16.235.25) with ESMTP
	id 66448F7E00005AAB; Wed, 15 May 2024 18:33:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 78175834210488
X-SMAIL-UIID: B7BED75A8A414A4A95A1F180F40624EC-20240515-183337-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2f44671e54488d20f0e6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] [usb?] WARNING in kernfs_get (5)
Date: Wed, 15 May 2024 18:33:25 +0800
Message-Id: <20240515103325.3308-1-hdanton@sina.com>
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
 
--- l/drivers/base/firmware_loader/sysfs.c
+++ s/drivers/base/firmware_loader/sysfs.c
@@ -81,10 +81,8 @@ static int firmware_uevent(const struct
 	const struct fw_sysfs *fw_sysfs = to_fw_sysfs(dev);
 	int err = 0;
 
-	mutex_lock(&fw_lock);
 	if (fw_sysfs->fw_priv)
 		err = do_firmware_uevent(fw_sysfs, env);
-	mutex_unlock(&fw_lock);
 	return err;
 }
 #endif /* CONFIG_FW_LOADER_USER_HELPER */
--

