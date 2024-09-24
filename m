Return-Path: <linux-kernel+bounces-337151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5363A9845FD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E0C284200
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C2D1A76D6;
	Tue, 24 Sep 2024 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSR5kmOW"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764751A7AD2
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727181153; cv=none; b=bTVDznt7NOrDzxnFnj3gichg6hZaUhClD3SHYyfnv1A83rbHsD5K/FhlmOGdznZma3t9EjiqIqXadFOmFNLy0BBWl9V605x1DjoEI3o/zeZVQdlBxVW9Si16QP+eM9Fkib8uqUt41Qp31MxackDxVqkKf93PfVK1nZyAWoZf7hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727181153; c=relaxed/simple;
	bh=vYyfq1fdnVJNKDHZZ4jwWfoOzvf/EQdKHUP/P8grO/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZHGioRFpEL3Vm6O1QA2aXRi0TgCqt7YnvccDCg8UQTG8gMssy5lshKjKd8x5j2kWmOPnViA74tN+mAVWocZHOeXMxDKr1o29nJZF6asD2j8dyXmd87rdKH+Dcq7vxI4KzoXMlwYmlKgGD79WMA693uGQZDy7agh8VZ2+MnMTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSR5kmOW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7178df70f28so4202057b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727181152; x=1727785952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFN6t0TJFQnxmv12ewrvdOXYHRD1/G/lf2Fnmv9SgI0=;
        b=lSR5kmOWj5y8tZSVzsZvInkwCtDs1h7uIKgdvvnut+rMS1vY6KolyiWJOYDeieTZqP
         SXtOKGiIFwAyxSMqzOh1kkc8Nljexp+Dfdikoz3sU6rWm8rsWYiGHz6xXD0xtu4EnCjj
         mLvePWSh8xhyYveps07wzFHLgOfxaXJok3JxLBd+AEWwFo2mLNBOMRnpZvahmpdXhl4P
         sk81W/M8Ki05vvvzOT9A6g/p/Cs1BVNXG/cMp1loQyboBszFf3c1mThD/opqciv/4X0p
         N82tt1cpOnZ7ZoGdyvBEPQrJ/ZfQKmY0m/DrBHLiz+TqrDkOshWQuoUb3yTTSMDQ9Abb
         Qc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727181152; x=1727785952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFN6t0TJFQnxmv12ewrvdOXYHRD1/G/lf2Fnmv9SgI0=;
        b=tqFNECjVIok8d1PRu1/WW/CNxXBPFbvod9oTGCQmPn8F/Hwef1tUYrAk7+Fmos97dU
         kzj7IPh9ZZYlVW+lr08FN42m07REflB3ejCKlfMuAQ9cU6/KBwYtSUU920Po74Ym+OKu
         nClqLKXZdbxjf8kthfWuk1bFnXqUXzWB/YaA0hBaZSfxLzAvex9ooNSjpB8xXGmb79i2
         e3ErYXPQkHbPY3Ek5tb1e78m1c65F24+iOj3J2WSBVFedugONMkLD3criJ8tWcitH2pO
         OpRcgkk+YtSDRtriyAPtpaz7JiWA+seAnsy1sYRdcwwbXYmhRlfOs/wItl/PBpHuHnwM
         67TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXkJz+yV9ykn/YbQtZ4eB55koWubIjduj0GHzOwU73YkKTKQoiT6jz6+SfpObnAoNEESYT/wUaaFTqUnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbDzovO+f723VcmoNFucyBtaSYfvxiIfilmAj6Hys7BSPVYQH8
	ArIqAxX53EXPSrNG0G6NABiJT/LdBpyemzO5xA1xu0+ivFry4dQt
X-Google-Smtp-Source: AGHT+IGIBC+s8z8I1M2LAb5TgNJi8KhjIZjaw41vOl29r8HnH762QSoVson27WbTULXb/X8c1gTiEQ==
X-Received: by 2002:a05:6a21:670d:b0:1cc:e409:7d0c with SMTP id adf61e73a8af0-1d30a983b2dmr22206674637.25.1727181151608;
        Tue, 24 Sep 2024 05:32:31 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9c5ad4sm1115566b3a.188.2024.09.24.05.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:32:30 -0700 (PDT)
From: Zhang Boyang <zhangboyang.id@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Zhang Boyang <zhangboyang.id@gmail.com>
Subject: [PATCH 2/5] rslib: Fix documentation of alpha_to[] and index_of[]
Date: Tue, 24 Sep 2024 20:31:38 +0800
Message-Id: <20240924123141.16962-3-zhangboyang.id@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240924123141.16962-1-zhangboyang.id@gmail.com>
References: <20240924123141.16962-1-zhangboyang.id@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Obviously, alpha_to[] is antilog table, and index_of[] is logarithm
table.

Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
---
 include/linux/rslib.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rslib.h b/include/linux/rslib.h
index f76e0fc097a4..908bf7d0eb58 100644
--- a/include/linux/rslib.h
+++ b/include/linux/rslib.h
@@ -18,8 +18,8 @@
  *
  * @mm:		Bits per symbol
  * @nn:		Symbols per block (= (1<<mm)-1)
- * @alpha_to:	log lookup table
- * @index_of:	Antilog lookup table
+ * @alpha_to:	Antilog lookup table
+ * @index_of:	log lookup table
  * @genpoly:	Generator polynomial
  * @nroots:	Number of generator roots = number of parity symbols
  * @fcr:	First consecutive root, index form
-- 
2.30.2


