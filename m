Return-Path: <linux-kernel+bounces-228818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E935891676A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77DA6B21E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDDB15F3F0;
	Tue, 25 Jun 2024 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki5PI0W4"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F31156679
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719317830; cv=none; b=fIIxuQWT2Zxo6M679u0fmyYQSl9UOzz1Cp7GatG491eackaNNtvk28fEylc1nUQvo8sp66D0IA8c3hFBU3HpzCwHo4BEFNw2qkRoYijzk4voRme5/iriQeYvqYvWTKonOKMaBxE7OAVRA1Ib4yaE2sOqY0bOBS3JR7sMyBdJfwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719317830; c=relaxed/simple;
	bh=V+FiACKvQmTm3/7fen2NI7/xRgvTbLB9IbeecwYntjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jRWLn3MvLr2R8wHlEN8fI49wPTVvARm8D439Yg1pDGC0J//mJiPHylU3rGCC0fv52y3wK69WXOIrBnrmsUP1I3B1sK0ev9Y++VG7hMROCdBErjJnpMX7l1lcNhuPRM0Kn2impOlq2DGe4bp/ug8upcjaPN3UVvP1esQKMvTaBW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ki5PI0W4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f9aa039327so44699195ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 05:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719317829; x=1719922629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UU/g240f/L7w/Z66TFDfSallHVn15XV0NCyAfvU/O9Q=;
        b=ki5PI0W4Zq9yh30BLwVt5L7J09ht4KxpCSvt8UM472Y9NNP4S16ZS68B+XNV2g+/LI
         poOQK5tchTBggRR9WCfeHoqxfEqRvTeS9onJEoEo3ksjEdFHJc8I5yDTyxD/coHOv6WC
         VWfnbfW4mY2CVxkt+5pQwgCgnIGBum4+YhUOTZGfNWBIUw9Lcd1dNEmczmkMsls4zr9f
         nG/AtAKpMsNnZ7ihs/Mh5bzmG2YiA46udR0Oafdx9WRi774/N7TPSPhiPLvyT7SXZia9
         XAg66TsHcu3s1Ph+dNMRGGmQupATUSbU3OrrG44wMu5wqrJuWaGLR4kQqwP7JIntGwDI
         78rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719317829; x=1719922629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UU/g240f/L7w/Z66TFDfSallHVn15XV0NCyAfvU/O9Q=;
        b=YSoVQowNjybHdMCMxLjpRZNl9rjI5FTneyJTeyT8FHFLIPiG//aX6pV5eCcStCqZbL
         LUx2b6FjpA3ygcD+WlUA+JcxIqVc/mgJPItt8tK38St7ZYkbYx94o9Isk/AZ1I9TnQP9
         IwwgxxjZ/raLzbv/E9W8L8FGYvWGXVtnLO+5Yyc2QKZMFAgFiyRz7bSZRHlgZCmp61Ip
         IPsV/856xqP7mZNxRlhOMbkrDF38UkQoWwqoZGGDff8BXZA0I6vvtqsELgnIhFZbxeJO
         1i9HcuAoeEXiozB9H9sg5aZxQIJD0rZ5OCqDhIDfP6+AvZGqeTtD25IvNSANiv8gJ9lr
         nk3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrna0whLXvPPq4r8xyub13Drak2feGmdVVLPdusN2BVmPc9pa5TNk68LkDPCp8IYIbVITVElrb0r3tn35V2lyWrxa2k5nXZhwBBSEc
X-Gm-Message-State: AOJu0Ywcd/WJtRi1zaJIbrXTZKH7qotiXi0nOtLkbmDCDOot4ORk7BUp
	qswK2K5SpHA3V/XbIeX482Dw2+yikdAk/eEr4niyF7AaeAyTJ9pq
X-Google-Smtp-Source: AGHT+IGRMS8OB61wL8cXtxJx3wCGcpMp7tS1M3woivAe2Yz6YNFRzTSQ3wNi11zN+HRWnkFb2YsOnQ==
X-Received: by 2002:a17:902:ce82:b0:1f7:3d0d:4cd with SMTP id d9443c01a7336-1fa1d514687mr93247815ad.24.1719317828808;
        Tue, 25 Jun 2024 05:17:08 -0700 (PDT)
Received: from guanshun-ubuntu.mioffice.cn ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa75f5401csm10166885ad.119.2024.06.25.05.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:17:08 -0700 (PDT)
From: Guanshun Liu <lgs156412@gmail.com>
To: rppt@kernel.org
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Guanshun Liu <lgs156412@gmail.com>
Subject: [PATCH v2] memblock: export memblock_free() to free reserved memory.
Date: Tue, 25 Jun 2024 20:16:52 +0800
Message-Id: <20240625121652.1189095-1-lgs156412@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On architectures that support the preservation of memblock metadata
after __init, allow drivers to call memblock_free() to free a
reservation configured in dts. This is a hack to support the
freeing of bootsplash reservations passed to Linux by the bootloader.

Signed-off-by: Guanshun Liu <lgs156412@gmail.com>
---
 mm/memblock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 6d18485571b4..20e7f81fc076 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -848,6 +848,9 @@ void __init_memblock memblock_free(void *ptr, size_t size)
 	if (ptr)
 		memblock_phys_free(__pa(ptr), size);
 }
+#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
+EXPORT_SYMBOL_GPL(memblock_free);
+#endif
 
 /**
  * memblock_phys_free - free boot memory block
-- 
2.25.1


