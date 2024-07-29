Return-Path: <linux-kernel+bounces-266015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BB293F944
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 212521F22EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60BD156665;
	Mon, 29 Jul 2024 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pVxjARHj"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E677D1E4A2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266500; cv=none; b=T02FNp8zBCrON6Zn+SmesSbi0IJ0vAl6fTmh7ts3PbmKQIQZ8J3j1CMwf0vLcJdUAjsPlcyj8b6+VoRjn8Q6GjkPJoQsZMMighrW1F9Mikjn9jt5yitqhs6tqmAAu6szEN1G4OaW3W9uxCRZX4u6eokVhBoFKx+/asPJ8vyLG3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266500; c=relaxed/simple;
	bh=WxJ+IfMX+isGsBEuW7oDq7IMsrPdaJvA3U4JaY2D7ao=;
	h=Subject:Date:Message-ID:MIME-Version:Cc:From:To; b=emjSLp0r6L1kws4qYuVthB/8+VzI4mOA4yNR5EFslWu8OR6GqFtWWCgjJ+ozhTlJtf7wfY4Oc6TBOR8XIILrwzFtOzVi5ICL/9zPpOJm8UMnEfodKCt+Rpen4BjO/KiZCwcfZOdGjbMGZHaw9GbHBcv2oUnnJ5KOAzWzcNsUSbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pVxjARHj; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d150e8153so2077707b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722266497; x=1722871297; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=SoEKborZDLLspJ4C4ZlzVfaOM/BQ3q5zicx1YXxsFHQ=;
        b=pVxjARHjSpP1p/xKOsAzam18E5QD0Cjj+m5SUeMKuTBFIzacKIvZfG1z4Kz3l0/M5q
         nBQffQhREYyWHRJRDQnzHHI2OIhNPliy6QioBUmtDODu/C4wfewt+Ob/xi+dnfXxNbyX
         eZ7gVfH4ldNo//I2YfpHCDBSKRBSQuP0JN/FOJEXowoaBA0sjfzApmm0cdFfg0AkL5Rc
         tN8CFKMBC0yczzRbMYSizdsfMs4OZb+3NehIpoZTKvukBWydNU/IoH0TzIJ9t7DEIOOc
         MqXzKL+CSbo2wroJFERegYPyBfz6Vbh9l/IpXWwecHCwCPMCyTVHwY3AR7CCgSPjvpVU
         xFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722266497; x=1722871297;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SoEKborZDLLspJ4C4ZlzVfaOM/BQ3q5zicx1YXxsFHQ=;
        b=ooLVlWctRxWQZ170T/pLXths1GfQXCkeqsRw1jj7dezWlmKYVsH0oCnx4I4D0ulCnq
         cnJBRqwcASHh8wtL0CKUndt2z9RJYBLhIy9qRtt+g9nw03XkWLPARz2frcsNAe20+6Hy
         PirNssMv/7wb6I60Z+accELRWR+PxQTDYW97gG+RGmGmyKM6uLvx2/ohcvJuJknE5Nzx
         STcJT1VWoMKq2SP8nwaPp1zWNIfF8jPkFMbg5HbDhwrccY7+ufQOx0HdbhBmj5A9nEjK
         BlKQIo6WBcWDMtKuhfDfV1BlhvD7Z3kuWL5DjO8BRPXKnNnrLJNVBvuKgP4DgbIL4ly4
         QsNw==
X-Forwarded-Encrypted: i=1; AJvYcCUomwael6w6A6819ptLeh5MtTKgr5G79NadsEmebBLWdXVAAzHRj7p8Y+OD15jhvYHKjHyEkk//FDWZm9gRgCGdWCCm+TIhzkJCgbpC
X-Gm-Message-State: AOJu0YwGcrqw6ERy4eYdBsakmYweICEwsKRIE5h0hmXbDY7xT9f3fqBx
	Vk3YPBzVts7rZOGDuTijdadrMPHs5XhdJW9CystCt69riFlzVr6znuzHRihrvB4=
X-Google-Smtp-Source: AGHT+IG03b3b3+OQRrIK9p7ls70IDSdQ0ZmBZp1SWkhBLAAGm2gwiMIdpOYSSQpe4J9R4tOmddPoEw==
X-Received: by 2002:a05:6a00:8596:b0:70e:aa44:39df with SMTP id d2e1a72fcca58-70ece73f470mr12009859b3a.1.1722266496972;
        Mon, 29 Jul 2024 08:21:36 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f816da89sm6305748a12.20.2024.07.29.08.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 08:21:36 -0700 (PDT)
Subject: [PATCH] resource: Elide a conversion warning on 32-bit
Date: Mon, 29 Jul 2024 08:16:53 -0700
Message-ID: <20240729151652.15063-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
  ilpo.jarvinen@linux.intel.com, Greg KH <gregkh@linuxfoundation.org>, bhe@redhat.com,
  alison.schofield@intel.com, Palmer Dabbelt <palmer@rivosinc.com>, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: bhelgaas@google.com

From: Palmer Dabbelt <palmer@rivosinc.com>

I recently ended up with a warning on some compilers along the lines of

      CC      kernel/resource.o
    In file included from include/linux/ioport.h:16,
                     from kernel/resource.c:15:
    kernel/resource.c: In function 'gfr_start':
    include/linux/minmax.h:49:37: error: conversion from 'long long unsigned int' to 'resource_size_t' {aka 'unsigned int'} changes value from '17179869183' to '4294967295' [-Werror=overflow]
       49 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
          |                                     ^
    include/linux/minmax.h:52:9: note: in expansion of macro '__cmp_once_unique'
       52 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
          |         ^~~~~~~~~~~~~~~~~
    include/linux/minmax.h:161:27: note: in expansion of macro '__cmp_once'
      161 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
          |                           ^~~~~~~~~~
    kernel/resource.c:1829:23: note: in expansion of macro 'min_t'
     1829 |                 end = min_t(resource_size_t, base->end,
          |                       ^~~~~
    kernel/resource.c: In function 'gfr_continue':
    include/linux/minmax.h:49:37: error: conversion from 'long long unsigned int' to 'resource_size_t' {aka 'unsigned int'} changes value from '17179869183' to '4294967295' [-Werror=overflow]
       49 |         ({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
          |                                     ^
    include/linux/minmax.h:52:9: note: in expansion of macro '__cmp_once_unique'
       52 |         __cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
          |         ^~~~~~~~~~~~~~~~~
    include/linux/minmax.h:161:27: note: in expansion of macro '__cmp_once'
      161 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
          |                           ^~~~~~~~~~
    kernel/resource.c:1847:24: note: in expansion of macro 'min_t'
     1847 |                addr <= min_t(resource_size_t, base->end,
          |                        ^~~~~
    cc1: all warnings being treated as errors

which this elides via an extra cast.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
Not sure if there's a better way to do this, but I didn't see any
reports yet and my tester is failing so I figured it'd be best to get
something on the lists.
---
 kernel/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 14777afb0a99..6459561b746e 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1845,7 +1845,7 @@ static bool gfr_continue(struct resource *base, resource_size_t addr,
 	 */
 	return addr > addr - size &&
 	       addr <= min_t(resource_size_t, base->end,
-			     (1ULL << MAX_PHYSMEM_BITS) - 1);
+			     (resource_size_t)((1ULL << MAX_PHYSMEM_BITS) - 1));
 }
 
 static resource_size_t gfr_next(resource_size_t addr, resource_size_t size,
-- 
2.45.2


