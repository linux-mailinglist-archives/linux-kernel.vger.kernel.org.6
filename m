Return-Path: <linux-kernel+bounces-373954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845279A5FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 041FEB25E00
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366321D04BB;
	Mon, 21 Oct 2024 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HHlRO/MV"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899071E284E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502068; cv=none; b=a/zpdma85K/RkZkaj+9GElO7PDfCBUBxI3oRT9rVTeAWpGXqu4OIYv9FHPd5GdkJyOCw0Uq6sshIJHbyTXWtikh+FEizql0DMCmu36XtkYJuXGVymz8O/eK+FnB79KVIHXQrTcnjN2ugpiG3j42o5kLtOFMjPsBnnj8IJUpEJRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502068; c=relaxed/simple;
	bh=ASWrvXnuLMsHbkqZnMajEVLcesZQBnkmFo5lh1TiMiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UDxmrYTpJm4k9O4vPOAsmNRyAZO7hsik59xTBDcfxrQ+7H5/ZBETI28iPEDxbXWSLTu3pNg2/PAl2y2X39MKGjwmgYfQCUqObg0e5mVf6NbvNCEjQB46z/X8h1knZpRy9DSFd4m+WoBps/dsocEjGrOVIfrrfaa63+L6mTzFtbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HHlRO/MV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so11857875e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729502064; x=1730106864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5raYV5vPxawZNarPbF7rVysyaAZqhzjtOUPOejyw3qk=;
        b=HHlRO/MVX1dtUD+mxEsabbrRTsOQDjotwpVkIm4L4dD2R2TD2ocxYY/yTwNpjhluVo
         LFSGyP6HylQp8Ziaf/SlLAJCCH3Cf97AqrQ9BpALpSxd8SO6O+rTYJB6XDmX4mNISlzB
         d3m/Fa6iTxUUBvq+nNc95Dhvep/E6pZtFctRcRce0IlQpxlQcnL1PuLZx4XS1iRfVpX8
         5yIAOJzU4pFh1MoCTEND2MstqW7DYuDcgwI4sRKl/nTwVEKZSC9eaMpBkopaUuRngK1m
         H5wsz0KYlok0kqd41SEeU9mzW5hdHzSo9qd1dE0vz44THZX2/AQ95mJzjyUPOtxGofAd
         wX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729502064; x=1730106864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5raYV5vPxawZNarPbF7rVysyaAZqhzjtOUPOejyw3qk=;
        b=Emnxr1m49GZZVetqGE0xOVYaPI+V8LP2qUInkX4f2Vf/ESy4RmQVaZivVYACF/mGZG
         ULC8edrnOx7cOTKk3FfFngJlqRVIJUimk9fHcz6OEEaQO6zYR2IDnjGRIUJNuG+vfQNX
         uFs7EhuvcqcJtL/HdES037w5ORmClFbwfvUJiY3w7TwMinkfKeD5ucDC/Te2Nil3YtZV
         3MUYW6mKHp/yb1SZGAvyMoLw0O2Z/6oPwGqt6jwGhhltyoA6kTRvrzD/23YHGTFmJzkr
         Trzjk/DR+/1zAlLMuOrbWV4O6lcMiiW5HxYmOxKeKWv4JY1hGpJljc1Xiv5bpVO3pPRZ
         Kptg==
X-Forwarded-Encrypted: i=1; AJvYcCVw9j9oRhAr7RRAR9LET/FzqHr4hUGsUIt4daUJqoW0HXlUV+4HbfPl5ugKXiR5MtifQ1mf7DZKVeiyOJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYs/87ZoTQNEonLUptBpPn3ncNITd/InodU791EzR6sTZNdIIU
	UttTpeQV1WvDIdcK4rvsxbuRLLXhuNUkpTpCagaiZ2oHCptznR5I2m3PQKa95YBEK0gQ4KmT7Bc
	d
X-Google-Smtp-Source: AGHT+IEYuZyLwzQfurWjEnYG8ZF9u47IIP/NoCY4w93Z6L4JxTaxu47mXeeN94UlMxTSaSPKDiwZYg==
X-Received: by 2002:a05:600c:45d2:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-4316168ee39mr77674285e9.22.1729502063773;
        Mon, 21 Oct 2024 02:14:23 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b40b:61e8:fa25:f97b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f571201sm51099145e9.5.2024.10.21.02.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:14:23 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] lib: string_helpers: fix potential snprintf() output truncation
Date: Mon, 21 Oct 2024 11:14:17 +0200
Message-ID: <20241021091417.37796-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The output of ".%03u" with the unsigned int in range [0, 4294966295] may
get truncated if the target buffer is not 12 bytes.

Fixes: 3c9f3681d0b4 ("[SCSI] lib: add generic helper to print sizes rounded to the correct SI range")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 lib/string_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 4f887aa62fa0..91fa37b5c510 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -57,7 +57,7 @@ int string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
 	static const unsigned int rounding[] = { 500, 50, 5 };
 	int i = 0, j;
 	u32 remainder = 0, sf_cap;
-	char tmp[8];
+	char tmp[12];
 	const char *unit;
 
 	tmp[0] = '\0';
-- 
2.43.0


