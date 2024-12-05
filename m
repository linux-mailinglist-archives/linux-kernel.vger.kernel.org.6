Return-Path: <linux-kernel+bounces-432983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56E99E5294
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FEFF18816CA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9E11DC075;
	Thu,  5 Dec 2024 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QOOfvl8Z"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E9E202C3E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395122; cv=none; b=eMKKBDH2QpiAW+zgrmS2OpNxkeCu3+AQ1Ti5eyFtjHjk9R7o99CB5M5eyuT9lx4E2LIIlLzX+kmCBASrI215t97/q6Mz5qZA3MKy96BxehPtwTqy+Fd+uppc5C17OIyIdHaKV1I+For518peN++m+uaszbpPjH4+rkaJ6hLdyaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395122; c=relaxed/simple;
	bh=LAwYaE87yw9Ykpi8K3m6cxKiTi2Y0B9KHX3J6XW9rFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c5aL+FPvNa/oVmAFcCBgLHNCRQPS9izs4dl12I5Qt5do72tan016BXQ90x/Dy53r/Ja4KjbWBULT75b+6hV+nK5RdfnCHGqNKKbXGn7mpZI22EuH0WnbyZ1e93N+6fAt0cB76rA+Abum2rU+Mi6gk0fTy0vUUudEtxM4zAVOxnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QOOfvl8Z; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a77c066a15so2819935ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395120; x=1733999920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQ/0Scy9E/wZ7/MnA5BYlbNUXDy/8A/TpwTZAMtapEc=;
        b=QOOfvl8ZPBdvDomoOKLEGRU/7MBDZevZQtHL3cOsFNzmcpVLu3TSryug8jcApJVLqc
         RnwQITCdfx6HIBbkBiv7NdKGDgQcZ3LhkdwQJFPXYA2br6ycgPjPohdjz74/C4z5yvAx
         GCQ9KYg3ShOWSaicA+gdl9WWffo6G+1OqHI0arzvUmMxPduu5DjP+96HoML68AMdpO0W
         Zyn2wy+sjsbtAW1RSTKPYdpJ/G7ZBdwjis0qQNafSAMQwBQJQAuhBOZb3a65UOvcYueK
         z3zGMcJ5iS1nWAawJM77zKNyzcwIp9VD4AyV7u11sJLrbMIWAuIbj+8IFezrtGFBsIio
         U+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395120; x=1733999920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQ/0Scy9E/wZ7/MnA5BYlbNUXDy/8A/TpwTZAMtapEc=;
        b=UQzapTRQHKXlFkHfFwgslqm0lW81NpTN0pEr7MKSeDouMhnooAOLVhuAb9W5eif6vR
         rCCJBfrxAyLK8ufQDWz0mwoDAqcIMjc6RQAKICwEnCJx7ISjfxA84/x/tMNGSDY+tuhN
         f6KbeW/IMN3o3lw93HGnuJh6eD/vOuOsHPukzb0vb5TvylcVAPt3QAI0eMlL01jATsRQ
         vgQPElgCVQU+p7EiVmdJ+AVCJSdu88UhQ2Ze3ZMlILpjmRROKTCRrvDG4l+po31h5t4a
         qaDkH7+0Fcr83TqyKncxXiDUJJuS/NvRmjFd8t4o3kW0FvIF7YlkEyaJX5Lk7KLbLolS
         KFkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcqzlAC6Uw7n50mzZCsu5dIVYAqGWbY6in9FBWpV6+lOc6SYe1Zgni6VMb5HGen9H9aYsskQeAWZzAuSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlZ3KZHVmLpiMtEQTZI3XeueCLYy4+A9VvU9fTpeYFDQ6vwqnS
	bj0tX7b2Yd8+OhvbgK1MKKeivILg8fBGFme/Ci2ZArCsjAl+BhkGv+ZmNt5hrNoY778AIxXZXWz
	gWa0=
X-Gm-Gg: ASbGncu0hlTR70vWA6HjYenfN0/FGLSDXS6eGlmvyUq1Uo/m1u0py3rvK10pGJaaswu
	B5sw5zD/3bsCkSwU/4kwrsDir2Q1t3dtSiqp9Efpm+8CtYxHWgAkYxQqzYutUnPbnMD2jOWdT7h
	0V8tWcQghaM6urgNOt6tOorNXuXyUnWl4dzTrAcxs50lLw5FZUy1cTQ7/oFFymwlt57CPF/wc31
	eeAS8aD1oB9fs4vJ9gn4lxUMmPO9IBuTSypc3La7D54U2tzUEdz0719YFqwph3KZkC+eTwerj/6
	lbvGdMDvjsxXSJ6aT/oDVazlCq4NDgRg
X-Google-Smtp-Source: AGHT+IE8l6yfJ87eJad5FAeGJqDd+iC1OcZn198mK7ZYZDH6TLk8OTxSkqSKrMniNwvDITNae2Qz7w==
X-Received: by 2002:a05:6e02:144c:b0:3a7:d792:d6ad with SMTP id e9e14a558f8ab-3a7f9ab0ff1mr115272635ab.22.1733395119846;
        Thu, 05 Dec 2024 02:38:39 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.38.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:38:39 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	anup@brainfault.org,
	atishp@atishpatra.org
Cc: xieyongji@bytedance.com,
	lihangjing@bytedance.com,
	punit.agrawal@bytedance.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v2 15/21] riscv: mm: Adjust FIX_BTMAPS_SLOTS for variable PAGE_SIZE
Date: Thu,  5 Dec 2024 18:37:23 +0800
Message-Id: <20241205103729.14798-16-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241205103729.14798-1-luxu.kernel@bytedance.com>
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/fixmap.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 0a55099bb734..17bf31334bd5 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -44,7 +44,8 @@ enum fixed_addresses {
 	 * before ioremap() is functional.
 	 */
 #define NR_FIX_BTMAPS		(SZ_256K / PAGE_SIZE)
-#define FIX_BTMAPS_SLOTS	7
+#define FIX_BTMAPS_SIZE		(FIXADDR_SIZE - ((FIX_BTMAP_END + 1) << PAGE_SHIFT))
+#define FIX_BTMAPS_SLOTS	(FIX_BTMAPS_SIZE / SZ_256K)
 #define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
 
 	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
-- 
2.20.1


