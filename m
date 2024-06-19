Return-Path: <linux-kernel+bounces-220653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132A090E4F7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26AF71C21DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3825E77117;
	Wed, 19 Jun 2024 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="fMH3FnHx"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D9770ED
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783689; cv=none; b=fTtGD9mYO+eq8EmcxIb05BeoiFPJzn7cOY/Yg5bjrp5XTwKznW/OMMaqJbOYgy5otnwXk14yiaCdrGPrVfA3jaZMtfihQ760iz/lx7yIp+fBfTU8WZupgp3XqebEfC63B893djihul2BizO0+XR7B6Qlo0a0OldW+dT7Ijo+jTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783689; c=relaxed/simple;
	bh=iq0Po46MttQB5ZXI3wwLnZW/QZWc+/jk0VVwxEntq0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d77zcnSEk8tZ/QdH3E/Vk80KuzqRMyKNk5KAJ0oqxm5rRrtaqXUFz/k/GPCEPaqFuC+3SQuws1NBXXY93kzVlAeQ5P2hZKPfLM1cjbRYiEZojzumqCu6Ccr6d7Ya9veSvjQ9Nb+T6EN376nExZZDcZg8YijJ0lG+Inhp/NRo2/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=fMH3FnHx; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 299BB4061D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718783382;
	bh=B30QvcofR9KiWrZLYpcmSs9yQbLcW6coRoJpHxt3rTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=fMH3FnHxYovYnAvcb7DZxOm6Z3+vMPTY9DEzWSl+PTQmrgag7Dm0yjUSvZut+C7lh
	 0Lra7UCukvy7F3fYIhGgwPcF5UhDPX2rvS4xpmkvSHSSE90FkA+1X4Ig84YaEhc+vM
	 D3bJJy1BO85qVFb1jd+123G52X4I4IAYGeP9MDwqhTh0LxI2MEy2bArjAsGb0TlFEI
	 Av99nNDoYuIrqrwp4ortrCYW//pfTBKw5MMwVkoG3sn7uZmU0p3QBLXNPRiiFKDRWA
	 N9t+Q7z3YTRbiH3uPWJpMb0nT6J9X0/i2lPRDwABTqUO0xRlZXs1eCbbFlSIRJHX88
	 yBaXkmHGm6jCA==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-705f9efa07aso3988023b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 00:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718783380; x=1719388180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B30QvcofR9KiWrZLYpcmSs9yQbLcW6coRoJpHxt3rTM=;
        b=A8MykkFVVW2gwhferTtzGGmnqM+Sv8oB01XoH+fiGNpxatI4CrhOTJ4X0TLKQAcLRW
         u3n0oRWSuSRXaaOrtbYMpvb3sRwYhK5ZxQJh/1uaclhyk6GkUuLV7+nlUk8NUhNIOfEx
         Vwf927pgR0AR/QXqrd16ShFPQLErlyfThqcrK/yzLXOYQPlQTBFmuCUoQToGTKnEMSWN
         2tHJE5FxAu2d2EKjXhHpHhPs1erHb9h8oQ5656aHOJcywAyTkhzM7A3lbmhTQutKsx9v
         0sHfm9ZwMyts6yXTPjgmuQjdIi0G7CAJA+3lDYiiNyhQLC26UXlPLZ5nYs65KXUE5Y1S
         7b6w==
X-Forwarded-Encrypted: i=1; AJvYcCUs5ZZpSQXUXEg3Av/yNYtX7dTq6kuZEBhSs0yb6LFuLLr3qOo40YtyiSsB7guaQH/7DnQXqgYO3ZOaPvBuz7bB3wCDXPfUzjLIXQxk
X-Gm-Message-State: AOJu0YzlqGQE6l/sXt4MRyDysWUdAbq7tzKnOIvcFYX9jXpJNhBQ4+Cc
	NqCfKqHOgwR2oJ1IOes7WmwMt4dpaEx1IeoGFWAu5VwmqvFIV7NM2XwNjdL1OICt4kdDTGIj5Z2
	n5rcYuOGhU7kef/a1hr93NhrM+1/+1IrpM7FkB6+PBChzwmfU8K/4AKXRe1SekrWpc6s9T4K2he
	VwcQ==
X-Received: by 2002:a05:6a00:11df:b0:706:29e6:2ed2 with SMTP id d2e1a72fcca58-70629e639efmr1635528b3a.5.1718783380569;
        Wed, 19 Jun 2024 00:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp2ee+jTm37JUPAalohhD7m060pnacLcLav948WEvUrYPHLjCwC2idv1NnXncRv5b8z3MMUg==
X-Received: by 2002:a05:6a00:11df:b0:706:29e6:2ed2 with SMTP id d2e1a72fcca58-70629e639efmr1635520b3a.5.1718783380213;
        Wed, 19 Jun 2024 00:49:40 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3cdc6sm10076908b3a.138.2024.06.19.00.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:49:40 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] scripts/gdb: change the layout of vmemmap
Date: Wed, 19 Jun 2024 15:49:08 +0800
Message-Id: <20240619074911.100434-4-kuan-ying.lee@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619074911.100434-1-kuan-ying.lee@canonical.com>
References: <20240619074911.100434-1-kuan-ying.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to change the layout of vmemmap in gdb scripts after
commit 32697ff38287 ("arm64: vmemmap: Avoid base2 order of
struct page size to dimension region") changed it.

Fixes: 32697ff38287 ("arm64: vmemmap: Avoid base2 order of struct page size to dimension region")
Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
---
 scripts/gdb/linux/mm.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
index e0461248abe2..f8b9be3f43e8 100644
--- a/scripts/gdb/linux/mm.py
+++ b/scripts/gdb/linux/mm.py
@@ -89,10 +89,10 @@ class aarch64_page_ops():
         self.MODULES_VADDR = self._PAGE_END(self.VA_BITS_MIN)
         self.MODULES_END = self.MODULES_VADDR + self.MODULES_VSIZE
 
-        self.VMEMMAP_SHIFT = (self.PAGE_SHIFT - self.STRUCT_PAGE_MAX_SHIFT)
-        self.VMEMMAP_SIZE = ((self._PAGE_END(self.VA_BITS_MIN) - self.PAGE_OFFSET) >> self.VMEMMAP_SHIFT)
-        self.VMEMMAP_START = (-(1 << (self.VA_BITS - self.VMEMMAP_SHIFT))) & 0xffffffffffffffff
-        self.VMEMMAP_END = self.VMEMMAP_START + self.VMEMMAP_SIZE
+        self.VMEMMAP_RANGE = self._PAGE_END(self.VA_BITS_MIN) - self.PAGE_OFFSET
+        self.VMEMMAP_SIZE = (self.VMEMMAP_RANGE >> self.PAGE_SHIFT) * self.struct_page_size
+        self.VMEMMAP_END = (-(1 * 1024 * 1024 * 1024)) & 0xffffffffffffffff
+        self.VMEMMAP_START = self.VMEMMAP_END - self.VMEMMAP_SIZE
 
         self.VMALLOC_START = self.MODULES_END
         self.VMALLOC_END = self.VMEMMAP_START - 256 * 1024 * 1024
-- 
2.34.1


