Return-Path: <linux-kernel+bounces-200319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BBE8FAE66
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7A51F23A69
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CDC144D3B;
	Tue,  4 Jun 2024 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="G9yMqb+5"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485351448FA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492161; cv=none; b=YK5CVSpUMN8puR6ee4fkFX5DhhiQgLemKRhV1IOly3E1osjX1Lt1xyzHyB+bLF1SyxBDHstCb2d0XCQn1DwvGm6CZymIMLJ6szk7xqy+r6uoiD8IABU28igQD8lkabJtUZaa5it84++cUZtQFLNhj3StQRgHNgVeTTuqaZ0p0uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492161; c=relaxed/simple;
	bh=Cd4N3ppnIKo96UjuDYKqNAWCqoo7sSNwgSH8lYyi25w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f+f+zvXaeny9aQHjTcAV+3iDhe3vyCXpW6nrr8NvCVowdZEaoafIkpEFD2vVVQnzdM6ufz039ecHzR7cyFX9iaG62G1d88jtoPD1kzBrdHTXZ9EMZ7A78IfX8OwDR7wW7mf/Gt31LIXOu/SpvPOz40iosS6XjeArFU2ehvlvvZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=G9yMqb+5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso75046666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717492157; x=1718096957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwBsgjYa0IXOImdBe/4+bRIQcCY8SgWsOwsbDkpj0Qk=;
        b=G9yMqb+5y+fskP0M+Dp9D2JAnx5D8aYx6BCHwZ11OJr63fw0LbLiW79W8MpJHI1EeS
         /1Sj3Qg/sginyzX/kOyj8Pzszf7n3BZpDu/M8OnKRvlsD96QxTACULYN4rybY5zayT6o
         EPYXI4dZREftrLIz6fzv6jvSsG55lCpOcBRWKinTSpmKDLL7GdF0SO9u2VeCB0YCyR63
         L0q3NNaz2y1K9xR4lCXg/mtylQHeIxMt6UmlHJG0rD6GnSIvJTe4M9UDeKOm017tWpiU
         VO1gHdwbTJyrU59cGsbT2KiWrVzDlLmki+0zqBipRA5lCHKI/oG9jGAY3vsnNRTKAnGh
         ptow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717492157; x=1718096957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwBsgjYa0IXOImdBe/4+bRIQcCY8SgWsOwsbDkpj0Qk=;
        b=I/8ca5HqSmI8ZrvaA0g0So9IVudomKv619mOXAdVimx7jgQ4vrL90gjSjpcgjltsnd
         PZ+mnR5G0jzKR39cjF6WyCuKL8NJs9Vl1mSmYK/4YpxVQZIFI4NptQtRKrrNg7k2Hr5J
         UVfheR5niZPfGH4JflaFJPbc2zmGYfjIRDUvQ+WdbFXr3ZFXUwGIhxkJ9E8w0Z0tEoWB
         WBpOFkWatFHl4JmTjMe7g6vLuvmmJmBLK0DuygPG3CRU+Y8f9Gxte5uKG2ds1zYOPKNT
         6Bo4FfZ9NZkycKYQuNHzZgJxvyL5MGXdAitSQzwi07P0FXSFivW7rnu3wU9LRbUZ/Pyf
         d14Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkXEDPqSNvAVs1hi+Tgjmhr7VdA/d+wew0ErHZ+irEnHkcH9cOfyX/hbIL71uYZhHofBFmZtVlZrETUgV6Eo8gTNu782a6jGx7C73h
X-Gm-Message-State: AOJu0YyalvCPU5UP1LCm3x2ywC4h8QPnjji7or51JRhn4GOR84zJFUA9
	vsTeHopnlxRLTjsEgjpgwEdRGzlxH5TUaRjE4Lc1kxkUvXH3DwT484qrRocrWG0=
X-Google-Smtp-Source: AGHT+IHIJT2BE+IHPYnFS/7wmnu2XAw4mULYk5HJdR9W0oN6DhpUIE6zi6XQ1spmCyvvSqUKhBaXJg==
X-Received: by 2002:a17:906:4f0d:b0:a68:c6e5:3574 with SMTP id a640c23a62f3a-a68c6e5360bmr467546066b.75.1717492157591;
        Tue, 04 Jun 2024 02:09:17 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f4f9200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4f:9200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fa49e66fsm328376766b.129.2024.06.04.02.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:09:17 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	sfr@canb.auug.org.au,
	david@redhat.com,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v6 09/15] linux/mm.h: move devmap-related declarations to mm/devmap_managed.h
Date: Tue,  4 Jun 2024 11:08:39 +0200
Message-Id: <20240604090845.2182265-10-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604090845.2182265-1-max.kellermann@ionos.com>
References: <20240604090845.2182265-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare to reduce dependencies on linux/mm.h.

put_devmap_managed_page() is called by put_page().  Moving it to a
separate header allows us to move put_page() to a separate lean header
as well.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h                | 20 +------------------
 include/linux/mm/devmap_managed.h | 32 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/mm/devmap_managed.h

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7be75960e7e1..6ae6961e83bf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_MM_H
 #define _LINUX_MM_H
 
+#include <linux/mm/devmap_managed.h>
 #include <linux/mm/folio_next.h>
 #include <linux/mm/folio_size.h>
 #include <linux/mm/page_address.h>
@@ -1354,25 +1355,6 @@ vm_fault_t finish_fault(struct vm_fault *vmf);
  *   back into memory.
  */
 
-#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_FS_DAX)
-DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
-
-bool __put_devmap_managed_folio_refs(struct folio *folio, int refs);
-static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	if (!static_branch_unlikely(&devmap_managed_key))
-		return false;
-	if (!folio_is_zone_device(folio))
-		return false;
-	return __put_devmap_managed_folio_refs(folio, refs);
-}
-#else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
-{
-	return false;
-}
-#endif /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-
 /* 127: arbitrary random number, small enough to assemble well */
 #define folio_ref_zero_or_close_to_overflow(folio) \
 	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
diff --git a/include/linux/mm/devmap_managed.h b/include/linux/mm/devmap_managed.h
new file mode 100644
index 000000000000..50357b304d68
--- /dev/null
+++ b/include/linux/mm/devmap_managed.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MM_DEVMAP_MANAGED_H
+#define _LINUX_MM_DEVMAP_MANAGED_H
+
+#include <linux/types.h> // for bool
+
+struct page;
+
+#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_FS_DAX)
+
+#include <linux/jump_label.h> // for DECLARE_STATIC_KEY_FALSE(), static_branch_unlikely()
+#include <linux/mmzone.h> // folio_is_zone_device()
+
+DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
+
+bool __put_devmap_managed_folio_refs(struct folio *folio, int refs);
+static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
+{
+	if (!static_branch_unlikely(&devmap_managed_key))
+		return false;
+	if (!folio_is_zone_device(folio))
+		return false;
+	return __put_devmap_managed_folio_refs(folio, refs);
+}
+#else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
+static inline bool put_devmap_managed_folio_refs(struct folio *folio, int refs)
+{
+	return false;
+}
+#endif /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
+
+#endif /* _LINUX_MM_DEVMAP_MANAGED_H */
-- 
2.39.2


