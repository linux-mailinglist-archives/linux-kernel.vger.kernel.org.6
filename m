Return-Path: <linux-kernel+bounces-336550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D819F983C31
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27E56283B31
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F1D3B1A4;
	Tue, 24 Sep 2024 05:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q+TvEMOG"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703C88C07
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727154587; cv=none; b=kUZYh1TEODolVeF8Ex9ph8ZDnD682sTCbLMw/3x3hdxi6wt1pXB5Foq/DXvNnzD4IrH+pv3akpkEbLywp2V03xgh6zLd1aSJ5SmCz9G58r4YGV5wOmMGRuCPoJtSm5e+E8ZCnPEEbBmxRxtRJyPEzE0ggNAbaeduiPBt/M5oVq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727154587; c=relaxed/simple;
	bh=4DTv4zDbfWZ/zbCot2Jal8307ZXuogjRn94N0TEyp7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XVYk6vUgQfRw5D/kOLdGPn4Alyb5JlEBafNag5812qZtcTAbBX0GaPVBIRYmpo0St49QegCJKZo5jdEzEK9wKVVehHS7MHZY2u9AOd7GZr9WI5M72PWWBdXc0icHmi/svvfBnSdyRITpdf8O9Phf2gbNtqd//X9QkMu7AsbIMLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q+TvEMOG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so4204176b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727154586; x=1727759386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOYpUvrzwZdtOkSd4gUm2SXn7O9pFSKVomnIDxmxarI=;
        b=Q+TvEMOGQeXIxuRayTirIo5UvDAqgP0XLieGyyCfGE0y35K8bXuatVC4stIcszJ8Zc
         IJ2zoDqlycLR88zD0LtrByWyoI3wU4yxleS0n3evgGCmVUGqTBmjvSGgzr3F/CiVlAO1
         4GboUJN+jdAO+P1qskORKpLI9k/MZ26U8xkDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727154586; x=1727759386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOYpUvrzwZdtOkSd4gUm2SXn7O9pFSKVomnIDxmxarI=;
        b=vnEKSHGKL8WsOUCglIGUyZ360LmqsfdZ28I4R/hrzE84Fi87txftw56I8QvGUfVSc3
         sjL8sFAj8elQfCIqm21IaNfwpsfB+ig0YsvRh0mVVvD3JMHim46ebCEIYtKcAf3j0rKB
         KemrVNyRyiTHAYbvH2OIFeBSIlqiOtcI5J9zx8mL2pkEkS/+IhgGyeCyxjtWWq5thNNx
         82ERI00yP+xD0DRd4c0CjjVbPpoMnWa0cNv/HlbqpFoxki8yRI4BK1j7XKaoqJVlCAf2
         vaRE85v5OMEftDjq1a1/EfX19J4mKs9tiuZdlmwlMY++VoKIC0T03kCMkkBbrd8XsYug
         JPVA==
X-Forwarded-Encrypted: i=1; AJvYcCWp8T0C4hBdf0DxjmGBfjmk6zH8dRiOa+koNWwpBV7AxzmZRhCDDKLkWA22VHa3PtwZUpbA6F597bipdtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh/L/JIcuqTqYZ0zcKvZaq60v9+fMEn77WHTZoKelQRM9XIg3Z
	uhV3NA9V3m0bDZ9fgvnBeuwJLublR3oHQGTmTu5N0ZnBoEhFjZtCoXnNCf5YNA==
X-Google-Smtp-Source: AGHT+IE+Yf9VOaIeSQAGvHRM9wd8PE6iBTLD4Yw1UXiqbMkcR3rjs2z4coe9TQqe14JyB9eVir5STw==
X-Received: by 2002:a05:6a20:d81a:b0:1d2:e458:404b with SMTP id adf61e73a8af0-1d343c60c82mr2895416637.14.1727154585655;
        Mon, 23 Sep 2024 22:09:45 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:93d1:1107:fd24:adf0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc834175sm435128b3a.43.2024.09.23.22.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 22:09:45 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2] mm: do not export const kfree and kstrdup variants
Date: Tue, 24 Sep 2024 14:08:37 +0900
Message-ID: <20240924050937.697118-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both kfree_const() and kstrdup_const() use __start_rodata
and __end_rodata, which do not work for modules.  This is
especially important for kfree_const().  Stop exporting
these functions, as they cannot be used in the modules.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/util.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 4f1275023eb7..24dadbd5727a 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -42,7 +42,6 @@ void kfree_const(const void *x)
 	if (!is_kernel_rodata((unsigned long)x))
 		kfree(x);
 }
-EXPORT_SYMBOL(kfree_const);
 
 /**
  * kstrdup - allocate space for and copy an existing string
@@ -86,7 +85,6 @@ const char *kstrdup_const(const char *s, gfp_t gfp)
 
 	return kstrdup(s, gfp);
 }
-EXPORT_SYMBOL(kstrdup_const);
 
 /**
  * kstrndup - allocate space for and copy an existing string
-- 
2.46.0.792.g87dc391469-goog


