Return-Path: <linux-kernel+bounces-344910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 076C798AF9F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CAF3B20F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0150B188000;
	Mon, 30 Sep 2024 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCsofAK0"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DCA170A22
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734037; cv=none; b=NBZ79Z3O2HXgDVlsS6qGLl/8PQMe9toZWi4d5hr9kVNEn9SGGpUSRSLNZPZ5jzyCPqkT+pI1v4B7d8mdPYxcKhoa7ILBpUjwkt8BIMIoxxrTY1z++eau9y96Y4JQwvm1QRs71bpVd0Pu9TkaWzOK1wOiY/NWNwwDe8HK0u3sajQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734037; c=relaxed/simple;
	bh=WpnDnASCV+Gtw8rk9RmrIK+C1V8UQl4cVbmyHFUq3rc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MaqM3qqx7r2gz4dRFPhqy6JOMWfodeNrc8EUXlI6iUbwDR1E+/z3ZEuptVpVeyHxGiLXYZMsGB9t4jdNRj7f8ve7pyAEMspI+wBKWyaw1E3ljQQfudVae1hIVloroOV/g0EkwAfwJlCVRpNIgZD+HntALvv/mpbD8TBnZMGF7HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCsofAK0; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8a7dddd2aaso53737166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727734034; x=1728338834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6wBKkpzL7p8O08s7/xl4OXiKllt1Q/5qfedldVbtkzM=;
        b=WCsofAK0uBm4faiQ7sBSHlddDyEYpjLhVVg5cCrPWXWAsa40bANV7v5kU22mIdUb3/
         B8hQavlNKdTpVEDCZbovM4DSwLjmtT0eXNMk0S7uzQAwCLempgshQFkjBT7waSee+7FA
         MnxRsKNZ985YewPlhXWwhIwdSbHj476BdPUtFAX9OMwvH27E/YzhsGaa01ZorJgkGjpy
         m7en3x2zjY5n3Ae9Hl5i/E1L1+QxIzOJMf1pQrr9qziJLPrkrGYxjljd6nSwr+bO9LEt
         Mh3uS3/BhGbeFN/c/SSdDitbg8Qib2bk61ypWuuP2Qto07DZNzEFNkmmSpyEoLU4Y/xt
         g6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727734034; x=1728338834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6wBKkpzL7p8O08s7/xl4OXiKllt1Q/5qfedldVbtkzM=;
        b=fICHlwKzZl3fFtpzXRQJZVJVabD47GqBbTVDpvQBPzT9VXPgwXA/CK8JXZTP5L8P+k
         w0XDy9kGEDiEk0UfGKHlQfk63uM9aA7+oZvZzBvfEc6KHz2N1JTrvjfeu56V77GaAY7l
         bcK1PIahrXqn3MbjRRlh5v6wKjUCGzPNisZF0efUNteLLmq2xP3UrDOlthlQ83oAVaMN
         hPgoG4r7gSrQVECeZuUua6+n102pCRTWANcG3p04F8s51l0IKZoVeaUaiLU+CvUDoip9
         EpmzOlVGLu4TtvHs/Z3GSI4a4Czp3oFOsWLj+KCoOpieQ93vpFoVb1BwknKxwD99AScn
         Fepw==
X-Gm-Message-State: AOJu0Yxdk8GTTXubXxpbILmYF09PQc0MA6fh7xxh1OiKNnvtukORNg1y
	LJsXX5xY5y7kN9BMHrE37ndJSz5ZfeH/Vwxo2kWaUTrgpJdNrmOw
X-Google-Smtp-Source: AGHT+IF0cHXMEqLzl9bb+Kj5JyVMOePGoh05LJ7+huIURUyeK1zPRKuC45ZFJ+tmqCUBGp+cJHR1NA==
X-Received: by 2002:a17:907:2cc5:b0:a86:7179:849e with SMTP id a640c23a62f3a-a93d84e4131mr460888666b.0.1727734033783;
        Mon, 30 Sep 2024 15:07:13 -0700 (PDT)
Received: from localhost.localdomain ([78.190.121.160])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c277726asm605050466b.10.2024.09.30.15.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:07:13 -0700 (PDT)
From: Okan Tumuklu <okantumukluu@gmail.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Okan=20T=C3=BCm=C3=BCkl=C3=BC?= <117488504+Okan-tumuklu@users.noreply.github.com>
Subject: [PATCH] Update core.c
Date: Tue,  1 Oct 2024 01:06:49 +0300
Message-Id: <20240930220649.6954-1-okantumukluu@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Okan Tümüklü <117488504+Okan-tumuklu@users.noreply.github.com>

1:The control flow was simplified by using else if statements instead of goto structure.

2:Error conditions are handled more clearly.

3:The device_unlock call at the end of the function is guaranteed in all cases.
---
 net/nfc/core.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/net/nfc/core.c b/net/nfc/core.c
index e58dc6405054..4e8f01145c37 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -40,27 +40,19 @@ int nfc_fw_download(struct nfc_dev *dev, const char *firmware_name)
 
 	if (dev->shutting_down) {
 		rc = -ENODEV;
-		goto error;
-	}
-
-	if (dev->dev_up) {
+	}else if (dev->dev_up) {
 		rc = -EBUSY;
-		goto error;
-	}
-
-	if (!dev->ops->fw_download) {
+	}else if (!dev->ops->fw_download) {
 		rc = -EOPNOTSUPP;
-		goto error;
-	}
-
-	dev->fw_download_in_progress = true;
-	rc = dev->ops->fw_download(dev, firmware_name);
-	if (rc)
-		dev->fw_download_in_progress = false;
+	}else{
+		dev->fw_download_in_progress = true;
+		rc = dev->ops->fw_download(dev, firmware_name);
+		if (rc)
+			dev->fw_download_in_progress = false;
+		}
 
-error:
-	device_unlock(&dev->dev);
-	return rc;
+		device_unlock(&dev->dev);
+		return rc;
 }
 
 /**
-- 
2.39.5


