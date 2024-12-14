Return-Path: <linux-kernel+bounces-445847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771209F1C34
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 04:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E446E7A04AD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 03:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB05517BA0;
	Sat, 14 Dec 2024 03:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZv9kGqB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C131401C
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 03:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734145257; cv=none; b=nJeZ0LzU7tPH3ZWZ6hSy3RyAjwWnns93n2gL5N6Ca+FALCFx8+h9Gs6TMb36jfIJI7Y9NGEtibQ7Y7v4MzFPB+jKqpPZAN37kaWdEUSHbnwcCQDDd5B6BwIiStTPAPwREX9+39bu9lyL71+ZwIJfAAIPlTowPMXDhXZiMc9OCgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734145257; c=relaxed/simple;
	bh=/+QxwvUo6a1L3DteocIub3mw/QpPvnkc6X6IDvVBvhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Si8o0qu1nr721JKfnKHmJHOygm8WsbyhXD9eB4QecFC1pr9ohxMdKYhJx7pQc34/uh4C/B0jEGs/C3K5IVMud1hPuy9qH7EFsYrNTvvbUbbAxGB9FBJGZw7ITYxylGx7KkfQyOAZZo4bbowHzoPx0mFPXbq6miw21W3GqCb3w0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZv9kGqB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2166f1e589cso25549925ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 19:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734145255; x=1734750055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZM9tq16lU7xfYZ3fQtKg9WeMf5EZFK62A2HYIHVvwM0=;
        b=KZv9kGqBDNlnIr3gy6Fs6dix6hSU8l4Ap8IFbelN6uI3U4pF0skdpeqMhDaz3tj/lb
         t9qTSexIMaUFpYN1lx2lG/+oXHKyt2ixbNGbNDqmoXWNChLxjZA17claSdFj5377BMCB
         eaYawudWwsnjHDeRxmsWhzu3bSXXLGmNHXoCexuBiNEB2p7RUCi/iUZ4X+UWUxXap6dn
         N94nhBuEhNqqn3NLRxhHiljiRLXQCq++ySsEpxgMc5THsfSa9ED5oo2eOTuS/QX2x+aM
         ZlULDTSvoNnKkV2Jb5nQjGdK8JiFlKM47fmJQsd0NFSJR+2gpFwmnC6e+6lEhH/Y894P
         1++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734145255; x=1734750055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZM9tq16lU7xfYZ3fQtKg9WeMf5EZFK62A2HYIHVvwM0=;
        b=I9SBER+a3w47eIByYMOWLOH9NcUgtcxWSkU9k9A5s6VkIwg/dYX/cMXe9HQrZCp5Aa
         tlTH6QNqSOYiJYDCLerGwzJA2ltywsnB1prYLLSQnggA6SSs9Hvjqj66Taatm3GsiULN
         qvmx7fDG6nIXmgTYcvC9E/dpWkeqlrpowjM/xqhQqQhRWrxnIONd8/5IdD95og2EacRX
         DXucnWzqgWtMrhKaROqPOgar4usp1dsNDWzCrkSUdDMhyJQ4Wn2FloJjgc3ePn50+J6+
         qTas2r+B6bUosBtINl2qLHZFUbYsyKTvRGOUs6lB4vw+XLJCNdzDTPFPyVzlZU5b5IDu
         hSGA==
X-Forwarded-Encrypted: i=1; AJvYcCVchGr58OPS1KyoRJiSk9hBkBBcc7TAqTqShVYQP40fBdmZFFbYRKsRtLdd83Xxm+7t0UWU9hNVUdxYCxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxROplieTc1FEkcRfEj1rmY56Tae52FYcxCUX50NlJuB3LvoTNp
	8t6fyiKArY8eKr2oXv1jBYfEaaCbQb5YhQN9yWXR0Q26dSHGT/AP
X-Gm-Gg: ASbGncvMCWp/rJWBnP3oNf/p6Nw6IGhprhcxsg9ZA3eFaf2u1VLLTXU5+tf3ILkRgSb
	5Sa2CQsNbr/8Yp2UDyVLwJRtN7tdj4Pgw8Tix7EgH1CpZDHf6uJWbbaMeP2UZg+l9VnaOJMJ3un
	AyZhIIPPmgtJE3D8o1u0SYZJ/MRUU7vcISvvZ9+fTmycexFeoPuy2yLUO5Jd71yU+NMo0n67un9
	2P6C/Pzvuf429LC5XNl7sDD1llCAcsFw7wnabCysFevyX1gOU6biRadVFP+1FR4lOSoejof
X-Google-Smtp-Source: AGHT+IE1RY52apvNH4/yTyRcE0FgmMS/DeJyCmrR14TXSXuKCpFh/dhc8sPh+qKyOnQ4fOZLB//1BA==
X-Received: by 2002:a17:903:41c5:b0:216:1cfa:2bda with SMTP id d9443c01a7336-21892ab824emr66805165ad.43.1734145254677;
        Fri, 13 Dec 2024 19:00:54 -0800 (PST)
Received: from localhost.localdomain ([119.28.17.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a91ec5sm446330a12.6.2024.12.13.19.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 19:00:54 -0800 (PST)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: akpm@linux-foundation.org,
	Liam.Howlett@oracle.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v2] mm: fix outdated incorrect code comments for handle_mm_fault()
Date: Sat, 14 Dec 2024 11:00:50 +0800
Message-ID: <20241214030050.1702776-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.41.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
changelog:
- v2: lower case mmap_Lock to mmap_lock
- v1: https://lore.kernel.org/linux-mm/20241213031820.778342-1-alexjlzheng@tencent.com/#r
---
 mm/memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index d9af83dd86bb..9d64e02341f8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6159,7 +6159,8 @@ static vm_fault_t sanitize_fault_flags(struct vm_area_struct *vma,
 }
 
 /*
- * By the time we get here, we already hold the mm semaphore
+ * By the time we get here, we already hold either the VMA lock or the
+ * mmap_lock (FAULT_FLAG_VMA_LOCK tells you which).
  *
  * The mmap_lock may have been released depending on flags and our
  * return value.  See filemap_fault() and __folio_lock_or_retry().
-- 
2.41.1


