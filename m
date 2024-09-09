Return-Path: <linux-kernel+bounces-322137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3277D97249A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 23:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89275B22C06
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66EB18C90B;
	Mon,  9 Sep 2024 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGox7BV3"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01521836D9
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725917918; cv=none; b=MLcb7nvZoxx+QW/rgwAyYWq2076ufaDguRxz3WfcMlghkMw3OSs54yiMVMlDQKrG1pzzRsS53XzVJUSkHfT8OMn9aHgR8rBLoTIo4dG/1wkQlrgy6D8SKlQQe411249pW1YL15c4cRmQb9iE8ELyd5N62xU6UB+wf0MEGRXsnf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725917918; c=relaxed/simple;
	bh=/7/v+K92vmdZpMfKKUS8N2xkxGQSmXLfm6PNgOLKnvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J0kbxiciwsFAZyWHF4JHqGL9MYhdkIsjyQPeMIyxFAn0KvuLLw5YZt8cG9Yu0vfHpu3dB+cmye6qh9mjtwkoufFFknp8F3ryre4ualBGwuDK989AfpGHQCBVQq/JbLLMLBfhA5yTzjxhSgyvzSi1kPzUbcv7kkVzpFq+0ZZXCpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGox7BV3; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d86f713557so3162674a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 14:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725917916; x=1726522716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8/YshQpzW9k3lt1mfESjTp63HexH096NDFAn0wVw4Ug=;
        b=kGox7BV3rDeTAkRJ7YajjDJuVqeEdbYxvMVKdJl3/Mu1NjMpXxPvDetht+IGI07W0l
         3wOQb+U3yCZD5cLqr4RYX3WmZsnMbrI4XJzgKCSIUsTUnzeurGpuD009vSKM/L/0XILj
         zjGlHy4sZgbL/5lM+ypnd5akK3KH3PJriTggWTnTNe1c1JQvuz2dpnniOJiWGbhf1d4w
         bcSKIOWgdyO2YLo/M7OCV0N3RRLCRohs3E8Cqd/qZa2C4yidl40Y16cjCZrR7Uwwn0ax
         N0GRZkmFUWcLuYY9/N2v+5Vk/924yIgT1j+EsnSllaMoZiJU+itWmQDLaburkkbRMAeI
         7IrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725917916; x=1726522716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/YshQpzW9k3lt1mfESjTp63HexH096NDFAn0wVw4Ug=;
        b=P9O6fX7XGnB4C+A6bNprCYjzKHs3peBOS/xFOD/T6vTp93KN6cH7N/5pXfBMfcVt5Y
         GX7daDL3AZ7lrOnejQSgUe40sv7Pe3IhS8bMy0+9UbZEAbNHt9VYvWc2G6yw8nmuerKn
         9LYY3GiApiGh/jyfFsktOmS30JmgYVWKKaf+TpyuvNoYm1eIJQbwrxzISES4/G3YmpV3
         34norYKqXe4bV2hU71R2kOinOX71EQabszyfTrq5X3/W8A5wET/XejXXwj+BdiV+LEcc
         LL4GFuSPf8nceNBFHV05KdbuGHQxOZ+iOfQHm3DVGMHFstMyq94tOLlKY01aEObprIy2
         iX2g==
X-Forwarded-Encrypted: i=1; AJvYcCVxgC06VHZFKM4AZYOaYVYFVPB2rG4+qAUBEf5gmdd8MkWqngpzjE6FNS/NqDvI+IQCbRraIjXoazawf+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtVy/+TG34Kk4LWeiY8tnqMk99LRABo+DsKBwiiMq7/gLJFKES
	aCMs4zXp3SP4bbGtjBoMrkpniPLIR2QwW/Kw+5umak7gABV5TRGh
X-Google-Smtp-Source: AGHT+IGrOVTK6wZShZQSP2xltoODwGJpYytnvla3nrL8GsuPex3p977aNFbfq7McIsjRNhh/2I+iEQ==
X-Received: by 2002:a17:90a:5802:b0:2c9:5c67:dd9e with SMTP id 98e67ed59e1d1-2dad50139d8mr14574504a91.19.1725917915951;
        Mon, 09 Sep 2024 14:38:35 -0700 (PDT)
Received: from localhost.localdomain (111-240-106-94.dynamic-ip.hinet.net. [111.240.106.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db0419ae89sm5067016a91.13.2024.09.09.14.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 14:38:35 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: Nick Terrell <terrelln@fb.com>
Cc: Min-Hua Chen <minhuadotchen@gmail.com>,
	Nick Terrell <terrelln@meta.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] zstd: use NULL instead of 0 for NULL pointer
Date: Tue, 10 Sep 2024 05:38:08 +0800
Message-ID: <20240909213811.192532-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use NULL instead of 0 for NULL pointer to fix the
following sparse warning:
lib/zstd/compress/zstd_fast.c:726:28: sparse: warning: Using plain integer as NULL pointer

No functional changes intended.

Fixes: 98988fc8e9ed ("zstd: import upstream v1.5.5")
Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 lib/zstd/compress/zstd_fast.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/zstd/compress/zstd_fast.c b/lib/zstd/compress/zstd_fast.c
index 3399b39c5dbc..b0dbe0db3310 100644
--- a/lib/zstd/compress/zstd_fast.c
+++ b/lib/zstd/compress/zstd_fast.c
@@ -723,7 +723,7 @@ static size_t ZSTD_compressBlock_fast_extDict_generic(
     U32 offcode;
     const BYTE* match0;
     size_t mLength;
-    const BYTE* matchEnd = 0; /* initialize to avoid warning, assert != 0 later */
+    const BYTE* matchEnd = NULL; /* initialize to avoid warning, assert != NULL later */
 
     size_t step;
     const BYTE* nextStep;
@@ -895,7 +895,7 @@ static size_t ZSTD_compressBlock_fast_extDict_generic(
 _match: /* Requires: ip0, match0, offcode, matchEnd */
 
     /* Count the forward length. */
-    assert(matchEnd != 0);
+    assert(matchEnd != NULL);
     mLength += ZSTD_count_2segments(ip0 + mLength, match0 + mLength, iend, matchEnd, prefixStart);
 
     ZSTD_storeSeq(seqStore, (size_t)(ip0 - anchor), anchor, iend, offcode, mLength);
-- 
2.43.0


