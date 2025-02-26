Return-Path: <linux-kernel+bounces-534668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBF3A469BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B970C3AB223
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B92022257B;
	Wed, 26 Feb 2025 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD9exBNr"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A419597F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594503; cv=none; b=Cfwr9U9MRfphzqoshcQWi4oETYRUMxFJPLsVSBJ4IIZ+YYA2cRPzbf5gphcFJMZkQBLEwLLErxX2YxmVFyDXiaAa+oT+ZQBt0y9KQCoxiOz+SFk22YF/egYFIT7Gs9OY2mQfYe3kczBx2uVG/uJbQthbeQKZ+5xGONQ58cylN/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594503; c=relaxed/simple;
	bh=9tJSryV3UIix0A0318dVjz1+cy/T3SG8xsS9e9fiHHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XM7YnmTX2QxvZd8cgyIksk2IJTpQTNWEgRWZ6xOYzAmG2MS5mUvOJP/UtxV4cVyhgjlZmLrF1imcxBOk0QC/q/L1dw0dD9Agdh1cjscW+UjAMX8egFoVoIVVMUwUO+ywdkRwSyF0xO9uHSWugBUtL9ingScHD/0zPLuDm9OpMrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iD9exBNr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220c92c857aso2925655ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740594501; x=1741199301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jKEXMcX2vydQl8yKGxLj6o83FrSjnokZ56LmF36tpZQ=;
        b=iD9exBNrqXX6Wjr8a/IfKN7uULPmpNz2S5k9kMQJJ8jmkVErKrGMKmNNzWgHzJ+kPM
         COf0mNbIK5ZT5iI/jXz1VjmzVzFJ7h9lFmkyU/bH/kp7dqqfQXWoHeSkqhdzh23+ObVo
         S0aB+e6/faPZpWSnbuuojHZzpOobMY/s7VmyRq79nMOOtfLbr4vEb2AhE73JMdUt+uhW
         U7al21SY9g4rjZGSFciqBM2uJMujEPNExhWSSqIjjCeXMlLnYGjvmE7aha5pXR7qBF9w
         zt6u9kFvUVxXoHhoA0znf5QNJ5mU7ROrwOl7CZAKIREZuqGXcj517g81yjpE0u1vB7M8
         aQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740594501; x=1741199301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKEXMcX2vydQl8yKGxLj6o83FrSjnokZ56LmF36tpZQ=;
        b=mB6GZ/tfW/bZqj2Bzii5gldiNPWtCmTc2qYn4FM8I8Iz/iuw627UXB0Cf2SzCE9mXV
         9c54VcryeoV4LvFnuPSf8e/eOY9tkNpKdmvsjCR8b25GNxI5U69cZFTCWUUF7zUbuhOP
         hCY0qUTYrZa/2tvps0A8IhVX7YOR8Ewl/IuPoGGItEGQAM+Qnn4lxRckTX88o17tGVWL
         YJMxW7LAW52xK1VcSWMLpSj2z8oNup76mQB9tO95oGiNmUnfZNQ2VKyhVHQAe2V0I41C
         R9mt+G3DXWCYawnWUcSshWM0TsrbKq1dMcf9CeuzBTtKZFaCTEhkvauCEI8oKp6JaurU
         E2iA==
X-Forwarded-Encrypted: i=1; AJvYcCWsD+KFVCJNOCMFltTzX+2Egj5Sz0KwyjGtlm484E3gBTQ/dJSnDPLtxrraONg9Ic8vI5OK5QeZ9O9vzbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhahyL6+/xmHh+XlCFtUW4TqgpSqSISGx6fzHIs7fxR10obOI
	y4QnznkqLgoKFYZrBKfJgfmPj4VZ5yMEGyrJlgZ6AyGc07AZbEo3iXs/0Ni4
