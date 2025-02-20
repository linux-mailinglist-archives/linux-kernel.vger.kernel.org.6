Return-Path: <linux-kernel+bounces-523331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3829BA3D52C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C52719C0B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FA71F3FC2;
	Thu, 20 Feb 2025 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3JrxH4l"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7FD1F3B9D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044634; cv=none; b=JV2CCUlQYC+HpjQ2qLVrhgF5vIbORkcV3LXF19j0OMRFXGCsGR8LE7cm9aaiq3XM/WEQDimBZ/HghrfynSFJuojlUGQYZ+avSFcVV8lAmKINhlo2pRGKCaWUh3Flp0xkkSKgomT4jMuj71KjpSLev51Z2maoAIKT2/o6oFgedHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044634; c=relaxed/simple;
	bh=siQfZG6q7O2sigyc4bjU1Rsm1nhMkVlYV4r4rO8LUAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i7mDRLUKVOl4xie5uTW6bs5l2WroOT1mv9UGjHY2ir4AsGBm6FVpuhCvqRPAIMVST/XR28kMIkVtJ95w2YC5hJ9/DWr91BLdYgZdqdLZIUEvJipyQ2tPJ3mm/K6Zuo1YSomBGgQlPSAUorEitH9JBZLWjC+VRv0+fBGBLr2LSlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3JrxH4l; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-545fed4642aso820835e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740044630; x=1740649430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BJJaDhjE30elvjUE90iF7FHjBFvFQhwKbe1es1j+S7w=;
        b=b3JrxH4lMECCpcIxQ1hydeOXdjkFicbzGMLaYGj8baKCcD8EBsnn8vZunt7eUALfwe
         a5yjt5o79xQMEglGbJxckoG5ELKWZdjtOWlDQdit+80zmXkpSevXhwwt5AmVBkTkvjbL
         qAGyAc9Ozycsl55nsd0ZxK3s4+a5M4R564u9hYmZqEnOqs4j52K82tghBrjpb+r0jV1l
         hCaGCQoA7nUH1+WZfCsCd0PKL5D6xnEHuO2j/jHi+q1rNq/iDT8eJ/5Ka3UZyn8Qpttj
         bM3Dms+YNqCOtJ6zqIybkls2NPHwrYDls+YZ3sii09Ru6wmtze4C+JnKNHHI2OhQiFZu
         a+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740044630; x=1740649430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJJaDhjE30elvjUE90iF7FHjBFvFQhwKbe1es1j+S7w=;
        b=E+xYT0502IILP+S1zMh/awPZfER5+CwDc74o6LZN8uw0/Vw+zxEKyL4rIFZR88akO7
         b3/mZVHKXySl8g31EhAa04sO+/osRZYpawnrm0CvLk8wkN2y+ahtm8Mvz20/4YKcT1gq
         gFqFUx82Xztr7XdMfygfgBEBRnrCmAftZ1wF0MLcetFZdxdjUzL01Ypznuo/pSRV6+3j
         n2EwBdRrNO8N3Uh9PYdoJSQuD0CaXPcUqPwimNpoFM0RbJ/sgP9tXOrWtQYA3G74ilby
         zvGkar38JsPxl+83ncSJe+xaYld+tTAE/lbUensgjUTUvpccncQ1fs7jmf3ncZotsvi8
         esow==
X-Forwarded-Encrypted: i=1; AJvYcCWoLtmZ6Ij2iASe79fx2dMSu7qrmAy/1QdZlE/TPBZAghGxy6jpSz+fZg7NTmgE5RK+Jj3bl1jB+T2bSZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAUDEKRi6H+lyQvVipqNpRRu5b/RRmxd3qt4wFHvd7lI2UdcrL
	e0RhmB53kXEM2bib30wNH0b8qEzxxQoPOT1MdCUGLkv6bHlQeE3/
X-Gm-Gg: ASbGnctpvgEsnIlvXtGOdUZNyj/1Uommlx6jflI9OBPMeTnZFY230e2UmsHFiMlSoPD
	0QxpFJZJ7wS0ISnkzPlK6TEN6mWJC2K0vaXaYhL59cDPt2nAMSTeBaevPdHvHgkXtqiJgt3WPDW
	qcRSkJojGB61LCPZZZb8plkTpuxQiEG5BLrquF3KiJqqKMDXhg8XtB6vnWymaY/n+2+JHHrB+mQ
	G491sOKXUcQZKwWaZB7xmSMynJFPGJzapgQzqZ4z2LdSNIahQ2qmM0iK1o+H2lEDPqfawfSyPGR
	TCneoE7E9OrV+mUcOZqem4FNZVPxQ+zDuGRHJ8Ox/lCfmm9Omv4TdCIS8g==
X-Google-Smtp-Source: AGHT+IHbjmlrQKyZa9vOcI3zku2nA08D6JCeRqFIufLZ/yEvKNLBxeThOwDv51mb+aAJjfRscer+Dw==
X-Received: by 2002:ac2:4c46:0:b0:545:bf4:4bc7 with SMTP id 2adb3069b0e04-547243c348amr811852e87.19.1740044630137;
        Thu, 20 Feb 2025 01:43:50 -0800 (PST)
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-546222619d3sm1158816e87.209.2025.02.20.01.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:43:49 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	voskresenski.stanislav@confident.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH] fs/jfs: cast inactags to s64 to prevent potential overflow
Date: Thu, 20 Feb 2025 12:43:49 +0300
Message-Id: <20250220094349.1685195-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The expression "inactags << bmp->db_agl2size" in the function
dbFinalizeBmap() is computed using int operands. Although the
values (inactags and db_agl2size) are derived from filesystem
parameters and are usually small, there is a theoretical risk that
the shift could overflow a 32-bit int if extreme values occur.

According to the C standard, shifting a signed 32-bit int can lead
to undefined behavior if the result exceeds its range. In our
case, an overflow could miscalculate free blocks, potentially
leading to erroneous filesystem accounting.

To ensure the arithmetic is performed in 64-bit space, we cast
"inactags" to s64 before shifting. This defensive fix prevents any
risk of overflow and complies with kernel coding best practices.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 fs/jfs/jfs_dmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index f9009e4f9ffd..f89f07c9580e 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3666,8 +3666,8 @@ void dbFinalizeBmap(struct inode *ipbmap)
 	 * system size is not a multiple of the group size).
 	 */
 	inactfree = (inactags && ag_rem) ?
-	    ((inactags - 1) << bmp->db_agl2size) + ag_rem
-	    : inactags << bmp->db_agl2size;
+	    (((s64)inactags - 1) << bmp->db_agl2size) + ag_rem
+	    : ((s64)inactags << bmp->db_agl2size);
 
 	/* determine how many free blocks are in the active
 	 * allocation groups plus the average number of free blocks
-- 
2.34.1


