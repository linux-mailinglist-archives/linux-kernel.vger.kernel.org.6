Return-Path: <linux-kernel+bounces-182995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E74088C9302
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 01:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B0C281CB0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 23:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7CD612EB;
	Sat, 18 May 2024 23:02:09 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2470C199B8
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716073329; cv=none; b=ebDUCptS9XJMlH8Tc6f0QADFH4IqkZxwijPIAIC9+OlWDYnH+F2pUrAQWKRsVmlmcTYCRkOPMS1yvghHg6j3gq9tQP3Q0eujIt3KB9KbI9HfpS7rVoXzfryOL4gfxlV/nACjVdhir6XnEaN40/XzimQkFCptZ1qWBEfELXDBxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716073329; c=relaxed/simple;
	bh=G6vDf+lRemoblvucBh3laridfNHysm4v3Er3VZGWys4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RBmiuP5mprzunw6874iC8sn6Hyn8001Z0ZM3nDmWFGfRS79HOF4lX3eCkKRIpbAYtw4qo6iEud6KJzmDd2rMyhEBbJ9RjK/ZRlvNgjxlij4PjyhewgvQpjvyQgazE+JZ6unLlwWbxxXGkTjrkucoRyjZRn0WIaA1TRV+CCDZjsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.153])
	by sina.com (10.75.12.45) with ESMTP
	id 6649336100005440; Sat, 19 May 2024 07:01:55 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 63390531457848
X-SMAIL-UIID: 3173DF573BBB437BB3E8A5340C7C8B6D-20240519-070155-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+77a2ec57108df22d5c63@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] possible deadlock in evdev_cleanup (2)
Date: Sun, 19 May 2024 07:01:44 +0800
Message-Id: <20240518230144.1856-1-hdanton@sina.com>
In-Reply-To: <000000000000de2ee50618bb2490@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 18 May 2024 07:18:36 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    fda5695d692c Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134d3182980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git  for-kernelci

--- l/drivers/input/misc/uinput.c
+++ u/drivers/input/misc/uinput.c
@@ -311,6 +311,7 @@ static int uinput_create_device(struct u
 	struct input_dev *dev = udev->dev;
 	int error, nslot;
 
+	lockdep_assert_held(&udev->mutex);
 	if (udev->state != UIST_SETUP_COMPLETE) {
 		printk(KERN_DEBUG "%s: write device info first\n", UINPUT_NAME);
 		return -EINVAL;
@@ -362,7 +363,9 @@ static int uinput_create_device(struct u
 
 	input_set_drvdata(udev->dev, udev);
 
-	error = input_register_device(udev->dev);
+	mutex_unlock(&udev->mutex);
+	error = input_register_device(dev);
+	mutex_lock(&udev->mutex);
 	if (error)
 		goto fail2;
 
--

