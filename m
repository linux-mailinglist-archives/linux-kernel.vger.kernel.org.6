Return-Path: <linux-kernel+bounces-188000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4712D8CDBB1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3E71C21926
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0805127E0D;
	Thu, 23 May 2024 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKDdJwik"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABD5127B77
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716498063; cv=none; b=Kw5ntYiOdRRqQ5u4WZuUGvLovNVeq1dbbN+MZlRNdsdRFHp7KFgNXUXN8XA72E/a3lMk9sRyb72jyDhfwVVex2osEqNK9rbnceQtl/+xrVYjmUEWkRMdycP9LhnPhnVWc1m5lQtoHF2n3mnoaK8SXzHfZCE47/nx2y2LK2FptrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716498063; c=relaxed/simple;
	bh=P10fqiAxrikOC2Ee4Nfn8mCd7HDQ6xw3rggtlBpeZoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nDIDMQGjt/AnkmCpO9v+RXjTvOKSUHC6vkD1zrLzSLvB+DfxvHIOZId4jcVfbOJEYsA66sSdV+Q90X2hUkuw1B7wzPHwsVgFmN3u5S/0NZMpLGSWnXGnB4yOoQ4/nYru+MbskDfoQIkCLxXEEzWmQnmq8OCt5gSgedNxVAnaPsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKDdJwik; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f32448e8fbso17455875ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716498061; x=1717102861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fz6C4rTluib+JFtAS5ELTQqLXEuP3SgExV8pay9i7vQ=;
        b=PKDdJwikaE99iiTCcWgkSViJsDOzOKlRTZBYZD/cBWRgKxxoXrOvL75VN1BUAbVpMZ
         Fjac7ocQ0Iy0dM8wI8+8/KOPZaa42V8k+AxKkqy1QexdM4ifTpAhoDsrLnQTgZ0GN1Or
         LPml+BdrMe7RqS5ybCOiyUtsm7konU4heo1a4/E+JaizRVgPgemuYIFIf6OLuMgzQAxH
         KWr/4fOoIAFBW+Usmjv78SFwU9mJLrfsB145eOkfUccLoagLS1jrlpIXb+h4h5Ijjr21
         oswl86pLZnoS6CHJQO0+0gOWzABtThwn6k/tVtKWOrKQc75yHg3bpqsNVJFXOIRqdQ7J
         BS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716498061; x=1717102861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fz6C4rTluib+JFtAS5ELTQqLXEuP3SgExV8pay9i7vQ=;
        b=CeLuw2Zm3KsqelWg9rVGGm+NK38Z4SRaOmaqj1YOxlRHBgiwTAfrXWzfFgp9yD7blU
         ku7WooVt9GLYTcAQuN3uAkTyaloiRy3Ve7NczLtK8Yhy4x2F9452rtaZKg0GhVWX3dBW
         bOSMsGPeU+Dr1cikUjAIkwWK+iUX9uh+H7uFYdOV5bOdSrjsrk9ZC5opZbvJO1cPnJsX
         zv7cWT/qPBHagNFYVak8WQtjFpxnD5znKD3xS6z4Q2VhilwXUu6wBDVHdYtSrgA5HilQ
         FhT1xxr9JksLEknLmXrWC5jFuqjIbJoxwp78waZzSHHuFg1H5LLTHnxpwEGCJbBpV2it
         hrfg==
X-Forwarded-Encrypted: i=1; AJvYcCW9wY0V1C4K4yrgcboknlnCUUgMMy8/FHWxSSW6mXUDNUQh3lon8CYkqixZ3Kj4npBPAEmRLlqhrDJpHQWfWjTTO9GAGVjrYcbdiuk/
X-Gm-Message-State: AOJu0YypnrJwRZ3SR3HDKWKCcUesUHT+gYwSR1VPB+1IJumjEY0ud9+U
	wiabPlBexnkqF5QO4po5DBFpCvaFYsldj/GO+Kkf7uMqn0263ltH
