Return-Path: <linux-kernel+bounces-555827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AA4A5BD3E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92FFC1753DB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3500A232792;
	Tue, 11 Mar 2025 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5ipPmTL"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD15A42065
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687674; cv=none; b=uMZ6p5s5bQ4UXMqJbSt9Wsk+mZlLoQspwaJx80TCJiqJabX88z7llQRBXIdLqU7Vjetd3SKuItzpTj1gH4zy8KQrD4utTMfjyz2GyhxyS3M6EhBHYZ0Dim2VCVwnXreJvJnRL4L1nehpu0msgbM+b629+IFbBjbYu3CYiNp+dXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687674; c=relaxed/simple;
	bh=xGFRszwbX0EpzbA+wtyC3HJY64P/mPWKGUJW7Fm4z6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ndfFhD3+faGXUt4tsBeZtct+h6bplUfu80Iyh/RGvudUfOFP3JhT32ONmssqVe7tfEoEZ8SS6R9V7m9otT/TJQ3oDwScluy97Gr7wvL9qpD6gbGMIyWVtnVRrYn3cFzzeaKP24uDHBjvbbmv9dMHRH+yuCIPHG3aWi6CJwEr4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5ipPmTL; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2239c066347so91583415ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 03:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741687672; x=1742292472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jR2AEl9XzIa7+EBYQ4qofWGILaHfK0Tvb5r5mukPd7o=;
        b=T5ipPmTL42NHsJuHjlBHCQCpOTltet3HDDKRqHF1DKzhxyuWMjZiotCVa/iWl5ZjRe
         1OQeGjBCqStxAu4qNzzJ0r/dbz/Ddl/p3KQKdsDzlhNP7i3aWOhlnLvoqfN7NL4gxQ6l
         Oo0B4fLPOrWWrjRFyp2wz6laHzeTLL8XiCXXYc4SJnxkdj46Sm0rlf3CUlUaq0M3ruDT
         lSe95yCb6m1v6fwqrq9q8BaVuuDnQjH6sIi67t5nIxqMtTviduWrVexKSYyCbf4W9Lzy
         DjkOT6CnXedR2ZDBzGEG7TXYmqLsPXhBjXA/YAkuG3lYB2Nb1RkwOfvsilXg90poSfkn
         L/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741687672; x=1742292472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jR2AEl9XzIa7+EBYQ4qofWGILaHfK0Tvb5r5mukPd7o=;
        b=fN9L/Mj0l6FqKbrIIv5nzw2IlKiFc1TTIRsv37WmGuj7J1KH6LvPwmNAddRkDy36j4
         QY1Vqsz44NcMEE+RgDmKXI9L4VpBBUNdNr19d9zyo63hP9bsUS8oWRahQp3B5N1EZG88
         uOCMZ2AL26YzuT5JG53LHjyPUQ69dNp1prcqmauBXFBiO+fx90X1M810XlSiSxnSfsxI
         +aKeXAxoGCTVr+PNh2S7SQwg1WeYVLk8wROPAKZdtoqw829r/8+CdZlahpFiK/tGONiw
         vJe2L955RQUWESSSJzq8T2r47INxKLAH3tNRtgFObdAALI+Hq/zY8qvqGYCKwL7F5ls0
         aSzA==
X-Forwarded-Encrypted: i=1; AJvYcCXFcBlUvT9VNvDwnGNvbJEIkUnhUCu8PQI5KHxLYEr9P4mvLxLU75KFcP5CrTeMq9/zjVfHSflQ1usKX8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw05G6v9L7bgOJ3FIymyDpFFbmBGVptPcOHA3TMjpjSpoWG7+cR
	P5e25A7ok8YGeq/0duI6B1JhcxK/XROQ049xOiN00I8/QuqduJQjGD7xTZ28
X-Gm-Gg: ASbGncsLofYkCNp3r5drRIP49roevxI9SS44FhiZqvPDmDtz+4k6J6qNBVqqXrAc/F+
	lQFQFB7eWQgOTbg5udLjd3DYGmad7voG5jyOlQFAmIEoXbmfAjsaqd/YwE3uxT4ktEU6MVkOvjC
	8pY/t0AtDiKQV098t4Nfp1E/danrW4PXGo+ZrocXE+rahY709CpFSPKVom2XNYZZg3tQkQnC9WG
	yOnWNmGAUVjqyRDC/77GsO1uT0rTqIXQS8VA4XCXas9sldzpM+hCbwKjhF2D1TyXouwQ4oVfWxX
	KvKXyIub1swpiBzu90V/MGntw1ilBI82Fi7z9ODA0G/V2vf7UA2zj/EuTwadh/vvsgF6Jb56hA=
	=
