Return-Path: <linux-kernel+bounces-266707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B26B19405A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0C9282E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69032145B24;
	Tue, 30 Jul 2024 03:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE/TIY0b"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F55433C1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722308985; cv=none; b=DeFq61MuuForgEIIjhuF4F/kblWF3szX/BdpMOKrztShJCI96UajodQ6QQlVE7uZTrAzm4nN8ejFSbbhSSHAYORvgSttlTtXqCjnkqgF2xYZhQ9GJ40oLl4L6K7FQQ3OockHHQ3+k6DlUB+eSc98M9RZVb8PQvSwD+H8m3eFf+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722308985; c=relaxed/simple;
	bh=rbmTH/MVqhdntEaNz5qQp01MHYwN0bcFA2Ny4BFYcEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QpMSqIfX7QclWZPwuii51Drvy60tZ/wusPstpO8YyRGB5e99Dsj7hyuVaKVIZVI4g+kJgRCy8HffTkELyq6GpIRNFyV620euhJVtgY0T5o+mYFuA3Kwbff0W8I5JMaZte6WkkHoQBzN3Y5VyWtpKAVvU+I4WtSA/W4vlTYsJQ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cE/TIY0b; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70943b07c2cso1687264a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722308983; x=1722913783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6o/LSAsnPfKQgia5vbIjKijTxONit5l+FP4hTEMfTrI=;
        b=cE/TIY0bpQ24wXciQjG5tC4L9pf0G2ook7fOngh5X1MBd+NElI3ZKLAS7fuPmAHmhv
         tCTJXQyRGmkmdYM5t5mUV+GiIUHSZ+BqYYogBgRjOF4ysf7BF2zgSUvjJqXHGCLDCteQ
         wRybguwizRbzzahYrRMesiGASQ7zrgqQMsaC/1OERVqgIi9AtjSI0g5GNJyD+93+TshE
         c0lBko9wq2vzma3+EM4b7E7amsVlQJsMrOl2YS7QX3EnwOYBxsWmToUtOwEVXPydeLjy
         S/OP6nymwaf8jEUwT0gdLmgWh1snqKFnreAiJcdB/JhuR6vBVjHTPv4LxU3fgn0O8iik
         qqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722308983; x=1722913783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6o/LSAsnPfKQgia5vbIjKijTxONit5l+FP4hTEMfTrI=;
        b=id467kLjuwTPvpFemtpLY5y5Y/4FbE7ube7Wq1eauLsUPRTtFBzD78zAbsx/gGfd4f
         e1kk08owS8Rn0oAyIKa8+jT/fownPjvyexnA1ESGNxOlpuLUKhmwM2UGNiYMTqsBEVQL
         zveufq0dqcsahzCOSmSwDHgzP4eCIgJUzYNJI8iyvSNuLSoRlOmqOumJBVOhLzwwcv8J
         PbU6sSNoYof72AMN0dxPGnuG/WrjIsGTEtLV8o1OAO2n6xYFVIc3pEFP4OC6g950cleX
         +lI6t9nnFKttzxjxZ4XMb0RO5wg9jTqMlt4kc/YxP7HQlN6bpvUgzOexCgC0X9n8ifSS
         EPSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRxWuruVWTCeXKOVw5gJJAGVrmaueVO5Yi2EEjBfOVp2uas3c/3olqmGVHXNkAyjgnaj36QDkNRvJPaoJlYVxBdAQQtxJK9y5VO8WM
X-Gm-Message-State: AOJu0Yx+bkpOw1WneFUEiUn2exAg0IgiNocIaSL5D1rR1EMqIJgcHQso
	DrJZyFY0ybRBhkATpz+e4c7g2cNM3+oOFa4Z3qUbpFhW7mvR4AV0
X-Google-Smtp-Source: AGHT+IE7JmJrGduCxqsOlwg8TXr/phg1W24qan1v9DfhqFI2Guv3u6NYJBnwHK1M+4z8CZ0EnqZOKA==
X-Received: by 2002:a9d:7f11:0:b0:708:b2b0:bb0b with SMTP id 46e09a7af769-70940c12142mr9790307a34.10.1722308983213;
        Mon, 29 Jul 2024 20:09:43 -0700 (PDT)
Received: from localhost.localdomain ([190.196.134.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8146aesm7469899b3a.131.2024.07.29.20.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 20:09:42 -0700 (PDT)
From: Camila Alvarez <cam.alvarez.i@gmail.com>
To: syzbot+916742d5d24f6c254761@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Camila Alvarez <cam.alvarez.i@gmail.com>
Subject: [PATCH] usb: slab-use-after-free Read in hdm_disconnect
Date: Mon, 29 Jul 2024 23:07:58 -0400
Message-Id: <20240730030757.109700-1-cam.alvarez.i@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test
All references on the device were lost when deregistering the interface. To make sure the device is not released before freeing all the memory we add get_device to increase the ref count by one.

Reported-by: syzbot+916742d5d24f6c254761@syzkaller.appspotmail.com
Signed-off-by: Camila Alvarez <cam.alvarez.i@gmail.com>
---
 drivers/most/most_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index 485d5ca39951..e178a5a0d3aa 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -1120,6 +1120,7 @@ static void hdm_disconnect(struct usb_interface *interface)
 
 	if (mdev->dci)
 		device_unregister(&mdev->dci->dev);
+	get_device(&mdev->dev);
 	most_deregister_interface(&mdev->iface);
 
 	kfree(mdev->busy_urbs);
-- 
2.34.1


