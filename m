Return-Path: <linux-kernel+bounces-357246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4705F996E68
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0706B2167B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F26419D8AD;
	Wed,  9 Oct 2024 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcx1KWUO"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638211AD3E0;
	Wed,  9 Oct 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484914; cv=none; b=cxjorwNZlNPCal+hPUtHA/k+SRCbDvdetqPPbRCRqlhi01mj9IE7M12BfmV8qgrtExFdvtqghUkHvYxYZDn3WD8XN7ihcVRuY35e6wyUPt/dIol6sMJ39EWd6N2ZC8Pwgqkb9PKfKDNIliyHptCMeXjCoQOdfRI7IImKyDcsX+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484914; c=relaxed/simple;
	bh=VunEJ/xwuettX6smQJKBDV+UW+4btbVoLLeTdCyl+II=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CkQa1cCx1adVLp3w6/afirEghhFZFHHq5yX2SbHXpgSpG5ODjEy3hocAd4oHjv+muh7P2GgfPIwcoKsaGFnM739iVZCMal3kveECoBWe08gJ+KwX2ZmvppDflHQnEbQBuTpJKQAswQWOzzNpjrRxoKxREikYwh8RnUpWfwbGz4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcx1KWUO; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7e6b38088f6so1198971a12.1;
        Wed, 09 Oct 2024 07:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728484913; x=1729089713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qCtld05NumSV4UkgVSqT2rR72s9JAMPSic0BfS69Q20=;
        b=lcx1KWUOxomY7RIF5FhdLBOnwV2rb6OaKDkaC38IPGVBVtd85HQStFYZF0aRjUB3KN
         kXeyvs5UH1+HzlL5SRobTkcpgQb/RNVLIoRrAcl+9WGcujKpDI3x1DSzRcLhdln2OV5s
         9V70CYd7z4HayZ7U/ulAk54qtW+DuGFGn75fy8Kx1HtfiJk2vzM6MzKTci20BnAXLEyO
         udSS9giDvdK6dk6nq68I/b8aMslzKP6gQJ7g47DLu0XiJPYXzGBp9xq3eiwSkQrFggZ2
         ORCP9g7GDG8oXveGeH6KDQ/pAXxL4pw3YL6LA8lEaQAp7ZznTkbn4s9TjKItTBvcLA5K
         /ZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484913; x=1729089713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCtld05NumSV4UkgVSqT2rR72s9JAMPSic0BfS69Q20=;
        b=A/G5egAAvLTJMzqEtebhhGIMZpRjKiYcLTHBFsB46niztULIvn8Oy+eQoNSUA8CyBx
         ol7+AvQkUWXMLf3Z9eX0xQCZF4gzV9bLJ+/Bs0MNDKBoglx4evUMViGyBP0fmC0ZTdgF
         y9U6g7ZcB5+0AtBwULAlLIxEXFI/axHPNG8wOVid8nxNWjFpTJpACrS3lAv2wpGvqQb5
         AHUoANQUXxBcsqZxNc1LBJbu0qvuTT5nJdpwDp9knLS7+K9MsW1DPnTN0LWV1Px8x8KJ
         6ZLEudvISEDEaKJxOZnUAGohCEottD96Yxv1+N5wxYVrOrajpjfrUTaVezLBqPmdJR1H
         B9OA==
X-Forwarded-Encrypted: i=1; AJvYcCW5dHPL1ZJrpXS1T88Xwg4lqzrUlOqWRCUof61p84tQyobS7WPPT+Bn8+3tGLLTp5SRNQLOXsbuYqw=@vger.kernel.org, AJvYcCWlU7ODEhvZw7FmLY80oL7Xde9QPCpKlaja2tZ+K7KBBmrlQ7ecJ94WD733DNkIF1JZjByXGCe+qqpmgcvR@vger.kernel.org
X-Gm-Message-State: AOJu0YwI9auTYs6rixB3OMX/bHhsKxP5vykGKYr5TfqXJiz5CdKJWXek
	cN42a+F8whNddg1LLu1TxgxmwLMKeXOnfvqnXjonrxDoFOhGVA3/
X-Google-Smtp-Source: AGHT+IFbcpYZf9mlup8jftHLL9IKaYbXftIXgq5WuXvgQ689+uVJJ0PPW0vH0vmnqiOS/rPViK4++g==
X-Received: by 2002:a05:6a20:72a0:b0:1cf:4845:67f with SMTP id adf61e73a8af0-1d8a3c4e311mr2042735637.9.1728484912596;
        Wed, 09 Oct 2024 07:41:52 -0700 (PDT)
Received: from aizome.localdomain ([117.172.223.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4ce2bsm8566342a12.83.2024.10.09.07.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:41:52 -0700 (PDT)
From: Pengyu Zhang <zpenya1314@gmail.com>
To: corbet@lwn.net
Cc: rppt@kernel.org,
	linus.walleij@linaro.org,
	fmdefrancesco@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaxin_wang_uestc@163.com,
	Pengyu Zhang <zpenya1314@gmail.com>
Subject: [PATCH v2] Docs/mm: Fix a mistake for pfn in page_tables.rst
Date: Wed,  9 Oct 2024 22:41:35 +0800
Message-Id: <20241009144135.12453-1-zpenya1314@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation incorrectly calculate the pfn value as 0x3fffff,
which should be 0x3ffff instead. It is obtained by right-shifting
0xffffc000 by 14 bits.

This patch corrects the value to prevent any potential confusion
for developers referencing this document.

Signed-off-by: Pengyu Zhang <zpenya1314@gmail.com>
---
 Documentation/mm/page_tables.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/page_tables.rst b/Documentation/mm/page_tables.rst
index be47b192a596..e7c69cc32493 100644
--- a/Documentation/mm/page_tables.rst
+++ b/Documentation/mm/page_tables.rst
@@ -29,7 +29,7 @@ address.
 With a page granularity of 4KB and a address range of 32 bits, pfn 0 is at
 address 0x00000000, pfn 1 is at address 0x00001000, pfn 2 is at 0x00002000
 and so on until we reach pfn 0xfffff at 0xfffff000. With 16KB pages pfs are
-at 0x00004000, 0x00008000 ... 0xffffc000 and pfn goes from 0 to 0x3fffff.
+at 0x00004000, 0x00008000 ... 0xffffc000 and pfn goes from 0 to 0x3ffff.
 
 As you can see, with 4KB pages the page base address uses bits 12-31 of the
 address, and this is why `PAGE_SHIFT` in this case is defined as 12 and
-- 
2.25.1