X-Google-Smtp-Source: AGHT+IGS7KcnPb8+TJyAnPHto01gvbCAUx9HULK68QLGEhW0OfBfPMFYsEKvGDjOFVUJjGXe2hheAQ==
X-Received: by 2002:a17:902:e802:b0:223:44dc:3f36 with SMTP id d9443c01a7336-22428c0f1c9mr260153265ad.43.1741687671722;
        Tue, 11 Mar 2025 03:07:51 -0700 (PDT)
Received: from sid-Inspiron-15-3525.. ([106.222.230.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a918f0sm93869765ad.168.2025.03.11.03.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 03:07:51 -0700 (PDT)
From: Siddarth G <siddarthsgml@gmail.com>
To: gregkh@linuxfoundation.org,
	abbotti@mev.co.uk,
	hsweeten@visionengravers.com
Cc: skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	ruffalolavoisier@gmail.com,
	colin.i.king@gmail.com,
	n.zhandarovich@fintech.ru,
	Siddarth G <siddarthsgml@gmail.com>
Subject: [PATCH v2] staging: comedi: remove redundant filename references in headers
Date: Tue, 11 Mar 2025 15:37:41 +0530
Message-ID: <20250311100741.11999-1-siddarthsgml@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch.pl reports the following warning in COMEDI subsystem files:
  WARNING: It's generally not useful to have the filename in the file
These file headers contain redundant filename references (e.g., "* comedi_buf.c"
in comedi_buf.c) which are unnecessary.
This patch removes these references from 14 files to comply with kernel coding
standards and eliminate the warnings.

Signed-off-by: Siddarth G <siddarthsgml@gmail.com>
---
Changes in v2:
-Included the exact checkpatch.pl warning in the commit message for clarity.
---
 drivers/comedi/comedi_buf.c                          | 1 -
 drivers/comedi/comedi_fops.c                         | 1 -
 drivers/comedi/comedi_pci.c                          | 1 -
 drivers/comedi/comedi_pcmcia.c                       | 1 -
 drivers/comedi/comedi_usb.c                          | 1 -
 drivers/comedi/drivers.c                             | 1 -
 drivers/comedi/drivers/ni_routing/ni_device_routes.c | 1 -
 drivers/comedi/drivers/ni_routing/ni_device_routes.h | 1 -
 drivers/comedi/drivers/ni_routing/ni_route_values.c  | 1 -
 drivers/comedi/drivers/ni_routing/ni_route_values.h  | 1 -
 drivers/comedi/drivers/tests/comedi_example_test.c   | 1 -
 drivers/comedi/drivers/tests/ni_routes_test.c        | 1 -
 drivers/comedi/drivers/tests/unittest.h              | 1 -
 drivers/comedi/range.c                               | 1 -
 14 files changed, 14 deletions(-)

diff --git a/drivers/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
index 393966c09740..6597b25c0fc4 100644
--- a/drivers/comedi/comedi_buf.c
+++ b/drivers/comedi/comedi_buf.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * comedi_buf.c
  *
  * COMEDI - Linux Control and Measurement Device Interface
  * Copyright (C) 1997-2000 David A. Schleef <ds@schleef.org>
diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index b9df9b19d4bd..80afb683a2d1 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * comedi/comedi_fops.c
  * comedi kernel module
  *
  * COMEDI - Linux Control and Measurement Device Interface
diff --git a/drivers/comedi/comedi_pci.c b/drivers/comedi/comedi_pci.c
index cc2581902195..c664c6d6eb7e 100644
--- a/drivers/comedi/comedi_pci.c
+++ b/drivers/comedi/comedi_pci.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * comedi_pci.c
  * Comedi PCI driver specific functions.
  *
  * COMEDI - Linux Control and Measurement Device Interface
diff --git a/drivers/comedi/comedi_pcmcia.c b/drivers/comedi/comedi_pcmcia.c
index c53aad0fc2ce..2a7ba645af88 100644
--- a/drivers/comedi/comedi_pcmcia.c
+++ b/drivers/comedi/comedi_pcmcia.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * comedi_pcmcia.c
  * Comedi PCMCIA driver specific functions.
  *
  * COMEDI - Linux Control and Measurement Device Interface
diff --git a/drivers/comedi/comedi_usb.c b/drivers/comedi/comedi_usb.c
index d11ea148ebf8..fd38b4cfb4b4 100644
--- a/drivers/comedi/comedi_usb.c
+++ b/drivers/comedi/comedi_usb.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * comedi_usb.c
  * Comedi USB driver specific functions.
  *
  * COMEDI - Linux Control and Measurement Device Interface
diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
index 376130bfba8a..050c7417e273 100644
--- a/drivers/comedi/drivers.c
+++ b/drivers/comedi/drivers.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- *  module/drivers.c
  *  functions for manipulating drivers
  *
  *  COMEDI - Linux Control and Measurement Device Interface
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes.c b/drivers/comedi/drivers/ni_routing/ni_device_routes.c
index 58654c2b12d6..f68bbc3f6761 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- *  comedi/drivers/ni_routing/ni_device_routes.c
  *  List of valid routes for specific NI boards.
  *
  *  COMEDI - Linux Control and Measurement Device Interface
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes.h b/drivers/comedi/drivers/ni_routing/ni_device_routes.h
index 09e4e172c659..460f840f7600 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes.h
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes.h
@@ -1,6 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- *  comedi/drivers/ni_routing/ni_device_routes.c
  *  List of valid routes for specific NI boards.
  *
  *  COMEDI - Linux Control and Measurement Device Interface
diff --git a/drivers/comedi/drivers/ni_routing/ni_route_values.c b/drivers/comedi/drivers/ni_routing/ni_route_values.c
index 54a740b39819..dbf8c99ea922 100644
--- a/drivers/comedi/drivers/ni_routing/ni_route_values.c
+++ b/drivers/comedi/drivers/ni_routing/ni_route_values.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- *  comedi/drivers/ni_routing/ni_route_values.c
  *  Route information for NI boards.
  *
  *  COMEDI - Linux Control and Measurement Device Interface
diff --git a/drivers/comedi/drivers/ni_routing/ni_route_values.h b/drivers/comedi/drivers/ni_routing/ni_route_values.h
index 80880083ea41..70e245fdd403 100644
--- a/drivers/comedi/drivers/ni_routing/ni_route_values.h
+++ b/drivers/comedi/drivers/ni_routing/ni_route_values.h
@@ -1,6 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- *  comedi/drivers/ni_routing/ni_route_values.h
  *  Route information for NI boards.
  *
  *  COMEDI - Linux Control and Measurement Device Interface
diff --git a/drivers/comedi/drivers/tests/comedi_example_test.c b/drivers/comedi/drivers/tests/comedi_example_test.c
index 81d074bcdea5..dfb00b60f0c9 100644
--- a/drivers/comedi/drivers/tests/comedi_example_test.c
+++ b/drivers/comedi/drivers/tests/comedi_example_test.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- *  comedi/drivers/tests/comedi_example_test.c
  *  Example set of unit tests.
  *
  *  COMEDI - Linux Control and Measurement Device Interface
diff --git a/drivers/comedi/drivers/tests/ni_routes_test.c b/drivers/comedi/drivers/tests/ni_routes_test.c
index 652362486ff6..afeb7f85347d 100644
--- a/drivers/comedi/drivers/tests/ni_routes_test.c
+++ b/drivers/comedi/drivers/tests/ni_routes_test.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- *  comedi/drivers/tests/ni_routes_test.c
  *  Unit tests for NI routes (ni_routes.c module).
  *
  *  COMEDI - Linux Control and Measurement Device Interface
diff --git a/drivers/comedi/drivers/tests/unittest.h b/drivers/comedi/drivers/tests/unittest.h
index b0b34e058aad..87716ef0ea45 100644
--- a/drivers/comedi/drivers/tests/unittest.h
+++ b/drivers/comedi/drivers/tests/unittest.h
@@ -1,6 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- *  comedi/drivers/tests/unittest.h
  *  Simple framework for unittests for comedi drivers.
  *
  *  COMEDI - Linux Control and Measurement Device Interface
diff --git a/drivers/comedi/range.c b/drivers/comedi/range.c
index 8f43cf88d784..d006402146c4 100644
--- a/drivers/comedi/range.c
+++ b/drivers/comedi/range.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * comedi/range.c
  * comedi routines for voltage ranges
  *
  * COMEDI - Linux Control and Measurement Device Interface
-- 
2.43.0


