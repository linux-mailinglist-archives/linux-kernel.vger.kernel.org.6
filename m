Return-Path: <linux-kernel+bounces-181171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C150F8C7868
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683AB1F22D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E374014A4E5;
	Thu, 16 May 2024 14:28:14 +0000 (UTC)
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1F6149DFB
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715869694; cv=none; b=GH5aRdpreBvu4PxyVNkM1fR8vEqnmmssvlqFiRXvzbFXrMfoPvMr+W9xSaZxzTitBqQpe9StikEk7MgtUgautEGybtHcqzqkgoOa1lWUrgdBiJTRlmxnutaUXuNBvA0WXVZgpwwaoZoH4yk5FKJbgPG+sOUhDOaSil2faFX/w/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715869694; c=relaxed/simple;
	bh=TDaEZybXqvpmUnjwTVX/eb2UV3Rfqn0IpKildOfcolo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C0uaxObyJUpdHxmjFGOpJtAHJsZtlFxB36d7TogOdpgFU0dJKwzR/xqk1NWP2GFbGI3gVAMcA1iiRlZUaP02iNv30MEAmbq80FrGzYXX4ed0lhVErgCcNT/719VsnNcR53lBraOF4AcSEaY8Q4Q/akROqubc1/FNUGPVA7651Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.157])
	by sina.com (10.75.12.45) with ESMTP
	id 664617ED00000A8D; Thu, 16 May 2024 22:28:00 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 10188231457764
X-SMAIL-UIID: 4EA501508203459DB2B96C4558590B53-20240516-222800-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2f44671e54488d20f0e6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] [usb?] WARNING in kernfs_get (5)
Date: Thu, 16 May 2024 22:27:48 +0800
Message-Id: <20240516142748.3376-1-hdanton@sina.com>
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
@@ -64,6 +64,7 @@ void kill_pending_fw_fallback_reqs(bool
 	mutex_unlock(&fw_lock);
 }
 
+static DEFINE_MUTEX(fw_load_sysfs_mutex);
 /**
  * fw_load_sysfs_fallback() - load a firmware via the sysfs fallback mechanism
  * @fw_sysfs: firmware sysfs information for the firmware to load
@@ -82,6 +83,7 @@ static int fw_load_sysfs_fallback(struct
 		fw_priv->is_paged_buf = true;
 
 	dev_set_uevent_suppress(f_dev, true);
+	mutex_lock(&fw_load_sysfs_mutex);
 
 	retval = device_add(f_dev);
 	if (retval) {
@@ -124,6 +126,7 @@ out:
 	device_del(f_dev);
 err_put_dev:
 	put_device(f_dev);
+	mutex_unlock(&fw_load_sysfs_mutex);
 	return retval;
 }
 
--

