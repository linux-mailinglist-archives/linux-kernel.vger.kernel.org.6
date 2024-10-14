Return-Path: <linux-kernel+bounces-364124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E1D99CB64
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0EE281F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A261ABED8;
	Mon, 14 Oct 2024 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhrdtaqV"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5995A1ABEB4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911676; cv=none; b=aJqF4MZqcbJNVz6/q1tfgV9I5Uj7TKDHc5xqVzKVv6JyWbvvtuqZho9Np62s5224Xh8Ahkhm9uZGahmzgmbbB2CH/6oOGym8y539zhh9pbUsewW38zYvcPI0hkye4grO8qApmkVIHmaJ4EPCg/RASKXXyVoF/eaUNItVtlh2ZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911676; c=relaxed/simple;
	bh=3AI3XhXvRGcP/N5oxZ4NF2AZexCtH/3/RLDrW+YPt24=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OzerBN/5nySdj8aMGsHn+tg8z7y8cpkLLdgQHFuFuOMqwlcBh8n77chcdXZe92hB+GzPSG+oL9RbT9KGKV7/GRxfPZpjUlTCQM+iVldg5u67c0ftdfUYM2jMqWSKUOlQXnXZjNfScqCy1sIKqBVFXRO0igL+BVBTouJ+0HCyk1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhrdtaqV; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b1205e0e03so186462985a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728911674; x=1729516474; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZoT5PblpjMSYAGgJ9Q4ES+Ig5qmcNlUIU6W5cu9hZ4=;
        b=dhrdtaqV9J3CL/WI6QQes8WbwwblCggESWt9wlJC53w2481kSoofb2dLl5xlaCwW2b
         WGoODz4qdKQcCggYjB5NGXuwrGeAoF7iXAV0yg4tZ8z0WwBV4cjtjy/d5XgaJqz7KR5D
         xVK9lkvEQwPPHB1ILwxDrl86ZKi/yv6f4zK/LZxi1dXfuNZXNRp/jNJoVPOwOmoO1aqd
         gLncehrjJtiC1/OTDUPSIslDHSAfQeab0WxmHZsGQF4tJgyNqcRb2jnpgug1RhnY6dJw
         QhNUF44kuw4rB8YcQ5LBDEFW/KI0uj+2yfB2f4TO4mFLf1p/8W04oxiRjyve/urZ5kmK
         IJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728911674; x=1729516474;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZoT5PblpjMSYAGgJ9Q4ES+Ig5qmcNlUIU6W5cu9hZ4=;
        b=a2+dkqC10g7uTKFc4+EAWN1WzR1q1kx/4milVYZ+NOEmr0wECAoxTepXA2V2I3W3X4
         rUhDYLx1nWa78UWMyzUhc/1mpzTapuuZk3Z2Xxo4cbQI1OeBz6C2mUSW/VO3wBt7DIIY
         Z1Q1w2SSF8+gfqXDVRYYRyTWC5rXy5v583LucJR3kPaLRXJwQOrUO4hAj+/qXiBWqA3T
         9puXCmiFvMt1kz5inNZglTq8VbZ4KorHqGDzrO2QQ1invn3TnSRZdUqnSpN3DMcq5BLy
         9DbYlR+CJMFvALxZqFwX3kd22w9H88uNSfr7/2uxGy2Eh1Z5WsxqI1r3M6tSFqiGFBce
         OY9w==
X-Gm-Message-State: AOJu0Yz+Q+Nk9QquHXo2oET9kqLx0rU6siG21RPtulU7jtyIT07mAU6l
	sz50sWnpWYrUDZKJhsNFXg6TBN8VLXmSNz805S8cQ55qdQ+6Eb0Ft4maCWof
X-Google-Smtp-Source: AGHT+IHsiRcvZ7SKufp4ei3jPGJnjeed4QvsNN31zu1bjPVkj/2AgD617s19iXz37Ou6N57ameBPuQ==
X-Received: by 2002:a05:620a:4454:b0:7ab:ec86:c91f with SMTP id af79cd13be357-7b11a37feb6mr2062194885a.36.1728911673712;
        Mon, 14 Oct 2024 06:14:33 -0700 (PDT)
