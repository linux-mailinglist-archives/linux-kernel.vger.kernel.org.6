Return-Path: <linux-kernel+bounces-392757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D00F9B97CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7061C20833
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505A51CDFDC;
	Fri,  1 Nov 2024 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niiaH5Qs"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119A7602D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486420; cv=none; b=NdVerGnfquDKvXko6ovqGIUx6Uf9TO3iVHNaSKBVJC3+N2aYg0LV+SgRRg3LoFt2mL7s9CuR4qCs/PEUsxvmACCq3Vx9gkShH16xIWf2vMy/tBkE6bdoOgOo7enj32VF7bYtMChdGVXgSWDI6OhNkQ8PUvI4rm3Ro2fOTFlnT4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486420; c=relaxed/simple;
	bh=DkAVtKAGLSMH4HMan7qBCgb5QZQElY7M2pnYrh7xjeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HwTVLkWqP1JwrgcxA2LqTvs+F7FrLYI5FFmn27WwCWk080irm2ZyLttLNUq3O4KqbCSEhs/0jEULrZfgVL5Awa36I6T1DTbQSIyqqeRg/+F4lPhSypCtMyJw04oI4f8qhJrCO9X6CmYgckGvj5wxRYXPs/x8c4tyyG4YQJspprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niiaH5Qs; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539fe02c386so2978189e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730486417; x=1731091217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EWC1yOTC5QFlqMhqCf1j0kyrByhgWgxna16p0UGDJ/I=;
        b=niiaH5Qsb5kUOVczp9qiFMN0kvOcumm2urrNk4fIJ1NBIrwtRT77E72avvep9qZJZX
         Mh9cOzUFdStWap5wdR0OsuBMPfHPy2ha9L871IdzJSP/Zav549FnUnfMx5OmnuW959/F
         MLqBWNOuWNnwcRPms3faXZQZWq4LB3rqYa7Am0oyf7RXbfxcYgYiS1YnXDil0hcSGs/+
         9egmiI5MpIXGAAgo6G4msEFnPIcKeWnR50DCLw5mWgS/tywVYT3vprYVfq79xwURxFMe
         niXTBSeJPCnpKJWuGJJawi+TwzuddO4BWKgJlqXMs2whs33fEmJ0PnVkCeCv0UzEoIoI
         kPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730486417; x=1731091217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWC1yOTC5QFlqMhqCf1j0kyrByhgWgxna16p0UGDJ/I=;
        b=enudyHYLsWILY9b19bKZ2EOTAgiWO3zobQKasCqNE9hL7cO2XbhCkEPnCFY6ZqsrY4
         qtuDC9CwwOhC1rI3nyI2D1jEGhWf0iBipAAs4AGitSyRqu9tXvmEsJ20XG88/G4r/Utq
         m6JlmE3NucPnikyb56vNdGnoYZ9WkEuB20RmPOdcG/3jBlmeXv5yw0rOcg/vfnORp6Y5
         q6us9LskhrCWDfkNjw6Fi7XCcGwKc07RjUxFfycR61oemmCM9P7b2WcAgYzSqbRr1TR5
         TfAA4RHqIexxy8m3X5JBcCpOJLofkiMjOvDsBUeJQ2kssyJvqKujQPed1E+Lc43I2zw4
         WISg==
X-Forwarded-Encrypted: i=1; AJvYcCWQH+3s4+zxDk9Tpqmo+uitz4cROBvKuMAoZaRCXCrlrEokJZs6o9a+iNqjEKfADCs6lKoqDDSD/dir9Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2X0Uzl6xSFkjPcK38VsFDHpft4blszkO03iw3ZWXVRifYQJi0
	2COM0xPs+p3aoTAIaxa5g+PtbN3US7gsPBX8NKAzzB3SxuQhIOqe
X-Google-Smtp-Source: AGHT+IHLjQ8uX4kh50Kgv4JyHszznqgBG5TRqOm0LAgUvXB/FB4l6W6aA7yqdjLqOptEmMvEvounmQ==
X-Received: by 2002:a05:6512:23a7:b0:52f:1b08:d2d8 with SMTP id 2adb3069b0e04-53c7bbdcaa9mr3079453e87.7.1730486416985;
        Fri, 01 Nov 2024 11:40:16 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc957cbsm646821e87.60.2024.11.01.11.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 11:40:16 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	andreyknvl@gmail.com,
	elver@google.com
Cc: arnd@kernel.org,
	glider@google.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	snovitoll@gmail.com
Subject: [PATCH 0/2] kasan: few improvements on kunit tests
Date: Fri,  1 Nov 2024 23:40:09 +0500
Message-Id: <20241101184011.3369247-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses the issue [1] with KASAN symbols used
in the Kunit test, but exported as EXPORT_SYMBOL_GPL.

Also a small tweak of marking kasan_atomics() as KUNIT_CASE_SLOW
to avoid kunit report that the test should be marked as slow.

Both patches have been tested on (CONFIG_KASAN_KUNIT_TEST=y):
- x86_64: CONFIG_KASAN=y
- arm64: CONFIG_KASAN_HW_TAGS=y

[1] https://lore.kernel.org/linux-mm/ZxigQIF59s3_h5PS@infradead.org/T/

EXPORT_SYMBOL_IF_KUNIT

Sabyrzhan Tasbolatov (2):
  kasan: use EXPORT_SYMBOL_IF_KUNIT to export symbols for kunit tests
  kasan: change kasan_atomics kunit test as KUNIT_CASE_SLOW

 mm/kasan/hw_tags.c      |  7 ++++---
 mm/kasan/kasan_test_c.c |  4 +++-
 mm/kasan/report.c       | 17 +++++++++--------
 3 files changed, 16 insertions(+), 12 deletions(-)

-- 
2.34.1


