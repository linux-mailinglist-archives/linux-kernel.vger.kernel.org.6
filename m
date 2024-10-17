Return-Path: <linux-kernel+bounces-370003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FE59A2593
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD78A284C52
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E301DE89A;
	Thu, 17 Oct 2024 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmkIhPHu"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E9B1DE3B8
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176706; cv=none; b=lhkf2pUHJE4rWZG5sodj08veQVe8t7LyLGEJcowXwFbKw2JTjjPXOyc5e3TiiOWlXN3nUt5Dr0QvaS+Zt7CWQbQH6G9FWFsfgMpZ6zd4nutWfWEbsxkvUeB9arYqGjPV3YgThsyZYCyG91BCHZ+C6ME4spY8tAp0OGGI7O7LyLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176706; c=relaxed/simple;
	bh=EuhtQH5bex7/i0COwlqxw03mixVVhAkIYmn265ypFEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fsbA5cXEXtMK688B8f9oWIwHzfuwbpPjWc+ZAbkjDdB8XBnmsg41Vod86L5IMM3yiDACjyirnFo8clFxBbptVexnDEOeF3Q654+M2yaDBXrNpg3DzkDAp8gZqLSBq1Pg/jrLT6t5s+qt7wxxRnGW7BLMi7YMCB4RoVvmgfO/arY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmkIhPHu; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2eb9dde40so834377a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729176705; x=1729781505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MGAXgC7FfrdTSppqbnulVF8CdRAJ5Pma8ywisvco0CA=;
        b=fmkIhPHu/f4u5qlQrwZEwWjr3+mZxBUMVK4+0I+Ix5qrYaXbdtJxl7CD1ceG5p3IQc
         7dd9yy8RTFfUZe817GymVbqKfz8/AiFBX3U4qKQ4mRbfA1wlvj5TLYMNykNfKksifzDa
         1vt1wfvSZ8nsro2tARUqRmGTjQk3Zzswcl20EHImnGcOMRP8GL6upu3wxAV5RpKQImuH
         LDMvH8zKvD0+0s2zFLkxa5nBXttvR6qSf9OM4ZKans+L/AYxEbttkbj2LV9JXHzNXgRE
         x2yN07t53BuS2XuqRiEjK3fxQPXVzDmbDU673Jg1KIwqhgqNXhw9Otj7V7Sq3k2iV67c
         rKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729176705; x=1729781505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGAXgC7FfrdTSppqbnulVF8CdRAJ5Pma8ywisvco0CA=;
        b=qfVIJcUYtHNe/6N//Vu8xUeQF+PNY9t8mwn28lXiQVL/VnkiRHpUqMOkJD6MuFVvz6
         uEr3BZNHxB1GFvJF+UgqKQ+NF0Z0+RK+vOA6vhPT7loPD5oVVLokRSRvS6JgBxgvfNRb
         4dGwI55Nxdv3p7EKWaUfGKoQFCx4BR+cxFnFu0JSOAjeb5t5nLPx65LzviST2rAYS9yW
         R69Jj4KHvT2VuGhtu6BV4FAmdM8hyv+uDOvoNCsxUDpsKSg6U1hJCpdgZ6nm8CjOk9vO
         SwXOB7vR0SGnAkqGkK7C8M4jhLj7YP72mOwNKxIvDHTpRZ8VmKvjhcGTT0VyMajVYnd+
         y89g==
X-Forwarded-Encrypted: i=1; AJvYcCWvCXWFbAyG5Ep4qZwCb++againkpIjoRAH50G1KVxsru0Bv7qmhwNk88FSsLEGx8UlGK0EXv9xr+N0jdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE6dZelCQI30L/g1HcMaz/4kyvfR4FwOQz5DFnDpVeKIw1D94e
	+CNhF91uo9T+VhgDBBlDzK+KMo0iY73ZWjFN0r8lEdIhCnIP1zgh
X-Google-Smtp-Source: AGHT+IFhstisOgB5ENTbIo7OsmYiTc+/emFeQDDHfpKn0UhVxc9aXoSyDuh5MufuBK+/z4SaNzTbkw==
X-Received: by 2002:a17:90b:4c8c:b0:2e0:b65b:6b4d with SMTP id 98e67ed59e1d1-2e2f0dfe7b1mr21726981a91.41.1729176704837;
        Thu, 17 Oct 2024 07:51:44 -0700 (PDT)
Received: from ernestox.hitronhub.home ([2407:4d00:3c04:81a0:a609:723d:8a7:5889])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e3e094be93sm2009196a91.57.2024.10.17.07.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 07:51:44 -0700 (PDT)
From: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
To: 
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	ricardo@marliere.net,
	skhan@linuxfoundation.org,
	0xff07@gmail.com,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] misc: rtsx: list supported models in Kconfig help
Date: Thu, 17 Oct 2024 22:47:38 +0800
Message-ID: <20241017144747.15966-1-0xff07@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rts5228, rts5261, rts5264 are supported by the rtsx_pci driver, but
they are not mentioned in the Kconfig help when the code was added.
List those models in the Kconfig help accordingly.

Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
---
 drivers/misc/cardreader/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cardreader/Kconfig b/drivers/misc/cardreader/Kconfig
index 022322dfb36e..a70700f0e592 100644
--- a/drivers/misc/cardreader/Kconfig
+++ b/drivers/misc/cardreader/Kconfig
@@ -16,7 +16,8 @@ config MISC_RTSX_PCI
 	select MFD_CORE
 	help
 	  This supports for Realtek PCI-Express card reader including rts5209,
-	  rts5227, rts522A, rts5229, rts5249, rts524A, rts525A, rtl8411, rts5260.
+	  rts5227, rts5228, rts522A, rts5229, rts5249, rts524A, rts525A, rtl8411,
+	  rts5260, rts5261, rts5264.
 	  Realtek card readers support access to many types of memory cards,
 	  such as Memory Stick, Memory Stick Pro, Secure Digital and
 	  MultiMediaCard.
-- 
2.43.0


