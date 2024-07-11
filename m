Return-Path: <linux-kernel+bounces-248844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A12492E29E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C11C1C22871
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647F0152789;
	Thu, 11 Jul 2024 08:43:31 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8185C78283;
	Thu, 11 Jul 2024 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687411; cv=none; b=oO23ncdJcgnxD5nlAnkmRb3aDYI15XcCh2yVSOGwuYYjlD2SDY2zm1J1kxu6woxg+W4lQfzXZxxurvg5pwp9aF0EvkU+I5TCnt1KEU9mFax3hKzW3vNrETb8u+L3Qw1KekB+htYwasL0kAB8cVjynq21wzHsDzihcER/lFJei2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687411; c=relaxed/simple;
	bh=3Ih/lm7QXJqZDZmmBWIqjoo6KPLaLwCxI6zVQJrKHtw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JL+bkqT4CTn184rdKJkYpv/7mhs/cQorDXx/locTJW7BdL3NGjt8SVx0omTXJFsHax3xMTPOGzxdoU2XEN9s8fK0SPVsTK/I3aENMeYQlf75SiguZpxSwJaoRhn+3SCkLY3McnwTQ4nwq9DIWPgOd8FYHVSt+lSjShv1gO0+WTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70af2b1a35aso515925b3a.1;
        Thu, 11 Jul 2024 01:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720687408; x=1721292208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcSuUAbudwUQC1/YmfPyNbFicLu/cAqT4mx6S8tQT58=;
        b=J9fp9CpQdhQU7h7f5bby4Mn2ymXXKxjdIvOlna4McrGhTkkrXw9tlfUmntEgEQHNR3
         VkKyWjB3sNcqGtN6csMkrfwtZ83eDBgD3CSuvJ939kMHnwROsrFky+tDNuFXn05Ju7h8
         kvdd7UuUU6aOuIqVXKW5xIX8vrNk+RmZzlIoW5KO2MMLuKl+8Wtow9tzyrWI1o+yDNwN
         w/8FT6cmLXeU/c8TTnRlp32Kn+ymlKqDRS9mgkSAdzz8gzzblKNvyCNxqiaBUOdNDSlB
         r8H+Prja7TmWxm3Kk6AP9JMJ65weJU62+9GoymlmCr1oPQIJ77k+hM2NSaMVlyixvgmY
         uziA==
X-Forwarded-Encrypted: i=1; AJvYcCU7UXkIZYRW8GXCjzw7XEqfWowfCNCm5Z3EUVY+jLtWar3Yqr3kjGVfV8uglkXfgJs9PlZIk76dK3ESWXgtnCxjLI2Zn51TS5ALxA0eV4Z20GhjkdkTusrY1h1ujIEw61w2waF613Tg
X-Gm-Message-State: AOJu0Yzbexa+TKCQvhVGmgHb8B8yK5ncixAR5g42hEUPYvpILI0c66/t
	WOnzLPd4WBOZz+oIB/b3gSAdrs7eAZ95OaTj+p2QHFwAMwc7LvnZGPbg2Mkqd0Cu2A==
X-Google-Smtp-Source: AGHT+IFNTCeBwYnSATF4CAYjcNXdYzI8De3Rb96vSVzVauhm7s+zeJIwmav9SvADkWgl7Vhg2kgE1A==
X-Received: by 2002:a05:6a00:4650:b0:706:6248:93e with SMTP id d2e1a72fcca58-70b43522345mr9062405b3a.1.1720687407610;
        Thu, 11 Jul 2024 01:43:27 -0700 (PDT)
Received: from js-pc.. ([2408:8453:10:1e58:b448:78db:2fd2:8dd3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43984adcsm5103591b3a.162.2024.07.11.01.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:43:27 -0700 (PDT)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: gregkh@linuxfoundation.org
Cc: brauner@kernel.org,
	jlayton@kernel.org,
	xiehongyu1@kylinos.cn,
	jack@suse.cz,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH next] usb: usbfs: Add reset_resume for usbfs
Date: Thu, 11 Jul 2024 16:43:21 +0800
Message-Id: <20240711084321.44916-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During hibernation, usb_resume_interface will set needs_binding to 1 if
the usb_driver has no reset_resume implimentation. The USB interface
will be rebind after usb_resume_complete.

Normally, that's fine. But if a USB interface has a matched kernel
driver, and a userspace driver or application is using this USB
interface through usbfs during hibernation, usbfs will be
detatched with the USB interface after resume. And this USB interface
will be bind with a kernel driver instead of usbfs.

So add reset_resume to fix this.

Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---
 drivers/usb/core/devio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 3beb6a862e80..8c07df104c9a 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -746,6 +746,11 @@ static int driver_resume(struct usb_interface *intf)
 	return 0;
 }
 
+static int driver_reset_resume(struct usb_interface *intf)
+{
+	return 0;
+}
+
 #ifdef CONFIG_PM
 /* The following routines apply to the entire device, not interfaces */
 void usbfs_notify_suspend(struct usb_device *udev)
@@ -773,6 +778,7 @@ struct usb_driver usbfs_driver = {
 	.disconnect =	driver_disconnect,
 	.suspend =	driver_suspend,
 	.resume =	driver_resume,
+	.reset_resume =	driver_reset_resume,
 	.supports_autosuspend = 1,
 };
 
-- 
2.34.1


