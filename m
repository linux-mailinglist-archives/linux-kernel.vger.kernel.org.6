Return-Path: <linux-kernel+bounces-271665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B713594514E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47C61C22C87
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732A01B9B2B;
	Thu,  1 Aug 2024 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EYyfCYdP"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597021B9B23
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722532132; cv=none; b=OTqLctRg8IthKeUcxVF6pinSX1pFtsSec0deEfjYTaqXPY7Hgivq2qLIQ3krxhExx2L+6l0dm+kWFnZ4uTNMmNLU8MfMPi324bc1jV6vz3hQFshbbyZa/nocp+i4GrtjkKO7iHBIxcT5AsSGhYDtUiH5/WQsEzE4lM8LjMDndgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722532132; c=relaxed/simple;
	bh=opwdgHvj/stIDa3HZ1/Op1GuDUTBQR8Ot2AnxrruNYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ace4bbrwkI17litPC/KrLhiKSviVjLNklroqvk3N32qbPyBEDpOvYVwXD9+99vDLCoZdrV6Qa/XzKBrUu3rAII8lHTxTr1sVD5xE30Fjt1TTmxDv4xd51kX+40/pFywur4fZb3AR7KJK1M3Ji6aXDft17FNaGHcIp/l3P7A2XpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EYyfCYdP; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb576db1c5so4744670a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 10:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722532130; x=1723136930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSvjFG11eFXXPisXUSuvwXh3UtwiwX8QldwHUp+YOlQ=;
        b=EYyfCYdPauRJYEDgRyWBwJ8CUOBa85fIhAHN4iknIug6hzddnijl0O5Vd8jB/vRbOt
         tPaA7f7NFjnOgjfZEgC1nXwX0YgScvg8v6hwAl+gvVXOamg2kzkg8enfExI3DTriDHHZ
         eDVL4Tj6nSgWtLd7snDT+X0f235ZvuiPts0cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722532130; x=1723136930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSvjFG11eFXXPisXUSuvwXh3UtwiwX8QldwHUp+YOlQ=;
        b=eQJ6OJBdXEjEhQjGdiCSeVZ9avBgRQba2iSXQIA6I0BhHuuZ92OufQjgx1k0M8CPPD
         urLOJK8co3ZDIMqyP3QHrvbPUGHdwOGb4b6qikqidwsnLSPODXapdcdYBiHNj8DjsLD1
         RWFPO5fS3vtO+W5fi6F5A9IiOx7lZQw19TD9rzMTy5gUNtbLZrO/PRiY9tcQiNT+YPxj
         vSjQJmIspRouXZhZbgFEHfNhKWQzV7fcvfmNAvjMEQfEkO12S/f6JeYiSf+0OBJOFz9S
         GBZUPDvaghhdyar8bE4RQGek02umrokxjSu+Xs1tYpabMIr4OpvD7SnYf/xDUefFMmJU
         QiwA==
X-Gm-Message-State: AOJu0YyZern1JTqE0FkmlcXUpu0Oo2EWNNtg0ndU1h99jclHazWIqHRX
	1RT20C2nz9+OfIFQBAsKxcAfGJbKaO7g0ihou+vOKNsuiajcL6ZROLeH/o4YZQ==
X-Google-Smtp-Source: AGHT+IH0NnCLuyb7HngEFKEFyvGr5nBufmB5AXTNrSM7ABBYmr31HM+iM4rvpLqggxwU65VWSqTv+w==
X-Received: by 2002:a17:90b:3849:b0:2c9:5f45:5d30 with SMTP id 98e67ed59e1d1-2cff9526d3bmr979842a91.26.1722532130487;
        Thu, 01 Aug 2024 10:08:50 -0700 (PDT)
Received: from localhost (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2cfca2a8330sm2588490a91.0.2024.08.01.10.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 10:08:50 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	adhemerval.zanella@linaro.org,
	ojeda@kernel.org,
	adobriyan@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v1 1/1] binfmt_elf: mseal address zero
Date: Thu,  1 Aug 2024 17:08:33 +0000
Message-ID: <20240801170838.356177-2-jeffxu@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
In-Reply-To: <20240801170838.356177-1-jeffxu@google.com>
References: <20240801170838.356177-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Some legacy SVr4 apps might depend on page on address zero
to be readable, however I can't find a reason that the page
ever becomes writeable, so seal it.

If there is a compain, we can make this configurable.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 fs/binfmt_elf.c    | 4 ++++
 include/linux/mm.h | 4 ++++
 mm/mseal.c         | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 19fa49cd9907..e4d35d6f5d65 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1314,6 +1314,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		   emulate the SVr4 behavior. Sigh. */
 		error = vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
 				MAP_FIXED | MAP_PRIVATE, 0);
+
+#ifdef CONFIG_64BIT
+		do_mseal(0, PAGE_SIZE, 0);
+#endif
 	}
 
 	regs = current_pt_regs();
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c4b238a20b76..b5fed60ddcd9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4201,4 +4201,8 @@ void vma_pgtable_walk_end(struct vm_area_struct *vma);
 
 int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
 
+#ifdef CONFIG_64BIT
+int do_mseal(unsigned long start, size_t len_in, unsigned long flags);
+#endif
+
 #endif /* _LINUX_MM_H */
diff --git a/mm/mseal.c b/mm/mseal.c
index bf783bba8ed0..7a40a84569c8 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -248,7 +248,7 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
  *
  *  unseal() is not supported.
  */
-static int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
+int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 {
 	size_t len;
 	int ret = 0;
-- 
2.46.0.rc1.232.g9752f9e123-goog


