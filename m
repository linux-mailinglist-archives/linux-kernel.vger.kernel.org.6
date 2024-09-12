Return-Path: <linux-kernel+bounces-326694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F942976BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A1C283B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D35A1AD266;
	Thu, 12 Sep 2024 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs1pBbww"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE2837703
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726150912; cv=none; b=YWYQftqXxcnwiUSUCw5GoTlQMSnL/xC5NyyQBq3z6lFIuUN9yqtFJYp6L+m5G2qk7JrDVzSU5DnueAa/hiQe0dAUY2KH1RDBekwPfarnHCzJx4hNoORfjuZQAb+sva/BWf9ZMG/tPeH5u7Lh8LnsMXcukEi7SN1Idr/TpjvNaog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726150912; c=relaxed/simple;
	bh=rTBjxx4+b47bGg3J26c2e8ga8lvm+9yDAmwyKU/aSMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K+O4riVxX9agn2fRYKZtzVmcpUj22FSpuMYkb5G3NSvYF1fjVw9OyMHHZagm6qPIpWk8MfQ564k9BpCGXbVDPxV4/4iNvYun5c1rUgPBKsaNDeuNTvuncP22HtmwylYDBoOuK1dxo5vThOf7Ubo8gD/aRFZ548lswf3bmNhIiVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs1pBbww; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2055f630934so9421045ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726150911; x=1726755711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHoSN/BsNMq662D8PdBz7Jtr+ZLuV1vua1ojJAG9E40=;
        b=Xs1pBbww6UFef/SmiAfcXa62XNNKTJnqK5rKGj2KrLBfn51ExqCF7B4sq5xrfYjtp5
         Ga3ohbcbPZvP7cQkBhuPxCSfNnySGPlNTjshBCBBTbClaLDF7cZX8R88TkUs17htqS9a
         cht2GBw53Oa05AyomxKgUQ2kx7cAo82eNxyqmXg7MvtlSQDuA9NPl1PmWFrrb9oOpO7q
         DFTDqXN3h+8IfxvLsOKmWpaTW+BELA/aq10X1g38wGuo2vtRboc9fU82fLMLkLi78r+B
         +st1H32fyKwFqw+laafNMdbGIavpbdCQuGu71rL4i/pO+bL3TlZdAO6voaRfMabySocp
         Q/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726150911; x=1726755711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHoSN/BsNMq662D8PdBz7Jtr+ZLuV1vua1ojJAG9E40=;
        b=BbV0db9TWGt00Gb59sKdmst55mOzYNBydh3GAQ+t/4NMCMbI9WaTG2HbilvxoLKL/T
         4kKulxwURZltMULoeGHPTKi6GTP6gZSsZacL6/bIPuKJCjuIg5UyMGZkbCHDSytiG3J2
         4C5XxKXh26gybknP1lKWkm6wv0NJUc0xCIr9vlycaWYb6Kis1siS+L6glLHqnRIi7opb
         ylMQt3JFE7daCImtj2KH8sQsVBadzLxL0l9q2Hc5ywcnlBfqoptNjK/2wap41Kn2ytyz
         gyG77bCtnP5htkIppNM5M2nd8b35Z7jfxXoFrchVtpdd8qjQurPQRN4B13VGiVWVKt24
         Gasw==
X-Forwarded-Encrypted: i=1; AJvYcCWdGEjL0GSXZSwabUl7dvXHIcTKQg6iqW/XEIk0kjnjuoSoF/vizlL7yv7UQyO2kut9Gpg2wI6//zmtjn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMKGNwcLMWlL1w6diQpbYzvjl9djC5kx4XSbdn/Ofy3a1/39Zb
	nK9tLiWM8HD4oWL7Yx3jHGHYhI8ggf55Uv6CgQpbELIoWbJM9jlx6HG70omM
X-Google-Smtp-Source: AGHT+IH/2qS0acz8kovhhNcC55Kfyaw0RfFLQ8g2cMlMNn4c8s6ExYbC9te9lczWpYtadWGUK7k0PA==
X-Received: by 2002:a17:902:f707:b0:201:e7c2:bd03 with SMTP id d9443c01a7336-2076e444167mr38963785ad.60.1726150910481;
        Thu, 12 Sep 2024 07:21:50 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af25678sm14828465ad.29.2024.09.12.07.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:21:50 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+b8080cbc8d286a5fa23a@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [usb?] KMSAN: kernel-infoleak in iowarrior_read
Date: Thu, 12 Sep 2024 23:21:45 +0900
Message-Id: <20240912142145.8418-1-aha310510@gmail.com>
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
 drivers/usb/misc/iowarrior.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 6d28467ce352..9b5acb312a02 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -833,7 +833,7 @@ static int iowarrior_probe(struct usb_interface *interface,
 			 dev->int_in_endpoint->bInterval);
 	/* create an internal buffer for interrupt data from the device */
 	dev->read_queue =
-	    kmalloc_array(dev->report_size + 1, MAX_INTERRUPT_BUFFER,
+	    kcalloc(dev->report_size + 1, MAX_INTERRUPT_BUFFER,
 			  GFP_KERNEL);
 	if (!dev->read_queue)
 		goto error;
--

