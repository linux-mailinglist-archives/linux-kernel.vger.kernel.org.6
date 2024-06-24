Return-Path: <linux-kernel+bounces-227184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F2F9149A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B39282A03
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9606F137C2A;
	Mon, 24 Jun 2024 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b="rRgTxUBu"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233F132130
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719231455; cv=none; b=BSgt5ljrpVi9J/agfmjePswhcpqZceTowG6DETvBxbKalipKYZbRqfcglDjSmAqpltFcthpzVCkj+PWJNjju3yuMTwcHyRRTN7TOPQ3MBiDEobPw4Wlng1tpBeVWTsnXQQU5hsb0GMPd1gLDxHdmteX3QjbWesxJ8j5jZCClIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719231455; c=relaxed/simple;
	bh=IImyGNlk9SdvLcvUXXPWkUWKrolYgwpadcgIksrFtWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=APNJeMezzLNLkwI5cbAaWKSCiepBk7L6Hr4SAzt8cbw7AUpMkK9DZW9RQqDAAEAIw3wHWx9HKA7vIjNNeV1rqdqduiB6b8gZPMo9MGmIo4yQWqF3b8kPDOjWkxY+lug4akRSzgu5X4QtCT/u9avDDyd2y76oWGe1dAFKgQNcPu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com; spf=pass smtp.mailfrom=codasip.com; dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b=rRgTxUBu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codasip.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4248e28de9eso9669475e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 05:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codasip.com; s=google; t=1719231452; x=1719836252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K5lWE14O0q40ZM3Q7e7I/Qkwnqb7aa5e7ucmPjX7TUI=;
        b=rRgTxUBuPIujcleIJiMHjZ+WF5HrIeVYU+TsGVQej/C/8gUWEIOETkwA+kZv45pIst
         QpZAnu2IUY7G+fknLFHFHgrJbdg7X3aPSm1OR5FPEJtTHIJe/8XVy4MIVHf3knrotGkR
         duEyFuqenecVRewjIgGlinw0M2Am3AVzclumyKB0nx40p2VTPzsFlSlzod1UMmQbHPSh
         78Wg/KQbF7VdT9TPoyDihNd44DiSCDIUvVzjO6CMmQyRfbLFbDBJQNoos3+sJygquVr3
         ZtLPpk8D0MMctcEgHsq/nN0bKRxgDEwziOEEcBkLf45Qvr5Of3bmW7znaTdwX4n4CjKL
         mdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719231452; x=1719836252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5lWE14O0q40ZM3Q7e7I/Qkwnqb7aa5e7ucmPjX7TUI=;
        b=EW35mzomPOB4e16hi5Z6KfPZtmTF4G9SaR1KGiAWsGN5C0kdV1MmlJ/53yXQPrmdEG
         3UwqzO9XYSCf5yTG6xqqRazASTX/Nyc5xUCMpsia8GarliZd/Dcql9YVss/qz3otvPD4
         TCaFgm3nt+354CvfX4c2LLt85rO8xNapNDxvpL35n5QHKyt5pvH2fFU1xnr5N889v/qW
         rvfDAAc8DwCL5EpP7rOvlffUk0lMeqKvXWpsB9yZvK6+7dDa4edSQL4ZT2AuQfK93c/W
         EdQ2qsJsbCY3pm5RmaQ9+IQKo5MyqXWXPeiA85APUceZ8L1/qy5qfxZfW8NrOUX0tn9c
         Yzhg==
X-Forwarded-Encrypted: i=1; AJvYcCXCe47aQECJprnwmsaxd379zZJTX+8iQNt7rK7xNOvNRUwqHl3AzDX51OzFzHM9bJjx7QkHqC+unvWJUDfPCV3H8uFBYczebZQhaHoF
X-Gm-Message-State: AOJu0YyuknP4dAbKSUg3wJ2lNAU3/hwduYrygtZeS/vpih+VEHyBiGTx
	GQ5Q33bpIaMfUpCYM0HczGUQzvomgUKj13JG0uF7QDDVepkHOjohNgCQ3g8NhZs=
X-Google-Smtp-Source: AGHT+IHlTVb4uXVbpvGdrzA3vLqFoPj0qa5FX8+qTKTnek1ZPTk/8klkQRo+HeGDJOeUrnb/fhPXuA==
X-Received: by 2002:a5d:47a8:0:b0:366:f64b:286 with SMTP id ffacd0b85a97d-366f64b0350mr1487982f8f.37.1719231452509;
        Mon, 24 Jun 2024 05:17:32 -0700 (PDT)
Received: from nb152.localdomain ([167.98.108.175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f6da6sm9869486f8f.12.2024.06.24.05.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 05:17:32 -0700 (PDT)
From: Stuart Menefy <stuart.menefy@codasip.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Stuart Menefy <stuart.menefy@codasip.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Remove redundant restriction on memory size
Date: Mon, 24 Jun 2024 13:17:23 +0100
Message-ID: <20240624121723.2186279-1-stuart.menefy@codasip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original reason for reserving the top 4GiB of the direct map
(space for modules/BPF/kernel) hasn't applied since the address
map was reworked for KASAN.

Signed-off-by: Stuart Menefy <stuart.menefy@codasip.com>
---
 arch/riscv/mm/init.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 7e25606f858a..3998d1ca369c 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1130,13 +1130,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 				0UL : PAGE_OFFSET - kernel_map.phys_addr;
 	kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
 
-	/*
-	 * The default maximal physical memory size is KERN_VIRT_SIZE for 32-bit
-	 * kernel, whereas for 64-bit kernel, the end of the virtual address
-	 * space is occupied by the modules/BPF/kernel mappings which reduces
-	 * the available size of the linear mapping.
-	 */
-	memory_limit = KERN_VIRT_SIZE - (IS_ENABLED(CONFIG_64BIT) ? SZ_4G : 0);
+	memory_limit = KERN_VIRT_SIZE;
 
 	/* Sanity check alignment and size */
 	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
-- 
2.43.0


