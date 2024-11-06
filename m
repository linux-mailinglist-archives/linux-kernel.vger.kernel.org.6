Return-Path: <linux-kernel+bounces-398730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BFC9BF542
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91DB1B24185
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A9A208234;
	Wed,  6 Nov 2024 18:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpITMdZi"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D386B36D;
	Wed,  6 Nov 2024 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730917846; cv=none; b=fVr8Q+5kM0pqHh8PZ5OU9+ijqF7VkCbbtdRhZofJaRPqzIVDzxphcDkgrMVocfaQVOfmhEgvWia+prFLftQjPAV0fN/hhPeXspHUwiCfgtUJHUDsfX1JOOVxpoZgHZrutF8MnNE2BbQ1l04ONfsr0TCMO4tvWo7VPg/yRmau9eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730917846; c=relaxed/simple;
	bh=30AuDX1Mh0CsEAAlI7vPkUgHlaRbfrD6TmxgS0EWW/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=thCPc/PsjE623G+iE3HbOLMWA7wHT+seUx956jsKHcNMzEMn1BVnQa/SEcIbbDAnKK+uE2IQGD4rOsOeeyaDFaWT6dWHP/BRAsRXqrAnG8zTybyWdsJtuLNkJ5BrjBGpRCONDG/qkY8Pd767tqWBuZpKiFHa1J1uLha+7i40b7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpITMdZi; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ceccffadfdso40507a12.2;
        Wed, 06 Nov 2024 10:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730917843; x=1731522643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4jQjAPZSMk3c5EOUW4fuy8zkDO9GQcwiVzIg0XH4OH4=;
        b=KpITMdZin8n8Ug1Y8BDixQESyBfV0sMAjtLwyoQ1+aiOrVjnuej1WNbBtUt67/I4zl
         836dnz3P7sm1EMG6z3tlBleDh+oI1isNJSPVrIBdUihD3QhKYVUyRk85qr6uKPRvt89P
         Nwut8tMArhi7FFj+rgE9HgWOSxqGf9Oq2+n4fW2+gdUrMIrXocAeVoKpIqOYPpFhvZS/
         7Y5C+fJw2ZkrnkoA7hGA8kwBQn1RIhCU48ifLf73iUj186sEnxFeuMIauEJ9ziZ3o85F
         NtsxmeJdpPQ5BAlJdUlL1KeLwf1r0YX2j2gnhFAOG8BhAN8R7dfNhKp6vAPSP64I/Sfc
         LCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730917843; x=1731522643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jQjAPZSMk3c5EOUW4fuy8zkDO9GQcwiVzIg0XH4OH4=;
        b=TccoGuXpR+YnmqWZgvZ6I4FxIjr7rB+apRapvq86eeKcRqqtm2AZQICQMMJZD+T16e
         CzivWVmbcMW6M+F+hNXD+xGL7bSQdrZR5bCaDw2wD6QQ5N5gFgvCx4ZnK+idA8rKLc4q
         G+D5vbzjUrEbxUawTEIYO5jF5uAkXYhLRLB4t6WJ3P9OKTtDu7mlEqsko6OJ0zlI5X+G
         NHhUEmQ1mYHBt2F45LX4k6sNHwNAik29V1bJzsu9cYrLsMLOG0oqFT6DVq6xFb48Ff2G
         qsEM25nfatvqxN2B5TMaAJUaV9+dAJArJwiAAlps8SC4KyOVIaJrB7QILb7a88Vy4A5z
         9qWA==
X-Forwarded-Encrypted: i=1; AJvYcCVerZyY7umrDzyilJ3Isz9xIrUbgp+/L5gceqYhxNrbZFQJrtbKgk4oEze/7TUmNAhcj4NiVoTYaqQWGgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyknu5SVDo0KAFEREZUXMwZQCzGiPaEvJzZrJiFjDd4VkjlGRrR
	wLbPzm0g4wCh0di0ZeeCy1JCOdtwjlsCL3O/Zkw2vS9vTLgFDicx
X-Google-Smtp-Source: AGHT+IGKEOlwyyanLQrWzfWXYnMuH7AyafClYqD6xch68uThhM29tx9Z1Uac8l2W0vN2AIXNSUaOBw==
X-Received: by 2002:a05:6402:26c4:b0:5ce:bb32:ca9b with SMTP id 4fb4d7f45d1cf-5cebb32cbd9mr15675866a12.21.1730917842851;
        Wed, 06 Nov 2024 10:30:42 -0800 (PST)
Received: from localhost.localdomain ([83.168.79.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6a9a3e3sm3070634a12.12.2024.11.06.10.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 10:30:42 -0800 (PST)
From: Karol Przybylski <karprzy7@gmail.com>
To: gregkh@linuxfoundation.org,
	paul@crapouillou.net,
	tudor.ambarus@linaro.org,
	Chris.Wulff@biamp.com,
	david.sands@biamp.com,
	viro@zeniv.linux.org.uk,
	m.grzeschik@pengutronix.de,
	peter@korsgaard.com,
	karprzy7@gmail.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH] usb: gadget: f_fs: remove unused values and add immediate returns
Date: Wed,  6 Nov 2024 19:30:32 +0100
Message-Id: <20241106183032.80155-1-karprzy7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of faulty copy_from_user call inside ffs_epfile_ioctl, error code is
saved in a variable. However, this variable is later overwritten in every possible
path, which overshadows initial assignment.

This patch fixes it by returning the error code immediately and exiting the function.

Error discovered in coverity scan - CID 1583682

Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
---
 drivers/usb/gadget/function/f_fs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 2920f8000bbd..00f52c9bb716 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1735,8 +1735,7 @@ static long ffs_epfile_ioctl(struct file *file, unsigned code,
 		int fd;
 
 		if (copy_from_user(&fd, (void __user *)value, sizeof(fd))) {
-			ret = -EFAULT;
-			break;
+			return -EFAULT;
 		}
 
 		return ffs_dmabuf_attach(file, fd);
@@ -1746,8 +1745,7 @@ static long ffs_epfile_ioctl(struct file *file, unsigned code,
 		int fd;
 
 		if (copy_from_user(&fd, (void __user *)value, sizeof(fd))) {
-			ret = -EFAULT;
-			break;
+			return -EFAULT;
 		}
 
 		return ffs_dmabuf_detach(file, fd);
@@ -1757,8 +1755,7 @@ static long ffs_epfile_ioctl(struct file *file, unsigned code,
 		struct usb_ffs_dmabuf_transfer_req req;
 
 		if (copy_from_user(&req, (void __user *)value, sizeof(req))) {
-			ret = -EFAULT;
-			break;
+			return -EFAULT;
 		}
 
 		return ffs_dmabuf_transfer(file, &req);
-- 
2.34.1


