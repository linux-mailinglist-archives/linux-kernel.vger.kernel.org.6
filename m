Return-Path: <linux-kernel+bounces-270599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C43E9441ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7ED41C21E19
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E939A13C818;
	Thu,  1 Aug 2024 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JF6Dqs6c"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D741D696
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722483450; cv=none; b=T+lk9j5CNt8SJ2vkoDYkvYceeldDLJmyXTnmpYCAMZ9XRNxCezaTk6Ah+uL+STrJIH00ovw0ZguL8b3BPJqoHDkLQCvxZIxtAHWggUeT7Lbeg2CCInJtZxH9RvmFP6EwxAWfPQpEZPbqKpvL6DlLURfrrF6dXi1P1t3jPyLqORE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722483450; c=relaxed/simple;
	bh=jtyFm42yP7J6Z+8iSJte/VB8viY24KRG972kkOL1u4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ugCqfQg6SAImdf/DeWgeICuci0zVXgAKQdSabLfveEBex1UzALlUzzmdZ5TI3XTG9SBviZJGs6oo4XH8hw9doI89HpKRc0c9ZTOf41O4Jj51pZS5TAOXPKZprprf9PCuKjVPN6COeoHlpuXUa+jjHGw7i/u1sUZeGdOPlvYog30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JF6Dqs6c; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d150e8153so1147569b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1722483448; x=1723088248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9k9VIOXjwuqNS+/YcMmWUWuyVFM+OX2w1xgp26aZK9k=;
        b=JF6Dqs6c7feBiVWe1ShT49F4ooLivpnJe72YFwBSq3sNsr2kfz/bHG7/EaIAOy/L9h
         hCTE7p/7MqYbkftKyG4yUOgxS1A6BTWBx4GaY9AD5rvygQaU9gIzRnNK1Aiqa6Wy4SSm
         R490AQexNRpVvx9Pv+He55xHidxfD2BTXVUUsMWXrT59q9yC5E7VbldeSqpTZvbVAtv1
         snCH3nxv3MPCYfX1k2UTU1axbSXLu209T3/bCHZ4+2ReGh/XqC6yPCKJzmmwTchGANyE
         HIwxqv8wDsQPUfHUUbJn4Sj0S85BvVaBKTBp8cZ8NzJ315bi9uIvJx6edI2g/7DwUkFA
         Si4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722483448; x=1723088248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9k9VIOXjwuqNS+/YcMmWUWuyVFM+OX2w1xgp26aZK9k=;
        b=Kxy+UliIcnBcj/d4m8qBwICPmNFvR0EMX4ywgJTZnkZK2B5TKAVtIdpyfcbzWoWA8E
         enbQV3757Uzk277WWhyP6+qOWPA1Z9nTWsb1cGlBVq90AtuPICVE8vA9V4WUPgRaQEmu
         rkWWsH3RqB2A0NxTuCqc1iZnGAXruSKhThSMqTBqfLwkoJC4QbHJMcoNFhewAY522EWj
         CnSkDLukv126+q5NEL+kVp96O99N2JuEkrERo5k/qae7EZ8SZ8bRrqbm6IGEniH/YVe+
         ZE5LcQu0UdyX6p0i8QOB1RUIqg2Bmjfl4yj8NXK5wixnPYZrfuF3nbK9UW6KYF400Bdq
         MrWg==
X-Forwarded-Encrypted: i=1; AJvYcCXk215M32uGAcrnPX7+lU6HP5xAP05mLzMuA75Cg3CIZ8pENhCSdQShhrDO85eiYl0eihsuhaSEuCF0X/0Wdb/6x5o6ewuyD2W4l3Gg
X-Gm-Message-State: AOJu0YzjOSPYYupwoNpzVYJ/DTDYpnZMdnB0buaZ3KXdQ5cgGssnOAmy
	zwkVQajekLABMmKVG7cjkauKi0k+cnivC2L583rXbSorWh3z0vqdza7yZ9oEOJE=
X-Google-Smtp-Source: AGHT+IHFOBC47p4CpLPq6v4nWD7xk3dw+GUeSZ7shUYfUzrVEJsAf/D+jq7FoEQeTYk7sxpWstWV2Q==
X-Received: by 2002:aa7:9184:0:b0:70d:2e89:de2b with SMTP id d2e1a72fcca58-70efe426bc4mr10438408b3a.4.1722483447727;
        Wed, 31 Jul 2024 20:37:27 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ae3asm10954457b3a.91.2024.07.31.20.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 20:37:27 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 0/2] riscv: Improve KASAN coverage to fix unit tests
Date: Wed, 31 Jul 2024 20:36:58 -0700
Message-ID: <20240801033725.28816-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two areas where uninstrumented assembly routines
caused gaps in KASAN coverage on RISC-V, which were caught by KUnit
tests. The KASAN KUnit test suite passes after applying this series.

This series fixes the following test failures:
  # kasan_strings: EXPECTATION FAILED at mm/kasan/kasan_test.c:1520
  KASAN failure expected in "kasan_int_result = strcmp(ptr, "2")", but none occurred
  # kasan_strings: EXPECTATION FAILED at mm/kasan/kasan_test.c:1524
  KASAN failure expected in "kasan_int_result = strlen(ptr)", but none occurred
  not ok 60 kasan_strings
  # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan_test.c:1531
  KASAN failure expected in "set_bit(nr, addr)", but none occurred
  # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan_test.c:1533
  KASAN failure expected in "clear_bit(nr, addr)", but none occurred
  # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan_test.c:1535
  KASAN failure expected in "clear_bit_unlock(nr, addr)", but none occurred
  # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan_test.c:1536
  KASAN failure expected in "__clear_bit_unlock(nr, addr)", but none occurred
  # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan_test.c:1537
  KASAN failure expected in "change_bit(nr, addr)", but none occurred
  # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan_test.c:1543
  KASAN failure expected in "test_and_set_bit(nr, addr)", but none occurred
  # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan_test.c:1545
  KASAN failure expected in "test_and_set_bit_lock(nr, addr)", but none occurred
  # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan_test.c:1546
  KASAN failure expected in "test_and_clear_bit(nr, addr)", but none occurred
  # kasan_bitops_generic: EXPECTATION FAILED at mm/kasan/kasan_test.c:1548
  KASAN failure expected in "test_and_change_bit(nr, addr)", but none occurred
  not ok 61 kasan_bitops_generic


Samuel Holland (2):
  riscv: Omit optimized string routines when using KASAN
  riscv: Enable bitops instrumentation

 arch/riscv/include/asm/bitops.h | 43 ++++++++++++++++++---------------
 arch/riscv/include/asm/string.h |  2 ++
 arch/riscv/kernel/riscv_ksyms.c |  3 ---
 arch/riscv/lib/Makefile         |  2 ++
 arch/riscv/lib/strcmp.S         |  1 +
 arch/riscv/lib/strlen.S         |  1 +
 arch/riscv/lib/strncmp.S        |  1 +
 arch/riscv/purgatory/Makefile   |  2 ++
 8 files changed, 32 insertions(+), 23 deletions(-)

-- 
2.45.1


