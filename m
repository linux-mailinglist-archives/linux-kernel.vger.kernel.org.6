Return-Path: <linux-kernel+bounces-514361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C8AA355EE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA143ADC76
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F41E1917D6;
	Fri, 14 Feb 2025 04:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UdYFM98s"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D418FC9F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508827; cv=none; b=QyjbxsiJRD/37SUXBvoNMEXiU0ynWJnjzjyuPyBY8frC/kX0vCPMty4rF5nbD76ll4fBXRIW7sW2TQvSTxI+VUkOgBKY1fWBEx0sk0vcujtLowgOZyfaWbYfbNFniGUnXrkQAXWZhevvWiJ/pDyAxs6cd5a876HpyzCtgjE0iPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508827; c=relaxed/simple;
	bh=3bl4FZa1Jj9/SryddhJVpujsF+YKBcOIbQtdPgtbXnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TX2t7of7DsEcT/1E/imAWGJCVS+q/T4FbViIDOJHR6WR4Whnte1UbbR2nvcLo3WcEgIGvqyKoXPj99qZplnrG0TSxDzOjkChwQgzREy9LqhkEFFLuQlbpqvTsBVq96ZQ8q4X0GGgM1/M/NJCl0hZWPAnkXb6VJgWZ4vDspyc2wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UdYFM98s; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c8cf98bbso32562385ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739508825; x=1740113625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvgHEnC+lRfOrRLv2RIVOYlOBk4EIx2tIzOwTFt2Qag=;
        b=UdYFM98se8kl4KobKhRtHWD97BzEtVkFXufCI80+8os4v3p4trqh7cETGGCIy5uC5F
         XvagkRB51cr47Rg1R6rZoePCDAkHP+KSadNDafZJ1sI09JHYCPalQmNIod3ja7t1k9Z3
         ROXAKIw37K84VDOuPuGhMdODafpvr/pGvB3Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508825; x=1740113625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvgHEnC+lRfOrRLv2RIVOYlOBk4EIx2tIzOwTFt2Qag=;
        b=o1Vk4xZc2v0790I7EcsWxHs6DrIsfcbslzD0GXusgbsRuN45MFISDfoeHgfRjX9PWw
         5N8c6fTZnH40NgbiGpL7DLLJGE0vql44JfjsI+TZmdSLeG7potOdynmTC/7176xMVZFn
         INmDdFf/Wox1jzolbPTqu3zrbYJQDpL1GFi33WNRzSmJPvxFbB+LnQ82Y31gJ6GcIX41
         Rl2/uG+Hon8PwKU7Ve0jYkovtoF/eCCE3j2mwhXnaxrMwl/ddjllnYrD4KhwyonCBoPg
         gf5E/vrlKlWLptkfCCMew9fih62DcDsVoVMp/jCaMbt2RZdkwAWI2vMsBTaASNtVgIl/
         j4tQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8OwVWNfcHdbEHs8riGwCGudpW0aqxyBxP8AylUZf0piTrwZ5h3w4pz0q818zrwEClpikHONQzJYNJJ4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZdGXW2IRnApcnD9EmtUTeJAkDuJ2qBrNkH/L+A/TCI0KNRazm
	BR+R03hHkCwpDcFTJ766cs2eg/ypRg83WFyX+hQGSX7afcky9oBYBifg/nuDeA==
X-Gm-Gg: ASbGncsv7d/5QPXShj7d+okr7wwki6Hr8HuFPNwzQVZceSZGjAPR1WNV2KdmO3iwZLO
	l77p3rBOdbBMM2vH1g7/rcIWMIqYhlLAaSX0qn53QhWq5VZt+Xque1W9Ks+fd5ml7YKt9Bjh5BV
	v7SlLPk6ztoL9gzVsbAFLAfNnF4p9YmlD8mEyNg6J26Nq1MFuHjg0D+IyUNrfvffb+zgbRAWL7c
	pvSlNIdsjruN0SLv2WOxT7yz8mUFF8ANUpNv3fTbgkNy0Ka557bJYIfLLgqtZqv0xkQYE84pWH9
	TbzIHii3RrmJvqIn7g==
X-Google-Smtp-Source: AGHT+IFtBGqgz6iEWt7LMNhyXXy7Ao2/LISUPvugqZVTStAhfwtsv9UYgCngz+ynDyppB1uJogIN/g==
X-Received: by 2002:a05:6a21:6d85:b0:1ee:85b2:ef73 with SMTP id adf61e73a8af0-1ee85b2efcemr458480637.34.1739508825453;
        Thu, 13 Feb 2025 20:53:45 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:942d:9291:22aa:8126])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-adb5a92c6d8sm2017586a12.65.2025.02.13.20.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:53:45 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 14/17] zram: permit reclaim in zstd custom allocator
Date: Fri, 14 Feb 2025 13:50:26 +0900
Message-ID: <20250214045208.1388854-15-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250214045208.1388854-1-senozhatsky@chromium.org>
References: <20250214045208.1388854-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When configured with pre-trained compression/decompression
dictionary support, zstd requires custom memory allocator,
which it calls internally from compression()/decompression()
routines.  That means allocation from atomic context (either
under entry spin-lock, or per-CPU local-lock or both).  Now,
with non-atomic zram read()/write(), those limitations are
relaxed and we can allow direct and indirect reclaim.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 1184c0036f44..53431251ea62 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -24,19 +24,14 @@ struct zstd_params {
 /*
  * For C/D dictionaries we need to provide zstd with zstd_custom_mem,
  * which zstd uses internally to allocate/free memory when needed.
- *
- * This means that allocator.customAlloc() can be called from zcomp_compress()
- * under local-lock (per-CPU compression stream), in which case we must use
- * GFP_ATOMIC.
- *
- * Another complication here is that we can be configured as a swap device.
  */
 static void *zstd_custom_alloc(void *opaque, size_t size)
 {
-	if (!preemptible())
+	/* Technically this should not happen */
+	if (WARN_ON_ONCE(!preemptible()))
 		return kvzalloc(size, GFP_ATOMIC);
 
-	return kvzalloc(size, __GFP_KSWAPD_RECLAIM | __GFP_NOWARN);
+	return kvzalloc(size, GFP_NOIO | __GFP_NOWARN);
 }
 
 static void zstd_custom_free(void *opaque, void *address)
-- 
2.48.1.601.g30ceb7b040-goog


