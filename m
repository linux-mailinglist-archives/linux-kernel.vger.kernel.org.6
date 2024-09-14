Return-Path: <linux-kernel+bounces-329594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6F5979353
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 22:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6581C2107D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 20:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94098129A78;
	Sat, 14 Sep 2024 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO6as4Lw"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47BD433BB
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726345954; cv=none; b=mCKqzuClsYt6XWQvCQTW/43WXfIv4ELTTBrG85NPZQSrd3kcqH+OUys1VUvoW9QkKf2qfVWOWXtZrSOQrEuYfEVB6k8GNF5BPcsf9JsiZzznsrr5xAEd7MCukle3qGSXCQItfGWUG4UIxYA6ShUx4tmtpXwRorbSbRTy3MayQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726345954; c=relaxed/simple;
	bh=F3IiwGIlOBcsHPpCUg0PYbzsHuC7Wa9ijM+/bgB4CMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ceeLhTnu250eiMaMKqOhaEod8Rc33AW0zdoY9ETx97h5GgaFQ6Fd6M0c31dxACsYW6T2TIVV/bDCoCyGq/jcZgpD1cstXYgdhNL4xZ/qFTvyom12B7G84sLS3MfQ/jOfwUmJHQ1jnDocwvZk3dHLGp49OpUKp5XHrTVe9AFgbug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO6as4Lw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-207397d1000so32626855ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 13:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726345950; x=1726950750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdKV1HEUhnJOzOUSDTkMKFHQ0OWb2jLH54eu+r9ySoM=;
        b=TO6as4LwigvR3gEWHOiUxhjh1h9TNw9vxBd4FhfRgqhRHGYdglLLzmg9u58LORcLBV
         8w0vxDjeGjrIDshZJcNw8MQWbbPfNMo/uN3vrUoQRs6GpF19QBGoXu7oIao8bHNgz32m
         Oi9cSqvQRkZVTeQ2Rqtb24IlzqeI3/kx2pPXHVIv0mrkF+FrSHtrefS7CfuTxqdhl/gq
         pP3wdWnTenpumfnutDxYiYmbIY67q8aoE6q292GMmmMge9wHCYd88YVOBIlc5TFMFMoZ
         hI2RsokXZUQ/GEIRqs0j/DiWXE6czdn3Itl5pHAfn3UiiozDdRk4w3H4XsKdrIanoCUN
         FXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726345950; x=1726950750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdKV1HEUhnJOzOUSDTkMKFHQ0OWb2jLH54eu+r9ySoM=;
        b=mHt77El/TISmoNJZl4ltF/yvc3r6JS8UGdyOWpSuxqQV28he4OQ2xfAulo+lCZ0XFO
         JLgJWECRRRDyXHNBAWspG80ay+Xy+bugrqdjkeOcR/Htsi3OjNxAKgSllQDz0YZ5JINd
         fYyzpJ8n3bYP4Y2uYPRyhydb5uAK3486oRgqTgFhwdpIwmOf9Rg+NpShHtzXbOiBKCLD
         +2d3KDkTAwdjQBS6wyVomZyUa1TlUpAEIfoaq6sWIeJp0caej8a4DPTRbsGCX0h9r+kB
         NRmPQPaM+JHuw141MKv7CNEChiDgl0bjpXMVjk0reM1ndsJdBxdefQVeF0lcwzF6H6En
         Cfwg==
X-Gm-Message-State: AOJu0YwC95Fn3CQVD2qvOKUn9YLzlXgpbommN+1WrN3aFpDgTdYH6r85
	OyvsPKTNmPdiCoJlcEVvOH+lm5ybTiuuGW9dDel9YiGIgIWNde70
X-Google-Smtp-Source: AGHT+IE1lA37ZVqupKEOTVaPbMVLYxIHYlm8EZ0ya+mHOr2CVKWmUD7Y+KF+KSASaQCL4BKwjyZQdg==
X-Received: by 2002:a17:903:41c9:b0:1fd:6033:f94e with SMTP id d9443c01a7336-2076e61ddabmr184752265ad.27.1726345950277;
        Sat, 14 Sep 2024 13:32:30 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945da9f3sm12866805ad.23.2024.09.14.13.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 13:32:30 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KMSAN: kernel-infoleak in iowarrior_read
Date: Sun, 15 Sep 2024 05:32:26 +0900
Message-Id: <20240914203226.99700-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000001fdbd80621e28ae3@google.com>
References: <0000000000001fdbd80621e28ae3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/usb/misc/iowarrior.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 6d28467ce352..c36eb831e3db 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -182,12 +182,6 @@ static void iowarrior_callback(struct urb *urb)
 	    && (dev->interface->cur_altsetting->desc.bInterfaceNumber == 0)) {
 		/* + 1 for serial number */
 		offset = aux_idx * (dev->report_size + 1);
-		if (!memcmp
-		    (dev->read_queue + offset, urb->transfer_buffer,
-		     dev->report_size)) {
-			/* equal values on interface 0 will be ignored */
-			goto exit;
-		}
 	}
 
 	/* aux_idx become next intr_idx */
--