X-Google-Smtp-Source: AGHT+IFS23wiPQKouuaen4geZNnXoXPiVbTmYmxSZgo7tQLACdNxUr3Ngi4qQ0W+oJANbqvL4AK0Kg==
X-Received: by 2002:a17:902:ce92:b0:1f3:3d07:d6e3 with SMTP id d9443c01a7336-1f448740bfemr4641085ad.34.1716498060780;
        Thu, 23 May 2024 14:01:00 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c797ca5sm261005ad.71.2024.05.23.14.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:01:00 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: lkp@intel.com
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	oe-kbuild-all@lists.linux.dev,
	v-songbaohua@oppo.com
Subject: Re: include/linux/huge_mm.h:285:undefined reference to `mthp_stats'
Date: Fri, 24 May 2024 09:00:45 +1200
Message-Id: <20240523210045.40444-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202405231728.tCAogiSI-lkp@intel.com>
References: <202405231728.tCAogiSI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c760b3725e52403dc1b28644fb09c47a83cacea6
> commit: ec33687c674934dfefd782a8ffd58370b080b503 mm: add per-order mTHP anon_fault_alloc and anon_fault_fallback counters
> date:   2 weeks ago
> config: s390-randconfig-r005-20230226 (https://download.01.org/0day-ci/archive/20240523/202405231728.tCAogiSI-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240523/202405231728.tCAogiSI-lkp@intel.com/reproduce)

> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405231728.tCAogiSI-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    s390-linux-ld: mm/memory.o: in function `count_mthp_stat':
>>> include/linux/huge_mm.h:285:(.text+0x191c): undefined reference to `mthp_stats'
>    s390-linux-ld: mm/huge_memory.o:(.rodata+0x10): undefined reference to `mthp_stats'
> 
> 
> vim +285 include/linux/huge_mm.h
> 
>    279	
>    280	static inline void count_mthp_stat(int order, enum mthp_stat_item item)
>    281	{
>    282		if (order <= 0 || order > PMD_ORDER)
>    283			return;
>    284	
>>   285		this_cpu_inc(mthp_stats.stats[order][item]);
>    286	}
>    287	

Thanks, would you please test if the below patch fixes the problem,

From: Barry Song <v-songbaohua@oppo.com>
Date: Fri, 24 May 2024 08:50:48 +1200
Subject: [PATCH] mm: huge_mm: fix undefined reference to `mthp_stats' for
 CONFIG_SYSFS=n

if CONFIG_SYSFS is not enabled in config, we get the below error,

All errors (new ones prefixed by >>):

   s390-linux-ld: mm/memory.o: in function `count_mthp_stat':
>> include/linux/huge_mm.h:285:(.text+0x191c): undefined reference to `mthp_stats'
   s390-linux-ld: mm/huge_memory.o:(.rodata+0x10): undefined reference to `mthp_stats'

vim +285 include/linux/huge_mm.h

   279
   280  static inline void count_mthp_stat(int order, enum mthp_stat_item item)
   281  {
   282          if (order <= 0 || order > PMD_ORDER)
   283                  return;
   284
 > 285          this_cpu_inc(mthp_stats.stats[order][item]);
   286  }
   287

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405231728.tCAogiSI-lkp@intel.com/
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/huge_mm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c8d3ec116e29..09c5744d9124 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -278,6 +278,7 @@ struct mthp_stat {
 	unsigned long stats[ilog2(MAX_PTRS_PER_PTE) + 1][__MTHP_STAT_COUNT];
 };
 
+#ifdef CONFIG_SYSFS
 DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
 
 static inline void count_mthp_stat(int order, enum mthp_stat_item item)
@@ -287,6 +288,11 @@ static inline void count_mthp_stat(int order, enum mthp_stat_item item)
 
 	this_cpu_inc(mthp_stats.stats[order][item]);
 }
+#else
+static inline void count_mthp_stat(int order, enum mthp_stat_item item)
+{
+}
+#endif
 
 #define transparent_hugepage_use_zero_page()				\
 	(transparent_hugepage_flags &					\
-- 
2.34.1



