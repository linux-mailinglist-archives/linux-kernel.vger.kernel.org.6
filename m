Return-Path: <linux-kernel+bounces-266415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A7D93FF99
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A431F22F30
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F79188CCD;
	Mon, 29 Jul 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qI9wbunD"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A88770F6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285469; cv=none; b=GCAf61ehCkb4uRudEE6fpyX5ZJV2mdYMvwAuyi/33CjGJEeBeeyGppJU13vvN/J6lddxbwnhZ3tn0bM/w4s4IUBFtu0Yb1tEgPo4VOx7/3/zAl3ngHWIfUvFcUCfXvbCXXI+lvTV/E67l5bNIUTOnLtn/zWIh6k7OySQ8v+zQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285469; c=relaxed/simple;
	bh=hkPp6GXfnm6S51+Az4VJb59LvXaAhT65AgIdZ2Wks70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UYTA7ECg1xVGlz/n41AiffYtaJbzEv8GtPtPmiNcLqpvsHZUTW0IFscZ8gw3NzB2ryRGBJ3BJxMKKnNLLUeN1EAWzjHBnLG7530gre1IOfuhRaEv69Gfb2HIzUmQQ4culCf5UDS+Yx4b8PSBIgtOVavmX1I8DYuUhw4/nHDDgKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qI9wbunD; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cb52e2cb33so2287857a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722285466; x=1722890266; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P8xtASAl0C3mPC2e/A3dwFCipYDFPC54iU7VAjLzuNU=;
        b=qI9wbunD9RWifLbQaZUriyu5fqT6NJTtTmU9A1hrfvaAJiVGbFhDIQyvManz5CkXCp
         M7S7DbEoNh81xM7EELwdHUnmzOF83DNBbDvXajr+tz8axZC9mR77zKRCQiPOmr8LSEu3
         I/MgGLkJBLWhdoAQAiuflh9X16thgqfYK6cRh4SOzmEkB4L5iBqNvD/RVf42F5W8BJjU
         JjOYQ2cpTOwY/1NbI8x9LqElA4ga/G4B0mHR/vhKG0SbRdS9KCJtWV85cJZvAvs/EXpx
         LuNQqfrcYxCxhx9aGRevi1/2GXdboPjrJqxSxN757DrefM/Bo060vyA0kWr046yipsoU
         3gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722285466; x=1722890266;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8xtASAl0C3mPC2e/A3dwFCipYDFPC54iU7VAjLzuNU=;
        b=saE1QoiP6Z8JVzgtyDrdOK3eW8bgTC1Ku6bdo6ImU3O6O1l/NSaUuBgX28ygcsjkvX
         uFaNNfhT88ZqI9KZUaLoScY0xZKvuWld6Yo2cjvuAOdj6puQYnuFYZXp/ji5NpcC4Q4Q
         zYuzclQ3DIjwuoOrbqDdDWqRueJux7pN3Amlc+S1IzVy/wli3Rrh0QKCQ/koJm0VkOf4
         rb5gFr7glc5z7lgJZH1rBEZQnTSDQyDU2agduTLlyA1TW2G7EKY7VsZ8HjeHKW03Fvfu
         YAAS9N67rX6XkRxKCyf5ipukD/B723lKELGFNchF6gowJJ1N0QuRsmQf1qCRdD3gvrD5
         OpiQ==
X-Gm-Message-State: AOJu0YxenkY6FohrtPbZI3ZNE3L/hkVyzAqjI+X7p4GQ45jNQ2XwtMcW
	znRwdzZ5Q7qnyJbstef2wNmoTx1acTk6+j2KHiDoLbegWirlQC7InU0KbAUUk6zGGO/K1dVhDH5
	y
X-Google-Smtp-Source: AGHT+IE2cDzJvIDV6R/rWNKWk1l/IXZQuwJGuqzFIhzGzz4l85cMdqPEp8EbA+DTdJx1nd+4/ZbWng==
X-Received: by 2002:a17:90a:f490:b0:2c9:9b2e:61b4 with SMTP id 98e67ed59e1d1-2cf7e1fadccmr7087463a91.22.1722285465711;
        Mon, 29 Jul 2024 13:37:45 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c56664sm9076121a91.5.2024.07.29.13.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 13:37:45 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 29 Jul 2024 13:37:36 -0700
Subject: [PATCH] tools: Remove tile architecture from barrier.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-remove_tile_tools-v1-1-76fbb7f8db87@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAI/9p2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNL3aLU3Pyy1PiSzBwgkZ+fU6xrZpxqZJlkamKWZmKhBNRXUJSallk
 BNjM6trYWALYVju1jAAAA
To: Arnd Bergmann <arnd@arndb.de>, 
 Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722285465; l=891;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=hkPp6GXfnm6S51+Az4VJb59LvXaAhT65AgIdZ2Wks70=;
 b=yNvBadpRsJFwBA1ju5ZoTNngkd4ePxCeRzFYieNpbXDxWC3v12rZWovCMzYuAv8Ye8f2q8qar
 yjjFBlbyWnKA8qcEBbBlOYA0VqrcLvfo67uH5umdyLL7uIw0DAo0duC
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The tile architecture was removed in commit bb9d812643d8 ("arch: remove
tile port") but this one use was missed.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/include/asm/barrier.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/include/asm/barrier.h b/tools/include/asm/barrier.h
index 8d378c57cb01..2042e97faf8d 100644
--- a/tools/include/asm/barrier.h
+++ b/tools/include/asm/barrier.h
@@ -14,8 +14,6 @@
 #include "../../arch/sh/include/asm/barrier.h"
 #elif defined(__sparc__)
 #include "../../arch/sparc/include/asm/barrier.h"
-#elif defined(__tile__)
-#include "../../arch/tile/include/asm/barrier.h"
 #elif defined(__alpha__)
 #include "../../arch/alpha/include/asm/barrier.h"
 #elif defined(__mips__)

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240729-remove_tile_tools-63e29b546f48
-- 
- Charlie


