Return-Path: <linux-kernel+bounces-173937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EAF8C07D8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA46283B98
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C59913329E;
	Wed,  8 May 2024 23:41:18 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC05986ADB
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 23:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715211677; cv=none; b=TG+uzCtpHOJYPA4KJzZZioxatooon4LlYq0Pmb4u9U5g7xwGYieI5W+zM9xA5NQycD8unCaJ9vwBczdykpULhl/R/GcpjRlnCI5uJs8UyL+h8BvY+lz2G2XfZzPOGVLgEw/XIMqWel6hcqrDbC4kJMf4iW3lXTmU81VrzTgyNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715211677; c=relaxed/simple;
	bh=nrqdNLDIzx+dkszgfU8G0gVZ5s8Mf/hcOqDeIGlqtNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jMb9etqzrp3xMywKe8HhryQQcKf0ryZBGd06UYqt5ksQ5wZ+upJmlNQTIGROF1XYg2sRuqQHENDIVh8yCBZbFLI6Q7HZhV7JGDaQkVAurwTHxX/eJFZE3GPkAFML9Wt66XrXtndTBm3kOZPr634zc7IZG2aPzmMuXJpXwjH3MoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.141])
	by sina.com (10.75.12.45) with ESMTP
	id 663C0D8E00003EDE; Wed, 9 May 2024 07:41:04 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 92419731457684
X-SMAIL-UIID: E88DBBE4D00B4F63966FFFAF9A9CF77C-20240509-074104-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+1e6e0b916b211bee1bd6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [usb?] INFO: rcu detected stall in aoecmd_cfg (2)
Date: Thu,  9 May 2024 07:40:53 +0800
Message-Id: <20240508234053.2319-1-hdanton@sina.com>
In-Reply-To: <0000000000008de5720617f64aae@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 08 May 2024 12:27:20 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    9221b2819b8a Add linux-next specific files for 20240503
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161a5d1f180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  9221b2819b8a

--- l/drivers/input/misc/yealink.c
+++ y/drivers/input/misc/yealink.c
@@ -436,7 +436,7 @@ static void urb_irq_callback(struct urb
 
 	yealink_do_idle_tasks(yld);
 
-	if (!yld->shutdown) {
+	if (!yld->shutdown && status != -EPROTO) {
 		ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
 		if (ret && ret != -EPERM)
 			dev_err(&yld->intf->dev,
@@ -458,13 +458,13 @@ static void urb_ctl_callback(struct urb
 	case CMD_KEYPRESS:
 	case CMD_SCANCODE:
 		/* ask for a response */
-		if (!yld->shutdown)
+		if (!yld->shutdown && status != -EPROTO)
 			ret = usb_submit_urb(yld->urb_irq, GFP_ATOMIC);
 		break;
 	default:
 		/* send new command */
 		yealink_do_idle_tasks(yld);
-		if (!yld->shutdown)
+		if (!yld->shutdown && status != -EPROTO)
 			ret = usb_submit_urb(yld->urb_ctl, GFP_ATOMIC);
 		break;
 	}
--

