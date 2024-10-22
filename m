Return-Path: <linux-kernel+bounces-376119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987B49AA054
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78971C20D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C73E19AD93;
	Tue, 22 Oct 2024 10:47:01 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB241957E7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729594021; cv=none; b=WhU8WtHKNAJbtSq/kgrU4ZOAbwqoqE/KrgAFgIMVNP07r4TakxoXz7+qfxwAHiMRxFwm81aEH2rBLASyfXFLmbM4BDMqmvoRBvK0uH7y0sILQI7fw0ioN9gq6xoN+q2fbhMpd5GvMFm8gfUeXNzW81jFAMV/iCV3jd5cjBLTXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729594021; c=relaxed/simple;
	bh=jzq0HxQBYaaRd7ybL15hd4e78mW9KxaQynaZjeF088w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kmfl4sXg1AanqUWlHfRfaa6VRpmCpqwC+1F4WIb0Pvyb/dq/7Ix2YCeFkYABN1jSi+zD3bQip+E+ziWfEoqFcV6UpGnGgZbrnVCyxg/k01EeXM31PMVB9orsCFFIIR1vp0ON2O8Iw6LI99IxmC7+57jS36bdVn8WM3GHPigCwcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.205])
	by sina.com (10.185.250.24) with ESMTP
	id 6717829300002E8B; Tue, 22 Oct 2024 18:46:47 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 14791810748597
X-SMAIL-UIID: F2832798B11445609D10B86AA394F071-20241022-184647-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
Date: Tue, 22 Oct 2024 18:46:35 +0800
Message-Id: <20241022104635.2252-1-hdanton@sina.com>
In-Reply-To: <6709234e.050a0220.3e960.0011.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 11 Oct 2024 06:08:30 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    4a9fe2a8ac53 dt-bindings: usb: dwc3-imx8mp: add compatible..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1312c327980000

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git   v6.12-rc3

--- x/drivers/usb/gadget/udc/dummy_hcd.c
+++ y/drivers/usb/gadget/udc/dummy_hcd.c
@@ -1303,7 +1303,7 @@ static int dummy_urb_enqueue(
 		urb->error_count = 1;		/* mark as a new urb */
 
 	/* kick the scheduler, it'll do the rest */
-	if (!hrtimer_active(&dum_hcd->timer))
+	if (!hrtimer_is_queued(&dum_hcd->timer))
 		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
 				HRTIMER_MODE_REL_SOFT);
 
--

