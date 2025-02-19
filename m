Return-Path: <linux-kernel+bounces-522312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F941A3C886
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31DF18834EE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F1722ACC5;
	Wed, 19 Feb 2025 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYzibaWg"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9E222A817
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993071; cv=none; b=VS4EWK5+09tX9ZZ4rE6YJ1+bZSaOY4DNVazJuy4ksm04Q4ahG1iq5hTUQWWAjjqfa9yLrtj52ZeCuYDe3rEAJuotYJLUSLqm5xCwuLPt0UXOHa7tNVhQky484XZxto52L8Q725zG0ThRyBpiKR58f7KNQ65Hj5TDWDPOGs83nzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993071; c=relaxed/simple;
	bh=PWxbo0Nj/ORNHe/HN3+hY0rbzi9JP2Y2DuLTad2niIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FZrZp8h1Afrk55Dp43gZBn9l8UFVXlZLnowFLPRkeFf13l+6Yzb/LBb6sk5yqA9Qtj2Udtj82/mSw5BU/lJvBf1NxirRUHecOqe0QgPFYYiN/0eZoKMn5PAMkpByseDQ7e6VcfRPDiqp0Rim23MPJJsQrcvfse/lUPjQjXI4DQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYzibaWg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220f4dd756eso1495715ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739993069; x=1740597869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jcRFOWqiwvbx/cuDCSDjWSGRAtOxjGOL6Kce8UnzUfg=;
        b=CYzibaWgpng0xRsMJdjmUbLX3n06e8tgjFA/RU9xG+5QUQZabesphpQgRApxIOiNU9
         hgzTYcDvBq0icR1lci6o0xPtHzcuxPkm2vfAoWgz9lcKepmKE+s70jDCxz6wh/gyWxx8
         A9PSu8FnAhOl8knTDrOZn8b7iAkzDh6X2qAQitR3kbQVeMZIx0oi3qwEVMfM220ZFVQV
         RteGCbh7nPEyOEEwMepALye0+n/+OV4fjMzejjqlJYJZ1LFyrP/9TdU+8PuL0F1pH8Ca
         8VWInzW3auzilCCxgfF05dKSNbvfVjug+e/YO06trcpqj7Yd4qT6WpbZknbi8jf76TCx
         d8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739993069; x=1740597869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jcRFOWqiwvbx/cuDCSDjWSGRAtOxjGOL6Kce8UnzUfg=;
        b=GlWjB0rgCrZ31RNGnssS5oQ99ds1uvxL3q1JFmtQKsMZ0yFs7y5ulx1Gsvuv9HsC7/
         ji4m/QaEhzrrbDXtAqeLdeka1fwq4N1ilEaMmTYvAhDYOMmt4ncTrt8UE0nDvhecB6nd
         ZdIHUJcsakqfM7XmJR7uuI50LDbeGXh6/BREgh6W8WYh4kFmR6LjDkpOwzJVuHOugiu5
         czO69RK0peF3uwcaXQ/IzBaulJmJs7qVzYHwoBi4i8cdkQxXa5BbG3xvTzqHeg0aYr3e
         pxyn5uLK7KOuCrKqaiuqMLtFn7OUPB1l0bwvi1dnpv7yhoiENSyugavmyxRqrgPDf63n
         DvTw==
X-Gm-Message-State: AOJu0YzuoA6THRcwAcFlALJh5oZUBCD7y3mcPa/lcwOHwDSucWlPnj9R
	XFpHKp5gA9rBm09sG+HPGum5TRLnyAr5ldJM7Oh+Z8r3BwMJKvTOmgkVOM+dEPw=
X-Gm-Gg: ASbGncsOX/eHkK11bXIlMTwNe6OlVMeNeYvsrFZcQs4AmCYw/rVouf2DwqE/TGgvCVt
	ejpEyWB+bNZVSyMAZKyZKMv7duUhBKOfQiG/CvajfqSiwIzAVai5rXQQuA3fo4dlfMzfmpmpUqR
	dhhKIEaFsZDvMurqwba/Zld3hmuPA+hpC36c4G/GTU9Q8r+EWtm+Oci/d6ldQLoEfZZ4N0bo1C+
	kBw2scSKMpw5NTcS1SbXEbGViMsvfUlAabAfj58bfYF6DjPkRYEkKWrWAlL9E5EfTSNGGtJr9d9
	0LJ7t/dw4lJNOsKr66P546Q5AGuErawwlY4xfYg/K2t4YI9dsv+q8jrXrPS4hRix84AYoy36Gik
	jqGkC8vta
X-Google-Smtp-Source: AGHT+IHLePBmCm8XR4neAvLj7Z1w8yOgkrHKiLj41zghWfb1DQViV0G74gMBdmoMAuU8TWA1mZcvZg==
X-Received: by 2002:a05:6a21:3992:b0:1ee:c8e7:203a with SMTP id adf61e73a8af0-1eec8e7224bmr13779721637.40.1739993068858;
        Wed, 19 Feb 2025 11:24:28 -0800 (PST)
Received: from test-suraj.qjz2hk5f2gku1a3adsvczrat5c.xx.internal.cloudapp.net ([20.9.134.79])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb58618479sm9615322a12.33.2025.02.19.11.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 11:24:28 -0800 (PST)
From: Suraj Patil <surajpatil522@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	Suraj Patil <surajpatil522@gmail.com>
Subject: [PATCH] gpio: gpiolib: Remove FIXME by safely handling const in gpiod_get_raw_value_commit
Date: Wed, 19 Feb 2025 19:24:24 +0000
Message-ID: <20250219192426.164654-1-surajpatil522@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Suraj Patil <surajpatil522@gmail.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index ff64d84492f4..59437c8f31d7 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/// SPDX-License-Identifier: GPL-2.0
 
 #include <linux/acpi.h>
 #include <linux/array_size.h>
-- 
2.43.0


