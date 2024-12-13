Return-Path: <linux-kernel+bounces-444998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 046FF9F0FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B653518822DD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEE01E2312;
	Fri, 13 Dec 2024 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS5Ws4GE"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1BA1E1C3F;
	Fri, 13 Dec 2024 14:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101614; cv=none; b=qtCzwZFbYxOs8BsPXscAAnSIdH8iydaL3qeKzx+bMsFeq3cl6Xy81YRAJ1OdP89YOIgP0bmk8S3OcNDvIs3T7asJkfXJc/1zQ4KuPYr8+7Kd63Kq795LeeUEOYI8nd6Pyxf06GIOo7Myf6tkozUa/UaNq3lRHxSPzSRVqZzLJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101614; c=relaxed/simple;
	bh=FAgGAyUsAb8uwbMlCep8Nds8XOm7ZF3gyqO+MrgJyCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T3AsJIaxzeJimBvboSm0vcD9rpRS0x5elCVOznDt6gnUo4n2yj82gVc66ONp0iAOvEK06OXYBgIX448rZHFGCFbJlL3CT7OmQ1ErEIM262z3gh5kjZsDQRJCugJ+QTgGcnkx+2vLBePyE2Y439tyHMR3YY7Npu2X8r3QKunODEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PS5Ws4GE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-725f4623df7so1562797b3a.2;
        Fri, 13 Dec 2024 06:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734101613; x=1734706413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ffDh4cPP1MjSOsq6XwoiROkk/23YNkcWtvcfwJIn5M=;
        b=PS5Ws4GEXukf9fP13NiXu008GxK3wOQ8C4KKv4NCT1hTtbKeaNPxbo7A3ZieBx/p+D
         N3eCVgzUCsvQX7fiWUJk135SuhCJFoEUT+egUYP6QF356SJdVREVCr8/bFYICJLWSOOa
         Is3rvEs5EPqHIMuQqiO1nax3a6RO6oE5gS0AWZIakhO365hfQeyv+oQfCzy1dfpUIIK8
         zlpEWxCzbJYTPwxK+IebFQ5v1QzjEJQfX6rHiloqfB9PVwBCp8aM3EGmo6J5o2/3GxSd
         iAUNJ+4nlWx97q5x8FcnAeGacFtyNboJWraEO1RyDj/y+Y6mjSso4d206tzDEKdIKEk6
         Edkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101613; x=1734706413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ffDh4cPP1MjSOsq6XwoiROkk/23YNkcWtvcfwJIn5M=;
        b=ABMEPffYfw4onnBcQWNPq2W983GWvVVYwYi0w0dd6TjjRRBsBY5kBGt20njj+2qzwx
         j70Y/jP7BcqGPqOhbXW6DMNCY7pBYbDFtn0bY8/obiKGdck9ikIYTbrRQXYJhQlXDW5x
         3bA/Vx6BVSwHkjgLe5vE5aXMwTTorNbFcXcEuM1h8McLOqJeMUA8/7EAmtUJobV3Risl
         ywysrYtIBgVoStmVqD9rfoF4sopgvMX372kxb3301Q6/LUvjke2iOe7NiS31JqPMb2li
         7ax0l0dQoPiKbmSJOHaA4UiJV5XvbtXkNGooEQp3PlSQOOK3t5A3kUCm/FEKYmmCm5Ed
         AGMw==
X-Forwarded-Encrypted: i=1; AJvYcCXbq7RgAyLWvrVQMhY+EZypa5bFhhM7tw5aajiR9ZwYhggutilnVyqFKaDFmxvV+Wbq65/z/d1Pq50hDK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze2ukgwx/bp4BaouJWm7Tt5KTOZPY9noAh657sPCJPQa/Nmgof
	Y5qDgN1esuShfkivljKocZsY2RJFzHaHMOamLIJzyVsB/eU+poOG
X-Gm-Gg: ASbGncsi1UqxKOlVtlkpXkeOA626gf2lilb40Gy5KmPI+w00CNslFrlr0p33lVSat4G
	C07DqOpfwAJUc0GU9NXiIiS6W32c2f+n5t8DUjIMjACuEvVlqChDXdYdeBRVT1hBuciSVS34ndX
	//C36KhusP5ZkipvP+oJ4n398WKjkZpn0CuIpUjbbFCgAu7mCTmyjT9J6H9HVUMqoPRH2sLqowv
	1xv0wVSjJ6Yz1MI026NAq6XFfRML3zC0LWQWvob8JIfpCoObjS4YmhhOQ==
X-Google-Smtp-Source: AGHT+IFQEzAQerjKuoSPL7Cy27yH+eoooujwqnA2dD4Hpr2w8zBOWQ0KFCmDZvR+4MRXGb0Lmht2yw==
X-Received: by 2002:a05:6a20:12c1:b0:1e1:ccfb:240 with SMTP id adf61e73a8af0-1e1dfdfe075mr5041951637.41.1734101612631;
        Fri, 13 Dec 2024 06:53:32 -0800 (PST)
Received: from arch.localdomain ([2a09:bac5:d58c:1682::23e:23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725d30e6959sm11251327b3a.88.2024.12.13.06.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:53:32 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: gregkh@linuxfoundation.org,
	zaitcev@redhat.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH] USB: usblp: remove redundant semicolon
Date: Fri, 13 Dec 2024 22:53:14 +0800
Message-ID: <20241213145314.785616-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

remove redundant semicolon in LPIOC_SOFT_RESET to
fix the incorrect macro expansion syntax.

Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
---
 drivers/usb/class/usblp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/class/usblp.c b/drivers/usb/class/usblp.c
index 5a2e43331064..0f422f6c28e9 100644
--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -87,7 +87,7 @@
 /* Get two-int array: [0]=vendor ID, [1]=product ID: */
 #define LPIOC_GET_VID_PID(len) _IOC(_IOC_READ, 'P', IOCNR_GET_VID_PID, len)
 /* Perform class specific soft reset */
-#define LPIOC_SOFT_RESET _IOC(_IOC_NONE, 'P', IOCNR_SOFT_RESET, 0);
+#define LPIOC_SOFT_RESET _IOC(_IOC_NONE, 'P', IOCNR_SOFT_RESET, 0)
 
 /*
  * A DEVICE_ID string may include the printer's serial number.
-- 
2.47.1


