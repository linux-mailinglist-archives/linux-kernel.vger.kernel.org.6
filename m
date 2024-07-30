Return-Path: <linux-kernel+bounces-266742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9309A940624
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53393282A80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F624156F30;
	Tue, 30 Jul 2024 03:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA3UnL4w"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9DC153BF7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722311960; cv=none; b=QYwtwL4Wtlx7TxlGtp/haE29JPGql61uHwIYQ5ygla+x2e1y1enM1oHX9Sr1xLIYtbY9TlO9Sq7nptt+ugxtkihsNAt+RICyzyKj1C3Sda9jbaylaKPz2rIW+5eEpawCUBhEbxioVcOgPhf/GgL54PURCbiyqADtfTazCViPfEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722311960; c=relaxed/simple;
	bh=EJ74EgXAdrv4f0ptwEhi5vT5qQ6kaeobLRmzQZgd7eU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NdfMPfE6W75fQ87z4g+KV1eEy8qtzomzElvZEG4jb1BiYrIJY1Rq4+fFM/hkYoyBohKe5xzUPhJsHR6o4vv+dHjCCmWqoVJtSmqUsiGAz/aB0+TzH3GRnVXPPmTs/cTf3SB7Er2jnpmhojY9VmjzmuirThL8vC0LXCO/awLbTY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA3UnL4w; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70ef732ff95so801587b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722311959; x=1722916759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O4rM+bIVkBiFMj0+QrsxL/UaeSimCk/iNeJl7ovFQ5o=;
        b=YA3UnL4wFws/Xix2vmo+pUDCn7b+gtaZcn5rP1NcgV4SxSRovXWoDxJ3OWj/HqMrY0
         hxiGLL8ZmayUJrwhJtBHtIcwTbpxOgL87XjHWT+OcDwIXqoTPAOU/9xEKhkH724SdXJS
         Qj1GbjDcIoLYs+m3EzRa+8B3sWg3WxcwKUKDaFAF8oEhQpm9MC8QvPmY9oLXSXLF1MlS
         OXwNYjCl+ReBKax+auhsTH7Co2zO7tNvjYLzcvvRMVAWRI1Ccb2cOwOb4I6WxDYAHcZJ
         hM+Du2TQfO705SWpyWMPn+3seij5nTT83m4WHnMpxHD4EHMNHmVUaD5CETbJqpTSA/2P
         cVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722311959; x=1722916759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4rM+bIVkBiFMj0+QrsxL/UaeSimCk/iNeJl7ovFQ5o=;
        b=odFazKW4ojHwuJdUUqaR6jRq1qkmwTRWm2ObRN8EzueYJZJOZBaPplGfas2+ZpaK3W
         F4pqRSEa7z6BONqeeK7k+A69u72KROL32xd+fqbYuugr4lDQPyr0Fu7zAYruJ5xbOzCP
         ecKMVdrUqIKJ8V4wwY4orrgmz40mijuKk1Itz3UpGcQliUCMZcXxHy2eqs4PEsUtdiHf
         KuZ2siw3dmXRb00KgGT4J9vpMrMBxTxbME1GyfaBNQXzOylJ0CKeGO4SsVRvmz+Q5sP0
         hZyn9Apdty1BoqiYjnE4hrNsR0PygqwiOm4cOdOs1D09ZuoAqeT2dh9ogv/fQgMg3UwV
         wVmw==
X-Forwarded-Encrypted: i=1; AJvYcCUNinW/M0vU5YcNRwRSggDkd+TScGIHM1RnvSFns9tfoTIdYsDfFlCjdAbaB0lxTyUt4qR0FZbMCN+t8wb/BNkXEL4mh2WiixwQjhqo
X-Gm-Message-State: AOJu0Yy6x+6xeK+wSerUOFi2sqxHxs/w5bNViQBMnwCVltoyYIZq4/EH
	8sx8bRl4DXSPKja0cOYPNBD6jC3ztHxDDCUUxL1WBvsmGuFLNgkRX6u82Jt5
X-Google-Smtp-Source: AGHT+IE8vqC8TX8et/xwYCNINzqfFvTWOuy7JOFVoDKdUKw8WtRHtDvOZXOIyWyipBMo0Y+faHIoag==
X-Received: by 2002:a05:6a00:b45:b0:704:32dc:c4e4 with SMTP id d2e1a72fcca58-70ecea0147bmr8327447b3a.1.1722311958574;
        Mon, 29 Jul 2024 20:59:18 -0700 (PDT)
Received: from localhost.localdomain ([190.196.134.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead712282sm7545736b3a.48.2024.07.29.20.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 20:59:17 -0700 (PDT)
From: Camila Alvarez <cam.alvarez.i@gmail.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Christian Gromm <christian.gromm@microchip.com>
Cc: syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Camila Alvarez <cam.alvarez.i@gmail.com>,
	syzbot+916742d5d24f6c254761@syzkaller.appspotmail.com
Subject: [PATCH] usb: fix slab-use-after-free Read in hdm_disconnect
Date: Mon, 29 Jul 2024 23:57:46 -0400
Message-Id: <20240730035745.110637-1-cam.alvarez.i@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All references on the device were lost when deregistering the interface.
To make sure the device is not released before freeing all the memory we
add get_device to increase the ref count by one.

Reported-by: syzbot+916742d5d24f6c254761@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=916742d5d24f6c254761
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