Received: from localhost.localdomain ([4.15.194.220])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1149562e0sm415730785a.91.2024.10.14.06.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:14:33 -0700 (PDT)
From: Vimal Agrawal <avimalin@gmail.com>
X-Google-Original-From: Vimal Agrawal <vimal.agrawal@sophos.com>
To: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	arnd@arndb.de
Cc: avimalin@gmail.com,
	vimal.agrawal@sophos.com
Subject: [PATCH] misc: misc_minor_alloc to allocate ids for all dynamic/misc dynamic minors
Date: Mon, 14 Oct 2024 13:14:16 +0000
Message-Id: <20241014131416.27324-1-vimal.agrawal@sophos.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

misc_minor_alloc was allocating id for minor only in case of
MISC_DYNAMIC_MINOR but misc_minor_free was always freeing ids
using ida_free causing a mismatch and following
warn:
> > WARNING: CPU: 0 PID: 159 at lib/idr.c:525 ida_free+0x3e0/0x41f
> > ida_free called for id=127 which is not allocated.
> > <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
...
> > [<60941eb4>] ida_free+0x3e0/0x41f
> > [<605ac993>] misc_minor_free+0x3e/0xbc
> > [<605acb82>] misc_deregister+0x171/0x1b3

misc_minor_alloc is changed to allocate id from ida for all dynamic/
misc dynamic minors

Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
---
 drivers/char/misc.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 541edc26ec89..fbe51e776c15 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -63,16 +63,28 @@ static DEFINE_MUTEX(misc_mtx);
 #define DYNAMIC_MINORS 128 /* like dynamic majors */
 static DEFINE_IDA(misc_minors_ida);
 
-static int misc_minor_alloc(void)
+static int misc_minor_alloc(int minor)
 {
 	int ret;
 
-	ret = ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
-	if (ret >= 0) {
-		ret = DYNAMIC_MINORS - ret - 1;
-	} else {
-		ret = ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MINOR + 1,
+	if (minor == MISC_DYNAMIC_MINOR) {
+		/* allocate free id */
+		ret = ida_alloc_max(&misc_minors_ida, DYNAMIC_MINORS - 1, GFP_KERNEL);
+		if (ret >= 0) {
+			ret = DYNAMIC_MINORS - ret - 1;
+		} else {
+			ret = ida_alloc_range(&misc_minors_ida, MISC_DYNAMIC_MINOR + 1,
 				      MINORMASK, GFP_KERNEL);
+		}
+	} else {
+		/* specific minor, check if it is in dynamic or misc dynamic range  */
+		if (minor < DYNAMIC_MINORS) {
+			minor = DYNAMIC_MINORS - minor - 1;
+			ret = ida_alloc_range(&misc_minors_ida, minor, minor, GFP_KERNEL);
+		}
+
+		if (minor > MISC_DYNAMIC_MINOR)
+			ret = ida_alloc_range(&misc_minors_ida, minor, minor, GFP_KERNEL);
 	}
 	return ret;
 }
@@ -219,7 +231,7 @@ int misc_register(struct miscdevice *misc)
 	mutex_lock(&misc_mtx);
 
 	if (is_dynamic) {
-		int i = misc_minor_alloc();
+		int i = misc_minor_alloc(misc->minor);
 
 		if (i < 0) {
 			err = -EBUSY;
@@ -228,6 +240,7 @@ int misc_register(struct miscdevice *misc)
 		misc->minor = i;
 	} else {
 		struct miscdevice *c;
+		int i;
 
 		list_for_each_entry(c, &misc_list, list) {
 			if (c->minor == misc->minor) {
@@ -235,6 +248,12 @@ int misc_register(struct miscdevice *misc)
 				goto out;
 			}
 		}
+
+		i = misc_minor_alloc(misc->minor);
+		if (i < 0) {
+			err = -EBUSY;
+			goto out;
+		}
 	}
 
 	dev = MKDEV(MISC_MAJOR, misc->minor);
-- 
2.17.1


