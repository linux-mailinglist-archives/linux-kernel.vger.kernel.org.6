Return-Path: <linux-kernel+bounces-392926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC589B99B7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B10B282F40
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01561E2606;
	Fri,  1 Nov 2024 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vX8Rsziq"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE7C1E1C32
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730494504; cv=none; b=NLEkwY2DP+HAZBAVA0p4HHF5Jm53Tem8U9GAQkek2YMaq00yxTMd+yjHDbHeitL8PGKfz4gctcNbl3FjKK/McdmJeO6UAUuLKXg/xBiwgnBBHqRh5Py5auIeGGnSjC5/AQ40pwrCYL/+t6zLr0ZrvtU82Dr7pghwOlO5dxlsWNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730494504; c=relaxed/simple;
	bh=4RROoxRB8fpvFTHrKZ9NejmpNSX4yec1eT70eaOuSC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPxU7oZ5iHf+jV+V9+iICtL9eaohFbwd8J1KhxGfFYHvCvC/pia5SAdkcu17rR994LuNlwUwuUzQy6K3Ao3047wXi8APjLXzoozKy9Q1ykAn+jWNsAKRFqmE0PpyRtODnNp1WYbsV9nW9Elm9BeAsujLbiD/V/NwhSz6MumTxUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vX8Rsziq; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so1339415f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730494500; x=1731099300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jLTdEDXvDx6C1+kdRWN0DBnWkM5vnWkdpplvs2TB8+4=;
        b=vX8RsziqWL/e7Ct70aTRl07kmCtIghKq7bQ46IWWc+WBabbjSOAbSUsG4CvlKzJ+G0
         KLtTJXY+5sfXVsISW22XNeDwbOSuIQgllkok1jePycHTJircSuXVmUCPnsvZt8M2wrgj
         Ojb/Asq98n4VFs8bIW2kf228G0hw7OBp6CAnckOwiiI2ud5Ba2hoUBtCvnV4QLWh0yU0
         IGUWczfA43tY5tur24rX6G/IlDyqBlYyhqwfo1XD6rq7Icyva/4lcJQvEbnRrdD379rw
         uJ0tZrlWgyMqf54aB0M7X7jNT6lH4KqYy2T1sdF9HtgpTQ3+/SNG2N2u6kIBF5qeFHZH
         BRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730494500; x=1731099300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLTdEDXvDx6C1+kdRWN0DBnWkM5vnWkdpplvs2TB8+4=;
        b=P6YLMN/l4QohJO82OjWNTpZmmfou9DnZFNUx0nSiVt0j3r5jKG8qT8A02t7PBGnD0e
         y/H+1gS1E3GgpZIuElSby/09OdxstXEX4KTkwoY5A3THGcOa9LUjBtzRAZPs+t5F+NCH
         0sozlcMpuzV0ildOd+jtyy8Gj2TWnQfONsdTrKkJwPrEdjT9+VmHvPgnY6rSa4VVxYSR
         ripJMwmFZFvgzGV9gb80CHXH3O7w7LSEw86XARUGxywNiQdCYlK3/Q2XqXBj5fzySVJS
         4K/WU/yijsfrKoAJ03LPaI8m7FXGt/d8w072VWmmh/U8bNgsmqr2AIc5eJJzZkSqbKyC
         qbDw==
X-Forwarded-Encrypted: i=1; AJvYcCXfdQcYxO+btB4dtej7jvH72nFgGfPaTyLMsgE6p8HhTFWrfxQqVArdGOM4z6vW/+LPYn5Edm5hTAdKgCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywpJsbuUFtc4v9IuOhXzk8Xk+Tk5FTQw9xxMhJV3iFDLmBR/hM
	V2SzzDn7cvMIC2o1NejCbN59D0BP/C63PRGkkKxyn9PKgkRbYi1vATvgdBaRWzw=
X-Google-Smtp-Source: AGHT+IF9SJTbl/9ym3H2HLLhqsElg5KmBrO4oJDVweH5FkNcn4aOm7mRNyiEG2gDz6qmQ/+JagSV1Q==
X-Received: by 2002:a5d:59c7:0:b0:37d:4fb1:4fab with SMTP id ffacd0b85a97d-381c7ab739cmr4123785f8f.57.1730494499960;
        Fri, 01 Nov 2024 13:54:59 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7e52:b53c:229:e024])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116af7esm6153480f8f.103.2024.11.01.13.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 13:54:59 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] lib: string_helpers: silence snprintf() output truncation warning
Date: Fri,  1 Nov 2024 21:54:53 +0100
Message-ID: <20241101205453.9353-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The output of ".%03u" with the unsigned int in range [0, 4294966295] may
get truncated if the target buffer is not 12 bytes. This can't really
happen here as the 'remainder' variable cannot exceed 999 but the
compiler doesn't know it. To make it happy just increase the buffer to
where the warning goes away.

Fixes: 3c9f3681d0b4 ("[SCSI] lib: add generic helper to print sizes rounded to the correct SI range")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Kees Cook <kees@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Changes in v2:
- improve the commit message

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
2.45.2


