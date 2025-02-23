Return-Path: <linux-kernel+bounces-527607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D452A40D3E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 08:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1DA37AC18A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 07:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81281FC0F7;
	Sun, 23 Feb 2025 07:31:09 +0000 (UTC)
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E530010A3E
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740295869; cv=none; b=J6YBVGHZDwtgSk3+dljy6hgp+P27rvTiyszctV31O9IkdojauWUiO146Mk1nyR3vniFXxGC+oWIDaBaP6uaOQ58Raw2aDNi/qTAUsMQSKmWcU5Cbwrlb3yNe1ndebpzNve3jsAnTVj+/YdWrtfQXpmWeW/55gvF18+yeznFP07Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740295869; c=relaxed/simple;
	bh=O0Xre8m/woFzloFs2iQiIx8kdrwFMbU0HJ8trqXGK6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePCNeDvHE7kg9XPu2XB7W9ypd9jtsFU3I6aQr5oc1+by7xvcBlhL6XBftSn4RMBOWc0bLqcYWaOJG9I943mbrfc7QrdLl+Rb2Z7NUd+pXcdQ4xlZIecNhKaUbOVg0mWwUa8xcqI33sUVmAikqjZ9xeCJi+VVBB0+gtYxZj04NOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.60])
	by sina.com (10.185.250.23) with ESMTP
	id 67BACE8800003278; Sun, 23 Feb 2025 15:30:19 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9713598913362
X-SMAIL-UIID: EA549A2A5C5245E28990863166DB3DE7-20250223-153019-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
Date: Sun, 23 Feb 2025 15:29:57 +0800
Message-ID: <20250223073007.2673-1-hdanton@sina.com>
In-Reply-To: <67ba02e3.050a0220.14d86d.065b.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 22 Feb 2025 09:01:23 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    0a86e49acfbb dt-bindings: usb: samsung,exynos-dwc3 Add exy..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c02ba4580000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/drivers/hid/hid-steam.c
+++ y/drivers/hid/hid-steam.c
@@ -618,6 +618,8 @@ static void steam_input_close(struct inp
 	unsigned long flags;
 	bool set_lizard_mode;
 
+	if (dev->going_away)
+		return;
 	if (!(steam->quirks & STEAM_QUIRK_DECK)) {
 		spin_lock_irqsave(&steam->lock, flags);
 		set_lizard_mode = !steam->client_opened && lizard_mode;
@@ -1086,6 +1088,11 @@ static void steam_work_unregister_cb(str
 	connected = steam->connected;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
+	if (opened) {
+		steam_sensors_unregister(steam);
+		steam_input_unregister(steam);
+		opened = false;
+	}
 	if (connected) {
 		if (opened) {
 			steam_sensors_unregister(steam);
--

