Return-Path: <linux-kernel+bounces-282034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE1F94DEBB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 23:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8EA282B4B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 21:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8674513D88F;
	Sat, 10 Aug 2024 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7a3n/VR"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B304C1DDC9;
	Sat, 10 Aug 2024 21:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723324569; cv=none; b=CV+nv3weiLpEjr2/iOBnprfZ89fd6RSzl+XNixYhmZCIMR5oH0SpkIVXsQ8D2G9Qo+mQqfeySo1Tw6Ze577qHrrS/Svng4u72O9lum+F5BB/8uVLu9AefUtIFY1nhtGyInlDTBGe2E7VSLakDEJTXRqlmfIxhda2CxfSn3/9fd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723324569; c=relaxed/simple;
	bh=Q7F2hdstUR1GcdFZzkKqRZdBh9TpTH6fl3NNQSG2Mhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ci0P/K6mAtsER05bgLljnENgBIWfAYust7YE3UCECbH2vg4FWTfPuPwYupI65Bqg0UBa5U218x8F1h+U2SPbmiELIxbRMaFsGt2adqGmZfiyH8yhg4Aw8eRJjItwKHt7awOTAlf18g4k5/utFDkVbmZNQ9c4rwIQ6Xl5YvDiwCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7a3n/VR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso29867665e9.3;
        Sat, 10 Aug 2024 14:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723324562; x=1723929362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LvUlAvVnkZsWC5X269v12Fz35WI2szKmllVuoFQEAKA=;
        b=f7a3n/VRTeRdPROphGSII/qkXscwb0pCynt6MLWjcYcP/UfFUc4KoD7KNlkJH9Hb5v
         zOuF2VUyeog8i3PMxN2c3+j/1tzSIxBWkj3TzYRKP1N4g/RVGGAZKLHbbAEI0fT8BkC3
         OM1kNgzo9p1eFnU8DYxIVilE99FTuJtT5o47KGHkzQtn3SQuSOU5E2fMS8fxwfWFfavq
         p13qCHg98eUgu8N1K/74/qvi5DDrn5gW+Sko7uZglrnJJqL2EV2NzXxYIpXjNc6Dym52
         7uFpU7YsZjOyil+Av4H8Y69zbsFnevxc1pABW8KvdiYSD9IwPCZv1dKc9tT/fmRGppgF
         hXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723324562; x=1723929362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvUlAvVnkZsWC5X269v12Fz35WI2szKmllVuoFQEAKA=;
        b=D6/70iTXXEje5jQhpLOGEgSThkDkBvdezaIqvTEiLWE5pSn9/KWF9QRTinpM7epV3V
         Gxn0DQbOU5q4HmFF9QP5r3vTqRC8L/5yfaLcRlzzCmeqLiIP1GXZ6XCjD30LwQOewPE2
         zEACaUz3gzp/xxiVKNyb+xwUn3sZi5BRDpp93IC20ZgSLlEFr38KUkzOAr2345zxndsO
         qnfCsqEj1c7EWf+QK09L1lDnIuThIWrpFYxbl3EJeQk6qr3jEKJozp/fxP2tDlGrsq3N
         0fA6xTKomw6xP/iKuEiRWMvzQMDy2SL3TCHse51MVj1xKnP5Z1+WVIySCgN4nPFAFiR/
         M93w==
X-Forwarded-Encrypted: i=1; AJvYcCXkyj6bObhaFfIZHwCS3gYFI6hGjqWPqWOCn1uS4SFFmA/KSs1aes/QBR+ZtJ41iJaVWm6zCnZDAR8OgSQ6pV4KWIZEh9YLDIJMReHHMFRzOgMqf2pOsZt3VPVNzzlCbl6noAblMqr4
X-Gm-Message-State: AOJu0YwMe2QR7wqA6W/0JiSp1NrNXS+hRJq7tMNyWri+Y2I72c4rSDjF
	BgdkJY+MY70C/miG5/VJM2NmCF6eq7GTHEGPo9lLOPRYDVJuaTNZ
X-Google-Smtp-Source: AGHT+IH1Cc4GXfdUeAw6MR4Ptp0ch5rMDt6CdgHe4dATqTizhRm3PD/S8LCVzKvgbSupymrOze5N2w==
X-Received: by 2002:a05:600c:4f48:b0:426:6f87:65fc with SMTP id 5b1f17b1804b1-429c3a295efmr48384685e9.17.1723324561683;
        Sat, 10 Aug 2024 14:16:01 -0700 (PDT)
Received: from gmail.com ([156.197.240.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c77374a5sm43419725e9.30.2024.08.10.14.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 14:16:01 -0700 (PDT)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: skhan@linuxfoundation.org
Cc: Eslam Khafagy <eslam.medhat1993@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dm-crypt: documentation: fix Unexpected indentation error.
Date: Sun, 11 Aug 2024 00:15:57 +0300
Message-Id: <20240810211557.42874-1-eslam.medhat1993@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

this fixes indentation error at Documentation/admin-guide/device-mapper/dm-crypt.rst
when compiling the documentation as per sphinx documentation: Nested lists must be separated
from the parent list items by blank lines

Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
---
 Documentation/admin-guide/device-mapper/dm-crypt.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/device-mapper/dm-crypt.rst b/Documentation/admin-guide/device-mapper/dm-crypt.rst
index e625830d335e..dc6ded632b22 100644
--- a/Documentation/admin-guide/device-mapper/dm-crypt.rst
+++ b/Documentation/admin-guide/device-mapper/dm-crypt.rst
@@ -164,6 +164,7 @@ iv_large_sectors
 Module parameters::
 max_read_size
 max_write_size
+   
    Maximum size of read or write requests. When a request larger than this size
    is received, dm-crypt will split the request. The splitting improves
    concurrency (the split requests could be encrypted in parallel by multiple
-- 
2.34.1


