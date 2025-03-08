Return-Path: <linux-kernel+bounces-552396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E8FA57988
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1759B189190D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C290C1ABEC5;
	Sat,  8 Mar 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFLtoJwD"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D8618C32C
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741426512; cv=none; b=KPgrf4qTcG1ns1lJSQ2uv8snB3C49rrqwvM7hQltnhBWQ4+AEqctnqLddDxbbfSeNN4Kdd/gh/OESAU0Woa/fO0AnBJr2tW6tQ+0VyboCVlX51MPdWoPBDRGpevxijDhyV3ClhEYf42JeZoj9QfIO7QeMd8ZL1rcUmpEWIaxeOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741426512; c=relaxed/simple;
	bh=yaFi5KFEXVSi4uK0w9NOxfl10H46qSEs1dbuyvMz1Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=db97Uez7nYggp8lbFL/JhZBTvYPHngN3EntHVSLxNRMVVzHXrbT/xsM5WJf60Ol7gUh0agNfMuRyBxB24doWB+nGb6BvVg5ssc4gkIOuoxy0WEFGHk5Fq0sLniu8SZ6KLDRhSqJeOLtR81jai+RI6A5zv2sxlLzod1FVNzJGWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFLtoJwD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43bbc8b7c65so29392365e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 01:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741426509; x=1742031309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oQi4M3B4m1yhI+j/DR3tG0ChOrFssIfqquYPn+5ff0s=;
        b=bFLtoJwDKyaHDwlGTY2yWM+f0TwXfwjab5oiCorRPlHWW3zdugBxHyR4luNTw+CTfB
         zFB35tly5kDXfvKQUJ9bjmQ9E6jSynWZPU4ImtNtgwGrBFEPqBQBWrwWDnDrKr6WcCLN
         vrCMQ/l64iOK0xd4oRcEpslCuKYc1n+hsNWNDH6nZ+A/Fzs+0pZFTxys74TiFipW+OVH
         m/QxBTmVv3Xyjzno+1kFfBKZpaMRM4JuFPc57NUKCTenicK1UicILXA2atAUSJ7QipCb
         Mcy5NqRTi62zY7fF2HFDoxijUx1YDcGWXzRlHYcO52zAOKhGKxhZHySUyRxMu8F90EsH
         BOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741426509; x=1742031309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQi4M3B4m1yhI+j/DR3tG0ChOrFssIfqquYPn+5ff0s=;
        b=eArT8AnxP6rAq8VhvM8BIQeX1wwRoGv8i5QrBkaMckf53VUjxz2HuX6JS61KK9Adkv
         /bBc8O4TQGHiMx8WXiywLn99Tee5mXpH2OQiiT6DQAxG3ladCVMlCSH1yHqHnE8a8eeU
         Y7VewslrBN3IYR66arf0ucMrlFCbiMHpRuhVnt9BkYWl6ZQhIb9ob7Y9DDYLD9SmBuqz
         aVvcy0vZR/KjDCeM/8getiTdM+9RsS2diV0J/Wjr6g/TP0l483b61Sz5XnRRi4r0/byt
         8di2Muci4IO7oc09VO6G7nSbinSLUvz4Igl+YY0aGMgZedypjRN3UV8c6MbreNb7iPuY
         5APQ==
X-Gm-Message-State: AOJu0Yz6h/3XjaYdqFpjVv76ap+9mh5SOVFmxHvuPbIH+1TfZ/qe2xVB
	nDJv1/nxCzLl3q4N0qcWtNAxgfAHIdNnAOOawxSwtPuXlR48BlnzrMJcYw==
X-Gm-Gg: ASbGncvkECReW33b+OI7InF/4wY/oHQMZ8nhC+ZwX7IX+8ZnpQx03TKY46Ex4SFpRXd
	c7w3wDhJA3TRrWJvXlAB0ZFXOSqJgP92c51Wltm1Xw0uvAVNlaY2XoeUHGgh9aUAc/29mmR1T4f
	lrc3GKG4sEoZKpyFmTVSCkQceCuQuFmXdAUK0PzQvEl2y86Y3CFsH3mD0+8zefd/TJw+sovhbfa
	Vv8n8+h7/VGTTSs17nE383yLIKhMICeR+GuJYaykvwUdmzWviiTvICVGcpbTs5oviRT9a6miekY
	lKGxkQB+WhyzJ5/8OCnFluL9h/y+DYqnaGO0XJjZ/byKMdGW5ML+/8hbaUSvNGzms+SWeE33X51
	vqDf5N4vk/RX/WtuhyWTLJChsyOpeI4Nhr0c1
X-Google-Smtp-Source: AGHT+IFHGVRSeJ2svL22e7XoXGyZ3gvwPQU5r65V24nnpaGQi/ag5JS5qDaLkrXRMkcLvk4Wk40URA==
X-Received: by 2002:a5d:64ac:0:b0:38d:dfb8:3679 with SMTP id ffacd0b85a97d-39132d228c5mr5644939f8f.17.1741426508543;
        Sat, 08 Mar 2025 01:35:08 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce3f573f6sm15663895e9.0.2025.03.08.01.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 01:35:08 -0800 (PST)
From: David Laight <david.laight.linux@gmail.com>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	nnac123@linux.ibm.com,
	horms@kernel.org
Subject: [PATCH next 0/8] test_hexdump: Improve test coverage
Date: Sat,  8 Mar 2025 09:34:44 +0000
Message-Id: <20250308093452.3742-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was suggested that I add some addition tests for hex_dump_to_buffer().
This required reworking the test code so that could verify arbitrary data.

16 of the tests (those with zero len and bufsize) fail on the current
kernel (the return value should be zero but is ascii ? 3 * rowsize : -1)

There are now 2000 tests that include more buffer overflow conditions and
all 256 bytes values.

David Laight (8):
  Change rowsize and groupsize to size_t
  Create test output data from the binary input data buffer
  Use longer variable names
  Check for buffer overrun of sample output buffer
  Fix sample output if zero bytes requested
  If a test fails print all the parameters
  Run fixed not random tests
  Test all 256 byte values

 lib/test_hexdump.c | 256 ++++++++++++++++++++-------------------------
 1 file changed, 113 insertions(+), 143 deletions(-)

-- 
2.39.5


