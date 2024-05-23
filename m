Return-Path: <linux-kernel+bounces-187627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A030F8CD583
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB84280CB3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BD414A62D;
	Thu, 23 May 2024 14:17:33 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B378062B
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716473853; cv=none; b=cT++KfZa6zQkhLyjIoUFrPYHBuokBBbQrYoixtHmjjsoNtgzIenHp5coajxjtYCuigjbo/sBoUg6Z0Alz4w2zel8rb2EKbSwOgsSN3IrlXkxSmWOg1UntwyzEOVJxS2dykuHVjQNA7s7viEGN5sHiWZ/nhueqZbHi4/BU4DydXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716473853; c=relaxed/simple;
	bh=ZSR6n2pEadnCfEBNysFFl/udTlGkNqXpW+x5Iov/XaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ws1YZiDi6gZjk5XkXwwXa7Udnu3rrSf7QvBKJ6mi9GU5JDfrFP+a39300QvIz/ARE7DCPcGdhSTB3Miv7SZrxSwY0HYc5E+Bj8Y7YNVBntMKyJujK/SN6hHPeQKAnqjDblILmjI6q+KQesHg+lSsUS9EJohoNylm3Woh7CkqVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 23 May
 2024 17:17:19 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 23 May
 2024 17:17:18 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [usb?] UBSAN: array-index-out-of-bounds in usbhid_parse
Date: Thu, 23 May 2024 07:17:07 -0700
Message-ID: <20240523141707.25170-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <000000000000d330500607d85a5f@google.com>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
---
 drivers/hid/usbhid/hid-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index a90ed2ceae84..f38a4bd3a20e 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1020,6 +1020,9 @@ static int usbhid_parse(struct hid_device *hid)
 	num_descriptors = min_t(int, hdesc->bNumDescriptors,
 	       (hdesc->bLength - offset) / sizeof(struct hid_class_descriptor));
 
+	if (num_descriptors > ARRAY_SIZE(hdesc->desc))
+		num_descriptors = ARRAY_SIZE(hdesc->desc);
+
 	for (n = 0; n < num_descriptors; n++)
 		if (hdesc->desc[n].bDescriptorType == HID_DT_REPORT)
 			rsize = le16_to_cpu(hdesc->desc[n].wDescriptorLength);