X-Gm-Gg: ASbGnctGB0E03Tv0MRYGQ3i/Ogw9f2ozo1TvHXi+P48p3fUIZTInffLx5NEIcao7FTT
	N0SF8Es9yKuIsCncMzjKTrtpCPQBKYIXSMadUQGt5M97wd+3VgMyHvz5BqZOYa9mm7vsYOcK58o
	yokb23Q5JlanwR/b6cGvcVj8iZymFamM+7zJ5bh2zfCKmZkeVUP9G2RWIPeGajUAwelfDklEWnN
	OBOewZUWoomtiO6Slp4ulIw0FidXwKUhmBYHWG38fQTYr6qTh/mFSFo85rtUdsND77Pn22TNsMf
	XU7or3ohUH+9eRohByH0EMGtDl/ayz7VmBepvYX5yNL/qE7TCo8/
X-Google-Smtp-Source: AGHT+IFWBxzBAY5PMojlcke9devpD3Go8axTjlzmDjzhL79jsCphy2n0lTirLrKLsEIErC2ofUnoFw==
X-Received: by 2002:a17:902:d504:b0:21f:6dcf:fd2b with SMTP id d9443c01a7336-2234a15e3a9mr5976705ad.1.1740594501327;
        Wed, 26 Feb 2025 10:28:21 -0800 (PST)
Received: from ideapad.tail50fddd.ts.net ([139.5.199.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6ada86sm3849296b3a.30.2025.02.26.10.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:28:20 -0800 (PST)
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Subject: [PATCH] drivers/base: fix iterator cleanup in attribute_container
Date: Wed, 26 Feb 2025 23:57:52 +0530
Message-ID: <20250226182753.257559-1-ayaanmirzabaig85@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses a long-standing FIXME in
dirvers/base/attribute_container.c, where the function
failed to call klist_iter_exit() before breaking
out of the loop when a matching class device was found.

The code is now refactored to use a goto-based cleanup approach
that ensure klist_iter_exit() is invoked exactly once regardless
of the exit path.

In addition, checkpatch.pl warnings were fixed along with this change.

Tested on a minimal Debian System in QEMU with GDB attached.
No regressions or errors were observed.

Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
---
 drivers/base/attribute_container.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/base/attribute_container.c b/drivers/base/attribute_container.c
index b6f941a6ab69..1e7af328dd49 100644
--- a/drivers/base/attribute_container.c
+++ b/drivers/base/attribute_container.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2005 - James Bottomley <James.Bottomley@steeleye.com>
  *
  * The basic idea here is to enable a device to be attached to an
- * aritrary numer of classes without having to allocate storage for them.
+ * aritrary number of classes without having to allocate storage for them.
  * Instead, the contained classes select the devices they need to attach
  * to via a matching function.
  */
@@ -21,7 +21,8 @@
 #include "base.h"
 
 /* This is a private structure used to tie the classdev and the
- * container .. it should never be visible outside this file */
+ * container .. it should never be visible outside this file
+ */
 struct internal_container {
 	struct klist_node node;
 	struct attribute_container *cont;
@@ -42,7 +43,6 @@ static void internal_container_klist_put(struct klist_node *n)
 	put_device(&ic->classdev);
 }
 
-
 /**
  * attribute_container_classdev_to_container - given a classdev, return the container
  *
@@ -449,7 +449,7 @@ attribute_container_remove_attrs(struct device *classdev)
 
 	if (cont->grp) {
 		sysfs_remove_group(&classdev->kobj, cont->grp);
-		return ;
+		return;
 	}
 
 	for (i = 0; attrs[i]; i++)
@@ -491,12 +491,11 @@ attribute_container_find_class_device(struct attribute_container *cont,
 	klist_for_each_entry(ic, &cont->containers, node, &iter) {
 		if (ic->classdev.parent == dev) {
 			cdev = &ic->classdev;
-			/* FIXME: must exit iterator then break */
-			klist_iter_exit(&iter);
-			break;
+			goto out;
 		}
 	}
-
+out:
+	klist_iter_exit(&iter);
 	return cdev;
 }
 EXPORT_SYMBOL_GPL(attribute_container_find_class_device);
-- 
2.47.1


