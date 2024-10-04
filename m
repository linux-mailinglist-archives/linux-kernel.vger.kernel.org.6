Return-Path: <linux-kernel+bounces-350763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A7A99093A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071AF1F212E9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159401CACE6;
	Fri,  4 Oct 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G3iHADMx"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C88A15B0FF
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059523; cv=none; b=ZgQz2RfR6dhVDvZTXnCk4wFju0qFQIj5AG6kw53EOZi0qEpXEa9GlxKyY39/3P16r51rCpHOfEkoLpDWgEUdtrqNCjVLUtuXJ6USBjjL25OQVRPxPzuSq85BjFmIoeJD8wiy6bRFO5r4ArAvC404Ly7Y+NzOPn18zAHCOaz5Awk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059523; c=relaxed/simple;
	bh=sBj7fTJoQaZYxklmzS3W4vzzZjdBvQS/D7Q3yJhEUYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kYVRaZZG6Vkmegeox45TY2zstBLiFiIAEEGxQ8TORiyAKDQzKVFowD1UJVLkqTi0OPfNJOiYF7LiHysCEFQ7SIebR/Q/8bkF6C75VbT9+Xoav4q6gF5Jt22eXb+oZJol5oyKj5wZjRsS4+Bzy5B6TEhewjtK98NOfEMkKO0eZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G3iHADMx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b0c5895aaso2238965ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 09:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728059521; x=1728664321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K60b0HU9ftXyJtge8qd284Y8viY6O8DUlfpDN9STjVM=;
        b=G3iHADMx83xrnbpKDkaz8RmodhKhdpA83XgTyAgXGX1Ojva1ntISNIUSkyQ6pYv1CG
         aa0315KZUx1fHBc/TwX7m1jqJrfVvDdYnDA1+Ck4nD7CFh233WUexay/K0BrhsVkePiN
         hEOw+SnVaWAcXaArtxMV7BoytJ4G3WPuKvD5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728059521; x=1728664321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K60b0HU9ftXyJtge8qd284Y8viY6O8DUlfpDN9STjVM=;
        b=hACM1F6+WI/5JTE/OUBDmgieSKtO2rbPDjyJnnLevuFk9N2IG1zWUaDdLNxXouiR+V
         dSMN8T3xke8yfFHOOATWq9myqM3LDcEklv0GTWBPI1ugFX0Et4K7PDQYZg8HFQq207L5
         TWuEtPxY3kw8PtvFHGkHZY3UC67C71Ah44MN8zHzqe9Q9oVEsF6y3mKjP7wRd7XPdFPw
         FpEBI5cnLJNZ6ZbqoJSoX+DgS+z3T0lY5qyAOIa9QAZSHpKwFy/0mYtK0SSU0NOuJU1K
         4QcBaK+6jeat0nj73W2YUTxIhjlPvHxpmmQEegUgpCTVwCMoUyAyahDeofAtHTwe14MV
         A9Kw==
X-Gm-Message-State: AOJu0Yw/xGxILFoZw46o8NYW6rCjxutQYA5lS/mxaYgJarr7VLufvr0f
	ZUbA+IymNagLQpM/3jfkdKLUFbP13Xt3PsW8CpFusD3flgJ3A0ausgWB8HDfyQ==
X-Google-Smtp-Source: AGHT+IFSrVTmBEuZDVkZdKrrQvLg1DhltJ6h+f4mR5YU4xMyntpg8h23nyzBrsG074u46Uhkd92ffg==
X-Received: by 2002:a17:903:32cc:b0:206:9f2e:1029 with SMTP id d9443c01a7336-20bfdf72cd1mr18918805ad.2.1728059521290;
        Fri, 04 Oct 2024 09:32:01 -0700 (PDT)
Received: from localhost (99.34.197.35.bc.googleusercontent.com. [35.197.34.99])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2e20b0f6380sm100765a91.40.2024.10.04.09.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 09:32:00 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	ojeda@kernel.org,
	adobriyan@gmail.com,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	mike.kravetz@oracle.com,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	hch@lst.de,
	peterx@redhat.com,
	hca@linux.ibm.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	nathan_lynch@mentor.com,
	dsafonov@virtuozzo.com,
	Liam.Howlett@Oracle.com,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	lorenzo.stoakes@oracle.com,
	Jeff Xu <jeffxu@google.com>
Subject: [RFC PATCH v1 0/1] seal system mappings
Date: Fri,  4 Oct 2024 16:31:54 +0000
Message-ID: <20241004163155.3493183-1-jeffxu@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@google.com>

Seal vdso, vvar, sigpage, uprobes and vsyscall.

Those mappings are readonly or executable only, sealing can protect
them from ever changing during the life time of the process.

System mappings such as vdso, vvar, and sigpage (for arm) are
generated by the kernel during program initialization. These mappings
are designated as non-writable, and sealing them will prevent them
from ever becoming writeable.

Unlike the aforementioned mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime [1], thus sealable.

The vdso, vvar, sigpage, and uprobe mappings all invoke the
_install_special_mapping() function. As no other mappings utilize this
function, it is logical to incorporate sealing logic within
_install_special_mapping(). This approach avoids the necessity of
modifying code across various architecture-specific implementations.

The vsyscall mapping, which has its own initialization function, is
sealed in the XONLY case, it seems to be the most common and secure
case of using vsyscall.

It is important to note that the CHECKPOINT_RESTORE feature (CRIU) may
alter the mapping of vdso, vvar, and sigpage during restore
operations. Consequently, this feature cannot be universally enabled
across all systems. To address this, a kernel configuration option has
been introduced to enable or disable this functionality. I tested
CONFIG_SEAL_SYSTEM_MAPPINGS_ALWAYS with ChromeOS, which doesn’t use
CHECKPOINT_RESTORE, to verify the sealing works.

[1] https://lore.kernel.org/all/CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com/

Jeff Xu (1):
  exec: seal system mappings

 .../admin-guide/kernel-parameters.txt         |  9 ++++
 arch/x86/entry/vsyscall/vsyscall_64.c         |  9 +++-
 fs/exec.c                                     | 53 +++++++++++++++++++
 include/linux/fs.h                            |  1 +
 mm/mmap.c                                     |  1 +
 security/Kconfig                              | 26 +++++++++
 6 files changed, 97 insertions(+), 2 deletions(-)

-- 
2.47.0.rc0.187.ge670bccf7e-goog


