Return-Path: <linux-kernel+bounces-350292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE5B9902F7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C8A281805
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9421415B541;
	Fri,  4 Oct 2024 12:34:13 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA2A18E1F;
	Fri,  4 Oct 2024 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045253; cv=none; b=ZDIEjeEyEbOR7zW03aJXfqUC91GP/HEH8yUUAN/G6ZMCEmUres9oE6RyTVJJis/RBdQloJIUhlnGpEZ/ZGlpMgGsO7EHubM1eEkptZyQ2qG/bVc1jOKyA9d/HKY+2ARvewcOfzba0dG6XmwpVIPMDzeRGincwplzOTGxW3qqowM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045253; c=relaxed/simple;
	bh=7hBWKtz6dWTnpx3jUstRvRIZEdeM1cAM8quInGLhZbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNyJmuqUxdKirh0HoyzvoJYcgC5GPLdQ1dxZDtsnRCrNpMnUTRUSll0XU+3QOT26r64iYwp7W2ZHSWQpswMkpyMKdIeOqyorWsisKm/S+RhcTsVu653uMjy3FU/BD/gCE2NBdJBbYV3zqjcPK3DMeuawxySnxTfE4tHww0r+3cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cddc969daso3176305e9.1;
        Fri, 04 Oct 2024 05:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728045250; x=1728650050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5wiS6PT3uog3ZWz/ePudKvC7BQwH5spP07b0l64QsQ=;
        b=Rfxd0SFSmelg8nPK49u77ekFdauddGbGJRNDHup22rfhB83xYV9h9EFsxeMlO/j2WI
         YUr9rkdPHE8+m10ahE/GP/EqiqYT+j+mzEvzropS2Z+Mnl0kQfGgDKl/me0V7BuPMyiS
         LXx4pIRdskGOfbLIvEHySGIiNdPTwVhFk7889x+YNExBq8XFZikmgoiimwzXGk53ybwM
         8PTX3nKeY5ECNGPtpTwu1FiBXO5YOFUvxfNNd23GEp3+tFWo4FmDBF68ju18NxeFYXyj
         yfJw9GU2s02OI61CFu1KbIGnFUGgmh9kuti7lE1exblXCuKetGXMe3gfTFSIEoPvlIJI
         1KNw==
X-Forwarded-Encrypted: i=1; AJvYcCXGIJE4zKMniDaZmrINuM5TOipGM/MNdz6FUV8Uj5OOVd6PuiMLpvFCTUA3mJFng5QEeOqfGLXSGw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh6DWKqTFbmtdOuTdzhn5r+FDm0e2IPXRI9V50/CIh7NVAyZT4
	5Jy5xHBj9lsPT1HpBf11loaLopkdM1TfH454rSlUeiAS0m8UDpTV
X-Google-Smtp-Source: AGHT+IFHiCsbuqVP82pI02OCb9kK9RQKqQ6ecj8M5e8Z5YEv6QH7VP2hR7GxJVU+0jhS8narvT8f9Q==
X-Received: by 2002:a05:600c:511b:b0:42c:aeee:e604 with SMTP id 5b1f17b1804b1-42f85af5be7mr8856795e9.8.1728045249711;
        Fri, 04 Oct 2024 05:34:09 -0700 (PDT)
Received: from tahuti.c.googlers.com.com (232.38.195.35.bc.googleusercontent.com. [35.195.38.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a205absm14628875e9.19.2024.10.04.05.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 05:34:09 -0700 (PDT)
From: Pimyn@web.codeaurora.org, Girgis@web.codeaurora.org,
	bemenboshra2001@gmail.com
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	nogikh@google.com,
	glider@google.com,
	dvyukov@google.com,
	elver@google.com,
	pimyn@google.com,
	syzbot+8f282cce71948071c335@syzkaller.appspotmail.com,
	Pimyn Girgis <bemenboshra2001@gmail.com>
Subject: [PATCH] usb: usbtmc: initialize memory written to device
Date: Fri,  4 Oct 2024 12:33:13 +0000
Message-ID: <20241004123313.2463701-1-bemenboshra2001@gmail.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid kernel-usb-infoleak by initializing all memory written to device.
The buffer length uses 32bit alignment which might cause some buffer
data to be read without any initialization.

Reported-by: syzbot+8f282cce71948071c335@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/0000000000006f6622061eb52dba@google.com/T/
Signed-off-by: Pimyn Girgis <bemenboshra2001@gmail.com> (Google)
---
 drivers/usb/class/usbtmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index ffc9c6fdd7e1..d79a08dfb54d 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -21,6 +21,7 @@
 #include <linux/usb.h>
 #include <linux/compat.h>
 #include <linux/usb/tmc.h>
+#include <linux/string.h>
 
 /* Increment API VERSION when changing tmc.h with new flags or ioctls
  * or when changing a significant behavior of the driver.
@@ -1169,6 +1170,8 @@ static ssize_t usbtmc_generic_write(struct usbtmc_file_data *file_data,
 		 * (size + 3 & ~3) rounds up and simplifies user code
 		 */
 		aligned = (this_part + 3) & ~3;
+		/* Initialize the remaining part of the buffer */
+		memzero_explicit(buffer + this_part, aligned - this_part);
 		dev_dbg(dev, "write(size:%u align:%u done:%u)\n",
 			(unsigned int)this_part,
 			(unsigned int)aligned,
-- 
2.47.0.rc0.187.ge670bccf7e-goog


