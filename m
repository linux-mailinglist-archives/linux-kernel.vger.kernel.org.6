Return-Path: <linux-kernel+bounces-186794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2048CC941
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B2C1F220FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C531494C8;
	Wed, 22 May 2024 22:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU7JfUok"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9671494BF
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716418721; cv=none; b=LCDCd29zChsyDJ0zoZ+8m8j56FlJUczG8g/TgxMW9WNGLS+2h1ZEEdM/OxpHoBs3YR4BJ4ug7OLsvcMDaIEqe8kCXmKhikHnjkI07F2xrQUQN32yaXBVbxCnuHMh4VbdtU6rMy4TrY3JBN4fLYsoScvow8nwyvsvWNBTOV8ovSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716418721; c=relaxed/simple;
	bh=2/WOKg2UsryvuOjF0tR4aFm9e3Gmo9fdiQK9MaRQs0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=P9KSjMB/mgFB+nvwHKMya4Zkoje6Sh3wTDLfViWJ3StB+9lvjE/Eyu55wc+9XdICuZ+bAfb8yzHBqXyHZ3Wr/sudRELmMSfVClNA28LgaaG8rj+vb4DDEgjX/8FXybo3gw7YV/5fBIqivoCFHb0O+J9+EwfGm/gjApSns26bjxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BU7JfUok; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f44e3fd382so2831293b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716418719; x=1717023519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F29FxmiJU2YNXfIAoVsgdy2y8g4QcTv30E2TRMskf9w=;
        b=BU7JfUoknrK48JusYMIxANGp4Xltelt36LuBKJPMAOYHd/S1+G8r5lcOduQybjYpjf
         q0VLet7mnbNzpqetq1Oc363kn3/uqt8jn2vS3QU57AHcXJGLzC4bolup1ianatSwf4MP
         9rFQq1EeZnydHEk4UJg18oeFzPPSo4fovlrL6tJmcymFgJhgx3fNwC5LsYk5cX0S6eV9
         ID5AswqCLjqPXYFUQLRPXJv00O0FAZDO1oS/23NwV8iDkSGqq1lF6hGHYVN/EZySMNvV
         LulWNH7OSk8psXs3On4umWlTpBlQTrrlKltbTqDjgg3UA+co+Xhy8TLn52QTSaYKnA4y
         BBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716418719; x=1717023519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F29FxmiJU2YNXfIAoVsgdy2y8g4QcTv30E2TRMskf9w=;
        b=lHuCbHW7ZRCyGhrKxPJKrbMNO83izB+zPyXG1YVqKJ8atf/Ie18WP1tUCb2IvOmfIZ
         /OrbIpjyk4XrcfVFGPxu2k+vrGLKnL0jFNZbuIcq0j5D0JnniB/RjLMXLurzGli1Eupj
         GhuH0rFp0Hdb2C8XwWyyzM0jYR16xDmyCht2RW+dvp5+qkzpP5OBBw+6vxTiBwHH57rb
         yNRQMMU/tJztFZ9+6zduPkZL7DBdxMk262ZgzSyERfkFNyme2quh+uUaEke7SzNWEt3u
         fuS55ZguB65WbrlY2sx4KQTKDDZkOhh25ln5lSeLrAdBLtnyOqZaGuADR4UHwZocIDPY
         zeJg==
X-Gm-Message-State: AOJu0YzctTR7AmbdRmbYSz4S6sJ0ZpcyhILSVmDX5cUkXQJ38zwvMEdw
	tc45VAoD6Du65n9k9tI8aAsclE31y52JuKg9Dx6sla5myAC9jwTGxgjJkg==
X-Google-Smtp-Source: AGHT+IH6wH03Yfk/IYbMHWOePxbAmrGG18YvuLW+vaqOqRN32MhJyA7J41ir0sYCJqm2lLy3jMpWmQ==
X-Received: by 2002:a05:6a00:9285:b0:6e7:20a7:9fc0 with SMTP id d2e1a72fcca58-6f6d620bb5cmr3564729b3a.34.1716418719336;
        Wed, 22 May 2024 15:58:39 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a9d981sm23534566b3a.94.2024.05.22.15.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 15:58:38 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yoann Congal <yoann.congal@smile.fr>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH] gcc: disable '-Warray-bounds' for gcc-9
Date: Wed, 22 May 2024 15:58:30 -0700
Message-Id: <20240522225830.1201778-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

'-Warray-bounds' is already disabled for gcc-10+. Now that we've merged
bitmap_{read,write), I see the following error when building the kernel
with gcc-9.4 (Ubuntu 20.04.4 LTS) for x86_64 allmodconfig:

drivers/pinctrl/pinctrl-cy8c95x0.c: In function ‘cy8c95x0_read_regs_mask.isra.0’:
include/linux/bitmap.h:756:18: error: array subscript [1, 288230376151711744] is outside array bounds of ‘long unsigned int[1]’ [-Werror=array-bounds]
  756 |  value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
      |               ~~~^~~~~~~~~~~

The immediate reason is that the commit b44759705f7d ("bitmap: make
bitmap_{get,set}_value8() use bitmap_{read,write}()") switched the
bitmap_get_value8() to an alias of bitmap_read(); the same for 'set'.

Now; the code that triggers Warray-bounds, calls the function like this:

  #define MAX_BANK 8
  #define BANK_SZ 8
  #define MAX_LINE        (MAX_BANK * BANK_SZ)
  DECLARE_BITMAP(tval, MAX_LINE); // 64-bit map: unsigned long tval[1]
  
  read_val |= bitmap_get_value8(tval, i * BANK_SZ) & ~bits;

bitmap_read() is implemented such that it may conditionally dereference
a pointer beyond the boundary like this:

	unsigned long offset = start % BITS_PER_LONG;
        unsigned long space = BITS_PER_LONG - offset;

        if (space >= nbits)
                return (map[index] >> offset) & BITMAP_LAST_WORD_MASK(nbits);

        value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
        value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
        return (value_low >> offset) | (value_high << space);

In case of bitmap_get_value8(), it's impossible to violate the boundary
because 'space >= nbits' is never the true for byte-aligned 8-bit access.
So, this is clearly a false-positive. 

The same type of false-positives break my allmodconfig build in many
places. gcc-8, is clear, however.

Signed-off-by: Yury Norov <yury.norov@gmail.com>

---
It has already been spotted in this thread:

https://lore.kernel.org/linux-kernel//457b9cbb-9a5f-47ef-9eac-3e4f135d6a96@intel.com/T/#mc833ceac1b05d7156a864dcfe21435d01d77a0d7

And I suggested to use the OPTIMIZER_HIDE_VAR() there. But now that I
see the warning disabled for gcc-10+, it looks simpler to just extend
it to gcc-9+.

---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 72404c1f2157..febdea2afc3b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -883,7 +883,7 @@ config GCC10_NO_ARRAY_BOUNDS
 
 config CC_NO_ARRAY_BOUNDS
 	bool
-	default y if CC_IS_GCC && GCC_VERSION >= 100000 && GCC10_NO_ARRAY_BOUNDS
+	default y if CC_IS_GCC && GCC_VERSION >= 90000 && GCC10_NO_ARRAY_BOUNDS
 
 # Currently, disable -Wstringop-overflow for GCC globally.
 config GCC_NO_STRINGOP_OVERFLOW
-- 
2.40.1


